"""Pure compile: taxonomy tree -> agent inputs. No LLM, no I/O."""

from __future__ import annotations

import csv
import io

from .models import (
    SECTION_HEADINGS,
    SECTION_KEYS,
    TaxonomyCompileIn,
    TaxonomyCompileOut,
    TaxonomyDomain,
    TaxonomyIssue,
    TaxonomySection,
    TaxonomySubdomain,
    TaxonomyTree,
)
from .naming import schema_for, snake
from .rules import rule_issues

_COMMON_RULES = (
    "Model each concept in ONE domain. Keep source_system and a stable business_key on every "
    "product; never strip them. Do NOT invent placeholder entities - use the REAL entities named "
    "below. Tag every table with its sub_domain."
)


def domain_schema(d: TaxonomyDomain) -> str:
    return schema_for(d.name, d.schema_name)


def _categories(s: TaxonomySubdomain) -> list[str]:
    """Trimmed, non-blank categories. Defensive: the UI sanitizes first, but a blank
    category must never reach the clamp as 'sub: , x' or the CSV as an empty row."""
    return [c.strip() for c in s.categories if c.strip()]


def build_clamp(tree: TaxonomyTree, strictness: str) -> str:
    n = len(tree.domains)
    if strictness == "guided":
        head = (
            f"Start from these {n} domains - keep their names and do NOT merge, split, or drop them. "
            "You MAY add a domain only for a real capability none of them covers; say why in its "
            f"description. {_COMMON_RULES}"
        )
    else:
        head = (
            f"Produce EXACTLY these {n} domains - do NOT rename, merge, split, drop, or invent "
            f"domains. {_COMMON_RULES}"
        )
    lines = ["## Conformance clamp (load-bearing)", head]

    if tree.shared_masters:
        grouped: dict[str, list[str]] = {}
        for sm in tree.shared_masters:
            grouped.setdefault(sm.home_domain, []).append(sm.entity)
        lines += [
            "",
            "Shared masters (model ONCE in the canonical home; elsewhere use foreign keys, never duplicate tables):",
        ]
        lines += [f"- {', '.join(ents)} -> {home}" for home, ents in grouped.items()]

    lines += ["", "Domains, sub-domains, and required entities:"]
    for idx, d in enumerate(tree.domains, start=1):
        parts = [
            f"{snake(s.name)}: {', '.join(snake(c) for c in _categories(s))}"
            for s in d.subdomains
            if _categories(s)
        ]
        lines.append(f"{idx} {domain_schema(d)} - {'; '.join(parts)}.")

    if tree.relationships:
        rels = "; ".join(f"{r.source} -> {' + '.join(r.targets)}" for r in tree.relationships)
        lines += ["", f"Key relationships: {rels}."]
    return "\n".join(lines) + "\n"


def tree_to_csv(tree: TaxonomyTree) -> str:
    buf = io.StringIO()
    w = csv.writer(buf, lineterminator="\n")
    w.writerow(["Domain", "Sub Domain", "Category"])
    for d in tree.domains:
        for s in d.subdomains:
            for c in _categories(s):
                w.writerow([d.name, s.name, c])
    return buf.getvalue()


def _section_text(section: TaxonomySection) -> str:
    return " ".join(c.text.strip() for c in section.claims)


def _issues(tree: TaxonomyTree) -> list[TaxonomyIssue]:
    issues: list[TaxonomyIssue] = rule_issues(tree)
    seen: dict[str, str] = {}
    for di, d in enumerate(tree.domains):
        seen.setdefault(domain_schema(d), d.name)
        if not d.subdomains:
            issues.append(TaxonomyIssue(
                severity="warning", message=f"Domain '{d.name}' has no sub-domains.", domains=[di],
            ))
        for s in d.subdomains:
            if not _categories(s):
                issues.append(TaxonomyIssue(
                    severity="warning", message=f"Sub-domain '{s.name}' in '{d.name}' has no categories.",
                    domains=[di],
                ))

    homes: dict[str, list[int]] = {}
    for di, d in enumerate(tree.domains):
        for s in d.subdomains:
            for c in _categories(s):
                homes.setdefault(snake(c), []).append(di)
    for ent, idxs in homes.items():
        unique = sorted({domain_schema(tree.domains[di]) for di in idxs})
        if len(unique) > 1:
            issues.append(TaxonomyIssue(
                severity="warning",
                message=f"'{ent}' appears in {', '.join(unique)} - make it a shared master with one home.",
                domains=list(dict.fromkeys(idxs)),
            ))

    schemas = set(seen)
    for sm in tree.shared_masters:
        if sm.home_domain not in schemas:
            issues.append(TaxonomyIssue(
                severity="error",
                message=f"Shared master '{sm.entity}' points at unknown domain '{sm.home_domain}'.",
            ))
    return issues


def compile_taxonomy(data: TaxonomyCompileIn) -> TaxonomyCompileOut:
    tree = data.tree
    clamp = build_clamp(tree, data.strictness)
    blocks: list[str] = []
    for key in SECTION_KEYS:
        section = data.sections.get(key)
        text = _section_text(section) if section else ""
        if key == "company" and tree.division_names:
            text = (text + " " if text else "") + f"Organization divisions: {', '.join(tree.division_names)}."
        if text:
            blocks.append(f"## {SECTION_HEADINGS[key]}\n{text}\n")
    blocks.append(clamp)
    return TaxonomyCompileOut(
        clamp=clamp,
        business_vibes="\n".join(blocks),
        business_domains=", ".join(domain_schema(d) for d in tree.domains),
        csv=tree_to_csv(tree),
        issues=_issues(tree),
    )
