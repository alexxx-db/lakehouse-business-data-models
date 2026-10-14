import json, os
import pytest

import agent_helpers as ah
import vreq_spec_util as vs

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")
NB_PRE = "/tmp/agent_pre_v337.ipynb"


def _full_src(path):
    nb = json.load(open(path))
    return "".join(
        "".join(c.get("source", [])) if isinstance(c.get("source"), list) else c.get("source", "")
        for c in nb["cells"]
    )


class _Batch:
    def __init__(self, rows=(), intent="", targets=(), bid="B1", vreq_ids=("V1",)):
        self.batch_id = bid
        self.vreq_ids = vreq_ids
        self.intent_summary = intent
        self.target_entities = targets
        self.data_payload = tuple(rows)


class _Log:
    def info(self, *a, **k): pass
    def warning(self, *a, **k): pass
    def error(self, *a, **k): pass


def _row(pid, action, target, reason):
    sq = f"**PRIORITY {pid} \u2014 {action}: {target}** \u2014 {reason}"
    return {"intent": reason, "target": target, "source_quote": sq}


def _model():
    return {
        "model": {
            "domains": [
                {
                    "name": "project",
                    "products": [
                        {"name": "dsctr_category", "table_name": "dsctr_category",
                         "primary_key": "dsctr_category_id",
                         "attributes": [
                             {"name": "dsctr_category_id", "column_name": "dsctr_category_id", "type": "BIGINT"},
                             {"name": "label", "column_name": "label", "type": "STRING"},
                         ]},
                        {"name": "dsctr_group_control", "table_name": "dsctr_group_control",
                         "primary_key": "dsctr_group_control_id",
                         "attributes": [
                             {"name": "dsctr_group_control_id", "column_name": "dsctr_group_control_id", "type": "BIGINT"},
                             {"name": "dsctr_dropdown_lookup_id", "column_name": "dsctr_dropdown_lookup_id", "type": "BIGINT"},
                         ]},
                    ],
                },
                {
                    "name": "hr",
                    "products": [
                        {"name": "position", "table_name": "position", "primary_key": "position_id",
                         "attributes": [
                             {"name": "position_id", "column_name": "position_id", "type": "BIGINT"},
                             {"name": "dsctr_category_id", "column_name": "dsctr_category_id", "type": "BIGINT",
                              "foreign_key_to": "project.dsctr_category.dsctr_category_id"},
                         ]},
                    ],
                },
            ]
        }
    }


def _names(mdl, dom):
    for d in mdl["model"]["domains"]:
        if d["name"] == dom:
            return [p["name"] for p in (d.get("products") or d.get("data_products") or [])]
    return []


def _fk_of(mdl, dom, prod, col):
    for d in mdl["model"]["domains"]:
        if d["name"] == dom:
            for p in (d.get("products") or []):
                if p["name"] == prod:
                    for a in p["attributes"]:
                        if a["name"] == col:
                            return a.get("foreign_key_to")
    return None


# ---------- batched rename_product (the RC8 core that v336 failed) ----------

def test_batched_rename_products_all_in_place_and_fk_rewired():
    m = _model()
    vs.register(ah, m, vs.spec("P008", "rename_product", ["project.dsctr_category"], new_name="pse_category"),
                vs.spec("P013", "rename_product", ["project.dsctr_group_control"], new_name="pse_group_control"))
    batch = _Batch(rows=[
        _row(8, "rename_product", "project.dsctr_category",
             "rename to pse_category because all PSE tables use the pse_ prefix"),
        _row(13, "rename_product", "project.dsctr_group_control",
             "rename to pse_group_control because all PSE tables use the pse_ prefix"),
    ], vreq_ids=("P008", "P013"))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is not None, "pure-rename batch must fire deterministically"
    assert sorted(_names(new_model, "project")) == ["pse_category", "pse_group_control"]
    # PK renamed on the first
    cat = [p for p in new_model["model"]["domains"][0]["products"] if p["name"] == "pse_category"][0]
    assert cat["primary_key"] == "pse_category_id"
    assert any(a["name"] == "pse_category_id" for a in cat["attributes"])
    assert not any(a["name"] == "dsctr_category_id" for a in cat["attributes"])
    # cross-domain FK rewired: hr.position.* -> project.pse_category.pse_category_id
    assert _fk_of(new_model, "hr", "position", "dsctr_category_id") == "project.pse_category.pse_category_id"
    # source untouched
    assert "dsctr_category" in _names(m, "project")


def test_mixed_batch_defers_to_llm():
    # rename + connect_table in one batch -> all-or-nothing -> defer (no false-applied)
    m = _model()
    vs.register(ah, m, vs.spec("P008", "rename_product", ["project.dsctr_category"], new_name="pse_category"),
                vs.spec("P002", "add_column", ["hr.position"], columns=[{"name": "cost_center_id", "type": "BIGINT"}], fk_target="hr.org.org_id"),
                vs.spec("P003", "set_fields", ["hr.position"], fields=[vs.field("products", "description")]))
    assert ah._v337_deterministic_mutate(_Batch(vreq_ids=("P008",)), m, _Log())[0] is not None
    batch = _Batch(rows=[
        _row(8, "rename_product", "project.dsctr_category", "rename to pse_category because prefix"),
        _row(2, "connect_table", "hr.position", "add column cost_center_id (BIGINT) with FK to hr.org.org_id"),
    ], vreq_ids=("P008", "P002"))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is None, "mixed batch with a connect_table must defer the whole batch"
    assert ah._v337_deterministic_mutate(_Batch(vreq_ids=("P008", "P003")), m, _Log()) == (None, "")
    assert "dsctr_category" in _names(m, "project") and "pse_category" not in _names(m, "project")


def test_rename_attribute_renames_column():
    m = _model()
    vs.register(ah, m, vs.spec("P017", "rename_column", ["project.dsctr_group_control.dsctr_dropdown_lookup_id"],
                               new_name="pse_dropdown_lookup_id"))
    batch = _Batch(rows=[
        _row(17, "rename_attribute", "project.dsctr_group_control",
             "rename column dsctr_dropdown_lookup_id to pse_dropdown_lookup_id because of prefix"),
    ], vreq_ids=("P017",))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is not None
    gc = [p for p in new_model["model"]["domains"][0]["products"] if p["name"] == "dsctr_group_control"][0]
    assert any(a["name"] == "pse_dropdown_lookup_id" for a in gc["attributes"])
    assert not any(a["name"] == "dsctr_dropdown_lookup_id" for a in gc["attributes"])


def test_rename_attribute_pk_rewires_fks():
    m = _model()
    vs.register(ah, m, vs.spec("P025", "rename_column", ["project.dsctr_category.dsctr_category_id"], new_name="category_id"))
    batch = _Batch(rows=[
        _row(25, "rename_attribute", "project.dsctr_category",
             "rename column dsctr_category_id to category_id because shorter"),
    ], vreq_ids=("P025",))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is not None
    cat = [p for p in new_model["model"]["domains"][0]["products"] if p["name"] == "dsctr_category"][0]
    assert cat["primary_key"] == "category_id"
    # FK pointing at the old PK col is rewired
    assert _fk_of(new_model, "hr", "position", "dsctr_category_id") == "project.dsctr_category.category_id"


def test_move_product_rewires_domain_prefix():
    m = _model()
    vs.register(ah, m, vs.spec("P030", "move_product", ["project.dsctr_category"], destination_domain="hr"))
    batch = _Batch(rows=[
        _row(30, "move_product", "project.dsctr_category", "move to the hr domain because ownership"),
    ], vreq_ids=("P030",))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is not None
    assert "dsctr_category" not in _names(new_model, "project")
    assert "dsctr_category" in _names(new_model, "hr")
    assert _fk_of(new_model, "hr", "position", "dsctr_category_id") == "hr.dsctr_category.dsctr_category_id"


def test_rename_collision_defers():
    m = _model()
    # rename dsctr_group_control -> dsctr_category (already exists) => merge => defer
    vs.register(ah, m, vs.spec("P008", "rename_product", ["project.dsctr_group_control"], new_name="dsctr_category"))
    batch = _Batch(rows=[
        _row(8, "rename_product", "project.dsctr_group_control", "rename to dsctr_category because merge"),
    ], vreq_ids=("P008",))
    assert ah._v337_build_ops(batch, m) == ([("rename_product", "project", "dsctr_group_control", "dsctr_category")], True)
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is None


def test_a_batch_without_payload_is_driven_by_its_spec_not_its_intent():
    m = _model()
    batch = _Batch(rows=(), intent="Rename product project.dsctr_category to pse_category",
                   targets=(("project", "dsctr_category"),))
    assert ah._v337_deterministic_mutate(batch, m, _Log()) == (None, "")
    vs.register(ah, m, vs.spec("V1", "rename_product", ["project.dsctr_category"], new_name="pse_category"))
    new_model, summary = ah._v337_deterministic_mutate(batch, m, _Log())
    assert new_model is not None
    assert "pse_category" in _names(new_model, "project")


def test_hook_present_in_v337_absent_in_pre():
    post = _full_src(NB)
    assert "vov-deterministic-mutate FIRED v3.3.7" in post
    assert "def _v337_deterministic_mutate(" in post
    if os.path.exists(NB_PRE):
        pre = _full_src(NB_PRE)
        assert "def _v337_deterministic_mutate(" not in pre


def test_version_bumped():
    import re as _re
    m = _re.search(r'__AGENT_VERSION__\s*=\s*"(\d+)\.(\d+)\.(\d+)"', _full_src(NB))
    assert m, "no single-digit-semver __AGENT_VERSION__ literal found"
    assert tuple(int(g) for g in m.groups()) >= (3, 3, 7)
