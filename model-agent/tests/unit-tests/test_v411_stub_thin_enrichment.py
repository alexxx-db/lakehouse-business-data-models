import json, os, logging, pytest

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
        if c.get("cell_type") == "code"
    )


class _Req:
    def __init__(self, text, rid="VREQ-T"):
        self.original_text = text
        self.id = rid


def _attrs(spec):
    """spec: list of (domain, product, n_data, n_pk, n_fk)."""
    out = []
    for d, p, nd, npk, nfk in spec:
        for i in range(nd):
            out.append({"domain": d, "product": p, "attribute": f"data_{i}"})
        for i in range(npk):
            out.append({"domain": d, "product": p, "attribute": f"pk_{i}", "is_primary_key": True})
        for i in range(nfk):
            out.append({"domain": d, "product": p, "attribute": f"fk_{i}",
                        "foreign_key_to": "other.x.id"})
    return out


def _prods(attrs):
    return [{"domain": d, "product": p} for d, p in dict.fromkeys((a["domain"], a["product"]) for a in attrs)]


def _count_spec(rid, entity, value, targets=()):
    return vs.spec(rid, "other", targets, kind="count_target", count={"entity": entity, "op": "at_least", "value": value})


def _verify(spec, attrs, products=None, text="requirement text", catalog=None):
    products = _prods(attrs) if products is None else products
    catalog = attrs if catalog is None else catalog
    domains = [{"domain": d} for d in dict.fromkeys(a["domain"] for a in catalog)]
    vs.register(ah, ah.widgets_flat_to_model(domains, _prods(catalog), catalog), spec)
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = logging.getLogger("test_v411_stub_thin")
    return orch._verify_deterministic(_Req(text, spec["id"]), [], products, attrs)


# --- fail-pre proof: the helper does not exist in the pre-patch notebook ---
def test_pre_patch_helper_absent():
    if not os.path.exists(NB_PRE):
        pytest.skip(f"pre-patch backup {NB_PRE} absent (ephemeral /tmp dev artifact)")
    src = _full_src(NB_PRE)
    assert "_verify_stub_thin_enrichment" not in src


# --- zero violators -> fulfilled ("expand the products that have only 4-8 attributes" -> at least 9) ---
def test_thin_range_all_satisfied_fulfilled():
    attrs = _attrs([("ops", "a", 12, 1, 3), ("ops", "b", 9, 1, 2), ("sales", "c", 20, 1, 0)])
    r = _verify(_count_spec("VREQ-T", "attributes_per_product", 9), attrs,
                text="Expand the thin products that currently have only 4-8 data attributes into full data products.")
    assert r["status"] == "fulfilled", r
    assert r["evidence"].startswith("[verifier-spec FIRED v5.3.3] 3/3 attributes_per_product at_least 9"), r


# --- one violator -> partial, never fulfilled ---
def test_thin_range_one_violator_is_partial_never_fulfilled():
    attrs = _attrs([("ops", "a", 12, 1, 3), ("ops", "b", 5, 1, 2)])
    r = _verify(_count_spec("VREQ-T", "attributes_per_product", 9), attrs)
    assert r["status"] == "partial", r
    assert "1/2 attributes_per_product at_least 9 (measured [16, 8])" in r["evidence"], r
    r = _verify(_count_spec("VREQ-T", "attributes_per_product", 9), _attrs([("ops", "b", 5, 1, 2)]))
    assert r["status"] == "failed", r


# --- a count target on one domain measures only that domain's tables ---
def test_count_target_on_a_domain_ignores_other_domains():
    attrs = _attrs([("ops", "a", 12, 1, 3), ("sales", "c", 1, 1, 0)])
    assert _verify(_count_spec("VREQ-T", "attributes_per_product", 9, ["ops"]), attrs)["status"] == "fulfilled"
    assert _verify(_count_spec("VREQ-T", "attributes_per_product", 9, ["sales"]), attrs)["status"] == "failed"


# --- a structural spec on a thin product is judged by its own action, never by the attribute count ---
def test_structural_spec_on_a_thin_product_is_judged_by_its_action():
    before = _attrs([("ops", "a", 1, 1, 0)])
    renamed = _attrs([("ops", "a", 0, 1, 0)]) + [{"domain": "ops", "product": "a", "attribute": "order_label"}]
    rename = vs.spec("VREQ-T", "rename_column", ["ops.a.data_0"], new_name="order_label")
    r = _verify(rename, renamed, catalog=before, text="rename thin attribute data_0 on ops.a to order_label")
    assert r["status"] == "fulfilled", r
    r = _verify(rename, before, text="rename thin attribute data_0 on ops.a to order_label")
    assert r["status"] == "failed", r
    created = _attrs([("inventory", "stock_position", 2, 1, 0)])
    r = _verify(vs.spec("VREQ-U", "add_product", ["inventory.stock_position", "inventory.stock_ledger"]), created)
    assert r["status"] == "partial" and "1/2 target(s) present" in r["evidence"], r


# --- 'total attribute' phrasing counts PK+FK toward the threshold ---
def test_total_attribute_includes_pk_fk():
    # product has 3 data + 1 pk + 3 fk = 7 total >= 6 -> satisfied
    r = _verify(_count_spec("VREQ-T", "attributes_per_product", 6), _attrs([("ops", "a", 3, 1, 3)]))
    assert r["status"] == "fulfilled", r
    r = _verify(_count_spec("VREQ-T", "attributes_per_product", 6), _attrs([("ops", "a", 2, 1, 2)]))
    assert r["status"] == "failed", r


# --- empty attribute universe -> no deterministic verdict (cannot prove) ---
def test_empty_universe_abstains():
    spec = _count_spec("VREQ-T", "attributes_per_product", 5)
    vs.register(ah, {"model": {"domains": []}}, spec)
    assert ah._verify_from_spec(ah.vreq_spec("VREQ-T"), [], [], []) is None
    r = _verify(spec, [], products=[])
    assert r["status"] == "partial" and "no specific pattern matched" in r["evidence"], r


# --- a product-count requirement is measured in products, never in attributes ---
def test_product_count_requirement_counts_products_not_attributes():
    spec = _count_spec("VREQ-T", "products_per_domain", 5, ["shared"])
    five_thin = _attrs([("shared", f"p{i}", 1, 1, 0) for i in range(5)])
    assert _verify(spec, five_thin)["status"] == "fulfilled"
    one_rich = _attrs([("shared", "p0", 40, 1, 2)])
    r = _verify(spec, one_rich, text="Expand the shared stub domain (currently 1 product) with real entities so it has 5 products.")
    assert r["status"] == "failed" and "measured [1]" in r["evidence"], r


# --- a requirement the LLM could not read is failed with its reason ---
def test_uninterpreted_enrichment_requirement_is_failed_with_reason():
    spec = dict(_count_spec("VREQ-T", "attributes_per_product", 5), interpretable=False, reason="no count is stated")
    r = _verify(spec, _attrs([("ops", "a", 12, 1, 3)]))
    assert r["status"] == "failed" and "no count is stated" in r["evidence"], r


# --- alias sentinel present for audit grep ---
def test_alias_sentinel_present():
    src = _full_src(NB)
    assert "verifier-spec FIRED v5.3.3" in src
    assert "alias=verifier-spec" in src
