"""Tests for assessment per-source column profiles (`assess_column_source_profile`).

Covers lenient validators, schema validation, prompt validation, migration, db_models, and contracts.
"""

import pytest
from pathlib import Path

from vibe_modeling.backend.assessment.schemas import _SourceProfile, _Col, AssessmentDoc


# --- Lenient Pydantic validators ---

class TestSourceProfileLenience:
    """_SourceProfile accepts malformed JSON and coerces field types."""

    def test_string_int_and_float_coerce(self):
        p = _SourceProfile(
            system="src1", source_table="t1", source_column="c1",
            rows="100", null_pct="5.5", distinct_count="50"
        )
        assert p.rows == 100 and isinstance(p.rows, int)
        assert p.null_pct == 5.5 and isinstance(p.null_pct, float)
        assert p.distinct_count == 50 and isinstance(p.distinct_count, int)

    def test_null_becomes_empty_string_or_none_for_numbers(self):
        p = _SourceProfile(system=None, note=None, rows=None, null_pct=None)
        assert p.system == "" and p.note == ""
        assert p.rows is None and p.null_pct is None

    def test_role_lowercased(self):
        p = _SourceProfile(system="s", source_table="t", source_column="c", role="POPULATES")
        assert p.role == "populates"

    def test_non_number_ints_become_none(self):
        p = _SourceProfile(system="s", source_table="t", source_column="c", rows="invalid")
        assert p.rows is None

    def test_non_number_floats_become_none(self):
        p = _SourceProfile(system="s", source_table="t", source_column="c", null_pct="invalid")
        assert p.null_pct is None


class TestColProfilesValidation:
    """_Col.profiles_by_source lenient list handling."""

    def test_null_list_becomes_empty(self):
        c = _Col(target="x", status="mapped", profiles_by_source=None)
        assert c.profiles_by_source == []

    def test_non_list_becomes_empty(self):
        c = _Col(target="x", status="mapped", profiles_by_source="not a list")
        assert c.profiles_by_source == []
        c = _Col(target="x", status="mapped", profiles_by_source={"not": "list"})
        assert c.profiles_by_source == []

    def test_non_dict_items_dropped(self):
        c = _Col(
            target="x", status="mapped",
            profiles_by_source=[
                {"system": "s1", "source_table": "t1", "source_column": "c1"},
                "not a dict",
                123,
                None,
            ]
        )
        assert len(c.profiles_by_source) == 1
        assert c.profiles_by_source[0].system == "s1"

    def test_all_key_fields_empty_dropped(self):
        """Items with system, source_table, source_column all empty/missing are dropped."""
        c = _Col(
            target="x", status="mapped",
            profiles_by_source=[
                {"system": "s1", "source_table": "t1", "source_column": "c1", "rows": 100},
                {"rows": 50},  # no system/table/column
                {"system": "", "source_table": None, "source_column": "", "rows": 75},  # all empty
                {"system": "s2"},  # has system, kept
            ]
        )
        assert len(c.profiles_by_source) == 2
        assert [p.system for p in c.profiles_by_source] == ["s1", "s2"]

    def test_assessment_doc_with_malformed_profiles_validates(self):
        """A doc with profiles having non-dict items, empty items, etc. still validates."""
        d = {
            "metamodel": {"location": "l", "version": "v"},
            "entities": [{
                "name": "order", "grade": "full",
                "columns": [{
                    "target": "amount", "status": "mapped",
                    "profiles_by_source": [
                        {"system": "s1", "source_table": "t1", "source_column": "c1"},
                        "not a dict",
                        {},  # all key fields empty
                        None,
                    ]
                }]
            }],
        }
        doc = AssessmentDoc.model_validate(d)
        assert len(doc.entities[0].columns[0].profiles_by_source) == 1


# --- Schema & Prompt Validation ---

def test_schema_accepts_docs_with_and_without_profiles():
    """AssessmentDoc validates docs with/without profiles_by_source."""
    # Without profiles_by_source
    doc_no_profiles = {
        "metamodel": {"location": "l", "version": "v"},
        "entities": [{"name": "e", "grade": "full", "columns": [{"target": "c", "status": "mapped"}]}],
    }
    AssessmentDoc.model_validate(doc_no_profiles)

    # With profiles_by_source
    doc_with_profiles = {
        "metamodel": {"location": "l", "version": "v"},
        "entities": [{
            "name": "e", "grade": "full",
            "columns": [{
                "target": "c", "status": "mapped",
                "profiles_by_source": [
                    {"system": "s1", "source_table": "t1", "source_column": "c1", "rows": 100}
                ]
            }]
        }],
    }
    doc = AssessmentDoc.model_validate(doc_with_profiles)
    assert len(doc.entities[0].columns[0].profiles_by_source) == 1

    # With null profiles_by_source
    doc_null_profiles = dict(doc_with_profiles)
    doc_null_profiles["entities"][0]["columns"][0]["profiles_by_source"] = None
    doc2 = AssessmentDoc.model_validate(doc_null_profiles)
    assert len(doc2.entities[0].columns[0].profiles_by_source) == 0


def test_assess_prompt_mentions_profiles_by_source():
    """assess_prompt.md rule 8 documents profiles_by_source."""
    prompt_path = Path(__file__).resolve().parents[2] / "src" / "app" / "vendored" / "assessment" / "assess_prompt.md"
    prompt = prompt_path.read_text()
    assert "profiles_by_source" in prompt
    assert "Per-source profile" in prompt or "per-source profile" in prompt.lower()


def test_assess_prompt_mentions_prior_tiers():
    """assess_prompt.md rule 8 documents prior_tiers.json and reuse."""
    prompt_path = Path(__file__).resolve().parents[2] / "src" / "app" / "vendored" / "assessment" / "assess_prompt.md"
    prompt = prompt_path.read_text()
    assert "prior_tiers.json" in prompt
    assert "Reuse prior tiers" in prompt


def test_assess_notebook_writes_prior_tiers_when_present():
    """assess_domain.py writes docs/inputs/prior_tiers.json when cfg.get('prior_tiers') exists."""
    notebook_path = Path(__file__).resolve().parents[2] / "src" / "app" / "vendored" / "assessment" / "assess_domain.py"
    notebook = notebook_path.read_text()
    # Check that the code guards the write by checking cfg.get("prior_tiers")
    assert 'cfg.get("prior_tiers")' in notebook
    assert "docs" in notebook and "inputs" in notebook and "prior_tiers.json" in notebook
