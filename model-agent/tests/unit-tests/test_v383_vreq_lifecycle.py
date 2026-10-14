"""v3.8.3 behavioral tests for the SIX generic VREQ-lifecycle fixes (microscopic vibe audit 2026-06-18).

Each fix is industry-agnostic; tests assert the OBSERVABLE state change (not a log line). The gov_transport
vibe (backtick directives, the 72-row CDE glossary table, the 9-row subdomain roster, the 3 mandated metric
views, the PSE merge-first directive) is read by the LLM requirement classifier: each test registers the specs
it returns for that vibe and drives the live helpers of the production notebook.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

CFG = {"MODEL_CONVENTIONS": {"tag_prefix": "gov_transport_", "tag_suffix": ""}}
GLOSSARY_TERMS = ["Organizational Unit", "Position", "Vacancy Status"]


def _tag_spec(vid, targets, level, tags):
    return dict(vs.spec(vid, "set_fields", targets, breadth="set", fields=[vs.field(level, "tags")]), tags=tags)


METRIC_VIEWS = vs.spec("VREQ-001", "other", [], kind="count_target", count={"entity": "metric_views", "op": "exactly", "value": 3},
                       metric_views=["Vacancy Rate", "Retirement Eligibility", "Total Positions"])
HR_SOURCE_ATTRIBUTE = _tag_spec("VREQ-002", ["hr"], "attributes", [{"key": "gov_transport_source_attribute", "value": "<original_column>"}])
GLOSSARY = dict(_tag_spec("VREQ-003", ["hr"], "attributes", [{"key": "gov_transport_business_glossary_term", "value": "<Business Data Element>"}]),
                allowed_values=[{"level": "attributes", "field": "business_glossary_term", "values": GLOSSARY_TERMS},
                                {"level": "attributes", "field": "tags", "key": "gov_transport_business_glossary_term", "values": GLOSSARY_TERMS}])
HR_SUBDOMAINS = dict(vs.spec("VREQ-004", "set_fields", ["hr"], breadth="set", fields=[vs.field("products", "subdomain")]),
                     allowed_values=[{"level": "products", "field": "subdomain",
                                      "values": ["Employee Records", "Compensation & Benefits", "Talent Acquisition"]}])
PSE_MERGE_FIRST = dict(vs.spec("VREQ-005", "other", ["project"], breadth="set"), policy="merge_into_existing")
HR_SOURCE_TABLE = _tag_spec("VREQ-006", ["hr"], "products", [{"key": "gov_transport_source_table", "value": "<orig>"}])
PSE_ORIGINAL_TABLE = _tag_spec("VREQ-007", ["project"], "products", [{"key": "original_table_name", "value": "<orig>"}])
VIBE_SPECS = (METRIC_VIEWS, HR_SOURCE_ATTRIBUTE, GLOSSARY, HR_SUBDOMAINS, PSE_MERGE_FIRST, HR_SOURCE_TABLE, PSE_ORIGINAL_TABLE)


def _register(*specs):
    vs.register(ah, {"model": {"domains": []}}, *specs)


def _register_vibe(without=None):
    _register(*[s for s in VIBE_SPECS if s is not without])


# ---------------------------------------------------------------- CLASS A ----
def test_A_metric_view_product_removed_not_fk_target():
    _register_vibe()
    doms = [{"name": "hr", "products": [{"name": "vacancy_rate"}, {"name": "total_positions"}, {"name": "employee"}]}]
    prods = [{"domain": "hr", "name": "vacancy_rate", "description": "Metric view (KPI-1): vacancy rate"},
             {"domain": "hr", "name": "total_positions", "description": "headcount of positions by unit"},
             {"domain": "hr", "name": "employee", "description": "core HR table"}]
    attrs = [{"domain": "hr", "product": "vacancy_rate", "attribute": "x"},
             {"domain": "hr", "product": "total_positions", "attribute": "z"},
             {"domain": "hr", "product": "employee", "attribute": "y"}]
    removed = ah._v383_remove_metric_view_products(doms, prods, attrs, {}, CFG, None)
    assert removed == ["vacancy_rate", "total_positions"], removed
    assert [p["name"] for p in prods] == ["employee"]
    assert [a["product"] for a in attrs] == ["employee"]  # orphan attrs dropped
    assert doms[0]["products"] == [{"name": "employee"}]   # domain product list pruned


def test_A_fk_target_metric_view_is_kept_safe():
    _register_vibe()
    # a product that LOOKS like an MV but is an FK target must NOT be removed (FK-safe)
    doms = [{"name": "hr", "products": [{"name": "vacancy_rate"}]}]
    prods = [{"domain": "hr", "name": "vacancy_rate", "description": "Metric view (KPI-1)"}]
    attrs = [{"domain": "hr", "product": "other", "attribute": "vr_id", "foreign_key_to": "hr.vacancy_rate.id"}]
    removed = ah._v383_remove_metric_view_products(doms, prods, attrs, {}, CFG, None)
    assert removed == [], removed
    assert [p["name"] for p in prods] == ["vacancy_rate"]


# ---------------------------------------------------------------- CLASS B ----
def test_B_per_attribute_provenance_resolved():
    _register_vibe()
    prods = [{"domain": "hr", "name": "employee", "tags": "gov_transport_source_table=emp_actions"},
             {"domain": "hr", "name": "job_grade", "tags": ""},
             {"domain": "project", "name": "route", "tags": "original_table_name=pse_route"}]
    attrs = [{"domain": "hr", "product": "employee", "attribute": "hire_date", "column_name": "hire_date", "tags": ""},
             {"domain": "hr", "product": "job_grade", "attribute": "grade_code", "column_name": "grade_code", "tags": ""},
             {"domain": "project", "product": "route", "attribute": "route_id", "column_name": "route_id", "tags": ""}]
    n = ah._v383_apply_per_attribute_value_tags(attrs, prods, CFG, None)
    assert n == 1, n
    assert "gov_transport_source_attribute=hire_date" in attrs[0]["tags"], attrs[0]["tags"]
    # the non-source-derived product's attribute is untouched (no blanket stamping)
    assert "source_attribute" not in (attrs[1]["tags"] or ""), attrs[1]["tags"]
    assert "source_attribute" not in (attrs[2]["tags"] or ""), attrs[2]["tags"]


# ---------------------------------------------------------------- CLASS C ----
def test_C_fabricated_glossary_purged_real_kept():
    _register_vibe()
    attrs = [{"domain": "hr", "product": "e", "attribute": "a", "business_glossary_term": "Position"},
             {"domain": "hr", "product": "e", "attribute": "b", "business_glossary_term": "Made Up Zzqq Nonsense"},
             {"domain": "hr", "product": "e", "attribute": "c", "tags": "gov_transport_business_glossary_term=Garbage Xyzzy"}]
    purged = ah._v383_purge_fabricated_lookup_tags(attrs, CFG, None)
    assert purged == 2, purged
    assert attrs[0]["business_glossary_term"] == "Position"   # real lexicon match survives
    assert attrs[1]["business_glossary_term"] == ""           # zero-overlap fabrication purged
    assert "glossary_term" not in attrs[2]["tags"]            # fabricated tag-string value purged


def test_C_noop_when_no_lookup_directive():
    _register_vibe(without=GLOSSARY)
    attrs = [{"domain": "hr", "product": "e", "attribute": "a", "business_glossary_term": "Anything"}]
    assert ah._v383_purge_fabricated_lookup_tags(attrs, CFG, None) == 0
    assert attrs[0]["business_glossary_term"] == "Anything"


# ---------------------------------------------------------------- CLASS D ----
def test_D_closed_roster_relabels_invented_label():
    _register_vibe()
    prods = [{"domain": "hr", "name": "benefit_plan", "subdomain": "made_up_label", "description": "compensation benefits"},
             {"domain": "hr", "name": "emp", "subdomain": "Employee Records", "description": ""}]
    n = ah._v383_enforce_closed_label_roster(prods, CFG, None)
    assert n == 1, n
    assert prods[0]["subdomain"] == "compensation_benefits"   # forced onto nearest roster member
    assert prods[1]["subdomain"] == "Employee Records"        # already a member -> untouched


def test_D_noop_for_open_roster():
    _register_vibe(without=HR_SUBDOMAINS)
    prods = [{"domain": "hr", "name": "x", "subdomain": "anything", "description": "z"}]
    assert ah._v383_enforce_closed_label_roster(prods, CFG, None) == 0
    assert prods[0]["subdomain"] == "anything"


# ---------------------------------------------------------------- CLASS E ----
def test_E_merge_first_flags_overlapping_source_clone():
    _register_vibe()
    prods = [{"domain": "project", "name": "dsctrcategory", "tags": "original_table_name=dsctrcategory", "description": "decision tree category"},
             {"domain": "project", "name": "category", "tags": "", "description": "project category lookup"}]
    wv = {}
    flags = ah._v383_flag_merge_first_candidates([], prods, [], wv, CFG, None)
    assert len(flags) == 1, flags
    assert len(wv["_unfulfilled_for_next_vibe"]) == 1


def test_E_noop_without_merge_directive():
    _register_vibe(without=PSE_MERGE_FIRST)
    prods = [{"domain": "project", "name": "dsctrcategory", "tags": "original_table_name=x", "description": "category"},
             {"domain": "project", "name": "category", "tags": "", "description": "category"}]
    assert ah._v383_flag_merge_first_candidates([], prods, [], {}, CFG, None) == []


# ---------------------------------------------------------------- CLASS F ----
def test_F_literal_tag_name_outranks_prefix():
    _register_vibe()
    prods = [{"domain": "project", "name": "route", "tags": "gov_transport_original_table_name=pse_route,foo=bar"}]
    n = ah._v383_enforce_tag_name_precedence(prods, [], CFG, None)
    assert n == 1, n
    assert "original_table_name=pse_route" in prods[0]["tags"]
    assert "gov_transport_original_table_name" not in prods[0]["tags"]  # prefixed variant rewritten to literal
    assert "foo=bar" in prods[0]["tags"]                        # unrelated tag preserved


def test_F_prefixed_only_keys_untouched():
    _register_vibe()
    # gov_transport_source_table is given WITH prefix in the vibe -> not a literal-unprefixed target
    prods = [{"domain": "hr", "name": "employee", "tags": "gov_transport_source_table=emp_actions"}]
    ah._v383_enforce_tag_name_precedence(prods, [], CFG, None)
    assert prods[0]["tags"] == "gov_transport_source_table=emp_actions"
