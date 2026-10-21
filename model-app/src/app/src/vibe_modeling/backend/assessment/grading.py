"""Deterministic letter grade over the skill's Full/Partial/Blocked gate (spec 2026-10-13 §1)."""
from __future__ import annotations

import re
from dataclasses import dataclass

SOURCED_STATUSES = frozenset({"mapped", "derived"})


def _raw_pct(sourced: int, total: int) -> float:
    return min(max(sourced, 0), total) / total * 100


def enrichment_pct(sourced: int | None, total: int | None) -> float | None:
    if sourced is None or total is None:
        return None
    if total <= 0:
        return 100.0
    return round(_raw_pct(sourced, total), 1)


def letter_grade(gate: str, *, core_sourced: int | None, core_total: int | None,
                 enrichment_sourced: int | None, enrichment_total: int | None) -> str | None:
    g = (gate or "").lower()
    if g == "blocked":
        return "F"
    if core_sourced is None or core_total is None:
        return None
    core_complete = core_sourced >= core_total
    if g == "partial":
        return "C" if core_complete else "D"
    if g != "full":
        return None
    if enrichment_sourced is None or enrichment_total is None:
        return None
    # Thresholds compare the UNROUNDED percentage (74.99 must stay B); rounding is display-only.
    pct = 100.0 if enrichment_total <= 0 else _raw_pct(enrichment_sourced, enrichment_total)
    return "A" if pct >= 75 else "B" if pct >= 25 else "C"


# --- Structure axis (spec 2026-10-13 assessment-structure-grade) -------------------------------------
# Mechanical, read-time: derived from open `structure` decisions and before-build vibes, never stored.

DECISION_KINDS = frozenset({"structure", "source", "scope"})
_STRUCTURE_GATE = re.compile(r"\b(grain\w*|cardinal\w*|fk|2c|completeness|bridge|split|merge)\b", re.I)
_SOURCE_GATE = re.compile(r"\b(source-process|proxy|ingest\w*|source ownership)\b", re.I)
_LIST_SPLIT = re.compile(r"[,;]|\band\b", re.I)


def _names(value: str | None) -> set[str]:
    """Every entity-name candidate in a free-text entity reference.

    Handles padding, comma/semicolon/"and" lists, and dotted forms (`schema.entity`, `entity.column`) by
    offering each dot segment, so an entity matches when its name equals any segment."""
    out: set[str] = set()
    for tok in _LIST_SPLIT.split(value or ""):
        out.update(seg.strip().casefold() for seg in tok.split(".") if seg.strip())
    return out


def classify_decision_kind(gate: str | None) -> str:
    """Fallback `kind` for decisions with none stored (old runs): classify the gate text."""
    g = gate or ""
    if _STRUCTURE_GATE.search(g):
        return "structure"
    if _SOURCE_GATE.search(g):
        return "source"
    return "scope"


@dataclass(frozen=True)
class DecisionFacts:
    ordinal: int
    kind: str  # effective kind (stored, or the gate-text fallback)
    is_open: bool
    blocks_build: bool
    entity: str
    affected: tuple[str, ...] = ()


@dataclass(frozen=True)
class VibeFacts:
    priority: int | None
    urgency: str
    affected_entities: tuple[str, ...] = ()
    ordinal: int = 0  # labels an unprioritized vibe as "Vibe {ordinal+1}"


def structure_grade(entity_name: str, decisions: list[DecisionFacts],
                    vibes: list[VibeFacts]) -> tuple[str, list[str], list[str]]:
    """(status, decision_refs, vibe_refs) for one entity; status is rework | review | sound.

    rework: an open blocking `structure` decision touches the entity. review: an open non-blocking one does,
    or a `before_build` vibe lists it. Decision refs are `D{ordinal+1}`; vibe refs are `Vibe {priority}`
    (`Vibe {ordinal+1}` when unprioritized). Entity references are normalized by `_names`, so a decision
    about something that is not one of the run's entities (e.g. "cross-domain") touches no entity."""
    name = (entity_name or "").strip().casefold()
    hits = [d for d in decisions
            if d.kind == "structure" and d.is_open
            and name in set().union(_names(d.entity), *(_names(a) for a in d.affected))]
    blocking = sorted(d.ordinal for d in hits if d.blocks_build)
    if blocking:
        return "rework", [f"D{o + 1}" for o in blocking], []
    soft = sorted(d.ordinal for d in hits)
    vs = [v for v in vibes
          if v.urgency == "before_build" and name in set().union(*(_names(e) for e in v.affected_entities))]
    vibe_refs = [f"Vibe {v.priority}" if v.priority is not None else f"Vibe {v.ordinal + 1}" for v in vs]
    if soft or vs:
        return "review", [f"D{o + 1}" for o in soft], vibe_refs
    return "sound", [], []
