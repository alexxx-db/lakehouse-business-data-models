"""v5.3.3 shrink audit (r14a 542978771773870) findings.

The per-domain metric-view step replaced the list KPI-first had just appended to, so no KPI-first view ever shipped (9 of 9 lost
in the shrink, 0 of 100 views in the advertising lane were KPI views). A shrink or an enlarge regenerated its metric views from
scratch, so the four report views the ECM user had asked for were gone from the MVM although every table they read survived.
"""
import json
import logging
import sys
import types
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

LOG = logging.getLogger("test_v533_round13")
SRC = notebook_concat_source()


@pytest.fixture(autouse=True)
def _reset(monkeypatch):
    monkeypatch.setattr(ah, "logger", LOG, raising=False)
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    yield
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()


def _stmt(name, body="x"):
    return f"CREATE OR REPLACE VIEW `cat`.`_metrics`.`{name}`\nWITH METRICS\nLANGUAGE YAML\nAS $$\n  version: 1.1\n  comment: \"{body}\"\n$$"


def _rec(name, domain="sales", product="shop_sale", body="x"):
    return {"view_name": name, "owner_domain": domain, "owner_product": product, "sql": _stmt(name, body)}


def _body(stmt):
    return stmt.split('comment: "', 1)[1].split('"', 1)[0]


def test_the_per_domain_step_keeps_the_kpi_views_and_adds_its_own(caplog):
    wv = {"metric_view_statements": [_stmt("total_revenue_by_channel"), _stmt("sales_shop_sale", "base")],
          "_metric_view_records": [_rec("total_revenue_by_channel"), _rec("sales_shop_sale", body="base")],
          "_mv_kept_before_gapfill": ["total_revenue_by_channel"]}
    with caplog.at_level(logging.INFO):
        stmts, recs = ah._merge_metric_view_generations(wv, [_stmt("sales_pre_order")], [_rec("sales_pre_order", product="pre_order")], LOG)
    assert [ah._extract_metric_view_name_from_statement(s) for s in stmts] == ["total_revenue_by_channel", "sales_pre_order"]
    assert [r["view_name"] for r in recs] == ["total_revenue_by_channel", "sales_pre_order"]
    assert any("[mv-gapfill-merge FIRED v5.3.3] kept 1 metric view(s)" in r.getMessage() for r in caplog.records)


def test_a_view_the_per_domain_step_regenerates_replaces_the_earlier_one():
    wv = {"metric_view_statements": [_stmt("sales_shop_sale", "carried")], "_metric_view_records": [_rec("sales_shop_sale", body="carried")],
          "_mv_kept_before_gapfill": ["sales_shop_sale"]}
    stmts, recs = ah._merge_metric_view_generations(wv, [_stmt("sales_shop_sale", "regenerated")], [_rec("sales_shop_sale", body="regenerated")], LOG)
    assert [_body(s) for s in stmts] == ["regenerated"]
    assert [_body(r["sql"]) for r in recs] == ["regenerated"]


def test_views_not_produced_in_this_run_are_still_replaced_as_before():
    wv = {"metric_view_statements": [_stmt("sales_shop_sale", "base")], "_metric_view_records": [_rec("sales_shop_sale", body="base")]}
    stmts, recs = ah._merge_metric_view_generations(wv, [_stmt("sales_pre_order")], [_rec("sales_pre_order", product="pre_order")], LOG)
    assert [ah._extract_metric_view_name_from_statement(s) for s in stmts] == ["sales_pre_order"]
    assert [r["view_name"] for r in recs] == ["sales_pre_order"]


class _Writer:
    def emit_step(self, *a, **k):
        return None


def test_the_metric_view_step_ships_kpi_views_next_to_per_domain_views(monkeypatch):
    monkeypatch.setitem(ah.__dict__, "_build_domain_metric_sql_artifacts_with_llm",
                        lambda *a, **k: ({"sales": _stmt("sales_pre_order")}, [_stmt("sales_pre_order")], [_rec("sales_pre_order", product="pre_order")]))
    monkeypatch.setitem(ah.__dict__, "write_to_dbfs", lambda *a, **k: None)
    monkeypatch.setitem(ah.__dict__, "_get_file_sql_name", lambda *a, **k: "biz")
    wv = {"logger": LOG, "config": {"TARGET_CATALOG": "cat", "TARGET_VOLUME": "/Volumes/c/s/v/biz/v1/mvm"}, "vibe_writer": _Writer(),
          "domains": [{"domain": "sales", "database_name": "sales", "division": "business"}],
          "products": [{"domain": "sales", "product": "shop_sale"}, {"domain": "sales", "product": "pre_order"}], "attributes": [],
          "metric_view_statements": [_stmt("total_revenue_by_channel")], "_metric_view_records": [_rec("total_revenue_by_channel")],
          "_mv_kept_before_gapfill": ["total_revenue_by_channel"]}
    ah.step_generate_metric_view_artifacts(wv)
    assert sorted(r["view_name"] for r in wv["_metric_view_records"]) == ["sales_pre_order", "total_revenue_by_channel"]
    assert wv["metric_view_count"] == 2


def test_kpi_first_registers_the_views_it_rendered():
    body = SRC[SRC.index("def step_generate_kpi_first_metric_views("):]
    body = body[:body.index("\ndef ", 10)]
    append = body.index('widgets_values["_metric_view_records"] = list(existing_records) + list(records_total)')
    assert body.index('widgets_values["_mv_kept_before_gapfill"]', append) > append


def _base_model():
    return {"model": {"domains": [], "metric_views": [
        {"view_name": "sales_daily_sales_by_shop_and_product", "owner_domain": "sales", "owner_product": "shop_sale",
         "sql": "CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_daily_sales_by_shop_and_product` AS $$ source: cat.sales.shop_sale $$"},
        {"view_name": "sales_gift_card_liability", "owner_domain": "sales", "owner_product": "gift_card",
         "sql": "CREATE OR REPLACE VIEW `cat`.`_metrics`.`sales_gift_card_liability` AS $$ source: cat.sales.gift_card $$"},
    ]}}


def _fake_sdk(monkeypatch, reads):
    sdk = types.ModuleType("databricks.sdk")
    sdk.WorkspaceClient = lambda *a, **k: object()
    monkeypatch.setitem(sys.modules, "databricks", sys.modules.get("databricks") or types.ModuleType("databricks"))
    monkeypatch.setitem(sys.modules, "databricks.sdk", sdk)
    monkeypatch.setitem(ah.__dict__, "read_file_for_ddl", lambda path, w: reads.append(path) or json.dumps(_base_model()))


def test_a_shrink_carries_the_base_views_whose_tables_survive(monkeypatch, caplog):
    reads = []
    _fake_sdk(monkeypatch, reads)
    wv = {"operation": "shrink ecm", "source_version": "1", "source_model_scope": "ecm", "current_version": "1", "model_scope": "mvm",
          "products": [{"domain": "sales", "product": "shop_sale"}, {"domain": "sales", "product": "pre_order"}]}
    cfg = {"TARGET_VOLUME": "/Volumes/c/_metamodel/vol_root/business/bakery/v1/mvm"}
    with caplog.at_level(logging.INFO):
        ah._resize_carry_base_metric_views(wv, cfg, LOG)
    assert reads == ["/Volumes/c/_metamodel/vol_root/business/bakery/v1/ecm/model.json"]
    assert [r["view_name"] for r in wv["_metric_view_records"]] == ["sales_daily_sales_by_shop_and_product"]
    assert wv["_mv_kept_before_gapfill"] == ["sales_daily_sales_by_shop_and_product"]
    assert wv["metric_view_count"] == 1
    assert any("[resize-mv-carry FIRED v5.3.3] shrink ecm carries 1 metric view(s) of the v1/ecm base" in r.getMessage() for r in caplog.records)


def test_a_resize_without_a_source_scope_carries_nothing(monkeypatch):
    reads = []
    _fake_sdk(monkeypatch, reads)
    wv = {"operation": "enlarge mvm", "source_version": "1", "current_version": "1", "model_scope": "ecm",
          "products": [{"domain": "sales", "product": "shop_sale"}]}
    ah._resize_carry_base_metric_views(wv, {"TARGET_VOLUME": "/Volumes/c/s/v/bakery/v1/ecm"}, LOG)
    assert reads == [] and "_metric_view_records" not in wv and "_mv_kept_before_gapfill" not in wv


def test_the_surgical_path_still_reads_the_previous_version_of_the_same_scope(monkeypatch):
    reads = []
    _fake_sdk(monkeypatch, reads)
    wv = {"operation": "vibe modeling of version", "base_version_for_review": "3", "current_version": "4", "model_scope": "mvm",
          "products": [{"domain": "sales", "product": "shop_sale"}]}
    ah._preserve_baseline_metric_views_for_surgical(wv, {"TARGET_VOLUME": "/Volumes/c/s/v/bakery/v4/mvm"}, LOG)
    assert reads == ["/Volumes/c/s/v/bakery/v3/mvm/model.json"]


def test_main_carries_the_resize_base_views_before_kpi_first_runs():
    body = SRC[SRC.index("\ndef main():"):]
    carry = body.index("_resize_carry_base_metric_views(widgets_values, config, logger)")
    gate = body.rindex('if widgets_values.get("operation") in ("shrink ecm", "enlarge mvm"):', 0, carry)
    assert carry - gate < 120
    assert carry < body.index("step_generate_kpi_first_metric_views(widgets_values)", carry)
    assert body.rindex("if not _surgical_fast_path:", 0, carry) > body.rindex("_vibe_scope_settle_subdomains", 0, carry)
