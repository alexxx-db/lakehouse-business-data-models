import json
from pathlib import Path

import pytest
from pydantic import ValidationError

from vibe_modeling.backend.models import BUSINESS_NAME_PATTERN, BusinessIn, ORG_DIVISIONS_PRESETS
from vibe_modeling.backend.taxonomy.models import (
    SECTION_HEADINGS,
    SECTION_KEYS,
    TaxonomyIntake,
    TaxonomySection,
    TaxonomyTree,
)
from vibe_modeling.backend.taxonomy.naming import SCHEMA_NAME_RE, snake

FIXTURE = Path(__file__).parents[1] / "fixtures" / "taxonomy_snake_fixture.json"


@pytest.mark.parametrize("raw,expected", json.loads(FIXTURE.read_text()))
def test_snake_matches_shared_fixture(raw, expected):
    assert snake(raw) == expected


def test_schema_name_re():
    assert SCHEMA_NAME_RE.match("customer")
    assert SCHEMA_NAME_RE.match("2027_rate_case") is None  # must start with a letter
    assert SCHEMA_NAME_RE.match("") is None
    assert SCHEMA_NAME_RE.match("customer_premise") is None  # DOM-RUL-002: no underscores


def test_section_keys_and_headings_align():
    assert SECTION_KEYS == (
        "company", "channels", "processes", "terminology", "systems_of_record", "regulatory",
    )
    assert set(SECTION_HEADINGS) == set(SECTION_KEYS)
    assert SECTION_HEADINGS["systems_of_record"] == "Systems of record"


def test_intake_minimal_ok():
    i = TaxonomyIntake(company_name="Ridgeline Energy", industry="Electric & gas utility")
    assert i.known_domains == "" and i.pasted_doc == ""


@pytest.mark.parametrize("name", ["Ridgeline Energy / Gas", "Acme™", " Leading space", ""])
def test_intake_rejects_business_name_chars(name):
    with pytest.raises(ValidationError):
        TaxonomyIntake(company_name=name, industry="Utility")


def test_intake_caps_pasted_doc():
    with pytest.raises(ValidationError):
        TaxonomyIntake(company_name="Acme", industry="X", pasted_doc="a" * 60_001)


def test_tree_defaults_and_coverage_preset():
    t = TaxonomyTree.model_validate({"domains": [{"name": "Billing"}]})
    assert t.coverage == "Operations, Business and Corporate"
    assert t.domains[0].schema_name == ""
    assert t.shared_masters == [] and t.relationships == [] and t.division_names == []
    with pytest.raises(ValidationError):
        TaxonomyTree.model_validate({"domains": [{"name": "B"}], "coverage": "Everything"})
    assert ORG_DIVISIONS_PRESETS == (
        "Operations", "Operations and Business", "Operations, Business and Corporate",
    )
    for preset in ORG_DIVISIONS_PRESETS:
        assert TaxonomyTree.model_validate({"domains": [{"name": "B"}], "coverage": preset}).coverage == preset


def _patterns(field) -> set:
    return {getattr(m, "pattern", None) for m in field.metadata}


def test_intake_and_business_share_one_name_pattern():
    assert BUSINESS_NAME_PATTERN in _patterns(TaxonomyIntake.model_fields["company_name"])
    assert BUSINESS_NAME_PATTERN in _patterns(BusinessIn.model_fields["name"])


def test_tree_requires_a_domain():
    with pytest.raises(ValidationError):
        TaxonomyTree.model_validate({"domains": []})


def test_section_claim_provenance_enum():
    s = TaxonomySection.model_validate({"claims": [{"text": "A CIS owns billing.", "provenance": "industry"}]})
    assert s.claims[0].provenance == "industry"
    with pytest.raises(ValidationError):
        TaxonomySection.model_validate({"claims": [{"text": "x", "provenance": "guess"}]})
