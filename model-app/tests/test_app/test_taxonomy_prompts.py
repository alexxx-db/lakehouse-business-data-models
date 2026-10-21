import pytest

from vibe_modeling.backend.taxonomy.example import load_ridgeline_example
from vibe_modeling.backend.taxonomy.models import SECTION_KEYS, TaxonomyIntake
from vibe_modeling.backend.taxonomy.prompts import (
    PROMPT_AVOID,
    build_condense_prompt,
    build_section_prompt,
    build_tree_prompt,
)
from vibe_modeling.backend.taxonomy.rules import _PLACEHOLDERS, FORBIDDEN_DOMAINS, VAGUE_DOMAINS

INTAKE = TaxonomyIntake(
    company_name="Acme Water",
    industry="Water utility",
    known_domains="billing, asset_management",
    key_systems="SAP IS-U",
    pasted_doc="Capability map: Billing, Assets, Field Ops",
)


def test_tree_prompt_contains_intake_schema_and_example():
    system, user = build_tree_prompt(INTAKE)
    assert "ONLY a JSON object" in system
    assert '"shared_masters"' in system  # JSON schema embedded
    assert "Ridgeline" in system  # few-shot example
    for s in ("Acme Water", "Water utility", "billing, asset_management", "SAP IS-U", "Capability map"):
        assert s in user


def test_tree_prompt_keeps_known_domains_rule():
    system, _ = build_tree_prompt(INTAKE)
    assert "keep every domain the user already listed" in system


@pytest.mark.parametrize("key", SECTION_KEYS)
def test_section_prompt_per_key(key):
    tree = load_ridgeline_example().tree
    system, user = build_section_prompt(key, INTAKE, tree)
    assert "provenance" in system and '"confirm"' in system
    assert "customer (Customer & Premise)" in user  # drafted tree passed for consistency
    assert "Acme Water" in user


def test_systems_of_record_prompt_forbids_invented_vendors():
    system, _ = build_section_prompt("systems_of_record", INTAKE, load_ridgeline_example().tree)
    assert "do not invent vendor product names" in system.lower()


def test_unknown_section_key_raises():
    with pytest.raises(KeyError):
        build_section_prompt("finance", INTAKE, load_ridgeline_example().tree)


def test_condense_prompt_limit_and_domains():
    ex = load_ridgeline_example()
    system, user = build_condense_prompt(INTAKE, ex.tree, ex.sections, limit=1500)
    assert "1,500 characters" in system
    assert "customer, billing" in user


def test_section_prompt_asks_for_few_substantial_claims():
    system, _ = build_section_prompt("company", INTAKE, load_ridgeline_example().tree)
    assert "2 to 6 claims" in system
    assert "not one claim per sentence" in system


def test_tree_prompt_states_model_agent_naming_rules():
    system, _ = build_tree_prompt(INTAKE)
    assert "Leave schema_name empty" not in system
    assert "ALWAYS set schema_name" in system
    assert "exactly one lowercase word" in system and "no underscores" in system and "20 characters" in system
    assert "singular" in system
    assert all(w in system for w in FORBIDDEN_DOMAINS)
    assert "exactly two words" in system
    assert "share a word" in system and "unique across the whole model" in system
    assert "at least 3 domains" in system and "at least 2 sub-domains" in system
    assert "home_domain" in system and "schema name" in system
    assert "Corporate" in system


def test_prompt_avoid_list_is_tier_two():
    assert set(PROMPT_AVOID) <= VAGUE_DOMAINS


def test_tree_prompt_name_lists_come_from_the_rule_constants():
    system, _ = build_tree_prompt(INTAKE)
    assert f"(these are rejected): {', '.join(sorted(FORBIDDEN_DOMAINS))}." in system
    assert "Avoid services, utilities, support, admin, infrastructure unless" in system
    assert f"placeholders ({', '.join(sorted(_PLACEHOLDERS))}," in system
