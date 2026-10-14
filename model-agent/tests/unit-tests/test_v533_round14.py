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


def test_a_resize_asks_kpi_first_for_the_designed_views_of_carried_placeholders(monkeypatch, caplog):
    """Live r16c 379035090945153: the shrink carried the ECM's six report views as the row-count placeholders the ECM install had
    left, counted them as designed and never regenerated them; KPI-first also appended production_ingredient_stock_health next to
    the carried view of the same name, so model.json held 36 views for 35 names."""
    import json
    import types
    placeholder = f"CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_daily_sales_by_shop_and_product` AS $$ comment: \"{ah._MV_ROWCOUNT_FALLBACK_COMMENT}\" source: cat.sales.shop_sale $$"
    table_placeholder = f"CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_shop_sale` AS $$ comment: \"{ah._MV_ROWCOUNT_FALLBACK_COMMENT}\" source: cat.sales.shop_sale $$"
    base = {"model": {"domains": [], "metric_views": [
        {"view_name": "sales_daily_sales_by_shop_and_product", "owner_domain": "sales", "owner_product": "shop_sale", "sql": placeholder},
        {"view_name": "sales_shop_sale", "owner_domain": "sales", "owner_product": "shop_sale", "sql": table_placeholder},
        {"view_name": "sales_revenue_by_channel", "owner_domain": "sales", "owner_product": "shop_sale",
         "sql": "CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_revenue_by_channel` AS $$ source: cat.sales.shop_sale $$"}]}}
    sdk = types.ModuleType("databricks.sdk")
    sdk.WorkspaceClient = lambda *a, **k: object()
    monkeypatch.setitem(sys.modules, "databricks", sys.modules.get("databricks") or types.ModuleType("databricks"))
    monkeypatch.setitem(sys.modules, "databricks.sdk", sdk)
    monkeypatch.setitem(ah.__dict__, "read_file_for_ddl", lambda path, w: json.dumps(base))
    wv = {"operation": "shrink ecm", "source_version": "1", "source_model_scope": "ecm", "current_version": "1", "model_scope": "mvm",
          "products": [{"domain": "sales", "product": "shop_sale"}]}
    with caplog.at_level(logging.INFO):
        ah._resize_carry_base_metric_views(wv, {"TARGET_VOLUME": "/Volumes/c/s/v/bakery/v1/mvm"}, LOG)
    assert len(wv["_metric_view_records"]) == 3
    assert wv["_resize_regenerate_mv_names"] == ["daily sales by shop and product"]
    assert any("1 carried view(s) are row-count placeholders" in r.getMessage() for r in caplog.records)


def test_kpi_first_replaces_a_view_of_the_same_name_and_reads_the_resize_names():
    body = SRC[SRC.index("def step_generate_kpi_first_metric_views("):]
    body = body[:body.index("\ndef ", 10)]
    assert '_redo_mv_names = [n for n in widgets_values.get("_resize_regenerate_mv_names") or [] if n not in _spec_mv_names]' in body
    assert body.index("_spec_mv_names = _spec_mv_names + _redo_mv_names") < body.index("widgets_values['_required_mv_names'] = _spec_mv_names")
    append = body[body.index("if statements_total:"):]
    assert "if _extract_metric_view_name_from_statement(s).strip().lower() not in _kpi_fresh]" in append
    assert 'str(r.get("view_name") or "").strip().lower() in _kpi_fresh)]' in append


def test_the_install_reports_carried_placeholders_as_fallbacks():
    body = SRC[SRC.index("def step_apply_metric_views("):]
    body = body[:body.index("\ndef ", 10)]
    seed = body.index('_mv_rowcount_fb = list(metric_exec_result.get("rowcount_fallbacks") or [])')
    assert body.index("if _MV_ROWCOUNT_FALLBACK_COMMENT in str(s)} - set(_mv_rowcount_fb))", seed) < body.index('widgets_values["_mv_rowcount_fallbacks"] = _mv_rowcount_fb', seed)
    statements = [f"CREATE OR REPLACE VIEW `c`.`_metrics`.`a` AS $$ comment: \"{ah._MV_ROWCOUNT_FALLBACK_COMMENT}\" $$",
                  "CREATE OR REPLACE VIEW `c`.`_metrics`.`b` AS $$ comment: \"designed\" $$"]
    carried = sorted({ah._extract_metric_view_name_from_statement(s) for s in statements if ah._MV_ROWCOUNT_FALLBACK_COMMENT in str(s)} - set())
    assert carried == ["a"]


def test_an_enlarge_keeps_the_tables_its_plan_lists_for_a_new_domain():
    """Live r16d 1008476504045950: the enlarge plan listed 107 tables (tier target about 100), but every new domain was also queued
    for product generation, which added 15 to 20 tables to each of the 5 new domains; the model reached 212 tables."""
    body = SRC[SRC.index("    def _run_resize_model(widgets_values, direction):"):]
    body = body[:body.index("\n    def ", 10)]
    branch = body[body.index("for new_domain in new_domains_from_llm:"):body.index("for expansion in expanded_existing:")]
    assert 'if not (new_domain.get("products") or []):\n                    domains_needing_products.append(new_dom_rec)' in branch
    assert branch.count("domains_needing_products.append(") == 1
    assert "[resize-seed-plan-kept FIRED v5.3.3]" in body


def _registry_rows(fake, table):
    return [r for key, rows in fake.rows.items() if key.endswith(f"._metamodel.{table}") for r in rows]


def test_an_install_into_another_catalog_keeps_the_versions_first_deployment(capsys):
    """Live r17e 842714421575815: install model r14b put advertising v55 into vibe_dryrun_installed_v1 and rewrote v55's registry rows
    with that catalog, so v55's own schemas in vibe_dryrun_smoke_v2 had no owner and the next VOV there was refused."""
    import v514_feedback_util as fu
    fake = fu.register(fu.FakeSpark(), "mm_cat", install_catalog="cat_a")
    for row in _registry_rows(fake, "business"):
        row["deploy_status"] = None
    for row in _registry_rows(fake, "domain"):
        row["catalog"] = None
    capsys.readouterr()
    result = fu.register(fake, "mm_cat", install_catalog="cat_b").last_result
    printed = capsys.readouterr().out
    assert result["success"] and result["kept_deployments"] == ["cat_a"]
    business = sorted((r.get("catalog"), r.get("deploy_status")) for r in _registry_rows(fake, "business"))
    assert business == [("cat_a", None), ("cat_b", "installed")]
    domains = sorted({r.get("catalog") for r in _registry_rows(fake, "domain")})
    assert domains == ["cat_a", "cat_b"]
    per_catalog = {c: len([r for r in _registry_rows(fake, "domain") if r.get("catalog") == c]) for c in domains}
    assert per_catalog["cat_a"] == per_catalog["cat_b"] > 0
    products = len(_registry_rows(fake, "product"))
    assert "[install-registry-keeps-deployment FIRED v5.3.3] Airlines v1 (mvm) is also deployed in ['cat_a']" in printed
    fu.register(fake, "mm_cat", install_catalog="cat_b")
    assert sorted(r.get("catalog") for r in _registry_rows(fake, "business")) == ["cat_a", "cat_b"]
    assert len([r for r in _registry_rows(fake, "domain") if r.get("catalog") == "cat_b"]) == per_catalog["cat_b"]
    assert len(_registry_rows(fake, "product")) == products
    assert ah._registry_undo_failed_install(fake, "mm_cat", "Airlines", "1", "mvm", None, LOG, catalog="cat_b", kept=["cat_a"]) is True
    assert [r.get("catalog") for r in _registry_rows(fake, "business")] == ["cat_a"]
    assert {r.get("catalog") for r in _registry_rows(fake, "domain")} == {"cat_a"}


def test_an_install_into_the_versions_own_catalog_still_rewrites_its_rows():
    import v514_feedback_util as fu
    fake = fu.register(fu.FakeSpark(), "mm_cat", install_catalog="cat_a")
    result = fu.register(fake, "mm_cat", install_catalog="cat_a").last_result
    assert result["kept_deployments"] == []
    assert [r.get("catalog") for r in _registry_rows(fake, "business")] == ["cat_a"]


def test_a_parameter_default_calls_current_date_as_a_function():
    """Live r17d 1106403598347709: two views fell back with 'default value must be a constant expression, got: YEAR(CURRENT_DATE)'.
    Checked live: YEAR(current_date()) is accepted for an INT parameter and YEAR(CURRENT_DATE) is not."""
    def default(value, data_type):
        lines = ah._emit_mv_parameters_yaml([{"name": "p", "data_type": data_type, "default": value}], 2)
        return next(line.split("default: ", 1)[1] for line in lines if "default: " in line)
    assert default("YEAR(CURRENT_DATE)", "INT") == "YEAR(current_date())"
    assert default("year(current_date())", "INT") == "year(current_date())"
    assert default("date_sub(CURRENT_DATE, 30)", "DATE") == "date_sub(current_date(), 30)"
    assert default("CURRENT_TIMESTAMP", "TIMESTAMP") == "current_timestamp()"
    assert default("CURRENT_DATE", "STRING") == "\"'CURRENT_DATE'\""


def test_a_count_measure_never_gets_a_date_format():
    """Live r17d: customer_active_customer_count fell back with 'Column New Registrations has date/time format which is incompatible
    with column type LONG'."""
    counted = "COUNT(CASE WHEN date_trunc('month', registered_at) = date_trunc('month', current_date()) THEN 1 END)"
    assert (ah._infer_mv_format("New Registrations", counted) or {}).get("type") != "date"
    assert ah._infer_mv_format("First Registration", "MIN(registered_at)", "DATE")["type"] == "date"
    assert ah._infer_mv_format("Registration Month", "date_trunc('month', registered_at)", None, is_dimension=True)["type"] == "date"
    products = {"profile": {"table_name": "profile", "domain": "customer", "product": "profile"}}
    columns = {"profile": {"columns": {"profile_id", "registered_at"}, "string_columns": set(), "boolean_columns": set(), "col_rewrite_map": {}}}
    spec = {"metric_views": [{"view_name": "metrics_profile", "source_product": "profile",
                              "dimensions": [{"name": "registered_at", "display_name": "Registered At", "expr": "registered_at"}],
                              "measures": [{"name": "New Registrations", "expr": "COUNT(profile_id)", "format": {"type": "date"}},
                                           {"name": "First Registration", "expr": "MIN(registered_at)", "format": {"type": "date"}}]}]}
    out = ah._render_metric_sql_for_domain_from_llm_spec("cat", "customer", "customer", spec, products, LOG, product_columns=columns, config={})
    text = "\n".join(out[0] if isinstance(out, tuple) else out)
    count_block = text.split('name: "New Registrations"', 1)[1].split("- name:", 1)[0]
    first_block = text.split('name: "First Registration"', 1)[1]
    assert "type: date" not in count_block
    assert "type: date" in first_block and "date_format: year_month_day" in first_block


def test_a_requested_value_matches_whatever_the_trailing_period_and_spacing():
    """Live r18a 286160361756502, r17a 161181967549574 and r18g 954079209332463: the asked description landed as written plus a closing
    period, or with an article the spec value left out, and the spec verifier scored it 0/1 because it compared the strings exactly."""
    spec = {"action": "set_fields", "tags": [], "field_values": {("products", "description"): "one physical parcel sent to a customer address,  with its carrier and tracking"}}
    landed = {"description": "One physical parcel sent to a customer address, with its carrier and tracking."}
    other = {"description": "A parcel."}
    assert ah._verify_spec_value_ok(spec, "products", "description", landed) is True
    assert ah._verify_spec_value_ok(spec, "products", "description", other) is False
    worded = {"action": "set_fields", "tags": [], "field_values": {("products", "description"): "customer request to send items back for a refund or exchange"}}
    r18g = {"description": "A customer request to send items back for a refund or an exchange."}
    old = {"description": "Manages customer return requests, including reason, disposition, refund amounts, and resolution status."}
    assert ah._verify_spec_value_ok(worded, "products", "description", r18g) is True
    assert ah._verify_spec_value_ok(worded, "products", "description", old) is False
    steward = {"action": "set_fields", "tags": [], "field_values": {("products", "steward"): "order desk"}}
    assert ah._verify_spec_value_ok(steward, "products", "steward", {"steward": "Order Desk."}) is True
    assert ah._verify_spec_value_ok(steward, "products", "steward", {"steward": "the order desk team"}) is False


def test_an_exact_view_list_keeps_the_views_the_requirement_specs_name(monkeypatch, caplog):
    """Live r18e 484205915066667: the sizing directive read 'exactly 2 metric views' for the two new reports, KPI-first produced only
    those, and the four report views the same vibe asked for were missing (0/4 named metric views exist)."""
    class _Stop(Exception):
        pass

    def _stop(*a, **k):
        raise _Stop()
    monkeypatch.setitem(ah.__dict__, "_vibe_exact_metric_view_directive", lambda wv: (2, ["yearly ingredient cost report", "new loyalty sign-ups this month"]))
    monkeypatch.setitem(ah.__dict__, "_vreq_spec_metric_view_names",
                        lambda: ["daily sales by shop and product", "yearly ingredient cost report", "pre-order volumes by pickup day"])
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_model_summary", lambda *a, **k: "summary")
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_fk_summary", _stop)
    wv = {"logger": LOG, "config": {"TARGET_CATALOG": "cat"}, "domains": [{"domain": "sales"}],
          "products": [{"domain": "sales", "product": "shop_sale"}], "attributes": []}
    with caplog.at_level(logging.INFO), pytest.raises(_Stop):
        ah.step_generate_kpi_first_metric_views(wv)
    assert wv["_exact_mv_names"] == ["yearly ingredient cost report", "new loyalty sign-ups this month",
                                     "daily sales by shop and product", "pre-order volumes by pickup day"]
    assert wv["_exact_mv_count"] == 4
    assert any("[mv-exact-spec-union FIRED v5.3.3] the exact view list missed 2 view(s)" in r.getMessage() for r in caplog.records)
