import pytest
from vibe_modeling.backend.assessment.grading import letter_grade, enrichment_pct

@pytest.mark.parametrize("gate,cs,ct,es,et,want", [
    ("full", 9, 9, 75, 100, "A"), ("full", 9, 9, 749, 1000, "B"), ("full", 9, 9, 25, 100, "B"),
    ("full", 9, 9, 249, 1000, "C"), ("full", 9, 9, 0, 0, "A"),
    ("partial", 9, 9, 10, 31, "C"), ("partial", 8, 9, 31, 31, "D"),
    ("blocked", 0, 9, 0, 31, "F"), ("blocked", None, None, None, None, "F"),
    ("full", None, None, None, None, None), ("FULL", 9, 9, 80, 100, "A"),
])
def test_letter_grade(gate, cs, ct, es, et, want):
    assert letter_grade(gate, core_sourced=cs, core_total=ct, enrichment_sourced=es, enrichment_total=et) == want

@pytest.mark.parametrize("es,et,want", [(749, 1000, "B"), (7499, 10000, "B"), (75, 100, "A"), (2499, 10000, "C")])
def test_letter_uses_unrounded_pct(es, et, want):
    assert letter_grade("full", core_sourced=9, core_total=9, enrichment_sourced=es, enrichment_total=et) == want

def test_counts_clamped_when_model_overreports():
    assert enrichment_pct(40, 31) == 100.0
    assert letter_grade("partial", core_sourced=10, core_total=9, enrichment_sourced=1, enrichment_total=1) == "C"

def test_enrichment_pct_none_when_unknown():
    assert enrichment_pct(None, 5) is None and enrichment_pct(0, 0) == 100.0


# --- Structure axis (spec 2026-10-13 assessment-structure-grade) ---
from vibe_modeling.backend.assessment.grading import (  # noqa: E402
    DecisionFacts, VibeFacts, classify_decision_kind, structure_grade)


def _d(ordinal=0, kind="structure", open_=True, blocks=False, entity="tariff_rider", affected=()):
    return DecisionFacts(ordinal=ordinal, kind=kind, is_open=open_, blocks_build=blocks, entity=entity,
                         affected=tuple(affected))


@pytest.mark.parametrize("gate,want", [
    ("Phase 2C model completeness", "structure"), ("emerge from data", "scope"), ("Affixed", "scope"), ("Step 2.7 grain assertion", "structure"),
    ("cardinality of rider", "structure"), ("FK direction", "structure"), ("Bridge table", "structure"),
    ("entity split", "structure"), ("merge candidates", "structure"),
    ("source-process fit", "source"), ("Proxy source", "source"), ("missing ingestion", "source"),
    ("Source ownership", "source"), ("cross-domain governance", "scope"), ("", "scope"), (None, "scope"),
])
def test_classify_decision_kind_fallback(gate, want):
    assert classify_decision_kind(gate) == want


def test_structure_sound_without_decisions():
    assert structure_grade("tariff_rider", [], []) == ("sound", [], [])


def test_structure_rework_open_blocking_structure_decision():
    r = structure_grade("tariff_rider", [_d(ordinal=2, blocks=True), _d(ordinal=0)], [])
    assert r == ("rework", ["D3"], [])


def test_structure_review_nonblocking_decision():
    assert structure_grade("tariff_rider", [_d(ordinal=3)], []) == ("review", ["D4"], [])


def test_structure_answered_decision_does_not_count():
    assert structure_grade("tariff_rider", [_d(open_=False, blocks=True)], []) == ("sound", [], [])


def test_structure_source_and_scope_kinds_ignored():
    ds = [_d(kind="source", blocks=True), _d(kind="scope", blocks=True)]
    assert structure_grade("tariff_rider", ds, []) == ("sound", [], [])


def test_structure_affected_entity_matches_case_insensitively():
    d = _d(entity="other", blocks=True, affected=["Tariff_Rider"])
    assert structure_grade("tariff_rider", [d], []) == ("rework", ["D1"], [])


def test_structure_other_entity_not_matched():
    assert structure_grade("tariff_rider", [_d(entity="payment", blocks=True)], []) == ("sound", [], [])


def test_structure_before_build_vibe_makes_review():
    v = VibeFacts(priority=2, urgency="before_build", affected_entities=("tariff_rider",))
    assert structure_grade("tariff_rider", [], [v]) == ("review", [], ["Vibe 2"])


def test_structure_later_vibe_ignored():
    v = VibeFacts(priority=2, urgency="later", affected_entities=("tariff_rider",))
    assert structure_grade("tariff_rider", [], [v]) == ("sound", [], [])


def test_structure_rework_beats_review():
    v = VibeFacts(priority=1, urgency="before_build", affected_entities=("tariff_rider",))
    assert structure_grade("tariff_rider", [_d(blocks=True)], [v])[0] == "rework"


@pytest.mark.parametrize("ref", ["mvm_ecm_metertocash.bill", " bill ", "bill, payment", "payment; bill",
                                 "payment and bill", "bill.service_agreement_id", "Bill"])
def test_structure_entity_reference_shapes_match(ref):
    assert structure_grade("bill", [_d(entity=ref, blocks=True)], []) == ("rework", ["D1"], [])
    assert structure_grade("bill", [_d(entity="x", affected=[ref])], [])[0] == "review"
    v = VibeFacts(priority=1, urgency="before_build", affected_entities=(ref,))
    assert structure_grade("bill", [], [v]) == ("review", [], ["Vibe 1"])


def test_structure_non_entity_reference_touches_nothing():
    d = _d(entity="cross-domain", blocks=True)  # "Phase 2C completeness . Entity: cross-domain"
    assert classify_decision_kind("Phase 2C completeness") == "structure"
    assert structure_grade("bill", [d], []) == ("sound", [], [])


def test_structure_unprioritized_vibe_ref_uses_ordinal():
    v = VibeFacts(priority=None, urgency="before_build", affected_entities=("bill",), ordinal=3)
    assert structure_grade("bill", [], [v]) == ("review", [], ["Vibe 4"])
