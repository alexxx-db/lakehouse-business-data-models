"""``sync_assessment_job`` (the one writer of the job folder, job and runs-volume grants) and the boot sync."""
from __future__ import annotations

import asyncio
import os
import sys
from types import SimpleNamespace as NS
from unittest.mock import MagicMock

import pytest
from databricks.sdk.errors.platform import NotFound, PermissionDenied
from databricks.sdk.service.iam import User
from databricks.sdk.service.workspace import ObjectType
from sqlmodel import Session, select

sys.path.insert(0, os.path.dirname(__file__))

from _assess_helpers import _eff, seed_domain_run  # noqa: E402
from vibe_modeling.backend.assessment.config_service import assess_ready, record_sync_failure, sync_and_commit  # noqa: E402
from vibe_modeling.backend.assessment.job_sync import prune_job_folders, sync_assessment_job  # noqa: E402
from vibe_modeling.backend.core._assess_init import _AssessInitDependency, run_assess_boot_sync  # noqa: E402
from vibe_modeling.backend.db_models import AssessConfig, AssessDomainRun  # noqa: E402

ROOT = "/Users/app-sp/vibe-assess"
CAT = "cat"
VOL = f"{CAT}._metamodel.assess_runs"


def _ws(*, effective=None, volume_exists=False, folders=()):
    ws = MagicMock()
    ws.current_user.me.return_value = User(user_name="app-sp")
    ws.workspace.get_status.return_value.object_id = 42
    ws.workspace.list.return_value = [NS(path=f"{ROOT}/{f}", object_type=ObjectType.DIRECTORY) for f in folders]
    if not volume_exists:
        ws.volumes.read.side_effect = NotFound("no volume")
    ws.grants.get_effective.side_effect = effective or (lambda *a, **k: _eff())
    ws.jobs.create.return_value.job_id = 77
    ws.service_principals.list.return_value = [NS(application_id="reader-1", display_name="Reader One")]
    return ws


def _cfg(**kw):
    return AssessConfig(**{"reader_application_id": "reader-1", "max_concurrent_runs": 2, **kw})


def _grants(ws):
    return {(c.args[0], c.args[1]): [p.value for p in c.kwargs["changes"][0].add] for c in ws.grants.update.call_args_list}


def _sync(engine, ws, cfg, version="0.8.0"):
    with Session(engine) as s:
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, version, deployment_catalog=CAT)
        s.commit(); s.refresh(cfg)
        return res, cfg


def test_sync_uploads_to_app_sp_home_and_grants_reader_can_read(engine):
    ws = _ws()
    res, cfg = _sync(engine, ws, _cfg())
    assert res.ok and res.workspace_path == f"{ROOT}/0.8.0"
    uploaded = {c.args[0] for c in ws.workspace.upload.call_args_list}
    assert f"{ROOT}/0.8.0/assess_domain" in uploaded
    acl = ws.permissions.update.call_args.kwargs["access_control_list"][0]
    assert ws.permissions.update.call_args.args == ("directories", "42")
    assert acl.service_principal_name == "reader-1" and acl.permission_level.value == "CAN_READ"
    nb = ws.jobs.create.call_args.kwargs["tasks"][0].notebook_task.notebook_path
    assert nb == f"{ROOT}/0.8.0/assess_domain"
    assert (cfg.job_id, cfg.synced_version, cfg.job_reader, cfg.workspace_path, cfg.job_setup_error) == (
        77, "0.8.0", "reader-1", f"{ROOT}/0.8.0", "")
    assert cfg.reader_display_name == "Reader One"  # stored so Settings needs no SCIM call per read


def test_sync_ensures_both_metamodel_volumes_and_grants_only_what_is_missing(engine):
    """The sync can be the first thing to create ``_metamodel``, so it ensures ``vol_root``
    (the model runs' volume) as well as ``assess_runs``."""
    ws = _ws()
    _sync(engine, ws, _cfg())
    created = [c.kwargs for c in ws.volumes.create.call_args_list]
    assert [(k["catalog_name"], k["schema_name"], k["name"]) for k in created] == [
        (CAT, "_metamodel", "vol_root"), (CAT, "_metamodel", "assess_runs")]
    assert _grants(ws) == {("volume", VOL): ["READ_VOLUME", "WRITE_VOLUME"], ("schema", f"{CAT}._metamodel"): ["USE_SCHEMA"]}
    assert not any(c.args[0] == "catalog" for c in ws.grants.update.call_args_list)


def test_sync_skips_existing_grants_and_volume(engine):
    def eff(securable, name, principal=None):
        return _eff("READ_VOLUME", "WRITE_VOLUME") if securable == "volume" else _eff("USE_SCHEMA")
    ws = _ws(effective=eff, volume_exists=True)
    res, _ = _sync(engine, ws, _cfg())
    assert res.ok
    ws.volumes.create.assert_not_called()
    ws.grants.update.assert_not_called()


def test_sync_grants_only_the_missing_privilege(engine):
    def eff(securable, name, principal=None):
        return _eff("READ_VOLUME") if securable == "volume" else _eff("ALL_PRIVILEGES")
    ws = _ws(effective=eff, volume_exists=True)
    _sync(engine, ws, _cfg())
    assert _grants(ws) == {("volume", VOL): ["WRITE_VOLUME"]}


def test_sync_unreadable_privileges_count_as_missing(engine):
    def eff(*a, **k):
        raise PermissionDenied("cannot read grants")
    ws = _ws(effective=eff, volume_exists=True)
    _sync(engine, ws, _cfg())
    assert _grants(ws) == {("volume", VOL): ["READ_VOLUME", "WRITE_VOLUME"], ("schema", f"{CAT}._metamodel"): ["USE_SCHEMA"]}


def test_sync_resets_an_existing_job(engine):
    ws = _ws()
    res, cfg = _sync(engine, ws, _cfg(job_id=5))
    assert res.ok and cfg.job_id == 5
    ws.jobs.reset.assert_called_once()
    assert ws.jobs.reset.call_args.kwargs["new_settings"].run_as.service_principal_name == "reader-1"
    ws.jobs.create.assert_not_called()


class _StatefulWs:
    """A workspace client that remembers what the sync wrote, so a second sync can read it back."""

    def __init__(self):
        from databricks.sdk.service.jobs import JobSettings
        self.files: dict[str, bytes] = {}
        self.acl: list = []
        self.jobs_by_id: dict[int, object] = {}
        self.privs: set[str] = set()
        self.volumes: set[str] = set()
        self.ws = MagicMock()
        w = self.ws
        w.current_user.me.return_value = User(user_name="app-sp")
        w.service_principals.list.return_value = [NS(application_id="reader-1", display_name="Reader One")]
        w.workspace.list.return_value = []
        w.workspace.get_status.return_value.object_id = 42

        def download(path, format=None):
            if path not in self.files:
                raise NotFound(path)
            return NS(read=lambda: self.files[path])
        w.workspace.download.side_effect = download
        w.workspace.upload.side_effect = lambda path, data, **k: self.files.__setitem__(path, data.read())
        w.permissions.get.side_effect = lambda *a: NS(access_control_list=self.acl)

        def update_perms(kind, oid, access_control_list):
            self.acl = [NS(service_principal_name=r.service_principal_name,
                           all_permissions=[NS(permission_level=r.permission_level)]) for r in access_control_list]
        w.permissions.update.side_effect = update_perms

        def read_volume(name):
            if name not in self.volumes:
                raise NotFound(name)
        w.volumes.read.side_effect = read_volume
        w.volumes.create.side_effect = lambda **k: self.volumes.add(f"{k['catalog_name']}.{k['schema_name']}.{k['name']}")
        w.grants.get_effective.side_effect = lambda *a, **k: _eff(*self.privs)
        w.grants.update.side_effect = lambda t, n, changes: self.privs.update(p.value for p in changes[0].add)

        def create(**settings):
            self.jobs_by_id[77] = JobSettings(**settings)
            return NS(job_id=77)
        w.jobs.create.side_effect = create
        w.jobs.reset.side_effect = lambda job_id, new_settings: self.jobs_by_id.__setitem__(job_id, new_settings)
        w.jobs.get.side_effect = lambda job_id: NS(settings=self.jobs_by_id[job_id], run_as_user_name="reader-1")

    WRITES = ("workspace.upload", "workspace.mkdirs", "workspace.delete", "permissions.update", "volumes.create",
              "schemas.create", "grants.update", "jobs.create", "jobs.reset")

    def writes(self) -> dict[str, int]:
        out = {}
        for w in self.WRITES:
            obj = self.ws
            for part in w.split("."):
                obj = getattr(obj, part)
            if obj.call_count:
                out[w] = obj.call_count
        return out


def test_sync_is_check_then_act_a_second_sync_writes_nothing(engine):
    fake = _StatefulWs()
    res1, cfg = _sync(engine, fake.ws, _cfg())
    assert res1.ok and {"workspace.upload", "permissions.update", "volumes.create", "grants.update",
                        "jobs.create"} <= set(fake.writes())
    fake.ws.reset_mock(return_value=False, side_effect=False)
    with Session(engine) as s:
        cfg = s.get(AssessConfig, cfg.id)
        res2 = sync_assessment_job(s, fake.ws, cfg, "0.8.0", deployment_catalog=CAT)
        s.commit(); s.refresh(cfg)
    assert res2.ok and cfg.job_id == 77
    assert fake.writes() == {}


def test_a_changed_setting_resets_only_the_job(engine):
    fake = _StatefulWs()
    _, cfg = _sync(engine, fake.ws, _cfg())
    fake.ws.reset_mock(return_value=False, side_effect=False)
    with Session(engine) as s:
        cfg = s.get(AssessConfig, cfg.id)
        cfg.max_concurrent_runs = 4
        assert sync_assessment_job(s, fake.ws, cfg, "0.8.0", deployment_catalog=CAT).ok
    assert fake.writes() == {"jobs.reset": 1}


def test_a_new_version_uploads_again_and_repoints_the_job(engine):
    fake = _StatefulWs()
    _, cfg = _sync(engine, fake.ws, _cfg())
    fake.ws.reset_mock(return_value=False, side_effect=False)
    with Session(engine) as s:
        cfg = s.get(AssessConfig, cfg.id)
        assert sync_assessment_job(s, fake.ws, cfg, "0.8.1", deployment_catalog=CAT).ok
    w = fake.writes()
    assert w["jobs.reset"] == 1 and w["workspace.upload"] > 1 and "jobs.create" not in w
    assert fake.jobs_by_id[77].tasks[0].notebook_task.notebook_path == f"{ROOT}/0.8.1/assess_domain"


def test_reader_with_inherited_read_gets_no_folder_grant(engine):
    ws = _ws()
    ws.permissions.get.return_value = NS(access_control_list=[
        NS(service_principal_name="reader-1", all_permissions=[NS(permission_level=NS(value="CAN_MANAGE"))])])
    _sync(engine, ws, _cfg())
    ws.permissions.update.assert_not_called()


def test_reset_failure_rereads_the_job_and_prunes_nothing(engine):
    ws = _ws(folders=("0.5.0", "0.6.0", "0.7.0"))
    ws.jobs.reset.side_effect = PermissionDenied("not servicePrincipal.user")
    ws.jobs.get.return_value = NS(settings=NS(run_as=NS(service_principal_name="old-reader"),
                                              tasks=[NS(notebook_task=NS(notebook_path=f"{ROOT}/0.7.0/assess_domain"))]),
                                  run_as_user_name="old-reader")
    with Session(engine) as s:
        cfg = _cfg(job_id=5)
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=CAT)
    assert not res.ok
    assert res.error.startswith("Resetting or creating the assessment job failed: PermissionDenied: ")
    assert (res.reread.job_id, res.reread.job_reader, res.reread.workspace_path) == (5, "old-reader", f"{ROOT}/0.7.0")
    ws.jobs.create.assert_not_called()  # a reset error is raised, not replaced
    ws.workspace.delete.assert_not_called()


def test_upload_failure_records_the_step(engine):
    ws = _ws()
    ws.workspace.upload.side_effect = PermissionDenied("no write on home")
    with Session(engine) as s:
        cfg = _cfg()
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=CAT)
    assert not res.ok and res.error.startswith("Uploading the assessment notebook failed: PermissionDenied")
    assert res.reread.job_id is None
    ws.jobs.create.assert_not_called(); ws.grants.update.assert_not_called()


def test_volume_failure_names_the_runs_volume(engine):
    ws = _ws()

    def create(**k):
        if k["name"] == "assess_runs":
            raise PermissionDenied("no CREATE VOLUME")
    ws.volumes.create.side_effect = create
    with Session(engine) as s:
        cfg = _cfg()
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=CAT)
    assert not res.ok and f"Creating {CAT}._metamodel and its volumes vol_root and assess_runs failed" in res.error and "`assess_runs`" in res.error


@pytest.mark.parametrize("reader,catalog,needle", [("reader-1", "", "deployment catalog is not configured"),
                                                     ("", CAT, "No reader service principal")])
def test_input_checks_fail_before_any_write(engine, reader, catalog, needle):
    ws = _ws()
    with Session(engine) as s:
        cfg = _cfg(reader_application_id=reader)
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=catalog)
    assert not res.ok and res.error.startswith("Checking the assessment settings failed") and needle in res.error
    ws.workspace.upload.assert_not_called(); ws.workspace.mkdirs.assert_not_called()
    ws.permissions.update.assert_not_called(); ws.jobs.create.assert_not_called()


def test_prune_keeps_current_previous_and_folders_of_live_runs(engine):
    folders = ("0.5.0", "0.6.0", "0.7.0", "0.7.3", "0.7.3.post2", "0.8.0", "notes")
    ws = _ws(folders=folders)
    live = seed_domain_run(engine, status="queued")
    done = seed_domain_run(engine, status="completed")
    with Session(engine) as s:
        for dr_id, folder in ((live, f"/Workspace{ROOT}/0.5.0"), (done, f"{ROOT}/0.6.0")):
            dr = s.get(AssessDomainRun, dr_id); dr.notebook_folder = folder; s.add(dr)
        s.commit()
        deleted = prune_job_folders(s, ws, ROOT, "0.8.0")
    assert deleted == [f"{ROOT}/0.6.0", f"{ROOT}/0.7.0", f"{ROOT}/0.7.3"]
    assert all(c.kwargs == {"recursive": True} for c in ws.workspace.delete.call_args_list)


def _pruned(engine, folders, current):
    ws = _ws(folders=folders)
    with Session(engine) as s:
        return [d.rsplit("/", 1)[-1] for d in prune_job_folders(s, ws, ROOT, current)]


def test_prune_never_touches_names_that_are_not_versions(engine):
    names = ("2024-backup", "3d-assets", "1password", "v0.8", "0.8", "notes", "0.7.3.postx", "0.7.3-rc1")
    assert _pruned(engine, names + ("0.6.0", "0.7.0", "0.8.0"), "0.8.0") == ["0.6.0"]


def test_prune_keeps_every_folder_at_or_above_the_current_version(engine):
    assert _pruned(engine, ("0.6.0", "0.7.0", "0.8.0", "0.8.1", "0.9.0"), "0.8.0") == ["0.6.0"]


def test_prune_orders_post_and_rc_releases_numerically(engine):
    assert _pruned(engine, ("0.7.3.post9", "0.7.3.post10", "0.7.3.post2", "0.8.0"), "0.8.0") == [
        "0.7.3.post2", "0.7.3.post9"]
    assert _pruned(engine, ("0.8.0rc1", "0.8.0rc2", "0.7.9", "0.8.0"), "0.8.0") == ["0.7.9", "0.8.0rc1"]
    assert _pruned(engine, ("0.8.0.9", "0.8.0.10", "0.8.0.2", "0.8.1"), "0.8.1") == ["0.8.0.2", "0.8.0.9"]


def test_prune_does_nothing_when_the_current_version_is_not_a_version(engine):
    assert _pruned(engine, ("0.6.0", "0.7.0"), "local-build") == []


def test_prune_is_best_effort(engine, monkeypatch):
    ws = _ws(folders=("0.6.0", "0.7.0", "0.8.0"))
    with Session(engine) as s:
        monkeypatch.setattr(s, "exec", lambda *a, **k: (_ for _ in ()).throw(RuntimeError("db gone")))
        assert prune_job_folders(s, ws, ROOT, "0.8.0") == []
    ws.workspace.list.side_effect = ConnectionError("transport")
    with Session(engine) as s:
        assert prune_job_folders(s, ws, ROOT, "0.8.0") == []


def test_prune_runs_only_after_a_clean_sync(engine):
    ws = _ws(folders=("0.6.0", "0.7.0", "0.8.0"))
    res, _ = _sync(engine, ws, _cfg())
    assert res.ok and [c.args[0] for c in ws.workspace.delete.call_args_list] == [f"{ROOT}/0.6.0"]


def test_record_sync_failure_commits_error_and_reread_state(engine):
    from vibe_modeling.backend.assessment.job_sync import JobState, SyncResult
    with Session(engine) as s:
        s.add(AssessConfig(reader_application_id="r", job_id=5, job_reader="r", workspace_path="/old")); s.commit()
    record_sync_failure(engine, SyncResult(ok=False, error="boom", reread=JobState(None, "", "")))
    with Session(engine) as s:
        cfg = s.exec(select(AssessConfig)).one()
    assert (cfg.job_setup_error, cfg.job_id, cfg.job_reader, cfg.workspace_path) == ("boom", None, "", "")


def test_record_sync_failure_keeps_stored_job_when_unreadable(engine):
    from vibe_modeling.backend.assessment.job_sync import SyncResult
    with Session(engine) as s:
        s.add(AssessConfig(reader_application_id="r", job_id=5, job_reader="r")); s.commit()
    record_sync_failure(engine, SyncResult(ok=False, error="boom", reread=None))
    with Session(engine) as s:
        cfg = s.exec(select(AssessConfig)).one()
    assert (cfg.job_setup_error, cfg.job_id, cfg.job_reader) == ("boom", 5, "r")


# --- boot ---


def _row(engine):
    with Session(engine) as s:
        return s.exec(select(AssessConfig)).first()


def test_boot_seeds_a_new_row_and_syncs(engine, config):
    config.assess_reader_sp = "install-reader"
    ws = _ws()
    run_assess_boot_sync(engine, ws, config, "0.8.0")
    row = _row(engine)
    assert (row.reader_application_id, row.job_reader, row.synced_version, row.job_id) == (
        "install-reader", "install-reader", "0.8.0", 77)


def test_boot_fills_an_empty_existing_reader(engine, config):
    with Session(engine) as s:
        s.add(AssessConfig(reader_application_id="")); s.commit()
    config.assess_reader_sp = "install-reader"
    run_assess_boot_sync(engine, _ws(), config, "0.8.0")
    assert _row(engine).reader_application_id == "install-reader"


def test_boot_keeps_the_settings_reader(engine, config):
    with Session(engine) as s:
        s.add(AssessConfig(reader_application_id="settings-reader")); s.commit()
    config.assess_reader_sp = "install-reader"
    run_assess_boot_sync(engine, _ws(), config, "0.8.0")
    assert _row(engine).reader_application_id == "settings-reader"


def test_boot_skips_the_sync_without_a_reader(engine, config):
    ws = _ws()
    run_assess_boot_sync(engine, ws, config, "0.8.0")
    ws.workspace.upload.assert_not_called(); ws.jobs.create.assert_not_called()
    assert _row(engine).job_setup_error == ""


def test_boot_records_a_failed_sync(engine, config):
    config.assess_reader_sp = "install-reader"
    ws = _ws()
    ws.jobs.create.side_effect = PermissionDenied("not servicePrincipal.user")
    run_assess_boot_sync(engine, ws, config, "0.8.0")
    row = _row(engine)
    assert "servicePrincipal.user" in row.job_setup_error and row.synced_version == "" and row.job_id is None


@pytest.mark.parametrize("enabled", [False, True])
def test_lifespan_runs_the_boot_sync_only_when_installed(engine, config, monkeypatch, enabled):
    from vibe_modeling.backend.core import _assess_init
    calls = []
    monkeypatch.setattr(_assess_init, "run_assess_boot_sync", lambda *a: calls.append(a))
    config.assessment_enabled = enabled
    app = NS(state=NS(config=config, engine=engine, workspace_client=MagicMock()))

    async def go():
        async with _AssessInitDependency().lifespan(app):
            pass
    asyncio.run(go())
    assert len(calls) == (1 if enabled else 0)


def test_lifespan_survives_a_crashing_boot_sync(engine, config, monkeypatch):
    from vibe_modeling.backend.core import _assess_init

    def boom(*a):
        raise RuntimeError("db down")
    monkeypatch.setattr(_assess_init, "run_assess_boot_sync", boom)
    app = NS(state=NS(config=config, engine=engine, workspace_client=MagicMock()))

    async def go():
        async with _AssessInitDependency().lifespan(app):
            return "booted"
    assert asyncio.run(go()) == "booted"


def test_a_reader_that_does_not_resolve_fails_the_settings_check_with_the_save_message(engine):
    ws = _ws()
    ws.service_principals.list.return_value = []
    with Session(engine) as s:
        cfg = _cfg(reader_application_id="vibe-assess-reader")
        s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_and_commit(s, ws, cfg, deployment_catalog=CAT, app_version="0.8.0")
    msg = "Service principal with application ID 'vibe-assess-reader' not found in this workspace."
    assert not res.ok and res.error.startswith("Checking the assessment settings failed") and msg in res.error
    ws.workspace.upload.assert_not_called(); ws.jobs.create.assert_not_called(); ws.jobs.reset.assert_not_called()
    with Session(engine) as s:
        ready, missing = assess_ready(s.exec(select(AssessConfig)).one(), installed=True)
    assert not ready and any(msg in m for m in missing)


def test_a_reader_resolved_by_save_is_not_looked_up_again(engine):
    ws = _ws()
    with Session(engine) as s:
        cfg = _cfg(); s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=CAT,
                                  reader_sp=NS(application_id="reader-1", display_name="From Save"))
        assert res.ok and cfg.reader_display_name == "From Save"
    ws.service_principals.list.assert_not_called()


def test_a_resolved_sp_for_another_reader_is_ignored(engine):
    ws = _ws()
    with Session(engine) as s:
        cfg = _cfg(); s.add(cfg); s.commit(); s.refresh(cfg)
        res = sync_assessment_job(s, ws, cfg, "0.8.0", deployment_catalog=CAT,
                                  reader_sp=NS(application_id="someone-else", display_name="Wrong"))
        assert res.ok and cfg.reader_display_name == "Reader One"
    ws.service_principals.list.assert_called_once()


def test_an_unreadable_reader_lookup_does_not_block_the_sync(engine):
    ws = _ws()
    ws.service_principals.list.side_effect = PermissionDenied("scim")
    res, cfg = _sync(engine, ws, _cfg())
    assert res.ok and cfg.reader_display_name == ""
