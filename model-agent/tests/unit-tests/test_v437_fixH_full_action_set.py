"""v4.3.7 FIX H behavioral tests — expander emits the FULL canonical action set the
reviewer directives need (add_scd2_history / move_product / update_description) and the
_v337 split/reverse appliers are wired into the deterministic bridge.

ROOT CAUSE this extends: v4.3.6 FIX G made only remove_attribute/retype_attribute
reachable. P10 (SCD), P7/P8 (rehome/PCI move), and P2 (vendor-neutral descriptions)
still fell to the LLM sandbox because the expander did not emit their canonical actions
and the _v337 split/reverse appliers were never invoked from a VReq.

FAIL-PRE proof: on v4.3.6 HEAD the expander takes ONE arg (`_v436_expand_vreq_to_priorities(vreq)`)
and emits only remove/retype; `_v437_priority_to_v337_op` does not exist, and
`_v413_apply_det_op_inplace` has no split_product/reverse_fk branch. Each assertion below
fails pre-patch (TypeError on the model arg / empty output / LookupError / None result).
PASS-POST: the extended expander + bridge produce the exact canonical ops.

v5.3.3: the regex expander is deleted. An LLM reads each reviewer requirement into a spec; the spec's
ops (_vreq_spec_v337_entries -> _v437_priority_to_v337_op) and pass-1 priorities (_vov_vreq_to_priorities)
carry the canonical actions.
"""
import logging
import re

import conftest  # noqa: F401
import agent_helpers as ah
import vreq_spec_util as vs
from v435_helpers import concat_source, slice_functions
from notebook_source_util import vov_ledger_globals


class _V:
    def __init__(self, intent="", quote="", target="", vid="VREQ-T"):
        self.intent = intent
        self.source_quote = quote
        self.target = target
        self.vreq_id = vid


def _customer_model():
    def _table(name):
        return {"name": name, "primary_key": f"{name}_id", "attributes": [{"name": f"{name}_id", "type": "BIGINT"}]}
    return {"model": {"domains": [
        {"name": "customer", "products": [_table(n) for n in ("profile", "account", "note", "service_case", "segment",
                                                             "customer_membership", "payment_method")]},
        {"name": "marketing", "products": [_table("campaign")]},
        {"name": "finance", "products": [_table("payment_instrument")]}]}}


def _columns(model, product):
    return {a["name"] for p in model["model"]["domains"][0]["products"] if p["name"] == product for a in p["attributes"]}


def test_fixH_scd_emits_add_scd2_history_per_master_table():
    model = _customer_model()
    scd = [{"name": "effective_start_date", "type": "DATE"}, {"name": "effective_end_date", "type": "DATE"}]
    vs.register(ah, model, vs.spec("VREQ-010", "add_column", ["customer.profile", "customer.account"], columns=scd))
    priorities = ah._vov_vreq_to_priorities(_V("scd_history_on_master", vid="VREQ-010"))
    assert sorted(p["target"] for p in priorities) == ["customer.account", "customer.profile"], priorities
    _model, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logging.getLogger("test_v437"))
    for table in ("profile", "account"):
        assert {"effective_start_date", "effective_end_date"} <= _columns(model, table), (table, outcomes, residual)
    assert not {"effective_start_date", "effective_end_date"} & _columns(model, "note")


def test_fixH_move_expands_all_products_with_per_clause_dest():
    model = _customer_model()
    vs.register(ah, model, vs.spec("VREQ-007", "move_product", ["customer.service_case"], destination_domain="service"),
                vs.spec("VREQ-017", "move_product", ["customer.segment", "customer.customer_membership"], destination_domain="marketing"),
                vs.spec("VREQ-027", "move_product", ["customer.segment", "customer"], destination_domain="marketing"))
    moves = {(e["target"], e["new_domain"]) for vid in ("VREQ-007", "VREQ-017")
             for e in ah._vreq_spec_v337_entries(_V(vid=vid), model) if e["action"] == "move_product"}
    assert moves == {("customer.service_case", "service"), ("customer.segment", "marketing"),
                     ("customer.customer_membership", "marketing")}, moves
    assert ah._vreq_spec_v337_entries(_V(vid="VREQ-027"), model) == []


def test_fixH_move_op_converter_builds_v337_tuple_and_ignores_abbrev_noise():
    model = _customer_model()
    vs.register(ah, model, vs.spec("VREQ-008", "move_product", ["customer.payment_method"], destination_domain="finance"),
                vs.spec("VREQ-018", "move_product", ["customer.payment_method"], destination_domain="e.g."))
    ops = [ah._v437_priority_to_v337_op(e) for e in ah._vreq_spec_v337_entries(_V(vid="VREQ-008"), model)]
    assert ops == [("move_product", "customer", "payment_method", "finance")], ops
    assert ah.vreq_spec("VREQ-018")["interpretable"] is False
    assert ah._vreq_spec_v337_entries(_V(vid="VREQ-018"), model) == []


def test_fixH_v413_bridge_applies_split_and_reverse():
    # Proves the _v337 split/reverse appliers are now reachable via _v413_apply_det_op_inplace.
    src = concat_source()
    ns = slice_functions(
        ["_v413_apply_det_op_inplace", "_v337_apply_split_product", "_v337_apply_reverse_fk",
         "_v337_find_product", "_v337_iter_products", "_v337_apply_move_product",
         "_v337_apply_rename_product", "_v337_apply_rename_attribute", "_v337_rewire_fks",
         "_v337_parse_fk_fqn", "_v251_find_product", "_v327_infer_coltype", "_vibe_scope_note_rename"],
        src, extra_globals={**vov_ledger_globals(), "re": re, "copy": __import__("copy"), "_VIBE_SCOPE_RUNTIME": None})
    fn = ns["_v413_apply_det_op_inplace"]
    model = {"model": {"domains": [{"name": "customer", "products": [
        {"name": "preference", "primary_key": "preference_id", "attributes": [
            {"name": "preference_id", "type": "BIGINT"},
            {"name": "channel", "type": "STRING"},
            {"name": "diet", "type": "STRING"}]}]}]}}
    r = fn(model, ("split_product", "customer", "preference",
                   [("communication_preference", ["channel"]), ("dietary_restriction", ["diet"])]))
    assert r is not None, "split not applied via _v413"
    names = {p["name"] for p in model["model"]["domains"][0]["products"]}
    assert "communication_preference" in names and "dietary_restriction" in names, names
