"""v5.3.3 live round 15 (r15a 36478774249936) findings.

The user dropped product.sku.retail_price_id and the engine dropped it, but the column was back in the shipped model: a corrective
LLM fallback for that drop also carried out the price_tier_code requirement the LLM could not read, the SelfFixer then fixed the
same unread requirement again, and the FK alignment renamed the new price_tier_code column after the parent key, retail_price_id.
The feedback outcomes still said the drop was applied. A primary-key rule for one domain came back as set_primary_key with no
column and was never read.
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

LOG = logging.getLogger("test_v533_round14")
SRC = notebook_concat_source()
VOV = "vibe modeling of version"


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


def _model(with_retail_price_id=False):
    def table(name, *attrs):
        return {"name": name, "primary_key": f"{name}_id", "attributes": [{"name": f"{name}_id", "type": "BIGINT"}] + [dict(a) for a in attrs]}
    sku = [{"name": "sku_name", "type": "STRING"}, {"name": "vendor_ref", "type": "BIGINT", "foreign_key_to": "customer.vendor.vendor_id"}]
    if with_retail_price_id:
        sku.append({"name": "retail_price_id", "type": "BIGINT", "foreign_key_to": "product.retail_price.retail_price_id"})
    return {"model": {"domains": [
        {"name": "product", "division": "operations", "products": [
            table("retail_price", {"name": "price_tier_code", "type": "STRING"}), table("sku", *sku)]},
        {"name": "customer", "division": "business", "products": [
            table("vendor", {"name": "vendor_name", "type": "STRING"}), table("profile", {"name": "status", "type": "STRING"})]}]}}


def test_the_selffixer_reports_requirements_the_llm_could_not_read(monkeypatch, caplog):
    model = _model(with_retail_price_id=True)
    vs.register(ah, model, vs.spec("VREQ-002", "add_fk", ["product.sku.price_tier_code"], fk_target="product.retail_price.price_tier_code"),
                vs.spec("VREQ-003", "drop_column", ["product.sku.retail_price_id"]))
    assert ah.vreq_spec("VREQ-002")["interpretable"] is False and ah.vreq_spec("VREQ-003")["interpretable"] is True
    queued = [{"id": "VREQ-002", "text": "add price_tier_code"}, {"id": "VREQ-003", "text": "drop"}, {"id": "SA-unlinked_fk-1", "text": "link"}]
    assert ah._vreq_unread_ids(queued) == ["VREQ-002"]
    seen = {}

    class _Fixer:
        def __init__(self, **kwargs):
            pass

        def fix_all_unfulfilled(self, model_dict, unfulfilled, **kwargs):
            seen["ids"] = [r["id"] for r in unfulfilled]
            return {"fixed_count": 0, "remaining_count": len(unfulfilled), "rounds": 1}

    class _Agent:
        def _call_ai_query(self, *a, **k):
            return ""

    monkeypatch.setitem(ah.__dict__, "SelfFixer", _Fixer)
    with caplog.at_level(logging.INFO):
        ah.run_selffixer_or_skip({}, {"_unfulfilled_for_next_vibe": queued}, _Agent(), LOG, skip_ids=ah._vreq_unread_ids(queued))
    assert seen["ids"] == ["VREQ-003", "SA-unlinked_fk-1"]
    assert any("[selffixer-not-interpreted-skip FIRED v5.3.3] 1 requirement(s)" in r.getMessage() for r in caplog.records)


def test_the_run_hands_the_unread_requirements_to_the_selffixer():
    call = SRC[SRC.index("_sf_result = run_selffixer_or_skip("):]
    call = call[:call.index(")\n")]
    assert "skip_ids=_vreq_unread_ids(widgets_values.get('_unfulfilled_for_next_vibe'))" in call


def _reconcile_wv(model):
    d, p, a, mv = ah.model_to_widgets_flat(model)
    return {"operation": VOV, "domains": d, "products": p, "attributes": a,
            "_vov_2_raw_vreqs": [{"vreq_id": "U-VREQ-0004", "intent": "Drop the column", "target": "product.sku.retail_price_id", "source_quote": ""}],
            "_vov_vreq_status": {"U-VREQ-0004": {"status": "applied", "reason": ""}},
            "_vibe_input_map": {"items": {"i3": {"target": "product.sku", "spans": [[0, 10]]}}, "vreqs": {"U-VREQ-0004": {"item_ids": ["i3"]}}}}


def test_an_applied_change_a_later_pass_undid_is_reported_failed():
    base = _model(with_retail_price_id=True)
    vs.register(ah, base, vs.spec("U-VREQ-0004", "drop_column", ["product.sku.retail_price_id"]))
    wv = _reconcile_wv(_model(with_retail_price_id=True))
    assert ah._vov_reconcile_final_outcomes(wv, LOG) == ["U-VREQ-0004"]
    assert wv["_vov_vreq_status"]["U-VREQ-0004"]["status"] == "failed"
    assert wv["_vov_vreq_status"]["U-VREQ-0004"]["reason"].startswith("the final model does not hold it")
    assert [o["status"] for o in wv["_vibe_input_outcomes"]] == ["failed"]
    held = _reconcile_wv(_model(with_retail_price_id=False))
    assert ah._vov_reconcile_final_outcomes(held, LOG) == []
    assert held["_vov_vreq_status"]["U-VREQ-0004"]["status"] == "applied"


def test_a_primary_key_rule_written_as_set_primary_key_reads_as_the_policy():
    idx = ah._vreq_spec_index(_model())
    rule = ah._normalize_vreq_spec(vs.spec("K1", "set_primary_key", ["customer"], breadth="set", policy="primary_key_everywhere"), idx)
    assert rule["interpretable"] is True and rule["action"] == "other" and rule["policy"] == "primary_key_everywhere"
    keyed = ah._normalize_vreq_spec(vs.spec("K2", "set_primary_key", ["customer.vendor.vendor_name"], policy="primary_key_everywhere"), idx)
    assert keyed["action"] == "set_primary_key"
    no_rule = ah._normalize_vreq_spec(vs.spec("K3", "set_primary_key", ["customer"], breadth="set"), idx)
    assert no_rule["interpretable"] is False and "with the action other and targets that say where it applies" in no_rule["reason"]
    assert "a requirement that only states the rule uses the action other" in ah.VREQ_SPEC_PROMPT


def test_a_corrective_fallback_changes_only_what_the_corrective_names(caplog):
    model = _model(with_retail_price_id=True)
    vs.register(ah, model, vs.spec("CORR-1", "drop_column", ["product.sku.retail_price_id"]))
    mutations = [{"entity_type": "attribute", "operation": "remove", "entity_ref": "product.sku.retail_price_id", "field": "", "new_value": ""},
                 {"entity_type": "attribute", "operation": "add", "entity_ref": "product.sku.price_tier_code", "field": "type", "new_value": "STRING"},
                 {"entity_type": "link", "operation": "add", "entity_ref": "product.sku.price_tier_code", "field": "foreign_key_to",
                  "new_value": "product.retail_price.price_tier_code"},
                 {"entity_type": "product", "operation": "modify", "entity_ref": "product.sku", "field": "description", "new_value": "x"},
                 {"entity_type": "attribute", "operation": "modify", "entity_ref": "product.retail_price.price_tier_code", "field": "type", "new_value": "STRING"}]
    with caplog.at_level(logging.INFO):
        kept = ah._llm_fallback_own_targets(mutations, ah.vreq_spec("CORR-1"), LOG)
    assert [m["entity_ref"] for m in kept] == ["product.sku.retail_price_id"]
    assert any("[llm-fallback-own-targets FIRED v5.3.3] dropped 4 mutation(s)" in r.getMessage() for r in caplog.records)
    vs.register(ah, model, vs.spec("CORR-2", "add_column", ["product.sku"], columns=[{"name": "batch_code", "type": "STRING"}]))
    add = [{"entity_type": "attribute", "operation": "add", "entity_ref": "product.sku.batch_code", "field": "type", "new_value": "STRING"},
           {"entity_type": "attribute", "operation": "add", "entity_ref": "product.retail_price.batch_code", "field": "type", "new_value": "STRING"}]
    assert [m["entity_ref"] for m in ah._llm_fallback_own_targets(add, ah.vreq_spec("CORR-2"), LOG)] == ["product.sku.batch_code"]
    assert ah._llm_fallback_own_targets(mutations, None, LOG) == mutations


def test_the_corrective_loop_hands_its_spec_to_the_fallback():
    body = SRC[SRC.index("_vs_fb_ctx = {"):]
    body = body[:body.index("_llm_fallback_handler(_vs_action, _vs_fb_ctx, _vs_ai_agent, _vs_vibe_text)")]
    assert "'spec': _vs_spec," in body
    handler = SRC[SRC.index("def _llm_fallback_handler("):]
    handler = handler[:handler.index("\ndef ", 10)]
    assert handler.count("mutations = _llm_fallback_own_targets(mutations, ctx.get('spec'), logger)") == 2


def _flat(model):
    d, p, a, mv = ah.model_to_widgets_flat(model)
    return d, p, a


def test_fk_alignment_keeps_a_foreign_key_column_name_a_requirement_names(caplog):
    model = _model()
    _d, products, attributes = _flat(model)
    ref = next(a for a in attributes if a["attribute"] == "vendor_ref")
    ref["foreign_key_to"] = "customer.vendor.vendor_name"
    vs.register(ah, model, vs.spec("VREQ-1", "add_fk", ["product.sku.vendor_ref"], fk_target="customer.vendor.vendor_id"))
    with caplog.at_level(logging.INFO):
        ah._v493_align_fk_column_names_to_parent_pk(products, attributes, {}, LOG)
    assert ref["attribute"] == "vendor_ref" and ref["foreign_key_to"] == "customer.vendor.vendor_id"
    assert any("[fk-align-user-named-kept FIRED v5.3.3] kept 1 FK column name(s)" in r.getMessage() for r in caplog.records)
    ah._VREQ_SPECS.clear()
    _d, products, attributes = _flat(_model())
    ah._v493_align_fk_column_names_to_parent_pk(products, attributes, {}, LOG)
    assert any(a["attribute"] == "vendor_id" and a["product"] == "sku" for a in attributes)


def test_the_bare_name_pass_keeps_a_column_name_a_requirement_names(caplog):
    model = _model()
    _d, _p, attributes = _flat(model)
    vs.register(ah, model, vs.spec("VREQ-1", "set_fields", ["customer.profile.status"], fields=[vs.field("attributes", "description")]))
    with caplog.at_level(logging.INFO):
        ah._fix_bare_attribute_names(attributes, LOG)
    assert any(a["attribute"] == "status" and a["product"] == "profile" for a in attributes)
    assert any("[bare-name-user-named-kept FIRED v5.3.3] kept 1 bare column name(s)" in r.getMessage() for r in caplog.records)
    ah._VREQ_SPECS.clear()
    _d, _p, attributes = _flat(_model())
    ah._fix_bare_attribute_names(attributes, LOG)
    assert any(a["attribute"] == "profile_status" for a in attributes)


def test_the_shrink_demotion_keeps_a_column_name_a_requirement_names():
    model = _model()
    vs.register(ah, model, vs.spec("VREQ-1", "set_fields", ["product.sku.vendor_ref_id"], fields=[vs.field("attributes", "description")]))
    attr = {"domain": "product", "product": "sku", "attribute": "vendor_ref_id", "column_name": "vendor_ref_id", "foreign_key_to": ""}
    assert ah._demote_unlinked_fk_attr_to_external_code(attr, "_id", LOG) is False and attr["attribute"] == "vendor_ref_id"
    ah._VREQ_SPECS.clear()
    assert ah._demote_unlinked_fk_attr_to_external_code(attr, "_id", LOG) is True and attr["attribute"] == "vendor_ref_code"


def test_a_date_parameter_default_is_a_literal_or_a_function_call():
    """Live r15c 629619103476845: sales_price_list installed as a row-count fallback because its DATE parameter default was
    written as the string 'CURRENT_DATE', which Unity Catalog cannot cast to DATE. Checked live: current_date(),
    current_timestamp() and date_sub(current_date(), 30) install unquoted, a bare CURRENT_DATE does not, a quoted date does."""
    def default(value, data_type):
        lines = ah._emit_mv_parameters_yaml([{"name": "p", "data_type": data_type, "default": value}], 2)
        return next(line.split("default: ", 1)[1] for line in lines if "default: " in line)
    assert default("CURRENT_DATE", "DATE") == "current_date()"
    assert default("'CURRENT_DATE'", "date") == "current_date()"
    assert default("current_timestamp()", "TIMESTAMP") == "current_timestamp()"
    assert default("date_sub(current_date(), 30)", "DATE") == "date_sub(current_date(), 30)"
    assert default("2024-01-01", "DATE") == "\"'2024-01-01'\""
    assert default("CURRENT_DATE", "STRING") == "\"'CURRENT_DATE'\""
    assert default("USD", "STRING") == "\"'USD'\""
    assert default("0.1", "DOUBLE") == "0.1"


def test_a_dimension_gets_only_a_temporal_or_boolean_format():
    """Live r16b 2277631092136: six customer views installed as row-count fallbacks with COLUMN_FORMAT_INCOMPATIBLE_WITH_COLUMN_TYPE,
    because the LLM gave STRING dimensions such as Account Status a number format. Checked live: a number format on a STRING
    column is rejected, a date format needs date_format and a date_time format needs date_format and time_format."""
    products = {"loyalty_account": {"table_name": "loyalty_account", "domain": "customer", "product": "loyalty_account"}}
    columns = {"loyalty_account": {"columns": {"loyalty_account_id", "account_status", "enrolled_on", "points_balance"},
                                   "string_columns": {"account_status"}, "boolean_columns": set(), "col_rewrite_map": {}}}
    spec = {"metric_views": [{"view_name": "metrics_loyalty_account", "source_product": "loyalty_account",
                              "dimensions": [{"name": "account_status", "display_name": "Account Status", "expr": "account_status",
                                              "format": {"type": "number", "decimal_places": {"type": "all"}}},
                                             {"name": "enrolled_on", "display_name": "Enrolled On", "expr": "enrolled_on", "format": {"type": "date"}}],
                              "measures": [{"name": "Points", "expr": "SUM(points_balance)", "format": {"type": "number"}}]}]}
    out = ah._render_metric_sql_for_domain_from_llm_spec("cat", "customer", "customer", spec, products, LOG, product_columns=columns, config={})
    text = "\n".join(out[0] if isinstance(out, tuple) else out)
    status = text.split('name: "account_status"', 1)[1].split("- name:", 1)[0]
    enrolled = text.split('name: "enrolled_on"', 1)[1].split("measures:", 1)[0]
    points = text.split('name: "Points"', 1)[1]
    assert "format:" not in status
    assert "type: date" in enrolled and "date_format: year_month_day" in enrolled
    assert "type: number" in points
