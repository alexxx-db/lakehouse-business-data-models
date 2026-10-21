"""Model-agent naming rules (DOM-RUL-*): the shared fixture is the golden list of issues per tree."""
import json
from pathlib import Path

import pytest

from vibe_modeling.backend.taxonomy.compile import compile_taxonomy, domain_schema
from vibe_modeling.backend.taxonomy.models import TaxonomyCompileIn, TaxonomyDomain, TaxonomyTree
from vibe_modeling.backend.taxonomy.rules import (
    APPLIED_RULES,
    FORBIDDEN_DOMAINS,
    MIN_DOMAINS,
    VAGUE_DOMAINS,
    rule_issues,
)

FIX = Path(__file__).parents[1] / "fixtures"
SCHEMA_CASES = json.loads((FIX / "taxonomy_schema_fixture.json").read_text())
RULE_CASES = json.loads((FIX / "taxonomy_rules_fixture.json").read_text())


@pytest.mark.parametrize("name,override,expected", SCHEMA_CASES)
def test_domain_schema_matches_shared_fixture(name, override, expected):
    assert domain_schema(TaxonomyDomain(name=name, schema_name=override)) == expected


@pytest.mark.parametrize("case", RULE_CASES, ids=[c["label"] for c in RULE_CASES])
def test_rule_issues_match_shared_fixture(case):
    tree = TaxonomyTree.model_validate({"domains": case["domains"]})
    key = lambda e: (e["message"], e["rule_id"])  # noqa: E731
    assert sorted((i.model_dump() for i in rule_issues(tree)), key=key) == sorted(case["expected"], key=key)


@pytest.mark.parametrize("case", RULE_CASES, ids=[c["label"] for c in RULE_CASES])
def test_compile_surfaces_rule_issues(case):
    tree = TaxonomyTree.model_validate({"domains": case["domains"]})
    out = compile_taxonomy(TaxonomyCompileIn(tree=tree))
    have = {(i.severity, i.message, i.rule_id, tuple(i.domains)) for i in out.issues}
    assert {(e["severity"], e["message"], e["rule_id"], tuple(e["domains"])) for e in case["expected"]} <= have


def _tree(*domains: TaxonomyDomain) -> TaxonomyTree:
    return TaxonomyTree(domains=list(domains))


def _dom(name: str, *subs: str, schema: str = "") -> TaxonomyDomain:
    return TaxonomyDomain.model_validate(
        {"name": name, "schema_name": schema, "subdomains": [{"name": s, "categories": ["Thing"]} for s in subs]}
    )


_OK = (_dom("Customer", "Party Master", "Service Location"), _dom("Billing", "Meter Reading", "Bill Production"))


def test_two_word_count_splits_on_whitespace_like_the_agent():
    issues = rule_issues(_tree(*_OK, _dom("Asset", "Low-Income Assistance", "Work_Order")))
    flagged = [i.message for i in issues if i.rule_id == "DOM-RUL-021"]
    assert flagged == ["Sub-domain 'Work_Order' in 'Asset' should be exactly two words (DOM-RUL-021)."]


def test_shared_word_check_splits_on_whitespace_like_the_agent():
    issues = rule_issues(_tree(*_OK, _dom("Asset", "Low-Income Assistance", "Income Support")))
    assert not [i for i in issues if i.rule_id == "DOM-RUL-024"]
    issues = rule_issues(_tree(*_OK, _dom("Asset", "Income Assistance", "income Support")))
    assert [i.rule_id for i in issues] == ["DOM-RUL-024"]


def test_uncategorized_is_a_placeholder():
    issues = rule_issues(_tree(*_OK, _dom("Asset", "Uncategorized", "Crew Dispatch")))
    assert any(i.rule_id == "DOM-RUL-027" and "'Uncategorized'" in i.message for i in issues)


@pytest.mark.parametrize("schema", ["audittrail", "batchcontrol"])
def test_schema_forms_of_tech_names_are_forbidden(schema):
    assert schema in FORBIDDEN_DOMAINS
    issues = rule_issues(_tree(*_OK, _dom("X Y", "Event Capture", "Change History", schema=schema)))
    assert [(i.severity, i.rule_id) for i in issues] == [("error", "DOM-RUL-030")]


def test_fewer_than_three_domains_stays_a_blocking_error():
    issues = rule_issues(_tree(*_OK))
    assert MIN_DOMAINS == 3
    assert [(i.severity, i.rule_id, i.domains) for i in issues] == [("error", "DOM-RUL-032", [])]
    assert APPLIED_RULES["DOM-RUL-032"] == "error"


def test_tiers_never_overlap():
    assert not FORBIDDEN_DOMAINS & VAGUE_DOMAINS


def test_compile_only_issues_carry_domain_indices():
    tree = _tree(*_OK, TaxonomyDomain(name="Grid"))
    out = compile_taxonomy(TaxonomyCompileIn(tree=tree))
    empty = next(i for i in out.issues if i.message == "Domain 'Grid' has no sub-domains.")
    assert (empty.rule_id, empty.domains) == ("", [2])
