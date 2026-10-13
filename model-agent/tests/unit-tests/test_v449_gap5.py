import logging
import sys
import types
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

LOG = logging.getLogger("test_v449_gap5")

# real reviewer directive text (shipping & ports R1..R9), verbatim shape
R1 = ("REVIEWER-PRIORITY 1 - add_product: cargo.transhipment - model transhipment (T/S) as a FIRST-CLASS "
      "concept, not a generic container visit. Add product cargo.transhipment (a T/S move that links an "
      "inbound vessel call to an outbound vessel call) plus cargo.transhipment_leg. "
      "FK the transhipment to the existing inbound/outbound vessel.call and cargo.container.")
R4 = ("REVIEWER-PRIORITY 4 - add_domain: sustainability - create a new FIRST-CLASS domain sustainability in "
      "the operations division for decarbonization tracking, with products cii_rating, eexi_record, "
      "shore_power_session, and bunker_carbon_intensity. Classify sustainability as division=operations; "
      "FK to masterdata.vessel_master and vessel.call where relevant.")
A5 = ("REVIEWER-PRIORITY 5 - add ESG and energy products (production + governance): Add more tables to the "
      "manufacturing domain for ESG and energy tracking: energy_consumption_record, co2_emission_record, "
      "water_usage_record, line_energy_meter. Add more tables to the compliance domain for ESG reporting: "
      "esg_report, social_compliance_audit, sustainability_metric.")
A7 = ("REVIEWER-PRIORITY 7 - connect telemetry to aftersales: In the aftersales domain, the service appointment "
      "table should reference mobility.connected_vehicle: add column connected_vehicle_id to the aftersales "
      "service appointment table with FK to mobility.connected_vehicle.")

SUSTAINABILITY = ["cii_rating", "eexi_record", "shore_power_session", "bunker_carbon_intensity"]
A5_TABLES = ([("manufacturing", p) for p in ["energy_consumption_record", "co2_emission_record", "water_usage_record", "line_energy_meter"]]
             + [("compliance", p) for p in ["esg_report", "social_compliance_audit", "sustainability_metric"]])


def _fake_req(text, scope="domain", scope_targets=None, rid="VREQ-005"):
    r = types.SimpleNamespace()
    r.original_text = text
    r.scope = scope
    r.scope_targets = scope_targets or []
    r.id = rid
    return r


def _base_model():
    # cargo exists (so a domain-present verifier would false-fulfill), but transhipment is absent;
    # sustainability domain is entirely absent.
    return {"model": {"domains": [
        {"name": "cargo", "products": [
            {"name": "container", "primary_key": "container_id",
             "attributes": [{"name": "container_id", "type": "BIGINT", "is_primary_key": True}]}]},
        {"name": "vessel", "products": [
            {"name": "call", "primary_key": "call_id",
             "attributes": [{"name": "call_id", "type": "BIGINT", "is_primary_key": True}]},
            {"name": "vessel_master", "primary_key": "vessel_master_id",
             "attributes": [{"name": "vessel_master_id", "type": "BIGINT", "is_primary_key": True}]}]},
        {"name": "masterdata", "products": [
            {"name": "vessel_master", "primary_key": "vessel_master_id",
             "attributes": [{"name": "vessel_master_id", "type": "BIGINT", "is_primary_key": True}]}]},
    ]}}


class _NoLLM:
    def _call_ai_query(self, **kwargs):
        raise AssertionError("the LLM fallback must not judge a requirement the spec verifier can judge")


def _verify(spec, text, products_data, rid="VREQ-005"):
    vs.register(ah, _base_model(), spec)
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = LOG
    orch._llm_verify_enabled = True
    orch.ai_agent = _NoLLM()
    return orch._verify_requirement(_fake_req(text, rid=rid), [], products_data, [])


def _prods(pairs):
    return [{"domain": d, "product": p} for d, p in pairs]


# ---------------------------------------------------------------- verifier honesty (fail-pre/pass-post)
def test_verifier_scope_domain_named_product_scores_failed_when_missing():
    # v4.4.8 bug returned None (scope==domain bail) -> LLM fallback false-fulfilled.
    # The spec verdict is authoritative: 0 of {transhipment,transhipment_leg} exist -> failed.
    spec = vs.spec("VREQ-005", "add_product", ["cargo.transhipment", "cargo.transhipment_leg"])
    verdict = _verify(spec, R1, _prods([("cargo", "container")]))
    assert verdict["status"] == "failed", verdict
    verdict = _verify(spec, R1, _prods([("cargo", "container"), ("cargo", "transhipment")]))
    assert verdict["status"] == "partial" and "1/2 target(s) present" in verdict["evidence"], verdict


def test_verifier_scores_fulfilled_when_products_present():
    spec = vs.spec("VREQ-005", "add_product", ["cargo.transhipment", "cargo.transhipment_leg"])
    verdict = _verify(spec, R1, _prods([("cargo", "container"), ("cargo", "transhipment"), ("cargo", "transhipment_leg")]))
    assert verdict["status"] == "fulfilled", verdict


# ---------------------------------------------------------------- what the LLM spec may and may not say
def test_a_new_domain_with_named_tables_is_created_by_its_tables_not_a_domain_action():
    as_domain = vs.spec("VREQ-004", "add_domain", [f"sustainability.{p}" for p in SUSTAINABILITY])
    verdict = _verify(as_domain, R4, _prods([("sustainability", p) for p in SUSTAINABILITY]), rid="VREQ-004")
    assert verdict["status"] == "failed", verdict
    assert "add_domain changes a domain but names the table(s)" in verdict["evidence"], verdict
    as_tables = vs.spec("VREQ-004", "add_product", [f"sustainability.{p}" for p in SUSTAINABILITY])
    verdict = _verify(as_tables, R4, _prods([("sustainability", p) for p in SUSTAINABILITY]), rid="VREQ-004")
    assert verdict["status"] == "fulfilled", verdict
    verdict = _verify(as_tables, R4, _prods([("sustainability", p) for p in SUSTAINABILITY[:3]] + [("cargo", "container")]), rid="VREQ-004")
    assert verdict["status"] == "partial" and "3/4 target(s) present" in verdict["evidence"], verdict


def test_two_domain_directive_scores_both_legs():
    spec = vs.spec("VREQ-005", "add_product", [f"{d}.{p}" for d, p in A5_TABLES])
    verdict = _verify(spec, A5, _prods(A5_TABLES))
    assert verdict["status"] == "fulfilled", verdict
    verdict = _verify(spec, A5, _prods(A5_TABLES[:4]))
    assert verdict["status"] == "partial" and "4/7 target(s) present" in verdict["evidence"], ("compliance leg lost", verdict)


def test_add_column_directive_creates_nothing():
    # an add-column/FK directive is not a product create; the FK target 'mobility.connected_vehicle' must not
    # be mistaken for a product to create.
    model = ah.widgets_flat_to_model(
        [{"domain": "aftersales"}, {"domain": "mobility"}],
        [{"domain": "aftersales", "product": "service_appointment", "primary_key": "service_appointment_id"},
         {"domain": "mobility", "product": "connected_vehicle", "primary_key": "connected_vehicle_id"}],
        [{"domain": "aftersales", "product": "service_appointment", "attribute": "service_appointment_id"},
         {"domain": "mobility", "product": "connected_vehicle", "attribute": "connected_vehicle_id"}])
    idx = ah._vreq_spec_index(model)
    misread = ah._normalize_vreq_spec(vs.spec("VREQ-007", "add_product", ["aftersales.service_appointment.connected_vehicle_id",
                                                                         "mobility.connected_vehicle.connected_vehicle_id"]), idx)
    assert misread["interpretable"] is False, misread
    assert misread["reason"].startswith("add_product changes a table but names the column(s)"), misread
    assert ah._vreq_spec_det_ops(misread, model) == []
    spec = ah._normalize_vreq_spec(vs.spec("VREQ-007", "add_column", ["aftersales.service_appointment"],
                                           columns=[{"name": "connected_vehicle_id", "type": "BIGINT"}], fk_target="mobility.connected_vehicle"), idx)
    assert spec["interpretable"], spec
    assert ah._vreq_spec_det_ops(spec, model) == [
        ("add_fk", "aftersales", "service_appointment", "connected_vehicle_id", "mobility.connected_vehicle.connected_vehicle_id")]
    ah.register_vreq_specs({"VREQ-007": spec})
    vreq = ah.RawVREQ(vreq_id="VREQ-007", intent="connect telemetry to aftersales", target="", source_quote=A7, source_chunk_id="c")
    assert [p["action"] for p in ah._vov_vreq_to_priorities(vreq)] == ["connect_table"]


if __name__ == "__main__":
    import sys
    sys.exit(pytest.main([__file__, "-v"]))
