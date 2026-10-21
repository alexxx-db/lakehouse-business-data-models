from vibe_modeling.backend.taxonomy.example import load_ridgeline_example
from vibe_modeling.backend.taxonomy.models import SECTION_KEYS


def test_example_has_all_sections_and_ten_domains():
    ex = load_ridgeline_example()
    assert ex.company_name == "Ridgeline Energy"
    assert len(ex.tree.domains) == 10
    assert set(ex.sections) == set(SECTION_KEYS)
    assert all(c.provenance == "user" for s in ex.sections.values() for c in s.claims)
    assert 0 < len(ex.description) <= 2000


def test_example_sections_exclude_clamp():
    ex = load_ridgeline_example()
    assert all("Conformance clamp" not in c.text for s in ex.sections.values() for c in s.claims)


def test_example_conforms_to_model_agent_naming_rules():
    from vibe_modeling.backend.taxonomy.compile import compile_taxonomy, domain_schema
    from vibe_modeling.backend.taxonomy.models import TaxonomyCompileIn

    ex = load_ridgeline_example()
    assert compile_taxonomy(TaxonomyCompileIn(tree=ex.tree, sections=ex.sections)).issues == []
    # Friendly display names are kept; the one-word schema is a stored override.
    assert [(d.name, d.schema_name) for d in ex.tree.domains][:3] == [
        ("Customer & Premise", "customer"), ("Meter-to-Cash", "billing"), ("Electric Grid", "grid"),
    ]
    assert all(d.schema_name == domain_schema(d) for d in ex.tree.domains)
    assert all(len(s.name.split()) == 2 for d in ex.tree.domains for s in d.subdomains)
    assert {m.home_domain for m in ex.tree.shared_masters} <= {domain_schema(d) for d in ex.tree.domains}
    assert "customer, billing, grid, gas, asset, outage, supply, finance, workforce, and safety" in ex.description
