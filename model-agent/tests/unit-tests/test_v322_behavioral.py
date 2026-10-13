"""v3.2.2 behavioral tests.

Root-cause fixes for the gov_transport mvm_v2 ~37% adherence ceiling. The architectural gap:
"MISSED VIBES" directives in next_vibes were routed to flaky LLM synthesis, bypassing
deterministic handlers that read widget input (dead on VOV runs), and missing-target
priorities were permanently dropped.

Every test proves the NEW behavior AND that pre-patch behavior would have failed
(CLAUDE.md §8.3 anti-tautology, §8.10 behavioral-not-noop).

Fixes covered:
  (F1) vov-mvfloor-from-nextvibes   MV "exactly N" read from the next_vibes requirement's LLM spec, not just widget
  (F2) vov-prevalidate-requeue      missing-target priorities re-queued into LLM residual, not dropped
  (F3) vov-generative-budget-floor  generative batches start at 480s cap, not 240s base
"""
import ast
import json
import os
import re
import sys
import types
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

NB = os.path.join(os.path.dirname(__file__), "..", "..", "agent", "dbx_vibe_modelling_agent.ipynb")
NO_MODEL = {"model": {"domains": []}}


def _load_src():
    nb = json.load(open(NB))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


# --------------------------------------------------------------------------- #
# (F1) vov-mvfloor-from-nextvibes
# --------------------------------------------------------------------------- #
def _mv_count(vid, op, value, names=()):
    return vs.spec(vid, "other", kind="count_target", count={"entity": "metric_views", "op": op, "value": value}, metric_views=list(names))


def test_mv_count_read_from_the_requirement_spec_when_widget_silent():
    # VOV run: widget vibe_classification is EMPTY (the dead-code condition on gov_transport)
    widgets = {}
    assert ah._vibe_exact_metric_view_directive(widgets) == (None, [])
    vs.register(ah, NO_MODEL, dict(_mv_count("VREQ-0005", "exactly", 9), interpretable=False, reason="two readings"),
                vs.spec("VREQ-0006", "other", kind="count_target", count={"entity": "products", "op": "exactly", "value": 3}))
    assert ah._vibe_exact_metric_view_directive(widgets) == (None, [])
    vs.register(ah, NO_MODEL, _mv_count("VREQ-0007", "exactly", 3, ["Vacancy Rate", "Retirement Eligibility", "Total Positions and Active Employees"]))
    cnt, names = ah._vibe_exact_metric_view_directive(widgets)
    assert cnt == 3, f"expected 3 from the next_vibes requirement spec, got {cnt}"
    assert "Vacancy Rate" in names


def test_mv_count_widget_still_wins_when_present():
    widgets = {"vibe_classification": {"sizing_directives": {"max_metric_views": 5}}}
    # widget present => fallback must NOT be consulted (widget authority preserved)
    vs.register(ah, NO_MODEL, _mv_count("VREQ-0007", "exactly", 3))
    cnt, _ = ah._vibe_exact_metric_view_directive(widgets)
    assert cnt == 5


def test_mv_count_narrative_mention_does_not_trip():
    # a narrative line WITHOUT a constraint word must not be parsed as a directive
    nv = "In v1 the agent added 5 metric views across the operations domain."
    vs.register(ah, NO_MODEL, vs.spec("VREQ-0008", "other", kind="documentation", reason=nv), _mv_count("VREQ-0009", "about", 5))
    cnt, _ = ah._vibe_exact_metric_view_directive({})
    assert cnt is None, f"narrative mention must not fire, got {cnt}"


# --------------------------------------------------------------------------- #
# (F3) vov-generative-budget-floor
# --------------------------------------------------------------------------- #
def _load_generative_budget():
    return ah._vov_batch_is_generative, ah._vov_effective_handler_budget


class _FakeBatch:
    def __init__(self, batch_id, intent_summary="", data_payload=()):
        self.batch_id = batch_id
        self.intent_summary = intent_summary
        self.data_payload = data_payload


def test_generative_metric_view_batch_gets_cap_budget():
    is_gen, eff = _load_generative_budget()
    b = _FakeBatch("B0001", "Build Vacancy Rate metric view with calculation and dimensions")
    assert is_gen(b) is True
    # PRE-PATCH: every batch ran at the 240s base => generative ones timed out, bounced 2 iters
    # POST-PATCH: generative batch starts at the 480s cap
    assert eff(b, 240.0) == 480.0


def test_generative_base_model_batch_gets_cap_budget():
    is_gen, eff = _load_generative_budget()
    b = _FakeBatch("B0002", data_payload=({"intent": "Build the human resources base model", "target": "hr"},))
    assert is_gen(b) is True
    assert eff(b, 240.0) == 480.0


def test_surgical_batch_keeps_base_budget():
    is_gen, eff = _load_generative_budget()
    # surgical edits (add attribute / rename / tag) must NOT be inflated => no slowdown
    for txt in (
        "Add column project_data_value to project",
        "Rename product data_value to project_data_value",
        "Tag every column with source_attribute lineage",
    ):
        b = _FakeBatch("B0003", txt)
        assert is_gen(b) is False, f"surgical batch wrongly flagged generative: {txt!r}"
        assert eff(b, 240.0) == 240.0


def test_generative_budget_never_lowers_an_already_high_base():
    is_gen, eff = _load_generative_budget()
    b = _FakeBatch("B0004", "Construct the finance sub-model")
    # if the global escalation already raised the base above the cap, keep the higher value
    assert eff(b, 600.0) == 600.0


# --------------------------------------------------------------------------- #
# (F2) vov-prevalidate-requeue  (source-contract: the drop loop now re-queues)
# --------------------------------------------------------------------------- #
def test_prevalidate_requeues_into_residual_not_dropped():
    full = _load_src()
    # the zero-progress branch must append the would-be-dropped priority to _residual
    assert "_residual.append(_p)" in full
    assert "alias=vov-prevalidate-requeue" in full


def test_prevalidate_no_longer_emits_structural_unresolvable_drop():
    full = _load_src()
    # PRE-PATCH the drop loop emitted a structural_unresolvable VReqOutcome inline; that emission
    # must be gone from the prevalidate zero-progress branch (the LLM path now owns the real outcome).
    # Locate the prevalidate requeue block and assert no structural_unresolvable status within it.
    i = full.index("alias=vov-prevalidate-requeue")
    window = full[i - 600:i + 600]
    assert 'status="structural_unresolvable"' not in window


def test_agent_version_is_at_least_322():
    full = _load_src()
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([0-9.]+)"', full)
    assert m, "version constant not found"
    assert tuple(int(x) for x in m.group(1).split(".")) >= (3, 2, 2)
