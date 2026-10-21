import re
from pathlib import Path

from vibe_modeling.backend.taxonomy.compile import build_clamp, compile_taxonomy, tree_to_csv
from vibe_modeling.backend.taxonomy.example import load_ridgeline_example, tree_from_csv
from vibe_modeling.backend.taxonomy.models import (
    TaxonomyCompileIn,
    TaxonomyTree,
)

EXAMPLES = Path(__file__).parents[2] / "src/app/src/vibe_modeling/backend/taxonomy/examples"


def _parse_domain_lines(clamp: str) -> dict:
    """Parse '1 schema - sub: a, b; sub2: c.' lines into {schema: {sub: [ents]}}."""
    block = clamp.split("Domains, sub-domains, and required entities:")[1].split("Key relationships:")[0]
    out = {}
    for line in block.strip().splitlines():
        m = re.match(r"\d+ (\w+) - (.*)", line.strip())
        if not m:
            continue
        out[m.group(1)] = {}
        for part in m.group(2).rstrip(".").split("; "):
            sub, ents = part.split(": ")
            out[m.group(1)][sub] = [e.strip() for e in ents.split(",")]
    return out


def test_golden_ridgeline_domains_match_hand_written_clamp():
    ex = load_ridgeline_example()
    compiled = build_clamp(ex.tree, "strict")
    hand = (EXAMPLES / "ridgeline_business_vibes.md").read_text()
    assert _parse_domain_lines(compiled) == _parse_domain_lines(hand)


def test_golden_ridgeline_relationships_line_matches():
    ex = load_ridgeline_example()
    compiled = build_clamp(ex.tree, "strict")
    hand = (EXAMPLES / "ridgeline_business_vibes.md").read_text()
    pick = lambda s: [l for l in s.splitlines() if l.startswith("Key relationships:")][0]
    assert pick(compiled) == pick(hand)


def test_golden_ridgeline_shared_master_lines():
    compiled = build_clamp(load_ridgeline_example().tree, "strict")
    assert "- premise, service_point, customer_account -> customer" in compiled
    assert "- supplier -> finance" in compiled
    assert "- employee, organization -> workforce" in compiled


def test_strict_vs_guided_header():
    tree = load_ridgeline_example().tree
    assert "Produce EXACTLY these 10 domains" in build_clamp(tree, "strict")
    guided = build_clamp(tree, "guided")
    assert "Start from these 10 domains" in guided
    assert "Produce EXACTLY" not in guided


def test_compile_outputs_domains_seed_and_vibes_order():
    ex = load_ridgeline_example()
    out = compile_taxonomy(TaxonomyCompileIn(tree=ex.tree, sections=ex.sections))
    assert out.business_domains == (
        "customer, billing, grid, gas, asset, outage, supply, finance, workforce, safety"
    )
    v = out.business_vibes
    assert v.index("## Company and segments") < v.index("## Systems of record") < v.index("## Conformance clamp (load-bearing)")
    assert "Organization divisions: Customer Operations, Grid & Gas Operations, Energy Supply, Corporate." in v
    assert out.issues == []  # the few-shot example must be fully conforming: zero errors AND zero warnings


def test_csv_round_trip():
    tree = load_ridgeline_example().tree
    csv_text = tree_to_csv(tree)
    assert csv_text.splitlines()[0] == "Domain,Sub Domain,Category"
    assert [d.model_dump() for d in tree_from_csv(csv_text, {d.name: d.schema_name for d in tree.domains})] == [d.model_dump() for d in tree.domains]


def _tree(**kw) -> TaxonomyTree:
    base = {"domains": [{"name": "Billing", "subdomains": [{"name": "Invoices", "categories": ["Bill"]}]}]}
    base.update(kw)
    return TaxonomyTree.model_validate(base)


def test_compile_errors_on_duplicate_schema_names():
    t = TaxonomyTree.model_validate({"domains": [{"name": "Billing"}, {"name": "billing!"}]})
    out = compile_taxonomy(TaxonomyCompileIn(tree=t))
    assert any(i.severity == "error" and "billing" in i.message for i in out.issues)


def test_compile_errors_on_empty_or_invalid_schema_name():
    t = TaxonomyTree.model_validate({"domains": [{"name": "&&&"}, {"name": "日本"}, {"name": "2027 Plan"}]})
    errors = [i for i in compile_taxonomy(TaxonomyCompileIn(tree=t)).issues if i.severity == "error"]
    assert len(errors) == 3


def test_compile_errors_on_unknown_shared_master_home():
    t = _tree(shared_masters=[{"entity": "bill", "home_domain": "finance"}])
    out = compile_taxonomy(TaxonomyCompileIn(tree=t))
    assert any(i.severity == "error" and "finance" in i.message for i in out.issues)


def test_compile_warns_on_entity_in_two_domains_and_empty_nodes():
    t = TaxonomyTree.model_validate({"domains": [
        {"name": "Billing", "subdomains": [{"name": "Invoices", "categories": ["Customer"]}]},
        {"name": "Customer", "subdomains": [{"name": "Master", "categories": ["Customer"]}, {"name": "Empty"}]},
        {"name": "Hollow"},
    ]})
    warnings = [i.message for i in compile_taxonomy(TaxonomyCompileIn(tree=t)).issues if i.severity == "warning"]
    assert any("customer" in w and "billing" in w for w in warnings)
    assert any("Empty" in w for w in warnings)
    assert any("Hollow" in w for w in warnings)


def test_compile_skips_blank_categories():
    """Defensive: the UI sanitizes first, but a blank category must never emit 'sub: , x'."""
    t = TaxonomyTree.model_validate({"domains": [
        {"name": "Billing", "subdomains": [
            {"name": "Invoices", "categories": ["Bill", "", "   "]},
            {"name": "Blank", "categories": [""]},
        ]},
    ]})
    out = compile_taxonomy(TaxonomyCompileIn(tree=t))
    assert "1 billing - invoices: bill." in out.clamp
    assert ": ," not in out.clamp and ", ," not in out.clamp
    assert out.csv.splitlines()[1:] == ["Billing,Invoices,Bill"]
    assert any("Blank" in i.message for i in out.issues if i.severity == "warning")
