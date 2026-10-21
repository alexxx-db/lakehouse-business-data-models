"""Ingest safety (design §4.6): the schema contract, the pin match, ``results_valid=false``,
the write surface, and the one-feedback-item-per-next-vibe compare-and-set."""
from __future__ import annotations

import json
import os
import sys
from pathlib import Path

import pytest
from sqlmodel import Session, select

sys.path.insert(0, os.path.dirname(__file__))

from _assess_helpers import FEEDBACK_TABLES, changed_tables, table_digests  # noqa: E402
from test_assess_ingest import OUT, _counts, _fixture_files, _seed_run, _ws_with  # noqa: E402
from test_assess_next_vibe_feedback import WHO  # noqa: E402

from vibe_modeling.backend.assessment import ingest as ingest_mod  # noqa: E402
from vibe_modeling.backend.assessment.constants import SUPPORTED_SCHEMA_VERSIONS  # noqa: E402
from vibe_modeling.backend.assessment.ingest import ingest_domain_run  # noqa: E402
from vibe_modeling.backend.db_models import AssessDomainRun, AssessNextVibe, VibeInput, VibeInputContextLink  # noqa: E402

VENDOR = Path(__file__).resolve().parents[2] / "src" / "app" / "vendored" / "assessment"
SUMMARY, CONFIG = f"{OUT}/summary.json", f"{OUT}/config.json"


def _files(summary: dict | None = None, config: dict | None = None, **summary_changes) -> dict[str, bytes]:
    files = _fixture_files()
    s = summary if summary is not None else json.loads(files[SUMMARY])
    s.update(summary_changes)
    files[SUMMARY] = json.dumps(s).encode()
    if config is not None:
        files[CONFIG] = json.dumps(config).encode()
    return files


def _ingest(engine, dr_id, files):
    with Session(engine) as s:
        res = ingest_domain_run(s, _ws_with(files), s.get(AssessDomainRun, dr_id))
        return res, _counts(s), s.get(AssessDomainRun, dr_id)


# --- schema contract ---------------------------------------------------------------------------


def test_vendored_schema_version_is_supported_and_newest():
    version = json.loads((VENDOR / "assessment.schema.json").read_text())["x-schema-version"]
    assert version in SUPPORTED_SCHEMA_VERSIONS and version == max(SUPPORTED_SCHEMA_VERSIONS)


def test_the_notebook_copies_the_schema_version_into_summary_json():
    src = (VENDOR / "assess_domain.py").read_text()
    assert 'summary["schema_version"] = assessment_schema.get("x-schema-version")' in src


def test_supported_schema_version_is_ingested_and_stored(engine):
    dr_id, _, _ = _seed_run(engine)
    res, counts, dr = _ingest(engine, dr_id, _files())
    assert res.results_valid and counts[0] == 2 and dr.schema_version == 1


@pytest.mark.parametrize("value", [None, 0, 2, "1", True, 1.0])
def test_unknown_or_missing_schema_version_is_refused_with_no_rows(engine, value):
    dr_id, _, _ = _seed_run(engine)
    files = _fixture_files()
    s = json.loads(files[SUMMARY])
    if value is None:
        s.pop("schema_version")
    else:
        s["schema_version"] = value
    files[SUMMARY] = json.dumps(s).encode()
    res, counts, dr = _ingest(engine, dr_id, files)
    assert not res.results_valid and res.error.startswith("Results refused: summary.json schema_version is")
    assert counts == (0, 0, 0, 0, 0, 0) and dr.results_valid is False
    # The declared version is kept on the run when it is an integer, for the admin to see.
    assert dr.schema_version == (value if type(value) is int else None)


def test_previous_schema_version_is_kept_for_one_release(engine, monkeypatch):
    # Policy: on a bump to N the app keeps N-1 for one release; ingest reads the set, nothing else.
    monkeypatch.setattr(ingest_mod, "SUPPORTED_SCHEMA_VERSIONS", frozenset({1, 2}))
    dr_id, _, _ = _seed_run(engine)
    res, counts, dr = _ingest(engine, dr_id, _files(schema_version=2))
    assert res.results_valid and counts[0] == 2 and dr.schema_version == 2


def test_missing_summary_is_refused(engine):
    dr_id, _, _ = _seed_run(engine)
    files = _fixture_files()
    del files[SUMMARY]
    res, counts, _ = _ingest(engine, dr_id, files)
    assert not res.results_valid and "summary.json not found" in res.error and counts[0] == 0


# --- pin match: notebook- and app-written fields only ------------------------------------------


GOOD_CONFIG = {"batch_id": "b", "domain": "sales_order", "model_version": 3}


@pytest.mark.parametrize("summary_changes,config,reason", [
    ({"domain": "customer"}, None, "summary.json is for domain 'customer'"),
    ({"preflight": {"ok": True, "version_check": "failed"}}, None, "pre-flight model version check is 'failed'"),
    ({"preflight": None}, None, "pre-flight model version check is None"),
    ({}, {**GOOD_CONFIG, "batch_id": "other"}, "config.json is for batch 'other'"),
    ({}, {**GOOD_CONFIG, "domain": "customer"}, "config.json is for domain 'customer'"),
    ({}, {**GOOD_CONFIG, "model_version": 4}, "config.json pins model version 4"),
])
def test_pin_mismatch_is_refused_with_no_rows(engine, summary_changes, config, reason):
    dr_id, _, _ = _seed_run(engine)
    res, counts, dr = _ingest(engine, dr_id, _files(config=config, **summary_changes))
    assert not res.results_valid and res.error.startswith("Results refused: ") and reason in res.error
    assert counts == (0, 0, 0, 0, 0, 0) and dr.results_valid is False


def test_missing_launch_config_is_refused(engine):
    dr_id, _, _ = _seed_run(engine)
    files = _fixture_files()
    del files[CONFIG]
    res, counts, _ = _ingest(engine, dr_id, files)
    assert "config.json is missing" in res.error and counts[0] == 0


def test_a_skipped_version_check_still_matches(engine):
    dr_id, _, _ = _seed_run(engine)
    res, _, _ = _ingest(engine, dr_id, _files(preflight={"ok": True, "version_check": "skipped: metamodel has no version column"}))
    assert res.results_valid


def test_the_llm_written_metamodel_is_display_only(engine):
    dr_id, _, _ = _seed_run(engine)
    files = _files()
    doc = json.loads(files[f"{OUT}/docs/design/assessment.json"])
    doc["metamodel"] = {"location": "someone_else._metamodel", "version": "999"}
    files[f"{OUT}/docs/design/assessment.json"] = json.dumps(doc).encode()
    res, _, dr = _ingest(engine, dr_id, files)
    assert res.results_valid and dr.metamodel_version == "999"


@pytest.mark.parametrize("value,shown", [(False, "false"), (None, "null"), ("true", '"true"'), (1, "1"), (1.0, "1.0")])
def test_results_not_valid_write_no_rows(engine, value, shown):
    dr_id, _, _ = _seed_run(engine)
    res, counts, dr = _ingest(engine, dr_id, _files(results_valid=value, validation_errors=["entities: required"]))
    assert not res.results_valid and res.error == f"Results refused: the notebook reported results_valid={shown}: entities: required"
    assert counts == (0, 0, 0, 0, 0, 0) and dr.results_valid is False


# --- write surface -------------------------------------------------------------------------------


def test_ingest_writes_assess_tables_only_and_feedback_only_vibe_inputs(client, engine):
    dr_id, _, _ = _seed_run(engine)
    before = table_digests(engine)
    res, _, _ = _ingest(engine, dr_id, _files())
    assert res.results_valid
    after_ingest = table_digests(engine)
    changed = changed_tables(before, after_ingest)
    assert changed and all(t.startswith("assess_") for t in changed), changed

    with Session(engine) as s:
        ids = list(s.exec(select(AssessNextVibe.id).where(AssessNextVibe.domain_run_id == dr_id)))
    r = client.post(f"/api/assessment-domain-runs/{dr_id}/next-vibes/feedback/bulk",
                    json={"ids": ids}, headers=WHO)
    assert r.status_code == 200 and r.json()["count_created"] == 1, r.text
    changed = changed_tables(after_ingest, table_digests(engine))
    assert {t for t in changed if not t.startswith("assess_")} == FEEDBACK_TABLES
    assert changed - FEEDBACK_TABLES == {"assess_next_vibe"}


# --- one feedback item per next vibe ------------------------------------------------------------


@pytest.fixture
def ingested(engine):
    dr_id, _, _ = _seed_run(engine)
    assert _ingest(engine, dr_id, _files())[0].results_valid
    with Session(engine) as s:
        nv_id = s.exec(select(AssessNextVibe.id).where(AssessNextVibe.domain_run_id == dr_id)).one()
    return dr_id, nv_id


def _feedback_rows(engine):
    with Session(engine) as s:
        return len(s.exec(select(VibeInput)).all()), len(s.exec(select(VibeInputContextLink)).all())


def test_a_double_click_creates_one_item(client, engine, ingested):
    dr_id, nv_id = ingested
    url = f"/api/assessment-domain-runs/{dr_id}/next-vibes/{nv_id}/feedback"
    first, second = client.post(url, headers=WHO).json(), client.post(url, headers=WHO).json()
    assert first["created"] and not second["created"]
    assert first["feedback_input_id"] == second["feedback_input_id"]
    assert _feedback_rows(engine) == (1, 1)


def test_a_lost_race_rolls_back_and_returns_the_winner(client, engine, ingested, monkeypatch):
    """Another request links the next vibe between this request's read and its compare-and-set."""
    import vibe_modeling.backend.routes.assessments as routes
    from vibe_modeling.backend.models import VibeInputOrigin, VibeInputPriority

    dr_id, nv_id = ingested
    real = routes.create_vibe_input_with_anchor
    winner = {}

    def racing_create(session, **kw):
        with Session(engine) as other:  # the concurrent request: creates its item and links it first
            nv = other.get(AssessNextVibe, nv_id)
            vi = real(other, business_id=kw["business_id"], text="winner", author="other@example.com",
                      version_id=kw["version_id"], origin=VibeInputOrigin.USER,
                      priority=VibeInputPriority.MEDIUM, confidence_score=None)
            nv.vibe_input_id = winner["id"] = vi.id
            other.add(nv)
            other.commit()
        return real(session, **kw)

    monkeypatch.setattr(routes, "create_vibe_input_with_anchor", racing_create)
    r = client.post(f"/api/assessment-domain-runs/{dr_id}/next-vibes/{nv_id}/feedback", headers=WHO)
    assert r.status_code == 200, r.text
    assert r.json() == {"next_vibe_id": nv_id, "feedback_input_id": winner["id"], "created": False}
    assert _feedback_rows(engine) == (1, 1)  # the loser's VibeInput and link rolled back
    with Session(engine) as s:
        assert s.get(AssessNextVibe, nv_id).vibe_input_id == winner["id"]


def test_a_deprecated_link_is_replaced_once(client, engine, ingested):
    from vibe_modeling.backend.models import VibeInputStatus

    dr_id, nv_id = ingested
    url = f"/api/assessment-domain-runs/{dr_id}/next-vibes/{nv_id}/feedback"
    old = client.post(url, headers=WHO).json()["feedback_input_id"]
    with Session(engine) as s:
        vi = s.get(VibeInput, old)
        vi.status = VibeInputStatus.DEPRECATED.value
        s.add(vi); s.commit()
    new = client.post(url, headers=WHO).json()
    assert new["created"] and new["feedback_input_id"] != old
    again = client.post(url, headers=WHO).json()
    assert not again["created"] and again["feedback_input_id"] == new["feedback_input_id"]


def test_a_race_that_leaves_no_winner_is_a_plain_retry_409(client, engine, ingested, monkeypatch):
    """The link this request read (a deprecated item) is cleared by another request before the
    compare-and-set: nothing to return, so the modeler is told to retry (not the admin-help shape)."""
    import vibe_modeling.backend.routes.assessments as routes
    from vibe_modeling.backend.models import VibeInputStatus

    dr_id, nv_id = ingested
    url = f"/api/assessment-domain-runs/{dr_id}/next-vibes/{nv_id}/feedback"
    old = client.post(url, headers=WHO).json()["feedback_input_id"]
    with Session(engine) as s:
        vi = s.get(VibeInput, old)
        vi.status = VibeInputStatus.DEPRECATED.value
        s.add(vi); s.commit()
    real = routes.create_vibe_input_with_anchor

    def clearing_create(session, **kw):
        with Session(engine) as other:
            nv = other.get(AssessNextVibe, nv_id)
            nv.vibe_input_id = None
            other.add(nv); other.commit()
        return real(session, **kw)

    monkeypatch.setattr(routes, "create_vibe_input_with_anchor", clearing_create)
    r = client.post(url, headers=WHO)
    assert r.status_code == 409
    assert r.json()["detail"] == {"message": "Another request changed this next vibe's feedback link at the same time; try again."}
    assert _feedback_rows(engine) == (1, 1)  # this request's item rolled back
