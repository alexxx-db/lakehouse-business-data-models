import json, re, os, sys, textwrap, logging, pytest

from notebook_source_util import pk_suffix_globals

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v338.ipynb"

SENTINEL = {"status": "SENTINEL_FELL_THROUGH", "evidence": "fell-through"}


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


def _bind_verify_requirement(path):
    src = _full_src(path)
    ns = {"re": re, **pk_suffix_globals()}
    exec(_extract_fn(src, "_verify_requirement"), ns)
    if "def _vibe_scope_open_field_verdict(" in src:
        ns["_VIBE_SCOPE_RUNTIME"] = None
        for name in ("get_vibe_scope_runtime", "_vibe_scope_open_field_verdict"):
            exec(re.search(rf"(?ms)^def {name}\(.*?(?=^\S)", src).group(0), ns)
    if "def _verify_domain_structural_op(self" in src:
        for name in ("_v337_negated_before", "_v337_extract_domain_rename", "_v337_extract_domain_merge",
                     "_v337_extract_bulk_move", "_v407_resolve_dp"):
            exec(re.search(rf"(?ms)^def {name}\(.*?(?=^\S)", src).group(0), ns)
        exec(_extract_fn(src, "_verify_domain_structural_op"), ns)

    class Dummy:
        logger = _Logger()
        ai_agent = None
        _llm_verify_enabled = False
        _step_snapshots = {}
        widgets_values = {}
        config = {}

        def _verify_deterministic(self, *a, **k): return dict(SENTINEL)
        def _verify_state_diff(self, *a, **k): return dict(SENTINEL)
        def _verify_structural_target(self, *a, **k): return dict(SENTINEL)
        def _verify_via_llm(self, *a, **k): return dict(SENTINEL)
        def _verify_count_shape(self, *a, **k): return None

    Dummy._verify_requirement = ns["_verify_requirement"]
    if "_verify_domain_structural_op" in ns:
        Dummy._verify_domain_structural_op = ns["_verify_domain_structural_op"]
    return Dummy()


class _Req:
    def __init__(self, text, rid="VREQ-T", strategy="llm_verify"):
        self.original_text = text
        self.id = rid
        self.verification_strategy = strategy
        self.scope_targets = []


def _attrs(rows):
    # rows: (domain, product, attribute, foreign_key_to)
    return [{"domain": d, "product": p, "attribute": a, "foreign_key_to": fk} for d, p, a, fk in rows]


VERIFY_ONLY_TEXT = (
    "Verify only (no action needed): the FKs succession_plan.job_family_id, "
    "rif_group.job_family_id, and plan_inclusion.milestone_id are already correctly linked."
)


def _flat(linked=True):
    tables = [("hr", "succession_plan"), ("hr", "rif_group"), ("hr", "job_family"), ("hr", "position"), ("hr", "salary_grade"),
              ("project", "plan_inclusion"), ("project", "milestone")]
    domains = [{"domain": "hr"}, {"domain": "project"}]
    products = [{"domain": d, "product": p, "primary_key": f"{p}_id"} for d, p in tables]
    attrs = _attrs([(d, p, f"{p}_id", "") for d, p in tables] + [
        ("hr", "succession_plan", "job_family_id", "hr.job_family.job_family_id" if linked else ""),
        ("hr", "rif_group", "job_family_id", "hr.job_family.job_family_id" if linked else ""),
        ("project", "plan_inclusion", "milestone_id", "project.milestone.milestone_id" if linked else ""),
    ])
    return domains, products, attrs


def _orchestrator(llm=False):
    orch = ah.VibeOrchestrator({"logger": logging.getLogger("test_v338"), "config": {}, "vibe_modelling_instructions": VERIFY_ONLY_TEXT,
                                "operation": "vibe modeling of version"})
    orch._llm_verify_enabled = llm
    orch.ai_agent = object() if llm else None
    orch._verify_via_llm = lambda *a, **k: dict(SENTINEL)
    return orch


def _verify(spec, flat, llm=False, text=VERIFY_ONLY_TEXT):
    vs.register(ah, ah.widgets_flat_to_model(*[list(x) for x in flat]), spec)
    return _orchestrator(llm)._verify_requirement(_Req(text, rid=spec["id"]), *flat)


def _check_spec():
    return vs.spec("VREQ-T", "check_only", ["hr.succession_plan.job_family_id", "hr.rif_group.job_family_id",
                                            "project.plan_inclusion.milestone_id"])


def test_verify_only_check_is_never_scored_failed_or_fulfilled_without_the_llm():
    for linked in (True, False):
        res = _verify(_check_spec(), _flat(linked))
        assert res["status"] == "partial", (linked, res)
        assert "no deterministic check fits this requirement" in res["evidence"], res


def test_verify_only_check_is_judged_by_the_llm_audit():
    assert _verify(_check_spec(), _flat(), llm=True) == SENTINEL
    assert _verify(vs.spec("VREQ-T", "check_only", []), _flat(), llm=True,
                   text="Verify only (no action needed): the model is internally consistent.") == SENTINEL


def test_non_verify_only_directive_unaffected():
    connect = vs.spec("VREQ-T", "add_column", ["hr.position"], columns=[{"name": "salary_grade_id", "type": "BIGINT"}], fk_target="hr.salary_grade")
    text = "connect_table hr.position: add column salary_grade_id with FK to hr.salary_grade"
    domains, products, attrs = _flat()
    landed = (domains, products, attrs + _attrs([("hr", "position", "salary_grade_id", "hr.salary_grade.salary_grade_id")]))
    res = _verify(connect, landed, llm=True, text=text)
    assert res["status"] == "fulfilled" and "reference hr.salary_grade.salary_grade_id" in res["evidence"], res
    assert _verify(connect, _flat(), llm=True, text=text)["status"] == "failed"


@pytest.mark.skipif(not os.path.exists(NB_PRE), reason="pre-v338 backup not present")
def test_pre_patch_verify_only_not_fulfilled_by_branch():
    # NON-TAUTOLOGY proof: on pre-v338 code the same verify-only+linked input must NOT
    # return the verify-only fulfilled verdict (it falls through to state-diff -> sentinel).
    obj = _bind_verify_requirement(NB_PRE)
    req = _Req(VERIFY_ONLY_TEXT)
    attrs = _attrs([
        ("hr", "succession_plan", "job_family_id", "hr.job_family.job_family_id"),
        ("hr", "rif_group", "job_family_id", "hr.job_family.job_family_id"),
        ("project", "plan_inclusion", "milestone_id", "project.milestone.milestone_id"),
    ])
    res = obj._verify_requirement(req, [], [], attrs)
    assert "verifier-verify-only-no-change" not in res.get("evidence", "")
