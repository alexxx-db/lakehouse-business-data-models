"""Behavioral tests for v2.9.8 severity-calibration root-cause fix (user audit 2026-06-01).

Root cause: the extractor labelled ~92% of VREQs 'critical' (healthcare 2891/3136), so the
existing severity-first ordering + defer-low-severity tail were DEFEATED. v2.9.8 adds
_v298_recalibrate_severity (alias=vov-severity-calibrate) which re-derives severity from the
requirement's LLM spec (v5.3.3; never from its text), independent of the (inflated) LLM label.

These tests exercise the REAL production helpers through agent_helpers and assert the
OBSERVABLE flip (cosmetic critical->low, structural medium->critical), per CLAUDE.md 8.10. The
PRE-PATCH behaviour was "trust the LLM label verbatim", so on the degenerate input below the
cosmetic VREQs would stay 'critical' -> these assertions FAIL on pre-patch HEAD.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

SRC = notebook_concat_source()
MODEL = {"model": {"domains": []}}


def _vreq(vid, severity, intent="any wording"):
    return ah.RawVREQ(vreq_id=vid, intent=intent, target="", source_quote=intent, source_chunk_id="C1", severity=severity)


def _recalibrate(spec, severity):
    vs.register(ah, MODEL, spec)
    return ah._v298_recalibrate_severity(_vreq(spec["id"], severity))


# --- FIX-B: deterministic guard flips on real degenerate input --------------

def test_cosmetic_comment_vreq_downranked_to_low_even_when_llm_says_critical():
    # healthcare VREQ-054 class: "Every attribute must include a business-justification comment".
    comment = vs.spec("VREQ-054", "set_fields", breadth="model", fields=[vs.field("attributes", "description")])
    assert _recalibrate(comment, "critical") == "low"
    tagged = dict(comment, fields=[vs.field("attributes", "description"), vs.field("attributes", "tags")])
    assert _recalibrate(tagged, "critical") == "critical"


def test_description_add_downranked():
    spec = vs.spec("V1", "set_fields", ["finance.invoice.total"], fields=[vs.field("attributes", "description")])
    assert _recalibrate(spec, "high") == "low"
    glossary = dict(spec, fields=[vs.field("attributes", "business_glossary_term")])
    assert _recalibrate(glossary, "high") == "high"


def test_nonkey_rename_downranked_to_low():
    # healthcare VREQ-038 class: rename a non-key column for canonical naming (SOFT per 3a-bis).
    column = vs.spec("VREQ-038", "rename_column", ["consent.workflow.superseded_note"], new_name="supersession_note")
    assert _recalibrate(column, "critical") == "low"
    table = vs.spec("VREQ-039", "rename_product", ["consent.workflow"], new_name="consent_workflow")
    assert _recalibrate(table, "critical") == "low"


def test_structural_fk_uppranked_to_critical_even_when_llm_says_low():
    spec = vs.spec("V1", "add_fk", ["booking.booking.flight_leg_id"], fk_target="flight.flight_leg.flight_leg_id")
    assert _recalibrate(spec, "low") == "critical"
    assert _recalibrate(dict(spec, kind="tooling"), "low") == "low"
    ah.vov_ledger_reset()
    assert ah._v298_recalibrate_severity(_vreq("V1", "low", "Add the missing foreign key from booking to flight_leg")) == "low"


def test_ssot_duplicate_uppranked():
    spec = vs.spec("V1", "merge_products", ["patient.mpi_record"], merge_into="patient.patient")
    assert _recalibrate(spec, "medium") == "critical"
    assert _recalibrate(dict(spec, interpretable=False, reason="two readings"), "medium") == "medium"


def test_cycle_uppranked():
    for action in ("remove_fk", "reverse_fk"):
        assert _recalibrate(vs.spec("V1", action, ["order.order.shipment_id"]), "medium") == "critical", action
    assert _recalibrate(vs.spec("V1", "check_only", ["order.order"]), "medium") == "medium"


def test_add_new_attribute_is_NOT_downranked():
    spec = vs.spec("V1", "add_column", ["flight.aircraft"], columns=[{"name": "aircraft_tail_number", "type": "STRING"}])
    assert _recalibrate(spec, "high") == "high"


def test_rename_touching_key_keeps_llm_severity():
    assert _recalibrate(vs.spec("V1", "rename_column", ["x.y.y_id"], new_name="y_key"), "high") == "high"
    fk_column = vs.spec("V2", "rename_column", ["consent.workflow.superseded_by_workflow_id"], new_name="superseded_by_consent_workflow_id")
    assert _recalibrate(fk_column, "critical") == "critical"


def test_neutral_vreq_keeps_deinflated_llm_label():
    spec = vs.spec("V1", "retype_column", ["x.y.amount"], column_type="DECIMAL(18,2)")
    assert _recalibrate(spec, "medium") == "medium"


# --- sort chokepoint persists the recalibrated severity ---------------------

def test_sort_chokepoint_recalibrates_and_persists():
    vs.register(ah, MODEL, vs.spec("V1", "set_fields", breadth="model", fields=[vs.field("attributes", "description")]),
                vs.spec("V2", "add_fk", ["x.y.z_id"], fk_target="x.z.z_id"))
    cosmetic = _vreq("V1", "critical", "Add a business-justification comment to every attribute")
    structural = _vreq("V2", "low", "Add the missing foreign key that orphans the table")
    unread = _vreq("V3", "high", "Add the missing foreign key on another table")
    ordered = ah._v296_sort_vreqs([cosmetic, unread, structural])
    assert [v.vreq_id for v in ordered] == ["V2", "V3", "V1"]
    assert [v.severity for v in ordered] == ["critical", "high", "low"]


def test_agent_version_is_298_or_higher():
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([0-9]+)\.([0-9]+)\.([0-9]+)"', SRC)
    assert m, "agent version constant not found"
    major, minor, patch = (int(g) for g in m.groups())
    assert (major, minor, patch) >= (2, 9, 8), f"expected >= 2.9.8, got {m.group(0)}"
