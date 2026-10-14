"""v4.4.6 behavioral tests for the generic agent capability gaps automotive surfaced (CLAUDE.md 8.10).

GAP-1 (HIGH): the surgical-VOV outcome-scope guard discarded an additive new-domain-with-products
batch as scope_mismatch because the batch summary omitted explicit "create domain" phrasing, even
though a USER-KING domain_creates / reviewer add_domain VREQ mandated the first-class domain. Fix:
the outcome-scope guard (now `diff_within_requirement_scope`) permits a new domain that a requirement spec of the
batch creates (add_domain, add_product, a rename, merge or move destination).

GAP-4 (LOW): `ai_query` returns SQL NULL -> None on timeout; `_call_ai_query` then called len() on it
and raised `TypeError: object of type 'NoneType' has no len()`. Fix: `_v446_coerce_ai_response`.

Fail-pre proof: on the committed v4.4.5 notebook `_vov446_allowed_new_domains` /
`_v446_coerce_ai_response` do not exist (slice raises LookupError) and `diff_within_summary_scope`
has no `allowed_new_domains` kwarg (TypeError) -> every test below errors. git-stash the notebook ->
FAIL; pop -> PASS.

Generic: uses a NON-automotive domain name ("field_services" is generic; the tests also use
"telemetry_ops") and never hardcodes an industry.
"""
import re
import sys
from pathlib import Path

import pytest

from v435_helpers import concat_source, slice_functions
from notebook_source_util import pk_suffix_globals

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


def _gate(diff, *specs):
    ah.vov_ledger_reset()
    vs.register(ah, {"model": {"domains": [{"name": "ops", "products": [{"name": "sensor", "attributes": []}]}]}}, *specs)
    return ah.diff_within_requirement_scope(diff, [s["id"] for s in specs])


def _coerce_ns():
    return slice_functions(["_v446_coerce_ai_response"], concat_source())


def _empty_diff(**over):
    d = {"domains_added": set(), "domains_removed": set(), "products_added": [],
         "products_removed": [], "fks_removed": 0, "fks_added": 0, "metric_views_delta": 0}
    d.update(over)
    return d


class _Row:
    def __init__(self, val):
        self.ai_response = val


# ===================================================== GAP-1
def test_gap1_a_new_domain_its_spec_creates_is_in_scope():
    diff = _empty_diff(domains_added={"field_services"})
    for spec in (vs.spec("V1", "add_domain", ["field_services"]), vs.spec("V1", "add_product", ["field_services.work_order"])):
        ok, diag = _gate(diff, spec)
        assert ok, "a domain the requirement creates must be in scope: %s" % diag


def test_gap1_unauthorized_new_domain_still_rejected():
    diff = _empty_diff(domains_added={"hallucinated_domain"})
    ok, diag = _gate(diff, vs.spec("V1", "add_domain", ["field_services"]))
    assert not ok and "domain hallucinated_domain added" in diag, diag


def test_gap1_without_a_spec_a_domain_add_is_out_of_scope():
    diff = _empty_diff(domains_added={"whatever"})
    ok, diag = ah.diff_within_requirement_scope(diff, ["V-unknown"])
    assert not ok, diag


def test_gap1_only_the_domain_the_spec_names_is_allowed_not_one_the_llm_invented():
    diff = _empty_diff(domains_added={"field_services", "marketing_extra"})
    ok, diag = _gate(diff, vs.spec("V1", "add_domain", ["field_services"]))
    assert not ok and "domain marketing_extra added" in diag and "field_services" not in diag


def test_gap1_a_move_into_a_new_domain_permits_that_domain():
    diff = _empty_diff(domains_added={"telemetry_ops"}, products_added=[("telemetry_ops", "sensor")], products_removed=[("ops", "sensor")])
    ok, diag = _gate(diff, vs.spec("V1", "move_product", ["ops.sensor"], destination_domain="telemetry_ops"))
    assert ok, diag
    ok, diag = _gate(diff, vs.spec("V1", "move_product", ["ops.sensor"], destination_domain="field_services"))
    assert not ok and "domain telemetry_ops added" in diag


# ===================================================== GAP-4
def test_gap4_none_ai_response_coerced_to_empty_string():
    ns = _coerce_ns()
    raw, was_none = ns["_v446_coerce_ai_response"]([_Row(None)])
    assert raw == "" and was_none is True
    # the whole point: len() must not raise
    assert len(raw) == 0


def test_gap4_normal_response_passthrough():
    ns = _coerce_ns()
    raw, was_none = ns["_v446_coerce_ai_response"]([_Row('{"status":"fulfilled"}')])
    assert raw == '{"status":"fulfilled"}' and was_none is False


def test_gap4_empty_rows_safe():
    ns = _coerce_ns()
    raw, was_none = ns["_v446_coerce_ai_response"]([])
    assert raw == "" and was_none is False
    assert len(raw) == 0


# ===================================================== GAP-2
def _connect_ns():
    """Slice _v415_complete_connect_details plus every _v251_*/_v410_* helper it
    transitively calls, so the REAL connect-completion path executes end-to-end."""
    import ast as _ast
    src = concat_source()
    tree = _ast.parse(src)
    helpers = [n.name for n in tree.body
               if isinstance(n, _ast.FunctionDef)
               and (n.name.startswith("_v251_") or n.name.startswith("_v410_"))]
    names = list(dict.fromkeys(helpers + ["_v415_complete_connect_details"]))
    return slice_functions(names, src, extra_globals={"re": re, **pk_suffix_globals()})


def _automotive_connect_model():
    return {"model": {"domains": [
        {"name": "mobility", "products": [
            {"name": "predictive_maintenance_alert", "primary_key": "alert_id",
             "attributes": [{"name": "alert_id", "primary_key": True}]},
            {"name": "connected_vehicle", "primary_key": "connected_vehicle_id",
             "attributes": [{"name": "connected_vehicle_id", "primary_key": True}]}]},
        {"name": "product", "products": [
            {"name": "order_guide", "primary_key": "order_guide_id",
             "attributes": [{"name": "order_guide_id", "primary_key": True}]}]},
        {"name": "aftersales", "products": [
            {"name": "aftersales_repair_order", "primary_key": "repair_order_id",
             "attributes": [{"name": "repair_order_id", "primary_key": True}]},
            {"name": "aftersales_parts_order", "primary_key": "parts_order_id",
             "attributes": [{"name": "parts_order_id", "primary_key": True}]},
            {"name": "service_appointment", "primary_key": "appt_id",
             "attributes": [{"name": "appt_id", "primary_key": True}]}]}]}}


def test_gap2_the_fk_target_comes_from_the_spec_and_completion_only_fills_its_key():
    model = _automotive_connect_model()
    ah.vov_ledger_reset()
    vs.register(ah, model, vs.spec("P001", "add_column", ["mobility.predictive_maintenance_alert.service_order_id"],
                                   columns=[{"name": "service_order_id", "type": ""}], fk_target="aftersales.aftersales_repair_order"))
    pr = {"vreq_id": "P001", "action": "connect_table", "target": "mobility.predictive_maintenance_alert",
          "intent": "add column service_order_id with FK to the aftersales service order table"}
    details = ah._v251_parse_priority_details(pr)
    assert details["fk_target"] == "aftersales.aftersales_repair_order.repair_order_id" and details["column"] == "service_order_id"
    out = ah._v415_complete_connect_details(pr, dict(details, fk_target="aftersales.aftersales_repair_order"), model, None)
    assert out["fk_target"] == "aftersales.aftersales_repair_order.repair_order_id"
    ah.vov_ledger_reset()
    assert ah._v251_parse_priority_details(pr)["fk_target"] is None


def test_gap2_explicit_target_domain_never_disturbed():
    """When the resolved domain IS named in the directive (an explicit 'FK to mobility.connected_vehicle'),
    the correction must NOT fire even though another domain (aftersales, the source table) is in the text."""
    ns = _connect_ns()
    f = ns["_v415_complete_connect_details"]
    pr = {"action": "connect_table", "target": "aftersales.service_appointment",
          "intent": "add connected_vehicle_id to the aftersales service appointment table with FK to mobility.connected_vehicle",
          "source_quote": "FK to mobility.connected_vehicle", "reason": "link"}
    out = f(pr, {"fk_target": "mobility.connected_vehicle.connected_vehicle_id", "column": "connected_vehicle_id"},
            _automotive_connect_model(), None)
    assert out["fk_target"] == "mobility.connected_vehicle.connected_vehicle_id"


def test_gap2_correct_in_domain_resolution_left_alone():
    """A correctly in-domain-resolved FK (both the target and resolved domain are 'aftersales') must
    pass through untouched -- no spurious re-scope when the resolved domain is present in the text."""
    ns = _connect_ns()
    f = ns["_v415_complete_connect_details"]
    pr = {"action": "connect_table", "target": "aftersales.aftersales_parts_order",
          "intent": "add repair_order_id referencing aftersales.aftersales_repair_order",
          "source_quote": "reference aftersales.aftersales_repair_order", "reason": "link"}
    out = f(pr, {"fk_target": "aftersales.aftersales_repair_order.repair_order_id", "column": "repair_order_id"},
            _automotive_connect_model(), None)
    assert out["fk_target"] == "aftersales.aftersales_repair_order.repair_order_id"


# ===================================================== GAP-3
_GAP3_KEEP = ("purchase_order", "purchase_order_line", "purchase_requisition", "supplier", "scheduling_agreement", "goods_receipt",
              "connected_vehicle", "telemetry_event", "predictive_maintenance_alert")


def _gap3_specs(extra=()):
    """The spec an LLM returns for the reviewer's 'keep basic Procurement / the Mobility basics in the MVM' directive."""
    homes = {p: "procurement" for p in _GAP3_KEEP[:6]} | {p: "mobility" for p in _GAP3_KEEP[6:]}
    targets = [{"domain": homes[p], "product": p, "column": ""} for p in _GAP3_KEEP] + [{"domain": d, "product": p, "column": ""} for d, p in extra]
    return [{"action": "preserve", "targets": targets}]


def _gap3_products():
    prods = [{"domain": "procurement", "product": p} for p in
             ("purchase_order", "purchase_order_line", "purchase_requisition", "supplier",
              "scheduling_agreement", "goods_receipt", "rfq")]
    prods += [{"domain": "mobility", "product": p} for p in
              ("connected_vehicle", "telemetry_event", "predictive_maintenance_alert", "geofence")]
    prods += [{"domain": "sales", "product": p} for p in ("sales_order", "quote")]
    return prods


def test_gap3_forcekeep_readds_reviewer_named_mvm_products():
    """The shrink heuristic excluded procurement + mobility entirely; the reviewer's keep directive, read by the LLM
    into a preserve spec, re-adds the 9 reviewer-named products."""
    out = ah._vov_shrink_apply_reviewer_specs({("sales", "sales_order"), ("sales", "quote")}, _gap3_specs(), _gap3_products())
    kept = {p for (_d, p) in out}
    for must in _GAP3_KEEP:
        assert must in kept, must


def test_gap3_does_not_add_products_outside_the_directive():
    """Products the reviewer did NOT name (rfq, geofence) are NOT force-kept, and names absent from products_data
    are never invented."""
    out = ah._vov_shrink_apply_reviewer_specs({("sales", "sales_order")}, _gap3_specs([("procurement", "nonexistent_table")]), _gap3_products())
    assert ("procurement", "rfq") not in out
    assert ("mobility", "geofence") not in out
    assert not any(p == "nonexistent_table" for (_d, p) in out)


def test_gap3_noop_when_no_keep_directive():
    """No reviewer spec -> tables_to_keep returned unchanged."""
    ttk = {("sales", "sales_order"), ("sales", "quote")}
    assert set(ah._vov_shrink_apply_reviewer_specs(ttk, [], _gap3_products())) == ttk


def test_gap3_preserves_input_container_type():
    """Set in -> set out; list in -> list out (call-site passes a set)."""
    assert isinstance(ah._vov_shrink_apply_reviewer_specs({("sales", "sales_order")}, _gap3_specs(), _gap3_products()), set)
    assert isinstance(ah._vov_shrink_apply_reviewer_specs([("sales", "sales_order")], _gap3_specs(), _gap3_products()), list)
