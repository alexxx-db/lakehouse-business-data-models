"""``assess_ready``: the one place that decides whether assessments can launch.

Table-driven over the install flag and every stored setup field it reads
(reader, job, synced version, sync error, job reader). Nothing is probed.
"""
from __future__ import annotations

import pytest

from vibe_modeling import __version__ as APP_VERSION
from vibe_modeling.backend.assessment.config_service import NOT_INSTALLED_DETAIL, assess_ready
from vibe_modeling.backend.db_models import AssessConfig

READER = "reader-1"


def _cfg(**overrides) -> AssessConfig:
    base = dict(reader_application_id=READER, job_id=7, synced_version=APP_VERSION,
                job_setup_error="", job_reader=READER)
    base.update(overrides)
    return AssessConfig(**base)


NO_JOB = "The assessment job has not been created yet"
STALE = f"The assessment job has not been synced for app version {APP_VERSION}"
WRONG_READER = "The assessment job does not run as the configured reader"


@pytest.mark.parametrize("installed,overrides,ready,missing", [
    (True, {}, True, []),
    (False, {}, False, [NOT_INSTALLED_DETAIL]),
    (False, {"reader_application_id": ""}, False, [NOT_INSTALLED_DETAIL]),
    (True, {"reader_application_id": ""}, False, ["No reader service principal"]),
    (True, {"reader_application_id": "", "job_setup_error": "boom"}, False, ["No reader service principal"]),
    (True, {"job_setup_error": "PermissionDenied: x"}, False, ["Job sync failed: PermissionDenied: x"]),
    (True, {"job_setup_error": "boom", "job_id": None}, False, ["Job sync failed: boom"]),
    (True, {"job_id": None}, False, [NO_JOB]),
    (True, {"synced_version": ""}, False, [STALE]),
    (True, {"synced_version": "0.0.1"}, False, [STALE]),
    (True, {"job_reader": ""}, False, [WRONG_READER]),
    (True, {"job_reader": "someone-else"}, False, [WRONG_READER]),
    (True, {"job_id": None, "synced_version": "", "job_reader": ""}, False, [NO_JOB, STALE, WRONG_READER]),
])
def test_assess_ready(installed, overrides, ready, missing):
    assert assess_ready(_cfg(**overrides), installed) == (ready, missing)


def test_config_out_uses_assess_ready(client, engine):
    from sqlmodel import Session
    with Session(engine) as s:
        s.add(_cfg(job_reader="someone-else")); s.commit()
    body = client.get("/api/assess/config").json()
    assert body["ready"] is False and body["missing"] == [WRONG_READER]
