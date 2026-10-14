"""v4.4.0 behavioral tests — the deterministic reviewer-directive fixes, each exercising the
REAL notebook code path (CLAUDE.md 8.10), each proven fail-pre on the v4.3.9 HEAD (git stash the
v4.4.0 edits) and pass-post:

  P6 split_preference_god_table  — vov-split-product: the LLM spec routes the source columns into the
     reviewer-named children; its op runs the reused _v337 split applier, which materializes the 3 child
     tables and keeps every column it was not told to move in the source (no column dropped).
  P9 fk_direction_correctness    — vov-prune-root-fks: cell-60 handler prunes the ROOT domain's
     OUTBOUND cross-domain FKs EXCEPT those to reference/dimension tables. Pre-patch: unsupported action.
  P12 glossary_and_regex_tag_cleanup — vov-tag-cleanup: cell-60 handler clears junk glossary
     (term==TitleCase(col)) + redundant value_regex, in field AND tag_set, KEEPING pii. Pre-patch: unsupported.
  P13 ensure_household_and_mvm_minimalism — the LLM reads the reviewer directive into a keep_only spec;
     _vov_shrink_apply_reviewer_specs restricts that domain to its named MVM tables and never empties it.
"""
import json
import re
import copy

import agent_helpers as ah
import vreq_spec_util as vs
from v435_helpers import concat_source, slice_functions


class _Log:
    def info(self, *a, **k):
        pass

    def warning(self, *a, **k):
        pass

    def error(self, *a, **k):
        pass

    def debug(self, *a, **k):
        pass


# ============================================================ P6 split god-table
def _pref_model():
    return {"domains": [
        {"name": "customer", "products": [
            {"name": "preference", "primary_key": "preference_id", "attributes": [
                {"name": "preference_id", "type": "BIGINT"},
                {"name": "channel_captured", "type": "STRING"},
                {"name": "consent_given", "type": "BOOLEAN"},
                {"name": "opt_out_flag", "type": "BOOLEAN"},
                {"name": "language", "type": "STRING"},
                {"name": "allergy_info", "type": "STRING"},
                {"name": "dietary_restriction_note", "type": "STRING"},
                {"name": "favorite_color", "type": "STRING"},
                {"name": "shoe_size", "type": "STRING"},
            ]},
        ]},
    ]}


P6_SPLIT = [{"product": "communication_preference", "columns": ["channel_captured", "consent_given", "opt_out_flag", "language"]},
            {"product": "dietary_restriction", "columns": ["allergy_info", "dietary_restriction_note"]},
            {"product": "customer_attribute", "columns": ["favorite_color"]}]
P6_CHILDREN = ("communication_preference", "dietary_restriction", "customer_attribute")


def test_p6_split_spec_materializes_child_tables_and_drops_no_column():
    mdl = _pref_model()
    vs.register(ah, {"model": mdl}, vs.spec("REVIEWER-6", "split_product", ["customer.preference"], split_into=P6_SPLIT))
    op = ah._vreq_spec_det_op(ah.vreq_spec("REVIEWER-6"), {"model": mdl})
    assert op == ("split_product", "customer", "preference", [(s["product"], s["columns"]) for s in P6_SPLIT]), op
    source_cols = {a["name"] for a in mdl["domains"][0]["products"][0]["attributes"]}
    res = ah._v337_apply_split_product(mdl, op[1], op[2], op[3])
    assert res is not None, "split should apply"
    prods = {p["name"]: p for p in mdl["domains"][0]["products"]}
    for child in P6_CHILDREN:
        assert child in prods, prods.keys()
        # each child carries the source PK so it links back
        assert any(a["name"] == "preference_id" for a in prods[child]["attributes"]), child
    kept = {a["name"] for a in prods["preference"]["attributes"]}
    routed = {a["name"] for child in P6_CHILDREN for a in prods[child]["attributes"]}
    assert source_cols <= kept | routed, source_cols - kept - routed
    assert "shoe_size" in kept and "favorite_color" not in kept, kept
    d, p, a, _mv = ah.model_to_widgets_flat({"model": mdl}, quiet=True)
    assert ah._verify_from_spec(ah.vreq_spec("REVIEWER-6"), d, p, a)["status"] == "fulfilled"


def test_p6_split_spec_naming_two_tables_builds_no_op():
    idx = ah._vreq_spec_index({"model": _pref_model()})
    spec = ah._normalize_vreq_spec(vs.spec("REVIEWER-6", "split_product", ["customer.preference", "customer.profile"], split_into=P6_SPLIT), idx)
    assert spec["interpretable"] is False, spec
    assert spec["reason"] == "split_product names 2 products but carries one split; each needs its own requirement"
    assert ah._vreq_spec_det_ops(spec, {"model": _pref_model()}) == []


# ============================================================ P9 prune root outbound FKs
def _handler_ns():
    return slice_functions(
        ["_v251_apply_priority_deterministic", "_v251_model_root",
         "_v251_find_attribute_row", "_v251_find_product", "_v533_glossary_is_column_name"],
        concat_source(), extra_globals={"re": re, "copy": copy})


def _fk_model():
    return {"domains": [
        {"name": "customer", "products": [
            {"name": "profile", "primary_key": "profile_id", "attributes": [
                {"name": "profile_id", "type": "BIGINT"},
                {"name": "location_id", "type": "BIGINT", "tags": "foreign_key",
                 "foreign_key_to": "store.location.location_id",
                 "tag_set": [{"key": "foreign_key", "value": ""}]},
                {"name": "order_id", "type": "BIGINT", "tags": "foreign_key",
                 "foreign_key_to": "order.header.order_id",
                 "tag_set": [{"key": "foreign_key", "value": ""}]},
                {"name": "household_id", "type": "BIGINT", "tags": "foreign_key",
                 "foreign_key_to": "customer.household.household_id",
                 "tag_set": [{"key": "foreign_key", "value": ""}]},
            ]},
        ]},
    ]}


def test_p9_prune_handler_keeps_ref_prunes_transaction_keeps_intra():
    ns = _handler_ns()
    mdl = _fk_model()
    ok, diag = ns["_v251_apply_priority_deterministic"](
        {"action": "prune_root_outbound_fks", "target": "customer"}, {}, mdl, _Log())
    assert ok and diag == "applied", (ok, diag)
    attrs = {a["name"]: a for a in mdl["domains"][0]["products"][0]["attributes"]}
    # reference/dimension target kept
    assert attrs["location_id"]["foreign_key_to"] == "store.location.location_id"
    # transaction target pruned (FK + label removed)
    assert attrs["order_id"]["foreign_key_to"] == ""
    assert attrs["order_id"]["tags"] == ""
    # intra-domain FK untouched
    assert attrs["household_id"]["foreign_key_to"] == "customer.household.household_id"


# ============================================================ P12 glossary/regex tag cleanup
def _tag_model():
    return {"domains": [
        {"name": "customer", "products": [
            {"name": "profile", "primary_key": "account_id", "attributes": [
                # junk glossary: term == TitleCase(column)
                {"name": "account_id", "type": "BIGINT", "business_glossary_term": "Account ID",
                 "value_regex": "",
                 "tag_set": [{"key": "dbx_business_glossary_term", "value": "Account ID"}]},
                # genuine glossary term (NOT titlecase of column) -> keep
                {"name": "cltv_score", "type": "DECIMAL(18,2)",
                 "business_glossary_term": "Customer Lifetime Value",
                 "value_regex": "",
                 "tag_set": [{"key": "dbx_business_glossary_term", "value": "Customer Lifetime Value"}]},
                # value_regex duplicating the description -> clear
                {"name": "status_code", "type": "STRING", "business_glossary_term": "",
                 "value_regex": "active|inactive",
                 "description": "one of active|inactive",
                 "tag_set": [{"key": "dbx_value_regex", "value": "active|inactive"}]},
                # pii tag -> KEEP untouched
                {"name": "email", "type": "STRING", "business_glossary_term": "Email",
                 "value_regex": "",
                 "tag_set": [{"key": "dbx_business_glossary_term", "value": "Email"},
                             {"key": "dbx_pii_email", "value": "true"}]},
            ]},
        ]},
    ]}


def test_p12_cleanup_clears_junk_keeps_genuine_and_pii():
    ns = _handler_ns()
    mdl = _tag_model()
    ok, diag = ns["_v251_apply_priority_deterministic"](
        {"action": "cleanup_glossary_regex_tags", "target": "*"}, {}, mdl, _Log())
    assert ok and diag == "applied", (ok, diag)
    attrs = {a["name"]: a for a in mdl["domains"][0]["products"][0]["attributes"]}
    # junk glossary cleared in BOTH field and tag_set
    assert attrs["account_id"]["business_glossary_term"] == ""
    assert all(t["key"] != "dbx_business_glossary_term" for t in attrs["account_id"]["tag_set"])
    # genuine glossary preserved
    assert attrs["cltv_score"]["business_glossary_term"] == "Customer Lifetime Value"
    # dup value_regex cleared
    assert attrs["status_code"]["value_regex"] == ""
    assert all(t["key"] != "dbx_value_regex" for t in attrs["status_code"]["tag_set"])
    # pii tag KEPT even though its glossary junk ("Email") was cleared
    assert attrs["email"]["business_glossary_term"] == ""
    assert any(t["key"] == "dbx_pii_email" for t in attrs["email"]["tag_set"])


# ============================================================ P13 shrink domain restrict
P13_BLOCK = (
    "REVIEWER-PRIORITY 13 \u2014 ensure_household_and_mvm_minimalism: keep a real customer.household "
    "table. For the MVM (shrink) specifically, the customer domain should be genuinely minimal: "
    "essentially profile + address + contact + consent (+ optional account for B2B). Do not carry the "
    "full CDP/MDM/CRM breadth into the MVM.\n"
)
P13_KEEP_ONLY = ["profile", "address", "contact", "consent", "account"]
P13_ECM = {("customer", "profile"), ("customer", "address"), ("customer", "contact"),
           ("customer", "consent"), ("customer", "account"), ("customer", "preference"),
           ("customer", "household"), ("customer", "segment"),
           ("order", "header"), ("store", "location")}


class _SpecAgent:
    def __init__(self, specs):
        self.specs = specs
        self.calls = []

    def _call_ai_query(self, prompt_name=None, prompt=None, **kwargs):
        self.calls.append(prompt_name)
        return json.dumps(vs.reply(prompt, self.specs))


def _rows(tables):
    return [{"domain": d, "product": p} for d, p in sorted(tables)]


def _p13_specs(spec):
    model = ah.widgets_flat_to_model([{"domain": d} for d in sorted({d for d, _p in P13_ECM})], _rows(P13_ECM), [])
    agent = _SpecAgent([spec])
    specs = ah._vov_shrink_reviewer_specs(P13_BLOCK, model, agent, _Log())
    assert agent.calls and set(agent.calls) == {"VREQ_SPEC_PROMPT"}, agent.calls
    return specs


def test_p13_restricts_reviewer_domain_to_named_tables():
    specs = _p13_specs(vs.spec("REVIEWER-13", "keep_only", [f"customer.{p}" for p in P13_KEEP_ONLY]))
    assert [s["action"] for s in specs] == ["keep_only"], specs
    out = ah._vov_shrink_apply_reviewer_specs(set(P13_ECM), specs, _rows(P13_ECM))
    cust = {p for (d, p) in out if d == "customer"}
    assert cust == {"profile", "address", "contact", "consent", "account"}, cust
    # other domains untouched
    assert ("order", "header") in out and ("store", "location") in out, out


def test_p13_safety_noop_when_no_directive():
    keep = {("customer", "profile"), ("order", "header")}
    model = ah.widgets_flat_to_model([{"domain": "customer"}, {"domain": "order"}], _rows(keep), [])
    assert ah._vov_shrink_reviewer_specs("no minimalism directive here", model, _SpecAgent([]), _Log()) == []
    assert ah._vov_shrink_apply_reviewer_specs(keep, [], _rows(keep)) == keep
    assert _p13_specs(vs.spec("REVIEWER-13", "keep_only", ["customer"])) == []


def test_p13_safety_never_empties_domain_when_no_match():
    specs = _p13_specs(vs.spec("REVIEWER-13", "keep_only", [f"customer.{p}" for p in P13_KEEP_ONLY]))
    # kept customer products share NONE of the reviewer keep-list -> must return input unchanged
    keep = {("customer", "loyalty_profile"), ("customer", "cdp_segment"), ("order", "header")}
    assert ah._vov_shrink_apply_reviewer_specs(keep, specs, _rows(keep)) == keep
