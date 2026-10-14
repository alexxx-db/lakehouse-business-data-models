import json
import os
import re
import logging

import agent_helpers as ah
import vreq_spec_util as vs

NB = os.path.join(os.path.dirname(__file__), "..", "..", "agent", "dbx_vibe_modelling_agent.ipynb")


def _load_src():
    nb = json.load(open(NB))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


class _Req:
    def __init__(self, rid, text, targets=None):
        self.id = rid
        self.original_text = text
        self.scope_targets = targets or []


def _attrs():
    # minimal after-state: product project.pse_user with employee_id FK to hr.employee.employee_id
    return [
        {"domain": "project", "product": "pse_user", "attribute": "pse_user_id", "foreign_key_to": None},
        {"domain": "project", "product": "pse_user", "attribute": "employee_id", "foreign_key_to": "hr.employee.employee_id"},
        {"domain": "hr", "product": "employee", "attribute": "employee_id", "foreign_key_to": None},
        {"domain": "project", "product": "spec_cat", "attribute": "original_table_name", "foreign_key_to": None},
    ]


def _prods(attrs):
    return [{"domain": d, "product": p} for d, p in dict.fromkeys((a["domain"], a["product"]) for a in attrs)]


def _verify(spec, attrs=None, catalog=None):
    attrs = _attrs() if attrs is None else attrs
    catalog = attrs if catalog is None else catalog
    domains = [{"domain": d} for d in dict.fromkeys(a["domain"] for a in catalog)]
    vs.register(ah, ah.widgets_flat_to_model(domains, _prods(catalog), catalog), spec)
    return ah._verify_from_spec(ah.vreq_spec(spec["id"]), [], _prods(attrs), attrs)


def test_version_is_309():
    # v3.0.9 fix must be present at v3.0.9 OR LATER (forward bumps must not break this).
    m = re.search(r'__AGENT_VERSION__ = "(\d+)\.(\d+)\.(\d+)"', _load_src())
    assert m is not None
    assert tuple(int(x) for x in m.groups()) >= (3, 0, 9)


def test_helper_exists():
    assert "def _verify_from_spec(" in _load_src()
    assert "alias=verifier-spec" in _load_src()


def test_requirement_and_deterministic_paths_both_take_the_spec_verdict():
    vs.register(ah, ah.widgets_flat_to_model([], _prods(_attrs()), _attrs()), vs.spec(
        "R1", "add_column", ["project.pse_user"], columns=[{"name": "employee_id", "type": "BIGINT"}], fk_target="hr.employee.employee_id"))
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = logging.getLogger("t")
    orch._llm_verify_enabled = False
    orch.ai_agent = None
    req = _Req("R1", "On product project.pse_user, add a column `employee_id` (BIGINT) with an FK to `hr.employee.employee_id`.")
    for verdict in (orch._verify_requirement(req, [], _prods(_attrs()), _attrs()), orch._verify_deterministic(req, [], _prods(_attrs()), _attrs())):
        assert verdict["status"] == "fulfilled", verdict
        assert verdict["evidence"] == "[verifier-spec FIRED v5.3.3] 1/1 column(s) reference hr.employee.employee_id", verdict


def test_landed_add_column_with_fk_is_fulfilled():
    # THE core fix: a column added to an EXISTING product (no count change) must be FULFILLED,
    # not the pre-fix "partial: cannot confirm intent".
    res = _verify(vs.spec("R1", "add_column", ["project.pse_user"], columns=[{"name": "employee_id", "type": "BIGINT"}],
                          fk_target="hr.employee.employee_id"))
    assert res is not None and res["status"] == "fulfilled"


def test_missing_column_is_failed_not_fulfilled():
    res = _verify(vs.spec("R2", "add_column", ["project.pse_user"], columns=[{"name": "does_not_exist", "type": "BIGINT"}],
                          fk_target="hr.employee.employee_id"))
    assert res is not None and res["status"] == "failed"


def test_fk_to_wrong_target_is_failed():
    res = _verify(vs.spec("R3", "add_column", ["project.pse_user"], columns=[{"name": "employee_id", "type": "BIGINT"}],
                          fk_target="hr.organization.organization_id"))
    assert res is not None and res["status"] == "failed"
    assert "0/1 column(s) reference hr.organization.organization_id" in res["evidence"], res


def test_remove_fk_satisfied_is_fulfilled():
    before = [dict(a, foreign_key_to="project.pse_user.pse_user_id") if a["attribute"] == "original_table_name" else a for a in _attrs()]
    spec = vs.spec("R4", "remove_fk", ["project.spec_cat.original_table_name"])
    res = _verify(spec, catalog=before)
    assert res is not None and res["status"] == "fulfilled"
    res = _verify(spec, attrs=before, catalog=before)
    assert res is not None and res["status"] == "failed"


def test_rename_is_judged_by_its_own_rename_check():
    before = _attrs() + [{"domain": "hr", "product": "employee", "attribute": "working_title", "foreign_key_to": None}]
    after = _attrs() + [{"domain": "hr", "product": "employee", "attribute": "position_description", "foreign_key_to": None}]
    spec = vs.spec("R5", "rename_column", ["hr.employee.working_title"], new_name="position_description")
    assert _verify(spec, attrs=after, catalog=before)["status"] == "fulfilled"
    assert _verify(spec, attrs=before, catalog=before)["status"] == "failed"


def test_unresolvable_product_falls_back_to_none():
    res = _verify(vs.spec("R6", "other", [], breadth="model", reason="Reduce the overall model footprint."))
    assert res is None
