from notebook_source_util import notebook_concat_source

"""Behavioral test for v1.1.0 — verifier-keyword-rescue-when-llm-empty.

gov_transport mvm_v1 (run <run_id>) terminated with adherence precision = 0.3333:
9 of 15 VREQs marked failed with the SAME evidence:

    [verifier-llm-fallback-deterministic-rescue FIRED v1.0.3] primary LLM empty
    AND rescue extraction empty -- VREQ marked failed (no soft-accept per §11.5)

Of those 9:
- VREQ-001 ("The model is for gov_transport - North Carolina Department of Transportation. Common jargons: doh = Department of Highways, dmv = Department of Motor Vehicles.")
- VREQ-002 ("Operational systems of record for gov_transport are: SAP, DCH, Beacon, DB2 Mainframe...")
- VREQ-003 ("Industry governing bodies for gov_transport are: PCI, OWASP, NC Legislature.")
  → these are pure CONTEXT — no action verb, no testable target. The agent cannot
    "fulfil" them because there is nothing to build/rename/connect.

- VREQ-007 ("Reverse-engineer the PSE schema from gisu_prod.pse_silver into project domain")
- VREQ-010 ("HR subdomains must be defined using these groupings: Employee Records...")
- VREQ-011 ("Business glossary attribute enrichment: every attribute in the HR base
            model gets tag gov_transport_business_glossary_term...")
- VREQ-012/013/014 ("Build metric view KPI-1/2/3: Vacancy Rate / Retirement Eligibility...")
  → these ARE actionable AND in fact were fulfilled (mvm_v2 has hr.vacancy_rate_metric,
    hr.retirement_eligibility_metric, hr.total_positions_metric, project domain has pse_*
    products). But the LLM rescue extractor returned empty because the schema enum
    {product, attribute, fk, domain, datatype, description, unknown} is too narrow
    to express "metric view named X" or "tag with prefix Y".

v1.1.0 classified such VREQs from keywords in their text. Since v5.3.3 an LLM reads every
requirement into a spec, and the verifier acts only on the spec, before any LLM verdict:
  - a context requirement (kind documentation / tooling / deployment / quality_goal) is
    "informational" (excluded from precision) and the LLM verifier is never called
  - an actionable requirement is scored deterministically from its spec against the snapshot
  - a requirement with no deterministic check reaches the LLM verifier; if that is empty too,
    the empty-LLM site asks the spec verifier once more and otherwise marks it failed

These tests register the spec the LLM returns for each gov_transport VREQ shape and drive the
REAL VibeOrchestrator._verify_requirement.
"""
import json
import logging
import os

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

REPO_ROOT = os.path.normpath(os.path.join(os.path.dirname(__file__), "..", ".."))
AGENT_NB = os.path.join(REPO_ROOT, "agent", "dbx_vibe_modelling_agent.ipynb")


@pytest.fixture(scope="module")
def agent_text():
    with open(AGENT_NB, "r", encoding="utf-8", errors="ignore") as f:
        return f.read()


# ─────────────────────────── static contract ───────────────────────────


def test_v110_empty_llm_site_defers_to_the_spec_verifier(agent_text):
    """The v1.1.0 site (primary + rescue LLM both empty) asks the spec verifier before failing."""
    assert agent_text.count("_v110_spec = _verify_from_spec(vreq_spec(req)") == 1
    assert "primary LLM empty AND rescue extraction empty AND the requirement spec has no deterministic check" in agent_text
    assert "verifier-keyword-rescue-when-llm-empty" not in agent_text


def test_v110_mark_informational_method_present(agent_text):
    assert "def mark_informational(self, evidence_text" in agent_text, (
        "VibeRequirement must expose mark_informational helper for the v1.1.0 path"
    )


def test_v110_scorer_excludes_informational(agent_text):
    assert "scoreable_total = total - len(informational_reqs)" in agent_text, (
        "scorer must compute scoreable_total = total - informational"
    )
    assert "precision = fulfilled / scoreable_total" in agent_text, (
        "precision denominator must be scoreable_total (NOT raw total)"
    )


def test_v110_scorecard_emits_informational_count(agent_text):
    # Notebook stores source as JSON-escaped strings so the literal `"informational"` is
    # `\"informational\"` in raw bytes.
    assert '\\"informational\\": len(informational_reqs)' in agent_text, (
        "scorecard JSON must emit informational count for audit visibility"
    )


def test_v110_three_dispatch_sites_handle_informational(agent_text):
    """Three call sites where the verifier dispatches statuses (validate, unified_audit,
    remediation_from_audit) MUST all branch to mark_informational."""
    n = agent_text.count('mark_informational(result[\\"evidence\\"]')
    n += agent_text.count('mark_informational(evidence,')
    assert n >= 3, (
        f"informational dispatch must appear at validate + unified_audit + remediation_from_audit; got {n}"
    )


# ─────────────────────────── behavioral test ───────────────────────────


def _gov_transport_snapshot():
    products = [
        {"domain": "hr", "product": "employee"},
        {"domain": "hr", "product": "vacancy_rate_metric"},
        {"domain": "hr", "product": "retirement_eligibility_metric"},
        {"domain": "hr", "product": "total_positions_metric"},
        {"domain": "hr", "product": "leave_balance"},
        {"domain": "hr", "product": "benefit_provider"},
        {"domain": "hr", "product": "position"},
        {"domain": "project", "product": "pse_category"},
        {"domain": "project", "product": "pse_data_type"},
        {"domain": "project", "product": "pse_project_response"},
        {"domain": "project", "product": "document"},
    ]
    attrs = [
        {"domain": "hr", "product": "employee", "attribute": "employee_id"},
        {"domain": "hr", "product": "employee", "attribute": "supervisor_employee_id"},
        {"domain": "hr", "product": "vacancy_rate_metric", "attribute": "vacant_positions"},
        {"domain": "hr", "product": "vacancy_rate_metric", "attribute": "total_positions"},
        {"domain": "hr", "product": "retirement_eligibility_metric", "attribute": "age_range"},
        {"domain": "hr", "product": "retirement_eligibility_metric", "attribute": "pension_plan"},
        {"domain": "project", "product": "pse_category", "attribute": "category_id"},
        {"domain": "project", "product": "pse_project_response", "attribute": "project_id"},
    ]
    return products, attrs


class _Req:
    def __init__(self, rid, text):
        self.id = rid
        self.original_text = text
        self.scope_targets = []


class _NoLLM:
    def _call_ai_query(self, **kwargs):
        raise AssertionError("the LLM verifier must not run when the spec gives a verdict")


def _verify(spec, text):
    products, attrs = _gov_transport_snapshot()
    vs.register(ah, ah.widgets_flat_to_model([{"domain": "hr"}, {"domain": "project"}], products, attrs), spec)
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = logging.getLogger("test_v110")
    orch._llm_verify_enabled = True
    orch.ai_agent = _NoLLM()
    return orch._verify_requirement(_Req(spec["id"], text), [], products, attrs)


@pytest.mark.parametrize("rid,text", [
    ("VREQ-001", "The model is for gov_transport - North Carolina Department of Transportation. "
                 "Common jargons: doh = Department of Highways, dmv = Department of Motor Vehicles."),
    ("VREQ-002", "Operational systems of record for gov_transport are: SAP, DCH, Beacon, DB2 Mainframe, SharePoint, Web Applications."),
    ("VREQ-003", "Industry governing bodies for gov_transport are: PCI, OWASP, NC Legislature."),
])
def test_v110_context_requirement_is_informational_without_an_llm_call(rid, text):
    verdict = _verify(vs.spec(rid, "other", [], breadth="model", kind="documentation"), text)
    assert verdict["status"] == "informational", verdict


def test_v110_vreq_007_pse_reverse_engineer_is_scored_from_its_spec():
    """VREQ-007 asks for the PSE tables in the project domain; they are in the snapshot -> fulfilled."""
    text = "Reverse-engineer the PSE schema from source `gisu_prod.pse_silver` into the `project` domain."
    spec = vs.spec("VREQ-007", "add_product", ["project.pse_category", "project.pse_data_type", "project.pse_project_response"])
    verdict = _verify(spec, text)
    assert verdict["status"] == "fulfilled", verdict
    assert "3/3 target(s) present" in verdict["evidence"], verdict


def test_v110_vreq_unrelated_tables_are_failed_not_rescued_by_shared_words():
    """An actionable VREQ whose named tables are absent is failed; words it shares with the snapshot
    (metric, positions) never credit it."""
    text = ("Build metric view KPI-99: Quantum Foam Resonance Index using subatomic "
            "neutrino flux density and lepton chirality coefficient.")
    spec = vs.spec("VREQ-099", "add_product", ["hr.quantum_foam_resonance_metric"])
    verdict = _verify(spec, text)
    assert verdict["status"] == "failed", verdict


def test_v110_requirement_with_no_spec_is_failed():
    products, attrs = _gov_transport_snapshot()
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = logging.getLogger("test_v110")
    orch._llm_verify_enabled = True
    orch.ai_agent = _NoLLM()
    verdict = orch._verify_requirement(_Req("VREQ-404", ""), [], products, attrs)
    assert verdict["status"] == "failed", verdict
    assert "not interpreted: the requirement has no LLM spec" in verdict["evidence"], verdict


def test_v110_notebook_is_valid_json(agent_text):
    nb = json.loads(agent_text)
    assert isinstance(nb.get("cells", []), list) and len(nb["cells"]) > 0
