"""v5.3.3 requirement spec: an LLM reads every vibe requirement; code acts only on the structured spec it returns.

Covers the classifier driver (batching, retries with the rejection reason, not-interpreted outcomes), the prompt, the
normalizer and its validation, the deterministic ops built from a spec, the vibe-item anchors, the LLM call wrappers,
the rename ledger that only records accepted changes, partial application of multi-op requirements, coverage honesty
for requirements the LLM could not read, and the corrective actions read through the same classifier.
"""
import copy
import json
import logging
import sys
import threading
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
import test_v514_vibe_scope_vov_engine as E  # noqa: E402

LOG = logging.getLogger("test_v533_vreq_spec")


@pytest.fixture(autouse=True)
def _reset(monkeypatch):
    monkeypatch.setattr(ah, "logger", LOG, raising=False)
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    yield
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()


def _model():
    return E._engine()


def _item(vid, intent="change it", target="crew.member", quote=""):
    return {"id": vid, "intent": intent, "target": target, "source_quote": quote or intent}


class _Calls:
    def __init__(self, *replies):
        self.replies = list(replies)
        self.prompts = []

    def __call__(self, prompt, schema):
        self.prompts.append(prompt)
        reply = self.replies.pop(0) if self.replies else {"specs": []}
        if isinstance(reply, Exception):
            raise reply
        return reply(prompt) if callable(reply) else reply


def _echo(make):
    return lambda prompt: {"specs": [make(item) for item in vs.requested_items(prompt)]}


# ---------------------------------------------------------------- classifier driver


def test_the_classifier_reads_twelve_requirements_per_call_and_registers_every_reply():
    items = [_item(f"VREQ-{i:04d}") for i in range(1, 26)]
    items[0]["id"] = "VREQ-0001#oos"
    calls = _Calls(*[_echo(lambda it: vs.spec(it["id"], "check_only", ["crew.member"]))] * 3)
    specs = ah.classify_vreq_specs(calls, items, _model(), LOG)
    assert [len(vs.requested_items(p)) for p in calls.prompts] == [12, 12, 1]
    assert sorted(specs) == [f"VREQ-{i:04d}" for i in range(1, 26)]
    assert ah.vreq_spec("VREQ-0001#oos")["action"] == "check_only" and ah.vreq_spec(ah.RawVREQ(
        vreq_id="VREQ-0025", intent="", target="", source_quote="", source_chunk_id=""))["interpretable"]


def test_a_rejected_spec_is_asked_again_with_its_problem_then_failed_with_the_reason():
    bad = _echo(lambda it: vs.spec(it["id"], "rename_product", ["crew.member"]))
    calls = _Calls(bad, bad, bad)
    specs = ah.classify_vreq_specs(calls, [_item("V1", "rename crew member")], _model(), LOG)
    first, second, third = (vs.requested_items(p)[0] for p in calls.prompts)
    assert "previous_problem" not in first
    assert second["previous_problem"] == third["previous_problem"] == "rename_product names no new name"
    assert specs["V1"]["interpretable"] is False and specs["V1"]["reason"] == "rename_product names no new name"


def test_a_corrected_reply_on_retry_is_kept():
    calls = _Calls(_echo(lambda it: vs.spec(it["id"], "rename_product", ["crew.member"])),
                   _echo(lambda it: vs.spec(it["id"], "rename_product", ["crew.member"], new_name="crew_member")))
    specs = ah.classify_vreq_specs(calls, [_item("V1")], _model(), LOG)
    assert len(calls.prompts) == 2 and specs["V1"]["interpretable"] and specs["V1"]["new_name"] == "crew_member"


def test_a_requirement_the_reply_skips_is_asked_alone_and_then_marked_not_interpreted():
    only_v1 = lambda prompt: {"specs": [vs.spec("V1", "check_only", ["crew.member"])]}
    calls = _Calls(only_v1, lambda prompt: {"specs": []}, lambda prompt: {"specs": [{"id": "V9", "action": "other"}]})
    specs = ah.classify_vreq_specs(calls, [_item("V1"), _item("V2")], _model(), LOG)
    assert [vs.requested_ids(p) for p in calls.prompts] == [["V1", "V2"], ["V2"], ["V2"]]
    assert specs["V1"]["interpretable"] and not specs["V2"]["interpretable"]
    assert specs["V2"]["reason"].startswith("not interpreted:") and "V9" not in specs


def test_a_failing_llm_call_is_retried_and_its_error_becomes_the_reason():
    calls = _Calls(RuntimeError("endpoint down"), RuntimeError("endpoint down"), RuntimeError("endpoint down"))
    specs = ah.classify_vreq_specs(calls, [_item("V1")], _model(), LOG)
    assert len(calls.prompts) == 3 and specs["V1"]["interpretable"] is False
    assert specs["V1"]["reason"] == "not interpreted: RuntimeError: endpoint down"
    assert ah._vreq_spec_failed_outcome(ah.RawVREQ(vreq_id="V1", intent="", target="", source_quote="", source_chunk_id="")).status == "failed"


def test_the_classifier_log_line_counts_actions_and_failures(caplog):
    calls = _Calls(_echo(lambda it: vs.spec(it["id"], "add_product", ["crew.pilot"]) if it["id"] == "V1"
                         else vs.spec(it["id"], "add_fk", ["crew.member.base_id"])))
    with caplog.at_level(logging.INFO, logger=LOG.name):
        ah.classify_vreq_specs(calls, [_item("V1"), _item("V2")], _model(), LOG, attempts=1)
    line = next(r.getMessage() for r in caplog.records if "[vreq-spec FIRED v5.3.3]" in r.getMessage())
    assert "read 2 requirement(s)" in line and "'add_product': 1" in line and "not interpreted=['V2']" in line


# ---------------------------------------------------------------- prompt and catalog


def test_the_prompt_formats_cleanly_and_tells_the_llm_the_user_is_the_authority():
    items = [dict(_item("V1", target="crew"), anchor="crew.roster", anchor_text="- Rename roster to duty_roster", previous_problem="x")]
    prompt = ah.VREQ_SPEC_PROMPT.format(actions=", ".join(ah.VREQ_SPEC_ACTIONS), catalog=ah._vreq_spec_catalog(_model(), items),
                                        requirements_json=json.dumps(items, indent=1))
    assert prompt.startswith("USER VIBES ARE THE SUPREME AUTHORITY")
    assert "the user directive wins" in prompt and "anchor_text" in prompt and "previous_problem" in prompt
    assert vs.requested_items(prompt) == items and "{actions}" not in prompt and "{catalog}" not in prompt
    assert "  crew.roster columns: " in prompt and "  crew.member columns: " not in prompt


def test_the_catalog_lists_every_domain_and_columns_only_for_named_or_anchored_tables():
    model = _model()
    catalog = ah._vreq_spec_catalog(model, [_item("V1", target="crew.member"), dict(_item("V2", target="fleet"), anchor="fleet.aircraft")])
    lines = catalog.split("\n")
    assert len([ln for ln in lines if not ln.startswith("  ")]) == len(model["model"]["domains"])
    assert sorted(ln.split(" columns:")[0].strip() for ln in lines if ln.startswith("  ")) == ["crew.member", "fleet.aircraft"]
    assert len(ah._vreq_spec_catalog(model, [], limit=100)) == 100


# ---------------------------------------------------------------- normalizer and validation


def test_the_normalizer_keeps_known_values_and_drops_the_rest():
    idx = ah._vreq_spec_index(_model())
    spec = ah._normalize_vreq_spec({
        "id": "V1", "action": "Set_Fields", "breadth": "everything", "kind": "nonsense",
        "targets": [{"domain": "CREW", "product": "Member", "column": "MEMBER_ID"}, {"domain": "", "product": "", "column": ""}, "x"],
        "fields": [{"level": "products", "field": "description", "fill_only": True, "value": " A crew member "},
                   {"level": "products", "field": "color"}, {"level": "attributes", "field": "business_glossary_term"},
                   {"level": "attributes", "field": "business_glossary_term"}],
        "columns": [{"name": "nick name"}, {"name": "nickname", "type": " STRING "}],
        "new_name": "crew member", "count": {"entity": "domains", "op": "exactly", "value": 3},
        "policy": "colour", "tags": [{"key": " pii ", "value": "yes"}, {"key": ""}],
    }, idx)
    assert spec["action"] == "set_fields" and spec["breadth"] == "named" and spec["kind"] == "model"
    assert spec["targets"] == [{"domain": "crew", "product": "member", "column": "member_id"}]
    assert spec["fields"] == [("products", "description"), ("attributes", "business_glossary_term")]
    assert spec["fill_fields"] == [("products", "description")] and spec["field_values"] == {("products", "description"): "A crew member"}
    assert spec["columns"] == [{"name": "nickname", "type": "STRING"}] and spec["new_name"] == ""
    assert spec["count"] == {} and spec["policy"] == "" and spec["tags"] == [{"key": "pii", "value": "yes"}]
    assert spec["interpretable"]
    unknown = ah._normalize_vreq_spec({"id": "V2", "action": "teleport", "targets": [{"domain": "crew"}]}, idx)
    assert unknown["action"] == "other" and unknown["interpretable"]


def test_fk_targets_and_destinations_take_catalog_names_and_the_primary_key():
    idx = ah._vreq_spec_index(_model())
    base_pk = E._product(E._ENGINE, "crew", "base")["primary_key"]
    spec = ah._normalize_vreq_spec({"id": "V1", "action": "add_fk", "targets": [{"domain": "crew", "product": "member", "column": "base_id"}],
                                    "fk_target": "`Crew`.`Base`", "destination_domain": "FLEET"}, idx)
    assert spec["fk_target"] == f"crew.base.{base_pk}" and spec["destination_domain"] == "fleet"
    assert ah._vreq_spec_fk("base", idx) == "" and ah._vreq_spec_fk("crew.base.base_code", idx) == "crew.base.base_code"


def test_a_count_target_keeps_only_a_well_formed_count():
    idx = ah._vreq_spec_index(_model())
    good = ah._normalize_vreq_spec({"id": "V1", "action": "other", "kind": "count_target",
                                    "count": {"entity": "products", "op": "about", "value": "18"}}, idx)
    assert good["count"] == {"entity": "products", "op": "about", "value": 18} and good["interpretable"]
    for count in ({"entity": "tables", "op": "about", "value": 3}, {"entity": "products", "op": "roughly", "value": 3},
                  {"entity": "products", "op": "about", "value": "many"}, {"entity": "products", "op": "about", "value": -1}):
        bad = ah._normalize_vreq_spec({"id": "V1", "action": "other", "kind": "count_target", "count": count}, idx)
        assert not bad["interpretable"] and bad["reason"] == "count_target states no count", count


@pytest.mark.parametrize("raw,problem", [
    ({"action": "set_fields", "targets": [{"domain": "crew"}]}, "set_fields names no field"),
    ({"action": "add_column", "targets": [{"domain": "crew", "product": "member"}]}, "add_column names no column"),
    ({"action": "add_fk", "targets": [{"domain": "crew", "product": "member", "column": "base_id"}]}, "add_fk names no foreign key target"),
    ({"action": "retarget_fk", "targets": [{"domain": "crew", "product": "member", "column": "base_id"}]}, "retarget_fk names no foreign key target"),
    ({"action": "rename_column", "targets": [{"domain": "crew", "product": "member", "column": "member_id"}]}, "rename_column names no new name"),
    ({"action": "move_product", "targets": [{"domain": "crew", "product": "member"}]}, "move_product names no destination domain"),
    ({"action": "drop_product", "targets": []}, "drop_product names no target"),
    ({"action": "rename_product", "new_name": "x", "targets": [{"domain": "crew", "product": "member"}, {"domain": "crew", "product": "roster"}]},
     "rename_product names 2 products but carries one new name; each needs its own requirement"),
    ({"action": "rename_domain", "new_name": "x", "targets": [{"domain": "crew"}, {"domain": "fleet"}]},
     "rename_domain names 2 domains but carries one new name; each needs its own requirement"),
    ({"action": "split_product", "split_into": [{"product": "a", "columns": []}], "targets": [{"domain": "crew", "product": "member"},
                                                                                          {"domain": "crew", "product": "roster"}]},
     "split_product names 2 products but carries one split; each needs its own requirement"),
])
def test_a_spec_that_cannot_be_acted_on_is_not_interpretable(raw, problem):
    spec = ah._normalize_vreq_spec(dict(raw, id="V1"), ah._vreq_spec_index(_model()))
    assert spec["interpretable"] is False and spec["reason"] == problem


@pytest.mark.parametrize("raw", [
    {"action": "rename_product", "new_name": "crew_member", "targets": [{"domain": "crew", "product": "member"},
                                                                      {"domain": "crew", "product": "member", "column": "member_id"}]},
    {"action": "drop_product", "breadth": "model", "targets": []},
    {"action": "other", "kind": "tooling", "targets": []},
    {"action": "check_only", "targets": []},
    {"action": "add_column", "targets": [{"domain": "crew", "product": "member", "column": "nickname"}]},
])
def test_a_spec_that_can_be_acted_on_stays_interpretable(raw):
    assert ah._normalize_vreq_spec(dict(raw, id="V1"), ah._vreq_spec_index(_model()))["interpretable"]


def test_an_llm_saying_it_cannot_read_a_requirement_keeps_its_reason():
    spec = ah._normalize_vreq_spec({"id": "V1", "action": "other", "interpretable": False, "reason": "two readings"}, ah._vreq_spec_index(_model()))
    assert spec["interpretable"] is False and spec["reason"] == "two readings"


# ---------------------------------------------------------------- deterministic ops from a spec


def _ops(model, *specs):
    vs.register(ah, model, *specs)
    return ah._vreq_spec_det_ops(ah.vreq_spec(specs[0]["id"]), model)


def test_every_structural_action_builds_its_op_from_the_spec():
    model = _model()
    base_pk = E._product(E._ENGINE, "crew", "base")["primary_key"]
    assert _ops(model, vs.spec("V1", "rename_product", ["crew.member"], new_name="crew_member")) == [("rename_product", "crew", "member", "crew_member")]
    assert _ops(model, vs.spec("V1", "rename_column", ["crew.member.member_id"], new_name="member_key")) == [
        ("rename_attribute", "crew", "member", "member_id", "member_key")]
    assert _ops(model, vs.spec("V1", "rename_domain", ["crew"], new_name="aircrew")) == [("rename_domain", "crew", "aircrew")]
    assert _ops(model, vs.spec("V1", "merge_domains", ["crew"], merge_into="fleet")) == [("merge_domain", "crew", "fleet")]
    assert _ops(model, vs.spec("V1", "move_product", ["crew.member"], destination_domain="fleet")) == [("move_product", "crew", "member", "fleet")]
    assert _ops(model, vs.spec("V1", "split_product", ["crew.member"], split_into=[{"product": "member_contact", "columns": ["email"]}])) == [
        ("split_product", "crew", "member", [("member_contact", ["email"])])]
    assert _ops(model, vs.spec("V1", "reverse_fk", ["crew.roster.member_id"])) == [("reverse_fk", "crew", "roster", ("member_id", None))]
    assert _ops(model, vs.spec("V1", "add_fk", ["crew.member.base_id"], fk_target="crew.base")) == [
        ("add_fk", "crew", "member", "base_id", f"crew.base.{base_pk}")]
    assert _ops(model, vs.spec("V1", "add_column", ["crew.member"], columns=[{"name": "home_base_id", "type": "BIGINT"}], fk_target="crew.base")) == [
        ("add_fk", "crew", "member", "home_base_id", f"crew.base.{base_pk}")]
    assert _ops(model, vs.spec("V1", "add_column", ["crew.member"], columns=[{"name": "nickname", "type": "STRING"}])) == []
    assert _ops(model, vs.spec("V1", "set_fields", ["crew.member"], fields=[vs.field("products", "description")])) == []


def test_a_multi_target_spec_gives_one_op_per_target_or_none():
    model = _model()
    base_pk = E._product(E._ENGINE, "crew", "base")["primary_key"]
    assert _ops(model, vs.spec("V1", "add_fk", ["crew.member.home_base_id", "crew.roster.base_id"], fk_target="crew.base")) == [
        ("add_fk", "crew", "member", "home_base_id", f"crew.base.{base_pk}"), ("add_fk", "crew", "roster", "base_id", f"crew.base.{base_pk}")]
    assert _ops(model, vs.spec("V1", "rename_column", ["crew.member.status", "crew.roster.status"], new_name="state")) == [
        ("rename_attribute", "crew", "member", "status", "state"), ("rename_attribute", "crew", "roster", "status", "state")]
    assert _ops(model, vs.spec("V1", "add_fk", ["crew.member.home_base_id", "crew.roster"], fk_target="crew.base")) == [
        ("add_fk", "crew", "member", "home_base_id", f"crew.base.{base_pk}")], "a bare table next to named columns is context, not a target"
    assert _ops(model, vs.spec("V1", "merge_domains", ["crew", "fleet"], merge_into="fleet")) == [("merge_domain", "crew", "fleet")]


def test_a_multi_target_requirement_lands_only_when_every_target_landed():
    model = _model()
    base_pk = E._product(E._ENGINE, "crew", "base")["primary_key"]
    vs.register(ah, model, vs.spec("V1", "add_fk", ["crew.member.home_base_id", "crew.roster.home_base_id"], fk_target="crew.base"))
    vreq = ah.RawVREQ(vreq_id="V1", intent="", target="", source_quote="", source_chunk_id="")
    assert ah._vov_vreq_landed(vreq, model) is False
    ah._v413_apply_det_op_inplace(model, ("add_fk", "crew", "member", "home_base_id", f"crew.base.{base_pk}"))
    assert ah._vov_vreq_landed(vreq, model) is False
    ah._v413_apply_det_op_inplace(model, ("add_fk", "crew", "roster", "home_base_id", f"crew.base.{base_pk}"))
    assert ah._vov_vreq_landed(vreq, model) is True


def test_a_multi_target_move_opens_every_destination_in_the_requested_fence():
    model = _model()
    vs.register(ah, model, vs.spec("V1", "move_product", ["crew.member", "crew.roster"], destination_domain="fleet"))
    vreq = ah.RawVREQ(vreq_id="V1", intent="", target="", source_quote="", source_chunk_id="")
    spec, wide = ah._vibe_scope_requested_spec([vreq], model)
    assert wide == [] and {("fleet", "member"), ("fleet", "roster"), ("crew", "member"), ("crew", "roster")} <= set(spec.products)
    assert ah._vov_rename_pairs_for_vreqs([vreq], model) == [("move", "crew.member", "fleet.member"), ("move", "crew.roster", "fleet.roster")]


# ---------------------------------------------------------------- anchors and call wrappers


def test_items_carry_the_anchor_and_the_users_own_words():
    vreqs = [ah.RawVREQ(vreq_id="V1", intent="rename it", target="crew", source_quote="q", source_chunk_id="c")]
    assert ah._vreq_spec_items(vreqs) == [{"id": "V1", "intent": "rename it", "target": "crew", "source_quote": "q"}]
    assert ah._vreq_spec_items(vreqs, {"V1": {"anchor": "crew.roster", "anchor_text": "- Rename roster"}})[0]["anchor_text"] == "- Rename roster"
    text = "## Domain: crew\n<!-- vi:aaaa-1 target=crew.roster -->\n- (medium) Rename roster to duty_roster\n"
    stripped, items = ah._vibe_input_strip(text)
    imap = {"sha": ah._vibe_input_sha(stripped), "chars": len(stripped), "items": items, "vreqs": {}}
    quoted = [ah.RawVREQ(vreq_id="V1", intent="rename roster", target="crew.roster", source_quote="- (medium) Rename roster to duty_roster",
                         source_chunk_id="c")]
    assert ah._vreq_spec_anchors(imap, stripped, quoted) == {"V1": {"anchor": "crew.roster", "anchor_text": "- (medium) Rename roster to duty_roster"}}
    assert ah._vreq_spec_anchors(imap, stripped + "\nedited", quoted) == {}
    assert ah._vreq_spec_anchors({}, stripped, quoted) == {}


def test_the_engine_call_passes_the_schema_only_to_an_llm_that_takes_it():
    seen = []

    class _WithSchema:
        def complete_json(self, system, user, temperature=0.0, response_schema=None):
            seen.append(("schema", response_schema))
            return {"specs": []}

    class _NoSchema:
        def complete_json(self, system, user, temperature=0.0):
            seen.append(("plain", system))
            return {"specs": []}
    ah._vreq_spec_engine_call(_WithSchema())("p", {"type": "object"})
    ah._vreq_spec_engine_call(_NoSchema())("p", {"type": "object"})
    assert seen == [("schema", {"type": "object"}), ("plain", vs.CLASSIFIER_SYSTEM)]


def test_the_agent_call_uses_the_registered_prompt_and_reads_a_json_string():
    calls = []

    class _Agent:
        def _call_ai_query(self, **kwargs):
            calls.append(kwargs)
            return json.dumps({"specs": [{"id": "V1", "action": "check_only"}]})
    assert ah._vreq_spec_agent_call(None) is None and ah._vreq_spec_agent_call(object()) is None
    reply = ah._vreq_spec_agent_call(_Agent(), "vreq_spec_corrective")("prompt text", {"type": "object"})
    assert reply == {"specs": [{"id": "V1", "action": "check_only"}]}
    assert calls[0]["prompt_name"] == "VREQ_SPEC_PROMPT" and calls[0]["step_name"] == "vreq_spec_corrective"
    assert calls[0]["prompt"] == "prompt text" and calls[0]["response_schema"] == {"type": "object"}
    entry = next(p for p in ah.TECHNICAL_CONTEXT["prompts_models"] if p.get("prompt_name") == "VREQ_SPEC_PROMPT")
    assert entry["temperature"] == 0 and {"vibe", "basemodel"} <= set(entry["prompt_operations"])


# ---------------------------------------------------------------- the rename ledger records accepted changes only


def _events():
    return [(e["kind"], e["old"], e["new"], e["cause"]) for e in ah.vov_rename_events()]


def test_a_scope_rejected_deterministic_rename_leaves_no_ledger_event():
    E._fence()
    model = _model()
    kept, result, verdict = ah._vibe_scope_apply_det_op(model, ("rename_product", "fleet", "aircraft", "airframe"), "test", ("V1",), LOG)
    assert verdict[0] == "scope_rejected" and result is None and kept is model and E._has_product(model, "fleet", "aircraft")
    assert _events() == []


def test_an_accepted_deterministic_rename_names_its_requirement_with_or_without_a_fence():
    model = _model()
    ah._vibe_scope_apply_det_op(model, ("rename_product", "crew", "absence", "crew_absence"), "test", ("V1",), LOG)
    assert _events()[0] == ("product", "crew.absence", "crew.crew_absence", "V1")
    ah.vov_ledger_reset()
    E._fence()
    updated, result, verdict = ah._vibe_scope_apply_det_op(_model(), ("rename_product", "crew", "member", "crew_member"), "test", ("V2",), LOG,
                                                           cause="selffixer:V2")
    assert verdict == ("", "") and result and E._has_product(updated, "crew", "crew_member")
    assert _events() == [("product", "crew.member", "crew.crew_member", "selffixer:V2"),
                         ("attribute", "crew.crew_member.member_id", "crew.crew_member.crew_member_id", "selffixer:V2")]


def test_scratch_events_wait_for_the_commit_and_nest_with_their_cause():
    with ah._vov_ledger_scratch() as outer:
        with ah._vov_ledger_scratch() as inner:
            assert ah._vibe_scope_note_rename("product", "crew.member", "crew.crew_member", "V1")["cause"] == "V1"
            ah._vov_record_mv_rename("crew_member_view", "crew_crew_member_view")
        assert _events() == [] and len(inner) == 2
        assert ah._vov_commit_scratch(inner, "fallback", LOG) == 1
        assert _events() == [] and outer == [("product", "crew.member", "crew.crew_member", "V1"),
                                             ("metric_view", "crew_member_view", "crew_crew_member_view", "")]
    assert ah._VOV_LEDGER["mv_renames"] == {}
    ah._vov_commit_scratch(outer, "fallback", LOG)
    assert _events() == [("product", "crew.member", "crew.crew_member", "V1")]
    assert ah._VOV_LEDGER["mv_renames"] == {"crew_crew_member_view": "crew_member_view"}
    with pytest.raises(ValueError):
        with ah._vov_ledger_scratch():
            ah._vov_rename_event("table", "a.b", "a.c")
    assert ah._vov_scratch_events() is None
    assert ah._vibe_scope_note_rename("table", "a.b", "a.c") is None


def test_a_scratch_buffer_belongs_to_its_own_thread():
    started, done = threading.Event(), threading.Event()

    def _other():
        started.wait(5)
        ah._vibe_scope_note_rename("product", "crew.roster", "crew.duty_roster", "T2")
        done.set()
    worker = threading.Thread(target=_other)
    worker.start()
    with ah._vov_ledger_scratch() as mine:
        ah._vibe_scope_note_rename("product", "crew.member", "crew.crew_member", "T1")
        started.set()
        assert done.wait(5)
    worker.join(5)
    assert _events() == [("product", "crew.roster", "crew.duty_roster", "T2")]
    assert mine == [("product", "crew.member", "crew.crew_member", "T1")]


def test_pass1_names_each_rename_and_a_rejected_attempt_records_nothing():
    E._fence()
    model = _model()
    vs.register(ah, model, vs.spec("P001", "rename_product", ["fleet.aircraft"], new_name="airframe"),
                vs.spec("P002", "rename_product", ["crew.absence"], new_name="crew_absence"))
    priorities = [{"vreq_id": "P001", "action": "rename_product", "target": "fleet.aircraft", "reason": "the user asked"},
                  {"vreq_id": "P002", "action": "rename_product", "target": "crew.absence", "reason": "the user asked"}]
    new_model, outcomes, residual = ah._vibe_scope_apply_pass1(priorities, model, LOG)
    assert {o.vreq_ids[0]: o.status for o in outcomes} == {"P001": "scope_rejected", "P002": "applied"} and residual == []
    assert E._has_product(new_model, "crew", "crew_absence") and E._has_product(new_model, "fleet", "aircraft")
    assert [e for e in _events() if e[0] == "product"] == [("product", "crew.absence", "crew.crew_absence", "P002")]


def test_pass1_without_a_fence_names_each_rename():
    model = _model()
    vs.register(ah, model, vs.spec("P001", "rename_product", ["crew.absence"], new_name="crew_absence"))
    ah._vibe_scope_apply_pass1([{"vreq_id": "P001", "action": "rename_product", "target": "crew.absence", "reason": "x"}], model, LOG)
    assert [e for e in _events() if e[0] == "product"] == [("product", "crew.absence", "crew.crew_absence", "P001")]


def test_the_batch_deterministic_path_records_nothing_when_an_invariant_rejects_it():
    model = _model()
    vs.register(ah, model, vs.spec("P001", "rename_product", ["crew.member"], new_name="crew_member"))
    invariants = ah.capture_invariants(model, [], [("crew", "member")])
    batch = E._priority_batch("rename crew.member", "crew.member")
    new_model, outcome = ah._apply_handler_with_retry(E._handler(E.DESCRIBE_MUTATOR), batch, model, invariants, E._CannedLLM(), 1, (), (), 60.0)
    assert outcome.diagnostic.startswith("deterministic: rename crew.member->crew_member") and outcome.status != "applied"
    assert _events() == []
    ah.vov_ledger_reset()
    vs.register(ah, model, vs.spec("P001", "rename_product", ["crew.member"], new_name="crew_member"))
    new_model, outcome, events = ah._vov_apply_handler_scratch(E._handler(E.DESCRIBE_MUTATOR), batch, model,
                                                               ah.capture_invariants(model, [], []), E._CannedLLM(), 1, (), (), 60.0)
    assert outcome.status == "applied" and _events() == []
    assert events[0] == ("product", "crew.member", "crew.crew_member", "P001")


# ---------------------------------------------------------------- a blocked op leaves no partial change


def test_the_selffixer_fast_path_changes_nothing_when_one_of_its_ops_fails():
    model = _model()
    vs.register(ah, model, vs.spec("VREQ-0001", "move_product", ["crew.member", "crew.no_such_table"], destination_domain="fleet"))
    before = copy.deepcopy(model)
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "VREQ-0001"}, LOG)
    assert ok is None and evidence == "move_product_apply_failed" and model == before and _events() == []
    vs.register(ah, model, vs.spec("VREQ-0002", "move_product", ["crew.member", "crew.roster"], destination_domain="fleet"))
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "VREQ-0002"}, LOG)
    assert ok is True and E._has_product(model, "fleet", "member") and E._has_product(model, "fleet", "roster")
    assert [e[3] for e in _events()] == ["selffixer:VREQ-0002", "selffixer:VREQ-0002"]


def test_the_pipeline_preapply_leaves_a_partly_applicable_requirement_untouched(monkeypatch):
    vreq = ah.RawVREQ(vreq_id="VREQ-0001", intent="move member and a missing table to fleet", target="crew.member",
                      source_quote="move member and a missing table to fleet", source_chunk_id="c1", is_user_directive=True)
    monkeypatch.setitem(ah.__dict__, "extract_all", lambda *a, **k: [vreq])
    llm = E._CannedLLM(specs=[vs.spec("VREQ-0001", "move_product", ["crew.member", "crew.no_such_table"], destination_domain="fleet")])
    result = ah.run_vov_pipeline("move member and a missing table to fleet\n", _model(), llm, [], [], parallel=False, priority_reapply_loops=1)
    assert E._has_product(result.final_model, "crew", "member") and not E._has_product(result.final_model, "fleet", "member")
    assert not [o for o in result.outcomes if o.batch_id == "mech-det-VREQ-0001"]
    assert not [e for e in _events() if e[0] == "move"]


# ---------------------------------------------------------------- coverage counts requirements the LLM could not read


def test_an_unread_requirement_stays_in_the_coverage_universe_the_item_map_and_next_vibes(monkeypatch):
    text = "## Domain: crew\n<!-- vi:aaaa-1 target=crew.member -->\n- (high) Rename member to crew_member\n" \
           "<!-- vi:bbbb-2 target=crew.roster -->\n- (low) Make roster nicer somehow\n"
    stripped, items = ah._vibe_input_strip(text)
    imap = {"sha": ah._vibe_input_sha(stripped), "chars": len(stripped), "items": items, "vreqs": {}}
    vreqs = [ah.RawVREQ(vreq_id="VREQ-0001", intent="rename member", target="crew.member", source_quote="- (high) Rename member to crew_member",
                        source_chunk_id="c1", is_user_directive=True),
             ah.RawVREQ(vreq_id="VREQ-0002", intent="make roster nicer", target="crew.roster", source_quote="- (low) Make roster nicer somehow",
                        source_chunk_id="c1", is_user_directive=True)]
    monkeypatch.setitem(ah.__dict__, "extract_all", lambda *a, **k: list(vreqs))
    llm = E._CannedLLM(specs=[vs.spec("VREQ-0001", "rename_product", ["crew.member"], new_name="crew_member"),
                              vs.spec("VREQ-0002", "other", ["crew.roster"], interpretable=False, reason="no change is stated")])
    result = ah.run_vov_pipeline(stripped, _model(), llm, [], [], parallel=False, priority_reapply_loops=1, vibe_input_map=imap)
    assert {v.vreq_id for v in result.raw_vreqs} == {"VREQ-0001", "VREQ-0002"} and result.coverage_pct == 50.0
    failed = [o for o in result.outcomes if "VREQ-0002" in o.vreq_ids]
    assert [o.status for o in failed] == ["failed"] and "no change is stated" in failed[0].diagnostic
    assert result.vibe_input_vreqs["VREQ-0002"]["item_ids"] == ["bbbb-2"]
    assert [d["vreq_id"] for d in result.deferred_vreqs] == ["VREQ-0002"]
    assert E._has_product(result.final_model, "crew", "crew_member")


# ---------------------------------------------------------------- corrective actions are read by the classifier


ROWS = ([{"domain": "finance", "description": ""}],
        [{"domain": "finance", "product": "delivery_channel", "primary_key": "delivery_channel_id"}],
        [{"domain": "finance", "product": "delivery_channel", "attribute": "delivery_channel_id"},
         {"domain": "finance", "product": "delivery_channel", "attribute": "send_channel"}])


def test_correctives_are_classified_under_their_own_ids_with_their_fields_as_text():
    correctives = [{"action": "rename", "scope": "finance.delivery_channel.dispatch_channel", "name": "rename_dispatch_channel_to_send_channel",
                    "target_state": "Column dispatch_channel is renamed to send_channel", "reason": "the user asked"},
                   "not an action",
                   {"action": "add", "scope": "attribute", "name": "finance.delivery_channel.note", "target_state": "STRING"}]
    model = ah.widgets_flat_to_model(*[list(x) for x in ROWS])
    calls = _Calls(_echo(lambda it: vs.spec(it["id"], "check_only", [it["target"]])))
    specs = ah._vibe_corrective_specs(correctives, model, calls, LOG)
    asked = vs.requested_items(calls.prompts[0])
    assert [a["id"] for a in asked] == ["CORR-1", "CORR-3"] and sorted(specs) == ["CORR-1", "CORR-3"]
    assert asked[0]["target"] == "finance.delivery_channel.dispatch_channel" and "renamed to send_channel" in asked[0]["intent"]
    assert asked[0]["source_quote"] == "the user asked" and asked[1]["target"] == "finance.delivery_channel.note"
    assert ah._vibe_corrective_specs(correctives, model, None, LOG) == {} and ah._vibe_corrective_specs([], model, calls, LOG) == {}


def test_a_corrective_whose_rename_already_landed_is_skipped_and_others_run():
    model = ah.widgets_flat_to_model(*[list(x) for x in ROWS])
    vs.register(ah, model, vs.spec("CORR-1", "rename_column", ["finance.delivery_channel.dispatch_channel"], new_name="send_channel"),
                vs.spec("CORR-2", "rename_column", ["finance.delivery_channel.other_col"], new_name="send_channel"),
                vs.spec("CORR-3", "add_column", ["finance.delivery_channel.note"], columns=[{"name": "note", "type": "STRING"}]))
    assert not ah._vibe_corrective_already_landed(ah.vreq_spec("CORR-1"), *ROWS)
    ah._vibe_scope_note_rename("attribute", "finance.delivery_channel.dispatch_channel", "finance.delivery_channel.send_channel", "VREQ-0001")
    assert ah._vibe_corrective_already_landed(ah.vreq_spec("CORR-1"), *ROWS)
    assert not ah._vibe_corrective_already_landed(ah.vreq_spec("CORR-2"), *ROWS)
    assert not ah._vibe_corrective_already_landed(ah.vreq_spec("CORR-3"), *ROWS)
    assert not ah._vibe_corrective_already_landed(None, *ROWS)


def test_a_next_vibes_rename_with_a_different_new_name_is_not_an_echo():
    model = _model()
    assert ah._v337_apply_rename_domain(model["model"], "crew", "aircrew") is not None
    assert ah._vov_priority_echoes_rename(("rename_product", "aircrew", "member", "aircrew"), model)
    assert not ah._vov_priority_echoes_rename(("rename_product", "aircrew", "member", "crew_member"), model)
    assert not ah._vov_priority_echoes_rename(("rename_product", "fleet", "aircraft", "aircrew"), model)


# ---------------------------------------------------------------- the vibe parse never falls back to text rules


class _ParseAgent:
    def __init__(self, vibe, specs=(), fail=0, sizing=None, actions=None):
        self.vibe, self.specs, self.fail, self.sizing, self.calls = vibe, specs, fail, sizing or {}, []
        self.actions = actions

    def _call_ai_query(self, prompt_name=None, prompt=None, **kwargs):
        self.calls.append(prompt_name)
        if prompt_name == "VIBE_PARSE_PROMPT":
            if self.fail:
                self.fail -= 1
                raise RuntimeError("endpoint down")
            return json.dumps({"requirements": [{"original_text": self.vibe, "intent": "model the bakery", "scope": "model", "scope_targets": ["*"],
                                                 "mode": "generative", "priority": "high", "constraint_type": "soft", "verification_strategy": "llm_verify"}],
                               "sizing_directives": dict({"max_domains": None, "min_domains": None, "max_total_products": None, "min_total_products": None,
                                                          "max_products_per_domain": None, "min_products_per_domain": None,
                                                          "single_domain_mode": False, "explicit_count_statements": []}, **self.sizing),
                               "model_conventions": {}, **({"required_actions": self.actions} if self.actions is not None else {})})
        if prompt_name == "VREQ_SPEC_PROMPT":
            return json.dumps(vs.reply(prompt, self.specs))
        return "{}"


def _orch_parse(agent, vibe="Build a model for a small bakery with exactly three domains."):
    widgets = {"logger": LOG, "config": {}, "vibe_modelling_instructions": vibe, "operation": "new base model", "ai_agent": agent}
    ah.VibeOrchestrator(widgets).parse()
    return widgets


def test_the_vibe_parse_retries_the_llm_and_the_specs_fill_sizing_gaps():
    count = lambda item: vs.spec(item["id"], "other", [], kind="count_target", count={"entity": "domains", "op": "exactly", "value": 3})
    agent = _ParseAgent("vibe", specs=count, fail=1)
    widgets = _orch_parse(agent)
    assert agent.calls.count("VIBE_PARSE_PROMPT") == 2 and "VREQ_SPEC_PROMPT" in agent.calls
    assert widgets["vibe_manifest"].parse_method not in ("not_interpreted", "deterministic_grouped")
    assert widgets["sizing_directives"]["max_domains"] == 3 and widgets["sizing_directives"]["min_domains"] == 3


def test_an_unread_vibe_is_one_failed_requirement_never_a_text_parse():
    widgets = _orch_parse(_ParseAgent("vibe", fail=2))
    manifest = widgets["vibe_manifest"]
    assert manifest.parse_method == "not_interpreted" and [r.id for r in manifest.requirements] == ["VREQ-001"]
    spec = ah.vreq_spec("VREQ-001")
    assert spec["interpretable"] is False and "RuntimeError: endpoint down" in spec["reason"]
    assert not hasattr(ah.VibeOrchestrator, "_parse_deterministic")
    ah.vov_ledger_reset()
    widgets = {"logger": LOG, "config": {}, "vibe_modelling_instructions": "a tiny toy model", "operation": "new base model"}
    ah.VibeOrchestrator(widgets).parse()
    assert widgets["vibe_manifest"].parse_method == "not_interpreted" and "no AI agent" in ah.vreq_spec("VREQ-001")["reason"]
    assert widgets["sizing_directives"]["max_domains"] is None and widgets["sizing_directives"]["max_total_products"] is None


# ---------------------------------------------------------------- sizing comes from count specs an LLM read


def _counts(*rows):
    model = {"model": {"domains": []}}
    vs.register(ah, model, *[vs.spec(f"C{i}", "other", [], kind="count_target", count=c) for i, c in enumerate(rows, 1)])


def test_count_specs_become_sizing_readings_and_directives():
    _counts({"entity": "domains", "op": "exactly", "value": 3}, {"entity": "products", "op": "between", "value": 20, "low": 15},
            {"entity": "products_per_domain", "op": "at_most", "value": 8}, {"entity": "attributes_per_product", "op": "at_least", "value": 12},
            {"entity": "metric_views", "op": "exactly", "value": 4})
    readings = {r["phrase"].split(":")[0]: (r["unit"], r["scope"], r["per"], r["bound"], r["n"], r["lo"]) for r in ah._vreq_spec_sizing_readings()}
    assert readings == {"C1": ("domain", "total", "", "both", 3, None), "C2": ("product", "total", "", "range", 20, 15),
                        "C3": ("product", "per_unit", "domain", "max", 8, None), "C4": ("attribute", "per_unit", "product", "min", 12, None),
                        "C5": ("metric_view", "total", "", "both", 4, None)}
    sd = ah._sizing_directives_from_readings(ah._vreq_spec_sizing_readings())
    assert (sd["max_domains"], sd["min_domains"], sd["max_total_products"], sd["min_total_products"], sd["max_products_per_domain"],
            sd["min_products_per_domain"], sd["single_domain_mode"]) == (3, 3, 20, 15, 8, None, False)
    assert ah._vreq_spec_mv_directive() == (4, [])
    assert ah._vibe_exact_metric_view_directive({}) == (4, [])
    assert ah._vov_spec_mv_floor(0, LOG) == 4 and ah._vov_spec_mv_floor(7, LOG) == 7


def test_one_domain_exactly_is_single_domain_mode_and_bad_counts_are_not_readings():
    _counts({"entity": "domains", "op": "exactly", "value": 1})
    assert ah._sizing_directives_from_readings(ah._vreq_spec_sizing_readings())["single_domain_mode"] is True
    ah.vov_ledger_reset()
    _counts({"entity": "products", "op": "between", "value": 5, "low": 9}, {"entity": "products", "op": "between", "value": 5})
    assert ah._vreq_spec_sizing_readings() == []
    assert all(not ah.vreq_spec(v)["interpretable"] for v in ("C1", "C2"))
    assert ah._sizing_directives_from_readings([])["max_domains"] is None


def test_override_axes_and_attribute_bounds_read_only_the_specs():
    assert ah._sizing_override_axes({}) == (set(), [])
    _counts({"entity": "attributes", "op": "about", "value": 600}, {"entity": "products_per_subdomain", "op": "at_most", "value": 4})
    axes, evidence = ah._sizing_override_axes({})
    assert axes == {"attributes", "subdomains"} and evidence == ["C1: about 600 attributes", "C2: at_most 4 products_per_subdomain",
                                                                 "a requirement spec names subdomains"]
    assert ah._attribute_total_per_product_bounds(30) == {"min_attributes_per_product": 20, "max_attributes_per_product": 20,
                                                          "phrases": ["C1: about 600 attributes"], "products": 30}
    assert ah._attribute_total_per_product_bounds(0) is None
    ah.vov_ledger_reset()
    vs.register(ah, {"model": {"domains": []}}, vs.spec("V1", "set_fields", ["crew"], breadth="set", fields=[vs.field("products", "subdomain")]))
    assert ah._sizing_override_axes({})[0] == {"subdomains"}


def test_coverage_requeue_reads_tag_specs_and_the_metric_view_count():
    model = _model()
    vs.register(ah, model, vs.spec("V1", "set_fields", ["crew"], breadth="set", fields=[vs.field("attributes", "tags")],
                                   tags=[{"key": "source_system", "value": "crew_ops"}]),
                vs.spec("V2", "other", [], kind="count_target", count={"entity": "metric_views", "op": "exactly", "value": 500}))
    widgets = {}
    assert ah._v320_vibe_completeness_requeue(model, widgets, LOG) == 2
    queued = {q["id"]: q for q in widgets["_unfulfilled_for_next_vibe"]}
    assert set(queued) == {"COMPLETENESS-TAG-source_system-column", "COMPLETENESS-MV-COUNT"}
    assert "of crew" in queued["COMPLETENESS-TAG-source_system-column"]["text"] and "V1" in queued["COMPLETENESS-TAG-source_system-column"]["text"]
    assert ah._v320_vibe_completeness_requeue(model, widgets, LOG) == 0
    ah.vov_ledger_reset()
    assert ah._v320_vibe_completeness_requeue(model, {}, LOG) == 0


# ---------------------------------------------------------------- structural placeholders, quote dedupe, redirects


@pytest.mark.parametrize("value,expected", [
    ("", None), ("n/a", "placeholder"), ("TBD", "placeholder"), ("<column>", "placeholder"), ("{term}", "placeholder"),
    ("member_id", "column name"), ("Member Id", "column name"), ("Crew Member Identifier", None), ("GlossaryTerm_roster_date", None),
    ("A crew member is a person employed to work aboard an aircraft during a flight sector.", None),
])
def test_a_glossary_value_is_rejected_only_for_structural_reasons(value, expected):
    assert ah._v533_glossary_term_defect(value, "member_id") == expected


def test_a_recovered_requirement_is_a_duplicate_only_when_its_quote_is_already_held():
    existing = [ah.RawVREQ(vreq_id="V1", intent="", target="", source_quote="Add a nickname column to crew member", source_chunk_id="c")]
    assert ah._v292_duplicate_of("add a nickname column", existing) == "V1"
    assert ah._v292_duplicate_of("Add a nickname column to crew member so dispatch can greet crew", existing) == "V1"
    assert ah._v292_duplicate_of("Add the nickname column to the crew member table", existing) is None
    assert ah._v292_duplicate_of("  ", existing) is None


def test_a_rename_requirement_is_never_redirected_and_others_follow_landed_renames_by_spec():
    model = _model()
    vs.register(ah, model, vs.spec("V1", "rename_product", ["crew.member"], new_name="crew_member"),
                vs.spec("V2", "add_column", ["crew.member.nickname"], columns=[{"name": "nickname", "type": "STRING"}], fk_target="crew.base"))
    vreqs = [ah.RawVREQ(vreq_id="V1", intent="Rename crew.member to crew_member", target="crew.member", source_quote="", source_chunk_id="c"),
             ah.RawVREQ(vreq_id="V2", intent="Add nickname to crew.member", target="crew.member", source_quote="", source_chunk_id="c")]
    out, redirected = ah._vov_redirect_vreqs(vreqs, {"crew.member": "crew.crew_member"}, {})
    assert redirected == ["V2"] and out[0] is vreqs[0] and out[1].target == "crew.crew_member" and out[1].intent == "Add nickname to crew.crew_member"
    assert ah.vreq_spec("V2")["targets"] == [{"domain": "crew", "product": "crew_member", "column": "nickname"}]
    assert ah.vreq_spec("V1")["targets"] == [{"domain": "crew", "product": "member", "column": ""}]


def test_a_physical_type_matches_a_spec_type_by_base_and_synonym():
    assert ah._verify_spec_type_matches("bigint", "long") and ah._verify_spec_type_matches("decimal", "decimal(10,2)")
    assert not ah._verify_spec_type_matches("decimal(10,2)", "decimal(12,2)") and ah._verify_spec_type_matches("int", "bigint")


def test_the_verifier_follows_a_table_rename_that_landed_in_the_same_run():
    model = _model()
    vs.register(ah, model, vs.spec("V1", "rename_column", ["crew.member.member_id"], new_name="member_key"),
                vs.spec("V2", "rename_product", ["crew.member"], new_name="crew_member"))
    assert ah._v337_apply_rename_product(model["model"], "crew", "member", "crew_member") is not None
    assert ah._v337_apply_rename_attribute(model["model"], "crew", "crew_member", "crew_member_id", "member_key") is not None
    d, p, a, _mv = ah.model_to_widgets_flat(model)
    assert ah._verify_from_spec(ah.vreq_spec("V1"), d, p, a)["status"] == "fulfilled"
    assert ah._verify_from_spec(ah.vreq_spec("V2"), d, p, a)["status"] == "fulfilled"
    ah.vov_ledger_reset()
    vs.register(ah, model, vs.spec("V1", "rename_column", ["crew.member.member_id"], new_name="member_key"))
    assert ah._verify_from_spec(ah.vreq_spec("V1"), d, p, a)["status"] == "failed"


def test_the_ground_truth_audit_does_not_score_fields_the_physical_columns_cannot_carry():
    spec = ah._normalize_vreq_spec({"id": "V1", "action": "set_fields", "targets": [{"domain": "crew", "product": "member"}],
                                    "fields": [{"level": "attributes", "field": "business_glossary_term"}]}, ah._vreq_spec_index(_model()))
    blind = [f for level, f in spec["fields"] if level == "attributes" and f not in ("description", "tags", "tag_set")]
    assert blind == ["business_glossary_term"]
    src = open(Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb").read()
    assert "comment AS cm" in src and "gt-spec-blind FIRED v5.3.3" in src


_R1A_VIBE = ("## Domain: product\n"
             "- (high) [product.size_chart] Rename the column chart_region to fit_region.\n"
             "- (high) [product.size_chart] Drop the column style from product.size_chart.\n"
             "- (high) [product.collection] Add a column launch_channel (STRING) to product.collection.\n"
             "- (high) [product.size_chart] Add a column primary_sku_id to product.size_chart that references product.sku.\n"
             "- (high) [product.collection] Give every column of product.collection that has no description a short description.\n")


class _OutlineLLM:
    def __init__(self, sections):
        self.sections = sections

    def complete_json(self, system, user, temperature=0.0, response_schema=None):
        return {"sections": self.sections}

    def complete_with_tools(self, system, user, tools=None, tool_handlers=None, temperature=0.0, response_schema=None):
        lines = [ln[2:].strip() for ln in user.split("\n") if ln.startswith("- ")]
        return {"vreqs": [{"intent": ln, "target": ln.split("]")[0].strip("[( high)"), "source_quote": ln} for ln in lines]}


def test_outline_sections_partition_the_vibe_when_the_llm_titles_match_no_heading():
    llm = _OutlineLLM([{"section_id": "S1", "title": "Size chart changes"}, {"section_id": "S2", "title": "Collection changes"},
                       {"section_id": "S3", "title": "Descriptions"}])
    outline = ah.build_outline(_R1A_VIBE, llm)
    assert [(s.byte_start, s.byte_end) for s in outline.sections] == [(0, len(_R1A_VIBE))]
    chunks = ah.chunk_vibe(_R1A_VIBE, outline=outline)
    assert len(chunks) == 1 and chunks[0].text == _R1A_VIBE
    vreqs = ah.dedupe_vreqs(ah.extract_all(chunks, outline, llm, parallel=False))
    assert len(vreqs) == 5 and len({v.source_quote for v in vreqs}) == 5


def test_outline_sections_take_llm_metadata_by_title_and_never_share_a_range():
    text = "## Crew\n- add a column shift_code to crew.roster\n## Fleet\n- drop the column legacy_code from fleet.aircraft\n"
    llm = _OutlineLLM([{"title": "Fleet", "summary": "fleet asks", "declared_entities": ["fleet.aircraft"]},
                       {"title": "Something else", "summary": "invented"}, {"title": "Crew", "summary": "crew asks"}])
    sections = ah.build_outline(text, llm).sections
    ranges = [(s.byte_start, s.byte_end) for s in sections]
    assert ranges == [(0, text.index("## Fleet")), (text.index("## Fleet"), len(text))]
    assert [s.summary for s in sections] == ["crew asks", "fleet asks"]
    assert [s.section_id for s in sections] == ["S1", "S2"]
    assert sections[1].declared_entities == ("fleet.aircraft",)
    in_order = ah.build_outline(text, _OutlineLLM([{"title": "a", "summary": "first"}, {"title": "b", "summary": "second"}])).sections
    assert [s.summary for s in in_order] == ["first", "second"]


def test_a_section_with_only_a_heading_yields_no_chunk():
    text = "## Domain: crew\n### Table: roster\n- add a column shift_code to crew.roster\n"
    chunks = ah.chunk_vibe(text, outline=ah.build_outline(text, _OutlineLLM([])))
    assert len(chunks) == 1
    assert chunks[0].text.startswith("## Domain: crew\n### Table: roster\n") and "shift_code" in chunks[0].text
    assert ah.chunk_vibe("## Only a heading\n\n", outline=ah.build_outline("## Only a heading\n\n", _OutlineLLM([]))) == []


def _raw(rid, quote, severity="medium", user=False, prio=9999):
    return ah.RawVREQ(vreq_id=rid, intent=quote, target="crew.member", source_quote=quote, source_chunk_id="c1",
                      severity=severity, is_user_directive=user, priority_id=prio)


def test_requirements_with_the_same_llm_spec_merge_and_keep_their_feedback_links():
    model = _model()
    a = _raw("VREQ-0001", "Rename member_id to member_key.", severity="low")
    b = _raw("VREQ-0002", "Please call the member_id column member_key instead.", severity="critical", user=True, prio=2)
    c = _raw("VREQ-0003", "Rename member_name to full_name.")
    d = _raw("VREQ-0004", "Something the classifier could not read.")
    vs.register(ah, model, vs.spec("VREQ-0001", "rename_column", ["crew.member.member_id"], new_name="member_key"),
                vs.spec("VREQ-0002", "rename_column", ["crew.member.member_id"], new_name="member_key"),
                vs.spec("VREQ-0003", "rename_column", ["crew.member.member_name"], new_name="full_name"))
    ah.register_vreq_specs({"VREQ-0004": ah._vreq_spec_not_interpreted("VREQ-0004", "unclear", ah._vreq_spec_index(model))})
    kept, merged = ah._vreq_spec_dedupe([a, b, c, d], logging.getLogger("t"))
    assert [v.vreq_id for v in kept] == ["VREQ-0001", "VREQ-0003", "VREQ-0004"]
    assert (kept[0].severity, kept[0].is_user_directive, kept[0].priority_id) == ("critical", True, 2)
    assert {k: [v.vreq_id for v in m] for k, m in merged.items()} == {"VREQ-0001": ["VREQ-0002"]}
    absorbed = ah._vibe_input_absorbed(kept, [a, b, c, d], [], merged)
    assert [v.vreq_id for v in absorbed["VREQ-0001"]] == ["VREQ-0001", "VREQ-0002"]
    assert ah._vreq_spec_dedupe([c, d], None) == ([c, d], {})


def test_the_spec_signature_reads_every_spec_shape_the_normalizer_builds():
    """Live r2a 502366182160316 and r2b 208131559706991: a set_fields spec with a value keys field_values by (level, field);
    json.dumps refused the tuple keys and both runs died in the spec dedupe."""
    idx = ah._vreq_spec_index(_model())
    raw = {"id": "V1", "action": "set_fields", "targets": [{"domain": "crew"}], "breadth": "named",
           "fields": [{"level": "domains", "field": "division", "value": "operations"}, {"level": "attributes", "field": "tags"}],
           "tags": [{"key": "pii", "value": "true"}]}
    one, two = ah._normalize_vreq_spec(raw, idx), ah._normalize_vreq_spec(dict(raw, id="V2"), idx)
    assert one["field_values"] == {("domains", "division"): "operations"}
    assert ah._vreq_spec_signature(one) == ah._vreq_spec_signature(two)
    other = ah._normalize_vreq_spec(dict(raw, id="V3", fields=[{"level": "domains", "field": "division", "value": "business"}]), idx)
    assert ah._vreq_spec_signature(one) != ah._vreq_spec_signature(other)
    swapped = ah._normalize_vreq_spec(dict(raw, id="V4", fields=list(reversed(raw["fields"]))), idx)
    assert ah._vreq_spec_signature(one) == ah._vreq_spec_signature(swapped)
    fk = ah._normalize_vreq_spec({"id": "V5", "action": "remove_fk", "targets": [{"domain": "crew", "product": "member", "column": "base_id"}]}, idx)
    assert isinstance(ah._vreq_spec_signature(fk), str)


class _FreeTextLLM(E._CannedLLM):
    def complete_json(self, system, user, temperature=0.0, response_schema=None):
        if system == ah.OUTLINE_SYSTEM_PROMPT:
            return {"sections": [{"title": "Division asks"}, {"title": "Second reading"}, {"title": "Third reading"}]}
        return super().complete_json(system, user, temperature, response_schema)

    def complete_with_tools(self, system, user, tools, tool_handlers, max_iters=6, temperature=0.0, response_schema=None):
        if str(user).startswith("CHUNK "):
            self.chunks = getattr(self, "chunks", []) + [user]
            lines = [ln[2:].strip() for ln in str(user).split("\n") if ln.startswith("- ")]
            return {"vreqs": [{"intent": ln, "target": "crew", "source_quote": ln, "severity": "high"} for ln in lines]}
        return super().complete_with_tools(system, user, tools, tool_handlers, max_iters, temperature, response_schema)


def _division_spec(item):
    if "division" in json.dumps(item).lower():
        return {"id": item["id"], "action": "set_fields", "breadth": "named", "targets": [{"domain": "crew", "product": "", "column": ""}],
                "fields": [{"level": "domains", "field": "division", "value": "operations"}], "interpretable": True, "reason": "division"}
    return None


def test_the_free_text_branch_reads_value_specs_and_merges_the_same_ask_end_to_end():
    """Live r2a/r2b crashed in this branch: a set_fields spec with a value broke the spec dedupe, and no offline test ran
    the free-text branch with extraction and classification together."""
    vibe = ("## Domain: crew\n"
            "- [crew] Set the division of the crew domain to operations.\n"
            "- [crew] The crew domain belongs to the operations division.\n")
    llm = _FreeTextLLM(specs=_division_spec)
    result = ah.run_vov_pipeline(vibe, E._engine(), llm, [], [], parallel=False, priority_reapply_loops=1)
    ids = sorted({str(v.vreq_id) for v in result.raw_vreqs})
    assert ids == ["VREQ-0001"], ids
    assert ah.vreq_spec("VREQ-0001")["field_values"] == {("domains", "division"): "operations"}
    assert len(llm.chunks) == 1 and llm.chunks[0].count("- [crew]") == 2


def _flat_hr():
    domains = [{"domain": "hr"}, {"domain": "ops"}]
    products = [{"domain": "hr", "product": "employee", "primary_key": "employee_id", "tags": "source_table=emp_master", "subdomain": "people"},
                {"domain": "hr", "product": "position", "primary_key": "position_id", "tags": "", "subdomain": "staffing ops"},
                {"domain": "ops", "product": "shift", "primary_key": "shift_id", "tags": "", "subdomain": ""}]
    attributes = [{"domain": "hr", "product": "employee", "attribute": "employee_id", "tags": "", "is_primary_key": True},
                  {"domain": "hr", "product": "employee", "attribute": "badge_number", "tags": "", "source_column": "BADGE_NO"},
                  {"domain": "hr", "product": "employee", "attribute": "position_id", "foreign_key_to": "hr.position.position_id", "tags": ""},
                  {"domain": "hr", "product": "position", "attribute": "position_id", "tags": "", "is_primary_key": True},
                  {"domain": "hr", "product": "position", "attribute": "position_code", "tags": ""},
                  {"domain": "ops", "product": "shift", "attribute": "shift_id", "tags": "", "is_primary_key": True},
                  {"domain": "ops", "product": "shift", "attribute": "employee_ref", "foreign_key_to": "hr.employee.employee_id", "tags": ""}]
    return domains, products, attributes


def _register_flat(flat, *specs):
    vs.register(ah, ah.widgets_flat_to_model(*flat), *specs)


def _tag_spec(vid, targets, level, tags, breadth="named"):
    return dict(vs.spec(vid, "set_fields", targets, breadth=breadth, fields=[vs.field(level, "tags")]), tags=tags)


def test_the_allowed_values_list_keeps_only_closed_lists_on_known_fields():
    out = ah._vreq_spec_allowed_list([
        {"level": "products", "field": "subdomain", "key": "ignored", "values": ["People", "People", " Staffing ", ""]},
        {"level": "attributes", "field": "tags", "key": "region", "values": ["EMEA"]},
        {"level": "products", "field": "row_count", "values": ["1"]},
        {"level": "galaxy", "field": "tags", "values": ["x"]},
        {"level": "attributes", "field": "business_glossary_term", "values": []},
        "not a dict"])
    assert out == [{"level": "products", "field": "subdomain", "key": "", "values": ["People", "Staffing"]},
                   {"level": "attributes", "field": "tags", "key": "region", "values": ["EMEA"]}]


def test_spec_tags_land_on_the_rows_their_breadth_and_targets_name_and_nowhere_else():
    flat = _flat_hr()
    _register_flat(flat,
                   _tag_spec("T1", [], "attributes", [{"key": "pii_review", "value": "pending"}], breadth="model"),
                   _tag_spec("T2", ["hr"], "products", [{"key": "data_owner", "value": "hr_team"}], breadth="set"),
                   _tag_spec("T3", ["hr.employee.badge_number"], "attributes", [{"key": "restricted", "value": "true"}]),
                   _tag_spec("T4", ["hr.employee"], "attributes", [{"key": "source_column", "value": "<original column>"}]))
    _d, products, attributes = flat
    assert ah._vreq_spec_apply_tags(products, attributes, logging.getLogger("t")) == 7 + 2 + 1
    assert all("pii_review=pending" in a["tags"] for a in attributes)
    assert [p["product"] for p in products if "data_owner=hr_team" in p["tags"]] == ["employee", "position"]
    assert [a["attribute"] for a in attributes if "restricted=true" in a["tags"]] == ["badge_number"]
    assert not any("source_column=" in a["tags"] for a in attributes)
    assert ah._vreq_spec_apply_tags(products, attributes) == 0


def test_spec_tags_never_touch_a_frozen_table():
    flat = _flat_hr()
    _register_flat(flat, _tag_spec("T1", [], "attributes", [{"key": "pii_review", "value": "pending"}], breadth="model"))
    frozen = SimpleNamespace(is_frozen_pass_row=lambda d, p: d == "ops")
    prior = ah._VIBE_SCOPE_RUNTIME
    ah._VIBE_SCOPE_RUNTIME = frozen
    try:
        ah._vreq_spec_apply_tags(flat[1], flat[2])
    finally:
        ah._VIBE_SCOPE_RUNTIME = prior
    assert [a["domain"] for a in flat[2] if "pii_review" in a["tags"]] == ["hr"] * 5


def test_a_tag_key_the_user_wrote_outranks_the_tag_prefix_convention():
    flat = _flat_hr()
    _register_flat(flat, _tag_spec("T1", [], "attributes", [{"key": "original_table_name", "value": "<source table>"}], breadth="model"))
    attributes = flat[2]
    attributes[1]["tags"] = "acme_original_table_name=EMP,acme_other=1"
    config = {"MODEL_CONVENTIONS": {"tag_prefix": "acme_"}}
    assert ah._v383_enforce_tag_name_precedence(flat[1], attributes, config) == 1
    assert attributes[1]["tags"] == "original_table_name=EMP,acme_other=1"
    ah.vov_ledger_reset()
    attributes[1]["tags"] = "acme_original_table_name=EMP"
    assert ah._v383_enforce_tag_name_precedence(flat[1], attributes, config) == 0


def test_a_placeholder_tag_spec_takes_each_column_s_own_provenance_on_source_tables_only():
    flat = _flat_hr()
    _register_flat(flat, _tag_spec("T1", ["hr"], "attributes", [{"key": "source_attribute", "value": "<original column>"}], breadth="set"))
    attributes = flat[2]
    assert ah._v383_apply_per_attribute_value_tags(attributes, flat[1]) == 3
    assert "source_attribute=BADGE_NO" in attributes[1]["tags"]
    assert not any("source_attribute" in a["tags"] for a in attributes if a["product"] != "employee")


def test_values_outside_a_closed_list_are_purged_and_members_kept():
    flat = _flat_hr()
    _register_flat(flat, dict(vs.spec("L1", "set_fields", [], breadth="model", fields=[vs.field("attributes", "tags")]),
                              tags=[{"key": "cde", "value": "<data element>"}],
                              allowed_values=[{"level": "attributes", "field": "tags", "key": "cde", "values": ["Badge Number (BN)", "Position Code"]}]))
    attributes = flat[2]
    attributes[1]["tags"] = "cde=badge number,keep=1"
    attributes[4]["tags"] = "cde=Invented Thing"
    assert ah._v383_purge_fabricated_lookup_tags(attributes) == 1
    assert attributes[1]["tags"] == "cde=badge number,keep=1" and attributes[4]["tags"] == ""
    ah.vov_ledger_reset()
    attributes[4]["tags"] = "cde=Invented Thing"
    assert ah._v383_purge_fabricated_lookup_tags(attributes) == 0 and attributes[4]["tags"] == "cde=Invented Thing"


def test_a_closed_subdomain_roster_relabels_invented_labels_and_an_open_one_does_nothing():
    flat = _flat_hr()
    products = flat[1]
    assert ah._v383_enforce_closed_label_roster(products) == 0
    _register_flat(flat, dict(vs.spec("R1", "set_fields", ["hr"], breadth="set", fields=[vs.field("products", "subdomain")]),
                              allowed_values=[{"level": "products", "field": "subdomain", "values": ["People", "Staffing"]}]))
    assert ah._v383_enforce_closed_label_roster(products) == 1
    assert [p["subdomain"] for p in products] == ["people", "staffing", ""]


def test_merge_first_review_runs_only_when_a_spec_states_the_policy():
    flat = _flat_hr()
    flat[1][0]["tags"] = ""
    flat[1].append({"domain": "hr", "product": "employee_badge", "tags": "source_table=badge_feed", "description": "employee badge feed"})
    widgets = {}
    assert ah._v383_flag_merge_first_candidates(*flat, widgets_values=widgets) == []
    _register_flat(flat, dict(vs.spec("M1", "other", [], breadth="model"), policy="merge_into_existing"))
    flags = ah._v383_flag_merge_first_candidates(*flat, widgets_values=widgets)
    assert flags and all("MERGE-FIRST" in f for f in flags) and widgets["_unfulfilled_for_next_vibe"] == flags


def test_a_set_primary_key_spec_rekeys_the_table_and_repoints_its_foreign_keys():
    flat = _flat_hr()
    _register_flat(flat, vs.spec("K1", "set_primary_key", ["hr.employee.badge_number"]))
    products, attributes = flat[1], flat[2]
    assert ah._v384_apply_canonical_keys(products, attributes, {}) == 1
    assert products[0]["primary_key"] == "badge_number"
    assert next(a for a in attributes if a["attribute"] == "employee_ref")["foreign_key_to"] == "hr.employee.badge_number"
    assert next(a for a in attributes if a["attribute"] == "badge_number")["is_primary_key"] is True
    d, p, a = flat
    assert ah._verify_from_spec(ah.vreq_spec("K1"), d, p, a)["status"] == "fulfilled"
    ah.vov_ledger_reset()
    _register_flat(_flat_hr(), vs.spec("K2", "set_primary_key", ["hr.employee.no_such_column"]))
    assert ah._v384_apply_canonical_keys(products, attributes, {}) == 0


def test_new_spec_shapes_that_cannot_be_acted_on_are_not_interpretable():
    idx = ah._vreq_spec_index(ah.widgets_flat_to_model(*_flat_hr()))
    no_column = ah._normalize_vreq_spec(vs.spec("K1", "set_primary_key", ["hr.employee"]), idx)
    assert no_column["interpretable"] is False and no_column["reason"] == "set_primary_key names no column"
    no_prefix = ah._normalize_vreq_spec(dict(vs.spec("P1", "other", [], breadth="model"), policy="column_prefix"), idx)
    assert no_prefix["interpretable"] is False and no_prefix["reason"] == "column_prefix names no value"
    prefix = ah._normalize_vreq_spec(dict(vs.spec("P2", "other", [], breadth="model"), policy="column_prefix", policy_value="hr_"), idx)
    assert prefix["interpretable"] is True
    d, p, a = _flat_hr()
    assert ah._verify_from_spec(prefix, d, p, a)["status"] == "failed"
    for row in a:
        row["attribute"] = "hr_" + row["attribute"]
    assert ah._verify_from_spec(prefix, d, p, a)["status"] == "fulfilled"


def test_the_classifier_prompt_offers_the_new_spec_shapes():
    for text in ("set_primary_key makes the named column the primary key of its table", '"column_prefix"', '"merge_into_existing"',
                 "- allowed_values:", '"allowed_values": []'):
        assert text in ah.VREQ_SPEC_PROMPT, text
    assert "set_primary_key" in ah.VREQ_SPEC_ACTIONS
    assert {"column_prefix", "merge_into_existing"} <= set(ah.VREQ_SPEC_POLICIES)


def test_a_domain_division_change_is_deployed_even_when_no_table_of_the_domain_is_rebuilt():
    """Live r2b2 540668198521691: the model set finance's division to business, but no finance table was rebuilt, the
    schema-tag statements of preserved domains were filtered out, and the physical schema tag stayed corporate."""
    facts = {"permitted_deltas": [{"kind": "P6", "domain": "finance", "product": "", "attribute": "", "fields": ["division"],
                                   "old": {"division": "corporate"}, "new": {"division": "business"}},
                                  {"kind": "P6", "domain": "media", "product": "", "attribute": "", "fields": ["description"],
                                   "old": {"description": "a"}, "new": {"description": "b"}}]}
    plan = ah.VibeScopeDeployPlan(facts, {"model": {"domains": []}})
    div = "ALTER SCHEMA `c`.`finance` SET TAGS ('dbx_division' = 'business');"
    assert plan.schema_metadata("finance", "`c`.`finance`", "Finance", div) == [div]
    assert plan.schema_metadata("finance", "`c`.`finance`", "Finance", div) == []
    assert plan.schema_metadata("media", "`c`.`media`", "Media", "ALTER SCHEMA `c`.`media` SET TAGS ('dbx_division' = 'x');") == \
        ["COMMENT ON SCHEMA `c`.`media` IS 'Media';"]
    assert plan.schema_metadata("contract", "`c`.`contract`", "Contract", "ALTER SCHEMA x;") == []
    assert plan.counts["metadata_statements"] == 2
    src = open(Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb").read()
    assert src.count("replace_single_quote(domain_desc), _div_sql))") == 2


def test_closed_lists_act_only_inside_the_targets_of_the_spec_that_states_them():
    flat = _flat_hr()
    products, attributes = flat[1], flat[2]
    products[0]["subdomain"] = "workforce analytics"
    _register_flat(flat, dict(vs.spec("R1", "set_fields", ["hr.position"], fields=[vs.field("products", "subdomain")]),
                              allowed_values=[{"level": "products", "field": "subdomain", "values": ["Staffing", "Workforce Analytics Hub"]}]))
    assert ah._v383_enforce_closed_label_roster(products) == 1
    assert [p["subdomain"] for p in products] == ["workforce analytics", "staffing", ""]
    ah.vov_ledger_reset()
    _register_flat(flat, dict(vs.spec("L1", "set_fields", ["hr.position"], fields=[vs.field("attributes", "tags")]),
                              tags=[{"key": "cde", "value": "<data element>"}],
                              allowed_values=[{"level": "attributes", "field": "tags", "key": "cde", "values": ["Position Code"]}]))
    attributes[1]["tags"] = "cde=Invented Thing"
    attributes[4]["tags"] = "cde=Another Invention"
    assert ah._v383_purge_fabricated_lookup_tags(attributes) == 1
    assert attributes[1]["tags"] == "cde=Invented Thing" and attributes[4]["tags"] == ""


def test_vibe_constraints_without_the_llm_classification_read_nothing_from_the_vibe():
    config = {"PROMPT_VARIABLES": {"business_config": {"vibe_modelling_instructions": "Remediation mode: do not remove any domain, add more tables."}}}
    out = ah._get_vibe_constraints_impl(config)
    assert out["source"] == "not_interpreted"
    assert (out["is_remediation"], out["no_domain_removal"], out["no_enrichment"], out["min_overlap_for_removal_pct"]) == (False, False, True, 85)
    classified = ah._get_vibe_constraints_impl({"REQUIRED_ACTIONS_FROM_CLASSIFICATION": {"allow_domain_removal": False, "enrich_model_content": True}})
    assert classified["source"] == "classification" and classified["no_domain_removal"] is True and classified["no_enrichment"] is False


def _step_req(rid, text):
    return ah.VibeRequirement(id=rid, original_text=text, intent=text, scope="table", scope_targets=[], verification_strategy="deterministic")


def test_the_step_check_marks_only_what_a_spec_names_and_never_a_count_change():
    before = ah.capture_vibe_model_snapshot([{"domain": "hr"}], [{"domain": "hr", "product": "employee"}], [])
    after = ah.capture_vibe_model_snapshot([{"domain": "hr"}, {"domain": "ops"}],
                                           [{"domain": "hr", "product": "employee"}, {"domain": "hr", "product": "badge"},
                                            {"domain": "ops", "product": "shift"}], [])
    model = ah.widgets_flat_to_model([{"domain": "hr"}], [{"domain": "hr", "product": "employee", "primary_key": "employee_id"}], [])
    vs.register(ah, model, vs.spec("Q1", "add_product", ["hr.badge"]), vs.spec("Q2", "add_product", ["hr.visitor"]),
                vs.spec("Q3", "add_domain", ["ops"]), vs.spec("Q4", "set_fields", ["hr"], fields=[vs.field("domains", "description")]))
    reqs = [_step_req("Q1", "add a badge table"), _step_req("Q2", "add a visitor table"), _step_req("Q3", "add an ops domain"),
            _step_req("Q4", "add more tables and enrich hr"), _step_req("Q5", "add more tables")]
    orch = object.__new__(ah.VibeOrchestrator)
    orch._quick_deterministic_check(reqs, before, after, "step_x")
    assert [r.status for r in reqs] == ["fulfilled", "pending", "fulfilled", "pending", "pending"]
    assert "vreq-spec-quick-check FIRED" in reqs[0].evidence


def test_a_foreign_key_suffix_spec_sets_the_convention_and_is_verified():
    flat = _flat_hr()
    idx = ah._vreq_spec_index(ah.widgets_flat_to_model(*flat))
    empty = ah._normalize_vreq_spec(dict(vs.spec("F0", "other", [], breadth="model"), policy="foreign_key_suffix"), idx)
    assert empty["interpretable"] is False and empty["reason"] == "foreign_key_suffix names no value"
    _register_flat(flat, dict(vs.spec("F1", "other", [], breadth="model"), policy="foreign_key_suffix", policy_value="ref"))
    config = {"MODEL_CONVENTIONS": {"foreign_key_suffix": "_id"}}
    assert ah._vreq_spec_apply_key_conventions(config) == "_ref" and config["MODEL_CONVENTIONS"]["foreign_key_suffix"] == "_ref"
    d, p, a = flat
    assert ah._verify_from_spec(ah.vreq_spec("F1"), d, p, a)["status"] == "failed"
    for row in a:
        if row.get("foreign_key_to"):
            row["attribute"] = row["attribute"].rsplit("_", 1)[0] + "_ref"
    assert ah._verify_from_spec(ah.vreq_spec("F1"), d, p, a)["status"] == "fulfilled"
    ah.vov_ledger_reset()
    assert ah._vreq_spec_apply_key_conventions({"MODEL_CONVENTIONS": {}}) is None


def test_the_contract_reads_no_keyword_from_requirement_text():
    manifest = ah.VibeManifest(raw_text="x", requirements=[_step_req("C1", "PII classification tags on every column; do not drop any domains")],
                               overall_mode="surgical", parse_method="llm")
    contract = manifest.to_contract({})
    assert [c.verifier for c in contract.verification_clauses] == ["spec_verifier"]
    assert not contract.forbidden_ops and not contract.requested_transforms
    nb = json.load(open(Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"))
    src = "\n".join("".join(c["source"]) for c in nb["cells"] if c["cell_type"] == "code")
    assert "_fk_suf_match" not in src and "parse_user_vibes_to_requirements" not in src and "fallback_substring" not in src


def test_the_glossary_coverage_gate_fires_on_a_glossary_spec_and_never_on_the_word_in_the_vibe():
    domains, products, attributes = _flat_hr()
    config = {"PROMPT_VARIABLES": {"model_vibes": "keep the glossary of this model short", "user_special_requirements": "glossary"}}

    def _categories():
        result = ah.run_metamodel_static_analysis(copy.deepcopy(domains), copy.deepcopy(products), copy.deepcopy(attributes), config,
                                                  logging.getLogger("t"))
        return {i["category"] for i in result.get("issues") or []}
    assert "missing_glossary_tag" not in _categories()
    _register_flat((domains, products, attributes),
                   dict(vs.spec("G1", "set_fields", [], breadth="model", fields=[vs.field("attributes", "business_glossary_term")])))
    assert "missing_glossary_tag" in _categories()


def test_the_pk_consistency_pass_keeps_a_primary_key_a_spec_sets():
    """Live r3a 975496194017273: the model set product.digital_asset's key to dam_asset_code, then the PK-consistency pass
    reset it to digital_asset_id 15 s before the DDL, so the physical table kept the old key."""
    flat = _flat_hr()
    products, attributes = flat[1], flat[2]
    products[0]["primary_key"] = "badge_number"
    config = {"MODEL_CONVENTIONS": {"primary_key_suffix": "_id", "data_asset_naming_convention": "snake_case"}}
    plain = copy.deepcopy((products, attributes))
    ah.enforce_configured_pk_consistency(plain[0], plain[1], config, logger=logging.getLogger("t"))
    assert plain[0][0]["primary_key"] == "employee_id"
    _register_flat(flat, vs.spec("K1", "set_primary_key", ["hr.employee.badge_number"]))
    ah.enforce_configured_pk_consistency(products, attributes, config, logger=logging.getLogger("t"))
    assert products[0]["primary_key"] == "badge_number"
    assert [a["attribute"] for a in attributes if a["product"] == "employee"] == ["employee_id", "badge_number", "position_id"]
    assert next(a for a in attributes if a["attribute"] == "employee_ref")["foreign_key_to"] == "hr.employee.badge_number"
    assert products[1]["primary_key"] == "position_id"
    assert ah._vreq_spec_user_pk("HR", "Employee") == "badge_number" and ah._vreq_spec_user_pk("hr", "position") is None


def test_the_qa_and_fk_gate_pk_fixes_leave_a_user_primary_key_alone():
    nb = json.load(open(Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"))
    src = "\n".join("".join(c["source"]) for c in nb["cells"] if c["cell_type"] == "code")
    assert "(pk_name != expected_pk and _vov285_san(pk_name) != _vov285_san(_user_pk))" in src
    assert "if pk != expected_pk and _vov285_san(pk) != _vov285_san(_vreq_spec_user_pk(domain_name, name)):" in src
    assert "if _pk_like_cols and not _vreq_spec_user_pk(p_domain, p_product):" in src


def test_keep_only_needs_a_table_and_restricts_a_shrink_to_the_named_tables():
    idx = ah._vreq_spec_index(ah.widgets_flat_to_model(*_flat_hr()))
    bad = ah._normalize_vreq_spec(vs.spec("S0", "keep_only", ["hr"]), idx)
    assert bad["interpretable"] is False and bad["reason"] == "keep_only names no table"
    flat = _flat_hr()
    flat[1].append({"domain": "ops", "product": "roster", "primary_key": "roster_id"})
    _register_flat(flat, vs.spec("S1", "keep_only", ["hr.employee"]), vs.spec("S2", "preserve", ["ops.roster", "ops.ghost_table"]),
                   vs.spec("S3", "keep_only", ["ops.unknown_table"]))
    specs = [ah.vreq_spec(s) for s in ("S1", "S2", "S3")]
    keep = {("hr", "employee"), ("hr", "position"), ("ops", "shift")}
    out = ah._vov_shrink_apply_reviewer_specs(keep, specs, flat[1])
    assert out == {("hr", "employee"), ("ops", "shift"), ("ops", "roster")}
    assert ah._vov_shrink_apply_reviewer_specs(sorted(keep), specs[2:], flat[1]) == sorted(keep)


class _ShrinkAgent:
    def __init__(self, specs):
        self.specs, self.calls = specs, []

    def _call_ai_query(self, **kw):
        self.calls.append(kw["prompt_name"])
        return json.dumps(vs.reply(kw["prompt"], self.specs))


def test_shrink_reads_the_reviewer_directives_through_the_llm_spec():
    text = ("REVIEWER-PRIORITY 1 — trim_hr: the hr domain should be minimal: employee only\n"
            "REVIEWER-PRIORITY 2 — keep_ops: keep the ops roster in the MVM\n")
    flat = _flat_hr()
    agent = _ShrinkAgent([vs.spec("REVIEWER-1", "keep_only", ["hr.employee"]), vs.spec("REVIEWER-2", "add_column", ["ops.shift"],
                                                                                       columns=[{"name": "x", "type": "STRING"}])])
    specs = ah._vov_shrink_reviewer_specs(text, ah.widgets_flat_to_model(*flat), agent, logging.getLogger("t"))
    assert [s["id"] for s in specs] == ["REVIEWER-1"] and agent.calls == ["VREQ_SPEC_PROMPT"]
    assert ah._vov_shrink_reviewer_specs("no reviewer blocks here", ah.widgets_flat_to_model(*flat), agent) == []
    assert agent.calls == ["VREQ_SPEC_PROMPT"]


def test_keep_only_is_verified_and_permitted_only_inside_its_domains():
    flat = _flat_hr()
    _register_flat(flat, vs.spec("K1", "keep_only", ["hr.employee"]))
    spec = ah.vreq_spec("K1")
    d, p, a = flat
    assert ah._verify_from_spec(spec, d, p, a)["status"] == "partial"
    only = [r for r in p if not (r["domain"] == "hr" and r["product"] == "position")]
    assert ah._verify_from_spec(spec, d, only, a)["status"] == "fulfilled"
    assert ah._verify_from_spec(spec, d, [r for r in only if r["product"] != "employee"], a)["status"] == "failed"
    assert ah.diff_within_requirement_scope({"products_removed": [["hr", "position"]]}, ["K1"])[0] is True
    assert ah.diff_within_requirement_scope({"products_removed": [["hr", "employee"]]}, ["K1"])[0] is False
    assert ah.diff_within_requirement_scope({"products_removed": [["ops", "shift"]]}, ["K1"])[0] is False
    req = ah.RawVREQ(vreq_id="K1", intent="keep only employee", target="hr.employee", source_quote="keep only employee", source_chunk_id="c")
    requested, wide = ah._vibe_scope_requested_spec([req], ah.widgets_flat_to_model(*flat))
    assert "hr" in requested.whole_domains and ("hr", "employee") in requested.products and wide == []


def test_the_classifier_reads_every_reply_shape_that_carries_the_specs():
    one = {"id": "V1", "action": "add_column", "targets": [{"domain": "crew", "product": "member", "column": "nickname"}]}
    assert ah._vreq_spec_reply_list([one]) == [one]
    assert ah._vreq_spec_reply_list({"specs": [one]}) == [one]
    assert ah._vreq_spec_reply_list({"specs": {"V1": dict(one, id="")}})[0]["id"] == "V1"
    assert ah._vreq_spec_reply_list({"vreq_specs": [one]}) == [one]
    for bad in ({"a": [one], "b": [one]}, {"specs": "none"}, "text", None, [1, 2]):
        assert ah._vreq_spec_reply_list(bad) is None, bad
    specs = ah.classify_vreq_specs(lambda prompt, schema: [dict(one, interpretable=True)], [_item("V1", "add a nickname column")], _model(), None)
    assert specs["V1"]["interpretable"] is True and specs["V1"]["action"] == "add_column"
    failed = ah.classify_vreq_specs(lambda prompt, schema: {"answer": "no"}, [_item("V2")], _model(), None)
    assert failed["V2"]["interpretable"] is False and "a dict with keys ['answer']" in failed["V2"]["reason"]


def test_a_scoped_run_whose_requirements_cannot_be_read_changes_nothing_inside_the_scope():
    """Live r4a 1072700004790036: the engine read neither requirement, the named set came back empty, and the fence opened
    every product of the scoped domain: 19 products and 20 metric views changed for a two-item vibe."""
    fence = E._fence()
    base = E._engine()
    unread = [ah.RawVREQ(vreq_id=f"VREQ-000{i}", intent="x", target="crew.member", source_quote="x", source_chunk_id="c") for i in (1, 2)]
    ah.register_vreq_specs({v.vreq_id: ah._vreq_spec_not_interpreted(v.vreq_id, "unread", ah._vreq_spec_index(base)) for v in unread})
    ah._vibe_scope_narrow_scoped(fence, unread, base, LOG)
    assert fence.spec.named_only is True and not fence.spec.products and not fence.spec.whole_domains
    fence = E._fence()
    vs.register(ah, base, vs.spec("VREQ-001", "add_column", ["crew.member"], columns=[{"name": "nickname", "type": "STRING"}]))
    ah._vibe_scope_narrow_scoped(fence, unread, base, LOG)
    assert fence.spec.named_only is True and fence.spec.products == frozenset({("crew", "member")})


# ---------------------------------------------------------------- base-domain preservation, scoreboard, pass 1, folds, counts


def _tiny():
    def table(name, *attrs):
        return {"name": name, "primary_key": f"{name}_id",
                "attributes": [{"name": f"{name}_id", "type": "BIGINT", "is_primary_key": True}] + [dict(a) for a in attrs]}
    return {"model": {"domains": [
        {"name": "crew", "division": "operations", "products": [
            table("member", {"name": "full_name", "type": "STRING"}),
            table("person"),
            table("staff", {"name": "grade", "type": "STRING"}),
            table("roster", {"name": "member_id", "type": "BIGINT", "foreign_key_to": "crew.member.member_id"},
                  {"name": "staff_id", "type": "BIGINT", "foreign_key_to": "crew.staff.staff_id"})]},
        {"name": "ops", "division": "business", "products": [table("member")]}]}}


def _table(model, domain, name):
    return next((p for d in model["model"]["domains"] if d["name"] == domain for p in d["products"] if p["name"] == name), None)


def _fk(model, domain, table, column):
    return next(a.get("foreign_key_to") for a in _table(model, domain, table)["attributes"] if a["name"] == column)


def test_base_domains_stay_preserved_unless_a_spec_drops_merges_or_renames_them():
    base = {"model": {"domains": [{"name": n, "products": []} for n in ("crew", "fleet", "ops", "cargo")]}}
    widgets = {"business_context_raw": base}
    pinned = set(ah._USER_PINNED_DOMAINS_RUNTIME)
    ah._USER_PINNED_DOMAINS_RUNTIME.clear()
    try:
        assert ah._vov_refresh_preserved_domains(widgets, LOG) == ["crew", "fleet", "ops", "cargo"]
        assert {"crew", "fleet", "ops", "cargo"} <= ah._USER_PINNED_DOMAINS_RUNTIME
        vs.register(ah, base, vs.spec("V1", "drop_domain", ["fleet"]), vs.spec("V2", "rename_domain", ["ops"], new_name="operations"),
                    vs.spec("V3", "merge_domains", ["cargo"], merge_into="crew"))
        assert ah._vov_refresh_preserved_domains(widgets, LOG) == ["crew"]
        assert widgets["_preserve_v1_domains"] == ["crew"] and widgets["_preserve_v1_pinned"] == ["crew"]
        assert ah._USER_PINNED_DOMAINS_RUNTIME == {"crew"}
    finally:
        ah._USER_PINNED_DOMAINS_RUNTIME.clear()
        ah._USER_PINNED_DOMAINS_RUNTIME.update(pinned)


def test_setup_and_parse_both_refresh_the_preserved_domains_from_the_specs():
    from notebook_source_util import notebook_concat_source
    src = notebook_concat_source()
    setup = src[src.index("def step_setup_and_clean("):]
    setup = setup[:setup.index("\ndef ", 10)]
    assert "_vov_refresh_preserved_domains(widgets_values, logger)" in setup and "_vov_vibe_text_for_closure" not in src
    parse = src[src.index("            _vov_refresh_user_closure(self.widgets_values, self.logger)"):][:400]
    assert "_vov_refresh_preserved_domains(self.widgets_values, self.logger)" in parse


def test_scope_rejection_and_lineage_links_match_requirements_by_spec_not_by_shared_words():
    model = _tiny()
    vs.register(ah, model, vs.spec("R1", "rename_product", ["crew.member"], new_name="crew_member"),
                vs.spec("R2", "drop_column", ["crew.member.full_name"]),
                vs.spec("V1", "rename_product", ["crew.member"], new_name="crew_member"),
                vs.spec("V2", "rename_column", ["crew.member.full_name"], new_name="display_name"))
    orch = ah.VibeOrchestrator({"logger": LOG, "config": {}, "vibe_modelling_instructions": "x", "operation": "vibe modeling of version"})
    shared = "rename the crew member table and its full name column"
    reqs = [ah.VibeRequirement(id=r, original_text=shared, intent="x", scope="model", scope_targets=["*"]) for r in ("R1", "R2")]
    orch.manifest = ah.VibeManifest(raw_text=shared, requirements=list(reqs))
    rejected = [ah.RawVREQ(vreq_id="V1", intent=shared, target="crew.member", source_quote=shared, source_chunk_id="c1")]
    kept = [ah.RawVREQ(vreq_id="V2", intent=shared, target="crew.member", source_quote=shared, source_chunk_id="c1")]
    assert orch.mark_scope_rejected(rejected, kept)["moved"] == 1
    assert [r.id for r in orch.scope_rejected_requirements] == ["R1"] and [r.id for r in orch.manifest.requirements] == ["R2"]
    widgets = {"_vov_2_raw_vreqs": [{"vreq_id": v, "intent": shared, "source_quote": shared} for v in ("V1", "V2")]}
    links = ah._vibe_lineage_requirement_links(widgets, [{"req_id": "R1", "text": shared}, {"req_id": "R2", "text": shared}])
    assert links["R1"]["vreq_ids"] == ["V1"] and links["R2"]["vreq_ids"] == []
    assert not hasattr(ah.VibeOrchestrator, "fold_vov_outcomes") and not hasattr(ah.VibeOrchestrator, "_vov_text_overlaps")


def test_pass1_relabels_a_priority_from_its_spec_and_never_renames_a_table_for_a_column_rename():
    model = _tiny()
    vs.register(ah, model, vs.spec("C1", "rename_column", ["crew.member.full_name"], new_name="display_name"),
                vs.spec("C2", "rename_product", ["crew.staff"], new_name="crew_staff"))
    priorities = [{"action": "fix_naming", "target": "crew.member", "vreq_id": "C1", "reason": "names"},
                  {"action": "tidy", "target": "crew.staff", "vreq_id": "C2", "reason": "names"}]
    new_model, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, LOG)
    member = _table(new_model, "crew", "member")
    assert member is not None and {a["name"] for a in member["attributes"]} == {"member_id", "display_name"}, (outcomes, residual)
    assert _table(new_model, "crew", "crew_staff") is not None and _table(new_model, "crew", "staff") is None
    assert [p["action"] for p in priorities] == ["rename_attribute", "rename_product"]


def test_a_plain_column_add_passes_prevalidation_and_a_missing_table_or_column_does_not():
    model = _tiny()
    assert ah._v251_prevalidate_priority({"action": "add_attribute", "target": "crew.member"}, model, {"column": "nickname"}) == (True, "")
    assert ah._v251_prevalidate_priority({"action": "add_attribute", "target": "crew.member"}, model, {}) == (False, "column-missing")
    assert ah._v251_prevalidate_priority({"action": "add_attribute", "target": "crew.ghost"}, model, {"column": "x"})[0] is False
    assert ah._v251_prevalidate_priority({"action": "connect_table", "target": "crew.member"}, model, {"column": "x"}) == (False, "fk-target-missing")


def test_pass1_adds_every_column_a_multi_column_spec_names_on_a_single_priority():
    model = _tiny()
    vs.register(ah, model, vs.spec("A1", "add_column", ["crew.member"], columns=[{"name": "hire_date", "type": "DATE"}, {"name": "base_code", "type": "STRING"}]))
    new_model, _outcomes, _residual = ah._v251_apply_pass1_priorities([{"action": "add_attribute", "target": "crew.member", "vreq_id": "A1"}], model, LOG)
    types = {a["name"]: a.get("type") for a in _table(new_model, "crew", "member")["attributes"]}
    assert {"hire_date", "base_code"} <= set(types) and types["hire_date"].upper().startswith("DATE"), types


def test_the_severity_sort_replaces_frozen_requirements_instead_of_dropping_the_new_severity(monkeypatch):
    vreqs = [ah.RawVREQ(vreq_id=v, intent="x", target="", source_quote="x", source_chunk_id="c1", severity=s) for v, s in (("B", "medium"), ("A", "low"))]
    monkeypatch.setattr(ah, "_v298_recalibrate_severity", lambda v: "critical" if v.vreq_id == "A" else v.severity)
    out = ah._v296_sort_vreqs(vreqs)
    assert [(v.vreq_id, v.severity) for v in out] == [("A", "critical"), ("B", "medium")]
    assert vreqs[1].severity == "low"


def test_a_move_onto_a_table_of_the_same_name_folds_the_source_into_it():
    model = _tiny()
    vs.register(ah, model, vs.spec("M1", "move_product", ["crew.member"], destination_domain="ops"))
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "M1"}, LOG)
    assert ok is True, evidence
    assert _table(model, "crew", "member") is None and "full_name" in {a["name"] for a in _table(model, "ops", "member")["attributes"]}
    assert _fk(model, "crew", "roster", "member_id") == "ops.member.member_id"
    assert ah._vov_vreq_satisfied_in_model("M1", model)[0] == "satisfied"


def test_merge_products_folds_each_source_into_the_target_and_repoints_its_foreign_keys():
    model = _tiny()
    vs.register(ah, model, vs.spec("G1", "merge_products", ["crew.member"], merge_into="crew.person"))
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "G1"}, LOG)
    assert ok is True, evidence
    person = _table(model, "crew", "person")
    assert _table(model, "crew", "member") is None and [a["name"] for a in person["attributes"]] == ["person_id", "full_name"]
    assert _fk(model, "crew", "roster", "member_id") == "crew.person.person_id"
    assert ah._vov_vreq_satisfied_in_model("G1", model)[0] == "satisfied"
    assert ah._vreq_spec_det_ops(ah.vreq_spec("G1"), model) and ah._v410_deterministic_selffix(model, {"id": "G1"}, LOG)[0] in (True, None)
    assert [a["name"] for a in _table(model, "crew", "person")["attributes"]] == ["person_id", "full_name"]


def test_merge_products_into_a_new_name_renames_the_first_source_and_folds_the_rest():
    model = _tiny()
    vs.register(ah, model, vs.spec("G2", "merge_products", ["crew.member", "crew.staff"], merge_into="crew.crew_person"))
    if not ah.vreq_spec("G2")["merge_into"]:
        pytest.skip("the normalizer keeps merge_into only for catalog tables")
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "G2"}, LOG)
    assert ok is True, evidence
    merged = _table(model, "crew", "crew_person")
    assert _table(model, "crew", "member") is None and _table(model, "crew", "staff") is None
    assert {"full_name", "grade"} <= {a["name"] for a in merged["attributes"]}
    assert _fk(model, "crew", "roster", "member_id").startswith("crew.crew_person.") and _fk(model, "crew", "roster", "staff_id").startswith("crew.crew_person.")


def test_a_merge_into_a_missing_table_of_another_domain_has_no_deterministic_op():
    model = _tiny()
    op = ah._vreq_spec_det_op(dict(vs.spec("G3", "merge_products", ["crew.member"], merge_into="ops.person"), interpretable=True), model)
    assert op == ("fold_product", "crew", "member", "ops", "person")
    assert ah._v413_apply_det_op_inplace(model, op) is None and _table(model, "crew", "member") is not None


def test_already_satisfied_covers_primary_keys_and_retypes():
    model = _tiny()
    vs.register(ah, model, vs.spec("K1", "set_primary_key", ["crew.member.member_id"]),
                vs.spec("K2", "set_primary_key", ["crew.member.full_name"]))
    assert ah._vov_vreq_satisfied_in_model("K1", model)[0] == "satisfied"
    assert ah._vov_vreq_satisfied_in_model("K2", model)[0] != "satisfied"


def test_a_placeholder_tag_for_a_non_provenance_key_is_never_filled_with_column_names():
    flat = _flat_hr()
    _register_flat(flat, _tag_spec("T1", ["hr"], "attributes", [{"key": "source_attribute", "value": "<original column>"}], breadth="set"),
                   _tag_spec("T2", ["hr"], "attributes", [{"key": "business_glossary_term", "value": "<glossary term>"}], breadth="set"))
    attributes = flat[2]
    assert ah._v383_apply_per_attribute_value_tags(attributes, flat[1]) == 3
    assert not any("business_glossary_term" in a["tags"] for a in attributes)


def test_the_metric_view_requeue_asks_only_for_a_floor_and_counts_the_domains_a_spec_names():
    model = {"model": {"domains": [{"name": f"d{i}", "products": []} for i in range(3)],
                       "metric_views": [{"name": "a", "owner_domain": "d0"}, {"name": "b"}]}}
    cases = [
        ({"entity": "metric_views", "op": "at_most", "value": 4}, [], None),
        ({"entity": "metric_views", "op": "at_least", "value": 4}, [], (2, 4)),
        ({"entity": "metric_views", "op": "between", "value": 9, "low": 5}, [], (2, 5)),
        ({"entity": "metric_views", "op": "at_least", "value": 3}, ["d0"], (1, 3)),
        ({"entity": "metric_views", "op": "at_least", "value": 1}, ["d0"], None),
        ({"entity": "metric_views_per_domain", "op": "at_least", "value": 2}, [], (1, 6)),
        ({"entity": "metric_views_per_domain", "op": "about", "value": 2}, ["d1", "d2"], (0, 2)),
    ]
    for count, targets, expected in cases:
        ah.vov_ledger_reset()
        vs.register(ah, model, vs.spec("N1", "other", targets, kind="count_target", count=count))
        widgets = {}
        ah._v320_vibe_completeness_requeue(model, widgets, LOG)
        queued = [q for q in widgets.get("_unfulfilled_for_next_vibe", []) if q["id"] == "COMPLETENESS-MV-COUNT"]
        if expected is None:
            assert not queued, (count, targets, queued)
            continue
        have, want = expected
        assert queued and queued[0]["evidence"].startswith(f"have={have} want={want} shortfall={want - have}"), (count, targets, queued)
        assert "more in" in queued[0]["text"] and "N1" in queued[0]["text"]


def test_prohibitions_and_informational_requirements_open_nothing_in_the_requested_scope():
    model = _tiny()
    vs.register(ah, model, vs.spec("Q1", "preserve", [], breadth="model"), vs.spec("Q2", "other", [], breadth="model", kind="deployment"),
                vs.spec("Q3", "check_only", ["crew.member"]), vs.spec("Q4", "rename_product", ["crew.staff"], new_name="crew_staff"))
    vreqs = [ah.RawVREQ(vreq_id=v, intent="x", target="", source_quote="x", source_chunk_id="c1") for v in ("Q1", "Q2", "Q3", "Q4")]
    spec, wide = ah._vibe_scope_requested_spec(vreqs, model)
    assert wide == [] and spec.whole_domains == frozenset(), (wide, spec.whole_domains)
    assert ("crew", "member") not in spec.products and ("crew", "staff") in spec.products
    spec, wide = ah._vibe_scope_requested_spec(vreqs[:3], model)
    assert spec is None and wide == []


def _count_rows():
    domains = [{"domain": "a", "division": "operations"}, {"domain": "b", "division": "operations"}, {"domain": "c", "division": "business"}]
    products = [{"domain": "a", "product": "p1", "subdomain": "s1"}, {"domain": "a", "product": "p2", "subdomain": "s1"},
                {"domain": "b", "product": "p3", "subdomain": "s2"}, {"domain": "c", "product": "p4", "subdomain": ""}]
    attrs = [{"domain": p["domain"], "product": p["product"], "attribute": f"c{i}"} for p in products for i in range(3)]
    return domains, products, attrs


@pytest.mark.parametrize("count,status", [
    ({"entity": "domains_per_division", "op": "at_most", "value": 2}, "fulfilled"),
    ({"entity": "domains_per_division", "op": "exactly", "value": 2}, "partial"),
    ({"entity": "subdomains", "op": "exactly", "value": 2}, "fulfilled"),
    ({"entity": "products_per_subdomain", "op": "at_least", "value": 2}, "partial"),
    ({"entity": "attributes", "op": "between", "value": 12, "low": 10}, "fulfilled"),
    ({"entity": "attributes", "op": "between", "value": 9, "low": 5}, "failed"),
    ({"entity": "products", "op": "between", "value": 5, "low": 4}, "fulfilled"),
])
def test_every_count_the_flat_rows_carry_gets_a_deterministic_verdict(count, status):
    vs.register(ah, {"model": {"domains": []}}, vs.spec("N2", "other", [], kind="count_target", count=count))
    verdict = ah._verify_from_spec(ah.vreq_spec("N2"), *_count_rows())
    assert verdict is not None and verdict["status"] == status, verdict


def test_a_metric_view_count_is_left_to_the_physical_metric_view_gate():
    vs.register(ah, {"model": {"domains": []}}, vs.spec("N3", "other", [], kind="count_target", count={"entity": "metric_views_per_domain", "op": "exactly", "value": 2}))
    assert ah.vreq_spec("N3")["interpretable"] and ah._verify_from_spec(ah.vreq_spec("N3"), *_count_rows()) is None


# ---------------------------------------------------------------- cleanup permissions and the long-vibe re-parse are LLM reads


def test_cleanup_permissions_merge_so_a_prohibition_or_an_ask_in_any_reply_wins():
    defaults = ah._VIBE_REQUIRED_ACTION_DEFAULTS
    assert ah._vibe_required_actions([None, {}]) == {}
    assert ah._vibe_required_actions([dict(defaults)]) == defaults
    merged = ah._vibe_required_actions([dict(defaults), dict(defaults, allow_table_removal=False), dict(defaults, reduce_model_content=True),
                                        {"allow_domain_rename": "no", "unknown_flag": False}])
    assert merged == dict(defaults, allow_table_removal=False, reduce_model_content=True)


def test_the_vibe_parse_feeds_the_cleanup_permissions_the_llm_read_into_the_constraints():
    actions = dict(ah._VIBE_REQUIRED_ACTION_DEFAULTS, allow_domain_removal=False, enrich_model_content=True)
    widgets = _orch_parse(_ParseAgent("vibe", actions=actions))
    assert widgets["config"]["REQUIRED_ACTIONS_FROM_CLASSIFICATION"] == actions
    constraints = ah._get_vibe_constraints_impl(widgets["config"])
    assert constraints["source"] == "classification" and constraints["no_domain_removal"] and not constraints["no_enrichment"]
    assert not constraints["no_domain_rename"] and constraints["no_reduction"] and constraints["no_division_drop"]
    ah.vov_ledger_reset()
    widgets = _orch_parse(_ParseAgent("vibe"))
    assert "REQUIRED_ACTIONS_FROM_CLASSIFICATION" not in widgets["config"]
    widgets["config"]["PROMPT_VARIABLES"] = {"business_config": {"vibe_modelling_instructions": "Do not remove any domain."}}
    fallback = ah._get_vibe_constraints_impl(widgets["config"])
    assert fallback["source"] == "not_interpreted" and not fallback["no_domain_removal"], "no text reading may stand in for the LLM"
    assert "`required_actions`" in ah.PROMPT_TEMPLATES["VIBE_PARSE_PROMPT"]
    assert "required_actions" in ah._VIBE_PARSE_RESPONSE_SCHEMA["schema"]["required"]


class _SectionParseAgent:
    def __init__(self):
        self.steps = []

    def _call_ai_query(self, prompt_name=None, prompt=None, step_name="", **kwargs):
        if prompt_name == "VIBE_PARSE_PROMPT":
            self.steps.append(step_name)
            req = {"original_text": f"ask from {step_name}", "intent": f"ask from {step_name}", "scope": "model", "scope_targets": ["*"],
                   "mode": "surgical", "priority": "high", "constraint_type": "soft", "verification_strategy": "llm_verify"}
            return json.dumps({"requirements": [req], "sizing_directives": {}, "model_conventions": {},
                               "required_actions": dict(ah._VIBE_REQUIRED_ACTION_DEFAULTS, allow_table_removal=step_name != "vibe_parse_segment_2")})
        return json.dumps({"specs": []})


def test_a_long_vibe_with_heading_sections_is_reparsed_per_section_and_review_words_alone_trigger_nothing():
    body = "Every table keeps its description and every key stays documented for the auditors. " * 9
    vibe = "\n\n".join(f"## Area {i}\n{body}" for i in range(1, 4))
    agent = _SectionParseAgent()
    widgets = _orch_parse(agent, vibe)
    assert len(vibe) >= 2000 and agent.steps == ["vibe_parse_llm", "vibe_parse_segment_1", "vibe_parse_segment_2", "vibe_parse_segment_3"]
    assert len(widgets["vibe_manifest"].requirements) == 4
    assert widgets["config"]["REQUIRED_ACTIONS_FROM_CLASSIFICATION"]["allow_table_removal"] is False
    ah.vov_ledger_reset()
    words = ("Must Fix: " + body + "\nShould Fix: " + body + "\nReviewer: " + body + "\nConcrete asks: " + body)
    agent = _SectionParseAgent()
    _orch_parse(agent, words)
    assert len(words) >= 2000 and agent.steps == ["vibe_parse_llm"]


def test_a_fill_only_requirement_is_already_satisfied_only_when_every_targeted_value_is_filled():
    model = _tiny()
    for p in _table(model, "crew", "member"), _table(model, "crew", "roster"):
        for a in p["attributes"]:
            a["description"] = f"what {a['name']} holds"
    vs.register(ah, model, vs.spec("F1", "set_fields", ["crew"], breadth="set", fields=[vs.field("attributes", "description", fill=True)],
                                   fill_fields=[("attributes", "description")]),
                vs.spec("F2", "set_fields", ["crew.member"], fields=[vs.field("attributes", "description")]))
    assert ah._vov_vreq_satisfied_in_model("F1", model)[0] == "unsatisfied"
    for p in _table(model, "crew", "person"), _table(model, "crew", "staff"):
        for a in p["attributes"]:
            a["description"] = f"what {a['name']} holds"
    assert ah._vov_vreq_satisfied_in_model("F1", model)[0] == "satisfied"
    assert ah._vov_vreq_satisfied_in_model("F2", model)[0] == "unknown", "a rewrite ask is never pre-skipped on values that already exist"
    _table(model, "crew", "member")["attributes"] += [{"name": f"extra_{i}", "type": "STRING", "description": "an extra fact"} for i in range(11)]
    _table(model, "crew", "staff")["attributes"][1]["description"] = ""
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    assert ah._verify_from_spec(ah.vreq_spec("F1"), d, p, a)["status"] == "fulfilled", "12 of 13 filled meets the scoring tolerance"
    assert ah._vov_vreq_satisfied_in_model("F1", model)[0] == "unsatisfied", "the bulk tolerance never pre-skips a fill"


# ---------------------------------------------------------------- clearing a field, per-column retypes, self-contradicting specs


def _regex_model():
    model = _tiny()
    for table in ("member", "staff"):
        for a in _table(model, "crew", table)["attributes"]:
            a["value_regex"] = "^[A-Z0-9]+$"
    return model


def test_a_clear_requirement_is_fulfilled_by_blank_values_and_lands_deterministically():
    model = _regex_model()
    vs.register(ah, model, vs.spec("X1", "clear_fields", ["crew.member"], fields=[vs.field("attributes", "value_regex")]))
    spec = ah.vreq_spec("X1")
    assert spec["interpretable"] and ah._vreq_spec_open_fields(spec) == {("attributes", "value_regex")}
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    assert ah._verify_from_spec(spec, d, p, a)["status"] == "failed", "a value that is still set is not cleared"
    assert ah._vov_vreq_satisfied_in_model("X1", model)[0] == "unsatisfied"
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "X1"}, LOG)
    assert ok is True, evidence
    assert all(not a.get("value_regex") for a in _table(model, "crew", "member")["attributes"])
    assert all(a.get("value_regex") for a in _table(model, "crew", "staff")["attributes"]), "only the named table is cleared"
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    assert ah._verify_from_spec(spec, d, p, a)["status"] == "fulfilled"
    op = ah._vreq_spec_det_op(spec, model)
    assert ah._vov_det_op_landed(op, ah._vibe_scope_index(model), model) and ah._v413_apply_det_op_inplace(model, op) == ""


def test_a_clear_requirement_may_blank_the_fields_it_names_and_a_set_requirement_may_not():
    for action, survives in (("clear_fields", True), ("set_fields", False)):
        ah.vov_ledger_reset()
        ah.set_vibe_scope_runtime(None)
        base = _regex_model()
        vs.register(ah, base, vs.spec("X2", action, ["crew.member"], fields=[vs.field("attributes", "value_regex")]))
        vreq = ah.RawVREQ(vreq_id="X2", intent="x", target="crew.member", source_quote="x", source_chunk_id="c1")
        fence = ah._vibe_scope_start_requested([vreq], copy.deepcopy(base), LOG, copy.deepcopy(base))
        assert (("attributes", "value_regex") in fence.spec.clear_fields) is survives
        final = copy.deepcopy(base)
        for a in _table(final, "crew", "member")["attributes"]:
            a["value_regex"] = ""
        fence.splice_and_verify(final, LOG)
        assert all(not a.get("value_regex") for a in _table(final, "crew", "member")["attributes"]) is survives, action
    ah.set_vibe_scope_runtime(None)


def test_a_multi_column_retype_carries_each_columns_own_type_and_a_column_without_one_is_a_problem():
    model = _tiny()
    vs.register(ah, model,
                vs.spec("T1", "retype_column", ["crew.member.full_name", "crew.staff.grade"],
                        columns=[{"name": "full_name", "type": "VARCHAR(200)"}, {"name": "grade", "type": "INT"}]),
                vs.spec("T2", "retype_column", ["crew.member.full_name", "crew.staff.grade"], columns=[{"name": "full_name", "type": "VARCHAR(200)"}]),
                vs.spec("T3", "retype_column", ["crew.member.full_name", "crew.staff.grade"], column_type="STRING"))
    vreq = lambda vid: ah.RawVREQ(vreq_id=vid, intent="", target="", source_quote="", source_chunk_id="c1")
    assert sorted((p["target"], p["target_state"]) for p in ah._vov_vreq_to_priorities(vreq("T1"))) == [
        ("crew.member.full_name", "VARCHAR(200)"), ("crew.staff.grade", "INT")]
    assert not ah.vreq_spec("T2")["interpretable"] and "names no type for ['crew.staff.grade']" in ah.vreq_spec("T2")["reason"]
    assert {p["target_state"] for p in ah._vov_vreq_to_priorities(vreq("T3"))} == {"STRING"}
    details = ah._v251_parse_priority_details({"action": "retype_attribute", "target": "crew.staff.grade", "vreq_id": "T1"})
    assert details["new_type"] == "INT"
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    assert ah._verify_from_spec(ah.vreq_spec("T1"), d, p, a)["status"] != "fulfilled"
    next(x for x in _table(model, "crew", "staff")["attributes"] if x["name"] == "grade")["type"] = "INT"
    next(x for x in _table(model, "crew", "member")["attributes"] if x["name"] == "full_name")["type"] = "VARCHAR(200)"
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    assert ah._verify_from_spec(ah.vreq_spec("T1"), d, p, a)["status"] == "fulfilled"


@pytest.mark.parametrize("raw,problem", [
    (vs.spec("P1", "drop_product", ["crew.staff"], kind="deployment"), "deployment requirement changes no model entity"),
    (vs.spec("P2", "remove_fk", ["crew.roster"]), "remove_fk names no column"),
    (vs.spec("P3", "retype_column", ["crew.member"], column_type="INT"), "retype_column names no column"),
    (vs.spec("P4", "clear_fields", ["crew.member"]), "clear_fields names no field"),
    (vs.spec("P5", "clear_fields", ["crew"], fields=[vs.field("domains", "division")]), "division cannot be cleared"),
])
def test_specs_that_contradict_themselves_are_not_interpretable(raw, problem):
    spec = ah._normalize_vreq_spec(raw, ah._vreq_spec_index(_tiny()))
    assert not spec["interpretable"] and problem in spec["reason"], spec["reason"]


def test_an_informational_requirement_with_no_model_action_stays_interpretable():
    spec = ah._normalize_vreq_spec(vs.spec("P6", "other", [], kind="deployment"), ah._vreq_spec_index(_tiny()))
    assert spec["interpretable"] and spec["kind"] == "deployment"


def test_the_fence_rejects_a_glossary_term_that_restates_its_column_name():
    assert ah._vibe_scope_bad_value("business_glossary_term", "Member Id", "member_id")
    assert not ah._vibe_scope_bad_value("business_glossary_term", "Crew Member Identifier", "member_id")
    vs.register(ah, _tiny(), vs.spec("B1", "set_fields", ["crew.member"], fields=[vs.field("attributes", "business_glossary_term")]))
    row = {"domain": "crew", "product": "member", "attribute": "member_id", "business_glossary_term": "Member Id"}
    assert not ah._verify_spec_value_ok(ah.vreq_spec("B1"), "attributes", "business_glossary_term", row)
    row["business_glossary_term"] = "Crew Member Identifier"
    assert ah._verify_spec_value_ok(ah.vreq_spec("B1"), "attributes", "business_glossary_term", row)


def test_a_batch_is_generative_only_when_its_specs_create_tables_domains_or_metric_views():
    vs.register(ah, _tiny(), vs.spec("N1", "add_product", ["crew.shift"]), vs.spec("N2", "set_fields", ["crew.member"], fields=[vs.field("products", "description")]))
    assert ah._vov_batch_is_generative(SimpleNamespace(vreq_ids=("N2", "N1"), intent_summary="", data_payload=()))
    assert not ah._vov_batch_is_generative(SimpleNamespace(vreq_ids=("N2",), intent_summary="build a new product and metric views", data_payload=()))


class _EmptyVerifierLLM:
    def __init__(self):
        self.names = []

    def _call_ai_query(self, prompt_name=None, **kwargs):
        self.names.append(prompt_name)
        return ""


def test_an_empty_llm_verdict_is_a_failure_and_no_second_llm_reads_the_requirement():
    orch = ah.VibeOrchestrator({"logger": LOG, "config": {}, "vibe_modelling_instructions": "x", "operation": "new base model"})
    orch.ai_agent = _EmptyVerifierLLM()
    orch.manifest = ah.VibeManifest(raw_text="x", requirements=[])
    req = ah.VibeRequirement(id="R9", original_text="Make the model clearer", intent="x", scope="model", scope_targets=["*"], verification_strategy="llm_verify")
    verdict = orch._verify_via_llm(req, [{"domain": "crew"}], [{"domain": "crew", "product": "member"}], [{"domain": "crew", "product": "member", "attribute": "member_id"}])
    assert verdict["status"] == "failed" and "[verifier-llm-fallback FIRED v5.3.3]" in verdict["evidence"], verdict
    assert orch.ai_agent.names and set(orch.ai_agent.names) == {"VERIFIER_LLM_FALLBACK"}


def test_connect_details_never_rewrite_a_target_column_that_a_requirement_adds():
    model = _tiny()
    details = ah._v415_complete_connect_details({"action": "connect_table"}, {"fk_target": "crew.person.person_code", "column": "person_code"}, model)
    assert details["fk_target"] == "crew.person.person_id"
    vs.register(ah, model, vs.spec("A2", "add_column", ["crew.person"], columns=[{"name": "person_code", "type": "STRING"}]))
    details = ah._v415_complete_connect_details({"action": "connect_table"}, {"fk_target": "crew.person.person_code", "column": "person_code"}, model)
    assert details["fk_target"] == "crew.person.person_code"


def _policy_rows(cycle=True):
    products = [{"domain": "a", "product": "p", "primary_key": "p_id"}, {"domain": "a", "product": "q", "primary_key": "q_id"},
                {"domain": "a", "product": "r", "primary_key": ""}]
    attrs = [{"domain": "a", "product": "p", "attribute": "p_id"}, {"domain": "a", "product": "p", "attribute": "q_id", "foreign_key_to": "a.q.q_id"},
             {"domain": "a", "product": "q", "attribute": "q_id"}, {"domain": "a", "product": "r", "attribute": "r_id"},
             {"domain": "a", "product": "r", "attribute": "ghost_id", "foreign_key_to": "a.ghost.ghost_id"}]
    if cycle:
        attrs.append({"domain": "a", "product": "q", "attribute": "p_id", "foreign_key_to": "a.p.p_id"})
    return [{"domain": "a", "division": "operations"}], products, attrs


@pytest.mark.parametrize("policy,status,cycle", [
    ("primary_key_everywhere", "failed", True), ("foreign_keys_resolve", "failed", True),
    ("no_fk_cycles", "failed", True), ("no_fk_cycles", "fulfilled", False),
])
def test_structural_policies_get_deterministic_verdicts(policy, status, cycle):
    vs.register(ah, {"model": {"domains": []}}, vs.spec("S1", "other", [], breadth="model", policy=policy))
    verdict = ah._verify_from_spec(ah.vreq_spec("S1"), *_policy_rows(cycle))
    assert verdict is not None and verdict["status"] == status, verdict


# ---------------------------------------------------------------- replaced tables unset cleared tags, platform types, merge sources, fk_from


def test_a_replaced_table_unsets_the_tags_its_cleared_fields_carried():
    base = _regex_model()
    current = copy.deepcopy(base)
    for a in _table(current, "crew", "member")["attributes"]:
        a["value_regex"] = ""
    others = [f"{d['name']}.{p['name']}" for d in current["model"]["domains"] for p in d["products"] if (d["name"], p["name"]) != ("crew", "member")]
    facts = {"changed_in_scope_products": ["crew.member"], "preserved_products": others, "permitted_deltas": []}
    defs = ["`member_id` BIGINT COMMENT 'id'", "`full_name` STRING COMMENT 'name'"]
    plan = ah.VibeScopeDeployPlan(facts, current, base_model=base)
    plan.tag_prefix = "dbx_"
    create, meta = plan.table_statements("crew", "member", "`cat`.`crew`.`member`", defs, "Member")
    assert create.startswith("CREATE OR REPLACE TABLE")
    assert meta == [f"ALTER TABLE `cat`.`crew`.`member` ALTER COLUMN `{c}` UNSET TAGS ('dbx_value_regex');" for c in ("member_id", "full_name")], meta
    assert plan.metadata == meta
    plan = ah.VibeScopeDeployPlan(facts, current)
    plan.tag_prefix = "dbx_"
    assert plan.table_statements("crew", "member", "`cat`.`crew`.`member`", defs, "Member")[1] == []


@pytest.mark.parametrize("want,have,ok", [
    ("int", "bigint", True), ("int", "INT", True), ("decimal(3,1)", "decimal(3,1)", True), ("decimal(3,1)", "decimal(4,1)", False),
    ("int", "string", False), ("date", "timestamp", False), ("smallint", "int", True), ("smallint", "bigint", False),
])
def test_a_spec_type_matches_the_physical_type_through_the_platform_type_map(want, have, ok):
    assert ah._verify_spec_type_matches(ah._sql_type_key(want), have) is ok


def test_a_retype_verdict_says_when_the_platform_type_map_widened_the_type():
    model = _tiny()
    vs.register(ah, model, vs.spec("T9", "retype_column", ["crew.staff.grade"], column_type="INT"))
    next(x for x in _table(model, "crew", "staff")["attributes"] if x["name"] == "grade")["type"] = "BIGINT"
    d, p, a, _mv = ah.model_to_widgets_flat(model, quiet=True)
    verdict = ah._verify_from_spec(ah.vreq_spec("T9"), d, p, a)
    assert verdict["status"] == "fulfilled" and "int deploys as BIGINT" in verdict["evidence"], verdict


def test_a_merge_spec_never_lists_its_own_destination_as_a_source():
    model = _tiny()
    spec = ah._normalize_vreq_spec(vs.spec("G4", "merge_products", ["crew.member", "crew.person"], merge_into="crew.person"), ah._vreq_spec_index(model))
    assert spec["interpretable"] and [ah._vreq_spec_fqn(t) for t in spec["targets"]] == ["crew.member"]
    assert ah._vreq_spec_det_ops(spec, model) == [("fold_product", "crew", "member", "crew", "person")]


def test_every_foreign_key_pointing_at_a_table_becomes_named_column_targets():
    model = _tiny()
    vs.register(ah, model, vs.spec("F9", "retarget_fk", [], breadth="model", fk_from="crew.member", fk_target="crew.person"),
                vs.spec("F8", "remove_fk", [], breadth="model", fk_from="crew.person"))
    spec = ah.vreq_spec("F9")
    assert spec["interpretable"] and spec["breadth"] == "named" and [ah._vreq_spec_fqn(t) for t in spec["targets"]] == ["crew.roster.member_id"]
    assert spec["fk_target"] == "crew.person.person_id"
    assert ah._vreq_spec_det_ops(spec, model) == [("add_fk", "crew", "roster", "member_id", "crew.person.person_id")]
    vreq = ah.RawVREQ(vreq_id="F9", intent="x", target="", source_quote="x", source_chunk_id="c1")
    scope, wide = ah._vibe_scope_requested_spec([vreq], model)
    assert wide == [] and scope.products == {("crew", "roster")} and not scope.whole_domains
    assert not ah.vreq_spec("F8")["interpretable"] and ah.vreq_spec("F8")["reason"] == "remove_fk names the referenced table crew.person but no foreign key points at it"


def test_a_model_wide_foreign_key_change_without_columns_stays_interpretable():
    spec = ah._normalize_vreq_spec(vs.spec("F7", "remove_fk", [], breadth="model"), ah._vreq_spec_index(_tiny()))
    assert spec["interpretable"], spec["reason"]
    spec = ah._normalize_vreq_spec(vs.spec("F6", "retype_column", [], breadth="model"), ah._vreq_spec_index(_tiny()))
    assert not spec["interpretable"] and spec["reason"] == "retype_column names no type"


def test_a_metric_view_count_requirement_lets_its_batch_change_the_metric_view_count():
    vs.register(ah, {"model": {"domains": []}}, vs.spec("M5", "other", ["media"], kind="count_target", count={"entity": "metric_views", "op": "at_least", "value": 12}),
                vs.spec("M6", "set_fields", ["crew.member"], fields=[vs.field("products", "description")]))
    assert ah._vov_spec_permits(["M5"])["metric_views"] is True
    assert ah._vov_spec_permits(["M6"])["metric_views"] is False


def test_a_column_clear_is_scored_on_the_named_column_only():
    base = _tiny()
    for a in _table(base, "crew", "member")["attributes"]:
        a["description"] = f"what {a['name']} holds"
    vs.register(ah, base, vs.spec("X5", "clear_fields", ["crew.member.full_name"], fields=[vs.field("attributes", "description")]))
    vreq = ah.RawVREQ(vreq_id="X5", intent="x", target="crew.member.full_name", source_quote="x", source_chunk_id="c1")
    fence = ah._vibe_scope_start_requested([vreq], copy.deepcopy(base), LOG, copy.deepcopy(base))
    final = copy.deepcopy(base)
    _table(final, "crew", "member")["attributes"].append({"name": "badge_code", "type": "STRING", "description": "the badge"})
    next(a for a in _table(final, "crew", "member")["attributes"] if a["name"] == "full_name")["description"] = ""
    d, p, a, _mv = ah.model_to_widgets_flat(final, quiet=True)
    verdict = ah._vibe_scope_open_field_verdict(SimpleNamespace(id="X5", scope_targets=["crew.member.full_name"]), d, p, a, LOG)
    assert verdict is not None and verdict["status"] == "fulfilled" and "1/1" in verdict["evidence"], verdict
    ah.set_vibe_scope_runtime(None)


def test_a_column_comment_never_starts_with_a_dangling_period_when_the_description_is_blank():
    assert ah._column_comment("", "^[0-9]{2}$") == "Valid values are `^[0-9]{2}$`"
    assert ah._column_comment("The employer number", "^[0-9]{2}$") == "The employer number. Valid values are `^[0-9]{2}$`"
    assert ah._column_comment("The employer's number", "") == ah.replace_single_quote("The employer's number")



def test_a_count_target_read_as_a_check_still_opens_its_domain_and_a_no_op_requirement_is_never_scope_rejected():
    model = _tiny()
    vs.register(ah, model, vs.spec("Q6", "check_only", ["crew"], kind="count_target", count={"entity": "metric_views", "op": "at_least", "value": 3}),
                vs.spec("Q7", "rename_product", ["ops.member"], new_name="ops_member"), vs.spec("Q8", "preserve", ["crew.member"]))
    vreq = lambda vid, target: ah.RawVREQ(vreq_id=vid, intent="x", target=target, source_quote="x", source_chunk_id="c1")
    scope, wide = ah._vibe_scope_requested_spec([vreq("Q6", "crew")], model)
    assert "crew" in scope.whole_domains and wide == []
    ah.set_vibe_scope_runtime(None)
    fence = ah._vibe_scope_start_requested([vreq("Q7", "ops.member"), vreq("Q8", "crew.member")], copy.deepcopy(model), LOG, copy.deepcopy(model))
    assert fence.is_frozen_product("crew", "member")
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, [vreq("Q7", "ops.member"), vreq("Q8", "crew.member")], model, LOG)
    assert [v.vreq_id for v in kept] == ["Q7", "Q8"] and rejected == [] and outcomes == []
    ah.set_vibe_scope_runtime(None)


@pytest.mark.parametrize("logical,physical", [("int", "BIGINT"), ("SMALLINT", "INT"), ("decimal(3,1)", "DECIMAL(3,1)"), ("", "STRING"),
                                              ("varchar(20)", "STRING"), ("timestamp_ntz", "TIMESTAMP"), ("unknown_type", "STRING")])
def test_the_physical_type_name_map_needs_no_pyspark(logical, physical, monkeypatch):
    for name in ("StringType", "LongType", "IntegerType", "BooleanType", "DoubleType", "FloatType", "DateType", "TimestampType", "DecimalType"):
        monkeypatch.delitem(ah.__dict__, name, raising=False)
    assert ah.map_data_type(logical) == physical


def test_metric_view_counts_are_counted_per_owner_domain_when_the_views_are_known():
    vs.register(ah, {"model": {"domains": [{"name": n, "products": []} for n in ("a", "b", "c")]}},
                vs.spec("N4", "other", ["a"], kind="count_target", count={"entity": "metric_views", "op": "at_least", "value": 2}),
                vs.spec("N5", "other", [], kind="count_target", count={"entity": "metric_views_per_domain", "op": "at_least", "value": 1}))
    d, p, a = _count_rows()
    mvs = [{"view_name": "x", "owner_domain": "a"}, {"view_name": "y", "owner_domain": "b"}]
    assert ah._verify_from_spec(ah.vreq_spec("N4"), d, p, a, metric_views=mvs)["status"] == "failed"
    assert ah._verify_from_spec(ah.vreq_spec("N4"), d, p, a, metric_views=mvs + [{"view_name": "z", "owner_domain": "a"}])["status"] == "fulfilled"
    assert ah._verify_from_spec(ah.vreq_spec("N5"), d, p, a, metric_views=mvs)["status"] == "partial"
    assert ah._verify_from_spec(ah.vreq_spec("N5"), d, p, a) is None, "an unknown view list is never counted as zero views"
