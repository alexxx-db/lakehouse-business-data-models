"""Shared helpers used by both the vibe agent and the headless assessment.

- ``routes/_helpers.build_job_run_url``: job and run links (keeps ``?o=``);
  the agent's ``_build_dbx_job_url``/``_build_dbx_run_url`` are thin callers
  and their URLs are unchanged.
- ``job_launcher.reset_or_create_job``: reset-or-create with an opt-in raise.
- ``core/_app_identity``: the app SP's user name, home and cached id.
"""
from __future__ import annotations

from types import SimpleNamespace as NS
from unittest.mock import MagicMock

import pytest
from databricks.sdk.errors import NotFound
from sqlmodel import Session

from vibe_modeling.backend.core import _app_identity
from vibe_modeling.backend.db_models import AgentConfig
from vibe_modeling.backend.job_launcher import reset_or_create_job
from vibe_modeling.backend.routes._helpers import _build_dbx_job_url, _build_dbx_run_url, build_job_run_url


def _ws(host: str):
    return NS(config=NS(host=host))


# --- build_job_run_url ---

@pytest.mark.parametrize("host,job_id,run_id,expected", [
    ("https://h.cloud.databricks.com", 7, None, "https://h.cloud.databricks.com/jobs/7"),
    ("https://h.cloud.databricks.com/", 7, 9, "https://h.cloud.databricks.com/jobs/7/runs/9"),
    ("https://h.cloud.databricks.com", None, 9, "https://h.cloud.databricks.com/jobs/runs/9"),
    ("https://h.cloud.databricks.com/?o=123", 7, None, "https://h.cloud.databricks.com/jobs/7?o=123"),
    ("https://h.cloud.databricks.com/?o=123", 7, 9, "https://h.cloud.databricks.com/jobs/7/runs/9?o=123"),
    ("https://h.cloud.databricks.com", None, None, ""),
])
def test_build_job_run_url(host, job_id, run_id, expected):
    assert build_job_run_url(_ws(host), job_id, run_id) == expected


def test_build_job_run_url_without_workspace_client():
    assert build_job_run_url(None, 7, 9) == ""


def test_agent_job_url_is_unchanged():
    assert _build_dbx_job_url(_ws("https://h/?o=1"), 7) == "https://h/jobs/7?o=1"
    assert _build_dbx_job_url(_ws("https://h"), None) == ""
    assert _build_dbx_job_url(None, 7) == ""


def test_agent_run_url_is_unchanged(engine):
    ws = _ws("https://h/?o=1")
    with Session(engine) as s:
        assert _build_dbx_run_url(9, ws, s) == "https://h/jobs/runs/9?o=1"
        s.add(AgentConfig(job_id=42)); s.commit()
        assert _build_dbx_run_url(9, ws, s) == "https://h/jobs/42/runs/9?o=1"
    assert _build_dbx_run_url(None, ws, None) is None
    assert _build_dbx_run_url(9, None, None) is None
    assert _build_dbx_run_url(9, ws, None) == "https://h/jobs/runs/9?o=1"


# --- reset_or_create_job ---

SETTINGS = {"name": "j", "max_concurrent_runs": 2}


def test_reset_existing_job():
    ws = MagicMock()
    assert reset_or_create_job(ws, job_id=7, settings=SETTINGS) == 7
    assert ws.jobs.reset.call_args.kwargs["new_settings"].name == "j"
    ws.jobs.create.assert_not_called()


def test_create_without_job_id():
    ws = MagicMock(); ws.jobs.create.return_value.job_id = 11
    assert reset_or_create_job(ws, job_id=None, settings=SETTINGS) == 11
    ws.jobs.reset.assert_not_called()
    assert ws.jobs.create.call_args.kwargs == SETTINGS


@pytest.mark.parametrize("raise_on_reset_error", [False, True])
def test_deleted_job_is_recreated(raise_on_reset_error):
    ws = MagicMock(); ws.jobs.reset.side_effect = NotFound("gone"); ws.jobs.create.return_value.job_id = 12
    assert reset_or_create_job(ws, job_id=7, settings=SETTINGS, raise_on_reset_error=raise_on_reset_error) == 12


def test_other_reset_error_recreates_by_default():
    ws = MagicMock(); ws.jobs.reset.side_effect = RuntimeError("boom"); ws.jobs.create.return_value.job_id = 13
    assert reset_or_create_job(ws, job_id=7, settings=SETTINGS) == 13


def test_other_reset_error_raises_when_opted_in():
    ws = MagicMock(); ws.jobs.reset.side_effect = RuntimeError("boom")
    with pytest.raises(RuntimeError, match="boom"):
        reset_or_create_job(ws, job_id=7, settings=SETTINGS, raise_on_reset_error=True)
    ws.jobs.create.assert_not_called()


def test_assessment_job_opts_in_to_the_raise():
    from vibe_modeling.backend.assessment.job import setup_assessment_job
    ws = MagicMock(); ws.jobs.reset.side_effect = RuntimeError("cannot act as SP")
    with pytest.raises(RuntimeError):
        setup_assessment_job(ws, job_id=7, notebook_path="/n", reader_application_id="a", max_concurrent_runs=2)
    ws.jobs.create.assert_not_called()


def test_agent_job_keeps_the_silent_recreate():
    from vibe_modeling.backend.job_launcher import setup_agent_job
    ws = MagicMock(); ws.jobs.reset.side_effect = RuntimeError("boom"); ws.jobs.create.return_value.job_id = 14
    cfg = AgentConfig(job_id=7, notebook_path="/n")
    assert setup_agent_job(ws, cfg) == 14


# --- core/_app_identity ---

def _me(user_name):
    ws = MagicMock(); ws.current_user.me.return_value.user_name = user_name
    return ws


def test_app_sp_home():
    assert _app_identity.app_sp_home(_me("sp-uuid")) == "/Users/sp-uuid"


@pytest.mark.parametrize("bad", ["", None])
def test_app_sp_user_name_requires_a_name(bad):
    with pytest.raises(RuntimeError, match="user_name"):
        _app_identity.app_sp_user_name(_me(bad))


def test_app_application_id_is_cached_and_fail_soft():
    _app_identity._APP_ID_CACHE.clear()
    try:
        failing = MagicMock(); failing.current_user.me.side_effect = RuntimeError("boom")
        assert _app_identity.app_application_id(failing) == ""
        assert _app_identity.app_application_id(_me("sp-1")) == "sp-1"
        assert _app_identity.app_application_id(_me("sp-2")) == "sp-1"
    finally:
        _app_identity._APP_ID_CACHE.clear()
