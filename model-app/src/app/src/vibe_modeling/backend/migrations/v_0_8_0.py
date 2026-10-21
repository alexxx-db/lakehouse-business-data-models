"""Migration 0.8.0 — Domain Taxonomy Builder columns + the headless-assessment tables.

The single migration of the 0.8.0 release, upgrading a 0.7.3 schema in one
step. Additive only. Two steps, in this order, in one transaction:

1. **Domain Taxonomy Builder columns** on existing tables, all defaulted so
   pre-existing rows read as "not configured" / "no proposal":

   * ``agent_config.taxonomy_model_service`` — the Unity Catalog model service
     (``catalog.schema.service``) the wizard drafts with; '' = not configured.
   * ``agent_config.taxonomy_llm_max_concurrency`` — app-wide cap on live LLM
     calls (1-16, default 6).
   * ``businesses.business_domains`` — the wizard's proposed domain schema
     names, ``"a, b, c"`` (the agent's ``business_domains`` widget value
     verbatim).
   * ``businesses.org_divisions`` — the proposed coverage preset, or ''.

   Postgres uses ``ADD COLUMN IF NOT EXISTS``; SQLite (tests) PRAGMA-checks
   first since its ``ADD COLUMN`` lacks ``IF NOT EXISTS``. Each table is
   guarded on existence so minimal migration-test fixtures are a no-op. The
   DDL is written as string LITERALS (not f-strings) so the owner-script drift
   gate (``tests/test_app/test_migration_drift_owner.py``) can regex the
   ``(table, column, type)`` triples straight out of this module and prove
   ``scripts/db/migrate.py`` mirrors them.

2. **Headless-assessment tables**: the eighteen tables in
   ``db_models.ASSESS_TABLES`` (config, source map, batch, domain run + its
   source snapshot, results: entity, column mapping + per-source profiles,
   gap, pending decision + options, option points, affected entities, next
   vibe + its entities, summary + items, hand-off), built from the final
   models. ``metadata.create_all(tables=..., checkfirst=True)`` makes it
   idempotent on both dialects. The two decision-option FKs on
   ``assess_pending_decision`` (``answer_option_id``,
   ``recommended_option_id``) are ``use_alter`` because the two tables
   reference each other; on Postgres ``create_all`` emits them as
   ``ALTER TABLE ... ADD CONSTRAINT`` after both tables exist.
   ``assess_next_vibe.vibe_input_id`` references ``vibe_inputs`` (ON DELETE
   SET NULL), which earlier migrations create. The owner script needs no
   mirror entry for these (the drift gate only compares ``ALTER TABLE ... ADD
   COLUMN`` triples).
"""

from __future__ import annotations

from sqlalchemy import inspect, text
from sqlalchemy.engine import Connection, Engine
from sqlmodel import SQLModel

from .registry import Migration

_ADD_TAXONOMY_MODEL_SERVICE_PG = (
    "ALTER TABLE agent_config ADD COLUMN IF NOT EXISTS taxonomy_model_service VARCHAR DEFAULT ''"
)
_ADD_TAXONOMY_MODEL_SERVICE_SQLITE = (
    "ALTER TABLE agent_config ADD COLUMN taxonomy_model_service VARCHAR DEFAULT ''"
)
_ADD_TAXONOMY_LLM_MAX_CONCURRENCY_PG = (
    "ALTER TABLE agent_config ADD COLUMN IF NOT EXISTS "
    "taxonomy_llm_max_concurrency INTEGER NOT NULL DEFAULT 6"
)
_ADD_TAXONOMY_LLM_MAX_CONCURRENCY_SQLITE = (
    "ALTER TABLE agent_config ADD COLUMN taxonomy_llm_max_concurrency INTEGER NOT NULL DEFAULT 6"
)
_ADD_BUSINESS_DOMAINS_PG = (
    "ALTER TABLE businesses ADD COLUMN IF NOT EXISTS business_domains VARCHAR DEFAULT ''"
)
_ADD_BUSINESS_DOMAINS_SQLITE = (
    "ALTER TABLE businesses ADD COLUMN business_domains VARCHAR DEFAULT ''"
)
_ADD_ORG_DIVISIONS_PG = (
    "ALTER TABLE businesses ADD COLUMN IF NOT EXISTS org_divisions VARCHAR DEFAULT ''"
)
_ADD_ORG_DIVISIONS_SQLITE = (
    "ALTER TABLE businesses ADD COLUMN org_divisions VARCHAR DEFAULT ''"
)

# (table, column) -> (postgres DDL, sqlite DDL). Single source of truth for the
# apply loop and the migration test.
NEW_COLUMNS: dict[tuple[str, str], tuple[str, str]] = {
    ("agent_config", "taxonomy_model_service"): (
        _ADD_TAXONOMY_MODEL_SERVICE_PG, _ADD_TAXONOMY_MODEL_SERVICE_SQLITE,
    ),
    ("agent_config", "taxonomy_llm_max_concurrency"): (
        _ADD_TAXONOMY_LLM_MAX_CONCURRENCY_PG, _ADD_TAXONOMY_LLM_MAX_CONCURRENCY_SQLITE,
    ),
    ("businesses", "business_domains"): (_ADD_BUSINESS_DOMAINS_PG, _ADD_BUSINESS_DOMAINS_SQLITE),
    ("businesses", "org_divisions"): (_ADD_ORG_DIVISIONS_PG, _ADD_ORG_DIVISIONS_SQLITE),
}


def _add_column(conn: Connection, table: str, column: str, is_postgres: bool) -> None:
    pg_ddl, sqlite_ddl = NEW_COLUMNS[(table, column)]
    if is_postgres:
        conn.execute(text(pg_ddl))
        return
    # SQLite (tests): ADD COLUMN lacks IF NOT EXISTS, so check first.
    present = {row[1] for row in conn.execute(text(f"PRAGMA table_info({table})")).fetchall()}
    if column not in present:
        conn.execute(text(sqlite_ddl))


def _add_taxonomy_columns(conn: Connection, is_postgres: bool) -> None:
    insp = inspect(conn)
    present_tables = {t for (t, _c) in NEW_COLUMNS if insp.has_table(t)}
    for table, column in NEW_COLUMNS:
        if table in present_tables:
            _add_column(conn, table, column, is_postgres)


def _create_assess_tables(conn: Connection) -> None:
    from ..db_models import ASSESS_TABLES

    SQLModel.metadata.create_all(
        conn, tables=[t.__table__ for t in ASSESS_TABLES], checkfirst=True
    )


def apply(engine: Engine) -> None:
    """Add the taxonomy columns, then create the ``assess_*`` tables.
    Idempotent; one transaction, both dialects."""
    is_postgres = engine.dialect.name == "postgresql"
    with engine.begin() as conn:
        _add_taxonomy_columns(conn, is_postgres)
        _create_assess_tables(conn)


MIGRATION = Migration(
    version="0.8.0",
    apply=apply,
    description=(
        "Add defaulted agent_config.taxonomy_model_service + taxonomy_llm_max_concurrency "
        "and businesses.business_domains + org_divisions (Domain Taxonomy Builder), then "
        "create the 18 headless-assessment assess_* tables (config, source map, batch, "
        "domain run, results, next vibes, hand-off)."
    ),
)
