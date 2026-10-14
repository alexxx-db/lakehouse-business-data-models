"""v5.3.3 live round 21 (r21e 452334240754641) findings, and decision 2A.

r21e rendered the yearly ingredient cost report with its p_fiscal_year parameter, but the column check dropped every measure
that used the parameter, so the view shipped with only the row-count placeholder and still counted as designed. The boolean
aggregate cast turned SUM(CASE WHEN ... THEN line_cost ELSE 0 END) into SUM(CAST(CASE ... AS INT)), which truncates the sum.
The requirement parse dropped the quotes of date_trunc('month', ...), and the KPI-first mandate passed that text on as the
exact measure, so the sign-ups view failed and fell back. Decision 2A: in a vibe modeling of version, a metric view that an
add, change or drop requirement names is in scope on its own; the tables stay frozen.
"""
import copy
import logging
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402
from published_models import published_json  # noqa: E402
from test_v345_behavioral import _exec_mv_prune  # noqa: E402

LOG = logging.getLogger("test_v533_round16")
SRC = notebook_concat_source()
RAW = published_json()
VOV = "vibe modeling of version"
SIGNUP_QUOTED = "COUNT(CASE WHEN date_trunc('month', signed_up_at) = date_trunc('month', current_date()) THEN 1 END)"
SIGNUP_UNQUOTED = "COUNT(CASE WHEN date_trunc(month, signed_up_at) = date_trunc(month, current_date()) THEN 1 END)"


@pytest.fixture(autouse=True)
def _reset(monkeypatch):
    monkeypatch.setattr(ah, "logger", LOG, raising=False)
    ah._VREQ_SPECS.clear()
    ah.set_vibe_scope_runtime(None)
    yield
    ah._VREQ_SPECS.clear()
    ah.set_vibe_scope_runtime(None)


def _render(measures, parameters=None, metric_filter=""):
    products = {"ingredient_stock": {"table_name": "ingredient_stock", "domain": "production", "product": "ingredient_stock"}}
    columns = {"ingredient_stock": {"columns": {"ingredient_stock_id", "fiscal_year", "line_cost", "status"}, "string_columns": {"status"},
                                    "boolean_columns": set(), "col_rewrite_map": {}}}
    spec = {"metric_views": [{"view_name": "production_yearly_ingredient_cost_report", "source_product": "ingredient_stock", "comment": "Yearly cost",
                              "filter": metric_filter, "parameters": parameters or [], "joins": [],
                              "dimensions": [{"name": "fiscal_year", "expr": "fiscal_year", "comment": "c"}], "measures": measures}]}
    out = ah._render_metric_sql_for_domain_from_llm_spec("cat", "production", "production", spec, products, LOG, product_columns=columns, config={})
    return "\n".join(out[0] if isinstance(out, tuple) else out)


PARAM = [{"name": "p_fiscal_year", "data_type": "INT", "default": "YEAR(CURRENT_DATE)"}]


def test_a_conditional_sum_is_not_cast_to_int():
    for expr in ("SUM(CASE WHEN status = 'paid' THEN line_cost ELSE 0 END)", "AVG(CASE WHEN fiscal_year = p_fiscal_year THEN line_cost END)",
                 "SUM(CASE WHEN status IS NULL THEN line_cost END)"):
        assert "AS INT" not in ah._sanitize_metric_measure_expr(expr).upper(), expr
    assert "CAST(is_active AS INT)" in ah._sanitize_metric_measure_expr("SUM(is_active)")
    assert "AS INT" in ah._sanitize_metric_measure_expr("SUM(qty <= reorder_point)").upper()


def test_a_measure_or_filter_that_uses_a_declared_parameter_survives_the_column_check():
    text = _render([{"name": "cost_in_year", "expr": "SUM(CASE WHEN fiscal_year = p_fiscal_year THEN line_cost ELSE 0 END)", "comment": "c"},
                    {"name": "ghost", "expr": "SUM(no_such_column)", "comment": "c"}], PARAM, "fiscal_year <= p_fiscal_year")
    assert [m["name"] for m in ah._mv_yaml_items(text, "measures")] == ["cost_in_year"]
    assert "filter: fiscal_year <= p_fiscal_year" in text
    assert "AS INT" not in text and ah._MV_ROWCOUNT_FALLBACK_COMMENT not in text
    without = _render([{"name": "cost_in_year", "expr": "SUM(CASE WHEN fiscal_year = p_fiscal_year THEN line_cost ELSE 0 END)", "comment": "c"}])
    assert [m["name"] for m in ah._mv_yaml_items(without, "measures")] == ["Row Count"]


def test_a_view_left_with_no_designed_measure_is_a_rowcount_placeholder(caplog):
    with caplog.at_level(logging.WARNING):
        text = _render([{"name": "ghost", "expr": "SUM(no_such_column)", "comment": "c"}])
    assert f'comment: "{ah._MV_ROWCOUNT_FALLBACK_COMMENT}: no designed measure survived the column checks"' in text
    assert ah._mv_rowcount_fallback_names([{"view_name": "production_yearly_ingredient_cost_report", "sql": text}]) == {"production_yearly_ingredient_cost_report"}
    assert any("[mv-render-rowcount-placeholder FIRED v5.3.3] production/" in r.getMessage() for r in caplog.records)
    assert ah._MV_ROWCOUNT_FALLBACK_COMMENT in _render([])
    assert ah._MV_ROWCOUNT_FALLBACK_COMMENT not in _render([{"name": "total_cost", "expr": "SUM(line_cost)", "comment": "c"}])


def test_the_apply_prune_keeps_a_reference_to_a_declared_parameter():
    stmt = ("CREATE OR REPLACE VIEW `c`.`_metrics`.`v`\nWITH METRICS\nLANGUAGE YAML\nAS $$\nversion: 1.1\nsource: `c`.`hr`.`position`\n"
            "  parameters:\n    - name: p_fiscal_year\n      data_type: INT\n      default: YEAR(current_date())\n"
            "  dimensions:\n    - name: \"Year\"\n      expr: fiscal_year\n"
            "  measures:\n    - name: \"Cost In Year\"\n      expr: SUM(CASE WHEN fiscal_year = p_fiscal_year THEN line_cost ELSE 0 END)\n"
            "    - name: \"Ghost\"\n      expr: SUM(ghost_column)\n$$")
    kept, drops, _renames = _exec_mv_prune()(stmt, {"fiscal_year", "line_cost", "position_id"})
    assert len(kept) == 1
    assert "Cost In Year" in kept[0] and "Ghost" not in kept[0]
    assert "p_fiscal_year" in kept[0]


def test_the_install_counts_a_placeholder_view_as_a_rowcount_fallback(monkeypatch, caplog):
    placeholder = ("CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_empty` WITH METRICS LANGUAGE YAML AS $$\n  version: 1.1\n"
                   f"  comment: \"{ah._MV_ROWCOUNT_FALLBACK_COMMENT}: no designed measure survived the column checks\"\n  source: \"`cat`.`sales`.`t`\"\n$$")
    designed = "CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_full` WITH METRICS LANGUAGE YAML AS $$\n  version: 1.1\n  source: \"`cat`.`sales`.`t`\"\n$$"
    assert ah._mv_placeholder_names([placeholder, designed]) == ["sales_empty"]
    monkeypatch.setitem(ah.__dict__, "execute_sql", lambda *a, **k: None)
    with caplog.at_level(logging.INFO):
        out = ah.execute_metric_views_in_parallel_no_halt(None, [placeholder, designed], LOG, 2, None, known_fallbacks=ah._mv_placeholder_names([placeholder, designed]))
    assert out["rowcount_fallbacks"] == ["sales_empty"] and out["failed"] == []
    assert any("all 2 created, 1 as designed and 1 as row-count fallback" in r.getMessage() for r in caplog.records)
    for site in ("known_fallbacks=_mv_placeholder_names(metric_view_statements),", "known_fallbacks=_mv_placeholder_names(_j_metric_stmts)"):
        assert site in SRC


def test_the_requirement_parse_copies_sql_verbatim():
    prompt = ah.PROMPT_TEMPLATES["VIBE_PARSE_PROMPT"]
    assert ("`original_text`: The full, self-contained requirement text (MUST be understandable in isolation); copy every SQL expression, "
            "name and quoted value the user writes exactly as written, quotes included") in prompt


def test_a_measure_matches_when_the_requirement_text_lost_its_quotes():
    text = "  measures:\n    - name: \"new_sign_ups_this_month\"\n      expr: " + SIGNUP_QUOTED + "\n"
    assert ah._mv_detail_present("measure", {"view": "", "name": "", "expr": SIGNUP_UNQUOTED}, text)
    assert ah._mv_detail_present("measure", {"view": "", "name": "", "expr": SIGNUP_QUOTED}, text)
    assert not ah._mv_detail_present("measure", {"view": "", "name": "", "expr": SIGNUP_UNQUOTED.replace("month", "year")}, text)


def _views():
    others = [m for m in RAW["model"]["metric_views"] if m.get("owner_domain") not in ("crew", "")]
    return others[0], others[1], others[2]


def _register(*specs):
    vs.register(ah, RAW, *specs)
    assert all(ah.vreq_spec(s["id"])["interpretable"] for s in specs)


def _fence():
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), RAW, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    return fence


def test_a_view_a_requirement_names_is_in_scope_while_its_tables_stay_frozen():
    drop_v, change_v, other = _views()
    fence = _fence()
    assert fence.is_frozen_metric_view(drop_v) and fence.is_frozen_metric_view(change_v)
    assert drop_v["view_name"] in {fence._active.idx["mvs"][k]["view_name"] for k in fence._active.frozen_mvs}
    table = [f"{other['owner_domain']}.{other['owner_product']}"]
    _register(vs.spec("VREQ-001", "drop_metric_view", table, metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-002", "change_metric_view", table, metric_views=[change_v["view_name"].split("_", 1)[1].replace("_", " ")]),
              vs.spec("VREQ-003", "add_metric_view", table, metric_views=["weekly fuel burn by aircraft"]))
    assert not fence.is_frozen_metric_view(drop_v) and not fence.is_frozen_metric_view(change_v) and fence.is_frozen_metric_view(other)
    live = {fence._active.idx["mvs"][k]["view_name"] for k in fence._active.frozen_mvs}
    assert drop_v["view_name"] not in live and change_v["view_name"] not in live and other["view_name"] in live
    new_view = {"view_name": f"{other['owner_domain']}_weekly_fuel_burn_by_aircraft", "owner_domain": other["owner_domain"], "owner_product": other["owner_product"]}
    assert not fence.is_frozen_metric_view(new_view)
    assert fence.is_frozen_metric_view(dict(new_view, view_name=f"{other['owner_domain']}_something_else"))
    assert fence.is_frozen_product(change_v["owner_domain"], change_v["owner_product"])
    assert fence.is_frozen_product(drop_v["owner_domain"], drop_v["owner_product"])


def test_a_dropped_view_is_not_put_back_and_a_change_that_did_not_land_keeps_the_base_view():
    drop_v, change_v, other = _views()
    fence = _fence()
    table = [f"{other['owner_domain']}.{other['owner_product']}"]
    _register(vs.spec("VREQ-001", "drop_metric_view", table, metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-002", "change_metric_view", table, metric_views=[change_v["view_name"]]))
    model = copy.deepcopy(RAW)
    model["model"]["metric_views"] = [m for m in model["model"]["metric_views"] if m["view_name"] not in (drop_v["view_name"], change_v["view_name"])]
    domains, products, attributes, mvs = ah.model_to_widgets_flat(model)
    fence.checkpoint("after_metric_views", domains, products, attributes, mvs, LOG)
    names = [m["view_name"] for m in mvs]
    assert drop_v["view_name"] not in names
    assert names.count(change_v["view_name"]) == 1
    regenerated = copy.deepcopy(RAW)
    for m in regenerated["model"]["metric_views"]:
        if m["view_name"] == change_v["view_name"]:
            m["sql"] = m["sql"].replace("version: ", "version:  ", 1)
            m["description"] = "regenerated with the requested change"
    regenerated["model"]["metric_views"] = [m for m in regenerated["model"]["metric_views"] if m["view_name"] != drop_v["view_name"]]
    domains, products, attributes, mvs = ah.model_to_widgets_flat(regenerated)
    fence.checkpoint("after_metric_views", domains, products, attributes, mvs, LOG)
    kept = [m for m in mvs if m["view_name"] == change_v["view_name"]]
    assert len(kept) == 1 and kept[0]["description"] == "regenerated with the requested change"
    assert drop_v["view_name"] not in [m["view_name"] for m in mvs]
    removed = ah._vibe_scope_removed_metric_views(fence, ah.widgets_flat_to_model(domains, products, attributes, mvs))
    assert [m["view_name"] for m in removed] == [drop_v["view_name"]]


def test_view_resolution_is_unique_or_nothing():
    names = ["sales_daily_revenue", "sales_daily_revenue_by_store", "finance_revenue_recognition"]
    assert ah._vreq_spec_resolve_view("daily revenue", names) == "sales_daily_revenue"
    assert ah._vreq_spec_resolve_view("revenue recognition", names) == "finance_revenue_recognition"
    assert ah._vreq_spec_resolve_view("revenue", names) is None
    assert ah._vreq_spec_resolve_view("", names) is None


def test_kpi_first_skips_a_dropped_view_and_the_merge_filters_it(monkeypatch):
    drop_v, _change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))
    assert ah._vreq_spec_drops_view(drop_v["view_name"]) and ah._vreq_spec_drops_view(drop_v["view_name"].split("_", 1)[1])
    assert not ah._vreq_spec_drops_view(other["view_name"])
    kept_stmt = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{other['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    drop_stmt = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{drop_v['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    wv = {"_mv_kept_before_gapfill": [], "metric_view_statements": [], "_metric_view_records": []}
    stmts, recs = ah._merge_metric_view_generations(wv, [kept_stmt, drop_stmt], [{"view_name": other["view_name"]}, {"view_name": drop_v["view_name"]}], LOG)
    assert stmts == [kept_stmt] and recs == [{"view_name": other["view_name"]}]
    kpi = SRC[SRC.index("def step_generate_kpi_first_metric_views("):]
    kpi = kpi[:kpi.index("\ndef ", 10)]
    assert kpi.index("if _vreq_spec_drops_view(kpi.get('view_name') or ''):") < kpi.index("        mv_shape = {")


def test_the_change_mandate_carries_the_base_definition():
    _drop_v, change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-002", "change_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[change_v["view_name"]],
                      reason="add a query parameter for the report period"))
    assert change_v["view_name"] in ah._vreq_spec_metric_view_names()
    lines = ah._vreq_spec_change_lines()
    assert len(lines) == 1
    line = lines[0]
    assert f"exists as view_name {change_v['view_name']} with owner_domain {change_v['owner_domain']} and primary_product {change_v['owner_product']}" in line
    first_measure = ah._mv_yaml_items(change_v["sql"], "measures")[0]
    assert f"{first_measure['name']} = {first_measure['expr']}" in line
    assert line.endswith("change only what the requirement asks (add a query parameter for the report period)")
    assert line in ah._vreq_spec_metric_view_detail_lines()
    ah.set_vibe_scope_runtime(None)
    assert ah._vreq_spec_change_lines() == []


def test_the_live_frozen_view_set_follows_specs_registered_after_the_fence():
    drop_v, _change_v, other = _views()
    fence = _fence()
    before = set(fence._active.frozen_mvs)
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))
    after = set(fence._active.frozen_mvs)
    assert before - after == {k for k in before if fence._active.idx["mvs"][k]["view_name"] == drop_v["view_name"]}
    ah._VREQ_SPECS.clear()
    assert set(fence._active.frozen_mvs) == before


def test_a_view_requirement_does_not_open_its_table_and_a_view_only_vibe_still_builds_a_fence():
    import types
    drop_v, change_v, other = _views()
    table = f"{other['owner_domain']}.{other['owner_product']}"
    _register(vs.spec("VREQ-001", "drop_metric_view", [table], metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-002", "change_metric_view", [table], metric_views=[change_v["view_name"]]))
    reqs = [types.SimpleNamespace(vreq_id="VREQ-001"), types.SimpleNamespace(vreq_id="VREQ-002")]
    spec, wide = ah._vibe_scope_requested_spec(reqs, RAW)
    assert spec is not None and spec.mode == "requested" and spec.entries == () and wide == []
    fence = ah.build_vibe_scope_fence(spec, RAW, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    assert fence.is_frozen_product(other["owner_domain"], other["owner_product"])
    assert not fence.is_frozen_metric_view(drop_v) and not fence.is_frozen_metric_view(change_v) and fence.is_frozen_metric_view(other)
    _register(vs.spec("VREQ-003", "set_fields", [table], fields=[vs.field("products", "description")], field_values=[]))
    mixed, _wide = ah._vibe_scope_requested_spec(reqs + [types.SimpleNamespace(vreq_id="VREQ-003")], RAW)
    assert mixed.entries == (table,)


def test_a_window_without_an_order_is_not_emitted():
    """Live r22a 548569728863809: the regenerated order_sales_order failed with 'Cannot coerce empty String ("") to WindowSpec',
    because a window entry without an order rendered as a bare '-' item; the install then fell back to a row count."""
    assert ah._emit_mv_window_yaml([{}], 6) == []
    assert ah._emit_mv_window_yaml([{"order": "", "range": "trailing 7 day"}], 6) == []
    assert ah._emit_mv_window_yaml([{"order": "order_date", "range": "trailing 7 day"}, {}], 6) == [
        "      window:", "        - order: order_date", "          range: trailing 7 day"]


def test_the_triage_keeps_a_requirement_that_names_a_view_in_scope():
    """Live r22a: the triage rejected all three view requirements as out of scope, because their tables are frozen."""
    import types
    drop_v, change_v, other = _views()
    table = f"{other['owner_domain']}.{other['owner_product']}"
    _register(vs.spec("VREQ-001", "drop_metric_view", [table], metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-002", "change_metric_view", [table], metric_views=[change_v["view_name"]]),
              vs.spec("VREQ-003", "add_metric_view", [table], metric_views=["weekly fuel burn by aircraft"]))
    reqs = [types.SimpleNamespace(vreq_id=v, target=table, intent="") for v in ("VREQ-001", "VREQ-002", "VREQ-003")]
    spec, _wide = ah._vibe_scope_requested_spec(reqs, RAW)
    fence = ah.build_vibe_scope_fence(spec, RAW, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, reqs, RAW, LOG)
    assert [r.vreq_id for r in kept] == ["VREQ-001", "VREQ-002", "VREQ-003"] and rejected == [] and outcomes == []
    ambiguous = dict(ah.vreq_spec("VREQ-002"), metric_views=["baggage"])
    assert ah._vreq_spec_views_in_scope(fence, ambiguous) is False
    assert ah._vreq_spec_views_in_scope(fence, dict(ah.vreq_spec("VREQ-002"), interpretable=False)) is False


def test_a_drop_removes_the_view_from_every_run_list(caplog):
    drop_v, _change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))
    keep_sql = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{other['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    drop_sql = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{drop_v['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    wv = {"metric_views": [copy.deepcopy(drop_v), copy.deepcopy(other)], "_metric_view_records": [{"view_name": drop_v["view_name"]}, {"view_name": other["view_name"]}],
          "metric_view_statements": [drop_sql, keep_sql], "metric_view_count": 2}
    with caplog.at_level(logging.INFO):
        assert ah._vreq_spec_apply_view_drops(wv, LOG) == [drop_v["view_name"]]
    assert [m["view_name"] for m in wv["metric_views"]] == [other["view_name"]]
    assert wv["_metric_view_records"] == [{"view_name": other["view_name"]}]
    assert wv["metric_view_statements"] == [keep_sql] and wv["metric_view_count"] == 1
    assert any("[mv-spec-drop FIRED v5.3.3] removed 1 metric view(s)" in r.getMessage() for r in caplog.records)
    ah.set_vibe_scope_runtime(None)
    untouched = {"metric_views": [copy.deepcopy(drop_v)]}
    assert ah._vreq_spec_apply_view_drops(untouched, LOG) == [] and len(untouched["metric_views"]) == 1
    main = SRC[SRC.index("def main("):]
    assert main.index("_vreq_spec_apply_view_drops(widgets_values, logger)") < main.index('_vibe_scope_checkpoint_widgets("after_metric_views", widgets_values, logger)')


def test_the_exact_view_list_loses_a_view_a_requirement_drops(monkeypatch, caplog):
    """Live r22a: the sizing read 'exactly 3 metric views' from the three named views, so KPI-first was told to produce
    order_note, the view the user asked to drop."""
    drop_v, _change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))

    class _Stop(Exception):
        pass

    def _stop(*a, **k):
        raise _Stop()
    monkeypatch.setitem(ah.__dict__, "_vibe_exact_metric_view_directive", lambda wv: (2, [drop_v["view_name"], "weekly fuel burn by aircraft"]))
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_model_summary", lambda *a, **k: "summary")
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_fk_summary", _stop)
    wv = {"logger": LOG, "config": {"TARGET_CATALOG": "cat"}, "domains": [{"domain": other["owner_domain"]}],
          "products": [{"domain": other["owner_domain"], "product": other["owner_product"]}], "attributes": []}
    with caplog.at_level(logging.INFO), pytest.raises(_Stop):
        ah.step_generate_kpi_first_metric_views(wv)
    assert wv["_exact_mv_names"] == ["weekly fuel burn by aircraft"] and wv["_exact_mv_count"] == 1
    assert any("[mv-exact-spec-drop FIRED v5.3.3]" in r.getMessage() for r in caplog.records)


def test_a_window_without_an_order_is_not_emitted():
    """Live r22a 548569728863809: the regenerated order_sales_order failed with 'Cannot coerce empty String ("") to WindowSpec',
    because a window entry without an order rendered as a bare '-' item; the install then fell back to a row count."""
    assert ah._emit_mv_window_yaml([{}], 6) == []
    assert ah._emit_mv_window_yaml([{"order": "", "range": "trailing 7 day"}], 6) == []
    assert ah._emit_mv_window_yaml([{"order": "order_date", "range": "trailing 7 day"}, {}], 6) == [
        "      window:", "        - order: order_date", "          range: trailing 7 day"]


def test_the_triage_keeps_a_requirement_that_names_a_view_in_scope():
    """Live r22a: the triage rejected all three view requirements as out of scope, because their tables are frozen."""
    import types
    drop_v, change_v, other = _views()
    table = f"{other['owner_domain']}.{other['owner_product']}"
    _register(vs.spec("VREQ-001", "drop_metric_view", [table], metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-002", "change_metric_view", [table], metric_views=[change_v["view_name"]]),
              vs.spec("VREQ-003", "add_metric_view", [table], metric_views=["weekly fuel burn by aircraft"]))
    reqs = [types.SimpleNamespace(vreq_id=v, target=table, intent="") for v in ("VREQ-001", "VREQ-002", "VREQ-003")]
    spec, _wide = ah._vibe_scope_requested_spec(reqs, RAW)
    fence = ah.build_vibe_scope_fence(spec, RAW, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, reqs, RAW, LOG)
    assert [r.vreq_id for r in kept] == ["VREQ-001", "VREQ-002", "VREQ-003"] and rejected == [] and outcomes == []
    ambiguous = dict(ah.vreq_spec("VREQ-002"), metric_views=["baggage"])
    assert ah._vreq_spec_views_in_scope(fence, ambiguous) is False
    assert ah._vreq_spec_views_in_scope(fence, dict(ah.vreq_spec("VREQ-002"), interpretable=False)) is False


def test_a_drop_removes_the_view_from_every_run_list(caplog):
    drop_v, _change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))
    keep_sql = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{other['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    drop_sql = f"CREATE OR REPLACE VIEW `c`.`_metrics`.`{drop_v['view_name']}` WITH METRICS LANGUAGE YAML AS $$\n$$"
    wv = {"metric_views": [copy.deepcopy(drop_v), copy.deepcopy(other)], "_metric_view_records": [{"view_name": drop_v["view_name"]}, {"view_name": other["view_name"]}],
          "metric_view_statements": [drop_sql, keep_sql], "metric_view_count": 2}
    with caplog.at_level(logging.INFO):
        assert ah._vreq_spec_apply_view_drops(wv, LOG) == [drop_v["view_name"]]
    assert [m["view_name"] for m in wv["metric_views"]] == [other["view_name"]]
    assert wv["_metric_view_records"] == [{"view_name": other["view_name"]}]
    assert wv["metric_view_statements"] == [keep_sql] and wv["metric_view_count"] == 1
    assert any("[mv-spec-drop FIRED v5.3.3] removed 1 metric view(s)" in r.getMessage() for r in caplog.records)
    ah.set_vibe_scope_runtime(None)
    untouched = {"metric_views": [copy.deepcopy(drop_v)]}
    assert ah._vreq_spec_apply_view_drops(untouched, LOG) == [] and len(untouched["metric_views"]) == 1
    main = SRC[SRC.index("def main("):]
    assert main.index("_vreq_spec_apply_view_drops(widgets_values, logger)") < main.index('_vibe_scope_checkpoint_widgets("after_metric_views", widgets_values, logger)')


def test_the_exact_view_list_loses_a_view_a_requirement_drops(monkeypatch, caplog):
    """Live r22a: the sizing read 'exactly 3 metric views' from the three named views, so KPI-first was told to produce
    order_note, the view the user asked to drop."""
    drop_v, _change_v, other = _views()
    _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", [f"{other['owner_domain']}.{other['owner_product']}"], metric_views=[drop_v["view_name"]]))

    class _Stop(Exception):
        pass

    def _stop(*a, **k):
        raise _Stop()
    monkeypatch.setitem(ah.__dict__, "_vibe_exact_metric_view_directive", lambda wv: (2, [drop_v["view_name"], "weekly fuel burn by aircraft"]))
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_model_summary", lambda *a, **k: "summary")
    monkeypatch.setitem(ah.__dict__, "_build_compact_global_fk_summary", _stop)
    wv = {"logger": LOG, "config": {"TARGET_CATALOG": "cat"}, "domains": [{"domain": other["owner_domain"]}],
          "products": [{"domain": other["owner_domain"], "product": other["owner_product"]}], "attributes": []}
    with caplog.at_level(logging.INFO), pytest.raises(_Stop):
        ah.step_generate_kpi_first_metric_views(wv)
    assert wv["_exact_mv_names"] == ["weekly fuel burn by aircraft"] and wv["_exact_mv_count"] == 1
    assert any("[mv-exact-spec-drop FIRED v5.3.3]" in r.getMessage() for r in caplog.records)


def test_a_bare_date_unit_is_quoted_unless_a_column_has_that_name(caplog):
    """Live r24a 305574473456938: the changed order_return_case and the new order_refunds_by_channel both failed with
    UNRESOLVED_COLUMN month at the first argument of DATE_TRUNC; Databricks reads a bare unit there as a column."""
    with caplog.at_level(logging.INFO):
        assert ah._mv_quote_date_units("DATE_TRUNC(month, requested_timestamp)", {"requested_timestamp"}, LOG, "order/v") == "DATE_TRUNC('month', requested_timestamp)"
    assert any("[mv-date-unit-quote FIRED v5.3.3] order/v: quoted the date unit(s) ['month']" in r.getMessage() for r in caplog.records)
    assert ah._mv_quote_date_units("COUNT(CASE WHEN date_trunc(month, a) = date_trunc(month, current_date()) THEN 1 END)") == SIGNUP_QUOTED.replace("signed_up_at", "a")
    assert ah._mv_quote_date_units("date_part(year, created_at)") == "date_part('year', created_at)"
    assert ah._mv_quote_date_units("DATE_TRUNC('month', ts)") == "DATE_TRUNC('month', ts)"
    assert ah._mv_quote_date_units("DATE_TRUNC(month, ts)", {"month", "ts"}) == "DATE_TRUNC(month, ts)"
    assert ah._mv_quote_date_units("EXTRACT(MONTH FROM ts)") == "EXTRACT(MONTH FROM ts)"
    products = {"return_case": {"table_name": "return_case", "domain": "order", "product": "return_case"}}
    columns = {"return_case": {"columns": {"return_case_id", "requested_timestamp"}, "string_columns": set(), "boolean_columns": set(), "col_rewrite_map": {}}}
    spec = {"metric_views": [{"view_name": "order_return_case", "source_product": "return_case", "comment": "c", "filter": "", "joins": [],
                              "dimensions": [{"name": "Month", "expr": "DATE_TRUNC(month, requested_timestamp)", "comment": "c"}],
                              "measures": [{"name": "Cases", "expr": "COUNT(DISTINCT return_case_id)", "comment": "c"}]}]}
    out = ah._render_metric_sql_for_domain_from_llm_spec("cat", "order", "order", spec, products, LOG, product_columns=columns, config={})
    assert "expr: DATE_TRUNC('month', requested_timestamp)" in "\n".join(out[0] if isinstance(out, tuple) else out)


def test_a_view_requirement_needs_no_table_target():
    """Live r24a: the orchestrator read the drop and the change as not interpreted ('names no target'), because they name only
    the view; the verifier then scored both failed although the drop landed."""
    idx = ah._vreq_spec_index(RAW)
    drop_v, change_v, _other = _views()
    for action, names in (("drop_metric_view", [drop_v["view_name"]]), ("change_metric_view", [change_v["view_name"]]), ("add_metric_view", ["weekly fuel burn"])):
        assert ah._normalize_vreq_spec(vs.spec("VREQ-009", action, metric_views=names), idx)["interpretable"] is True, action
    assert ah._normalize_vreq_spec(vs.spec("VREQ-009", "drop_metric_view"), idx)["interpretable"] is False
    assert ah._normalize_vreq_spec(vs.spec("VREQ-009", "drop_product"), idx)["interpretable"] is False


def test_the_final_outcomes_score_a_view_requirement_on_the_final_views():
    """Live r26a 525405185877634: the drop, the change and the add all landed and the physical audit scored 3 of 3, but the
    scope outcomes said 0 percent in-scope adherence, because the engine applies no view action and the reconcile checked
    landing on a model rebuilt without metric views."""
    drop_v, _change_v, other = _views()
    fence = _fence()
    _register(vs.spec("VREQ-001", "drop_metric_view", metric_views=[drop_v["view_name"]]),
              vs.spec("VREQ-003", "add_metric_view", metric_views=["weekly fuel burn by aircraft"]))
    model = copy.deepcopy(RAW)
    model["model"]["metric_views"] = [m for m in model["model"]["metric_views"] if m["view_name"] != drop_v["view_name"]]
    d, p, a, mv = ah.model_to_widgets_flat(model)
    wv = {"operation": VOV, "domains": d, "products": p, "attributes": a, "metric_views": mv,
          "_vov_2_raw_vreqs": [{"vreq_id": "VREQ-001", "intent": "Drop the view", "target": "", "source_quote": ""},
                               {"vreq_id": "VREQ-003", "intent": "Add the view", "target": "", "source_quote": ""}],
          "_vov_vreq_status": {"VREQ-001": {"status": "not_addressed", "reason": ""}, "VREQ-003": {"status": "not_addressed", "reason": ""}},
          "_vibe_scope_outcomes": {"in_scope_vreq_count": 2, "adherence_in_scope_pct": 0.0, "scope_rejected": []}}
    ah._vov_reconcile_final_outcomes(wv, LOG)
    assert wv["_vov_vreq_status"]["VREQ-001"]["status"] == "applied"
    assert wv["_vov_vreq_status"]["VREQ-003"]["status"] == "not_addressed"
    assert fence is ah.get_vibe_scope_runtime()


def test_the_change_mandate_keeps_the_base_parameters():
    _drop_v, change_v, other = _views()
    base = copy.deepcopy(RAW)
    for m in base["model"]["metric_views"]:
        if m["view_name"] == change_v["view_name"]:
            m["sql"] = m["sql"].replace("  dimensions:", "  parameters:\n    - name: p_min_weight_kg\n      data_type: DOUBLE\n      default: 0\n  dimensions:", 1)
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    vs.register(ah, base, vs.spec("VREQ-002", "change_metric_view", metric_views=[change_v["view_name"]], reason="add p_min_packages"))
    line = ah._vreq_spec_change_lines()[0]
    assert "keep its parameters ['p_min_weight_kg DOUBLE default 0'], dimensions" in line
