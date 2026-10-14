import json, re, os, textwrap, pytest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v335.ipynb"


def _full_src(path):
    nb = json.load(open(path))
    return "".join(
        "".join(c.get("source", [])) if isinstance(c.get("source"), list) else c.get("source", "")
        for c in nb["cells"]
    )


def _extract_fn(src, name):
    m = re.search(rf"\n    def {name}\(self.*?\n    def ", src, re.S)
    assert m, f"{name} not found"
    body = m.group(0)
    body = body[: body.rfind("\n    def ")]
    return textwrap.dedent(body)


class _Logger:
    def info(self, *a, **k): pass
    def warning(self, *a, **k): pass
    def error(self, *a, **k): pass


def _bind(path):
    """Bind _verify_requirement + _verify_structural_target onto a Dummy with the LLM disabled."""
    src = _full_src(path)
    ns = {"re": re}
    exec(_extract_fn(src, "_verify_structural_target"), ns)
    exec(_extract_fn(src, "_verify_requirement"), ns)
    if "def _verify_domain_structural_op(self" in src:
        for name in ("_v337_negated_before", "_v337_extract_domain_rename", "_v337_extract_domain_merge",
                     "_v337_extract_bulk_move", "_v407_resolve_dp"):
            exec(re.search(rf"(?ms)^def {name}\(.*?(?=^\S)", src).group(0), ns)
        exec(_extract_fn(src, "_verify_domain_structural_op"), ns)

    class Dummy:
        logger = _Logger()
        _llm_verify_enabled = False   # LLM disabled -> only deterministic-first can resolve
        ai_agent = None
        _step_snapshots = {}
        widgets_values = {}

        def _verify_deterministic(self, *a, **k):
            raise AssertionError("deterministic path should not run for llm_verify req")

        def _verify_state_diff(self, *a, **k):
            raise AssertionError("state_diff path should not run for llm_verify req")

        def _verify_via_llm(self, *a, **k):
            raise AssertionError("LLM path should not run when deterministic-first resolves")

    Dummy._verify_structural_target = ns["_verify_structural_target"]
    Dummy._verify_requirement = ns["_verify_requirement"]
    if "_verify_domain_structural_op" in ns:
        Dummy._verify_domain_structural_op = ns["_verify_domain_structural_op"]
    return Dummy()


class _Req:
    def __init__(self, text, rid="VREQ-T", strategy="llm_verify", scope_targets=None):
        self.original_text = text
        self.id = rid
        self.verification_strategy = strategy
        self.scope_targets = scope_targets or []


def _attrs(rows):
    return [{"domain": d, "product": p, "attribute": a, "foreign_key_to": fk, "tags": tg}
            for d, p, a, fk, tg in rows]


def _prods(pairs):
    return [{"domain": d, "product": p} for d, p in pairs]


class _Current:
    logger = _Logger()
    _llm_verify_enabled = False
    ai_agent = None

    def _verify_via_llm(self, *a, **k):
        raise AssertionError("LLM path should not run when the spec verdict resolves")


def _verify_current(req, products, attrs, obj=None):
    return ah.VibeOrchestrator._verify_requirement(obj or _Current(), req, [], products, attrs)


# ---------- v3.3.5 deterministic-first for llm_verify ----------

def test_llm_verify_structural_resolved_deterministically_fulfilled():
    base = {"model": {"domains": [{"name": "hr", "products": [{"name": "employee", "attributes": [{"name": "organization_id"}]}]}]}}
    vs.register(ah, base, vs.spec("VREQ-T", "rename_column", ["hr.employee.organization_id"], new_name="home_organization_id"))
    # rename landed: new present, old gone
    attrs = _attrs([("hr", "employee", "home_organization_id", "hr.organization.organization_id", None)])
    req = _Req("Rename column organization_id to home_organization_id on hr.employee because role.",
               strategy="llm_verify", scope_targets=["hr.employee"])
    v = _verify_current(req, _prods([("hr", "employee")]), attrs)
    assert v and v["status"] == "fulfilled", v
    assert "verifier-spec" in v["evidence"], v
    stale = _attrs([("hr", "employee", "organization_id", "hr.organization.organization_id", None)])
    assert _verify_current(req, _prods([("hr", "employee")]), stale)["status"] == "failed"
    ah.vov_ledger_reset()
    unread = _verify_current(req, _prods([("hr", "employee")]), attrs)
    assert unread["status"] == "failed" and "not interpreted" in unread["evidence"], unread


def test_llm_verify_semantic_still_falls_to_llm():
    # A non-structural llm_verify req: reconciler returns None -> with LLM disabled, terminal partial.
    vs.register(ah, {"model": {"domains": []}}, vs.spec("VREQ-T", "other", breadth="model"))
    req = _Req("Clean banned boilerplate phrases from attribute descriptions across the model.",
               strategy="llm_verify", scope_targets=["*"])
    v = _verify_current(req, _prods([("hr", "employee")]), [])
    assert v and v["status"] == "partial", v
    seen = []
    with_llm = _Current()
    with_llm._llm_verify_enabled, with_llm.ai_agent = True, object()
    with_llm._verify_via_llm = lambda r, *rows: seen.append(r.id) or {"status": "fulfilled", "evidence": "llm verdict"}
    assert _verify_current(req, _prods([("hr", "employee")]), [], with_llm)["evidence"] == "llm verdict" and seen == ["VREQ-T"]


# ---------- no-tautology vs pre-v335 ----------

@pytest.mark.skipif(not os.path.exists(NB_PRE), reason="pre-v335 backup absent")
def test_pre_v335_llm_verify_does_not_resolve_deterministically():
    obj = _bind(NB_PRE)
    attrs = _attrs([("hr", "employee", "home_organization_id", "hr.organization.organization_id", None)])
    req = _Req("Rename column organization_id to home_organization_id on hr.employee because role.",
               strategy="llm_verify", scope_targets=["hr.employee"])
    # pre-v335: no deterministic-first in _verify_requirement -> with LLM disabled -> NOT fulfilled
    v = obj._verify_requirement(req, [], _prods([("hr", "employee")]), attrs)
    assert not (v and v.get("status") == "fulfilled"), f"expected pre-v335 to NOT resolve, got {v}"


# ---------- version + aliases ----------

def test_version_is_335():
    full = _full_src(NB)
    m = re.search(r'__AGENT_VERSION__\s*=\s*"(\d+)\.(\d+)\.(\d+)"', full)
    assert m and tuple(int(g) for g in m.groups()) >= (3, 3, 5), m.group(0) if m else "missing"


def test_v335_spec_verdict_wired_at_both_sites():
    full = _full_src(NB)
    assert "_spec_v = _verify_from_spec(vreq_spec(req), domains, products, attributes, self.logger, req.id, metric_views=" in full
    assert "verdict = _verify_from_spec(vreq_spec(req), domains_data, products_data, attributes_data, self.logger" in full
    assert "alias=verifier-spec" in full
