"""Behavioral tests for v2.9.9 VREQ-explosion root-cause fix (user audit 2026-06-01).

Root cause: an 848-line next_vibes whose Section 1 listed 556 products under a single
'preserve every domain/product' directive was atomised by EXTRACTION_SYSTEM_PROMPT into 556
separate critical 'preserve <d>.<p>' VREQs (the one-VREQ-per-name rule). Those VREQs are
redundant with the structural pinning that already preserves them, so they wasted the apply
budget. v2.9.9 adds:
  FIX-1A  EXTRACTION_SYSTEM_PROMPT EXCEPTION (a bare preservation name-list is ONE VREQ).
  FIX-1B  deterministic _v299_collapse_preservation_vreqs guard that collapses preservation-only
          VREQs into ONE granularity=all VREQ.
  FIX-2   apply-loop batch cap 10 -> 25.

Since v5.3.3 an LLM classifier reads every requirement and the guard acts only on the spec it
returns: a VREQ is preservation-only iff its registered spec has action "preserve". These tests
register the spec the classifier would return and drive the REAL notebook helpers through
agent_helpers; the wording of a VREQ never decides anything. PRE-PATCH the guard did not exist,
so the 556-VREQ degenerate input below would pass through un-collapsed (per CLAUDE.md 8.10).
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

SRC = notebook_concat_source()
MODEL = {"model": {"domains": []}}
is_preservation_only = ah._v299_is_preservation_only
collapse = ah._v299_collapse_preservation_vreqs


class _Log:
    def __init__(self):
        self.lines = []

    def info(self, msg, *a, **k):
        self.lines.append(str(msg))


def _v(vid, intent, target, sev="critical", user=False, prio=9999):
    return ah.RawVREQ(vreq_id=vid, intent=intent, target=target, source_quote=f"  - {target}", source_chunk_id="c0",
                      severity=sev, is_user_directive=user, priority_id=prio)


def _preserve(vid, *targets):
    return vs.spec(vid, "preserve", targets)


def _add_column(vid, target):
    return vs.spec(vid, "add_column", [target], columns=[{"name": "added_note", "type": "STRING"}])


def _preserved(n):
    vs.register(ah, MODEL, *[_preserve(f"P{i}", f"d.p{i}") for i in range(n)])
    return [_v(f"P{i}", f"Preserve product d.p{i}", f"d.p{i}") for i in range(n)]


# --- FIX-1B detection: preservation-only vs substantive --------------------

def test_pure_preserve_is_preservation_only():
    vs.register(ah, MODEL, _preserve("V1", "patient.demographics"), _preserve("V2", "support"), _preserve("V3", "billing"),
                _preserve("V4", "encounter.visit"))
    assert is_preservation_only(_v("V1", "Preserve product patient.demographics", "patient.demographics"))
    assert is_preservation_only(_v("V2", "Keep domain support in the model", "support"))
    assert is_preservation_only(_v("V3", "Do not remove domain billing", "billing"))
    assert is_preservation_only(_v("V4", "Product encounter.visit must exist in v2", "encounter.visit"))
    assert is_preservation_only(_v("V4#oos", "Product encounter.visit must exist in v2", "encounter.visit"))
    assert not is_preservation_only(_v("V0", "Preserve product patient.encounter", "patient.encounter")), \
        "a VREQ the classifier has not read is never preservation-only"


def test_substantive_vreq_is_NOT_preservation_only():
    vs.register(ah, MODEL,
                vs.spec("V5", "add_column", ["patient.program_enrollment"], columns=[{"name": "enrollment_status", "type": "STRING"}]),
                vs.spec("V6", "rename_product", ["x.foo"], new_name="bar"),
                vs.spec("V7", "add_fk", ["claim.status_history.claim_id"], fk_target="claim.claim.claim_id"),
                vs.spec("V8", "add_column", ["supply.location_audit"], columns=[{"name": "audited_at", "type": "TIMESTAMP"}]),
                vs.spec("V9", "retype_column", ["finance.invoice.total"], column_type="DECIMAL(18,2)"),
                vs.spec("V10", "set_fields", [], breadth="model", fields=[vs.field("attributes", "description")]))
    substantive = [
        _v("V5", "Add core attributes to patient.program_enrollment", "patient.program_enrollment"),
        _v("V6", "Rename product foo to bar", "x.foo"),
        _v("V7", "Link claim.status_history.claim_id as FK to claim.claim", "claim.status_history"),
        _v("V8", "Expand thin product supply.location_audit", "supply.location_audit"),
        _v("V9", "Set the type of finance.invoice.total to DECIMAL", "finance.invoice.total"),
        _v("V10", "Add a business-justification comment to every attribute", "all"),
    ]
    for vreq in substantive:
        assert ah.vreq_spec(vreq)["interpretable"], vreq.vreq_id
        assert not is_preservation_only(vreq), f"{vreq.vreq_id} changes the model and must never be collapsed"


def test_preservation_is_read_from_the_spec_never_from_the_wording():
    vs.register(ah, MODEL, _add_column("W1", "patient.demographics"), _preserve("W2", "patient.program_enrollment"),
                vs.spec("W3", "preserve", ["d.p3"], interpretable=False, reason="two readings"),
                vs.spec("W4", "preserve", ["d.p4"], kind="documentation"))
    assert not is_preservation_only(_v("W1", "Preserve product patient.demographics", "patient.demographics"))
    assert is_preservation_only(_v("W2", "Add core attributes to patient.program_enrollment", "patient.program_enrollment"))
    unread = [_v("W3", "Preserve product d.p3", "d.p3"), _v("W4", "Preserve product d.p4", "d.p4"),
              _v("W5", "Preserve product d.p5", "d.p5")]
    assert not any(is_preservation_only(v) for v in unread)
    out = collapse(unread + [_v("W1", "Preserve product patient.demographics", "patient.demographics")])
    assert [v.vreq_id for v in out] == ["W3", "W4", "W5", "W1"], "preservation wording alone must never collapse"
    assert ah.vreq_spec("V299-PRESERVE-ALL") is None


# --- FIX-1B collapse behaviour ---------------------------------------------

def test_many_preserve_vreqs_collapse_to_one():
    log = _Log()
    out = collapse(_preserved(556), log)
    assert len(out) == 1, f"556 preservation VREQs must collapse to 1, got {len(out)}"
    assert out[0].vreq_id == "V299-PRESERVE-ALL"
    assert out[0].severity == "critical"
    assert "556" in out[0].intent
    assert len(ah.vreq_spec(out[0])["targets"]) == 556
    assert any("[vov-collapse-preserve FIRED" in line and "collapsed 556 " in line and "backlog 556 -> 1" in line for line in log.lines)


def test_collapse_preserves_substantive_vreqs_untouched():
    preserve = _preserved(10)
    vs.register(ah, MODEL, _add_column("S1", "a.b"), vs.spec("S2", "add_fk", ["x.y.z_id"], fk_target="x.w.w_id"))
    s1 = _v("S1", "Add core attributes to a.b", "a.b")
    s2 = _v("S2", "Link x.y.z_id FK to x.w", "x.y")
    out = collapse([s1] + preserve[:5] + [s2] + preserve[5:])
    assert len(out) == 3, f"expected 2 substantive + 1 collapsed = 3, got {len(out)}"
    assert out[0] is s1 and out[1] is s2, "substantive VREQs must survive collapse unchanged and in order (recall preserved)"
    assert out[2].vreq_id == "V299-PRESERVE-ALL"


def test_single_preserve_vreq_is_not_collapsed():
    one = _preserved(1)
    vs.register(ah, MODEL, _add_column("S1", "a.b"))
    mixed = one + [_v("S1", "Add core attributes to a.b", "a.b")]
    out = collapse(one)
    assert len(out) == 1 and out[0] is one[0], "a lone preservation VREQ must pass through unchanged"
    assert collapse(mixed) == mixed
    assert ah.vreq_spec("V299-PRESERVE-ALL") is None, "nothing collapsed, so no collapsed spec is registered"


def test_collapse_carries_user_directive_flag_and_min_priority():
    vs.register(ah, MODEL, _preserve("P0", "d.p0"), _preserve("P1", "d.p1"), _preserve("P2", "d.p2"))
    auto_low = _v("P0", "Preserve product d.p0", "d.p0", prio=7)
    user = _v("P1", "Preserve product d.p1", "d.p1", user=True, prio=3)
    auto = _v("P2", "Preserve product d.p2", "d.p2")
    out = collapse([auto_low, user, auto])
    assert len(out) == 1
    assert out[0].is_user_directive is True, "collapsed VREQ inherits user-directive if any source was user"
    assert out[0].priority_id == 3, "collapsed VREQ keeps the strongest (lowest) priority_id"
    no_user = collapse([auto_low, auto])
    assert no_user[0].is_user_directive is False, "without a user source the collapsed VREQ claims no user authority"
    assert no_user[0].priority_id == 7


def test_the_collapsed_requirement_preserves_the_union_of_its_sources_targets():
    vs.register(ah, MODEL, _preserve("P0", "d.p0"), _preserve("P1", "support"), _preserve("P2", "d.p0", "e.q"), _add_column("S1", "a.b"))
    out = collapse([_v("P0", "Preserve product d.p0", "d.p0"), _v("S1", "Add core attributes to a.b", "a.b"),
                    _v("P1", "Keep domain support", "support"), _v("P2", "Preserve d.p0 and e.q", "d.p0, e.q")])
    assert [v.vreq_id for v in out] == ["S1", "V299-PRESERVE-ALL"]
    spec = ah.vreq_spec(out[-1])
    assert spec["action"] == "preserve" and spec["interpretable"] and spec["kind"] == "model"
    assert spec["targets"] == [{"domain": "d", "product": "p0", "column": ""}, {"domain": "support", "product": "", "column": ""},
                               {"domain": "e", "product": "q", "column": ""}]
    assert is_preservation_only(out[-1]) and collapse(out) == out, "a second pass never re-collapses or expands the collapsed VREQ"


def test_empty_input_is_safe():
    assert collapse([]) == []


# --- FIX-1A + FIX-2 wiring (static contract) -------------------------------

def test_extraction_prompt_has_preservation_exception():
    assert "EXCEPTION - STRUCTURE-PRESERVATION" in SRC
    assert "vov-collapse-preserve" in SRC


def test_collapse_is_wired_before_the_sort():
    assert "_v299_collapse_preservation_vreqs(list(deduped), logger)" in SRC, \
        "collapse must run on deduped before _v296_sort_vreqs"


def test_batch_cap_raised_to_25():
    assert "_max_per_call=25))" in SRC, "FIX-2 must raise the apply-loop batch cap to 25"
    assert "_max_per_call=10))" not in SRC, "no apply-loop call site may keep the old cap of 10"
