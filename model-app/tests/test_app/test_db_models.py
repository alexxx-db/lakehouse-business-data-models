"""Test Lakebase database models — schema structure and load-bearing defaults.

Trimmed: tautological default-value / __tablename__ / FK-declaration tests
removed (Pydantic + SQLModel guarantee these). What remains targets:

- The schema-creation surface (all expected tables, all FK constraints) — would
  catch a missed migration / accidental table rename.
- BIGINT widening for `vibe_session_id_bigint` — real bug class (overflow).
- `intent` and `last_consumed_step_id` defaults — directly read by the
  orchestrator wiring.
"""

import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "src", "app", "src"))

from sqlmodel import select
from vibe_modeling.backend import db_models as db
from vibe_modeling.backend.db_models import Run, AssessColumnSourceProfile


class TestRunDefaults:
    def test_intent_default(self):
        r = Run(business_id="fake-id")
        assert r.intent == ""

    def test_last_consumed_step_id_default(self):
        r = Run(business_id="fake-id")
        assert r.last_consumed_step_id == 0

    def test_vibe_session_id_bigint_widening(self):
        # vibe_session_id_bigint must accept values that overflow INT4.
        big = 2**40  # well above 2_147_483_647
        r = Run(business_id="fake-id", vibe_session_id="sid", vibe_session_id_bigint=big)
        assert r.vibe_session_id_bigint == big


class TestDatabaseSchema:
    def test_all_tables_created(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        tables = insp.get_table_names()
        expected = [
            "businesses", "business_contexts", "agent_config",
            "model_versions", "runs", "run_artifacts", "run_progress_events",
            "domains", "products", "attributes", "foreign_key_links",
            # Vibe Inputs redesign (Task 2)
            "vibe_inputs", "vibe_input_context_links", "run_input_links",
            "subdomains", "product_reviews",
            # Vibe Inputs redesign (Task 4) — element rename/merge/delete lineage
            "run_element_lineage",
            # Headless assessment (migration 0.8.0)
            "assess_config", "assess_source_map", "assess_batch", "assess_domain_run",
            "assess_domain_source", "assess_entity", "assess_column_mapping", "assess_gap",
            "assess_pending_decision", "assess_decision_option", "assess_next_vibe",
            "assess_handoff",
            # Assessment results readability
            "assess_summary", "assess_summary_item", "assess_decision_option_point",
            "assess_decision_affected", "assess_next_vibe_entity",
        ]
        for table in expected:
            assert table in tables, f"Table '{table}' not created"

    def test_foreign_key_constraints(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        assert "businesses" in {fk["referred_table"] for fk in insp.get_foreign_keys("business_contexts")}
        assert "businesses" in {fk["referred_table"] for fk in insp.get_foreign_keys("runs")}
        assert "runs" in {fk["referred_table"] for fk in insp.get_foreign_keys("run_artifacts")}
        assert "runs" in {fk["referred_table"] for fk in insp.get_foreign_keys("run_progress_events")}
        assert "model_versions" in {fk["referred_table"] for fk in insp.get_foreign_keys("domains")}
        assert "domains" in {fk["referred_table"] for fk in insp.get_foreign_keys("products")}
        assert "products" in {fk["referred_table"] for fk in insp.get_foreign_keys("attributes")}
        assert "model_versions" in {fk["referred_table"] for fk in insp.get_foreign_keys("foreign_key_links")}

    def test_vibe_input_foreign_keys(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        assert "businesses" in {fk["referred_table"] for fk in insp.get_foreign_keys("vibe_inputs")}

        ctx_referred = {fk["referred_table"] for fk in insp.get_foreign_keys("vibe_input_context_links")}
        for t in ("vibe_inputs", "model_versions", "domains", "subdomains",
                  "products", "attributes", "foreign_key_links"):
            assert t in ctx_referred, f"vibe_input_context_links missing FK→{t}"

        link_referred = {fk["referred_table"] for fk in insp.get_foreign_keys("run_input_links")}
        assert "runs" in link_referred
        assert "vibe_inputs" in link_referred

        sub_referred = {fk["referred_table"] for fk in insp.get_foreign_keys("subdomains")}
        assert "model_versions" in sub_referred
        assert "domains" in sub_referred

        rev_referred = {fk["referred_table"] for fk in insp.get_foreign_keys("product_reviews")}
        assert "model_versions" in rev_referred
        assert "products" in rev_referred

        assert "subdomains" in {fk["referred_table"] for fk in insp.get_foreign_keys("products")}

    def test_self_fk_previous_element_id(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        for table in ("domains", "products", "attributes", "foreign_key_links", "subdomains"):
            referred = {fk["referred_table"] for fk in insp.get_foreign_keys(table)}
            assert table in referred, (
                f"{table}.previous_element_id self-FK→{table} missing"
            )


class TestRunElementLineageSchema:
    """Task 4 — the rename/merge/delete edge table."""

    def test_foreign_keys(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        referred = {fk["referred_table"] for fk in insp.get_foreign_keys("run_element_lineage")}
        assert "runs" in referred
        assert "model_versions" in referred

    def test_defaults(self):
        row = db.RunElementLineage(
            run_id="run-1",
            version_id="ver-1",
            element_type="product",
            change_kind="delete",
            old_element_id="old-1",
            old_fqn="legacy.thing",
        )
        assert row.new_element_id is None
        assert row.new_fqn == ""
        assert row.reason == ""

    def test_nullable_element_ids(self):
        cols = db.RunElementLineage.__table__.c
        assert cols.old_element_id.nullable is True
        assert cols.new_element_id.nullable is True


class TestVibeInputDefaults:
    def test_defaults(self):
        v = db.VibeInput(business_id="biz-1")
        assert v.origin == "user"
        assert v.author == ""
        assert v.priority == "medium"
        assert v.consumed is False
        assert v.selected_for_run is False
        assert v.status == "active"
        assert v.deprecated_by is None
        assert v.confidence_score is None
        assert v.category is None


class TestVibeInputNullability:
    """N2: lock the nullability flag on every column this task adds, so a
    future accidental NOT NULL (or dropped NULL) is caught at the schema layer."""

    def test_vibe_input_nullable_columns(self):
        cols = db.VibeInput.__table__.c
        assert cols.deprecated_by.nullable is True
        assert cols.confidence_score.nullable is True
        # category is nullable — null for origin=user inputs (v_0_6_3).
        assert cols.category.nullable is True
        # author is NOT NULL with an empty-string default.
        assert cols.author.nullable is False
        assert db.VibeInput(business_id="biz-1").author == ""
        # selected_for_run is NOT NULL with a False default (run-selection flag).
        assert cols.selected_for_run.nullable is False
        assert db.VibeInput(business_id="biz-1").selected_for_run is False

    def test_previous_element_id_nullable(self):
        for model in (db.Domain, db.Product, db.Attribute, db.ForeignKeyLink, db.Subdomain):
            assert model.__table__.c.previous_element_id.nullable is True, (
                f"{model.__name__}.previous_element_id must be nullable"
            )

    def test_product_subdomain_id_nullable(self):
        assert db.Product.__table__.c.subdomain_id.nullable is True


class TestRunInputLinkCompositePK:
    def test_composite_pk(self):
        pk_cols = {c.name for c in db.RunInputLink.__table__.primary_key.columns}
        assert pk_cols == {"run_id", "input_id"}


class TestVibeInputContextLinkModelWide:
    """Edge case 1: an all-element-null context link (model-wide anchor) is a
    valid, persistable row."""

    def test_all_null_element_fks_persist_and_read_back(self, engine):
        from sqlmodel import Session, select

        with Session(engine) as session:
            biz = db.Business(name="ctx-biz")
            session.add(biz)
            session.commit()
            session.refresh(biz)

            mv = db.ModelVersion(business_id=biz.id)
            session.add(mv)
            session.commit()
            session.refresh(mv)

            vi = db.VibeInput(business_id=biz.id)
            session.add(vi)
            session.commit()
            session.refresh(vi)

            link = db.VibeInputContextLink(input_id=vi.id, version_id=mv.id)
            session.add(link)
            session.commit()

            got = session.exec(
                select(db.VibeInputContextLink).where(
                    db.VibeInputContextLink.input_id == vi.id
                )
            ).one()
            assert got.domain_id is None
            assert got.subdomain_id is None
            assert got.product_id is None
            assert got.attribute_id is None
            assert got.fk_link_id is None
            assert got.is_origin is False
            assert got.needs_link_review is False


class TestModelVersionProvenanceColumns:
    """v_0_7_0: nullable agent_version / release_version persist + read back,
    default NULL for pre-existing rows."""

    def test_defaults_null(self):
        mv = db.ModelVersion(business_id="fake-id")
        assert mv.agent_version is None
        assert mv.release_version is None

    def test_persist_and_read_back(self, engine):
        from sqlmodel import Session, select

        with Session(engine) as session:
            biz = db.Business(name="prov-biz")
            session.add(biz)
            session.flush()
            mv = db.ModelVersion(
                business_id=biz.id,
                version=1,
                agent_version="4.9.8",
                release_version="0.8.0",
            )
            session.add(mv)
            session.commit()
            mv_id = mv.id

        with Session(engine) as session:
            got = session.exec(
                select(db.ModelVersion).where(db.ModelVersion.id == mv_id)
            ).one()
            assert got.agent_version == "4.9.8"
            assert got.release_version == "0.8.0"

    def test_columns_present_on_table(self):
        cols = {c.name for c in db.ModelVersion.__table__.columns}
        assert {"agent_version", "release_version"} <= cols


class TestAssessReadabilitySchema:
    """Assessment results readability: summary / tiers / decision detail / next-vibe urgency."""

    def test_new_columns_present(self):
        cols = lambda m: set(m.__table__.columns.keys())  # noqa: E731
        assert {"core_sourced", "core_total", "enrichment_sourced", "enrichment_total",
                "deferred_fk_count", "grade_reason", "row_filter", "reported_letter"} <= cols(db.AssessEntity)
        assert "tier" in cols(db.AssessColumnMapping)
        assert {"context", "why_it_matters", "recommendation_rationale", "blocks_build",
                "recommended_option_id"} <= cols(db.AssessPendingDecision)
        assert "impact" in cols(db.AssessDecisionOption)
        assert {"problem", "proposed_change", "impact_if_skipped", "urgency"} <= cols(db.AssessNextVibe)

    def test_structure_axis_columns_present(self):
        assert "reported_structure" in db.AssessEntity.__table__.columns.keys()
        assert "kind" in db.AssessPendingDecision.__table__.columns.keys()

    def test_new_tables_registered(self):
        for m in (db.AssessSummary, db.AssessSummaryItem, db.AssessDecisionOptionPoint,
                  db.AssessDecisionAffected, db.AssessNextVibeEntity, db.AssessColumnSourceProfile):
            assert m in db.ASSESS_TABLES

    def test_new_table_foreign_keys(self, engine):
        from sqlalchemy import inspect as sa_inspect
        insp = sa_inspect(engine)
        def fks(t):
            return {(fk["referred_table"], fk["options"].get("ondelete")) for fk in insp.get_foreign_keys(t)}
        assert ("assess_domain_run", "CASCADE") in fks("assess_summary")
        assert ("assess_summary", "CASCADE") in fks("assess_summary_item")
        assert ("assess_decision_option", "CASCADE") in fks("assess_decision_option_point")
        assert ("assess_pending_decision", "CASCADE") in fks("assess_decision_affected")
        assert ("assess_next_vibe", "CASCADE") in fks("assess_next_vibe_entity")
        assert ("assess_column_mapping", "CASCADE") in fks("assess_column_source_profile")

    def test_round_trip(self, engine):
        from sqlmodel import Session
        with Session(engine) as session:
            self._round_trip(session)

    def _round_trip(self, session):
        biz = db.Business(name="b")
        session.add(biz); session.commit()
        mv = db.ModelVersion(business_id=biz.id, version=1)
        session.add(mv); session.commit()
        dom = db.Domain(version_id=mv.id, name="d")
        batch = db.AssessBatch(business_id=biz.id, version_id=mv.id)
        session.add(dom); session.add(batch); session.commit()
        run = db.AssessDomainRun(batch_id=batch.id, domain_id=dom.id)
        session.add(run); session.commit()

        session.add(db.AssessSummary(domain_run_id=run.id, headline="h", verdict="ready",
                                     verdict_reason="r", recommended_next_step="n"))
        session.commit()
        session.add(db.AssessSummaryItem(summary_id=run.id, kind="finding", ordinal=0, text="t"))
        ent = db.AssessEntity(domain_run_id=run.id, name="e", grade="partial", core_sourced=3,
                              core_total=4, enrichment_sourced=1, enrichment_total=5,
                              deferred_fk_count=2, grade_reason="why", row_filter="x=1",
                              reported_letter="B")
        session.add(ent); session.commit()
        col = db.AssessColumnMapping(entity_id=ent.id, target="c", status="mapped", tier="core")
        session.add(col); session.commit()
        session.add(db.AssessColumnSourceProfile(column_id=col.id, ordinal=0, system="src1",
                                                 source_table="t1", source_column="c1", role="populates",
                                                 row_count=100, null_pct=2.5, note="test"))
        dec = db.AssessPendingDecision(domain_run_id=run.id, question="q", context="c",
                                       why_it_matters="w", recommendation_rationale="rr",
                                       blocks_build=True)
        session.add(dec); session.commit()
        opt = db.AssessDecisionOption(decision_id=dec.id, label="l", impact="i")
        session.add(opt); session.commit()
        dec.recommended_option_id = opt.id
        session.add(dec)
        session.add(db.AssessDecisionOptionPoint(option_id=opt.id, kind="pro", ordinal=0, text="p"))
        session.add(db.AssessDecisionAffected(decision_id=dec.id, entity="e", column="c"))
        nv = db.AssessNextVibe(domain_run_id=run.id, text="t", problem="p", proposed_change="pc",
                               impact_if_skipped="ii", urgency="high")
        session.add(nv); session.commit()
        session.add(db.AssessNextVibeEntity(next_vibe_id=nv.id, entity="e"))
        session.commit()

        session.refresh(ent); session.refresh(dec)
        assert (ent.core_sourced, ent.reported_letter, ent.row_filter) == (3, "B", "x=1")
        assert dec.recommended_option_id == opt.id and dec.blocks_build is True
        assert nv.urgency == "high"
        profile = session.exec(select(AssessColumnSourceProfile)).first()
        assert profile.system == "src1" and profile.row_count == 100 and profile.null_pct == 2.5
