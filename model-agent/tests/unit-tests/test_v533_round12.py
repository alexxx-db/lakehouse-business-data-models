"""v5.3.3 live round 12 (r12a 900785079378194) findings.

The corrective pass acted on a requirement the LLM could not read and dropped every FK of product.review; the name-collision
autofix renamed the user's new customer.vendor and the phantom cleanup deleted it; the FK-suffix autofix renamed the user's FK
column and pointed it at the key; a foreign key to a non-key column was accepted although Unity Catalog references the primary
key; a primary-key rule the base already met opened its whole domain; a mutator with a local variable named sc was rejected; and a
batch that created the table it was asked for was failed as target_miss.
"""
import logging
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

LOG = logging.getLogger("test_v533_round12")
SRC = notebook_concat_source()


@pytest.fixture(autouse=True)
def _reset(monkeypatch):
    monkeypatch.setattr(ah, "logger", LOG, raising=False)
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    ah._VREQ_SPECS.clear()
    yield
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    ah._VREQ_SPECS.clear()


def _model():
    def table(name, *attrs):
        return {"name": name, "primary_key": f"{name}_id", "attributes": [{"name": f"{name}_id", "type": "BIGINT", "is_primary_key": True}]
                + [dict(a) for a in attrs]}
    return {"model": {"domains": [
        {"name": "product", "division": "operations", "products": [
            table("vendor", {"name": "vendor_name", "type": "STRING"}),
            table("retail_price", {"name": "price_list_code", "type": "STRING"}),
            table("sku", {"name": "list_price_ref", "type": "BIGINT", "foreign_key_to": "product.retail_price.retail_price_id"})]},
        {"name": "customer", "division": "business", "products": [
            table("profile", {"name": "full_name", "type": "STRING"}),
            table("vendor", {"name": "vendor_name", "type": "STRING"}, {"name": "vendor_tier", "type": "STRING"})]}]}}


def _flat(model):
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    return d, p, a


def _vreq(vid, target):
    return ah.RawVREQ(vreq_id=vid, intent="x", target=target, source_quote="x", source_chunk_id="c1")


def test_a_requirement_the_llm_could_not_read_is_never_acted_on_by_the_corrective_pass():
    i = SRC.index("vibe-corrective-not-interpreted FIRED v5.3.3")
    loop = SRC.rfind("for _vs_index, _vs_action in enumerate(_vs_corrective, 1):", 0, i)
    dispatch = SRC.index("_dispatch_generic_action(_vs_at, _vs_sc, _vs_nm, _vs_ts, _vs_rs, _vs_action, _vs_ctx)", i)
    assert 0 < loop < i < dispatch, "the skip sits inside the corrective loop before any action runs"
    assert 'if _vs_spec is not None and not _vs_spec.get("interpretable", True):' in SRC[loop:i]


def test_a_name_collision_never_renames_a_table_the_user_named():
    model = _model()
    d, p, a = _flat(model)
    ah._validate_product_name_collisions(d, p, a, LOG, "test")
    assert ("customer", "vendor") not in {(r["domain"], r["product"]) for r in p}, "without a requirement the collision is qualified"
    vs.register(ah, model, vs.spec("V1", "add_product", ["customer.vendor"]))
    assert ah._vov_user_named("customer", "vendor") and not ah._vov_user_named("product", "vendor")
    d, p, a = _flat(model)
    ah._validate_product_name_collisions(d, p, a, LOG, "test")
    assert ("customer", "vendor") in {(r["domain"], r["product"]) for r in p}
    assert sum(1 for r in a if r["domain"] == "customer" and r["product"] == "vendor") == 3


def test_the_phantom_cleanup_keeps_a_disconnected_table_the_user_asked_for():
    i = SRC.index("[PHANTOM] Removed disconnected product")
    guard = SRC.rfind('_vov_user_named(_ph_p.get("domain"), _ph_p.get("product"))', 0, i)
    assert guard > 0 and i - guard < 1200


def test_the_fk_suffix_autofix_keeps_a_column_the_user_named():
    model = _model()
    d, p, a = _flat(model)
    ah._pre_static_analysis_autofix(d, p, a, {}, LOG)
    names = {r["attribute"] for r in a if r["product"] == "sku"}
    assert "list_price_ref" not in names, "without a requirement the FK column takes the target key's name"
    vs.register(ah, model, vs.spec("V2", "add_column", ["product.sku.list_price_ref"], columns=[{"name": "list_price_ref", "type": "BIGINT"}],
                                   fk_target="product.retail_price"))
    d, p, a = _flat(model)
    ah._pre_static_analysis_autofix(d, p, a, {}, LOG)
    assert "list_price_ref" in {r["attribute"] for r in a if r["product"] == "sku"}


def test_a_foreign_key_must_reference_the_parents_primary_key():
    model = _model()
    vs.register(ah, model,
                vs.spec("K1", "add_column", ["product.retail_price.price_tier_code", "product.sku.price_tier_code"],
                        columns=[{"name": "price_tier_code", "type": "STRING"}], fk_target="product.retail_price.price_tier_code"),
                vs.spec("K2", "add_fk", ["product.sku.list_price_ref"], fk_target="product.retail_price"),
                vs.spec("K3", "add_fk", ["product.sku.list_price_ref"], fk_target="product.retail_price.retail_price_id"))
    k1 = ah.vreq_spec("K1")
    assert not k1["interpretable"] and "is not the primary key of its table (retail_price_id)" in k1["reason"]
    assert ah.vreq_spec("K2")["interpretable"] and ah.vreq_spec("K2")["fk_target"] == "product.retail_price.retail_price_id"
    assert ah.vreq_spec("K3")["interpretable"]


def test_a_foreign_key_never_lands_on_the_column_it_references():
    model = _model()
    vs.register(ah, model, vs.spec("S1", "add_column", ["product.vendor.vendor_id", "product.sku.vendor_id"],
                                   columns=[{"name": "vendor_id", "type": "BIGINT"}], fk_target="product.vendor.vendor_id"))
    spec = ah.vreq_spec("S1")
    ops = ah._vreq_spec_det_ops(spec, model)
    assert [op for op in ops if op and op[0] == "add_fk"] == [("add_fk", "product", "sku", "vendor_id", "product.vendor.vendor_id")]
    d, p, a = _flat(model)
    a.append({"domain": "product", "product": "sku", "attribute": "vendor_id", "type": "BIGINT", "foreign_key_to": "product.vendor.vendor_id"})
    assert ah._verify_from_spec(spec, d, p, a)["status"] == "fulfilled", "the referenced column itself is not expected to point at itself"


def test_a_structural_rule_the_base_meets_opens_nothing():
    model = _model()
    vs.register(ah, model, vs.spec("R1", "other", ["customer"], breadth="set", policy="primary_key_everywhere"))
    assert ah._vov_vreq_satisfied_in_model("R1", model)[0] == "satisfied"
    assert ah._vibe_scope_requested_spec([_vreq("R1", "customer")], model) == (None, [])
    model["model"]["domains"][1]["products"][0]["primary_key"] = "missing"
    assert ah._vov_vreq_satisfied_in_model("R1", model)[0] == "unsatisfied"
    spec, _wide = ah._vibe_scope_requested_spec([_vreq("R1", "customer")], model)
    assert spec is not None and "customer" in spec.whole_domains


def test_a_local_variable_named_like_a_runtime_handle_is_not_a_handle():
    ah.validate_ast("def mutator(model, data):\n    for sc in model.get('domains', []):\n        sc['x'] = 1\n    return model\n")
    with pytest.raises(ah.UnsafeCodeError):
        ah.validate_ast("def mutator(model, data):\n    sc.stop()\n    return model\n")
    with pytest.raises(ah.UnsafeCodeError):
        ah.validate_ast("def mutator(model, data):\n    spark.sql('DROP TABLE x')\n    return model\n")


def test_a_batch_that_creates_its_named_table_meets_the_post_condition():
    i = SRC.index("def _apply_handler_with_retry(")
    body = SRC[i:SRC.index("\ndef ", i + 10)]
    assert '_target_set = {".".join(x for x in (t["domain"], t["product"]) if x) for _vid in (batch.vreq_ids or ())' in body


def test_an_architect_never_adds_a_table_past_the_users_cap():
    """Live r12c 564850156005703: the user capped each domain at six tables; the domain architect added three to production."""
    from collections import defaultdict
    products = [{"domain": "production", "product": f"t{i}", "primary_key": f"t{i}_id"} for i in range(6)]
    reply = {"products_to_add": [{"product_name": "ingredient_receipt", "description": "Receipts of ingredients.", "rationale": "gap"}]}
    queue = []
    ah._apply_single_domain_review_to_model(reply, "production", products, set(), queue, [], [], defaultdict(int), LOG,
                                            sizing_directives={"max_products_per_domain": 6})
    assert len(products) == 6 and [q["gate"] for q in queue] == ["domain_architect_add_over_user_cap"]
    ah._apply_single_domain_review_to_model(reply, "production", products, set(), [], [], [], defaultdict(int), LOG,
                                            sizing_directives={"max_products_per_domain": 7})
    assert [p["product"] for p in products][-1] == "ingredient_receipt", "room under the cap lets the architect add"
    assert ah._user_domain_room(products, "production", {"max_total_products": 7}) == 0
    assert ah._user_domain_room(products, "production", {}) is None


def test_a_requirement_with_two_counts_is_verified_on_both():
    model = _model()
    vs.register(ah, model, vs.spec("C1", "other", [], breadth="model", kind="count_target", count={"entity": "domains", "op": "exactly", "value": 2},
                                   counts=[{"entity": "domains", "op": "exactly", "value": 2}, {"entity": "products_per_domain", "op": "exactly", "value": 6}]))
    spec = ah.vreq_spec("C1")
    assert len(spec["counts"]) == 2
    d, p, a = _flat(model)
    verdict = ah._verify_from_spec(spec, d, p, a)
    assert verdict["status"] == "partial" and "products_per_domain exactly 6" in verdict["evidence"], verdict
    vs.register(ah, model, vs.spec("C2", "other", [], breadth="model", kind="count_target", count={"entity": "domains", "op": "exactly", "value": 2}))
    assert ah._verify_from_spec(ah.vreq_spec("C2"), d, p, a)["status"] == "fulfilled"
    prompt = ah.VREQ_SPEC_PROMPT
    assert "- counts: for count_target, every count the requirement states" in prompt and '"counts": []' in prompt
    schema = SRC[SRC.index("VREQ_SPEC_SCHEMA = {"):]
    assert '"counts": {"type": "array", "items": {"type": "object", "properties": {' in schema[:schema.index('"required": ["specs"]')]


def test_a_requested_report_is_a_named_metric_view_checked_deterministically():
    model = _model()
    vs.register(ah, model, vs.spec("M1", "add_metric_view", [], breadth="model",
                                   metric_views=["daily sales by shop and product", "pre-order volumes by pickup day"]))
    spec = ah.vreq_spec("M1")
    d, p, a = _flat(model)
    views = [{"view_name": "sales_daily_sales_by_shop_and_product", "sql": "CREATE ... WITH METRICS"}, {"view_name": "sales_sale_line", "sql": "x"}]
    verdict = ah._verify_from_spec(spec, d, p, a, metric_views=views)
    assert verdict["status"] == "partial" and "1/2 named metric view(s) exist" in verdict["evidence"], verdict
    fallback = ah._v469_build_mv_rowcount_fallback("`c`.`_metrics`.`sales_pre_order_volumes_by_pickup_day`", "`c`.`sales`.`pre_order`")
    views.append({"view_name": "sales_pre_order_volumes_by_pickup_day", "sql": fallback})
    assert ah._verify_from_spec(spec, d, p, a, metric_views=views)["status"] == "partial", "a row-count fallback is not the report"
    views[-1]["sql"] = "CREATE ... WITH METRICS"
    assert ah._verify_from_spec(spec, d, p, a, metric_views=views)["status"] == "fulfilled"
    assert ah._vreq_spec_metric_view_names() == ["daily sales by shop and product", "pre-order volumes by pickup day"]
    assert "kpi-first-spec-names FIRED v5.3.3" in SRC and "the user's requirements ask for these metric views and you MUST produce" in SRC
