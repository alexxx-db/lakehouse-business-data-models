"""v4.2.6 anti-lying-scoreboard verifier fixes (fail-pre / pass-post, §8.10).

Root causes (coffee_roastery base-MVM run <run_id> reported 33.3% adherence on a ~100% model):
  (a) verifier-domain-create-name-normalize -- vibe display domain names carry spaces
      ("green coffee sourcing and roasting") while the physical domain is space/punct-collapsed
      ("greencoffeesourcingandroasting"), so == / endswith / substring never matched and the domain
      false-scored "absent -> failed".
  (b) verifier-structural-invariant-deterministic -- model-wide structural invariants (PK / FK-resolve /
      silo / cycle) carry scope_target "*", so _verify_deterministic's per-target loop skips them, they
      fall through to a blind-partial, route to the LLM verifier, and false-fail on a transient
      SparkException.

v5.3.3: the verdict comes from the LLM spec of each requirement (_verify_from_spec): spec targets match the
physical names on their collapsed form, and the model-wide "no siloed table" rule is the fk_density policy.
"""
import json, re, os, sys, textwrap, logging, pytest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v426.ipynb"


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


class _Req:
    def __init__(self, text, rid="VREQ-T", strategy="deterministic", scope="model", scope_targets=None):
        self.original_text = text
        self.id = rid
        self.verification_strategy = strategy
        self.scope = scope
        self.scope_targets = scope_targets if scope_targets is not None else ["*"]


def _bind(path, name):
    src = _full_src(path)
    ns = {"re": re}
    exec(_extract_fn(src, name), ns)

    class Dummy:
        logger = _Logger()
    setattr(Dummy, name, ns[name])
    return Dummy()


def _prods(pairs, pk=None):
    return [{"domain": d, "product": p, "primary_key": pk} for d, p in pairs]


def _attr(dom, prod, name, is_pk=False, fk=None):
    return {"domain": dom, "product": prod, "attribute": name,
            "is_primary_key": is_pk, "foreign_key_to": fk}


def _verify(text, spec, prods, attrs=(), scope="model", scope_targets=None):
    vs.register(ah, {"model": {"domains": []}}, spec)
    orch = ah.VibeOrchestrator({"logger": logging.getLogger("test_v426"), "config": {}, "vibe_modelling_instructions": text,
                                "operation": "new base model"})
    domains = [{"domain": d} for d in dict.fromkeys(p["domain"] for p in prods)]
    return orch._verify_deterministic(_Req(text, rid=spec["id"], scope=scope, scope_targets=scope_targets), domains, prods, list(attrs))


# ============================================================================
# FIX (a): spec targets match the physical names on their collapsed form
# ============================================================================

# Faithful reproduction of the live coffee_roastery VREQ-002: the vibe names the domain with SPACES
# but the physical/model domain is space+punct collapsed.
DISPLAY = "green coffee sourcing and roasting"
PHYSICAL = "greencoffeesourcingandroasting"
NAMED = ["supplier", "green_lot", "roast_batch", "roast_profile"]
VREQ_TEXT = ("Create a %s domain with the following products: %s." % (DISPLAY, ", ".join(NAMED)))


def _spaced_model_prods():
    return _prods([(PHYSICAL, p) for p in NAMED])


def _create_spec():
    return vs.spec("VREQ-002", "add_product", ["%s.%s" % (DISPLAY, p) for p in NAMED])


def test_a_post_patch_spaced_domain_name_fulfilled():
    v = _verify(VREQ_TEXT, _create_spec(), _spaced_model_prods(), scope="domain", scope_targets=[DISPLAY])
    assert v["status"] == "fulfilled" and "4/4 target(s) present" in v["evidence"], v


def test_a_pre_patch_spaced_domain_name_false_fails():
    # FAIL-PRE: the pre-patch matcher (no collapse) cannot match "green coffee sourcing and roasting"
    # against "greencoffeesourcingandroasting" -> domain scored absent -> failed (the lying scoreboard).
    if not os.path.exists(NB_PRE):
        pytest.skip("pre-v426 backup absent")
    assert "verifier-domain-create-name-normalize" not in _full_src(NB_PRE)
    obj = _bind(NB_PRE, "_verify_domain_create_coverage")
    req = _Req(VREQ_TEXT, rid="VREQ-002", scope="domain", scope_targets=[DISPLAY])
    v = obj._verify_domain_create_coverage(req, _spaced_model_prods())
    assert v is not None and v["status"] == "failed", f"expected pre-patch false-fail, got {v}"


def test_a_genuinely_absent_domain_still_failed():
    v = _verify(VREQ_TEXT, _create_spec(), _prods([("customer_loyalty", "customer")]), scope="domain", scope_targets=[DISPLAY])
    assert v["status"] == "failed" and "0/4 target(s) present" in v["evidence"], v


# ============================================================================
# FIX (b): the model-wide "no siloed table" rule is the fk_density policy spec
# ============================================================================

SILO_TXT = "There must be no siloed tables; every table must connect to the rest of the model."


def _clean_model():
    # 3 tables, all with a PK attr; a resolvable FK chain a->b->c; no silo; no cycle.
    prods = _prods([("sales", "a"), ("sales", "b"), ("ref", "c")])
    attrs = [
        _attr("sales", "a", "a_id", is_pk=True),
        _attr("sales", "a", "b_id", fk="sales.b.b_id"),
        _attr("sales", "b", "b_id", is_pk=True),
        _attr("sales", "b", "c_id", fk="ref.c.c_id"),
        _attr("ref", "c", "c_id", is_pk=True),
    ]
    return prods, attrs


def _silo_spec():
    return vs.spec("VREQ-S", "other", [], breadth="model", policy="fk_density")


def test_b_clean_model_silo_invariant_fulfilled():
    prods, attrs = _clean_model()
    v = _verify(SILO_TXT, _silo_spec(), prods, attrs)
    assert v["status"] == "fulfilled" and "3/3 table(s) have a foreign key in or out" in v["evidence"], v


def test_b_silo_failed():
    prods, attrs = _clean_model()
    prods = prods + _prods([("misc", "island")])
    attrs = attrs + [_attr("misc", "island", "island_id", is_pk=True)]
    v = _verify(SILO_TXT, _silo_spec(), prods, attrs)
    assert v["status"] == "failed", v
    assert "misc.island" in v["evidence"], v


# ============================================================================
# Wiring / fail-pre proofs (§8.4 no dead code, §8.10 fail-pre)
# ============================================================================

def test_b_call_site_exists_in_verify_deterministic():
    src = _full_src(NB)
    m = re.search(r"\n    def _verify_deterministic\(self.*?\n    def ", src, re.S)
    assert m, "_verify_deterministic not found"
    body = m.group(0)
    assert "_verify_from_spec(vreq_spec(req)" in body, "spec verifier not called from _verify_deterministic"


def test_b_pre_patch_lacks_helper_and_callsite():
    # FAIL-PRE: pre-patch build has neither the helper nor its call site.
    if not os.path.exists(NB_PRE):
        pytest.skip("pre-v426 backup absent")
    pre = _full_src(NB_PRE)
    assert "def _verify_structural_invariant(" not in pre
    assert "_v426_struct" not in pre


def test_version_bumped_to_426():
    m = re.search(r'__AGENT_VERSION__ = "(\d)\.(\d)\.(\d)"', _full_src(NB))
    assert m and tuple(int(x) for x in m.groups()) >= (4, 2, 6), "engine build must be >= 4.2.6 (monotonic; v4.2.6 fixes remain live)"


def test_aliases_present():
    src = _full_src(NB)
    assert "alias=verifier-spec" in src
