"""NEW_BASE_MODEL auto-setup of a missing ``<catalog>._metamodel``.

The preflight only reports that setup is needed (validate and create) and
creates nothing. The new-base-model create handler creates the schema + MANAGED
``vol_root`` volume with the App SP client after every gate, or refuses with a
400. Every other `_METAMODEL_REQUIRED_INTENTS` intent keeps the original
blocker.
"""
from __future__ import annotations

import ast
import sys
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import MagicMock, call

import pytest
from databricks.sdk.errors import (
    AlreadyExists,
    BadRequest,
    NotFound,
    PermissionDenied,
    ResourceAlreadyExists,
    ResourceConflict,
)
from databricks.sdk.service.catalog import VolumeType
from sqlmodel import Session, select

import vibe_modeling.backend.router
from vibe_modeling.backend.db_models import AgentConfig, Business, Industry, Run
from vibe_modeling.backend.models import Intent, RunIn
from vibe_modeling.backend.router import _check_metamodel_schema_present
from vibe_modeling.backend.services import metamodel_setup
from vibe_modeling.backend.services.metamodel_setup import (
    MetamodelSetupError,
    ensure_metamodel_schema_and_volume,
)

from .conftest import stub_no_metamodel

CAT = "fresh_cat"


def _ws(schemas=("default",), client_id="sp-client-123"):
    ws = MagicMock()
    ws.schemas.list.return_value = iter([SimpleNamespace(name=n) for n in schemas])
    ws.schemas.get.side_effect = NotFound("no schema")
    ws.volumes.read.side_effect = NotFound("no volume")
    ws.config.client_id = client_id
    return ws


SCHEMA_GET = call(f"{CAT}._metamodel")
VOLUME_READ = call(f"{CAT}._metamodel.vol_root")


def _schema_exists_error(_message=None):
    # Live workspace shape: UC reports an existing schema as BadRequest, not a conflict.
    return BadRequest("Schema '_metamodel' already exists", error_code="SCHEMA_ALREADY_EXISTS")


def _run(intent=Intent.NEW_BASE_MODEL):
    return RunIn(intent=intent, catalog=CAT, cataloging_style="One Catalog")


# --- helper -----------------------------------------------------------------

def test_helper_creates_schema_and_managed_volume():
    ws = _ws()
    created = ensure_metamodel_schema_and_volume(ws, CAT)
    ws.schemas.create.assert_called_once_with(name="_metamodel", catalog_name=CAT)
    ws.volumes.create.assert_called_once_with(
        catalog_name=CAT, schema_name="_metamodel", name="vol_root",
        volume_type=VolumeType.MANAGED,
    )
    assert len(created) == 2


def test_helper_creates_each_requested_volume_and_names_it_on_failure():
    ws = _ws()
    ws.schemas.get.side_effect = None
    created = ensure_metamodel_schema_and_volume(ws, CAT, volumes=("assess_runs",))
    assert created == [f"managed volume {CAT}._metamodel.assess_runs"]
    assert ws.volumes.create.call_args.kwargs["name"] == "assess_runs"
    ws.volumes.create.side_effect = PermissionDenied("no CREATE VOLUME")
    with pytest.raises(MetamodelSetupError) as exc:
        ensure_metamodel_schema_and_volume(ws, CAT, volumes=("assess_runs",))
    assert exc.value.step == "volume" and "`assess_runs` volume" in str(exc.value)
    assert "vol_root" not in str(exc.value)


@pytest.mark.parametrize(
    "schema_error, volume_error",
    [
        (_schema_exists_error, ResourceAlreadyExists),
        (AlreadyExists, AlreadyExists),
        (ResourceConflict, ResourceConflict),
    ],
    ids=["live-shapes", "already-exists", "resource-conflict"],
)
def test_helper_already_exists_is_success(schema_error, volume_error):
    # Absent on the probe, present on the re-probe after the failed create.
    ws = _ws()
    ws.schemas.get.side_effect = [NotFound("no schema"), None]
    ws.volumes.read.side_effect = [NotFound("no volume"), None]
    ws.schemas.create.side_effect = schema_error("exists")
    ws.volumes.create.side_effect = volume_error("exists")
    assert ensure_metamodel_schema_and_volume(ws, CAT) == []
    ws.volumes.create.assert_called_once()  # still attempts the volume
    assert ws.schemas.get.call_args_list == [SCHEMA_GET] * 2
    assert ws.volumes.read.call_args_list == [VOLUME_READ] * 2


@pytest.mark.parametrize("reprobe_error", [NotFound, PermissionDenied])
@pytest.mark.parametrize("create_error", [_schema_exists_error, ResourceConflict])
@pytest.mark.parametrize("step", ["schema", "volume"])
def test_helper_failed_create_unconfirmed_raises_generic(step, create_error, reprobe_error):
    ws = _ws()
    error = create_error("conflict")
    if step == "schema":
        ws.schemas.create.side_effect = error
        ws.schemas.get.side_effect = [NotFound("no schema"), reprobe_error("gone")]
    else:
        ws.volumes.create.side_effect = error
        ws.volumes.read.side_effect = [NotFound("no volume"), reprobe_error("gone")]
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    msg = str(ei.value)
    assert msg.startswith("Couldn't set up `_metamodel`")
    assert "can't create" not in msg
    assert ei.value.step == step
    assert ei.value.__cause__ is error
    if step == "schema":
        assert ws.schemas.get.call_args_list == [SCHEMA_GET] * 2
        ws.volumes.create.assert_not_called()
    else:
        assert ws.volumes.read.call_args_list == [VOLUME_READ] * 2


@pytest.mark.parametrize("create_error", [PermissionDenied, RuntimeError])
@pytest.mark.parametrize("step", ["schema", "volume"])
def test_helper_failed_create_but_object_exists_is_success(step, create_error):
    ws = _ws()
    if step == "schema":
        ws.schemas.create.side_effect = create_error("racing creator won")
        ws.schemas.get.side_effect = [NotFound("no schema"), None]
    else:
        ws.volumes.create.side_effect = create_error("racing creator won")
        ws.volumes.read.side_effect = [NotFound("no volume"), None]
    created = ensure_metamodel_schema_and_volume(ws, CAT)
    if step == "schema":
        assert created == [f"managed volume {CAT}._metamodel.vol_root"]
    else:
        assert created == [f"schema {CAT}._metamodel"]
    if step == "schema":
        assert ws.schemas.get.call_args_list == [SCHEMA_GET] * 2
        assert ws.volumes.read.call_args_list == [VOLUME_READ]
    else:
        assert ws.schemas.get.call_args_list == [SCHEMA_GET]
        assert ws.volumes.read.call_args_list == [VOLUME_READ] * 2
    ws.volumes.create.assert_called_once()


@pytest.mark.parametrize("step", ["schema", "volume"])
def test_helper_permission_denied_reprobe_error_keeps_permission_message(step):
    ws = _ws()
    error = PermissionDenied("denied")
    if step == "schema":
        ws.schemas.create.side_effect = error
        ws.schemas.get.side_effect = [NotFound("no schema"), RuntimeError("reprobe boom")]
    else:
        ws.volumes.create.side_effect = error
        ws.volumes.read.side_effect = [NotFound("no volume"), RuntimeError("reprobe boom")]
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    assert ei.value.step == step
    assert str(ei.value).startswith("The app can't create")
    assert "reprobe boom" not in str(ei.value)
    assert ei.value.__cause__ is error
    if step == "schema":
        assert ws.schemas.get.call_args_list == [SCHEMA_GET] * 2
    else:
        assert ws.volumes.read.call_args_list == [VOLUME_READ] * 2


def test_helper_permission_denied_sanitized_and_names_sp():
    ws = _ws()
    error = PermissionDenied("User x@corp.com lacks CREATE SCHEMA on /Volumes/secret/path")
    ws.schemas.create.side_effect = error
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    msg = str(ei.value)
    assert ei.value.step == "schema"
    assert ei.value.__cause__ is error
    assert ws.schemas.get.call_args_list == [SCHEMA_GET] * 2  # probe + re-probe
    assert "sp-client-123" in msg
    assert "USE_CATALOG" in msg and "CREATE_SCHEMA" in msg
    assert "install/grant_catalog.py" in msg
    assert "x@corp.com" not in msg and "/Volumes/secret" not in msg
    ws.volumes.create.assert_not_called()


def test_helper_other_error_sanitized():
    ws = _ws()
    ws.volumes.create.side_effect = RuntimeError("boom token Bearer abc.def internal")
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    assert "boom" not in str(ei.value) and "Bearer" not in str(ei.value)


def test_helper_volume_permission_denied_names_volume_grants():
    ws = _ws()
    error = PermissionDenied("User x@corp.com lacks CREATE VOLUME")
    ws.volumes.create.side_effect = error
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    msg = str(ei.value)
    assert ei.value.step == "volume"
    assert ei.value.__cause__ is error
    assert ws.volumes.read.call_args_list == [VOLUME_READ] * 2  # probe + re-probe
    assert msg == (
        f"The app can't create the `vol_root` volume in '{CAT}._metamodel' (needs "
        f"USE_SCHEMA + CREATE_VOLUME on that schema). Ask a catalog owner to grant "
        f"the app's service principal (sp-client-123) those privileges, or run "
        f"`install/grant_catalog.py`."
    )
    assert "x@corp.com" not in msg
    ws.schemas.create.assert_called_once()


def test_helper_skips_existing_objects():
    ws = _ws()
    ws.schemas.get.side_effect = None
    ws.volumes.read.side_effect = None
    assert ensure_metamodel_schema_and_volume(ws, CAT) == []
    ws.schemas.create.assert_not_called()
    ws.volumes.create.assert_not_called()
    assert ws.schemas.get.call_args_list == [SCHEMA_GET]
    assert ws.volumes.read.call_args_list == [VOLUME_READ]


@pytest.mark.parametrize("step", ["schema", "volume"])
def test_helper_probe_unexpected_error_raises_generic(step):
    ws = _ws()
    error = RuntimeError("probe blew up Bearer abc.def")
    if step == "schema":
        ws.schemas.get.side_effect = error
    else:
        ws.volumes.read.side_effect = error
    with pytest.raises(MetamodelSetupError) as ei:
        ensure_metamodel_schema_and_volume(ws, CAT)
    msg = str(ei.value)
    assert ei.value.step == step
    assert ei.value.__cause__ is error
    assert msg.startswith("Couldn't set up `_metamodel`")
    assert "Bearer" not in msg
    if step == "schema":
        assert "USE_CATALOG + CREATE_SCHEMA" in msg
        ws.schemas.create.assert_not_called()
        ws.volumes.create.assert_not_called()
    else:
        assert f"USE_SCHEMA + CREATE_VOLUME on '{CAT}._metamodel'" in msg
        ws.schemas.create.assert_called_once()
        ws.volumes.create.assert_not_called()


def test_metamodel_setup_imports_only_stdlib_and_sdk():
    # install/grant_catalog.py loads this module by file path in an operator env
    # where only the stdlib and databricks.sdk are guaranteed.
    tree = ast.parse(Path(metamodel_setup.__file__).read_text())
    roots = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.ImportFrom):
            assert node.level == 0, f"relative import: from {'.' * node.level}{node.module or ''}"
            roots.add(node.module.split(".")[0])
        elif isinstance(node, ast.Import):
            roots.update(alias.name.split(".")[0] for alias in node.names)
    allowed = set(sys.stdlib_module_names) | {"__future__", "databricks"}
    assert roots <= allowed, roots - allowed


# --- check ------------------------------------------------------------------

def test_check_validate_path_warns_and_creates_nothing():
    ws = _ws()
    issue = _check_metamodel_schema_present(_run(), None, ws)
    assert issue.severity == "warning"
    assert issue.field_path == "catalog"
    assert issue.message == f"`_metamodel` will be set up in '{CAT}' when you start the run."
    ws.schemas.create.assert_not_called()
    ws.volumes.create.assert_not_called()


def test_check_present_metamodel_is_noop():
    ws = _ws(schemas=("default", "_metamodel"))
    assert _check_metamodel_schema_present(_run(), None, ws) is None
    ws.schemas.create.assert_not_called()


def test_check_other_intent_keeps_original_blocker():
    ws = _ws()
    issue = _check_metamodel_schema_present(_run(Intent.INSTALL), None, ws)
    assert issue.severity == "blocker"
    assert "has no `_metamodel` schema" in issue.message
    ws.schemas.create.assert_not_called()


def test_check_lenient_skips_unchanged():
    assert _check_metamodel_schema_present(_run(), None, None) is None
    ws = _ws()
    ws.schemas.list.side_effect = RuntimeError("auth")
    assert _check_metamodel_schema_present(_run(), None, ws) is None
    assert _check_metamodel_schema_present(_run(), None, _ws(schemas=())) is None
    ws.schemas.create.assert_not_called()


# --- route preflight --------------------------------------------------------

@pytest.fixture
def biz_id(engine):
    with Session(engine) as s:
        ind = Industry(name="Test", short_name="test", description="x")
        s.add(ind)
        s.flush()
        b = Business(name="autosetup-biz", description="t", industry_id=ind.id)
        s.add(b)
        s.add(AgentConfig(
            notebook_path="/Workspace/agent.ipynb", deployment_catalog="metamodel_cat",
            warehouse_id="wh-1", job_id=1, job_name="dbx_test",
        ))
        s.commit()
        return b.id


_BODY = {"intent": "new-base-model", "catalog": CAT, "cataloging_style": "One Catalog"}


def test_validate_endpoint_warns_without_creating(client, biz_id, mock_ws):
    stub_no_metamodel(mock_ws)
    resp = client.post(f"/api/businesses/{biz_id}/runs/validate", json=_BODY)
    assert resp.status_code == 200, resp.text
    body = resp.json()
    assert not any("_metamodel" in b["message"] for b in body["blockers"]), body
    assert any(
        w["field_path"] == "catalog" and "will be set up" in w["message"]
        for w in body["warnings"]
    ), body
    mock_ws.schemas.create.assert_not_called()
    mock_ws.volumes.create.assert_not_called()


def _run_count(engine, biz_id):
    with Session(engine) as s:
        return len(s.exec(select(Run).where(Run.business_id == biz_id)).all())


def test_create_endpoint_sets_up_metamodel(client, biz_id, mock_ws):
    stub_no_metamodel(mock_ws)
    resp = client.post(f"/api/businesses/{biz_id}/runs", json=_BODY)
    assert resp.status_code == 200, resp.text
    mock_ws.schemas.create.assert_called_once_with(name="_metamodel", catalog_name=CAT)
    mock_ws.volumes.create.assert_called_once()


def test_create_endpoint_metamodel_already_exists_ok(client, biz_id, mock_ws):
    stub_no_metamodel(mock_ws)
    # Live workspace shapes; absent on the probe, present on the re-probe.
    mock_ws.schemas.get.side_effect = [NotFound("no schema"), None]
    mock_ws.volumes.read.side_effect = [NotFound("no volume"), None]
    mock_ws.schemas.create.side_effect = _schema_exists_error()
    mock_ws.volumes.create.side_effect = ResourceAlreadyExists("exists")
    resp = client.post(f"/api/businesses/{biz_id}/runs", json=_BODY)
    assert resp.status_code == 200, resp.text
    assert mock_ws.schemas.get.call_args_list == [SCHEMA_GET] * 2
    assert mock_ws.volumes.read.call_args_list == [VOLUME_READ] * 2


def test_create_endpoint_permission_denied_is_400(client, engine, biz_id, mock_ws):
    stub_no_metamodel(mock_ws)
    mock_ws.config.client_id = "sp-client-123"
    mock_ws.schemas.create.side_effect = PermissionDenied("nope at /Workspace/a/b")
    resp = client.post(f"/api/businesses/{biz_id}/runs", json=_BODY)
    assert resp.status_code == 400, resp.text
    detail = resp.json()["detail"]
    assert "can't create `_metamodel`" in detail
    assert "sp-client-123" in detail
    assert "/Workspace" not in detail
    assert _run_count(engine, biz_id) == 0


def _empty_description(engine, biz_id, mock_ws):
    with Session(engine) as s:
        b = s.get(Business, biz_id)
        b.description = ""
        s.add(b)
        s.commit()
    return _BODY


def _notebook_unreadable(engine, biz_id, mock_ws):
    mock_ws.workspace.get_status.side_effect = PermissionDenied("no notebook access")
    return _BODY


def _next_vibe_ids_without_version(engine, biz_id, mock_ws):
    return {**_BODY, "next_vibe_ids": ["vibe-1"]}


@pytest.mark.parametrize(
    "refuse",
    [_empty_description, _notebook_unreadable, _next_vibe_ids_without_version],
    ids=["empty-description", "notebook-access", "next-vibe-ids-without-version"],
)
def test_create_endpoint_refused_run_does_not_set_up_metamodel(
    client, engine, biz_id, mock_ws, monkeypatch, refuse
):
    stub_no_metamodel(mock_ws)
    spy = MagicMock()
    monkeypatch.setattr(vibe_modeling.backend.router, "ensure_metamodel_schema_and_volume", spy)
    body = refuse(engine, biz_id, mock_ws)
    resp = client.post(f"/api/businesses/{biz_id}/runs", json=body)
    assert resp.status_code == 400, resp.text
    assert spy.call_count == 0
