"""v4.1.5 behavioral tests -- two root-cause fixes from the fresh v4.1.4 cross-industry
vov audit (automotive 76.2 / construction 90.5 / travel 82.8 / ngo 79.6):

RC#1 v415-verify-add-attr -- MISSION #1 lying-scoreboard lever. Add-column / add-FK
   VReqs that NAME their exact target ('On field_services.mobile_service_order add
   column party_id BIGINT FK->customer.party.party_id') had NO deterministic verifier
   (scope/scope_targets carried no 3-part triple), so _verify_deterministic returned
   None and the COARSE _verify_state_diff fallback scored them 'partial: Model changed
   but cannot confirm intent' even though the column IS present in the v2 model dict.
   Fix: a dict-grounded verifier that parses the column location+name (+optional FK)
   from the VReq text. PURE FALSE-NEGATIVE RECOVERY -- returns a verdict ONLY when the
   named column is present (fulfilled, or partial when an FK target is named but wrong);
   returns None for absent columns/products so it can NEVER false-fulfill a genuine gap.

RC#2 v415-empty-domain-final-export-sweep -- empty husk domains (consolidating /
   isolation / otherwise / data_governance) shipped in automotive's model.json with 0
   products while the v4.1.4 husk gate logged dropped=0. Root cause: every prior
   _cleanup_empty_domains call site ran on the FLAT lists BEFORE step_generate_data_model_json's
   phantom-product exclusion (0-attribute products) empties the husk in the EXPORT set.
   Fix: re-sweep the SAME _cleanup_empty_domains against the export-filtered products at
   the authoritative artifact point, with identical §3b/§3c protections.

Each test proves fail-pre on the v4.1.4 backup (/tmp/agent_pre_v415.ipynb) and pass-post
on the live notebook (CLAUDE.md §8.10).
"""
import json
import os
import types

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v415.ipynb"


def _full_src(path):
    nb = json.load(open(path))
    return "".join(
        "".join(c.get("source", [])) if isinstance(c.get("source"), list) else c.get("source", "")
        for c in nb["cells"]
    )


class _Logger:
    def info(self, *a, **k):
        pass

    def warning(self, *a, **k):
        pass

    def error(self, *a, **k):
        pass


def _prods(pairs):
    return [{"domain": d, "product": p} for d, p in pairs]


def _attr(d, p, a, fk=None):
    x = {"domain": d, "product": p, "attribute": a}
    if fk:
        x["foreign_key_to"] = fk
    return x


# ============================== version =====================================
def test_version_bumped_to_415():
    ver = tuple(int(x) for x in ah.__AGENT_VERSION__.split("."))
    assert ver >= (4, 1, 5), ah.__AGENT_VERSION__


# ===================== RC#1 add-column / add-FK spec verdicts (POST) ====================
PRODS = _prods([("field_services", "mobile_service_order"), ("customer", "party")])
SPEC_FK = vs.spec("VREQ-T", "add_column", ["field_services.mobile_service_order"], columns=[{"name": "party_id", "type": "BIGINT"}],
                  fk_target="customer.party.party_id", column_type="BIGINT")
SPEC_NO_FK = vs.spec("VREQ-T", "add_column", ["field_services.mobile_service_order"], columns=[{"name": "dispatch_notes", "type": ""}])


def _verdict(spec, products, attrs):
    vs.register(ah, ah.widgets_flat_to_model([], [dict(p, primary_key=p["product"] + "_id") for p in PRODS], []), spec)
    return ah._verify_from_spec(ah.vreq_spec(spec["id"]), [], products, attrs, _Logger(), spec["id"])


def test_add_fk_present_correct_fulfilled():
    attrs = [_attr("field_services", "mobile_service_order", "party_id", "customer.party.party_id")]
    v = _verdict(SPEC_FK, PRODS, attrs)
    assert v is not None and v["status"] == "fulfilled", v
    assert "[verifier-spec FIRED v5.3.3]" in v["evidence"]
    elsewhere = _verdict(SPEC_FK, PRODS, [_attr("field_services", "work_order", "party_id", "customer.party.party_id")])
    assert elsewhere["status"] == "failed", elsewhere


def test_add_fk_present_wrong_target_failed():
    attrs = [_attr("field_services", "mobile_service_order", "party_id", "vehicle.unit.unit_id")]
    v = _verdict(SPEC_FK, PRODS, attrs)
    assert v is not None and v["status"] == "failed", v


def test_add_column_no_fk_present_fulfilled():
    attrs = [_attr("field_services", "mobile_service_order", "dispatch_notes")]
    v = _verdict(SPEC_NO_FK, PRODS, attrs)
    assert v is not None and v["status"] == "fulfilled", v
    elsewhere = _verdict(SPEC_NO_FK, PRODS, [_attr("field_services", "work_order", "dispatch_notes")])
    assert elsewhere["status"] == "failed", elsewhere


def test_add_column_absent_is_failed_never_fulfilled():
    attrs = [_attr("field_services", "mobile_service_order", "some_other_col")]
    v = _verdict(SPEC_FK, PRODS, attrs)
    assert v is not None and v["status"] == "failed", v


def test_add_column_product_absent_is_failed_never_fulfilled():
    prods = _prods([("customer", "party")])  # mobile_service_order absent
    v = _verdict(SPEC_FK, prods, [])
    assert v is not None and v["status"] == "failed", v


def test_add_column_domain_prefix_tolerant():
    # SSOT rename: product physically named field_services_mobile_service_order;
    # the verifier must still resolve the unprefixed VReq target.
    prods = _prods([("field_services", "field_services_mobile_service_order"), ("customer", "party")])
    attrs = [_attr("field_services", "field_services_mobile_service_order", "party_id",
                   "customer.party.party_id")]
    assert _verdict(SPEC_FK, prods, attrs)["status"] == "failed", "no rename was recorded, so the old name is not credited"
    ah._vov_note_product_rename("field_services", "mobile_service_order", "field_services", "field_services_mobile_service_order",
                                "pass:p074_product_name_collision")
    wrong = [_attr("field_services", "field_services_mobile_service_order", "party_id", "vehicle.unit.unit_id")]
    assert _verdict(SPEC_FK, prods, wrong)["status"] != "fulfilled"
    v = _verdict(SPEC_FK, prods, attrs)
    assert v is not None and v["status"] == "fulfilled", v


# ===================== RC#2 husk export sweep (POST) ========================
def test_cleanup_drops_empty_husk_against_export_products():
    # the mechanism the export sweep relies on: a domain with NO covering product is dropped
    domains = [{"domain": "sales"}, {"domain": "isolation"}]
    products = [{"domain": "sales", "product": "order"}]  # 'isolation' has 0 products
    dropped = ah._cleanup_empty_domains(domains, products, logger=_Logger())
    assert dropped == ["isolation"], dropped
    assert [d["domain"] for d in domains] == ["sales"], domains


def test_cleanup_protects_user_vibed_new_domain():
    # §3c protection: a user-vibed-new empty domain is KEPT (never dropped)
    domains = [{"domain": "sales"}, {"domain": "new_analytics"}]
    products = [{"domain": "sales", "product": "order"}]
    dropped = ah._cleanup_empty_domains(domains, products, logger=_Logger(),
                                        user_vibed_new_domains=["new_analytics"])
    assert "new_analytics" not in dropped, dropped
    assert {"new_analytics"} <= {d["domain"] for d in domains}


# ===================== live-source wiring (POST) ============================
def test_export_sweep_wired_after_phantom_exclusion_POST(agent_source_text):
    src = agent_source_text
    assert "v415-empty-domain-final-export-sweep FIRED" in src
    assert "_cleanup_empty_domains(domains, products_for_export" in src
    # must run AFTER products_for_export is finalized (post phantom-product exclusion)
    pf_at = src.find("    products = products_for_export")
    sweep_at = src.find("_cleanup_empty_domains(domains, products_for_export")
    assert pf_at != -1 and sweep_at != -1 and pf_at < sweep_at


def test_spec_verifier_wired_after_the_open_field_verdict_POST(agent_source_text):
    src = agent_source_text
    assert "alias=verifier-spec" in src
    assert "self._v415_verify_add_attr(" not in src
    for method in ("    def _verify_requirement(self", "    def _verify_deterministic(self"):
        start = src.find(method)
        assert start != -1, method
        body = src[start:src.find("\n    def ", start + len(method))]
        open_at = body.find("_vibe_scope_open_field_verdict(req, domains_data, products_data, attributes_data, self.logger)")
        spec_at = body.find("_verify_from_spec(vreq_spec(req), domains_data, products_data, attributes_data, self.logger")
        assert -1 < open_at < spec_at, method


# ===================== RC#3 B7 column rename ====================
# ngo VREQ-034 (supply_category_code -> commodity_category_code): a column rename the
# fast path never applied. The classifier's rename_column spec now builds the op; a spec
# whose new name is not one identifier, that names no column, or whose source column is
# absent never mutates.
RA_FQN = "procurement.purchase_order"


def _ra_model():
    return ah.widgets_flat_to_model([], [{"domain": "procurement", "product": "purchase_order", "primary_key": "purchase_order_id"}],
                                    [{"domain": "procurement", "product": "purchase_order", "attribute": a}
                                     for a in ("purchase_order_id", "supply_category_code")])


def _ra_columns(model):
    return [a["name"] for a in model["model"]["domains"][0]["products"][0]["attributes"]]


def test_column_rename_spec_renames_the_column_and_misreadings_never_mutate_POST():
    model = _ra_model()
    vs.register(ah, model, vs.spec("VREQ-034", "rename_column", [RA_FQN + ".supply_category_code"], new_name="commodity_category_code"))
    assert ah._vreq_spec_det_ops(ah.vreq_spec("VREQ-034"), model) == [
        ("rename_attribute", "procurement", "purchase_order", "supply_category_code", "commodity_category_code")]
    ok, evidence = ah._v410_deterministic_selffix(model, {"id": "VREQ-034"}, _Logger())
    assert ok is True, evidence
    assert _ra_columns(model) == ["purchase_order_id", "commodity_category_code"]
    for spec, reason in (
            (vs.spec("VREQ-035", "rename_column", [RA_FQN + ".supply_category_code"], new_name="commodity category code"),
             "no_deterministic_action"),
            (vs.spec("VREQ-035", "rename_column", [RA_FQN], new_name="commodity_category_code"), "no_deterministic_action"),
            (vs.spec("VREQ-035", "rename_column", [RA_FQN + ".no_such_column"], new_name="commodity_category_code"),
             "rename_attribute_apply_failed")):
        model = _ra_model()
        vs.register(ah, model, spec)
        assert ah._v410_deterministic_selffix(model, {"id": "VREQ-035"}, _Logger()) == (None, reason), spec
        assert model == _ra_model(), spec


# ============================== FAILPRE =====================================
@pytest.mark.skipif(not os.path.exists(NB_PRE), reason="pre-v415 backup absent")
def test_add_attr_verifier_absent_pre_patch_FAILPRE():
    pre = _full_src(NB_PRE)
    assert "_v415_verify_add_attr" not in pre, "v4.1.4 must NOT have the add-attr verifier"
    assert "v415-empty-domain-final-export-sweep" not in pre, "v4.1.4 must NOT have the export sweep"
    assert "v415-rename-attr-bare-action" not in pre, "v4.1.4 must NOT have the bare-action col-rename branch"
