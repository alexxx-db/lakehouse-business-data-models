"""v3.2.9 — verifier-rename false-fulfillment root-cause fix.

Ground truth (gov_transport mvm_v6 physical audit 2026-06-05): source priorities
P18-P22 (rename_attribute, e.g. project_id -> primary_project_id on
project.asset_impact / project.location / project.plan_inclusion) were marked
ALREADY FULFILLED by the deterministic verifier yet were absent from BOTH
model.json and the gov_transport_v1 catalog. Two false-pass paths:

  (1) verifier-rename-state: the new-name capture regex `\\bto\\s+X` matched
      "...two FKs point to project.project" (the WRONG "to"), found leaf
      `project` present, and returned fulfilled.
  (2) verifier-rename-drop-structural: for scope=='attribute' it compared
      product-level (2-part) scope_targets against 3-part attr_keys. A 2-part
      name can never be in attr_keys, so _still_present was always empty ->
      "rename applied" -> false fulfilled.

The fix (a) anchors the new-name regex to a real "rename <old> to <new>"
construct, and (b) for scope=='attribute' filters old_targets to column
granularity (>=2 dots) and skips the absence shortcut (never false-fulfill)
when only product-level targets remain.

tests test_structural_path_* and test_rename_state_path_* FAIL on pre-patch
HEAD (verifier returns 'fulfilled') and PASS post-patch (no longer fulfilled).
"""
import json
import os
import re
import logging

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

NB = os.path.join(os.path.dirname(__file__), "..", "..", "agent", "dbx_vibe_modelling_agent.ipynb")


def _load_src():
    nb = json.load(open(NB))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


def _build_verifier():
    v = object.__new__(ah.VibeOrchestrator)
    v.logger = logging.getLogger("t")
    return v


def _register(spec, base_attrs):
    tables = sorted({(a["domain"], a["product"]) for a in base_attrs})
    products = [{"domain": d, "product": p, "primary_key": f"{p}_id"} for d, p in tables]
    vs.register(ah, ah.widgets_flat_to_model([], products, base_attrs), spec)


class _Req:
    def __init__(self, rid, text, scope="", targets=None):
        self.id = rid
        self.original_text = text
        self.scope = scope
        self.scope_targets = targets or []
        self.attributes = []


def _attrs_not_renamed():
    # project_id still present (rename project_id->primary_project_id NOT applied)
    return [
        {"domain": "project", "product": "asset_impact", "attribute": "asset_impact_id", "foreign_key_to": None},
        {"domain": "project", "product": "asset_impact", "attribute": "project_id", "foreign_key_to": "project.project.project_id"},
        {"domain": "project", "product": "location", "attribute": "project_id", "foreign_key_to": "project.project.project_id"},
        {"domain": "project", "product": "project", "attribute": "project_id", "foreign_key_to": None},
        {"domain": "hr", "product": "job", "attribute": "job_code_object_code", "foreign_key_to": None},
    ]


def _prods(names):
    return [{"domain": n.split(".")[0], "product": n.split(".")[1]} for n in names]


# ---------------- static contracts ----------------

def test_version_at_least_329():
    m = re.search(r'__AGENT_VERSION__ = "(\d+)\.(\d+)\.(\d+)"', _load_src())
    assert m is not None
    assert tuple(int(x) for x in m.groups()) >= (3, 2, 9)


def test_aliases_present():
    src = _load_src()
    assert "[verifier-spec FIRED v5.3.3]" in src
    assert "alias=verifier-spec" in src
    assert "verifier-rename-granularity-guard" not in src


# ---------- (1) structural false-pass path: product-level targets ----------

def test_rename_column_spec_naming_only_tables_is_not_false_fulfilled():
    """A column-rename spec that names the three tables but no column, rename NOT applied.
    The verifier has no column to check and the op builder builds no op: never fulfilled."""
    v = _build_verifier()
    tables = ["project.asset_impact", "project.location", "project.plan_inclusion"]
    _register(vs.spec("VREQ-029", "rename_column", tables, new_name="project"), _attrs_not_renamed())
    r = _Req(
        "VREQ-029",
        "Rename generic/unlabeled FK columns where two FKs point to project.project. "
        "On project.asset_impact, project.location, and project.plan_inclusion, rename the "
        "generic column to a descriptive label.",
    )
    res = v._verify_deterministic(r, [], [], _attrs_not_renamed())
    assert res["status"] != "fulfilled", res
    assert ah._vreq_spec_det_ops(ah.vreq_spec("VREQ-029")) == []


# ---------- (2) rename-state false-pass path: "point to X" ----------

def test_rename_state_point_to_capture_is_refused_as_a_new_name():
    """Reading 'point to project.project' as the new name gives new_name 'project.project':
    not one identifier, so the spec is not interpretable, the verdict is failed and no op is built."""
    v = _build_verifier()
    _register(vs.spec("VREQ-029b", "rename_column", ["project.asset_impact.project_id"], new_name="project.project"), _attrs_not_renamed())
    r = _Req("VREQ-029b", "Two FKs point to project.project. Rename the generic column to a descriptive label.")
    res = v._verify_deterministic(r, [], _prods(["project.project", "project.asset_impact", "project.location"]), _attrs_not_renamed())
    assert res["status"] == "failed", res
    assert "rename_column names no new name" in res["evidence"], res
    assert ah._vreq_spec_det_ops(ah.vreq_spec("VREQ-029b")) == []


# ---------- correctness regressions (must stay correct) ----------

def test_column_level_rename_applied_is_fulfilled():
    v = _build_verifier()
    attrs = [
        {"domain": "project", "product": "asset_impact", "attribute": "primary_project_id", "foreign_key_to": "project.project.project_id"},
        {"domain": "project", "product": "project", "attribute": "project_id", "foreign_key_to": None},
    ]
    _register(vs.spec("VREQ-020", "rename_column", ["project.asset_impact.project_id"], new_name="primary_project_id"), _attrs_not_renamed())
    r = _Req("VREQ-020", "On project.asset_impact, rename column project_id to primary_project_id to disambiguate.")
    res = v._verify_deterministic(r, [], _prods(["project.asset_impact", "project.project"]), attrs)
    assert res["status"] == "fulfilled", res
    copied = attrs + [_attrs_not_renamed()[1]]
    res = v._verify_deterministic(r, [], _prods(["project.asset_impact", "project.project"]), copied)
    assert res["status"] == "partial", res


def test_column_level_rename_not_applied_is_failed():
    v = _build_verifier()
    _register(vs.spec("VREQ-027", "rename_column", ["hr.job.job_code_object_code"], new_name="code_object_code"), _attrs_not_renamed())
    r = _Req("VREQ-027", "rename column job_code_object_code to code_object_code to remove the redundant product prefix.")
    res = v._verify_deterministic(r, [], _prods(["hr.job"]), _attrs_not_renamed())
    assert res["status"] != "fulfilled", res
    assert res["status"] == "failed", res


# ---------- bucket 2: remove_fk / relation verifier false-pass (P13/VREQ-025) ----------

def _attrs_with_org_fk():
    return [
        {"domain": "project", "product": "dsctr_project_data", "attribute": "organization_id",
         "foreign_key_to": "hr.organization.organization_id"},
        {"domain": "hr", "product": "organization", "attribute": "organization_id", "foreign_key_to": None},
    ]


def test_remove_fk_still_present_is_not_false_fulfilled():
    """remove_fk on the FK column: failed while the to-be-removed FK is still present. A spec
    that names only the referenced table has no column to check and is never credited either."""
    v = _build_verifier()
    r = _Req("VREQ-025", "On project.dsctr_project_data, remove the FK to hr.organization.")
    prods = _prods(["project.dsctr_project_data", "hr.organization"])
    _register(vs.spec("VREQ-025", "remove_fk", ["project.dsctr_project_data.organization_id"]), _attrs_with_org_fk())
    res = v._verify_deterministic(r, [], prods, _attrs_with_org_fk())
    assert res["status"] == "failed", res
    _register(vs.spec("VREQ-025", "remove_fk", ["hr.organization"]), _attrs_with_org_fk())
    res = v._verify_deterministic(r, [], prods, _attrs_with_org_fk())
    assert res["status"] != "fulfilled", res


def test_remove_fk_cleared_on_the_kept_column_is_fulfilled():
    """The named columns stay and lose their FK -> fulfilled; one of the two still linked -> partial."""
    v = _build_verifier()
    r = _Req("VREQ-026", "On project.dsctr_project_data, remove both FKs to hr.organization.")
    prods = _prods(["project.dsctr_project_data", "hr.organization"])
    linked = _attrs_with_org_fk() + [{"domain": "project", "product": "dsctr_project_data", "attribute": "owner_organization_id",
                                       "foreign_key_to": "hr.organization.organization_id"}]
    _register(vs.spec("VREQ-026", "remove_fk", ["project.dsctr_project_data.organization_id",
                                                "project.dsctr_project_data.owner_organization_id"]), linked)
    cleared = [dict(a, foreign_key_to=None) for a in linked]
    res = v._verify_deterministic(r, [], prods, cleared)
    assert res["status"] == "fulfilled", res
    res = v._verify_deterministic(r, [], prods, [cleared[0], linked[1], linked[2]])
    assert res["status"] == "partial", res


def test_remove_fk_actually_removed_is_fulfilled():
    """Same directive but the FK column is gone with its FK -> the remove is genuinely fulfilled.
    The same FK kept under another column name is still an FK to hr.organization -> not fulfilled."""
    v = _build_verifier()
    r = _Req("VREQ-025", "On project.dsctr_project_data, remove the FK to hr.organization.")
    prods = _prods(["project.dsctr_project_data", "hr.organization"])
    _register(vs.spec("VREQ-025", "remove_fk", ["project.dsctr_project_data.organization_id"]), _attrs_with_org_fk())
    kept_as_org_id = [dict(_attrs_with_org_fk()[0], attribute="org_id"), _attrs_with_org_fk()[1]]
    res = v._verify_deterministic(r, [], prods, kept_as_org_id)
    assert res["status"] != "fulfilled", res
    attrs = [{"domain": "hr", "product": "organization", "attribute": "organization_id", "foreign_key_to": None}]
    res = v._verify_deterministic(r, [], prods, attrs)
    assert res["status"] == "fulfilled", res


def test_add_link_relation_still_works():
    """Regression: an add/link relation spec with the FK present stays fulfilled; without it, failed."""
    v = _build_verifier()
    unlinked = [dict(a, foreign_key_to=None) for a in _attrs_with_org_fk()]
    _register(vs.spec("VREQ-100", "add_fk", ["project.dsctr_project_data.organization_id"], fk_target="hr.organization"), unlinked)
    r = _Req("VREQ-100", "Link project.dsctr_project_data to hr.organization via a foreign key.")
    prods = _prods(["project.dsctr_project_data", "hr.organization"])
    res = v._verify_deterministic(r, [], prods, _attrs_with_org_fk())
    assert res["status"] == "fulfilled", res
    res = v._verify_deterministic(r, [], prods, unlinked)
    assert res["status"] == "failed", res
