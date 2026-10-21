"""Shared builders for headless-assessment tests (readiness, launch, status, write surface)."""
from __future__ import annotations

import hashlib
import uuid
from types import SimpleNamespace as NS

METAMODEL_SET = ("business", "product", "attribute", "domain")


def _tables(*names):
    return [NS(name=n) for n in names]


def _eff(*privs, inherited=None):
    return NS(privilege_assignments=[NS(principal="app-1", privileges=[
        NS(privilege=NS(value=p), inherited_from_name=inherited) for p in privs])])


def ws_ok(mock_ws, reader: str = "app-1"):
    """Make every readiness check come back ``ok`` on ``mock_ws``."""
    mock_ws.tables.list.return_value = _tables(*METAMODEL_SET)
    mock_ws.grants.get_effective.side_effect = lambda *a, **k: _eff("ALL_PRIVILEGES")
    mock_ws.service_principals.list.return_value = [NS(application_id=reader, display_name="r", groups=[])]
    mock_ws.warehouses.get_permissions.return_value = NS(access_control_list=[
        NS(service_principal_name=reader, group_name=None, user_name=None,
           all_permissions=[NS(permission_level=NS(value="CAN_USE"))])])
    return mock_ws


def ready_config(reader: str = "app-1", job_id: int = 99, **overrides):
    """An ``AssessConfig`` that passes ``assess_ready``: synced for this app version, running as ``reader``."""
    from vibe_modeling import __version__ as app_version
    from vibe_modeling.backend.db_models import AssessConfig
    base = dict(reader_application_id=reader, job_id=job_id, warehouse_id="wh", synced_version=app_version,
                job_reader=reader, workspace_path=f"/Users/app-sp/vibe-assess/{app_version}")
    base.update(overrides)
    return AssessConfig(**base)


def run(lc, rs=None, msg=""):
    """Fake Jobs API ``get_run`` result."""
    return NS(state=NS(life_cycle_state=NS(value=lc), result_state=NS(value=rs) if rs else None, state_message=msg))


def seed_domain_run(engine, databricks_run_id=1, status="queued", out_dir="/Volumes/c/_metamodel/assess_runs/b/d",
                    created_at=None, batch_id=None, domain_id=None) -> str:
    """Insert one AssessDomainRun (creating business/version/domain/batch as needed); return its id."""
    from sqlmodel import Session

    from vibe_modeling.backend.db_models import AssessBatch, AssessDomainRun, Business, Domain, ModelVersion
    with Session(engine) as s:
        if batch_id is None:
            b = Business(name=f"B-{uuid.uuid4().hex[:8]}", description="d")
            s.add(b); s.commit(); s.refresh(b)
            mv = ModelVersion(business_id=b.id, version=1, scope="mvm", status="completed")
            s.add(mv); s.commit(); s.refresh(mv)
            d = Domain(version_id=mv.id, name="d", database_name="d")
            batch = AssessBatch(business_id=b.id, version_id=mv.id)
            s.add(d); s.add(batch); s.commit(); s.refresh(d); s.refresh(batch)
            batch_id, domain_id = batch.id, d.id
        dr = AssessDomainRun(batch_id=batch_id, domain_id=domain_id, databricks_run_id=databricks_run_id,
                             status=status, out_dir=out_dir)
        if created_at is not None:
            dr.created_at = created_at
        s.add(dr); s.commit(); s.refresh(dr)
        return dr.id


# Tables the next-vibe -> feedback conversion may write besides ``assess_*`` (core/_vibe_input_create.py).
FEEDBACK_TABLES = frozenset({"vibe_inputs", "vibe_input_context_links"})


def table_digests(engine) -> dict[str, str]:
    """sha256 of each table's rows (order-independent), by table name, for write-surface checks.

    Works on SQLite and Postgres: the tables are the engine's default schema's (on Postgres,
    the first schema on the connection's search_path).
    """
    from sqlalchemy import inspect, text

    out: dict[str, str] = {}
    with engine.connect() as conn:
        for table in sorted(inspect(conn).get_table_names()):
            rows = sorted(repr(tuple(r)) for r in conn.execute(text(f'SELECT * FROM "{table}"')))
            out[table] = hashlib.sha256("\n".join(rows).encode()).hexdigest()
    return out


def changed_tables(before: dict[str, str], after: dict[str, str]) -> set[str]:
    return {t for t in before.keys() | after.keys() if before.get(t) != after.get(t)}
