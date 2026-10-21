"""The built-in Ridgeline Energy example (workshop dry run, 2026-10-07)."""

from __future__ import annotations

import csv
import io
import json
from functools import lru_cache
from pathlib import Path

from .models import (
    SECTION_HEADINGS,
    TaxonomyClaim,
    TaxonomyDomain,
    TaxonomyExampleOut,
    TaxonomySection,
    TaxonomySharedMaster,
    TaxonomyRelationship,
    TaxonomySubdomain,
    TaxonomyTree,
)

_DIR = Path(__file__).parent / "examples"
_HEADING_TO_KEY = {v: k for k, v in SECTION_HEADINGS.items()}


def tree_from_csv(text: str, schema_names: dict[str, str] | None = None) -> list[TaxonomyDomain]:
    domains: dict[str, dict[str, list[str]]] = {}
    for row in csv.DictReader(io.StringIO(text)):
        domains.setdefault(row["Domain"], {}).setdefault(row["Sub Domain"], []).append(row["Category"])
    return [
        TaxonomyDomain(
            name=d,
            schema_name=(schema_names or {}).get(d, ""),
            subdomains=[TaxonomySubdomain(name=s, categories=cats) for s, cats in subs.items()],
        )
        for d, subs in domains.items()
    ]


def _sections_from_markdown(md: str) -> dict[str, TaxonomySection]:
    out: dict[str, TaxonomySection] = {}
    for chunk in md.split("## ")[1:]:
        heading, _, body = chunk.partition("\n")
        key = _HEADING_TO_KEY.get(heading.strip())
        if key and body.strip():
            out[key] = TaxonomySection(claims=[TaxonomyClaim(text=body.strip(), provenance="user")])
    return out


@lru_cache(maxsize=1)
def load_ridgeline_example() -> TaxonomyExampleOut:
    meta = json.loads((_DIR / "ridgeline_meta.json").read_text())
    tree = TaxonomyTree(
        domains=tree_from_csv((_DIR / "ridgeline_taxonomy.csv").read_text(), meta.get("schema_names")),
        shared_masters=[TaxonomySharedMaster(**m) for m in meta["shared_masters"]],
        relationships=[TaxonomyRelationship(**r) for r in meta["relationships"]],
        division_names=meta["division_names"],
        coverage=meta["coverage"],
    )
    return TaxonomyExampleOut(
        company_name=meta["company_name"],
        industry=meta["industry"],
        tree=tree,
        sections=_sections_from_markdown((_DIR / "ridgeline_business_vibes.md").read_text()),
        description=(_DIR / "ridgeline_description.txt").read_text().strip(),
    )
