"""v5.1.4 sizing unit scope: a per-domain or per-product count never becomes a model total.

Live run 99248567832927: "Keep the model small: about 4 products per domain." with 4 domains
merged max_total_products=4 / min_total_products=4. Behavioral tests drive the production code
through agent_helpers and fail on 56ce1eb (CLAUDE.md 8.10).
"""
import json
import logging
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

LIVE_VIBE = "Keep the model small: about 4 products per domain."
LIVE_DOMAINS = ["customer", "order", "product", "inventory"]
LIVE_COUNT = {"entity": "products_per_domain", "op": "about", "value": 4}
ALIAS = "sizing-unit-scope-literal FIRED"
TOTAL_KEYS = ("max_total_products", "min_total_products")
PER_DOMAIN_KEYS = ("max_products_per_domain", "min_products_per_domain")
NULL_SD = {
    "max_domains": None, "min_domains": None, "max_total_products": None, "min_total_products": None,
    "max_products_per_domain": None, "min_products_per_domain": None, "single_domain_mode": False,
    "max_metric_views": None, "min_metric_views": None, "explicit_metric_views": [],
    "explicit_count_statements": [],
}
NULL_RECOVERY = {"domains_exact": None, "products_exact": None, "products_per_domain_exact": None,
                 "metric_views_exact": None, "metric_view_names": []}


class _Records(logging.Handler):
    def __init__(self):
        super().__init__()
        self.lines = []

    def emit(self, record):
        self.lines.append(record.getMessage())


def _logger(name):
    log = logging.getLogger(name)
    log.handlers = []
    log.propagate = False
    log.setLevel(logging.INFO)
    rec = _Records()
    log.addHandler(rec)
    return log, rec


class _StubLLM:
    def __init__(self, vibe, parse_sd, recovery, counts=()):
        self.vibe = vibe
        self.parse_sd = parse_sd
        self.recovery = recovery
        self.counts = list(counts)

    def _call_ai_query(self, prompt_name=None, prompt=None, **_kw):
        if prompt_name == "VIBE_PARSE_PROMPT":
            return json.dumps({
                "requirements": [{
                    "original_text": self.vibe, "intent": f"sizing {i}", "scope": "model", "scope_targets": ["*"],
                    "mode": "holistic", "priority": "critical", "constraint_type": "hard",
                    "verification_strategy": "llm_verify"} for i in range(max(1, len(self.counts)))],
                "sizing_directives": self.parse_sd,
                "model_conventions": {k: "" for k in ("tag_prefix", "tag_suffix", "schema_prefix",
                                                       "schema_suffix", "data_asset_naming_convention",
                                                       "cataloging_style")},
            })
        if prompt_name == "VREQ_SPEC_PROMPT":
            return json.dumps(vs.reply(prompt, self._count_spec))
        if prompt_name == "SIZING_DIRECTIVE_RECOVERY_PROMPT":
            return json.dumps(self.recovery)
        return "{}"

    def _count_spec(self, item):
        index = int(item["intent"].rsplit(" ", 1)[1])
        if index >= len(self.counts):
            return vs.spec(item["id"], "other", [], kind="quality_goal")
        return vs.spec(item["id"], "other", [], kind="count_target", count=self.counts[index])


def _parse(vibe, llm_sd=None, recovery=None, counts=()):
    log, rec = _logger("test_v514_sizing_parse")
    widgets = {"logger": log, "config": {}, "vibe_modelling_instructions": vibe,
               "operation": "new base model",
               "ai_agent": _StubLLM(vibe, dict(NULL_SD, **(llm_sd or {})), dict(NULL_RECOVERY, **(recovery or {})), counts)}
    ah.VibeOrchestrator(widgets).parse()
    return widgets["sizing_directives"], rec.lines


def _register_counts(*counts):
    vs.register(ah, {"model": {"domains": []}},
                *[vs.spec(f"C{i}", "other", [], kind="count_target", count=c) for i, c in enumerate(counts, 1)])


def _directives(*counts):
    _register_counts(*counts)
    return ah._sizing_directives_from_readings(ah._vreq_spec_sizing_readings())


@pytest.fixture(autouse=True)
def _isolate_sizing_runtime():
    saved = dict(ah._USER_SIZING_BOUNDS_RUNTIME)
    ah._USER_SIZING_BOUNDS_RUNTIME.clear()
    yield
    ah._USER_SIZING_BOUNDS_RUNTIME.clear()
    ah._USER_SIZING_BOUNDS_RUNTIME.update(saved)


# ---------------------------------------------------------------- the live vibe, end to end

def test_live_vibe_with_a_correct_llm_parse_has_no_total_cap():
    sd, _ = _parse(LIVE_VIBE, {"max_products_per_domain": 4, "min_products_per_domain": 4,
                               "explicit_count_statements": [LIVE_VIBE]},
                   {"products_per_domain_exact": 4}, counts=[LIVE_COUNT])
    assert [sd.get(k) for k in TOTAL_KEYS] == [None, None], sd
    assert [sd.get(k) for k in PER_DOMAIN_KEYS] == [4, 4], sd


def test_live_vibe_with_four_domains_derives_a_total_of_sixteen_not_four():
    sd, _ = _parse(LIVE_VIBE, {"max_products_per_domain": 4, "min_products_per_domain": 4},
                   {"products_per_domain_exact": 4}, counts=[LIVE_COUNT])
    published = ah.set_user_sizing_bounds_runtime(sd, domain_count=len(LIVE_DOMAINS))
    assert "max_total_products" not in published and "min_total_products" not in published, published
    ceiling, floor = ah._v490_user_product_bounds()
    assert (ceiling, floor) == (16, 16), (ceiling, floor)


def test_live_vibe_no_longer_licenses_shrinking_the_model_to_four_products():
    sd, _ = _parse(LIVE_VIBE, {"max_products_per_domain": 4, "min_products_per_domain": 4},
                   {"products_per_domain_exact": 4}, counts=[LIVE_COUNT])
    ah.set_user_sizing_bounds_runtime(sd, domain_count=len(LIVE_DOMAINS))
    assert ah.shrink_is_user_requested(20, 4) is False
    assert ah.shrink_is_user_requested(20, 16) is True
    products = [{"domain": d, "product": f"{d}_{i}"} for d in LIVE_DOMAINS for i in range(5)]
    pruned = ah._v358_enforce_product_ceiling_flat([{"domain": d} for d in LIVE_DOMAINS], products, [], sd,
                                                   v1_products=[])
    assert pruned == 0 and len(products) == 20, (pruned, len(products))


def test_live_vibe_overrules_an_llm_that_copies_the_per_domain_count_into_the_totals():
    sd, lines = _parse(LIVE_VIBE, {"max_total_products": 4, "min_total_products": 4,
                                   "max_products_per_domain": 4, "min_products_per_domain": 4}, counts=[LIVE_COUNT])
    assert [sd.get(k) for k in TOTAL_KEYS] == [None, None], sd
    assert [sd.get(k) for k in PER_DOMAIN_KEYS] == [4, 4], sd
    assert any(ALIAS in l and "disagree" in l and "max_total_products=4" in l for l in lines), lines


def test_focused_recovery_cannot_reintroduce_the_per_domain_count_as_a_total():
    sd, lines = _parse(LIVE_VIBE, {"max_products_per_domain": 4, "min_products_per_domain": 4},
                       {"products_exact": 4, "products_per_domain_exact": 4}, counts=[LIVE_COUNT])
    assert [sd.get(k) for k in TOTAL_KEYS] == [None, None], sd
    assert any(ALIAS in l and "focused recovery fill refused" in l for l in lines), lines


def test_live_vibe_logs_the_per_unit_reading_of_its_requirement_spec():
    _, lines = _parse(LIVE_VIBE, {"max_products_per_domain": 4, "min_products_per_domain": 4}, counts=[LIVE_COUNT])
    assert any(ALIAS in l and "never model totals" in l and "about 4 products_per_domain" in l for l in lines), lines
    _, lines = _parse("16 products in total", {"max_total_products": 16, "min_total_products": 16},
                      counts=[{"entity": "products", "op": "exactly", "value": 16}])
    assert not any(ALIAS in l for l in lines), lines


# ---------------------------------------------------------------- per-domain vs total fields

@pytest.mark.parametrize("count,per_domain", [
    ({"entity": "products_per_domain", "op": "about", "value": 4}, [4, 4]),
    ({"entity": "products_per_domain", "op": "exactly", "value": 4}, [4, 4]),
    ({"entity": "products_per_domain", "op": "at_most", "value": 4}, [4, None]),
    ({"entity": "products_per_domain", "op": "at_least", "value": 4}, [None, 4]),
    ({"entity": "products_per_domain", "op": "between", "value": 7, "low": 5}, [7, 5]),
])
def test_a_per_domain_count_spec_sets_only_per_domain_bounds(count, per_domain):
    sd = _directives(count)
    assert [sd[k] for k in TOTAL_KEYS] == [None, None], (count, sd)
    assert [sd[k] for k in PER_DOMAIN_KEYS] == per_domain, (count, sd)


@pytest.mark.parametrize("count,totals", [
    ({"entity": "products", "op": "exactly", "value": 16}, [16, 16]),
    ({"entity": "products", "op": "about", "value": 30}, [30, 30]),
    ({"entity": "products", "op": "at_most", "value": 20}, [20, None]),
    ({"entity": "products", "op": "at_least", "value": 20}, [None, 20]),
])
def test_a_total_count_spec_sets_only_total_bounds(count, totals):
    sd = _directives(count)
    assert [sd[k] for k in TOTAL_KEYS] == totals, (count, sd)
    assert [sd[k] for k in PER_DOMAIN_KEYS] == [None, None], (count, sd)


def test_per_domain_and_total_count_specs_fill_their_own_fields():
    sd = _directives(LIVE_COUNT, {"entity": "products", "op": "exactly", "value": 16})
    assert [sd[k] for k in TOTAL_KEYS] == [16, 16], sd
    assert [sd[k] for k in PER_DOMAIN_KEYS] == [4, 4], sd


def test_a_count_per_a_unit_the_spec_cannot_name_is_no_sizing_reading():
    sd = _directives({"entity": "domains_per_division", "op": "about", "value": 4})
    assert not ah.vreq_spec("C1")["interpretable"] and ah._vreq_spec_sizing_readings() == []
    assert {k: v for k, v in sd.items() if v not in (None, False, [])} == {}, sd


def test_llm_that_reads_a_total_as_per_domain_is_overruled():
    sd, lines = _parse("16 products in total", {"max_products_per_domain": 16, "min_products_per_domain": 16},
                       counts=[{"entity": "products", "op": "exactly", "value": 16}])
    assert [sd.get(k) for k in PER_DOMAIN_KEYS] == [None, None], sd
    assert [sd.get(k) for k in TOTAL_KEYS] == [16, 16], sd
    assert any(ALIAS in l and "max_products_per_domain=16" in l for l in lines), lines


def test_an_explicit_total_still_caps_through_the_merge():
    sd, _ = _parse("Keep it to at most 20 tables in total.", {"max_total_products": 20})
    assert sd.get("max_total_products") == 20, sd
    ah.set_user_sizing_bounds_runtime(sd, domain_count=4)
    assert ah._v490_user_product_bounds()[0] == 20


@pytest.mark.parametrize("counts,expected", [
    ([{"entity": "domains", "op": "exactly", "value": 3}, {"entity": "products", "op": "about", "value": 18}],
     {"max_domains": 3, "min_domains": 3, "max_total_products": 18, "min_total_products": 18}),
    ([{"entity": "domains", "op": "between", "value": 5, "low": 3}], {"max_domains": 5, "min_domains": 3}),
    ([{"entity": "domains", "op": "at_most", "value": 10}, {"entity": "domains", "op": "at_least", "value": 2}],
     {"max_domains": 10, "min_domains": 2}),
    ([{"entity": "domains", "op": "exactly", "value": 1}], {"max_domains": 1, "min_domains": 1, "single_domain_mode": True}),
])
def test_domain_and_total_count_specs_keep_their_readings(counts, expected):
    sd = _directives(*counts)
    got = {k: v for k, v in sd.items() if k != "explicit_count_statements" and v not in (None, False)}
    assert got == expected, (counts, sd)


# ---------------------------------------------------------------- other sizing sites (§3e)

def test_domains_per_division_is_not_a_domain_total():
    sd, _ = _parse("about 4 domains per division", {"max_domains": 4, "min_domains": 4},
                   counts=[{"entity": "domains_per_division", "op": "about", "value": 4}])
    assert sd.get("max_domains") is None and sd.get("min_domains") is None, sd


def test_one_requirement_per_count_keeps_each_count_on_its_own_unit():
    sd, lines = _parse("each domain should have about 4 tables and 30 columns per table with roughly 12 metric views",
                       {"max_total_products": 4, "max_products_per_domain": 4},
                       counts=[LIVE_COUNT, {"entity": "attributes_per_product", "op": "about", "value": 30},
                               {"entity": "metric_views", "op": "about", "value": 12}])
    assert [sd.get(k) for k in TOTAL_KEYS] == [None, None], sd
    assert [sd.get(k) for k in PER_DOMAIN_KEYS] == [4, 4], sd
    assert any(ALIAS in l and "max_total_products=4" in l for l in lines), lines


def test_per_domain_metric_view_count_is_not_a_model_total():
    sd, lines = _parse("Build 2 metric views per domain.", {"max_metric_views": 2, "min_metric_views": 2},
                       counts=[{"entity": "metric_views_per_domain", "op": "exactly", "value": 2}])
    assert sd.get("max_metric_views") is None and sd.get("min_metric_views") is None, sd
    assert any(ALIAS in l and "max_metric_views=2" in l for l in lines), lines


def test_next_vibes_mv_directive_reads_only_an_interpreted_metric_view_total():
    _register_counts({"entity": "metric_views_per_domain", "op": "exactly", "value": 2})
    assert ah._vibe_exact_metric_view_directive({}) == (None, [])
    ah.vov_ledger_reset()
    vs.register(ah, {"model": {"domains": []}}, vs.spec("C1", "other", [], kind="count_target", metric_views=["A", "B", "C"],
                                                        count={"entity": "metric_views", "op": "exactly", "value": 3}))
    assert ah._vibe_exact_metric_view_directive({}) == (3, ["A", "B", "C"])


def _model(n_domains, n_mvs):
    return {"model": {
        "domains": [{"name": f"d{i}", "products": [{"name": f"p{i}", "attributes": []}]} for i in range(n_domains)],
        "metric_views": [{"name": f"mv{i}"} for i in range(n_mvs)],
    }}


def test_completeness_requeue_multiplies_a_per_domain_mv_count_by_the_domain_count():
    log, rec = _logger("test_v514_sizing_requeue")
    _register_counts({"entity": "metric_views_per_domain", "op": "at_least", "value": 2})
    widgets = {}
    added = ah._v320_vibe_completeness_requeue(_model(3, 2), widgets, log)
    assert added == 1, rec.lines
    req = widgets["_unfulfilled_for_next_vibe"][0]
    assert req["id"] == "COMPLETENESS-MV-COUNT" and "want=6" in req["evidence"], req


def test_completeness_requeue_still_reads_a_model_total():
    _register_counts({"entity": "metric_views", "op": "exactly", "value": 4})
    widgets = {}
    added = ah._v320_vibe_completeness_requeue(_model(3, 2), widgets, logging.getLogger("x"))
    assert added == 1 and "want=4" in widgets["_unfulfilled_for_next_vibe"][0]["evidence"]
    assert ah._v320_vibe_completeness_requeue(_model(3, 4), {}, logging.getLogger("x")) == 0


def test_completeness_requeue_reads_an_at_least_metric_view_total():
    _register_counts({"entity": "metric_views", "op": "at_least", "value": 4})
    widgets = {}
    added = ah._v320_vibe_completeness_requeue(_model(3, 2), widgets, logging.getLogger("x"))
    assert added == 1 and "want=4" in widgets["_unfulfilled_for_next_vibe"][0]["evidence"]


# ---------------------------------------------------------------- tier gate derives the total

def test_tier_gate_derives_the_total_from_per_domain_times_domain_count():
    log, rec = _logger("test_v514_sizing_gate")
    sd = {"max_products_per_domain": 4, "min_products_per_domain": 4}
    ah.set_user_sizing_bounds_runtime(sd, domain_count=4)
    active, skipped = ah._tier_aware_architect_gate_keys(sd, logger=log, alias="arch-gate-tier-aware")
    assert active == () and len(skipped) == 4, (active, skipped)
    assert any(ALIAS in l and "= 16" in l for l in rec.lines), rec.lines


def test_tier_gate_does_not_treat_the_per_domain_number_as_the_total():
    sd = {"max_products_per_domain": 10, "min_products_per_domain": 10}
    ah.set_user_sizing_bounds_runtime(sd, domain_count=4)
    active, skipped = ah._tier_aware_architect_gate_keys(sd)
    assert skipped == () and len(active) == 4, (active, skipped)


# ---------------------------------------------------------------- attributes per product

def test_live_vibe_attribute_analog_gives_no_product_or_total_cap():
    vibe = "Keep the model small: about 30 attributes per product."
    sd, lines = _parse(vibe, {"max_total_products": 30, "min_total_products": 30,
                              "max_products_per_domain": 30},
                       counts=[{"entity": "attributes_per_product", "op": "about", "value": 30}])
    assert [sd.get(k) for k in TOTAL_KEYS + PER_DOMAIN_KEYS] == [None, None, None, None], sd
    assert any(ALIAS in l and "max_total_products=30" in l for l in lines), lines
    ah.set_user_sizing_bounds_runtime(sd, domain_count=4)
    assert ah._v490_user_product_bounds() == (None, None)


def test_attribute_readings_keep_per_product_and_total_apart():
    _register_counts({"entity": "attributes_per_product", "op": "about", "value": 30},
                     {"entity": "attributes", "op": "exactly", "value": 300})
    readings = ah._vreq_spec_sizing_readings()
    assert [(r["unit"], r["scope"], r["per"], r["n"]) for r in readings] == [("attribute", "per_unit", "product", 30),
                                                                             ("attribute", "total", "", 300)]
    sd = ah._sizing_directives_from_readings(readings)
    assert [sd[k] for k in TOTAL_KEYS + PER_DOMAIN_KEYS] == [None, None, None, None], sd


def _model_params(vibe, mvm_llm, domains=None, counts=()):
    _register_counts(*counts)
    log, rec = _logger("test_v514_sizing_params")
    params = {"industry_complexity_tier": "tier_3", "tier_justification": "t", "sizing_notes": "s",
              "user_sizing_override": True, "mvm_model": dict(mvm_llm), "ecm_model": dict(mvm_llm)}
    config = {"MODEL_SCOPE": "mvm", "PROMPT_KEYS": {},
              "PROMPT_VARIABLES": {"business_config": {"business": "b", "description": "d"}}}
    widgets = {"vibe_modelling_instructions": vibe, "_user_specified_domains": list(domains or [])}
    validator = type("_Validator", (), {"validate_model_generation_parameters": lambda *_a, **_k: (True, [])})()
    original = ah.smart_worker_loop
    ah.smart_worker_loop = lambda **_kw: (True, params, [])
    try:
        ah._determine_model_parameters(None, {}, config, widgets, log, validator, None)
    finally:
        ah.smart_worker_loop = original
    return config["PROMPT_VARIABLES"], rec.lines


_MVM_BASE = {"min_business_domains": 4, "max_business_domains": 4, "min_data_products_per_domain": 5,
             "max_data_products_per_domain": 10, "min_attributes_per_product": 10, "max_attributes_per_product": 40,
             "min_business_subdomains": 2, "max_business_subdomains": 3, "min_products_per_subdomain": 2,
             "product_attributes_dedupe_threshold": 45, "min_honesty_score_threshold": 50}


def test_model_params_rejects_an_attribute_total_copied_into_the_per_product_cap():
    pv, lines = _model_params("300 attributes in total", dict(_MVM_BASE, max_attributes_per_product=300),
                              LIVE_DOMAINS, counts=[{"entity": "attributes", "op": "exactly", "value": 300}])
    assert pv["max_attributes_per_product"] == 50, pv["max_attributes_per_product"]
    assert any(ALIAS in l and "max_attributes_per_product 300 -> 50" in l for l in lines), lines


def test_model_params_keeps_an_explicit_per_product_attribute_cap():
    pv, lines = _model_params("at most 30 attributes per product", dict(_MVM_BASE, max_attributes_per_product=30),
                              LIVE_DOMAINS, counts=[{"entity": "attributes_per_product", "op": "at_most", "value": 30}])
    assert pv["max_attributes_per_product"] == 30, pv["max_attributes_per_product"]
    assert not any(ALIAS in l for l in lines), lines


def test_model_params_divides_a_product_total_copied_into_the_per_domain_range():
    pv, lines = _model_params("16 products in total",
                              dict(_MVM_BASE, min_data_products_per_domain=16, max_data_products_per_domain=16),
                              LIVE_DOMAINS, counts=[{"entity": "products", "op": "exactly", "value": 16}])
    assert (pv["min_data_products_per_domain"], pv["max_data_products_per_domain"]) == (4, 4), pv
    assert any(ALIAS in l and "max_data_products_per_domain 16 -> 4" in l for l in lines), lines


def test_model_params_leaves_the_live_vibe_to_the_per_domain_clamp():
    pv, lines = _model_params(LIVE_VIBE, _MVM_BASE, LIVE_DOMAINS, counts=[LIVE_COUNT])
    assert not any(ALIAS in l for l in lines), lines
    assert pv["max_attributes_per_product"] == 40 and pv["max_business_domains"] == 4


# ---------------------------------------------------------------- prompts + wiring smoke

def test_prompts_tell_the_llm_to_keep_per_unit_and_total_apart():
    parse = ah.PROMPT_TEMPLATES["VIBE_PARSE_PROMPT"]
    recovery = ah.PROMPT_TEMPLATES["SIZING_DIRECTIVE_RECOVERY_PROMPT"]
    params = ah.PROMPT_TEMPLATES["MODEL_GENERATION_PARAMETER_PROMPT"]
    assert "A per-domain count is NEVER a total" in parse
    assert "products_exact and metric_views_exact are WHOLE-MODEL totals" in recovery
    assert "**Per-unit vs total:**" in params
    assert "about 4 products per domain" in parse.format(vibe_text="v")
    assert "WHOLE-MODEL totals" in recovery.format(vibe_text="v")


def test_every_site_carries_the_fired_alias():
    src = notebook_concat_source()
    assert src.count("[sizing-unit-scope-literal FIRED v5.3.3]") >= 2 and src.count("[sizing-unit-scope-literal FIRED v5.1.4]") >= 3
    assert "sizing_directives parsed by the LLM (VIBE_PARSE)" in src
