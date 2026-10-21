import json
import os
import sys
from datetime import datetime, timezone, timedelta
from types import SimpleNamespace as NS

import pytest
from sqlmodel import Session, select

from vibe_modeling.backend.assessment.assets import read_versions
from vibe_modeling.backend.assessment.constants import domain_segment
from vibe_modeling.backend.assessment.launch import build_domain_config, prior_tiers_for
from vibe_modeling.backend.db_models import (
    AssessBatch, AssessConfig, AssessDomainRun, AssessDomainSource, Business, Domain, ModelVersion,
    AssessEntity, AssessColumnMapping,
)

sys.path.insert(0, os.path.dirname(__file__))

from _assess_helpers import _eff, ready_config, ws_ok


@pytest.fixture
def seeded(engine):
    with Session(engine) as s:
        b = Business(name="Meridian Mfg", description="d")
        s.add(b); s.commit(); s.refresh(b)
        mv = ModelVersion(business_id=b.id, version=3, scope="mvm", status="completed",
                          deployment_status="deployed", uc_catalog="mvm_cat")
        s.add(mv); s.commit(); s.refresh(mv)
        d1 = Domain(version_id=mv.id, name="sales_order", database_name="sales_order")
        d2 = Domain(version_id=mv.id, name="Customer Master", database_name="customer_master")
        s.add(d1); s.add(d2)
        s.add(ready_config())
        s.commit(); s.refresh(d1); s.refresh(d2)
        return NS(bid=b.id, vid=mv.id, d1=d1.id, d2=d2.id)


def _src(name="src_sap_sd", cat="bronze", sch="sap_sd"):
    return {"source_name": name, "catalog_name": cat, "schema_name": sch}


def test_launch_two_domains_writes_configs_and_runs(client, mock_ws, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = [NS(run_id=1000), NS(run_id=1001)]
    body = {"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]},
        {"domain_id": seeded.d2, "sources": [_src("src_crm", "bronze", "crm")]}]}
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json=body)
    assert r.status_code == 201, r.text
    out = r.json()
    assert [d["status"] for d in out["domain_runs"]] == ["queued", "queued"]
    assert {d["databricks_run_id"] for d in out["domain_runs"]} == {1000, 1001}
    paths = [c.args[0] for c in mock_ws.files.upload.call_args_list]
    assert paths[1].endswith(f"/assess_runs/{out['id']}/Customer_Master/config.json")
    assert ".." not in "".join(paths)
    cfg = json.loads(mock_ws.files.upload.call_args_list[0].args[1].getvalue())
    assert cfg["model_version"] == 3 and cfg["metamodel_schema"] == "_metamodel"
    assert cfg["bronze_sources"] == {"src_sap_sd": "bronze.sap_sd"} and cfg["warehouse_id"] == "wh"
    versions = read_versions()
    assert cfg["skills"] == versions["staged_skills"]
    assert not {"skills_repo", "skills_ref", "skills_subdir"} & set(cfg)  # skills are bundle-only at run time
    assert cfg["genie"] == versions["genie"] and cfg["databricks_cli"] == versions["databricks_cli"]
    assert cfg["genie_model"] == versions["genie_model"] and "genie_version" not in cfg
    assert cfg["customer"] == "Meridian Mfg"
    assert cfg["silver_catalog"] == "mvm_cat" and cfg["gold_catalog"] == "mvm_cat"
    assert cfg["out_dir"].endswith(f"/{out['id']}/sales_order")
    assert mock_ws.jobs.run_now.call_args_list[0].kwargs == {"job_id": 99, "job_parameters": {"config_path": paths[0]}}
    assert out["version"] == 3 and out["status"] == "running"
    assert out["domain_runs"][0]["run_url"].endswith("/jobs/99/runs/1000")
    assert out["domain_runs"][0]["sources"] == [_src()]


def test_launch_blocked_returns_409_and_no_side_effects(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    mock_ws.grants.get_effective.side_effect = lambda t, n, principal=None: _eff() if n.startswith("bronze") else _eff("ALL_PRIVILEGES")
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src("s", "bronze", "x")]}]})
    assert r.status_code == 409
    assert r.json()["detail"]["readiness"]["domains"][0]["blocked"] is True
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()
    with Session(engine) as s:
        assert s.exec(select(AssessBatch)).all() == []


def test_launch_without_job_is_409(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    with Session(engine) as s:
        cfg = s.exec(select(AssessConfig)).one()
        cfg.job_id = None; s.add(cfg); s.commit()
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]})
    assert r.status_code == 409
    assert r.json()["detail"]["not_ready"] == ["The assessment job has not been created yet"]
    assert r.json()["detail"]["error"] == "admin_help"
    assert "job_url" not in r.json()["detail"]  # no job, no link
    mock_ws.jobs.run_now.assert_not_called(); mock_ws.grants.get_effective.assert_not_called()


@pytest.mark.parametrize("overrides,missing", [
    ({"job_setup_error": "PermissionDenied: x"}, "Job sync failed: PermissionDenied: x"),
    ({"synced_version": "0.0.1"}, "The assessment job has not been synced for app version"),
    ({"job_reader": "someone-else"}, "The assessment job does not run as the configured reader"),
])
def test_launch_not_ready_is_409_with_job_url_and_no_side_effects(client, mock_ws, engine, seeded, overrides, missing):
    ws_ok(mock_ws)
    with Session(engine) as s:
        cfg = s.exec(select(AssessConfig)).one()
        for k, v in overrides.items():
            setattr(cfg, k, v)
        s.add(cfg); s.commit()
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]})
    assert r.status_code == 409, r.text
    detail = r.json()["detail"]
    assert detail["message"].startswith("Assessment isn't set up yet: ") and missing in detail["message"]
    assert detail["job_url"] == "https://test-workspace.databricks.com/jobs/99"
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()
    with Session(engine) as s:
        assert s.exec(select(AssessBatch)).all() == []


def test_launch_pins_job_reader_and_notebook_folder_on_each_run(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.return_value = NS(run_id=5)
    client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]})
    with Session(engine) as s:
        cfg = s.exec(select(AssessConfig)).one()
        dr = s.exec(select(AssessDomainRun)).one()
    assert (dr.job_id, dr.job_reader, dr.notebook_folder) == (99, "app-1", cfg.workspace_path)
    assert cfg.workspace_path.startswith("/Users/app-sp/vibe-assess/")


def test_launch_duplicate_domain_is_422(client, mock_ws, seeded):
    src = [_src("s", "b", "x")]
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": src}, {"domain_id": seeded.d1, "sources": src}]})
    assert r.status_code == 422
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()


def test_launch_domain_not_in_version_is_422(client, mock_ws, seeded):
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": "not-a-domain", "sources": [_src("s", "b", "x")]}]})
    assert r.status_code == 422
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()


def test_launch_unknown_business_is_404(client, seeded):
    r = client.post("/api/businesses/nope/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]})
    assert r.status_code == 404


def test_launch_version_of_other_business_is_422(client, engine, seeded):
    with Session(engine) as s:
        b2 = Business(name="Other", description="d"); s.add(b2); s.commit(); s.refresh(b2)
        bid2 = b2.id
    r = client.post(f"/api/businesses/{bid2}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]})
    assert r.status_code == 422


@pytest.mark.parametrize("bad", [
    [], [{"source_name": "", "catalog_name": "b", "schema_name": "x"}],
    [{"source_name": "s", "catalog_name": "b.c", "schema_name": "x"}],
    [{"source_name": "s/../x", "catalog_name": "b", "schema_name": "x"}]])
def test_launch_malformed_sources_422(client, mock_ws, seeded, bad):
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid,
                    "domains": [{"domain_id": seeded.d1, "sources": bad}]})
    assert r.status_code == 422
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()


@pytest.mark.parametrize("field,value", [("reasoning_effort", "extreme"), ("output_model", "star"), ("etl_type", "spark")])
def test_launch_literal_options_validated(client, seeded, field, value):
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, field: value,
                    "domains": [{"domain_id": seeded.d1, "sources": [_src()]}]})
    assert r.status_code == 422


def test_launch_one_run_now_failure_marks_only_that_domain(client, mock_ws, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = [NS(run_id=1000), RuntimeError("quota")]
    body = {"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src("a", "b", "x")]},
        {"domain_id": seeded.d2, "sources": [_src("a", "b", "x")]}]}
    out = client.post(f"/api/businesses/{seeded.bid}/assessments", json=body).json()
    st = {d["domain_name"]: (d["status"], d["error_message"]) for d in out["domain_runs"]}
    assert st["sales_order"][0] == "queued"
    assert st["Customer Master"][0] == "failed" and "quota" in st["Customer Master"][1]
    assert out["status"] == "running"


def test_launch_all_fail_rolls_up_failed(client, mock_ws, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = RuntimeError("quota")
    out = client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}]}).json()
    assert out["status"] == "failed"
    assert out["domain_runs"][0]["run_url"] == ""


def test_launch_snapshots_sources_in_db(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.return_value = NS(run_id=7)
    client.post(f"/api/businesses/{seeded.bid}/assessments", json={"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src("a", "b", "x"), _src("c", "d", "y")]}]})
    with Session(engine) as s:
        assert len(s.exec(select(AssessDomainRun)).all()) == 1
        assert {(x.source_name, x.catalog_name) for x in s.exec(select(AssessDomainSource))} == {("a", "b"), ("c", "d")}


def test_domain_segment_is_safe():
    assert domain_segment("Customer Master") == "Customer_Master"
    for n in ("../etc", "a/b", "a.b", "..", "x\\..\\y"):
        assert ".." not in domain_segment(n) and "/" not in domain_segment(n)


def test_build_domain_config_key_set():
    from vibe_modeling.backend.assessment.metamodel import MetamodelLocation
    from vibe_modeling.backend.assessment.schemas import SourceIn
    cfg = build_domain_config(
        batch=NS(id="b1", output_model="hybrid", etl_type="sdp_pipeline", reasoning_effort="high"),
        business=NS(name="Ridgeline Energy"), version=NS(uc_catalog="c", version=2, scope="Expanded Coverage Model - ECM"), domain=NS(name="d", database_name=None),
        mm=MetamodelLocation("c", "_metamodel", ""), sources=[SourceIn(source_name="s", catalog_name="bc", schema_name="x")],
        cfg=NS(warehouse_id="w"),
        versions={"genie": {"tag": "g", "sha256": {}}, "databricks_cli": {"tag": "c", "sha256": {}},
                  "genie_model": "m", "skills_ref": "r", "skills_repo": "o/r", "skills_subdir": "s",
                  "staged_skills": ["a"]}, out_dir="/o")
    # Skills come from the bundle next to the notebook: config.json carries only which ones to stage.
    assert set(cfg) == {"batch_id", "domain", "customer", "metamodel_business", "vibe_catalog", "physical_schema", "metamodel_schema",
                        "metamodel_prefix", "model_version", "model_scope", "bronze_sources", "bronze_catalog", "silver_catalog",
                        "gold_catalog", "output_model", "etl_type", "reasoning_effort", "warehouse_id",
                        "genie", "databricks_cli", "genie_model", "skills", "max_resumes",
                        "backoff_base_seconds", "timeout_minutes", "out_dir"}
    assert cfg["physical_schema"] == "d" and cfg["skills"] == ["a"] and cfg["model_scope"] == "ecm"
    assert cfg["customer"] == "Ridgeline Energy" and cfg["metamodel_business"] == "ridgeline_energy"


def test_source_map_roundtrip(client, seeded):
    src = [_src()]
    assert client.put(f"/api/businesses/{seeded.bid}/assess-source-map", json={"sources": src}).status_code == 200
    assert client.get(f"/api/businesses/{seeded.bid}/assess-source-map").json()["sources"] == src
    other = [_src("z", "c2", "s2")]
    client.put(f"/api/businesses/{seeded.bid}/assess-source-map", json={"sources": other})
    assert client.get(f"/api/businesses/{seeded.bid}/assess-source-map").json()["sources"] == other
    client.put(f"/api/businesses/{seeded.bid}/assess-source-map", json={"sources": []})
    assert client.get(f"/api/businesses/{seeded.bid}/assess-source-map").json()["sources"] == []


def test_source_map_unknown_business_404_and_duplicate_names_422(client, seeded):
    assert client.get("/api/businesses/nope/assess-source-map").status_code == 404
    assert client.put("/api/businesses/nope/assess-source-map", json={"sources": []}).status_code == 404
    r = client.put(f"/api/businesses/{seeded.bid}/assess-source-map", json={"sources": [_src(), _src()]})
    assert r.status_code == 422


def test_prior_tiers_for_picks_latest_completed_same_version_run(engine, seeded):
    """Helper picks the most recent completed run for same business + version + domain."""

    with Session(engine) as s:
        # Create two batches for same business + version
        batch1 = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        batch2 = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        s.add(batch1); s.add(batch2); s.commit(); s.refresh(batch1); s.refresh(batch2)

        # Create domain runs with different ended_at times
        now = datetime.now(timezone.utc)
        dr1 = AssessDomainRun(batch_id=batch1.id, domain_id=seeded.d1, status="completed",
                              ended_at=now - timedelta(hours=2))
        dr2 = AssessDomainRun(batch_id=batch2.id, domain_id=seeded.d1, status="completed",
                              ended_at=now)  # newer
        s.add(dr1); s.add(dr2); s.commit(); s.refresh(dr1); s.refresh(dr2)

        # Add entities and columns to dr2 only (so we can find it)
        ent = AssessEntity(domain_run_id=dr2.id, name="Sales Order", grade="full")
        s.add(ent); s.commit(); s.refresh(ent)
        col = AssessColumnMapping(entity_id=ent.id, target="order_id", status="mapped", tier="core")
        s.add(col); s.commit()

        # Query for prior tiers excluding batch2 (the new one being launched)
        result = prior_tiers_for(s, business_id=seeded.bid, version_id=seeded.vid,
                                 domain_id=seeded.d1, exclude_batch_id=batch2.id)

        # Should return dr1 (if it had tiers) or None. Since dr1 has no tiers, should be None.
        # Let's add tiers to dr1 instead
        s.rollback()

        # Actually, let's redo: add tiers to dr1 and verify it's picked when dr2 is launching
        ent1 = AssessEntity(domain_run_id=dr1.id, name="Sales Order", grade="full")
        s.add(ent1); s.commit(); s.refresh(ent1)
        col1 = AssessColumnMapping(entity_id=ent1.id, target="order_id", status="mapped", tier="enrichment")
        s.add(col1); s.commit()

        result = prior_tiers_for(s, business_id=seeded.bid, version_id=seeded.vid,
                                 domain_id=seeded.d1, exclude_batch_id=batch2.id)

        assert result is not None
        assert result["source_domain_run_id"] == dr1.id
        assert result["assessed_at"] == dr1.ended_at.isoformat()
        assert result["entities"]["sales order"]["order_id"] == "enrichment"


def test_prior_tiers_for_ignores_other_versions_failed_tierless(engine, seeded):
    """Helper ignores different version, failed status, or runs with no tiers."""

    with Session(engine) as s:
        now = datetime.now(timezone.utc)

        # Create another version
        mv2 = ModelVersion(business_id=seeded.bid, version=4, scope="mvm", status="completed",
                          deployment_status="deployed", uc_catalog="mvm_cat")
        s.add(mv2); s.commit(); s.refresh(mv2)

        # Add domains to the new version
        d3 = Domain(version_id=mv2.id, name="sales_order", database_name="sales_order")
        s.add(d3); s.commit(); s.refresh(d3)

        # Batch with different version
        batch_diff_ver = AssessBatch(business_id=seeded.bid, version_id=mv2.id, created_by="test")
        # Batch with failed status
        batch_failed = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        # Batch with tierless run
        batch_tierless = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        # Batch being launched
        batch_launching = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")

        s.add(batch_diff_ver); s.add(batch_failed); s.add(batch_tierless); s.add(batch_launching)
        s.commit(); s.refresh(batch_diff_ver); s.refresh(batch_failed); s.refresh(batch_tierless); s.refresh(batch_launching)

        # Different version run with tier (should be ignored)
        dr_diff_ver = AssessDomainRun(batch_id=batch_diff_ver.id, domain_id=d3.id, status="completed", ended_at=now)
        s.add(dr_diff_ver); s.commit(); s.refresh(dr_diff_ver)
        ent_dv = AssessEntity(domain_run_id=dr_diff_ver.id, name="sales_order", grade="full")
        s.add(ent_dv); s.commit(); s.refresh(ent_dv)
        col_dv = AssessColumnMapping(entity_id=ent_dv.id, target="col", status="mapped", tier="core")
        s.add(col_dv); s.commit()

        # Failed run (should be ignored)
        dr_failed = AssessDomainRun(batch_id=batch_failed.id, domain_id=seeded.d1, status="failed", ended_at=now)
        s.add(dr_failed); s.commit(); s.refresh(dr_failed)
        ent_f = AssessEntity(domain_run_id=dr_failed.id, name="sales_order", grade="full")
        s.add(ent_f); s.commit(); s.refresh(ent_f)
        col_f = AssessColumnMapping(entity_id=ent_f.id, target="col", status="mapped", tier="core")
        s.add(col_f); s.commit()

        # Tierless run (should be ignored)
        dr_tierless = AssessDomainRun(batch_id=batch_tierless.id, domain_id=seeded.d1, status="completed", ended_at=now)
        s.add(dr_tierless); s.commit(); s.refresh(dr_tierless)
        ent_tl = AssessEntity(domain_run_id=dr_tierless.id, name="sales_order", grade="full")
        s.add(ent_tl); s.commit(); s.refresh(ent_tl)
        col_tl = AssessColumnMapping(entity_id=ent_tl.id, target="col", status="mapped", tier="")
        s.add(col_tl); s.commit()

        result = prior_tiers_for(s, business_id=seeded.bid, version_id=seeded.vid,
                                 domain_id=seeded.d1, exclude_batch_id=batch_launching.id)

        assert result is None  # All should be filtered out


def test_prior_tiers_for_excludes_launching_batch(engine, seeded):
    """Helper excludes the batch being launched."""

    with Session(engine) as s:
        now = datetime.now(timezone.utc)

        batch_old = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        batch_new = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        s.add(batch_old); s.add(batch_new); s.commit(); s.refresh(batch_old); s.refresh(batch_new)

        # Old run with tier
        dr_old = AssessDomainRun(batch_id=batch_old.id, domain_id=seeded.d1, status="completed",
                                ended_at=now - timedelta(hours=1))
        s.add(dr_old); s.commit(); s.refresh(dr_old)
        ent_old = AssessEntity(domain_run_id=dr_old.id, name="sales_order", grade="full")
        s.add(ent_old); s.commit(); s.refresh(ent_old)
        col_old = AssessColumnMapping(entity_id=ent_old.id, target="col", status="mapped", tier="core")
        s.add(col_old); s.commit()

        # New run with tier (should be excluded if it's the batch being launched)
        dr_new = AssessDomainRun(batch_id=batch_new.id, domain_id=seeded.d1, status="completed", ended_at=now)
        s.add(dr_new); s.commit(); s.refresh(dr_new)
        ent_new = AssessEntity(domain_run_id=dr_new.id, name="sales_order", grade="full")
        s.add(ent_new); s.commit(); s.refresh(ent_new)
        col_new = AssessColumnMapping(entity_id=ent_new.id, target="col", status="mapped", tier="enrichment")
        s.add(col_new); s.commit()


        # Exclude batch_new (the launching batch): should return dr_old
        result = prior_tiers_for(s, business_id=seeded.bid, version_id=seeded.vid,
                                 domain_id=seeded.d1, exclude_batch_id=batch_new.id)

        assert result is not None
        assert result["source_domain_run_id"] == dr_old.id


def test_prior_tiers_for_lowercases_names(engine, seeded):
    """Helper lowercases entity and column names."""

    with Session(engine) as s:
        batch = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        s.add(batch); s.commit(); s.refresh(batch)

        dr = AssessDomainRun(batch_id=batch.id, domain_id=seeded.d1, status="completed",
                            ended_at=datetime.now(timezone.utc))
        s.add(dr); s.commit(); s.refresh(dr)

        ent = AssessEntity(domain_run_id=dr.id, name="Sales Order", grade="full")
        s.add(ent); s.commit(); s.refresh(ent)

        col = AssessColumnMapping(entity_id=ent.id, target="Order_ID", status="mapped", tier="CORE")
        s.add(col); s.commit()

        result = prior_tiers_for(s, business_id=seeded.bid, version_id=seeded.vid,
                                 domain_id=seeded.d1, exclude_batch_id="not-real")

        assert result is not None
        assert "sales order" in result["entities"]
        assert "order_id" in result["entities"]["sales order"]
        assert result["entities"]["sales order"]["order_id"] == "CORE"


def test_launch_batch_includes_prior_tiers_when_enabled_and_found(client, mock_ws, engine, seeded):
    """When reuse_prior_tiers=True and a prior run exists, payload includes prior_tiers."""
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.return_value = NS(run_id=1000)

    dr_prior_id = None
    with Session(engine) as s:
        # Create a prior batch with completed run and tiered columns
        prior_batch = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        s.add(prior_batch); s.commit(); s.refresh(prior_batch)

        dr_prior = AssessDomainRun(batch_id=prior_batch.id, domain_id=seeded.d1, status="completed",
                                   ended_at=datetime.now(timezone.utc))
        s.add(dr_prior); s.commit(); s.refresh(dr_prior)
        dr_prior_id = dr_prior.id

        ent = AssessEntity(domain_run_id=dr_prior.id, name="sales_order", grade="full")
        s.add(ent); s.commit(); s.refresh(ent)

        col = AssessColumnMapping(entity_id=ent.id, target="order_id", status="mapped", tier="core")
        s.add(col); s.commit()

    body = {"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}], "reuse_prior_tiers": True}
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json=body)
    assert r.status_code == 201

    cfg = json.loads(mock_ws.files.upload.call_args_list[0].args[1].getvalue())
    assert "prior_tiers" in cfg
    assert cfg["prior_tiers"]["source_domain_run_id"] == dr_prior_id
    assert "sales_order" in cfg["prior_tiers"]["entities"]


def test_launch_batch_omits_prior_tiers_when_disabled(client, mock_ws, engine, seeded):
    """When reuse_prior_tiers=False, payload omits prior_tiers even if a prior run exists."""
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.return_value = NS(run_id=1000)

    with Session(engine) as s:
        # Create a prior batch with completed run and tiered columns
        prior_batch = AssessBatch(business_id=seeded.bid, version_id=seeded.vid, created_by="test")
        s.add(prior_batch); s.commit(); s.refresh(prior_batch)

        dr_prior = AssessDomainRun(batch_id=prior_batch.id, domain_id=seeded.d1, status="completed",
                                   ended_at=datetime.now(timezone.utc))
        s.add(dr_prior); s.commit(); s.refresh(dr_prior)

        ent = AssessEntity(domain_run_id=dr_prior.id, name="sales_order", grade="full")
        s.add(ent); s.commit(); s.refresh(ent)

        col = AssessColumnMapping(entity_id=ent.id, target="order_id", status="mapped", tier="core")
        s.add(col); s.commit()

    body = {"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}], "reuse_prior_tiers": False}
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json=body)
    assert r.status_code == 201

    cfg = json.loads(mock_ws.files.upload.call_args_list[0].args[1].getvalue())
    assert "prior_tiers" not in cfg


def test_launch_batch_omits_prior_tiers_when_none_exist(client, mock_ws, seeded):
    """When no prior run exists, payload omits prior_tiers."""
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.return_value = NS(run_id=1000)

    body = {"version_id": seeded.vid, "domains": [
        {"domain_id": seeded.d1, "sources": [_src()]}], "reuse_prior_tiers": True}
    r = client.post(f"/api/businesses/{seeded.bid}/assessments", json=body)
    assert r.status_code == 201

    cfg = json.loads(mock_ws.files.upload.call_args_list[0].args[1].getvalue())
    assert "prior_tiers" not in cfg


@pytest.mark.parametrize("statuses, expected", [
    (["completed", "completed"], "completed"),
    (["completed", "failed"], "partial"),
    (["completed", "results_invalid"], "partial"),
    (["completed", "cancelled"], "partial"),
    (["results_invalid", "results_invalid"], "failed"),
    (["results_invalid", "cancelled"], "failed"),
    (["failed", "cancelled"], "failed"),
    (["cancelled"], "cancelled"),
    (["completed", "assessing"], "running"),
])
def test_rollup_status(statuses, expected):
    """``partial`` needs a completed run; a batch whose runs all lack usable results is ``failed``."""
    from vibe_modeling.backend.routes.assessments import _rollup_status
    assert _rollup_status(statuses) == expected
