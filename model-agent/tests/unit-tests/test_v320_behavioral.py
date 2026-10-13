"""v3.2.0 behavioral tests.

Covers two root-cause fixes proven against pre-patch behavior (CLAUDE.md §8.10):

(A) TIMEOUT — vov-global-call-cap / vov-lowprog-converge / vov-budget-sane /
    vov-batch-budget-wider. The 15h job kills were driven by raw LLM call VOLUME +
    round fragmentation, not a lock. These tests prove the module-level bridge-call
    counter caps/bumps/resets correctly and the budget literals were lowered.

(B) VREQ COMPLETENESS — vov-add-tag-wildcard / vov-completeness-requeue. A single
    bulk directive ("tag every column with source X") used to tag exactly ONE attr
    (exact-FQN match) and never re-queued the gap. These tests prove (1) wildcard
    add_tag matching tags ALL entities at the wildcarded level (and the OLD exact
    match would NOT — anti-tautology), and (2) the completeness verifier re-queues
    a coverage gap into _unfulfilled_for_next_vibe (the wired SelfFixer input) and
    does NOT re-queue when coverage is complete.
"""
import json
import logging
import os
import re

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

NB = os.path.join(os.path.dirname(__file__), "..", "..", "agent", "dbx_vibe_modelling_agent.ipynb")


def _load_src():
    nb = json.load(open(NB))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


def _load_call_cap_block():
    full = _load_src()
    i = full.index("import threading as _v320_threading")
    j = full.index("def run_vov_pipeline(")
    block = full[i:j]
    ns = {"re": re}
    exec(block, ns)  # single namespace so `global` + closures resolve module-level names
    return ns


# ---------------------------------------------------------------------------
# (A) TIMEOUT — global call cap
# ---------------------------------------------------------------------------

def test_call_cap_bump_reset_count():
    ns = _load_call_cap_block()
    ns["_v320_vov_reset_calls"]()
    assert ns["_v320_vov_calls"]() == 0
    for _ in range(5):
        ns["_v320_vov_bump_call"]()
    assert ns["_v320_vov_calls"]() == 5
    ns["_v320_vov_reset_calls"]()
    assert ns["_v320_vov_calls"]() == 0


def test_call_cap_constant_present_and_sane():
    ns = _load_call_cap_block()
    cap = ns["_VOV_BRIDGE_CALL_CAP"]
    # must be a real ceiling well below the 1894-call automotive runaway, > a healthy run
    assert isinstance(cap, int)
    assert 800 <= cap <= 1600


def test_budgets_lowered_in_notebook():
    src = _load_src()
    assert "vov-budget-sane" in src
    assert "vov-batch-budget-wider" in src
    assert "vov-lowprog-converge" in src
    # v3.2.1 SUPERSEDED: the v3.2.0 wider budget (64000) made per-batch sandbox mutate+verify
    # exceed the time budget on large models (gov_transport mvm_v2: 27 time_budget_exceeded VREQs), so it
    # was reverted to 48000 (alias=vov-batch-budget-narrower-revert). Assert the reverted literal.
    assert "budget=48000" in src
    # the old 660-min loop budget must be gone (lowered to 300)
    assert "_total_loop_budget_min = 660" not in src.replace(" ", "").replace("_total_loop_budget_min=660", "_total_loop_budget_min = 660")


# ---------------------------------------------------------------------------
# (B1) VREQ completeness — wildcard add_tag matching (mirror + anti-tautology)
# ---------------------------------------------------------------------------

def _wild_match(name, d, p, a):
    """Mirror of the v3.2.0 wildcard matcher embedded in apply_mutation_command."""
    segs = [s.strip().lower() for s in name.split(".")] if name.strip() else ["*"]
    while len(segs) < 3:
        segs.append("*")
    segs = segs[:3]
    return (segs[0] in ("*", d.lower())) and (segs[1] in ("*", p.lower())) and (segs[2] in ("*", a.lower()))


def _old_exact_match(name, d, p, a):
    """Pre-v3.2.0 exact-FQN match (the bug: bulk directive -> only 1 attr)."""
    return f"{d}.{p}.{a}".lower() == name.lower()


def test_wildcard_tags_all_attributes():
    attrs = [("hr", "employee", "name"), ("hr", "employee", "ssn"),
             ("project", "task", "due_date"), ("project", "task", "owner_id")]
    for pat in ("*", "*.*.*"):
        n = sum(1 for (d, p, a) in attrs if _wild_match(pat, d, p, a))
        assert n == 4, f"pattern {pat!r} should match all 4 attrs, matched {n}"


def test_wildcard_scoped_to_product_and_domain():
    attrs = [("hr", "employee", "name"), ("hr", "employee", "ssn"),
             ("project", "task", "due_date"), ("project", "task", "owner_id")]
    assert sum(1 for (d, p, a) in attrs if _wild_match("hr.employee.*", d, p, a)) == 2
    assert sum(1 for (d, p, a) in attrs if _wild_match("project.*.*", d, p, a)) == 2
    assert sum(1 for (d, p, a) in attrs if _wild_match("hr.employee.ssn", d, p, a)) == 1


def test_old_exact_match_would_tag_only_one():
    """Anti-tautology: prove the PRE-patch exact match tags only 1 (or 0) for a bulk pattern."""
    attrs = [("hr", "employee", "name"), ("hr", "employee", "ssn"),
             ("project", "task", "due_date")]
    assert sum(1 for (d, p, a) in attrs if _old_exact_match("*.*.*", d, p, a)) == 0
    assert sum(1 for (d, p, a) in attrs if _old_exact_match("hr.employee.ssn", d, p, a)) == 1


def test_add_tag_mutation_tags_every_attribute_the_wildcard_names():
    def _run(name):
        attrs = [{"domain": d, "product": p, "attribute": a, "tags": ""} for d, p, a in
                 [("hr", "employee", "name"), ("hr", "employee", "ssn"), ("project", "task", "due_date"), ("project", "task", "owner_id")]]
        ok, info = ah.apply_mutation_command({"action": "add_tag", "scope": "attribute", "name": name, "target_state": "source=x"},
                                             [], [], attrs, {}, logging.getLogger("t"))
        assert ok, info
        return info["applied"], sorted(f"{a['domain']}.{a['product']}.{a['attribute']}" for a in attrs if a["tags"] == "source=x")
    assert _run("*.*.*") == (4, ["hr.employee.name", "hr.employee.ssn", "project.task.due_date", "project.task.owner_id"])
    assert _run("hr.employee.*") == (2, ["hr.employee.name", "hr.employee.ssn"])
    assert _run("project.*.*") == (2, ["project.task.due_date", "project.task.owner_id"])
    assert _run("hr.employee.ssn") == (1, ["hr.employee.ssn"])
    assert _run("crm.contact.*") == (0, [])


# ---------------------------------------------------------------------------
# (B2) VREQ completeness — re-queue verifier
# ---------------------------------------------------------------------------

def _model_with_attr_tags(tagged_fraction):
    """Build a 4-attr model where `tagged_fraction` of attrs carry the source tag."""
    attrs = [
        {"attribute": "name", "tags": ""},
        {"attribute": "ssn", "tags": ""},
        {"attribute": "due_date", "tags": ""},
        {"attribute": "owner_id", "tags": ""},
    ]
    k = int(round(tagged_fraction * len(attrs)))
    for a in attrs[:k]:
        a["tags"] = "gov_transport_source_attribute=orig_col"
    return {"model": {"domains": [
        {"name": "hr", "products": [{"product": "employee", "attributes": attrs}]}
    ], "metric_views": []}}


def _register_every_column_tag():
    vs.register(ah, {"model": {"domains": []}}, dict(
        vs.spec("VREQ-001", "set_fields", [], breadth="model", fields=[vs.field("attributes", "tags")]),
        tags=[{"key": "source_attribute", "value": "<original column name>"}]))


def _register_mv_count(n):
    vs.register(ah, {"model": {"domains": []}},
                vs.spec("VREQ-002", "other", [], kind="count_target", count={"entity": "metric_views", "op": "exactly", "value": n}))


def test_requeue_fires_on_tag_gap():
    model = _model_with_attr_tags(0.25)  # only 1/4 attrs tagged
    assert ah._v320_vibe_completeness_requeue(model, {}, logging.getLogger("t")) == 0
    _register_every_column_tag()
    wv = {}
    added = ah._v320_vibe_completeness_requeue(model, wv, logging.getLogger("t"))
    assert added == 1
    reqs = wv.get("_unfulfilled_for_next_vibe", [])
    assert [r["id"] for r in reqs] == ["COMPLETENESS-TAG-source_attribute-column"]
    # evidence must enumerate the missing entities (the SelfFixer reads this)
    ev = reqs[0]["evidence"]
    assert ev.startswith("1/4 columns carry tag 'source_attribute'")
    assert "hr.employee.ssn" in ev and "hr.employee.name" not in ev


def test_requeue_silent_when_fully_covered():
    model = _model_with_attr_tags(1.0)  # all attrs tagged
    _register_every_column_tag()
    wv = {}
    added = ah._v320_vibe_completeness_requeue(model, wv, logging.getLogger("t"))
    assert added == 0
    assert not wv.get("_unfulfilled_for_next_vibe")


def test_requeue_mv_count_shortfall():
    model = {"model": {"domains": [], "metric_views": [{"name": "mv1"}]}}
    _register_mv_count(1)
    assert ah._v320_vibe_completeness_requeue(model, {}, logging.getLogger("t")) == 0
    _register_mv_count(5)
    wv = {}
    added = ah._v320_vibe_completeness_requeue(model, wv, logging.getLogger("t"))
    assert added == 1
    reqs = wv.get("_unfulfilled_for_next_vibe", [])
    assert [r["id"] for r in reqs] == ["COMPLETENESS-MV-COUNT"]
    assert reqs[0]["evidence"].startswith("have=1 want=5 shortfall=4; the model: 1/5")


def test_requeue_dedups_existing_ids():
    model = _model_with_attr_tags(0.25)
    _register_every_column_tag()
    pre = {"id": "COMPLETENESS-TAG-source_attribute-column", "text": "x", "evidence": "y", "attempts": 1}
    wv = {"_unfulfilled_for_next_vibe": [pre]}
    added = ah._v320_vibe_completeness_requeue(model, wv, logging.getLogger("t"))
    assert added == 0  # already queued, must not duplicate
    assert len(wv["_unfulfilled_for_next_vibe"]) == 1


# ---------------------------------------------------------------------------
# Version + wiring contracts
# ---------------------------------------------------------------------------

def test_version_is_320():
    src = _load_src()
    m = re.search(r'__AGENT_VERSION__ = "([0-9.]+)"', src)
    assert m is not None
    # v3.2.1+ supersedes: assert at-least 3.2.0 (forward bumps keep these fixes live)
    assert tuple(int(x) for x in m.group(1).split(".")) >= (3, 2, 0)
    assert all(len(seg) == 1 and seg.isdigit() for seg in m.group(1).split("."))


def test_completeness_wired_before_selffixer():
    src = _load_src()
    assert "_v320_vibe_completeness_requeue(_sf_model" in src
    assert "alias=vov-completeness-requeue" in src
