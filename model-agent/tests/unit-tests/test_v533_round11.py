"""v5.3.3 live round 11 (r11a 258488145999450, r11b 821822282731786, r11c 320734827997859) findings.

r11a: a missed in-scope ask was labelled outside vibe_scope, the next_vibes LLM was told a discarded action was applied, static
analysis offered to rename the user's own column back, and the flat model lists kept frozen-record edits after model.json was
spliced, so the DDL of a preserved table lost a column. r11b: a description the user cleared was backfilled, and a clear on one
table cancelled fill-only on another. r11c: three metric views were installed as row-count fallbacks and still counted delivered.
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

LOG = logging.getLogger("test_v533_round11")
VOV = "vibe modeling of version"


@pytest.fixture(autouse=True)
def _reset(monkeypatch):
    monkeypatch.setattr(ah, "logger", LOG, raising=False)
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    yield
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()


def _tiny():
    def table(name, *attrs):
        return {"name": name, "primary_key": f"{name}_id", "description": f"The {name} table.",
                "attributes": [{"name": f"{name}_id", "type": "BIGINT", "is_primary_key": True, "description": f"Key of {name}."}]
                + [dict(a) for a in attrs]}
    return {"model": {"domains": [
        {"name": "crew", "division": "operations", "description": "Crew.", "products": [
            table("member", {"name": "full_name", "type": "STRING", "description": "Full name of the member."}),
            table("staff", {"name": "grade", "type": "STRING", "description": "Pay grade."}),
            table("roster", {"name": "member_id", "type": "BIGINT", "foreign_key_to": "crew.member.member_id", "description": "Member."})]},
        {"name": "ops", "division": "business", "description": "Ops.", "products": [
            table("member", {"name": "shift_code", "type": "STRING", "description": "Shift."})]}]}}


def _table(model, domain, name):
    return next(p for d in model["model"]["domains"] if d["name"] == domain for p in d["products"] if p["name"] == name)


def _attr(model, domain, table, column):
    return next(a for a in _table(model, domain, table)["attributes"] if a["name"] == column)


def _vreq(vid, target):
    return ah.RawVREQ(vreq_id=vid, intent="x", target=target, source_quote="x", source_chunk_id="c1")


def _flat(model):
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    return d, p, a


# ---------------------------------------------------------------- the vibe's own lines on the priority branch


def test_without_sentinels_every_line_outside_the_priority_blocks_is_the_users_and_parent_lines_are_not():
    priority = "**PRIORITY 1 - fix_naming: crew.member** - rename the column full_name to member_name\n"
    vibe = "## Domain: crew\n- (high) [crew.staff] Add the column nickname (STRING) to crew.staff.\n" + priority
    user = ah._vov_user_written_text(vibe)
    assert "Add the column nickname" in user and "PRIORITY" not in user
    parent = ("**Model Quality Score: 70/100**\n\n**Static Analysis Findings (1 actionable):**\n"
              "  - [SA:unlinked_fk] Column crew.roster.staff_id looks like an FK \u2014 link it\n" + priority.replace(" - ", " \u2014 "))
    vibe = ah._plain_vibe_text(parent) + "- (high) Add the column nickname (STRING) to crew.staff.\n"
    assert ah._vov_user_written_text(vibe, parent).strip() == "- (high) Add the column nickname (STRING) to crew.staff.", \
        "lines copied from the parent next_vibes match after the same typography the widget applies"
    assert ah._vov_user_written_text(ah._plain_vibe_text(parent), parent).strip() == ""


def test_the_free_text_extractor_reads_only_the_users_lines(monkeypatch):
    seen = []
    monkeypatch.setattr(ah, "build_outline", lambda text, llm: seen.append(text) or None)
    monkeypatch.setattr(ah, "chunk_vibe", lambda text, outline=None: [text])
    monkeypatch.setattr(ah, "extract_all", lambda chunks, outline, llm, parallel=False: [_vreq("VREQ-001", "crew.staff")])
    monkeypatch.setattr(ah, "dedupe_vreqs", lambda vreqs: vreqs)
    vibe = "- (high) Add the column nickname (STRING) to crew.staff.\n**PRIORITY 1 - fix_naming: crew.member** - rename x to y\n"
    out = ah._vov_extract_user_free_text(vibe, None, False, LOG)
    assert [v.vreq_id for v in out] == ["U-VREQ-001"] and out[0].is_user_directive
    assert [s.strip() for s in seen] == ["- (high) Add the column nickname (STRING) to crew.staff."]


# ---------------------------------------------------------------- next_vibes labels and the LLM context


def test_a_missed_ask_inside_the_widget_scope_is_not_labelled_out_of_scope():
    base = _tiny()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, VOV, LOG)
    fence.narrow_to_named({("crew", "member")}, set(), set(), LOG)
    ah.set_vibe_scope_runtime(fence)
    d, p, a = _flat(base)
    wv = {"domains": d, "products": p, "attributes": a}
    missed = [{"interpretation": "tag staff", "scope_targets": ["crew.staff"], "reason": "orchestrator status=failed"},
              {"interpretation": "add crew.vendor", "scope_targets": ["crew.vendor"], "reason": "orchestrator status=failed"},
              {"interpretation": "link ops", "scope_targets": ["ops.member"], "reason": "orchestrator status=failed"}]
    assert fence.classify_target("crew", "staff") == "out", "the named-only fence froze crew.staff"
    inside, outside = ah._vibe_scope_partition_missed(wv, missed)
    assert inside == missed[:2] and outside == [missed[2]]


def test_the_next_vibes_context_never_lists_a_discarded_action_as_applied(monkeypatch):
    log = [{"action": "create_table", "scope": "customer.vendor", "name": "create_vendor_table", "status": "corrective"},
           {"action": "fix_naming", "scope": "product.review", "name": "rename title", "status": "executed"},
           {"action": "x", "scope": "product.sku", "name": "landed", "status": "already_landed"}]
    missed = [{"scope_targets": ["customer.vendor"], "interpretation": "Add the table customer.vendor", "reason": "orchestrator status=failed"}]
    wv = {"_vibe_actions_executed_log": log}
    assert [a["name"] for a in ah._vibe_actions_landed(wv, missed)] == ["rename title"]
    monkeypatch.setattr(ah, "_v304_vibe_missed_rollup", lambda widgets: missed)
    d, p, a = _flat(_tiny())
    ctx = ah._build_next_vibe_llm_context(d, p, a, {}, dict(wv, model_scope="mvm", business_name="Crew"))
    text = ctx["products_with_fk_links"]
    assert "[fix_naming] rename title" in text and "create_vendor_table" not in text
    assert "## Requirements NOT Met in This Version" in text and "Add the table customer.vendor (orchestrator status=failed)" in text
    monkeypatch.setattr(ah, "_v304_vibe_missed_rollup", lambda widgets: [])
    assert [a["name"] for a in ah._vibe_actions_landed(wv)] == ["create_vendor_table", "rename title"]


# ---------------------------------------------------------------- static analysis never offers to undo a user rename


def test_static_analysis_does_not_offer_to_rename_a_users_column_back():
    model = {"model": {"domains": [{"name": "product", "products": [{"name": "review", "primary_key": "review_id", "attributes": [
        {"name": "review_id", "type": "BIGINT", "is_primary_key": True}, {"name": "review_title", "type": "STRING"},
        {"name": "review_note", "type": "STRING"}]}]}]}}
    vs.register(ah, model, vs.spec("P001", "rename_column", ["product.review.title"], new_name="review_title"))
    d, p, a = _flat(model)
    before = [i["message"] for i in ah.run_metamodel_static_analysis(d, p, a, {}, LOG)["issues"] if i["category"] == "product_prefix_on_attribute"]
    assert any("'review_title'" in m for m in before), "without a user rename the prefix finding fires"
    ah._vov_record_rename("attribute", "product.review.title", "product.review.review_title", "P001")
    assert ah._is_user_renamed_attribute("product", "review", "review_title")
    after = [i["message"] for i in ah.run_metamodel_static_analysis(d, p, a, {}, LOG)["issues"] if i["category"] == "product_prefix_on_attribute"]
    assert not any("'review_title'" in m for m in after) and any("'review_note'" in m for m in after)
    ah.vov_ledger_reset()
    ah._vov_record_rename("attribute", "product.review.title", "product.review.review_title", "pass:autofix")
    assert not ah._is_user_renamed_attribute("product", "review", "review_title"), "a pass rename is not the user's"


# ---------------------------------------------------------------- the serialize gate leaves the flat lists equal to model.json


def test_the_serialize_gate_puts_frozen_records_back_in_the_flat_lists():
    base = _tiny()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    d, p, a = _flat(base)
    a[:] = [r for r in a if not (r["domain"] == "ops" and r["attribute"] == "shift_code")]
    next(r for r in p if r["domain"] == "ops")["primary_key"] = "shift_code"
    wv = {"config": {}, "model_scope": "mvm", "base_version_for_review": "1", "domains": d, "products": p, "attributes": a}
    data_model = ah.widgets_flat_to_model(copy.deepcopy(d), copy.deepcopy(p), copy.deepcopy(a))
    ah._vibe_scope_serialize_gate(_root(data_model), wv, LOG)
    assert any(r["domain"] == "ops" and r["attribute"] == "shift_code" for r in wv["attributes"]), "the preserved column is back"
    assert next(r for r in wv["products"] if r["domain"] == "ops")["primary_key"] == "member_id"
    assert any(c["name"] == "shift_code" for c in _table({"model": _root(data_model)}, "ops", "member")["attributes"])


def _root(model):
    return model.get("model", model) if isinstance(model, dict) else model


# ---------------------------------------------------------------- a cleared field stays cleared


def test_a_field_the_user_cleared_is_cleared_again_after_a_backfill():
    model = _tiny()
    vs.register(ah, model, vs.spec("X1", "clear_fields", ["crew.member.full_name"], fields=[vs.field("attributes", "description")]))
    _attr(model, "crew", "member", "full_name")["description"] = "The full name of the member."
    cleared = ah._enforce_user_cleared_fields(ah._v337_model_rows(model["model"]), LOG, "model.json")
    assert cleared == ["X1:full_name.description"] and _attr(model, "crew", "member", "full_name")["description"] == ""
    assert _attr(model, "crew", "member", "member_id")["description"] == "Key of member.", "only the named column"
    d, p, a = _flat(model)
    row = next(r for r in a if r["product"] == "member" and r["attribute"] == "full_name" and r["domain"] == "crew")
    row["description"] = "Backfilled."
    assert ah._enforce_user_cleared_fields(ah._v337_flat_rows(d, p, a), LOG, "memory") and row["description"] == ""
    assert ah._enforce_user_cleared_fields(ah._v337_model_rows(model["model"]), LOG, "model.json") == []
    src = open(conftest.NOTEBOOK_PATH, encoding="utf-8").read()
    assert src.count("_enforce_user_cleared_fields(") >= 3


# ---------------------------------------------------------------- fill-only and clear stay with their own target


def test_fill_only_on_one_table_survives_a_clear_of_the_same_field_on_another():
    model = _tiny()
    vs.register(ah, model, vs.spec("F1", "set_fields", ["crew.member"], fields=[vs.field("attributes", "description", fill=True)], fill_only=True),
                vs.spec("C1", "clear_fields", ["crew.staff.grade"], fields=[vs.field("attributes", "description")]))
    spec, wide = ah._vibe_scope_requested_spec([_vreq("F1", "crew.member"), _vreq("C1", "crew.staff")], model)
    assert wide == [] and spec.fill_only_fields == frozenset() and spec.clear_fields == frozenset()
    assert ("crew", "member", "attributes", "description") in spec.fill_only_targets
    assert ("crew", "staff", "attributes", "description") in spec.clear_targets
    fence = ah._vibe_scope_start_requested([_vreq("F1", "crew.member"), _vreq("C1", "crew.staff")], copy.deepcopy(model), LOG, copy.deepcopy(model))
    member, staff = ("crew", "member", "fullname"), ("crew", "staff", "grade")
    assert fence._fill_only_for("attributes", member) == {"description"} and fence._fill_only_for("attributes", staff) == set()
    assert "description" not in fence._kept_open("attributes", member, {"description": "Full name."}, {"description": "Rewritten."})
    assert "description" in fence._kept_open("attributes", member, {"description": ""}, {"description": "Written."})
    assert "description" not in fence._kept_open("attributes", member, {"description": "Full name."}, {"description": ""}), \
        "the clear on crew.staff does not allow blanking crew.member"
    assert "description" in fence._kept_open("attributes", staff, {"description": "Pay grade."}, {"description": ""})


# ---------------------------------------------------------------- structural policies on part of the model


def test_a_primary_key_policy_on_one_domain_is_verified_on_that_domain_only():
    model = _tiny()
    _table(model, "ops", "member")["primary_key"] = "missing_col"
    vs.register(ah, model, vs.spec("PK1", "other", ["crew"], breadth="set", policy="primary_key_everywhere"),
                vs.spec("PK2", "other", [], breadth="model", policy="primary_key_everywhere"))
    d, p, a = _flat(model)
    assert ah._verify_from_spec(ah.vreq_spec("PK1"), d, p, a)["status"] == "fulfilled"
    assert ah._verify_from_spec(ah.vreq_spec("PK2"), d, p, a)["status"] != "fulfilled"
    prompt = ah.VREQ_SPEC_PROMPT
    assert "primary_key_everywhere, never set_primary_key" in prompt and "only in the domains or tables the targets name" in prompt


# ---------------------------------------------------------------- a requirement the base already meets opens no scope


def test_a_requirement_the_base_already_meets_opens_nothing_and_an_unmet_one_opens_its_table():
    model = _tiny()
    vs.register(ah, model, vs.spec("N1", "add_column", ["crew.member.full_name"], columns=[{"name": "full_name", "type": "STRING"}]),
                vs.spec("N2", "add_column", ["crew.member.nickname"], columns=[{"name": "nickname", "type": "STRING"}]))
    assert ah._vibe_scope_requested_spec([_vreq("N1", "crew.member")], model) == (None, [])
    spec, wide = ah._vibe_scope_requested_spec([_vreq("N2", "crew.member")], model)
    assert wide == [] and ("crew", "member") in spec.products


# ---------------------------------------------------------------- validate re-checks an earlier fulfilled mark


def test_validate_rechecks_a_requirement_marked_fulfilled_before_the_fence_restored_it():
    text = "Add the column nickname (STRING) to crew.member."
    model = _tiny()
    vs.register(ah, model, vs.spec("VREQ-001", "add_column", ["crew.member.nickname"], columns=[{"name": "nickname", "type": "STRING"}]),
                vs.spec("VREQ-002", "add_column", ["crew.member.full_name"], columns=[{"name": "full_name", "type": "STRING"}]))
    orch = ah.VibeOrchestrator({"logger": LOG, "config": {}, "vibe_modelling_instructions": text, "operation": VOV})
    stale = ah.VibeRequirement(id="VREQ-001", original_text=text, intent="add", scope="table", scope_targets=["crew.member"],
                               verification_strategy="state_diff")
    held = ah.VibeRequirement(id="VREQ-002", original_text="Add full_name.", intent="add", scope="table", scope_targets=["crew.member"],
                              verification_strategy="state_diff")
    orch.manifest = ah.VibeManifest(raw_text=text, requirements=[stale, held])
    stale.mark_fulfilled("landed mid-run", "test")
    held.mark_fulfilled("landed mid-run", "test")
    d, p, a = _flat(model)
    orch.widgets_values.update({"domains": d, "products": p, "attributes": a})
    orch.validate()
    assert stale.status == "failed" and "verifier-spec" in stale.evidence
    assert held.status == "fulfilled"


# ---------------------------------------------------------------- a row-count fallback is not a delivered metric view


def test_a_row_count_fallback_view_is_not_a_delivered_metric_view():
    fallback = ah._v469_build_mv_rowcount_fallback("`c`.`_metrics`.`sales_daily`", "`c`.`sales`.`line`")
    assert ah._MV_ROWCOUNT_FALLBACK_COMMENT in fallback, "the marker and the builder agree"
    records = [{"view_name": "sales_daily", "sql": fallback}, {"view_name": "prod_usage", "sql": "CREATE OR REPLACE VIEW x WITH METRICS"}]
    assert ah._mv_rowcount_fallback_names(records) == {"sales_daily"}
    assert [mv["view_name"] for mv in ah._verify_spec_index([], [], [], records)["mvs"]] == ["prod_usage"]
    src = open(conftest.NOTEBOOK_PATH, encoding="utf-8").read()
    assert "gt-mv-fallback-not-delivered FIRED v5.3.3" in src and "because the designed view failed: {str(prior_error)[:600]}" in src
