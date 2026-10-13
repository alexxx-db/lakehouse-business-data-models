"""
v4.2.5 behavioral tests -- verifier-artifact-meta-informational (RC2).

ROOT CAUSE (retail v2 ECM VOV, run <run_id>):
    VREQ-022 "the file named _v1_mvm.sql writes DDL into the retail_ecm.customer
    catalog, so MVM and ECM files target the same catalog" and VREQ-043 "add a
    provenance disclosure (LLM-generated, last human-reviewed YYYY-MM-DD by ...)"
    scored FAILED. Both target GENERATED-FILE NAMING / DEPLOY MECHANICS or
    MODEL-LEVEL DOC/PROVENANCE metadata -- neither is a model entity/attribute/
    tag/MV, so neither is assertable by a model mutation. They dragged physical
    adherence below the 90% floor.

v5.3.3: an LLM reads every requirement into a spec. A spec of kind "deployment" or
    "documentation" changes no model entity, and the spec verifier scores it
    informational. A requirement whose spec changes the model keeps its genuine
    verdict (a real miss is NEVER excused -- S8.3, section-12 no false-positive).
"""
import logging
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

LOG = logging.getLogger("test_v425_artifact_meta_informational")

# ---- real live VREQ texts ----
VREQ_022 = ("Fix the schema/database name mismatch: the file named _v1_mvm.sql writes DDL into the "
            "retail_ecm.customer catalog, so MVM and ECM files target the same catalog and deploying "
            "both blows away the first.")
VREQ_043 = ("Add a provenance disclosure (e.g. 'LLM-generated, last human-reviewed YYYY-MM-DD by ...') "
            "so adopters know to vet the model.")
# compound / genuine-structural -> MUST stay scoreable
VREQ_047 = ("Resolve the 9 cross-domain SSOT duplicates detected in the ECM model so each concept has "
            "one authoritative owner, and lift ECM quality score from 69.0 to >= 80.")
VREQ_070 = ("Section 3E.4: Add a sensitivity/PII classification tag to these 14 untagged critical PII "
            "attributes and mask them in non-prod.")


def _model():
    return {"model": {"domains": [
        {"name": "customer", "products": [
            {"name": "profile", "primary_key": "profile_id", "attributes": [
                {"name": "profile_id", "type": "BIGINT"}, {"name": "email", "type": "STRING", "tags": ""},
                {"name": "phone", "type": "STRING", "tags": ""},
                {"name": "order_id", "type": "BIGINT", "foreign_key_to": "sales.order.order_id"}]},
            {"name": "consent", "primary_key": "consent_id", "attributes": [{"name": "consent_id", "type": "BIGINT"}]},
            {"name": "preference", "primary_key": "preference_id", "attributes": [
                {"name": "preference_id", "type": "BIGINT"}, {"name": "channel", "type": "STRING"},
                {"name": "diet", "type": "STRING"}]}]},
        {"name": "sales", "products": [
            {"name": "order", "primary_key": "order_id", "attributes": [{"name": "order_id", "type": "BIGINT"}]},
            {"name": "customer", "primary_key": "customer_id", "attributes": [{"name": "customer_id", "type": "BIGINT"}]}]},
        {"name": "compliance", "products": [
            {"name": "policy", "primary_key": "policy_id", "attributes": [{"name": "policy_id", "type": "BIGINT"}]}]},
    ]}}


def _orchestrator():
    orch = ah.VibeOrchestrator({"logger": LOG, "config": {"MODEL_CONVENTIONS": {"primary_key_suffix": "_id"}},
                                "vibe_modelling_instructions": VREQ_022, "operation": "vibe modeling of version"})
    orch._llm_verify_enabled = False
    orch.ai_agent = None
    return orch


def _req(text, rid="VREQ-T"):
    return ah.VibeRequirement(id=rid, original_text=text, intent=text[:40], scope="model", scope_targets=["*"],
                              verification_strategy="deterministic")


def _verdict(text, spec):
    model = _model()
    vs.register(ah, model, spec)
    d, p, a, _mv = ah.model_to_widgets_flat(model)
    return _orchestrator()._verify_requirement(_req(text, spec["id"]), d, p, a)


class TestArtifactMetaMatches:
    def test_vreq_022_deploy_file_naming(self):
        verdict = _verdict(VREQ_022, vs.spec("VREQ-022", "other", [], kind="deployment"))
        assert verdict["status"] == "informational", verdict
        assert "deployment requirement changes no model entity" in verdict["evidence"], verdict

    def test_vreq_043_provenance_doc(self):
        verdict = _verdict(VREQ_043, vs.spec("VREQ-043", "other", [], kind="documentation"))
        assert verdict["status"] == "informational", verdict

    @pytest.mark.parametrize("text,kind", [
        ("The file named schema_ddl.sql writes DDL into the wrong catalog.", "deployment"),
        ("Fix the catalog mismatch where MVM and ECM target the same catalog.", "deployment"),
        ("Add a model card documenting provenance.", "documentation"),
        ("Include an LLM-generated disclosure so adopters know to vet the model.", "documentation"),
    ])
    def test_meta_variants_match(self, text, kind):
        assert _verdict(text, vs.spec("VREQ-T", "other", [], kind=kind))["status"] == "informational", text


class TestCompoundStructuralNotExcused:
    """A requirement whose spec changes the model keeps its genuine verdict (no false-positive)."""

    def test_vreq_047_resolve_ssot_stays_scoreable(self):
        verdict = _verdict(VREQ_047, vs.spec("VREQ-047", "merge_products", ["sales.customer"], merge_into="customer.profile"))
        assert verdict["status"] == "failed", verdict

    def test_vreq_070_add_pii_tag_stays_scoreable(self):
        spec = vs.spec("VREQ-070", "set_fields", ["customer.profile"], fields=[vs.field("attributes", "tags")],
                       tags=[{"key": "pii", "value": "true"}])
        verdict = _verdict(VREQ_070, spec)
        assert verdict["status"] == "failed" and "0/2" in verdict["evidence"], verdict

    @pytest.mark.parametrize("text,spec", [
        ("Re-home the consent table to a compliance domain.",
         vs.spec("VREQ-T", "move_product", ["customer.consent"], destination_domain="compliance")),
        ("Split the preference god-table into focused tables.",
         vs.spec("VREQ-T", "split_product", ["customer.preference"], split_into=[{"product": "preference_channel", "columns": ["channel"]},
                                                                                 {"product": "preference_diet", "columns": ["diet"]}])),
        ("Add a household table to the customer domain.", vs.spec("VREQ-T", "add_product", ["customer.household"])),
        ("Remove reversed cross-domain FKs from the customer schema.", vs.spec("VREQ-T", "remove_fk", ["customer.profile.order_id"])),
    ])
    def test_structural_reqs_stay_scoreable(self, text, spec):
        assert _verdict(text, spec)["status"] == "failed", text


class TestWiredIntoVerifier:
    def test_returns_informational_and_guarded(self):
        model = _model()
        vs.register(ah, model, vs.spec("VREQ-022", "other", [], kind="deployment"),
                    vs.spec("VREQ-070", "set_fields", ["customer.profile"], fields=[vs.field("attributes", "tags")],
                            tags=[{"key": "pii", "value": "true"}]))
        d, p, a, _mv = ah.model_to_widgets_flat(model)
        orch = _orchestrator()
        meta, pii, unread = _req(VREQ_022, "VREQ-022"), _req(VREQ_070, "VREQ-070"), _req(VREQ_043, "VREQ-043")
        orch.manifest = ah.VibeManifest(raw_text=VREQ_022, requirements=[meta, pii, unread])
        orch.widgets_values.update({"domains": d, "products": p, "attributes": a})
        orch.validate()
        assert meta.status == "informational" and "[verifier-spec FIRED v5.3.3]" in meta.evidence, meta.evidence
        assert pii.status == "failed", pii.evidence
        assert unread.status == "failed" and "not interpreted" in unread.evidence, unread.evidence
