"""assessment.json output contract: richer optional fields, lenient normalization, old shape still valid."""
import json
import pathlib

import jsonschema

from vibe_modeling.backend.assessment.schemas import AssessmentDoc

ROOT = pathlib.Path(__file__).parents[2]
SCHEMA = json.loads((ROOT / "src/app/vendored/assessment/assessment.schema.json").read_text())
OLD = json.loads((ROOT / "tests/fixtures/assessment/assessment.json").read_text())


def _new_doc():
    d = json.loads(json.dumps(OLD))
    d["executive_summary"] = {"headline": "Buildable with gaps", "verdict": "Iterate_First", "verdict_reason": "r",
                              "key_findings": ["k1"], "top_risks": ["r1"], "recommended_next_step": "s"}
    e = d["entities"][0]
    e.update(core_sourced=9, core_total=9, enrichment_sourced=14, enrichment_total=31, deferred_fk_count=2,
             grade_reason="why", row_filter="type='E'", letter_grade="b")
    e["columns"][0]["tier"] = "Deferred FK"
    d["pending_decisions"][0]["options"] = [{"label": "Keep", "pros": ["p"], "cons": ["c"], "impact": "i"}, "Drop"]
    d["pending_decisions"][0].update(context="c", why_it_matters="w", recommended_option="Keep",
                                     recommendation_rationale="r", blocks_build=True, affected=[{"entity": "bill"}])
    d["next_vibes"][0].update(problem="p", proposed_change="c", impact_if_skipped="i", urgency="before build",
                              affected_entities=["bill"])
    return d


def test_old_shape_still_validates_against_schema_and_model():
    jsonschema.validate(OLD, SCHEMA)
    AssessmentDoc.model_validate(OLD)


def test_new_shape_validates_and_normalizes():
    d = _new_doc()
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.executive_summary.verdict == "iterate_first"
    assert doc.entities[0].letter_grade == "B" and doc.entities[0].columns[0].tier == "deferred_fk"
    assert [o.label for o in doc.pending_decisions[0].options] == ["Keep", "Drop"]
    assert doc.next_vibes[0].urgency == "before_build"


def test_off_values_are_dropped_not_rejected():
    d = _new_doc()
    d["entities"][0]["columns"][0]["tier"] = "primary"
    d["next_vibes"][0]["urgency"] = "now"
    d["executive_summary"]["verdict"] = "maybe"
    d["entities"][0]["letter_grade"] = "A+"
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.entities[0].columns[0].tier is None and doc.next_vibes[0].urgency is None
    assert doc.executive_summary.verdict is None and doc.entities[0].letter_grade is None


def test_letter_e_is_not_a_grade():
    d = _new_doc()
    d["entities"][0]["letter_grade"] = "E"
    assert AssessmentDoc.model_validate(d).entities[0].letter_grade is None


def test_wrong_typed_optional_fields_coerce_per_field():
    d = _new_doc()
    d["executive_summary"].update(key_findings="one finding", top_risks=["a", 2])
    e = d["entities"][0]
    e.update(core_sourced="9", core_total="n/a", enrichment_sourced="14", enrichment_total=31.0,
             deferred_fk_count=None)
    dec = d["pending_decisions"][0]
    dec.update(blocks_build="Yes", affected=["bill.amount", {"entity": "cust", "column": "id"}, "plain"])
    dec["options"] = [{"label": "Keep", "pros": "single pro", "cons": None}, {"pros": ["no label"]}, "Drop"]
    d["next_vibes"][0]["affected_entities"] = "bill"
    d["pending_decisions"][0]["recommended_option"] = "Keep"
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.executive_summary.key_findings == ["one finding"] and doc.executive_summary.top_risks == ["a", "2"]
    ent = doc.entities[0]
    assert (ent.core_sourced, ent.core_total, ent.enrichment_sourced, ent.enrichment_total,
            ent.deferred_fk_count) == (9, None, 14, 31, None)
    pd = doc.pending_decisions[0]
    assert pd.blocks_build is True
    assert [(a.entity, a.column) for a in pd.affected] == [("bill", "amount"), ("cust", "id"), ("plain", "")]
    assert [o.label for o in pd.options] == ["Keep", "Drop"]
    assert pd.options[0].pros == ["single pro"] and pd.options[0].cons == []
    assert doc.next_vibes[0].affected_entities == ["bill"]


def test_blocks_build_garbage_is_false():
    d = _new_doc()
    d["pending_decisions"][0]["blocks_build"] = "maybe"
    jsonschema.validate(d, SCHEMA)
    assert AssessmentDoc.model_validate(d).pending_decisions[0].blocks_build is False


def test_blocks_build_accepts_null_and_numbers():
    for raw, want in [(None, False), (1, True), (0, False), (1.0, True)]:
        d = _new_doc()
        d["pending_decisions"][0]["blocks_build"] = raw
        jsonschema.validate(d, SCHEMA)
        assert AssessmentDoc.model_validate(d).pending_decisions[0].blocks_build is want


def test_affected_null_column_and_non_iterable_inputs():
    d = _new_doc()
    d["pending_decisions"][0]["affected"] = [{"entity": "bill", "column": None}]
    jsonschema.validate(d, SCHEMA)
    assert [(a.entity, a.column) for a in AssessmentDoc.model_validate(d).pending_decisions[0].affected] == [("bill", "")]
    # non-iterables never raise TypeError in the lenient validators
    d = _new_doc()
    d["pending_decisions"][0]["affected"] = 5
    d["next_vibes"][0]["affected_entities"] = 7
    doc = AssessmentDoc.model_validate(d)
    assert doc.pending_decisions[0].affected == []
    assert doc.next_vibes[0].affected_entities == ["7"]
    d = _new_doc()
    d["next_vibes"][0]["affected_entities"] = {"a": 1}
    assert AssessmentDoc.model_validate(d).next_vibes[0].affected_entities == ["a"]


def null_doc():
    """_new_doc with every new optional field explicitly null (Genie may write `"row_filter": null`)."""
    d = _new_doc()
    d["executive_summary"] = {k: None for k in ("headline", "verdict", "verdict_reason", "key_findings", "top_risks",
                                                "recommended_next_step")}
    e = d["entities"][0]
    e.update(letter_grade=None, grade_reason=None, row_filter=None)
    for c in e["columns"]:
        c["tier"] = None
    for dec in d["pending_decisions"]:
        dec.update(context=None, why_it_matters=None, recommended_option=None, recommendation_rationale=None,
                   affected=None)
        dec["options"] = [{"label": "Keep", "pros": None, "cons": None, "impact": None}]
    for v in d["next_vibes"]:
        v.update(problem=None, proposed_change=None, impact_if_skipped=None, urgency=None, affected_entities=None)
    return d


def test_all_new_fields_null_validates_schema_and_model():
    d = null_doc()
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.entities[0].row_filter == "" and doc.entities[0].grade_reason == "" and doc.entities[0].letter_grade is None
    assert doc.executive_summary.headline == "" and doc.executive_summary.verdict is None
    assert doc.pending_decisions[0].context == "" and doc.pending_decisions[0].options[0].impact == ""
    assert doc.next_vibes[0].problem == "" and doc.next_vibes[0].urgency is None


def test_executive_summary_null_is_none():
    d = _new_doc()
    d["executive_summary"] = None
    jsonschema.validate(d, SCHEMA)
    assert AssessmentDoc.model_validate(d).executive_summary is None


# --- structure axis: decision kind + reported structure ---

def test_structure_fields_normalize_leniently():
    d = _new_doc()
    d["pending_decisions"][0]["kind"] = " Structure "
    d["entities"][0]["structure"] = "Rework"
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.pending_decisions[0].kind == "structure" and doc.entities[0].structure == "rework"


def test_structure_fields_off_values_and_null_become_none():
    d = _new_doc()
    d["pending_decisions"][0]["kind"] = "governance"
    d["entities"][0]["structure"] = None
    jsonschema.validate(d, SCHEMA)
    doc = AssessmentDoc.model_validate(d)
    assert doc.pending_decisions[0].kind is None and doc.entities[0].structure is None
    d["entities"][0]["structure"] = "meh"
    assert AssessmentDoc.model_validate(d).entities[0].structure is None


def test_old_shape_has_no_structure_fields():
    doc = AssessmentDoc.model_validate(OLD)
    assert doc.pending_decisions[0].kind is None and doc.entities[0].structure is None
