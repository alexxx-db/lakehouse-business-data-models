"""v2.9.1 FIX-2 behavioral test: meta model-quality-score requirements.

ROOT CAUSE (pre-patch): a VREQ like "improve the model quality score to >= 85"
has no entity target, so the per-VREQ verifier could not confirm it and marked it
failed/partial -- a false negative that dragged precision/recall, because the
authoritative deterministic Model Quality Score is computed later (in next_vibes),
not at the verifier stage.

FIX: _verify_requirement detects aggregate model-quality-score goals and returns
status='informational' (excluded from precision), reusing the existing
mark_informational path. Re-implementing the deterministic score in the verifier
would duplicate _compute_deterministic_confidence_and_status (DRY violation), so
the meta-goal is correctly excluded rather than faked as fulfilled.

v5.3.3: the regexes are gone. An LLM reads each requirement into a spec; kind
"quality_goal" marks a score goal, and the spec verifier scores it informational.
"""
import logging
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

META_REQS = [
    "Improve the model quality score to >= 85",
    "Achieve an overall model score of 90/100",
    "Raise the quality score above 80",
    "Maintain a model quality score of at least 88",
    "Increase the confidence score for the model",
]

ENTITY_REQS = [
    ("Add a foreign key from booking.flight_id to flight.flight_id",
     vs.spec("VREQ-E1", "add_fk", ["ops.booking.flight_id"], fk_target="ops.flight.flight_id")),
    ("Reverse-engineer the PSE schema into the project domain", vs.spec("VREQ-E2", "add_product", ["project.pse_schedule"])),
    ("Tag all PII attributes in the customer domain",
     vs.spec("VREQ-E3", "set_fields", ["customer"], breadth="set", fields=[vs.field("attributes", "tags")], tags=[{"key": "pii", "value": "true"}])),
    ("Rename product order_header to orders", vs.spec("VREQ-E4", "rename_product", ["sales.order_header"], new_name="orders")),
    ("Build metric view KPI-1: On-time performance", vs.spec("VREQ-E5", "add_metric_view", ["ops.flight"], metric_views=["KPI-1"])),
]


def _model():
    def _table(name, *cols):
        return {"name": name, "primary_key": f"{name}_id",
                "attributes": [{"name": f"{name}_id", "type": "BIGINT"}] + [{"name": c, "type": "STRING", "tags": ""} for c in cols]}
    return {"model": {"domains": [
        {"name": "ops", "products": [_table("booking", "flight_id"), _table("flight")]},
        {"name": "customer", "products": [_table("profile", "email", "phone")]},
        {"name": "sales", "products": [_table("order_header")]},
        {"name": "project", "products": [_table("milestone")]}]}}


def _req(text, rid):
    return ah.VibeRequirement(id=rid, original_text=text, intent=text[:40], scope="model", scope_targets=["*"],
                              verification_strategy="deterministic")


def _orchestrator(text):
    orch = ah.VibeOrchestrator({"logger": logging.getLogger("test_v291"), "config": {}, "vibe_modelling_instructions": text,
                                "operation": "vibe modeling of version"})
    orch._llm_verify_enabled = False
    orch.ai_agent = None
    return orch


def _verdict(text, spec):
    model = _model()
    vs.register(ah, model, spec)
    d, p, a, _mv = ah.model_to_widgets_flat(model)
    return _orchestrator(text)._verify_requirement(_req(text, spec["id"]), d, p, a)


def test_meta_reqs_classified():
    for i, text in enumerate(META_REQS):
        verdict = _verdict(text, vs.spec(f"VREQ-M{i}", "other", [], kind="quality_goal"))
        assert verdict["status"] == "informational", (text, verdict)
        assert "quality goal requirement changes no model entity" in verdict["evidence"], verdict


def test_entity_reqs_not_classified():
    for text, spec in ENTITY_REQS:
        verdict = _verdict(text, spec)
        assert verdict["status"] != "informational", (text, verdict)
    assert _verdict(*ENTITY_REQS[0])["status"] == "failed"
    assert _verdict(*ENTITY_REQS[3])["status"] == "failed"


def test_informational_return_wired():
    model = _model()
    vs.register(ah, model, vs.spec("VREQ-M0", "other", [], kind="quality_goal"), ENTITY_REQS[3][1])
    d, p, a, _mv = ah.model_to_widgets_flat(model)
    meta, entity = _req(META_REQS[0], "VREQ-M0"), _req(ENTITY_REQS[3][0], "VREQ-E4")
    orch = _orchestrator(META_REQS[0])
    orch.manifest = ah.VibeManifest(raw_text=META_REQS[0], requirements=[meta, entity])
    orch.widgets_values.update({"domains": d, "products": p, "attributes": a})
    orch.validate()
    assert meta.status == "informational" and "[verifier-spec FIRED v5.3.3]" in meta.evidence, meta.evidence
    assert entity.status == "failed", entity.evidence
