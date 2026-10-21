"""Naming rules from the modeling agent (vendored/agent/vibe-data-modelling-rules.csv, DOM-RUL-*).

The agent takes business_domains verbatim, so pinned domain names bypass its own
naming checks - the builder enforces them here instead. Errors block Create;
warnings do not. APPLIED_RULES lists every agent rule the builder applies; it is
kept in step with the vendored CSV at release time. Maintainers: the rules doc, its
test and the release gate are listed in docs/codebase-map.md, tests/INDEX.md and
scripts/INDEX.md.
"""

from __future__ import annotations

import re
from typing import Literal

from .models import TaxonomyIssue, TaxonomyTree
from .naming import SCHEMA_NAME_MAX, SCHEMA_NAME_RE, schema_for, snake

# Every agent rule the builder applies, with the severity it gives. "split" = errors for some
# names and warnings for others (the DOM-RUL-037 tiers). These ids are checked against
# the upstream CSV at release time (release gates: see scripts/INDEX.md).
APPLIED_RULES: dict[str, Literal["error", "warning", "split"]] = {
    "DOM-RUL-002": "error",
    "DOM-RUL-004": "warning",
    "DOM-RUL-006": "error",
    "DOM-RUL-007": "split",
    "DOM-RUL-016": "error",
    "DOM-RUL-020": "warning",
    "DOM-RUL-021": "warning",
    "DOM-RUL-024": "warning",
    "DOM-RUL-027": "warning",
    "DOM-RUL-030": "error",
    "DOM-RUL-032": "error",
    "DOM-RUL-037": "split",
    "DOM-RUL-040": "warning",
}

MIN_DOMAINS = 3  # DOM-RUL-032

# Tier 1 (DOM-RUL-037): hard-blocked in every industry. The singular forms (report, insight,
# metric) intentionally extend the CSV's plural-only lists - 'report' is as wrong a domain as
# 'reporting'.
_ANALYTICS_DOMAINS = frozenset((  # DOM-RUL-006
    "analytics reporting insights intelligence metrics kpi dashboard bi datawarehouse data system api "
    "report insight metric"
).split())
# DOM-RUL-030; audittrail/batchcontrol are the schema forms of the CSV's audit_trail/batch_control.
_TECH_DOMAINS = frozenset("integration etl logging audittrail batchcontrol".split())
_GENERIC_DOMAINS = frozenset("common core shared platform base general misc other auxiliary".split())  # DOM-RUL-007
FORBIDDEN_DOMAINS = _ANALYTICS_DOMAINS | _TECH_DOMAINS | _GENERIC_DOMAINS
# Tier 2 (DOM-RUL-037): vague unless it is the company's real org-chart name. The first group is
# also on DOM-RUL-007's list (utility/service are the singular forms).
_GENERIC_VAGUE = frozenset("utilities utility services service support infrastructure admin".split())
VAGUE_DOMAINS = _GENERIC_VAGUE | frozenset("operations regulatory audit technology".split())
# Naturally singular words that happen to end in "s" (DOM-RUL-004). Deliberately conservative.
SINGULAR_S_WORDS = frozenset(
    "logistics sales news series species lens bias gas bus atlas canvas "
    "economics electronics mechanics physics statistics".split()
)
_SINGULAR_ENDINGS = ("ss", "us", "is")
_PLACEHOLDERS = frozenset("other general miscellaneous misc n_a na none tbd uncategorized".split())
_PLACEHOLDER_RE = re.compile(r"(sub_?domain|category|group)_?(\d+|[a-z])")


def looks_plural(schema: str) -> bool:
    if len(schema) < 4 or not schema.endswith("s") or schema in SINGULAR_S_WORDS:
        return False
    return not schema.endswith(_SINGULAR_ENDINGS)


def _forbidden_rule(schema: str) -> str:
    if schema in _TECH_DOMAINS:
        return "DOM-RUL-030"
    return "DOM-RUL-007" if schema in _GENERIC_DOMAINS else "DOM-RUL-006"


def _vague_rule(schema: str) -> str:
    return "DOM-RUL-007" if schema in _GENERIC_VAGUE else "DOM-RUL-037"


def _is_placeholder(name: str) -> bool:
    key = snake(name)
    return key in _PLACEHOLDERS or bool(_PLACEHOLDER_RE.fullmatch(key))


def _err(rule_id: str, domains: list[int], msg: str) -> TaxonomyIssue:
    return TaxonomyIssue(severity="error", message=msg, rule_id=rule_id, domains=domains)


def _warn(rule_id: str, domains: list[int], msg: str) -> TaxonomyIssue:
    return TaxonomyIssue(severity="warning", message=msg, rule_id=rule_id, domains=domains)


def rule_issues(tree: TaxonomyTree) -> list[TaxonomyIssue]:
    out: list[TaxonomyIssue] = []
    seen: dict[str, tuple[str, int]] = {}
    domains = [(d, d.name.strip(), schema_for(d.name, d.schema_name)) for d in tree.domains]

    for di, (d, name, schema) in enumerate(domains):
        if not SCHEMA_NAME_RE.fullmatch(schema):  # fullmatch: `$` would accept a trailing newline
            out.append(_err("DOM-RUL-002", [di],
                f"Domain '{name}': schema name '{schema}' must be one lowercase word - letters and digits "
                "only, no underscores, starting with a letter (DOM-RUL-002)."
            ))
        elif len(schema) > SCHEMA_NAME_MAX:
            out.append(_err("DOM-RUL-002", [di],
                f"Domain '{name}': schema name '{schema}' is {len(schema)} characters - keep it to "
                f"{SCHEMA_NAME_MAX} or fewer (DOM-RUL-002)."
            ))
        if schema in FORBIDDEN_DOMAINS:
            rule = _forbidden_rule(schema)
            out.append(_err(rule, [di],
                f"Domain '{name}': '{schema}' is a catch-all or technical name, not a business function "
                f"- rename it ({rule})."
            ))
        elif schema in VAGUE_DOMAINS:
            rule = _vague_rule(schema)
            out.append(_warn(rule, [di],
                f"Domain '{name}': '{schema}' is a vague name unless it is the real department name at "
                f"this company ({rule})."
            ))
        elif looks_plural(schema):
            out.append(_warn("DOM-RUL-004", [di],
                f"Domain '{name}': '{schema}' looks plural - use the singular form, e.g. 'customer' not "
                "'customers' (DOM-RUL-004)."
            ))
        if schema:
            if schema in seen:
                first, fi = seen[schema]
                out.append(_err("DOM-RUL-016", [fi, di],
                    f"Domains '{first}' and '{name}' both map to schema '{schema}' (DOM-RUL-016)."
                ))
            else:
                seen[schema] = (name, di)

    homes: dict[str, list[tuple[int, str]]] = {}
    for di, (d, name, _) in enumerate(domains):
        subs = [s.name.strip() for s in d.subdomains if s.name.strip()]
        if len(d.subdomains) == 1:
            out.append(_warn("DOM-RUL-020", [di],
                f"Domain '{name}' has only one sub-domain - give it at least two (DOM-RUL-020)."
            ))
        owners: dict[str, list[str]] = {}
        for sname in subs:
            # The agent splits on whitespace, so 'Low-Income Assistance' is two words.
            words = sname.lower().split()
            if len(words) != 2:
                out.append(_warn("DOM-RUL-021", [di],
                    f"Sub-domain '{sname}' in '{name}' should be exactly two words (DOM-RUL-021)."
                ))
            if _is_placeholder(sname):
                out.append(_warn("DOM-RUL-027", [di],
                    f"Sub-domain '{sname}' in '{name}' is a placeholder - use a real business name (DOM-RUL-027)."
                ))
            for w in dict.fromkeys(words):
                owners.setdefault(w, []).append(sname)
            homes.setdefault(snake(sname), []).append((di, sname))
        for w, names in owners.items():
            if len(names) > 1:
                listed = ", ".join(f"'{n}'" for n in names)
                out.append(_warn("DOM-RUL-024", [di],
                    f"Sub-domains {listed} in '{name}' share the word '{w}' - no two sub-domains in a "
                    "domain may share a word (DOM-RUL-024)."
                ))

    for entries in homes.values():
        idxs = list(dict.fromkeys(di for di, _ in entries))
        if len(idxs) > 1:
            where = ", ".join(domains[di][1] for di in idxs)
            out.append(_warn("DOM-RUL-040", idxs,
                f"Sub-domain name '{entries[0][1]}' appears in more than one domain ({where}) - every "
                "sub-domain name must be unique across the model (DOM-RUL-040)."
            ))

    if len(domains) < MIN_DOMAINS:
        out.append(_err("DOM-RUL-032", [],
            f"A taxonomy needs at least {MIN_DOMAINS} domains (DOM-RUL-032); this one has {len(domains)}."
        ))
    return out
