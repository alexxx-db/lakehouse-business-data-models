import threading
import time
from datetime import datetime, timedelta, timezone

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient
from sqlalchemy.pool import StaticPool
from sqlmodel import Session, SQLModel, create_engine

from vibe_modeling.backend.core._config import AppConfig
from vibe_modeling.backend.core._defaults import _ConfigDependency
from vibe_modeling.backend.core._identity import LOCAL_DEV_IDENTITY
from vibe_modeling.backend.core._roles import UserRole, resolve_user_role
from vibe_modeling.backend.core.lakebase import _LakebaseDependency
from vibe_modeling.backend.db_models import AgentConfig
from vibe_modeling.backend.routes import taxonomy as taxonomy_routes
from vibe_modeling.backend.taxonomy import llm as llm_module
from vibe_modeling.backend.taxonomy.access import MODEL_SERVICE_ACCESS, PASSED_TTL
from vibe_modeling.backend.taxonomy.drafts import BUSY_ERROR, WAITING_FOR_TREE, DraftStore
from vibe_modeling.backend.taxonomy.example import load_ridgeline_example
from vibe_modeling.backend.taxonomy.llm import ProbeResult, TaxonomyLLMError
from vibe_modeling.backend.taxonomy.models import SECTION_HEADINGS, SECTION_KEYS, TaxonomyTree

EX = load_ridgeline_example()
SERVICE = "main.ai.drafter"
CONDENSE_BODY = {
    "intake": {"company_name": "Ridgeline Energy", "industry": "Utility"},
    "tree": EX.tree.model_dump(),
    "sections": {k: v.model_dump() for k, v in EX.sections.items()},
}


class FakeLLM:
    def __init__(self, fail_once=(), probe=("ok", "answered")):
        self.fail_once = set(fail_once)
        self.model_service = SERVICE
        self.probe_result = ProbeResult(*probe)
        self.probes = 0

    def probe(self):
        self.probes += 1
        return self.probe_result

    def complete_json(self, system, user, model):
        if model is TaxonomyTree:
            return EX.tree
        key = next(k for k in SECTION_KEYS if f"'{SECTION_HEADINGS[k]}'" in system)
        if key in self.fail_once:
            self.fail_once.discard(key)
            raise TaxonomyLLMError("boom")
        return EX.sections[key]

    def complete_text(self, system, user):
        return "Ridgeline is a regional utility."


@pytest.fixture(autouse=True)
def _fresh_access_cache():
    MODEL_SERVICE_ACCESS.clear()
    yield
    MODEL_SERVICE_ACCESS.clear()


def _make_tc(
    role: UserRole = UserRole.APP_ADMIN, llm=None, *, installed: bool = True,
    model_service: str = SERVICE, store: DraftStore | None = None,
) -> TestClient:
    """Own app so the LLM + store are injectable. The install flag is on and
    the AgentConfig row carries a model service unless told otherwise. Use as
    `with _make_tc() as c:` so the event loop (and background tasks) outlive
    each request."""
    app = FastAPI()
    app.include_router(taxonomy_routes.router)
    engine = create_engine("sqlite://", connect_args={"check_same_thread": False}, poolclass=StaticPool)
    SQLModel.metadata.create_all(engine)
    with Session(engine) as s:
        s.add(AgentConfig(taxonomy_model_service=model_service))
        s.commit()
    config = AppConfig(taxonomy_builder_enabled=installed)
    store = store if store is not None else DraftStore()
    llm = llm or FakeLLM()

    def _session():
        with Session(engine) as s:
            yield s

    app.dependency_overrides[_LakebaseDependency.__call__] = _session
    app.dependency_overrides[_ConfigDependency.__call__] = lambda: config
    app.dependency_overrides[taxonomy_routes.get_taxonomy_llm] = lambda: llm
    app.dependency_overrides[taxonomy_routes.get_draft_store] = lambda: store
    # Pin the resolved role (codebase pattern: test_regression_hardening._make_test_client)
    # so the BusinessAdminOnly guard runs for real without a SCIM lookup.
    app.dependency_overrides[resolve_user_role] = lambda: role
    return TestClient(app)


@pytest.fixture
def tc():
    with _make_tc() as c:
        yield c


A = {"X-Forwarded-Email": "a@x.com"}
B = {"X-Forwarded-Email": "b@x.com"}


def _poll(tc, did, headers=A, timeout=5):
    deadline = time.time() + timeout
    while time.time() < deadline:
        r = tc.get(f"/api/taxonomy/drafts/{did}", headers=headers)
        if r.json()["status"] != "running":
            return r.json()
        time.sleep(0.05)
    raise AssertionError("draft never finished")


def test_create_and_poll_draft(tc):
    r = tc.post("/api/taxonomy/drafts", json={"company_name": "Acme", "industry": "Utility"}, headers=A)
    assert r.status_code == 200
    out = _poll(tc, r.json()["draft_id"])
    assert out["status"] == "done"
    assert out["parts"]["tree"]["tree"]["domains"][0]["name"] == "Customer & Premise"


def test_create_rejects_bad_company_name(tc):
    r = tc.post("/api/taxonomy/drafts", json={"company_name": "Acme / Gas", "industry": "U"}, headers=A)
    assert r.status_code == 422


def test_other_user_cannot_read_or_cancel(tc):
    did = tc.post("/api/taxonomy/drafts", json={"company_name": "Acme", "industry": "U"}, headers=A).json()["draft_id"]
    assert tc.get(f"/api/taxonomy/drafts/{did}", headers=B).status_code == 404
    assert tc.post(f"/api/taxonomy/drafts/{did}/cancel", headers=B).status_code == 404
    assert tc.post(f"/api/taxonomy/drafts/{did}/parts/tree/retry", headers=B).status_code == 404


INTAKE_ACME = {"company_name": "Acme", "industry": "U"}


@pytest.fixture
def _outside_apps_runtime(monkeypatch):
    monkeypatch.delenv("DATABRICKS_APP_NAME", raising=False)
    monkeypatch.delenv("LOCAL_DEV_USER", raising=False)


@pytest.mark.usefixtures("_outside_apps_runtime")
def test_draft_owner_is_the_canonical_email_first_identity():
    store = DraftStore()
    both = {"X-Forwarded-Email": "a@x.com", "X-Forwarded-Preferred-Username": "alice"}
    with _make_tc(store=store) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE_ACME, headers=both).json()["draft_id"]
        assert store.get(did, "a@x.com") is not None
        assert c.get(f"/api/taxonomy/drafts/{did}", headers=A).status_code == 200
        alias_only = {"X-Forwarded-Preferred-Username": "alice"}
        assert c.get(f"/api/taxonomy/drafts/{did}", headers=alias_only).status_code == 404


@pytest.mark.usefixtures("_outside_apps_runtime")
def test_headerless_draft_outside_apps_is_owned_by_local_dev():
    store = DraftStore()
    with _make_tc(store=store) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE_ACME).json()["draft_id"]
        assert store.get(did, LOCAL_DEV_IDENTITY) is not None
        assert c.get(f"/api/taxonomy/drafts/{did}").status_code == 200
        assert c.get(f"/api/taxonomy/drafts/{did}", headers=A).status_code == 404


def test_headerless_inside_apps_is_401_and_creates_nothing(monkeypatch):
    monkeypatch.setenv("DATABRICKS_APP_NAME", "vibe-modeling")
    monkeypatch.delenv("LOCAL_DEV_USER", raising=False)
    store = DraftStore()
    llm = FakeLLM()
    with _make_tc(llm=llm, store=store) as c:
        assert c.post("/api/taxonomy/drafts", json=INTAKE_ACME).status_code == 401
        assert c.post("/api/taxonomy/condense", json=CONDENSE_BODY).status_code == 401
        assert c.get("/api/taxonomy/drafts/x").status_code == 401
        assert c.post("/api/taxonomy/drafts/x/cancel").status_code == 401
        assert c.post("/api/taxonomy/drafts/x/parts/tree/retry").status_code == 401
        assert store._drafts == {}
        assert llm.probes == 0
        did =c.post("/api/taxonomy/drafts", json=INTAKE_ACME, headers=A).json()["draft_id"]
        assert store.get(did, "a@x.com") is not None


def test_unknown_draft_404(tc):
    assert tc.get("/api/taxonomy/drafts/nope", headers=A).status_code == 404


def test_retry_bad_part_400_and_done_part_409(tc):
    did = tc.post("/api/taxonomy/drafts", json={"company_name": "Acme", "industry": "U"}, headers=A).json()["draft_id"]
    _poll(tc, did)
    assert tc.post(f"/api/taxonomy/drafts/{did}/parts/finance/retry", headers=A).status_code == 400
    r = tc.post(f"/api/taxonomy/drafts/{did}/parts/company/retry", headers=A)
    assert r.status_code == 409
    assert "already finished" in r.json()["detail"]


def test_retry_failed_part_200():
    with _make_tc(llm=FakeLLM(fail_once={"terminology"})) as c:
        did = c.post("/api/taxonomy/drafts", json={"company_name": "Acme", "industry": "U"}, headers=A).json()["draft_id"]
        out = _poll(c, did)
        assert out["parts"]["terminology"]["status"] == "failed"
        assert c.post(f"/api/taxonomy/drafts/{did}/parts/terminology/retry", headers=A).status_code == 200
        out = _poll(c, did)
        assert out["parts"]["terminology"]["status"] == "done"
        assert out["status"] == "done"


def test_condense_route(tc):
    did = tc.post("/api/taxonomy/condense", json=CONDENSE_BODY, headers=A).json()["draft_id"]
    out = _poll(tc, did)
    assert out["parts"]["description"]["description"] == "Ridgeline is a regional utility."


def test_compile_route(tc):
    body = {"tree": EX.tree.model_dump(), "strictness": "strict", "sections": {}}
    r = tc.post("/api/taxonomy/compile", json=body, headers=A)
    assert r.status_code == 200
    assert r.json()["business_domains"].startswith("customer, billing")


def test_example_route(tc):
    r = tc.get("/api/taxonomy/example", headers=A)
    assert r.status_code == 200 and r.json()["company_name"] == "Ridgeline Energy"


@pytest.mark.parametrize("role", [UserRole.MODELER, UserRole.VIEWER])
def test_non_business_admin_gets_403_on_mutations(role):
    """Drafting spends Claude tokens toward a business only a business admin can create."""
    with _make_tc(role) as c:
        intake = {"company_name": "Acme", "industry": "U"}
        assert c.post("/api/taxonomy/drafts", json=intake, headers=A).status_code == 403
        assert c.post("/api/taxonomy/condense", json=CONDENSE_BODY, headers=A).status_code == 403
        assert c.post("/api/taxonomy/drafts/x/cancel", headers=A).status_code == 403
        assert c.post("/api/taxonomy/drafts/x/parts/tree/retry", headers=A).status_code == 403
        # Read-only routes stay open to every signed-in user.
        compile_body = {"tree": EX.tree.model_dump(), "strictness": "strict", "sections": {}}
        assert c.post("/api/taxonomy/compile", json=compile_body, headers=A).status_code == 200
        assert c.get("/api/taxonomy/example", headers=A).status_code == 200
        assert c.get("/api/taxonomy/drafts/x", headers=A).status_code == 404


def test_llm_client_uses_short_timeout_and_one_second_retry_budget(monkeypatch):
    """90 s per call caps how long an abandoned call holds a slot; a 1 s retry
    budget makes a 429/503 sleep once and surface as busy. Built once, cached,
    and pointed at the stored model service."""
    made = []

    class FakeConfig:
        def __init__(self, **kw):
            self.__dict__.update(kw)

    class FakeWS:
        def __init__(self, *, config):
            self.config = config
            made.append(self)

    monkeypatch.setattr(llm_module, "Config", FakeConfig)
    monkeypatch.setattr(llm_module, "WorkspaceClient", FakeWS)
    monkeypatch.setattr(llm_module, "_LLM_WS", None)
    settings = taxonomy_routes.TaxonomyLLMSettings(SERVICE, 6)
    llm = taxonomy_routes.get_taxonomy_llm(settings)
    assert llm._ws.config.http_timeout_seconds == 90
    assert llm._ws.config.retry_timeout_seconds == 1
    assert llm.model_service == SERVICE
    taxonomy_routes.get_taxonomy_llm(settings)
    assert len(made) == 1  # built once, then cached


# --- gating -------------------------------------------------------------------

INTAKE = {"company_name": "Acme", "industry": "Utility"}
COMPILE_BODY = {"tree": EX.tree.model_dump(), "strictness": "strict", "sections": {}}
ALL_ROUTES = [
    ("POST", "/api/taxonomy/drafts", INTAKE),
    ("GET", "/api/taxonomy/drafts/x", None),
    ("POST", "/api/taxonomy/drafts/x/cancel", None),
    ("POST", "/api/taxonomy/drafts/x/parts/tree/retry", None),
    ("POST", "/api/taxonomy/condense", CONDENSE_BODY),
    ("POST", "/api/taxonomy/compile", COMPILE_BODY),
    ("GET", "/api/taxonomy/example", None),
]
LLM_ROUTES = [
    ("POST", "/api/taxonomy/drafts", INTAKE),
    ("POST", "/api/taxonomy/drafts/x/parts/tree/retry", None),
    ("POST", "/api/taxonomy/condense", CONDENSE_BODY),
]
CREATE_ROUTES = [r for r in LLM_ROUTES if "/retry" not in r[1]]


def _call(c, method, path, body):
    return c.request(method, path, json=body, headers=A)


@pytest.mark.parametrize("method,path,body", ALL_ROUTES)
def test_not_installed_is_404_on_every_route(method, path, body):
    store = DraftStore()
    with _make_tc(installed=False, store=store) as c:
        r = _call(c, method, path, body)
    assert r.status_code == 404
    assert r.json()["detail"] == taxonomy_routes.NOT_INSTALLED_DETAIL
    assert store._drafts == {}


@pytest.mark.parametrize("method,path,body", CREATE_ROUTES)
def test_no_model_service_is_config_missing_before_any_draft(method, path, body):
    store, llm = DraftStore(), FakeLLM()
    with _make_tc(model_service="", store=store, llm=llm) as c:
        r = _call(c, method, path, body)
    assert r.status_code == 422
    detail = r.json()["detail"]
    assert detail["error"] == "config_missing"
    assert [m["key"] for m in detail["missing"]] == ["taxonomy_llm"]
    assert detail["missing"][0]["settings_url"] == "/settings?tab=platform"
    assert store._drafts == {}
    assert llm.probes == 0


def test_retry_of_a_missing_draft_is_404_before_any_probe():
    llm = FakeLLM(probe=("denied", "no"))
    with _make_tc(llm=llm) as c:
        r = c.post("/api/taxonomy/drafts/nope/parts/tree/retry", headers=A)
    assert r.status_code == 404
    assert llm.probes == 0


def test_retry_of_an_unknown_part_is_400_before_any_probe():
    llm = FakeLLM()
    with _make_tc(llm=llm) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        _poll(c, did)
        MODEL_SERVICE_ACCESS.clear()
        llm.probe_result = ProbeResult("denied", "no")
        r = c.post(f"/api/taxonomy/drafts/{did}/parts/bogus/retry", headers=A)
    assert r.status_code == 400
    assert llm.probes == 1  # only the create's probe


def test_retry_refused_by_the_probe_is_422_and_changes_nothing():
    llm = FakeLLM(fail_once={"terminology"})
    with _make_tc(llm=llm) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        assert _poll(c, did)["parts"]["terminology"]["status"] == "failed"
        MODEL_SERVICE_ACCESS.clear()
        llm.probe_result = ProbeResult("denied", "probe said denied")
        r = c.post(f"/api/taxonomy/drafts/{did}/parts/terminology/retry", headers=A)
        assert r.status_code == 422
        assert r.json()["detail"]["message"] == "probe said denied"
        assert c.get(f"/api/taxonomy/drafts/{did}", headers=A).json()["parts"]["terminology"]["status"] == "failed"


def test_retry_of_a_missing_draft_is_404_even_without_a_model_service():
    with _make_tc(model_service="") as c:
        r = c.post("/api/taxonomy/drafts/nope/parts/tree/retry", headers=A)
    assert r.status_code == 404


def test_retry_of_an_existing_draft_without_a_model_service_is_config_missing():
    store = DraftStore()
    with _make_tc(store=store, llm=FakeLLM(fail_once={"terminology"})) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        _poll(c, did)
    with _make_tc(model_service="", store=store) as c:
        r = c.post(f"/api/taxonomy/drafts/{did}/parts/terminology/retry", headers=A)
        assert c.post(f"/api/taxonomy/drafts/{did}/parts/bogus/retry", headers=A).status_code == 400
    assert r.status_code == 422
    assert r.json()["detail"]["error"] == "config_missing"


def test_compile_and_example_answer_without_a_model_service():
    with _make_tc(model_service="") as c:
        assert c.post("/api/taxonomy/compile", json=COMPILE_BODY, headers=A).status_code == 200
        assert c.get("/api/taxonomy/example", headers=A).status_code == 200


@pytest.mark.parametrize("status", ["denied", "not_found", "error"])
@pytest.mark.parametrize("method,path,body", CREATE_ROUTES)
def test_failed_probe_refuses_with_its_message_before_any_draft(status, method, path, body):
    store, llm = DraftStore(), FakeLLM(probe=(status, f"probe said {status}"))
    with _make_tc(store=store, llm=llm) as c:
        r = _call(c, method, path, body)
    assert r.status_code == 422
    detail = r.json()["detail"]
    assert detail["error"] == "config_missing"
    assert detail["message"] == f"probe said {status}"
    assert [m["key"] for m in detail["missing"]] == ["taxonomy_llm"]
    assert store._drafts == {}
    assert MODEL_SERVICE_ACCESS.last_check(SERVICE).status == status
    assert not MODEL_SERVICE_ACCESS.is_cached(SERVICE)


def test_probe_runs_once_then_is_cached():
    llm = FakeLLM()
    with _make_tc(llm=llm) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        _poll(c, did)
        c.post("/api/taxonomy/drafts", json=INTAKE, headers=A)
        c.post("/api/taxonomy/condense", json=CONDENSE_BODY, headers=A)
    assert llm.probes == 1
    assert MODEL_SERVICE_ACCESS.is_cached(SERVICE)


def test_busy_probe_creates_the_draft_and_is_not_cached():
    llm = FakeLLM(probe=("busy", "busy right now"))
    with _make_tc(llm=llm) as c:
        r = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A)
        assert r.status_code == 200
        out = _poll(c, r.json()["draft_id"])
        # The tree counts down on the client; nothing was called yet.
        assert out["status"] == "busy"
        assert out["parts"]["tree"] == {
            "status": "busy", "error": BUSY_ERROR, "tree": None, "section": None, "description": None,
        }
        assert all(out["parts"][k]["error"] == WAITING_FOR_TREE for k in SECTION_KEYS)
        c.post("/api/taxonomy/drafts", json=INTAKE, headers=A)
    assert llm.probes == 2
    assert not MODEL_SERVICE_ACCESS.is_cached(SERVICE)
    assert MODEL_SERVICE_ACCESS.last_check(SERVICE).status == "busy"


def test_retry_of_a_busy_tree_probes_again_and_drafts():
    llm = FakeLLM(probe=("busy", "busy right now"))
    with _make_tc(llm=llm) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        assert _poll(c, did)["status"] == "busy"
        llm.probe_result = ProbeResult("ok", "answered")
        assert c.post(f"/api/taxonomy/drafts/{did}/parts/tree/retry", headers=A).status_code == 200
        assert _poll(c, did)["status"] == "done"
    assert llm.probes == 2


def test_retry_of_a_running_part_is_409():
    gate = threading.Event()

    class Slow(FakeLLM):
        def complete_json(self, system, user, model):
            gate.wait(5)
            return super().complete_json(system, user, model)

    with _make_tc(llm=Slow()) as c:
        did = c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"]
        r = c.post(f"/api/taxonomy/drafts/{did}/parts/tree/retry", headers=A)
        gate.set()
        _poll(c, did)
    assert r.status_code == 409 and "still drafting" in r.json()["detail"]


def test_description_retry_route():
    class FailOnce(FakeLLM):
        failed = False

        def complete_text(self, system, user):
            if not self.failed:
                self.failed = True
                raise TaxonomyLLMError("boom")
            return super().complete_text(system, user)

    with _make_tc(llm=FailOnce()) as c:
        did = c.post("/api/taxonomy/condense", json=CONDENSE_BODY, headers=A).json()["draft_id"]
        assert _poll(c, did)["parts"]["description"]["status"] == "failed"
        assert c.post(f"/api/taxonomy/drafts/{did}/parts/description/retry", headers=A).status_code == 200
        out = _poll(c, did)
    assert out["parts"]["description"]["description"] == "Ridgeline is a regional utility."


def test_pre_draft_probe_runs_again_once_the_pass_expires(monkeypatch):
    now = [datetime(2026, 10, 19, 10, 0, tzinfo=timezone.utc)]
    monkeypatch.setattr(MODEL_SERVICE_ACCESS, "_clock", lambda: now[0])
    llm = FakeLLM()
    with _make_tc(llm=llm) as c:
        _poll(c, c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"])
        now[0] += PASSED_TTL - timedelta(seconds=1)
        _poll(c, c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"])
        assert llm.probes == 1
        now[0] += timedelta(seconds=1)
        _poll(c, c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).json()["draft_id"])
    assert llm.probes == 2


def test_non_admin_gets_403_before_config_checks():
    with _make_tc(UserRole.VIEWER, model_service="") as c:
        assert c.post("/api/taxonomy/drafts", json=INTAKE, headers=A).status_code == 403


def test_router_is_registered_in_app():
    # app.routes only exposes a mount here, so check the registration in source.
    from pathlib import Path

    src = (Path(taxonomy_routes.__file__).parent.parent / "app.py").read_text()
    assert "taxonomy.router" in src
