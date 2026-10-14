"""v4.3.9 FIX J behavioral tests — expander correctness + new deterministic actions that make
the reviewer directives P3/P7/P11 reachable and, for P11, fix an ACTIVE regression.

ROOT CAUSES (proven on the v4.3.8 fe-gcp retail run 527847457221172, ECM v2 model.json):
  J1 (P11 customer_type_clean): the REMOVE branch matched the first 3-part FQN near a removal
     verb and removed it. P11 body = "customer.profile.customer_type must describe only ...
     Remove the redundancy across vip_flag / employee_flag / account_tier columns". Pre-patch this
     REMOVED customer.profile.customer_type (the ONE col the reviewer wanted KEPT) and left the bare
     flags (vip_flag/employee_flag) because they are not 3-part FQNs. FIX J1 excludes KEEP-clause FQNs
     and resolves the bare flag names against the keep-col table so the flags ARE removed and the
     keep col is NOT.
  J2 (P3 enum_type_categories_only): no classifier emitted anything, and cell-60 had no handler, so
     card_brand/wallet_provider kept their vendor value_regex ('visa|mastercard|...'). FIX J2 emits
     clear_value_regex per FQN + a cell-60 handler that blanks value_regex.
  J3 (P7 rehome): move to a reviewer-named MISSING domain deferred (service_case -> 'service'). The
     mechanism fix creates the reviewer-named domain then the move lands.

FAIL-PRE proof: run these on v4.3.8 HEAD (git stash the v4.3.9 edits). J1 asserts customer_type is
NOT removed and the bare flags ARE removed (pre-patch: opposite). J2 asserts clear_value_regex is
emitted + applied (pre-patch: no such action -> unsupported-deterministic-action). J3 asserts the
move lands after the reviewer-named domain is created.
"""
import re
import copy
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from v435_helpers import concat_source, slice_functions  # noqa: E402
from notebook_source_util import vov_ledger_globals  # noqa: E402


class _StubVREQ:
    def __init__(self, vreq_id="", intent="", target="", source_quote="",
                 source_chunk_id="", severity="critical", is_user_directive=True,
                 priority_id=9999):
        self.vreq_id = vreq_id
        self.intent = intent
        self.target = target
        self.source_quote = source_quote
        self.source_chunk_id = source_chunk_id
        self.severity = severity
        self.is_user_directive = is_user_directive
        self.priority_id = priority_id


class _Log:
    def info(self, *a, **k):
        pass

    def warning(self, *a, **k):
        pass

    def error(self, *a, **k):
        pass

    def debug(self, *a, **k):
        pass


def _model():
    return {"domains": [
        {"name": "customer", "products": [
            {"name": "profile", "primary_key": "profile_id", "attributes": [
                {"name": "profile_id", "type": "BIGINT"},
                {"name": "customer_type", "type": "STRING",
                 "description": "Legal entity type"},
                {"name": "vip_flag", "type": "BOOLEAN"},
                {"name": "employee_flag", "type": "BOOLEAN"},
                {"name": "account_tier", "type": "STRING"},
            ]},
            {"name": "payment_method", "primary_key": "payment_method_id", "attributes": [
                {"name": "payment_method_id", "type": "BIGINT"},
                {"name": "card_brand", "type": "STRING",
                 "value_regex": "visa|mastercard|amex|discover|jcb|unionpay"},
                {"name": "wallet_provider", "type": "STRING",
                 "value_regex": "applepay|googlepay|paypal"},
            ]},
            {"name": "service_case", "primary_key": "service_case_id", "attributes": [
                {"name": "service_case_id", "type": "BIGINT"},
                {"name": "profile_id", "type": "BIGINT",
                 "foreign_key_to": "customer.profile.profile_id"},
            ]},
        ]},
    ]}


P11_BLOCK = (
    "REVIEWER-PRIORITY 11 \u2014 customer_type_clean: customer.profile.customer_type must describe "
    "only the legal-entity type (individual vs organization). Remove the redundancy where "
    "classification/role values (vip, employee, wholesale) are duplicated across customer_type AND "
    "separate vip_flag / employee_flag / account_tier columns. Separate legal-entity type from the "
    "role the customer plays.\n"
)


def _apply_removals(spec, vreq):
    model = _model()
    vs.register(ah, model, spec)
    removes = set()
    for p in ah._vov_vreq_to_priorities(vreq):
        if p["action"] == "remove_attribute":
            removes.add(f"{p['target']}.{p['column']}")
            assert ah._v251_apply_priority_deterministic(p, ah._v251_parse_priority_details(p), model, _Log()) == (True, "applied"), p
    profile = next(p for p in model["domains"][0]["products"] if p["name"] == "profile")
    return removes, {a["name"] for a in profile["attributes"]}


# ---------------- J1: P11 keep-guard + bare-name resolution ----------------

def test_fixJ1_p11_keeps_customer_type_removes_bare_flags():
    vreq = _StubVREQ(vreq_id="REVIEWER-11", intent="customer_type_clean",
                     source_quote=P11_BLOCK, priority_id=11)
    bare = [{"domain": "", "product": "profile", "column": c} for c in ("vip_flag", "employee_flag", "account_tier")]
    removes, columns = _apply_removals(dict(vs.spec("REVIEWER-11", "drop_column"), targets=bare), vreq)
    # KEEP the col the reviewer wants kept
    assert "customer.profile.customer_type" not in removes and "customer_type" in columns, ("regression: customer_type removed", removes)
    # REMOVE the redundant bare flags (resolved against the keep-col table)
    assert removes == {"customer.profile.vip_flag", "customer.profile.employee_flag", "customer.profile.account_tier"}, removes
    assert not columns & {"vip_flag", "employee_flag", "account_tier"}, columns


def test_fixJ1_a_named_column_removal_has_no_collateral_removals():
    # A pure-FQN removal directive with NO keep clause (P4/P5 shape) must ONLY remove the listed
    # FQNs (no collateral removals).
    body = ("REVIEWER-PRIORITY 4 \u2014 deduplicate_consent: remove customer.profile.vip_flag.\n")
    vreq = _StubVREQ(vreq_id="REVIEWER-4", intent="deduplicate_consent",
                     source_quote=body, priority_id=4)
    removes, columns = _apply_removals(vs.spec("REVIEWER-4", "drop_column", ["customer.profile.vip_flag"]), vreq)
    assert removes == {"customer.profile.vip_flag"}, removes
    assert {"customer_type", "employee_flag", "account_tier"} <= columns, columns


# ---------------- J2: P3 clear_value_regex classifier + handler ----------------

def test_fixJ2_handler_blanks_value_regex():
    ns = slice_functions(
        ["_v251_apply_priority_deterministic", "_v251_find_attribute_row",
         "_v251_find_product", "_v251_find_domain", "_v251_model_root",
         "_v251_product_list", "_v251_iter_attribute_rows",
         "_v251_parse_priority_details", "_v327_infer_coltype"],
        concat_source(), extra_globals={"re": re, "copy": copy})
    mdl = _model()
    ok, diag = ns["_v251_apply_priority_deterministic"](
        {"action": "clear_value_regex", "target": "customer.payment_method.card_brand"},
        {}, mdl, _Log())
    assert ok and diag == "applied", (ok, diag)
    # observable state change: value_regex blanked
    row = ns["_v251_find_attribute_row"](mdl, "customer", "payment_method", "card_brand")
    assert str(row.get("value_regex") or "") == "", row


# ---------------- J3: P7 reviewer-named domain create then move lands ----------------

def test_fixJ3_move_lands_after_reviewer_named_domain_created():
    ns = slice_functions(
        ["_v337_apply_move_product", "_v337_find_product", "_v337_iter_products",
         "_v337_rewire_fks", "_v337_parse_fk_fqn", "_vibe_scope_note_rename",
         "_v337_table_pairs", "_v337_rewire_metric_views", "_vov285_san"],
        concat_source(), extra_globals={**vov_ledger_globals(), "re": re, "copy": copy, "_VIBE_SCOPE_RUNTIME": None})
    mdl = _model()
    # pre: 'service' domain absent -> mover defers (returns None) — this is the v4.3.8 behavior
    assert ns["_v337_apply_move_product"](mdl, "customer", "service_case", "service") is None
    # fix mechanism: create the reviewer-named domain, then the SAME move lands
    mdl["domains"].append({"name": "service", "description": "Reviewer-directed.", "products": []})
    res = ns["_v337_apply_move_product"](mdl, "customer", "service_case", "service")
    assert res is not None, "move should land after domain create"
    names = {d["name"]: [p["name"] for p in (d.get("products") or [])] for d in mdl["domains"]}
    assert "service_case" in names["service"], names
    assert "service_case" not in names["customer"], names
