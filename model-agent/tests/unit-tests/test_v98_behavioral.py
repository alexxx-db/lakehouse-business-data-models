"""v0.9.8 behavioral test — structural rename/drop verifier in _verify_deterministic.

ROOT-CAUSE FIX for v0.9.6/v0.9.7 RT audit finding: the deterministic verifier in
VibeOrchestrator had NO handler for rename / drop / remove on scope=table or
scope=attribute requirements. Result:
  - VREQ-003..008 (rename_product, RT)  -> all "partial" with generic evidence
  - VREQ-031..038 (rename_attribute, RT) -> same generic partial
  - Connect_table VREQs were FALSE-FULFILLED by the scope==table + 'add' check
    (which verifies the table exists, not the column addition).

v0.9.8 adds two structural verifier branches BEFORE the partial fallback:
  1. RENAME — when vibe text mentions rename and scope is table/attribute,
     check the OLD name is GONE from model.json (products / attributes).
  2. DROP/REMOVE/DELETE — when vibe text mentions drop/remove/delete and scope
     is table/attribute, check the target is GONE.

These are structural checks against the LIVE model state (products_data /
attributes_data inside the verifier closure), NOT regex on the vibe text.
The verb membership check (`'rename' in ll`) is a single-token membership,
not a regex pattern, and is generic across all industries. No industry strings,
no hardcoded entity names.

Sentinel: '[verifier-rename-drop-structural FIRED]' logs once per VREQ.

v5.3.3: the verb checks are gone. An LLM reads each requirement into a spec, and
_verify_from_spec checks the spec's rename / drop against the live model state.
"""
import json
import logging
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

NOTEBOOK = Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"


def _load_notebook_source():
    nb = json.loads(NOTEBOOK.read_text())
    return [(idx, "".join(cell.get("source", []))) for idx, cell in enumerate(nb["cells"])]


def _all_source():
    return "\n".join(src for _, src in _load_notebook_source())


def test_v98_agent_version_constant():
    cells = _load_notebook_source()
    cell1 = next(src for idx, src in cells if re.search(r"__AGENT_VERSION__\s*=", src))
    m = re.search(r'__AGENT_VERSION__\s*=\s*"(\d+)\.(\d+)\.(\d+)"', cell1)
    assert m is not None, "v0.9.8: __AGENT_VERSION__ must be set with single-digit semver"
    major, minor, patch = int(m.group(1)), int(m.group(2)), int(m.group(3))
    assert (major, minor, patch) >= (0, 9, 8), (
        f"v0.9.8: __AGENT_VERSION__ must be 0.9.8 or later, got {major}.{minor}.{patch}"
    )


def _crew_model():
    return {"model": {"domains": [{"name": "crew", "products": [
        {"name": "member", "primary_key": "member_id", "attributes": [
            {"name": "member_id", "type": "BIGINT"}, {"name": "legacy_code", "type": "STRING"}]},
        {"name": "roster", "primary_key": "roster_id", "attributes": [
            {"name": "roster_id", "type": "BIGINT"}, {"name": "duty_code", "type": "STRING"}]}]}]}}


def _verdict(rid, model):
    d, p, a, _mv = ah.model_to_widgets_flat(model)
    orch = ah.VibeOrchestrator({"logger": logging.getLogger("test_v98"), "config": {}, "vibe_modelling_instructions": "rename and drop",
                                "operation": "vibe modeling of version"})
    req = ah.VibeRequirement(id=rid, original_text="rename and drop", intent="structural", scope="table", scope_targets=["crew.member"],
                             verification_strategy="deterministic")
    return orch._verify_deterministic(req, d, p, a)


def _product(model, name):
    return next(p for p in model["model"]["domains"][0]["products"] if p["name"] == name)


def test_v98_rename_returns_failed_when_old_target_still_present():
    model = _crew_model()
    vs.register(ah, model, vs.spec("VREQ-003", "rename_product", ["crew.member"], new_name="crew_member"),
                vs.spec("VREQ-031", "rename_column", ["crew.roster.duty_code"], new_name="duty_type"))
    assert _verdict("VREQ-003", model)["status"] == "failed"
    assert _verdict("VREQ-031", model)["status"] == "failed"
    model["model"]["domains"][0]["products"].append(dict(_product(model, "member"), name="crew_member"))
    copied = _verdict("VREQ-003", model)
    assert copied["status"] == "partial" and "the old one is still there" in copied["evidence"], copied
    model["model"]["domains"][0]["products"].remove(_product(model, "member"))
    next(a for a in _product(model, "roster")["attributes"] if a["name"] == "duty_code")["name"] = "duty_type"
    assert _verdict("VREQ-003", model)["status"] == "fulfilled"
    assert _verdict("VREQ-031", model)["status"] == "fulfilled"


def test_v98_drop_returns_failed_when_target_still_present():
    model = _crew_model()
    vs.register(ah, model, vs.spec("VREQ-040", "drop_product", ["crew.roster"]), vs.spec("VREQ-041", "drop_column", ["crew.member.legacy_code"]))
    assert _verdict("VREQ-040", model)["status"] == "failed"
    assert _verdict("VREQ-041", model)["status"] == "failed"
    model["model"]["domains"][0]["products"].remove(_product(model, "roster"))
    _product(model, "member")["attributes"].pop()
    dropped = _verdict("VREQ-040", model)
    assert dropped["status"] == "fulfilled" and "1/1 target(s) removed" in dropped["evidence"], dropped
    assert _verdict("VREQ-041", model)["status"] == "fulfilled"


def _spec_verifier_block():
    src = _all_source()
    start = src.find("def _verify_spec_action(")
    end = src.find("def _verify_spec_follow_renames(", start)
    assert start != -1 and end > start, "spec verifier block not found"
    block = src[start:end]
    entry = src.find("def _verify_from_spec(")
    assert entry != -1, "_verify_from_spec not found"
    return block + src[entry:src.find("\ndef ", entry + 10)]


def test_v98_no_regex_introduced_for_verbs():
    """v5.3.3: the spec verifier never reads the requirement text, so no verb check, regex or keyword can creep back in."""
    block = _spec_verifier_block()
    for token in ("original_text", "source_quote", ".intent", "re.search", "re.match", "re.compile", "re.findall"):
        assert token not in block, f"spec verifier reads requirement text or uses regex: {token!r}"


def test_v98_no_industry_strings_introduced():
    """v0.9.8 / v5.3.3: the structural verifier MUST NOT contain industry-specific strings,
    customer names, or hardcoded entity names (per CLAUDE.md §8.5 industry-agnostic)."""
    forbidden = (
        "retail_", "healthcare_", "legal_", "airlines_", "banking_",
        "advance_ship_notice", "return_authorization", "ship_from_store_node",
    )
    block = _spec_verifier_block()
    for token in forbidden:
        assert token not in block, (
            f"v0.9.8: forbidden industry-specific token '{token}' found in verifier block"
        )


def test_v98_mode_reconciliation_aggregate_wins_present():
    """v0.9.8: master_analyze must reconcile LLM top-level classification vs
    aggregate overall_mode; when they disagree, empirical aggregate wins.

    ROOT-CAUSE FIX for v0.9.6 RT (run <run_id>):
    All 85 parsed VREQs had mode=surgical, but LLM returned classification='GENERATIVE'.
    compile_vibe_contract read 'classification' verbatim, so VibeContract.mode='GENERATIVE',
    surgical mutation pipeline was bypassed, 0 rename_product/connect_table mutations landed.
    """
    src = _all_source()
    assert "mode-reconciliation-aggregate-wins FIRED" in src, (
        "v0.9.8: sentinel '[mode-reconciliation-aggregate-wins FIRED]' missing from master_analyze"
    )
    assert "_llm_top_classification" in src, (
        "v0.9.8: reconciliation must capture LLM top-level classification in _llm_top_classification"
    )
    assert "_aggregate_mode_upper" in src, (
        "v0.9.8: reconciliation must compute aggregate mode from per-requirement modes"
    )
    assert "_reconciled_classification = _aggregate_mode_upper" in src, (
        "v0.9.8: when LLM disagrees with aggregate, classification must be set to aggregate"
    )


def test_v98_mode_reconciliation_uses_aggregate_in_classification_data():
    """v0.9.8: the dict written to widgets_values['vibe_classification'] must use
    the reconciled value, not the raw LLM value."""
    src = _all_source()
    assert "\"classification\": _reconciled_classification," in src, (
        "v0.9.8: classification_data dict must use _reconciled_classification, not data.get('classification', ...)"
    )


def test_v98_mode_reconciliation_no_regex_no_industry_strings():
    """v0.9.8: mode reconciliation MUST be a pure enum comparison —
    no regex on vibe text, no industry-specific strings."""
    src = _all_source()
    start = src.find('_llm_top_classification = str(data.get("classification", "") or "").upper()')
    end = src.find("classification_data = {", start)
    assert start != -1 and end != -1 and end > start, (
        "v0.9.8: mode-reconciliation block markers not found in expected order"
    )
    block = src[start:end]
    forbidden_industry = (
        "retail", "healthcare", "legal", "airlines", "banking",
    )
    for token in forbidden_industry:
        assert token.lower() not in block.lower(), (
            f"v0.9.8: forbidden industry token '{token}' found in mode-reconciliation block"
        )
    assert "re.search" not in block and "re.match" not in block and "re.compile" not in block, (
        "v0.9.8: mode-reconciliation block must not introduce regex"
    )
