import ast
import json
import re
import sys
import textwrap
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


NB_PATH = Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"


def _src():
    nb = json.loads(NB_PATH.read_text())
    return "\n".join(
        "".join(c.get("source", []))
        for c in nb.get("cells", [])
        if c.get("cell_type") == "code"
    )


def _extract_quality_fn(src: str):
    m = re.search(
        r"(def _compute_deterministic_confidence_and_status\(\):[\s\S]+?return calculated_confidence, calculated_status)",
        src,
    )
    assert m, "quality function not found"
    fn_src = textwrap.dedent(m.group(1))
    ns = {}
    exec(fn_src, ns)
    return ns["_compute_deterministic_confidence_and_status"], ns


def test_v409_aliases_present():
    src = _src()
    assert "physical-adherence-authoritative" in src
    assert "quality-foundation-plus-delta" in src


def test_move_product_balanced_scope_is_allowed():
    diff = {
        "domains_added": [],
        "domains_removed": [],
        "products_added": [("workforce", "benefit_plan")],
        "products_removed": [("procurement", "benefit_plan")],
        "fks_removed": 0,
        "metric_views_delta": 0,
    }
    ah.vov_ledger_reset()
    vs.register(ah, {"model": {"domains": []}}, vs.spec("V1", "move_product", ["procurement.benefit_plan"], destination_domain="workforce"))
    ok, msg = ah.diff_within_requirement_scope(diff, ["V1"])
    assert ok is True, msg


def test_non_move_remove_still_rejected():
    diff = {
        "domains_added": [],
        "domains_removed": [],
        "products_added": [("workforce", "benefit_plan")],
        "products_removed": [("procurement", "benefit_plan")],
        "fks_removed": 0,
        "metric_views_delta": 0,
    }
    ah.vov_ledger_reset()
    vs.register(ah, {"model": {"domains": []}}, vs.spec("V1", "other", [], breadth="model"),
                vs.spec("V2", "move_product", ["procurement.benefit_plan"], destination_domain="finance"))
    ok, msg = ah.diff_within_requirement_scope(diff, ["V1"])
    assert ok is False and "table procurement.benefit_plan removed" in msg
    ok, msg = ah.diff_within_requirement_scope(diff, ["V2"])
    assert ok is True, msg
    ok, msg = ah.diff_within_requirement_scope(dict(diff, domains_added=["workforce"]), ["V2"])
    assert ok is False and "domain workforce added" in msg


def test_quality_is_foundation_plus_delta_not_min50():
    src = _src()
    fn, ns = _extract_quality_fn(src)

    # rich/sound model -> foundation 50 + delta near 50
    ns["severity_counts"] = {"error": 0, "warning": 0}
    ns["model_stats"] = {
        "domain_count": 10,
        "product_count": 200,
        "fk_count": 800,
        "unlinked_id_count": 0,
        "siloed_count": 0,
    }
    ns["all_issues"] = []
    ns["attributes_data"] = [{"tags": {"division": "operations"}}]
    ns["widgets_values"] = {"_ground_truth_scorecard": {"scored": 10, "pct": 100.0}}
    ns["config"] = {"PROMPT_VARIABLES": {"_next_vibe_metadata": {"confidence_score": 0, "issue_counts": {"warning": 0}}}}

    class _L:
        def info(self, *_):
            pass

    ns["logger"] = _L()
    ns["_LAST_VERIFIED_ADHERENCE"] = 1.0
    score, _ = fn()
    assert score >= 95, score

    # no tags -> lose foundation points (cannot stay near max)
    ns["attributes_data"] = [{}]
    score_no_tags, _ = fn()
    assert score_no_tags < score, (score_no_tags, score)


def test_quality_penalized_by_physical_adherence_gap():
    src = _src()
    fn, ns = _extract_quality_fn(src)
    ns["severity_counts"] = {"error": 0, "warning": 0}
    ns["model_stats"] = {
        "domain_count": 10,
        "product_count": 200,
        "fk_count": 800,
        "unlinked_id_count": 0,
        "siloed_count": 0,
    }
    ns["all_issues"] = []
    ns["attributes_data"] = [{"tags": {"division": "operations"}}]
    ns["config"] = {"PROMPT_VARIABLES": {"_next_vibe_metadata": {"confidence_score": 0, "issue_counts": {"warning": 0}}}}

    class _L:
        def info(self, *_):
            pass

    ns["logger"] = _L()
    ns["_LAST_VERIFIED_ADHERENCE"] = 1.0

    ns["widgets_values"] = {"_ground_truth_scorecard": {"scored": 10, "pct": 100.0}}
    score_100, _ = fn()
    ns["widgets_values"] = {"_ground_truth_scorecard": {"scored": 57, "pct": 66.7}}
    score_667, _ = fn()
    assert score_667 < score_100, (score_667, score_100)


def test_physical_adherence_authoritative_path_present():
    src = _src()
    assert "_gt_scored > 0" in src
    assert "_adh_source = 'physical_ground_truth'" in src
    assert "scorecard['adherence_source'] = _adh_source" in src
    assert "scorecard['physical_adherence_pct']" in src
