"""Behavioral tests for v3.5.7 root-cause fixes from the v2-marathon GROUND-TRUTH VReq audit.

aliases:
  (RC1) move_product VReqs deferred to the flaky LLM sandbox because their destination was read from
        the text; since v5.3.3 the LLM requirement spec carries it (destination_domain)
  v357-preservation-gate         (RC2) — VOV dropped v1 products on rename/move conflicts
  v357-junk-domain-validator     (RC3) — LLM leaked sentinel words ('partially') as domains

Every test exercises the REAL production code through agent_helpers (not a stub), and the defect
surface lives in a single industry-MIXED synthetic model (healthcare + automotive + retail
+ banking + one junk domain) so the same fixture proves the fixes are INDUSTRY-AGNOSTIC.

RC1 tests register the move_product spec the classifier returns for 'move to <domain>'; the same
batch without that spec defers, so the move is driven by the spec and never by the wording.
"""
import copy
import json
import pathlib
import re
import sys
import types

import pytest

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[2]
NB_PATH = ROOT / "agent" / "dbx_vibe_modelling_agent.ipynb"
FIX = pathlib.Path(__file__).resolve().parent / "fixtures"


def _read_source() -> str:
    nb = json.loads(NB_PATH.read_text())
    return "\n".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


SRC = _read_source()


def _logger(lines=None):
    sink = [] if lines is None else lines
    return types.SimpleNamespace(info=lambda m, *a, **k: sink.append(str(m)), warning=lambda m, *a, **k: sink.append(str(m)))


def _load(name):
    return json.load(open(FIX / name))


def _flatten(model_json):
    """nested model.json -> (domains_data, products_data, attributes_data) flat lists."""
    dd, pp, aa = [], [], []
    m = model_json.get("model", model_json)
    for d in m.get("domains", []):
        dd.append({"domain": d["name"]})
        for p in (d.get("products") or d.get("data_products") or []):
            pp.append({"domain": d["name"], "product": p["name"]})
            for a in p.get("attributes", []):
                aa.append({"domain": d["name"], "product": p["name"],
                           "attribute": a["name"], "foreign_key_to": a.get("foreign_key_to")})
    return dd, pp, aa


# --------------------------------------------------------------------------- static
def test_v357_version_and_aliases():
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([^"]+)"', SRC)
    assert tuple(int(x) for x in m.group(1).split(".")) >= (3, 5, 7), m.group(1)
    for a in ("v357-preservation-gate", "v357-junk-domain-validator"):
        assert a in SRC, f"alias missing: {a}"
    for fired in ("[v357-junk-domain-validator FIRED]", "[v357-preservation-gate FIRED"):
        assert fired in SRC, f"FIRED sentinel missing: {fired}"


# --------------------------------------------------------------------------- RC1
def test_v357_rc1_full_deterministic_move_applied():
    """End-to-end: a move_product VReq whose spec names destination_domain=merchandising (what the
    classifier returns for 'move to merchandising') relocates the product deterministically
    (pre-patch this batch deferred to the LLM sandbox -> 'did not move'); without the spec the same
    batch defers."""
    model = _load("v357_synthetic_model.json")
    before = copy.deepcopy(model)
    batch = types.SimpleNamespace(
        batch_id="B1", vreq_ids=["P1"],
        data_payload=[{"source_quote": "PRIORITY 1 — move_product: aftersales.nameplate — "
                                       "move to merchandising because nameplate is retail master data"}],
        target_entities=[], intent_summary="",
    )
    assert ah._v337_deterministic_mutate(batch, model, _logger()) == (None, ""), "the wording alone must never move a product"
    vs.register(ah, model, vs.spec("P1", "move_product", ["aftersales.nameplate"], destination_domain="merchandising"))
    new_model, summary = ah._v337_deterministic_mutate(batch, model, _logger())
    assert new_model is not None, "deterministic move must APPLY, not defer (RC1)"
    doms = {d["name"]: [p["name"] for p in d["products"]] for d in new_model["model"]["domains"]}
    assert "nameplate" in doms["merchandising"], "product must land in target domain"
    assert "nameplate" not in doms["aftersales"], "product must leave source domain (no duplicate)"
    assert summary == "move aftersales.nameplate->merchandising"
    assert model == before, "the batch applies to a copy and never mutates the input model"


def test_v357_rc1_move_to_nonexistent_domain_defers_safely():
    """A bogus target domain must NOT create a domain (§3b) — the batch defers (returns None)."""
    model = _load("v357_synthetic_model.json")
    before = copy.deepcopy(model)
    batch = types.SimpleNamespace(
        batch_id="B2", vreq_ids=["P9"],
        data_payload=[{"source_quote": "PRIORITY 9 — move_product: aftersales.nameplate — "
                                       "move to nonexistent_domain because reasons"}],
        target_entities=[], intent_summary="",
    )
    vs.register(ah, model, vs.spec("P9", "move_product", ["aftersales.nameplate"], destination_domain="nonexistent_domain"))
    assert ah.vreq_spec("P9")["interpretable"], "the spec is readable; only the missing domain may stop the move"
    new_model, _ = ah._v337_deterministic_mutate(batch, model, _logger())
    assert new_model is None, "unknown target domain must defer, never invent a domain"
    assert model == before and "nonexistent_domain" not in {d["name"] for d in model["model"]["domains"]}
    assert ah.vov_rename_events() == [], "a deferred move records nothing in the rename ledger"


# --------------------------------------------------------------------------- RC3
def test_v357_rc3_junk_domain_rejected_and_reassigned():
    dd, pp, _ = _flatten(_load("v357_synthetic_model.json"))
    assert any(d["domain"] == "partially" for d in dd)
    n = ah._v357_reject_junk_domains(dd, pp, logger=_logger())
    assert n == 1, "exactly one junk domain ('partially') must be dropped"
    assert not any(d["domain"] == "partially" for d in dd), "junk domain removed"
    assert not any(p["domain"] == "partially" for p in pp), "no product left in junk domain"
    # most-populated valid sibling is clinical_care (12)
    moved = [p["product"] for p in pp if p["product"].startswith("orphan_")]
    assert all(next(x["domain"] for x in pp if x["product"] == op) == "clinical_care" for op in moved)


@pytest.mark.parametrize("name,is_junk", [
    ("partially", True), ("unknown", True), ("various", True), ("tbd", True), ("", True),
    ("healthcare", False), ("aftersales", False), ("merchandising", False),
    ("settlement", False), ("clinical_care", False), ("oil_and_gas", False),
])
def test_v357_rc3_industry_terms_never_junk(name, is_junk):
    """INDUSTRY-BIAS PROBE: no real industry/business term may be classified as junk."""
    assert ah._v357_is_junk_domain_name(name) is is_junk


# --------------------------------------------------------------------------- RC2
def test_v357_rc2_preservation_restores_dropped_products():
    v1 = _load("v357_synthetic_model.json")
    v2 = _load("v357_synthetic_v2_dropped.json")
    _, v1p, v1a = _flatten(v1)
    dd, pp, aa = _flatten(v2)
    before = {p["product"] for p in pp}
    assert "care_plan" not in before and "cash_flow" not in before, "fixture must start with drops"
    lines = []
    restored = ah._v357_enforce_product_preservation_flat(v1p, v1a, dd, pp, aa, logger=_logger(lines))
    after = {p["product"] for p in pp}
    assert restored == 2, f"both dropped v1 products must be restored, got {restored}"
    assert {"care_plan", "cash_flow"} <= after, "specific dropped products restored per §3b"
    # attributes of restored products also come back
    assert any(a["product"] == "care_plan" for a in aa)
    assert any("[v357-preservation-gate FIRED" in line and "restored 2 " in line for line in lines), "the restore must log its FIRED sentinel"


def test_v357_rc2_no_restore_when_nothing_dropped():
    v1 = _load("v357_synthetic_model.json")
    _, v1p, v1a = _flatten(v1)
    dd, pp, aa = _flatten(v1)  # v2 == v1, nothing dropped
    lines = []
    restored = ah._v357_enforce_product_preservation_flat(v1p, v1a, dd, pp, aa, logger=_logger(lines))
    assert restored == 0, "a complete model must not trigger any restore (no false positives)"
    assert not any("[v357-preservation-gate FIRED" in line for line in lines)


def test_v357_rc2_prefix_rename_not_falsely_restored():
    """If a v1 product was renamed with a domain prefix (nameplate -> aftersales_nameplate),
    preservation must treat it as accounted (no duplicate restore)."""
    v1 = _load("v357_synthetic_model.json")
    _, v1p, v1a = _flatten(v1)
    dd, pp, aa = _flatten(v1)
    for p in pp:
        if p["product"] == "nameplate":
            p["product"] = "aftersales_nameplate"  # simulate applied prefix-rename
    restored = ah._v357_enforce_product_preservation_flat(v1p, v1a, dd, pp, aa, logger=_logger())
    assert restored == 0, "prefix-renamed product must not be falsely restored"


# --------------------------------------------------------------------------- industry-bias (cross-domain invariance)
def test_v357_industry_bias_move_works_for_every_domain_pair():
    """The move fix must work identically no matter which industry domain is source/target."""
    model = _load("v357_synthetic_model.json")
    pairs = [("clinical_care", "settlement"), ("settlement", "merchandising"),
             ("merchandising", "clinical_care"), ("aftersales", "settlement")]
    for src, dst in pairs:
        m = copy.deepcopy(model)
        src_prod = m["model"]["domains"][[d["name"] for d in m["model"]["domains"]].index(src)]["products"][0]["name"]
        batch = types.SimpleNamespace(
            batch_id="BX", vreq_ids=["PX"],
            data_payload=[{"source_quote": f"PRIORITY 1 — move_product: {src}.{src_prod} — move to {dst} because test"}],
            target_entities=[], intent_summary="",
        )
        vs.register(ah, m, vs.spec("PX", "move_product", [f"{src}.{src_prod}"], destination_domain=dst))
        nm, _ = ah._v337_deterministic_mutate(batch, m, _logger())
        assert nm is not None, f"move {src}->{dst} must apply"
        doms = {d["name"]: [p["name"] for p in d["products"]] for d in nm["model"]["domains"]}
        assert src_prod in doms[dst] and src_prod not in doms[src], f"move {src}->{dst} failed"
        others = {d["name"]: [p["name"] for p in d["products"]] for d in model["model"]["domains"] if d["name"] not in (src, dst)}
        assert {k: doms[k] for k in others} == others, f"move {src}->{dst} must not touch any other domain"


if __name__ == "__main__":
    sys.exit(pytest.main([__file__, "-v"]))
