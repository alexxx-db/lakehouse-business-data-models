"""
v4.2.4 behavioral tests -- verifier-pipeline-meta-informational classifier.

ROOT CAUSE (water_utilities v2 ECM VOV, run <run_id>):
    VREQ-029 asked to "introduce an ontology-first stage to the GENERATION
    PIPELINE (e.g. via OntoBricks producing an OWL ontology)". That targets the
    AGENT'S generation pipeline / tooling, NOT any model entity/attribute/tag/MV,
    so it is UNSATISFIABLE by any model mutation. The verifier scored it FAILED,
    dragging physical adherence to 49/56 = 87.5% -- below the 90% floor. With the
    req correctly excluded (informational), scoreable_total becomes 55.

FIX (v5.3.3): the requirement classifier (an LLM) reads VREQ-029 into a spec of
    kind "tooling"; _verify_from_spec returns status="informational" (excluded
    from precision/recall via the v4.2.2 gt-informational-exclude path) for the
    tooling, quality_goal, deployment and documentation kinds, before any model
    check runs.

These tests register the spec the LLM returns and drive the REAL
VibeOrchestrator._verify_requirement, proving the decision boundary: specs of
the non-model kinds are informational, while genuine model-content specs (add a
table / add an ontology domain) are NOT (so they still count toward precision --
no scoreboard gaming, S8.3).
"""
import logging

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

# The exact VREQ-029 text that false-failed on the live wu run.
VREQ_029 = (
    "Consider introducing an ontology-first stage to the generation pipeline "
    "(e.g. via OntoBricks producing an OWL ontology) that captures PFAS-specific "
    "entities (long-chain vs short-chain PFAS, PFAS compound taxonomy)."
)

SNAPSHOT = ([{"domain": "treatment"}, {"domain": "compliance"}],
            [{"domain": "treatment", "product": "scada_tag", "primary_key": "scada_tag_id"},
             {"domain": "compliance", "product": "regulatory_requirement", "primary_key": "regulatory_requirement_id"}],
            [{"domain": "treatment", "product": "scada_tag", "attribute": "scada_tag_id", "tags": ""},
             {"domain": "compliance", "product": "regulatory_requirement", "attribute": "regulatory_requirement_id", "tags": ""}])


class _Req:
    def __init__(self, rid, text):
        self.id = rid
        self.original_text = text
        self.scope_targets = []


def _verify(spec, text="requirement text"):
    vs.register(ah, ah.widgets_flat_to_model(*[list(x) for x in SNAPSHOT]), spec)
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = logging.getLogger("test_v424")
    orch._llm_verify_enabled = False
    orch.ai_agent = None
    return orch._verify_requirement(_Req(spec["id"], text), *SNAPSHOT)


class TestPipelineMetaIsInformational:
    """Requirements whose spec names the agent's process/tooling, not the model."""

    def test_vreq_029_ontology_first_pipeline_is_informational(self):
        verdict = _verify(vs.spec("VREQ-029", "other", [], breadth="model", kind="tooling"), VREQ_029)
        assert verdict["status"] == "informational", verdict
        assert "tooling requirement changes no model entity and is not scored" in verdict["evidence"]
        assert verdict["evidence"].startswith("[verifier-spec FIRED v5.3.3]")

    @pytest.mark.parametrize("kind", ["tooling", "quality_goal", "deployment", "documentation"])
    def test_every_non_model_kind_is_informational(self, kind):
        assert _verify(vs.spec("VREQ-T", "other", [], breadth="model", kind=kind))["status"] == "informational"

    def test_an_uninterpretable_spec_is_failed_not_informational(self):
        verdict = _verify(vs.spec("VREQ-029", "other", [], kind="tooling", interpretable=False, reason="two readings"), VREQ_029)
        assert verdict["status"] == "failed" and "two readings" in verdict["evidence"], verdict


class TestModelContentStaysScored:
    """Genuine model-content reqs MUST still be scored (not excluded)."""

    @pytest.mark.parametrize("spec", [
        # wu VREQ-023 / VREQ-024 -- real create-entity gaps, MUST stay scoreable
        vs.spec("VREQ-023", "add_product", ["treatment.prediction_event"]),
        vs.spec("VREQ-024", "add_product", ["compliance.customer_impact_link"]),
        # an ontology *domain/table* is model content, not a pipeline stage
        vs.spec("VREQ-030", "add_product", ["ontology.owl_class", "ontology.rdf_triple"]),
        vs.spec("VREQ-031", "add_column", ["compliance.regulatory_requirement"], columns=[{"name": "jurisdiction", "type": "STRING"}]),
        dict(vs.spec("VREQ-032", "set_fields", ["treatment.scada_tag"], fields=[vs.field("products", "tags")]),
             tags=[{"key": "tag_taxonomy", "value": "basic"}]),
        vs.spec("VREQ-033", "other", [], kind="count_target", count={"entity": "metric_views", "op": "between", "value": 100, "low": 50}),
        vs.spec("VREQ-034", "set_fields", ["treatment.scada_tag"], fields=[vs.field("attributes", "value_regex")]),
    ], ids=lambda s: s["id"])
    def test_model_content_is_scored(self, spec):
        verdict = _verify(spec)
        assert verdict["status"] in ("failed", "partial"), verdict
        assert verdict["status"] != "informational"
