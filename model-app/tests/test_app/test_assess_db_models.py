from sqlmodel import Session, select

from vibe_modeling.backend.db_models import (
    ASSESS_TABLES, AssessBatch, AssessColumnMapping, AssessConfig, AssessDecisionOption,
    AssessDomainRun, AssessDomainSource, AssessEntity, AssessPendingDecision, AssessSourceMap,
    Business, Domain, ModelVersion,
)


def _seed(session):
    b = Business(name="Meridian", description="d")
    session.add(b); session.commit(); session.refresh(b)
    mv = ModelVersion(business_id=b.id, version=3, scope="mvm", status="completed",
                      deployment_status="deployed", uc_catalog="manufacturing_mvm_v1")
    session.add(mv); session.commit(); session.refresh(mv)
    d = Domain(version_id=mv.id, name="sales_order", database_name="sales_order")
    session.add(d); session.commit(); session.refresh(d)
    return b, mv, d


def test_assess_tables_registered():
    names = {t.__tablename__ for t in ASSESS_TABLES}
    assert names == {
        "assess_config", "assess_source_map", "assess_batch", "assess_domain_run",
        "assess_domain_source", "assess_entity", "assess_column_mapping", "assess_gap",
        "assess_pending_decision", "assess_decision_option", "assess_next_vibe", "assess_handoff",
        # results readability
        "assess_summary", "assess_summary_item", "assess_decision_option_point",
        "assess_decision_affected", "assess_next_vibe_entity",
        # per-source column profiles
        "assess_column_source_profile",
    }


def test_batch_domain_run_entity_chain(engine):
    with Session(engine) as s:
        b, mv, d = _seed(s)
        batch = AssessBatch(business_id=b.id, version_id=mv.id, created_by="u@x.com")
        s.add(batch); s.commit(); s.refresh(batch)
        dr = AssessDomainRun(batch_id=batch.id, domain_id=d.id)
        s.add(dr); s.commit(); s.refresh(dr)
        assert dr.status == "queued" and dr.attempt == 0 and dr.results_valid is None
        s.add(AssessDomainSource(domain_run_id=dr.id, source_name="src_sap_sd",
                                 catalog_name="bronze", schema_name="sap_sd"))
        e = AssessEntity(domain_run_id=dr.id, name="order", grade="partial")
        s.add(e); s.commit(); s.refresh(e)
        s.add(AssessColumnMapping(entity_id=e.id, target="number", status="mapped",
                                  source_table="vbak", source_column="vbeln"))
        dec = AssessPendingDecision(domain_run_id=dr.id, gate="2C", question="Add credit_check?",
                                    default_taken="defer")
        s.add(dec); s.commit(); s.refresh(dec)
        s.add(AssessDecisionOption(decision_id=dec.id, ordinal=0, label="add"))
        s.commit()
        assert s.exec(select(AssessColumnMapping)).one().dup_source is False
        assert dec.answer_status == "open"


def test_source_map_unique_per_business(engine):
    import pytest
    from sqlalchemy.exc import IntegrityError
    with Session(engine) as s:
        b, _, _ = _seed(s)
        s.add(AssessSourceMap(business_id=b.id, source_name="src_a", catalog_name="c", schema_name="s"))
        s.commit()
        s.add(AssessSourceMap(business_id=b.id, source_name="src_a", catalog_name="c2", schema_name="s2"))
        with pytest.raises(IntegrityError):
            s.commit()


def test_config_defaults(engine):
    with Session(engine) as s:
        c = AssessConfig()
        s.add(c); s.commit(); s.refresh(c)
        assert c.max_concurrent_runs == 2
        assert c.default_reasoning_effort == "high"
        assert c.job_id is None and c.synced_version == "" and c.job_reader == ""
        assert c.reader_display_name == ""
        assert not hasattr(c, "genie_version") and not hasattr(c, "skills_ref")
        assert not hasattr(c, "probe_job_id")
