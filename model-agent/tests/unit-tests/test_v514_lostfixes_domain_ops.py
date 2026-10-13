import copy
import json
import logging
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

HERE = Path(__file__).resolve().parent
VIBES = json.loads((HERE / "fixtures" / "v514_lostfixes_pc_vibes.json").read_text())
VOV = "vibe modeling of version"
LOG = logging.getLogger("test_v514_lostfixes_domain_ops")
UW_MOVED = ("submission", "uw_decision", "quote", "binder")
B1_EVIDENCE = "; ".join(f"move_product move coverage.{p}->underwriting" for p in UW_MOVED)
SPECS = {
    "A1": vs.spec("A1", "merge_domains", ["claimfinancials"], merge_into="claims"),
    "A2": vs.spec("A2", "rename_domain", ["claims"], new_name="claim"),
    "A3": vs.spec("A3", "rename_domain", ["riskexposure"], new_name="risk"),
    "A4": vs.spec("A4", "rename_domain", ["catastrophegeography"], new_name="catastrophe"),
    "B1": vs.spec("B1", "move_product", [f"coverage.{p}" for p in UW_MOVED], destination_domain="underwriting"),
}


@pytest.fixture(autouse=True)
def _no_scope():
    ah.set_vibe_scope_runtime(None)
    yield
    ah.set_vibe_scope_runtime(None)


def _p(name, *extra):
    return {"name": name, "primary_key": name + "_id", "attributes": [{"name": name + "_id", "type": "BIGINT"}] + list(extra)}


def _fk(name, target):
    return {"name": name, "type": "BIGINT", "foreign_key_to": target}


def _pc_model():
    return {"model": {"domains": [
        {"name": "claims", "database_name": "claims", "products": [_p("claim"), _p("claim_status")]},
        {"name": "claimfinancials", "database_name": "claimfinancials", "products": [
            _p("reserve", _fk("claim_id", "claims.claim.claim_id"))]},
        {"name": "riskexposure", "database_name": "riskexposure", "products": [_p("property_risk")]},
        {"name": "catastrophegeography", "database_name": "catastrophegeography", "products": [_p("peril")]},
        {"name": "coverage", "database_name": "coverage", "products": [
            _p(n) for n in ("coverage", "limit", "deductible", "exclusion", "submission", "uw_decision", "quote", "binder")]},
        {"name": "underwriting", "database_name": "underwriting", "products": [_p("uw_guideline")]},
        {"name": "policy", "database_name": "policy", "products": [_p(
            "policy",
            _fk("reserve_ref", "claimfinancials.reserve.reserve_id"),
            _fk("risk_ref", "riskexposure.property_risk.property_risk_id"),
            _fk("peril_ref", "catastrophegeography.peril.peril_id"),
            _fk("submission_ref", "coverage.submission.submission_id"))]},
    ]}}


def _domains(m):
    return m["model"]["domains"]


def _domain(m, name):
    return next(d for d in _domains(m) if d["name"] == name)


def _names(m):
    return [d["name"] for d in _domains(m)]


def _where(m, product):
    return [d["name"] for d in _domains(m) for p in d["products"] if p["name"] == product]


def _policy_fks(m):
    return {a["name"]: a.get("foreign_key_to") for a in _domain(m, "policy")["products"][0]["attributes"]}


def _dangling(m):
    live = {(d["name"], p["name"]) for d in _domains(m) for p in d["products"]}
    return [a["foreign_key_to"] for d in _domains(m) for p in d["products"] for a in p["attributes"]
            if a.get("foreign_key_to") and tuple(a["foreign_key_to"].split(".")[:2]) not in live]


def _flat(m):
    domains = [{"domain": d["name"]} for d in _domains(m)]
    products = [{"domain": d["name"], "product": p["name"]} for d in _domains(m) for p in d["products"]]
    attributes = [{"domain": d["name"], "product": p["name"], "attribute": a["name"], "foreign_key_to": a.get("foreign_key_to", "")}
                  for d in _domains(m) for p in d["products"] for a in p["attributes"]]
    return domains, products, attributes


def _register(*items, model=None):
    vs.register(ah, model or _pc_model(), *(SPECS[i] if isinstance(i, str) else i for i in items))


@pytest.mark.parametrize("order", [("A1", "A2", "A3", "A4"), ("A2", "A1", "A3", "A4"), ("A4", "A3", "A2", "A1")])
def test_a1_to_a4_land_through_the_selffix_precheck_in_every_order(order):
    _register("A1", "A2", "A3", "A4")
    m = _pc_model()
    for key in order:
        ok, evidence = ah._v410_deterministic_selffix(m, {"id": key, "text": VIBES[key]}, LOG)
        assert ok is True, (key, evidence)
    assert _names(m) == ["claim", "risk", "catastrophe", "coverage", "underwriting", "policy"]
    assert [d["database_name"] for d in _domains(m)][:3] == ["claim", "risk", "catastrophe"]
    reserve = next(p for p in _domain(m, "claim")["products"] if p["name"] == "reserve")
    assert reserve["subdomain"] == "claimfinancials"
    assert next(a for a in reserve["attributes"] if a["name"] == "claim_id")["foreign_key_to"] == "claim.claim.claim_id"
    fks = _policy_fks(m)
    assert fks["reserve_ref"] == "claim.reserve.reserve_id"
    assert fks["risk_ref"] == "risk.property_risk.property_risk_id"
    assert fks["peril_ref"] == "catastrophe.peril.peril_id"
    assert _dangling(m) == []


def test_a1_to_a4_land_through_the_vov_preapply_path():
    _register("A1", "A2", "A3", "A4")
    m = _pc_model()
    for key in ("A1", "A2", "A3", "A4"):
        op = ah._vreq_spec_det_op(ah.vreq_spec(key), m)
        assert op is not None and op[0] in ("merge_domain", "rename_domain"), (key, op)
        model, result, verdict = ah._vibe_scope_apply_det_op(m, op, "v413-preapply", (key,), LOG)
        assert result and verdict == ("", ""), (key, result, verdict)
        m = model
    assert _names(m) == ["claim", "risk", "catastrophe", "coverage", "underwriting", "policy"]
    assert _dangling(m) == []
    _register(vs.spec("A5", "rename_domain", ["claim"], new_name="Claim"), vs.spec("A6", "merge_domains", ["risk"], merge_into="risk"), model=m)
    assert ah._vreq_spec_det_op(ah.vreq_spec("A5"), m) is None and ah._vreq_spec_det_op(ah.vreq_spec("A6"), m) is None


def test_b1_moves_only_the_listed_products_and_repoints_their_fks():
    _register("B1")
    m = _pc_model()
    ok, evidence = ah._v410_deterministic_selffix(m, {"id": "B1", "text": VIBES["B1"]}, LOG)
    assert ok is True, evidence
    assert evidence == B1_EVIDENCE
    for product in UW_MOVED:
        assert _where(m, product) == ["underwriting"], product
    for product in ("coverage", "limit", "deductible", "exclusion"):
        assert _where(m, product) == ["coverage"], product
    assert _policy_fks(m)["submission_ref"] == "underwriting.submission.submission_id"
    assert _dangling(m) == []


def test_r3_only_the_tables_a_move_spec_names_move_and_a_keep_spec_moves_none():
    _register(vs.spec("R3", "move_product", ["coverage.submission", "coverage.quote"], destination_domain="underwriting"),
              vs.spec("R3K", "preserve", ["coverage.submission", "coverage.quote"]))
    m = _pc_model()
    before = copy.deepcopy(m)
    assert ah._v410_deterministic_selffix(m, {"id": "R3K"}, LOG) == (None, "no_deterministic_action") and m == before
    ok, evidence = ah._v410_deterministic_selffix(m, {"id": "R3"}, LOG)
    assert ok is True, evidence
    assert _where(m, "submission") == ["underwriting"] and _where(m, "quote") == ["underwriting"]
    for product in ("coverage", "limit", "deductible", "exclusion", "binder", "uw_decision"):
        assert _where(m, product) == ["coverage"], product


def test_r1_table_column_and_negated_rename_specs_never_rename_the_domain():
    _register("A2", "A3",
              vs.spec("R1T", "rename_product", ["claims.claim_status"], new_name="claim_state"),
              dict(vs.spec("R1C", "rename_column", new_name="state"), targets=[{"domain": "claims", "product": "", "column": "status"}]),
              vs.spec("R1N", "preserve", ["claims"]))
    m = _pc_model()
    assert ah._vreq_spec_det_op(ah.vreq_spec("A2"), m) == ("rename_domain", "claims", "claim")
    assert ah._vreq_spec_det_op(ah.vreq_spec("A3"), m) == ("rename_domain", "riskexposure", "risk")
    for rid in ("R1C", "R1N"):
        before = copy.deepcopy(m)
        assert ah._v410_deterministic_selffix(m, {"id": rid}, LOG) == (None, "no_deterministic_action") and m == before, rid
    ok, evidence = ah._v410_deterministic_selffix(m, {"id": "R1T"}, LOG)
    assert ok is True and evidence.startswith("rename_product "), evidence
    assert _names(m) == _names(_pc_model())
    assert [p["name"] for p in _domain(m, "claims")["products"]] == ["claim", "claim_state"]


def _hijack_model():
    return {"model": {"domains": [
        {"name": "product", "database_name": "product", "products": [_p("category"), _p("product_category")]},
        {"name": "service", "database_name": "service", "products": [_p("service_contract"), _p("contract_line"), _p("service_contract_line")]},
    ]}}


def test_r4_hijack_line_specs_act_on_their_tables_and_a_misread_domain_merge_is_refused():
    m = _hijack_model()
    _register(vs.spec("P99", "rename_product", ["product.product_category"], new_name="category_secondary"),
              vs.spec("P148", "add_column", ["service.contract_line"], columns=[{"name": "service_contract_id", "type": "BIGINT"}],
                      fk_target="service.service_contract"),
              vs.spec("P99X", "merge_domains", ["product"], merge_into="category"),
              vs.spec("P148X", "merge_domains", ["service_contract_line"], merge_into="contract_line"), model=m)
    for rid in ("P99X", "P148X"):
        before = copy.deepcopy(m)
        assert ah._v410_deterministic_selffix(m, {"id": rid}, LOG) == (None, "merge_domain_apply_failed") and m == before, rid
    assert ah._vreq_spec_det_op(ah.vreq_spec("P99"), m) == ("rename_product", "product", "product_category", "category_secondary")
    assert ah._vreq_spec_det_op(ah.vreq_spec("P148"), m) == (
        "add_fk", "service", "contract_line", "service_contract_id", "service.service_contract.service_contract_id")
    for rid in ("P99", "P148"):
        ok, evidence = ah._v410_deterministic_selffix(m, {"id": rid}, LOG)
        assert ok is True, (rid, evidence)
    assert _names(m) == ["product", "service"]


def test_r9_merge_refuses_product_name_collisions(caplog):
    m = _pc_model()
    assert ah._v337_apply_merge_domain(m["model"], "claimfinancials", "claims", LOG).startswith("merge_domain claimfinancials->claims")
    assert "claimfinancials" not in _names(m) and _where(m, "reserve") == ["claims"]
    clash = _pc_model()
    _domain(clash, "claimfinancials")["products"].append(_p("claim_status"))
    before = copy.deepcopy(clash)
    with caplog.at_level(logging.WARNING, logger=LOG.name):
        assert ah._v337_apply_merge_domain(clash["model"], "claimfinancials", "claims", LOG) is None
        assert ah._v337_apply_rename_domain(clash["model"], "claimfinancials", "claims", LOG) is None
    assert clash == before
    assert sum("[v337-merge-domain-collision FIRED v5.1.4]" in r.getMessage() for r in caplog.records) == 2


def _orch(base):
    return ah.VibeOrchestrator({"logger": LOG, "config": {}, "vibe_modelling_instructions": "vibes", "business_context_raw": base})


def _req(text, strategy="state_diff", rid="VREQ-T"):
    return ah.VibeRequirement(id=rid, original_text=text, intent="modify", scope="domain", verification_strategy=strategy)


def test_r2_rename_verdict_preempts_the_preserve_structure_lie():
    base = _pc_model()
    orch = _orch(base)
    d, p, a = _flat(base)
    orch._step_snapshots["step_interpret_model_instructions_before"] = ah.capture_vibe_model_snapshot(d, p, a)
    _register("A2")
    pre = orch._verify_requirement(_req(VIBES["A2"], rid="A2"), d, p, a)
    assert pre["status"] == "failed", pre
    assert "[verifier-spec FIRED v5.3.3] domain claims -> claim" in pre["evidence"]
    after = _pc_model()
    assert ah._v410_deterministic_selffix(after, {"id": "A2", "text": VIBES["A2"]}, LOG)[0] is True
    post = orch._verify_requirement(_req(VIBES["A2"], rid="A2"), *_flat(after))
    assert post["status"] == "fulfilled", post


def test_r2_verifier_never_credits_a_domain_op_on_a_name_that_was_never_a_domain():
    orch = _orch(_pc_model())
    live = _pc_model()
    ghosts = (vs.spec("G1", "merge_domains", ["fraud_case"], merge_into="claims"),
              vs.spec("G2", "rename_domain", ["claimz"], new_name="claim"))
    _register("A1", "A2", *ghosts)
    for ghost in ghosts:
        assert orch._verify_requirement(_req("", rid=ghost["id"]), *_flat(live))["status"] != "fulfilled", ghost
    assert orch._verify_requirement(_req(VIBES["A1"], rid="A1"), *_flat(live))["status"] == "failed"
    assert ah._v410_deterministic_selffix(live, {"id": "A2", "text": VIBES["A2"]}, LOG)[0] is True
    assert ah._v410_deterministic_selffix(live, {"id": "A1", "text": VIBES["A1"]}, LOG)[0] is True
    assert orch._verify_requirement(_req(VIBES["A1"], rid="A1"), *_flat(live))["status"] == "fulfilled"
    for ghost in ghosts:
        assert orch._verify_requirement(_req("", rid=ghost["id"]), *_flat(live))["status"] != "fulfilled", ghost


def test_bulk_move_verdict_is_failed_then_partial_then_fulfilled():
    orch = _orch(_pc_model())
    _register("B1")
    m = _pc_model()
    req = _req(VIBES["B1"], rid="B1")
    assert orch._verify_requirement(req, *_flat(m))["status"] == "failed"
    ah._v337_apply_move_product(m["model"], "coverage", "submission", "underwriting")
    assert orch._verify_requirement(req, *_flat(m))["status"] == "partial"
    assert ah._v410_deterministic_selffix(m, {"id": "B1", "text": VIBES["B1"]}, LOG)[0] is True
    verdict = orch._verify_requirement(req, *_flat(m))
    assert verdict["status"] == "fulfilled" and "4/4" in verdict["evidence"]


def _scope(entries, mode="Some Domains"):
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope(mode, entries), _pc_model(), VOV, LOG)
    ah.set_vibe_scope_runtime(fence)
    return fence


def test_r8_domain_ops_that_cross_the_scope_fence_are_refused(caplog):
    with caplog.at_level(logging.WARNING):
        for entries, mode, call in (
                ("claims", "Some Domains", lambda r: ah._v337_apply_rename_domain(r, "claims", "claim", LOG)),
                ("claims", "Some Domains", lambda r: ah._v337_apply_rename_domain(r, "policy", "policies", LOG)),
                ("claimfinancials", "Some Domains", lambda r: ah._v337_apply_merge_domain(r, "claimfinancials", "claims", LOG)),
                ("claimfinancials, claims", "Some Domains", lambda r: ah._v337_apply_merge_domain(r, "claimfinancials", "policy", LOG)),
                ("claims.core", "Some Subdomains", lambda r: ah._v337_apply_rename_domain(r, "claims", "claim", LOG))):
            _scope(entries, mode)
            m = _pc_model()
            before = copy.deepcopy(m)
            assert call(m["model"]) is None, entries
            assert m == before, entries
    assert sum("[v337-domain-op-fence FIRED v5.1.4]" in r.getMessage() for r in caplog.records) == 5
    _register("A2")
    _scope("claims")
    m = _pc_model()
    assert ah._v410_deterministic_selffix(m, {"id": "A2", "text": VIBES["A2"]}, LOG) == (None, "rename_domain_apply_failed")
    assert "claims" in _names(m)


def test_r8_in_scope_domain_ops_apply_and_call_the_domain_rename_ledger():
    ah.vov_ledger_reset()
    _scope("claims, claim, claimfinancials")
    base = _pc_model()
    m = copy.deepcopy(base)
    assert ah._v337_apply_rename_domain(m["model"], "claims", "claim", LOG).startswith("rename_domain claims->claim")
    assert ah._v337_apply_merge_domain(m["model"], "claimfinancials", "claim", LOG).startswith("merge_domain claimfinancials->claim")
    assert [(e["kind"], e["old"], e["new"]) for e in ah.vov_rename_events()] == [
        ("domain", "claims", "claim"), ("domain", "claimfinancials", "claim")]
    changes = ah.vov_entity_changes(base, m, {"operation": VOV})
    doms = {e["base_path"]: e for e in changes["entries"] if e["kind"] == "domain" and e.get("base_path")}
    assert (doms["claims"]["status"], doms["claims"]["path"]) == ("renamed", "claim")
    assert doms["claimfinancials"]["path"] == "claim"
    assert doms["claimfinancials"]["status"] in ("renamed", "merged")
    reserve = next(e for e in changes["entries"] if e["kind"] == "product" and e.get("base_path") == "claimfinancials.reserve")
    assert reserve["path"] == "claim.reserve" and reserve["status"] != "dropped"
    d, p, a, _mv = ah.model_to_widgets_flat(m, quiet=True)
    assert not [i for i in ah.run_metamodel_static_analysis(d, p, a, {}, LOG)["issues"]
                if i["category"] == "rename_leftover_original"]
    ah.vov_ledger_reset()


def test_r8_bulk_move_refuses_products_whose_move_crosses_the_fence():
    _register("B1")
    _scope("coverage")
    m = _pc_model()
    before = copy.deepcopy(m)
    assert ah._v410_deterministic_selffix(m, {"id": "B1", "text": VIBES["B1"]}, LOG) == (None, "move_product_blocked")
    assert m == before
    _scope("coverage, underwriting")
    ok, evidence = ah._v410_deterministic_selffix(m, {"id": "B1", "text": VIBES["B1"]}, LOG)
    assert ok is True and evidence == B1_EVIDENCE
