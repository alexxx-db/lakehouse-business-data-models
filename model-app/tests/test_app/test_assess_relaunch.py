import os
import sys
from types import SimpleNamespace as NS

import pytest
from sqlmodel import Session, select

from vibe_modeling.backend.db_models import (
    AssessBatch, AssessConfig, AssessDomainRun, AssessDomainSource, Business, Domain, ModelVersion,
)

sys.path.insert(0, os.path.dirname(__file__))

from _assess_helpers import _eff, ready_config, ws_ok


@pytest.fixture
def seeded(engine):
    """One batch with four domain runs: failed, cancelled, completed, assessing; sources on each."""
    with Session(engine) as s:
        b = Business(name="Meridian Mfg", description="d")
        s.add(b); s.commit(); s.refresh(b)
        mv = ModelVersion(business_id=b.id, version=3, scope="mvm", status="completed",
                          deployment_status="deployed", uc_catalog="mvm_cat")
        s.add(mv); s.commit(); s.refresh(mv)
        doms = [Domain(version_id=mv.id, name=n, database_name=n) for n in ("d_failed", "d_cancel", "d_done", "d_live")]
        for d in doms:
            s.add(d)
        s.add(ready_config())
        s.commit()
        for d in doms:
            s.refresh(d)
        batch = AssessBatch(business_id=b.id, version_id=mv.id, output_model="dimensional", etl_type="notebook",
                            reasoning_effort="low", created_by="u")
        s.add(batch); s.commit(); s.refresh(batch)
        runs = {}
        for d, st in zip(doms, ("failed", "cancelled", "completed", "assessing")):
            dr = AssessDomainRun(batch_id=batch.id, domain_id=d.id, status=st, databricks_run_id=1)
            s.add(dr); s.commit(); s.refresh(dr)
            s.add(AssessDomainSource(domain_run_id=dr.id, source_name=f"src_{st}", catalog_name="bronze",
                                     schema_name=f"sch_{st}"))
            s.commit()
            runs[st] = dr.id
        return NS(bid=b.id, vid=mv.id, batch=batch.id, runs=runs, doms={st: d.id for st, d in zip(runs, doms)})


def _relaunch(client, batch, body=None):
    return client.post(f"/api/assessments/{batch}/relaunch", json=body) if body is not None \
        else client.post(f"/api/assessments/{batch}/relaunch")


def test_default_selects_failed_cancelled_results_invalid_only(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    with Session(engine) as s:
        dr = s.get(AssessDomainRun, seeded.runs["completed"]); dr.status = "results_invalid"; s.add(dr); s.commit()
    mock_ws.jobs.run_now.side_effect = [NS(run_id=7), NS(run_id=8), NS(run_id=9)]
    r = _relaunch(client, seeded.batch)
    assert r.status_code == 201, r.text
    out = r.json()
    assert out["id"] != seeded.batch
    assert {d["domain_id"] for d in out["domain_runs"]} == {
        seeded.doms["failed"], seeded.doms["cancelled"], seeded.doms["completed"]}
    assert (out["output_model"], out["etl_type"], out["reasoning_effort"]) == ("dimensional", "notebook", "low")
    assert out["version_id"] == seeded.vid


def test_sources_copied_verbatim_and_old_batch_kept(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = [NS(run_id=7), NS(run_id=8)]
    out = _relaunch(client, seeded.batch).json()
    by_dom = {d["domain_id"]: d["sources"] for d in out["domain_runs"]}
    assert by_dom[seeded.doms["failed"]] == [
        {"source_name": "src_failed", "catalog_name": "bronze", "schema_name": "sch_failed"}]
    assert by_dom[seeded.doms["cancelled"]] == [
        {"source_name": "src_cancelled", "catalog_name": "bronze", "schema_name": "sch_cancelled"}]
    with Session(engine) as s:
        assert len(s.exec(select(AssessBatch)).all()) == 2
        assert s.get(AssessDomainRun, seeded.runs["failed"]).status == "failed"


def test_explicit_ids(client, mock_ws, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = [NS(run_id=7)]
    r = _relaunch(client, seeded.batch, {"domain_run_ids": [seeded.runs["cancelled"]]})
    assert r.status_code == 201, r.text
    assert [d["domain_id"] for d in r.json()["domain_runs"]] == [seeded.doms["cancelled"]]


def test_explicit_completed_run_is_relaunchable(client, mock_ws, seeded):
    ws_ok(mock_ws)
    mock_ws.jobs.run_now.side_effect = [NS(run_id=7)]
    r = _relaunch(client, seeded.batch, {"domain_run_ids": [seeded.runs["completed"]]})
    assert r.status_code == 201, r.text


def test_foreign_id_is_422(client, mock_ws, seeded):
    ws_ok(mock_ws)
    r = _relaunch(client, seeded.batch, {"domain_run_ids": ["nope"]})
    assert r.status_code == 422


def test_non_terminal_id_is_409(client, mock_ws, seeded):
    ws_ok(mock_ws)
    r = _relaunch(client, seeded.batch, {"domain_run_ids": [seeded.runs["assessing"]]})
    assert r.status_code == 409
    mock_ws.jobs.run_now.assert_not_called()


def test_nothing_eligible_is_409(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    with Session(engine) as s:
        for k in ("failed", "cancelled"):
            dr = s.get(AssessDomainRun, seeded.runs[k]); dr.status = "completed"; s.add(dr)
        s.commit()
    r = _relaunch(client, seeded.batch)
    assert r.status_code == 409
    assert r.json()["detail"] == "Nothing to relaunch."


def test_unknown_batch_is_404(client, mock_ws):
    assert _relaunch(client, "missing").status_code == 404


def test_blocked_readiness_is_409_and_creates_no_batch(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    mock_ws.grants.get_effective.side_effect = lambda t, n, principal=None: _eff() if n.startswith("bronze") else _eff("ALL_PRIVILEGES")
    r = _relaunch(client, seeded.batch)
    assert r.status_code == 409
    assert any(d["blocked"] for d in r.json()["detail"]["readiness"]["domains"])
    mock_ws.files.upload.assert_not_called(); mock_ws.jobs.run_now.assert_not_called()
    with Session(engine) as s:
        assert len(s.exec(select(AssessBatch)).all()) == 1


def test_run_without_stored_sources_is_422(client, mock_ws, engine, seeded):
    ws_ok(mock_ws)
    with Session(engine) as s:
        for x in s.exec(select(AssessDomainSource).where(AssessDomainSource.domain_run_id == seeded.runs["failed"])).all():
            s.delete(x)
        s.commit()
    assert _relaunch(client, seeded.batch, {"domain_run_ids": [seeded.runs["failed"]]}).status_code == 422
