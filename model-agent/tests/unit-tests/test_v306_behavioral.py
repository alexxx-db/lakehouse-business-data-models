"""v3.0.6 behavioral tests.

Covers the two v3.0.6 root-cause fixes from the construction ecm_v8 (2026-06-02) audit:

  Fix A (alias=v306-preserve-shortcircuit): pure-preservation VREQs must be detected
    and short-circuited to an 'applied' outcome instead of flowing through batch_vreqs ->
    _vov286_split_batches_by_budget where they exploded into 25 (B0058 tp=365) and
    orphan-rec (tp=241/161/143) per-product mutation sub-batches that noop/timeout.
    The SAFETY property under test: the gate that decides what gets short-circuited
    (_v299_is_preservation_only) must NEVER classify a transform/work VREQ as
    preservation-only (else real instructions are silently dropped -> adherence falls).

  Fix B (alias=v306-none-deref-hint): _v204_ast_class_hints must emit a NONE-DEREF
    retry preamble when a prior sandbox failure trace contains the AttributeError
    "'NoneType' object has no attribute 'lower'" (construction orphan-rec-0000__s5),
    and must NOT emit it when the trace is clean (non-tautology).
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
import test_v514_vibe_scope_vov_engine as E  # noqa: E402


class _FakeVReq:
    def __init__(self, intent="", target="", source_quote="", vreq_id="V1"):
        self.intent = intent
        self.target = target
        self.source_quote = source_quote
        self.vreq_id = vreq_id


# ---------------------------------------------------------------------------
# Fix A — preserve short-circuit gate safety
# ---------------------------------------------------------------------------

PRESERVE_SPECS = [
    vs.spec("V1", "preserve", ["clinical", "clinical.encounter"]),
    vs.spec("V2", "preserve", [], breadth="model"),
    vs.spec("V3", "preserve", ["billing.claim"]),
    vs.spec("V4", "preserve", ["facility.organization"]),
]


def test_preserve_detector_true_for_pure_preservation():
    vs.register(ah, {"model": {"domains": []}}, *PRESERVE_SPECS)
    for spec in PRESERVE_SPECS:
        assert ah._v299_is_preservation_only(_FakeVReq(vreq_id=spec["id"])), spec


def test_preserve_detector_false_for_transform_vreqs():
    """SAFETY: transform/work VREQs must NEVER be short-circuited.

    If any of these returned True, v306-preserve-shortcircuit would mark a real
    instruction 'applied' without doing the work -> silent adherence loss. This is
    the regression the gate must prevent.
    """
    tags = [vs.field("attributes", "tags")]
    transforms = [
        dict(vs.spec("T1", "set_fields", [], breadth="model", fields=tags), tags=[{"key": "pii_classification", "value": ""}]),
        dict(vs.spec("T2", "set_fields", ["clinical"], breadth="set", fields=tags), tags=[{"key": "cfr_42_part_2", "value": "true"}]),
        vs.spec("T3", "retype_column", ["billing.claim.amount_text"], column_type="DECIMAL"),
        vs.spec("T4", "add_fk", ["facility.organization.region_id"], fk_target="facility.region.region_id"),
        vs.spec("T5", "rename_column", ["billing.claim.id"], new_name="claim_id"),
        vs.spec("T6", "add_column", ["billing.claim"], columns=[{"name": "ibnr_reserve", "type": "DECIMAL(18,2)"}]),
        vs.spec("T7", "change_metric_view", ["revenue"], metric_views=["revpar"]),
        vs.spec("T8", "add_product", ["media.article", "media.segment"]),
        vs.spec("T9", "other", ["billing"], breadth="set"),
        dict(vs.spec("T10", "preserve", ["billing.claim"]), interpretable=False, reason="two readings"),
        vs.spec("T11", "preserve", ["billing.claim"], kind="documentation"),
    ]
    vs.register(ah, {"model": {"domains": []}}, *transforms)
    for spec in transforms:
        assert not ah._v299_is_preservation_only(_FakeVReq(vreq_id=spec["id"])), f"FALSE-POSITIVE on transform: {spec}"
    assert not ah._v299_is_preservation_only(_FakeVReq(vreq_id="NO-SPEC"))


def test_shortcircuit_applies_preservation_without_batching_it(monkeypatch):
    """The short-circuit fires inside _apply_batches_for_vreqs BEFORE batch_vreqs and
    emits an 'applied' VReqOutcome; a work VREQ in the same run is still batched."""
    vreqs = [ah.RawVREQ(vreq_id="VREQ-0001", intent="Preserve crew.member", target="crew.member", source_quote="Preserve crew.member",
                        source_chunk_id="c1", is_user_directive=True),
             ah.RawVREQ(vreq_id="VREQ-0002", intent="Describe crew.roster", target="crew.roster", source_quote="Describe crew.roster",
                        source_chunk_id="c1", is_user_directive=True)]
    monkeypatch.setitem(ah.__dict__, "extract_all", lambda *a, **k: list(vreqs))
    llm = E._CannedLLM(specs=[vs.spec("VREQ-0001", "preserve", ["crew.member"]),
                              vs.spec("VREQ-0002", "set_fields", ["crew.roster"], fields=[vs.field("products", "description")])])
    result = ah.run_vov_pipeline("Preserve crew.member\nDescribe crew.roster\n", E._engine(), llm, [], [], parallel=False,
                                 priority_reapply_loops=1)
    kept = [(o.batch_id, o.status, o.attempts) for o in result.outcomes if "VREQ-0001" in o.vreq_ids]
    assert kept == [("preserve-shortcircuit-VREQ-0001", "applied", 0)], kept
    work = [o for o in result.outcomes if "VREQ-0002" in o.vreq_ids]
    assert work and not any(o.batch_id.startswith("preserve-shortcircuit") for o in work), work
    batched = [v["vreq_id"] for system, user in llm.prompts if "group VREQs into BATCHES" in system for v in json.loads(user)["vreqs"]]
    assert "VREQ-0002" in batched and "VREQ-0001" not in batched, batched


# ---------------------------------------------------------------------------
# Fix B — None-deref retry hint
# ---------------------------------------------------------------------------

def test_none_deref_hint_emitted_on_trace():
    fn = ah._v204_ast_class_hints
    trace = (
        "iter=1 batch=orphan-rec-0000__s5 status=rejected_unsafe "
        "sandbox_diag: mutator raised: AttributeError: 'NoneType' object has no attribute 'lower'"
    )
    out = fn(trace)
    assert "NONE-DEREF" in out
    assert "v306-none-deref-hint" in out
    # guidance must teach the coercion pattern
    assert "or ''" in out


def test_none_deref_hint_absent_when_trace_clean():
    """Non-tautology: the hint is conditional on the failure signature."""
    out = ah._v204_ast_class_hints("iter=1 batch=B0001 status=applied")
    assert "NONE-DEREF" not in out
