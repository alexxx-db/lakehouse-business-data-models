import json, re, os, textwrap, logging, pytest

import agent_helpers as ah
import vreq_spec_util as vs

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v411.ipynb"


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
    def __init__(self, text, rid="VREQ-T", strategy="llm_verify", scope="domain", scope_targets=None):
        self.original_text = text
        self.id = rid
        self.verification_strategy = strategy
        self.scope = scope
        self.scope_targets = scope_targets or []


def _prods(pairs):
    return [{"domain": d, "product": p} for d, p in pairs]


# Faithful reproduction of live retail v2 VREQ-002 (scoreboard scored it 'partial' at 55.9% precision
# while inventory + all 19 named products were physically built).
INVENTORY = ["stock_position", "stock_ledger", "inventory_node", "replenishment_order", "cycle_count",
             "adjustment", "stock_transfer", "goods_receipt", "rfid_tag", "vmi_agreement",
             "expiry_tracking", "reservation", "reorder_policy", "asn", "lot", "node_assortment",
             "promo_stock_allocation", "location_assignment", "assortment_deployment"]
VREQ002_TEXT = ("Create the inventory domain with the following products: " + ", ".join(INVENTORY) + ".")
VREQ002_SPEC = vs.spec("VREQ-002", "add_product", [f"inventory.{p}" for p in INVENTORY])


def _orch(llm_verify=False, ai_agent=None):
    o = object.__new__(ah.VibeOrchestrator)
    o.logger = logging.getLogger("test_v411_domain_create")
    o._llm_verify_enabled = llm_verify
    o.ai_agent = ai_agent
    return o


def _verify(prods, spec=VREQ002_SPEC, text=VREQ002_TEXT):
    vs.register(ah, ah.widgets_flat_to_model([{"domain": "customer"}], _prods([("customer", "profile")]), []), spec)
    return _orch()._verify_deterministic(_Req(text, spec["id"], scope_targets=["inventory"]), [], prods, [])


# ---------- coverage grading is real (non-tautology: includes MUST-fail cases) ----------

def test_full_coverage_fulfilled():
    v = _verify(_prods([("inventory", p) for p in INVENTORY]))
    assert v["status"] == "fulfilled", v
    assert v["evidence"] == "[verifier-spec FIRED v5.3.3] 19/19 target(s) present", v


def test_ninety_pct_coverage_is_partial_because_a_named_list_needs_every_table():
    # 18/19 = 94.7%: a named create list is fulfilled only when every named table exists.
    v = _verify(_prods([("inventory", p) for p in INVENTORY[:18]]))
    assert v["status"] == "partial", v
    assert "18/19 target(s) present" in v["evidence"], v


def test_half_coverage_partial():
    v = _verify(_prods([("inventory", p) for p in INVENTORY[:10]]))  # 10/19 = 52%
    assert v["status"] == "partial", v


def test_zero_named_present_failed():
    # MUST-fail (non-tautology): domain exists but none of the NAMED products are present.
    v = _verify(_prods([("inventory", x) for x in ["foo", "bar", "baz"]]))
    assert v["status"] == "failed", v


def test_domain_absent_failed():
    v = _verify(_prods([("customer", "profile")]))  # inventory domain absent entirely
    assert v["status"] == "failed", v


def test_a_domain_action_that_names_tables_is_refused():
    spec = vs.spec("VREQ-002", "add_domain", [f"inventory.{p}" for p in INVENTORY])
    v = _verify(_prods([("inventory", p) for p in INVENTORY]), spec=spec)
    assert v["status"] == "failed", v
    assert "add_domain changes a domain but names the table(s)" in v["evidence"], v


def test_a_non_create_spec_is_judged_by_its_own_action():
    # A foreign-key requirement on an existing table is never credited by the table's presence.
    spec = vs.spec("VREQ-X", "add_fk", ["order.header.customer_id"], fk_target="customer.profile.profile_id")
    text = "Add a foreign key on order.header.customer_id to customer.profile.profile_id"
    vs.register(ah, ah.widgets_flat_to_model([{"domain": "order"}], _prods([("order", "header")]), []), spec)
    attrs = [{"domain": "order", "product": "header", "attribute": "customer_id", "foreign_key_to": ""}]
    v = _orch()._verify_deterministic(_Req(text, "VREQ-X", scope="relation", scope_targets=["order.header"]), [], _prods([("order", "header")]), attrs)
    assert v["status"] == "failed" and "0/1 column(s) reference customer.profile.profile_id" in v["evidence"], v
    attrs[0]["foreign_key_to"] = "customer.profile.profile_id"
    v = _orch()._verify_deterministic(_Req(text, "VREQ-X", scope="relation", scope_targets=["order.header"]), [], _prods([("order", "header")]), attrs)
    assert v["status"] == "fulfilled", v


# ---------- the llm_verify path takes the deterministic spec verdict ----------

def test_llm_verify_requirement_takes_the_spec_verdict_without_calling_the_llm():
    class _NoLLM:
        def _call_ai_query(self, **kwargs):
            raise AssertionError("the LLM verifier must not run when the spec gives a verdict")

    vs.register(ah, ah.widgets_flat_to_model([], [], []), VREQ002_SPEC)
    orch = _orch(llm_verify=True, ai_agent=_NoLLM())
    v = orch._verify_requirement(_Req(VREQ002_TEXT, "VREQ-002", scope_targets=["inventory"]),
                                 [], _prods([("inventory", p) for p in INVENTORY]), [])
    assert v["status"] == "fulfilled", v
    v = orch._verify_requirement(_Req(VREQ002_TEXT, "VREQ-002", scope_targets=["inventory"]), [], _prods([("customer", "profile")]), [])
    assert v["status"] == "failed", v


# ---------- pre-patch proof: the FN existed (domain-create VReq not resolvable -> not fulfilled) ----------

@pytest.mark.skipif(not os.path.exists(NB_PRE), reason="pre-v411 backup absent")
def test_pre_patch_structural_target_not_fulfilled():
    pre = _full_src(NB_PRE)
    assert "_verify_domain_create_coverage" not in pre, "pre-patch must lack the helper"
    ns = {"re": re}
    exec(_extract_fn(pre, "_verify_structural_target"), ns)
    for fn in ("_v395_verify_description_coverage", "_v394_verify_move_type_count"):
        exec(_extract_fn(pre, fn), ns)

    class Dummy:
        logger = _Logger()
    Dummy._verify_structural_target = ns["_verify_structural_target"]
    Dummy._v395_verify_description_coverage = ns["_v395_verify_description_coverage"]
    Dummy._v394_verify_move_type_count = ns["_v394_verify_move_type_count"]
    obj = Dummy()
    prods = _prods([("inventory", p) for p in INVENTORY])
    req = _Req(VREQ002_TEXT, rid="VREQ-002", scope_targets=["inventory"])
    v = obj._verify_structural_target(req, prods, [])
    # pre-patch: no domain-create branch -> cannot resolve a bare-domain create VReq to fulfilled
    assert not (v is not None and v.get("status") == "fulfilled"), f"expected pre-patch non-fulfilled, got {v}"


def test_v411_alias_present():
    full = _full_src(NB)
    assert "alias=verifier-spec" in full


# ---------- tables another pass re-homed are followed through the rename ledger ----------

def test_cross_domain_redistribution_fulfilled():
    # Mirrors live automotive VREQ-015 aftersales: the directive names 19 products but the architect
    # legitimately re-homes most of them to better domains (vehicle/product/compliance). A table the
    # ledger shows was moved (or moved and renamed) is credited where it landed -> fulfilled.
    prods = _prods(
        [("inventory", INVENTORY[0]), ("inventory", INVENTORY[1])]       # 2 in target domain
        + [("product", p) for p in INVENTORY[2:15]]                      # 13 moved to another domain
        + [("vehicle", "rehomed_" + p) for p in INVENTORY[15:]]          # 4 moved and renamed
    )
    v = _verify(prods)
    assert v["status"] == "partial" and "2/19 target(s) present" in v["evidence"], v
    for p in INVENTORY[2:15]:
        ah._vov_note_product_rename("inventory", p, "product", p, "pass:architect_rehome")
    for p in INVENTORY[15:]:
        ah._vov_note_product_rename("inventory", p, "vehicle", "rehomed_" + p, "pass:architect_rehome")
    v = _verify(prods)
    assert v["status"] == "fulfilled", v


def test_genuinely_absent_stays_partial_modelwide():
    # Mirrors live water_utilities wastewater 10/30: most named products exist NOWHERE in the model.
    # Model-wide presence must NOT rescue them -> honest partial (anti-lying-scoreboard in reverse).
    prods = _prods(
        [("inventory", p) for p in INVENTORY[:10]]            # 10 named present in domain
        + [("unrelated", "alpha_widget"), ("misc", "beta_gadget")]  # decoys, no overlap with named
        + [("product", p) for p in INVENTORY[10:]]
    )
    v = _verify(prods)
    assert v["status"] == "partial" and "10/19 target(s) present" in v["evidence"], v


def test_guarded_suffix_no_short_token_overmatch():
    # A short named table must NOT be credited by an unrelated *_token table; only the exact
    # domain.table counts. Prove the exact match is not a tautology.
    spec = vs.spec("VREQ-G", "add_product", ["catalog.sku", "catalog.ima"])
    text = "Create the catalog domain with the following products: sku, ima."
    prods = _prods([("inventory", "dealer_sku"), ("inventory", "max_ima"), ("catalog", "listing")])
    v = _verify(prods, spec=spec, text=text)
    # 0 of the 2 short named tokens credited (catalog present but neither sku nor ima built) -> failed
    assert v["status"] == "failed", v
    # now add an EXACT 'sku' product -> 1/2 credited -> partial (proves exact match still works)
    v2 = _verify(prods + _prods([("catalog", "sku")]), spec=spec, text=text)
    assert v2["status"] == "partial", v2
