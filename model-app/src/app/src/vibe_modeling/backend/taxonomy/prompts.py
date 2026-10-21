"""Prompt builders. Guidance mirrors docs/Describing-a-business.md; Ridgeline is the worked example."""

from __future__ import annotations

import json

from .compile import domain_schema
from .example import load_ridgeline_example
from .models import SECTION_HEADINGS, TaxonomyIntake, TaxonomySection, TaxonomyTree
from .rules import _PLACEHOLDERS, FORBIDDEN_DOMAINS

_JSON_ONLY = "Reply with ONLY a JSON object that matches this JSON Schema - no prose, no code fences:\n"

SECTION_GUIDANCE: dict[str, str] = {
    "company": "Who the company is: what it makes/sells/provides, major segments and how they differ, brands/subsidiaries/acquisitions in scope, geographies.",
    "channels": "How it reaches customers; which channels must be modeled separately; feedback data each channel produces.",
    "processes": "The value chain end to end (procure, engineer, make, move, sell, service, or the industry equivalent), structural splits inside steps, strategic initiatives and hard deadlines.",
    "terminology": "A flat list of the industry's and company's vocabulary with acronym expansions, e.g. 'ami (advanced metering infrastructure)'. Put about 10 terms in each claim, comma-separated.",
    "systems_of_record": "Each system, the domain it owns, and whether it is current source of truth, legacy being replaced, or target state; migrations in progress. If you do not know THIS company's actual systems, describe the typical system TYPES for the industry with provenance 'industry' (e.g. 'a customer information system (CIS) owns customers and billing') - do not invent vendor product names.",
    "regulatory": "Regulations and standards that apply to the industry and geographies, and which data they make restricted or mandatory.",
}

# Tier-2 names the tree prompt tells the model to avoid; a subset of rules.VAGUE_DOMAINS.
PROMPT_AVOID: tuple[str, ...] = ("services", "utilities", "support", "admin", "infrastructure")

_PROVENANCE_RULES = (
    'Split the section into 2 to 6 claims, each a full point (one to three sentences, or one comma-separated list), '
    'not one claim per sentence. Label each claim\'s provenance: '
    '"user" ONLY if the user stated it in the intake; "industry" if it is typical for companies in this industry; '
    '"confirm" if it is a specific fact about THIS company that you believe from training knowledge but the user '
    "must verify (e.g. a named vendor system, a revenue figure, a recent acquisition). Never label a guess about this "
    'company as "user" or "industry".'
)


def _intake_block(i: TaxonomyIntake) -> str:
    lines = [f"Company: {i.company_name}", f"Industry: {i.industry}"]
    for label, value in (
        ("One-line description", i.one_liner),
        ("Domains they already use", i.known_domains),
        ("Key systems", i.key_systems),
        ("Regulators", i.regulators),
    ):
        if value.strip():
            lines.append(f"{label}: {value.strip()}")
    if i.pasted_doc.strip():
        lines.append(f"Existing document (verbatim, may be partial):\n<<<\n{i.pasted_doc.strip()}\n>>>")
    return "\n".join(lines)


def _tree_summary(tree: TaxonomyTree) -> str:
    return "\n".join(
        f"- {domain_schema(d)} ({d.name}): " + "; ".join(f"{s.name}: {', '.join(s.categories)}" for s in d.subdomains)
        for d in tree.domains
    )


def build_tree_prompt(intake: TaxonomyIntake) -> tuple[str, str]:
    ex = load_ridgeline_example()
    schema = json.dumps(TaxonomyTree.model_json_schema())
    system = (
        "You draft an enterprise data-domain taxonomy for a company. It seeds a data-modeling agent that builds a "
        "source-agnostic silver-layer model, so domains are business capabilities, not systems or departments.\n"
        "Rules:\n"
        "- 6 to 14 domains (the model needs at least 3 domains); each domain 2 to 4 sub-domains (at least 2 sub-domains per domain, never exactly 1); each sub-domain 2 to 5 categories.\n"
        "- Categories are real business entities as singular nouns ('Service Agreement', not 'Service agreements data').\n"
        "- Put each entity in ONE domain. Entities many domains reference (customer, supplier, employee, product, "
        "location) go in shared_masters with exactly one home_domain (the domain's schema name, e.g. 'customer').\n"
        "- relationships use snake_case entity names: the entity that holds the foreign key -> what it references.\n"
        "- If the user already listed domains, keep every domain the user already listed (you may normalize the "
        "wording) and fill the gaps around them.\n"
        "- division_names: the company's top-level organizational divisions. coverage: use "
        "'Operations, Business and Corporate' unless the user's scope is clearly operations-only. "
        "Most domains should be Operations or Business functions; keep back-office Corporate domains to about a fifth.\n"
        "Naming rules (the modeling agent that consumes this taxonomy enforces them):\n"
        "- Domain name is a friendly display label ('Meter-to-Cash') and may be several words. ALWAYS set schema_name "
        "to the domain's schema: exactly one lowercase word (letters and digits only, no underscores, no spaces), "
        "singular, at most 20 characters, e.g. 'customer', 'billing', 'fieldservice'. (Naturally singular words such "
        "as 'logistics' or 'sales' are fine.) Every schema_name must be unique.\n"
        "- A domain must be a real business function - would you find that department at company headquarters? "
        f"Never use catch-alls or technical names (these are rejected): {', '.join(sorted(FORBIDDEN_DOMAINS))}. "
        f"Avoid {', '.join(PROMPT_AVOID)} unless that is the company's real department name.\n"
        "- Sub-domain names are in business language and exactly two words ('Meter Reading'). No two sub-domains in "
        "the same domain may share a word; every sub-domain name must be unique across the whole model; never use "
        f"placeholders ({', '.join(sorted(_PLACEHOLDERS))}, or numbered names like Group A or Category 1).\n"
        "Example for a different company - Ridgeline Energy (format reference ONLY - do not copy its content unless the company is "
        f"also a utility):\n{ex.tree.model_dump_json()}\n\n"
        f"{_JSON_ONLY}{schema}"
    )
    return system, _intake_block(intake)


def build_section_prompt(key: str, intake: TaxonomyIntake, tree: TaxonomyTree) -> tuple[str, str]:
    heading = SECTION_HEADINGS[key]  # KeyError on unknown key is intended
    ex = load_ridgeline_example()
    example = ex.sections[key].claims[0].text
    schema = json.dumps(TaxonomySection.model_json_schema())
    system = (
        f"You draft the '{heading}' section of a business description that a data-modeling agent reads.\n"
        f"What this section covers: {SECTION_GUIDANCE[key]}\n"
        f"{_PROVENANCE_RULES}\n"
        "Be specific and concrete; use the company's domains below so the section is consistent with them.\n"
        f"Example of a finished section for a different company (Ridgeline Energy):\n{example}\n\n"
        f"{_JSON_ONLY}{schema}"
    )
    user = f"{_intake_block(intake)}\n\nThe company's domains:\n{_tree_summary(tree)}"
    return system, user


def build_condense_prompt(
    intake: TaxonomyIntake,
    tree: TaxonomyTree,
    sections: dict[str, TaxonomySection],
    *,
    limit: int = 1900,
) -> tuple[str, str]:
    ex = load_ridgeline_example()
    system = (
        f"Write ONE paragraph, at most {limit:,} characters, summarizing this business for a data-modeling agent. "
        "Name the company, industry, segments, and geography; say what makes its data distinct; then list the domain "
        "schema names verbatim and state that the model must conform exactly to them. Plain text only - no markdown, "
        f"no headings, no lists.\nExample (different company):\n{ex.description}"
    )
    body = "\n\n".join(
        f"{SECTION_HEADINGS[k]}: " + " ".join(c.text for c in s.claims) for k, s in sections.items() if k in SECTION_HEADINGS
    )
    domains = ", ".join(domain_schema(d) for d in tree.domains)
    user = f"Company: {intake.company_name}\nIndustry: {intake.industry}\nDomains: {domains}\n\n{body}"
    return system, user
