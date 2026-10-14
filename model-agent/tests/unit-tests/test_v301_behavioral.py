"""Behavioral tests for v3.0.1 stub-merge routing fix (audit 2026-06-01).

ROOT CAUSE (ngo/travel/restaurants/construction <85% adherence): a directive
"stub table X must be renamed to existing Y" was classified action=table/surgical
(not rename_product), so it skipped the deterministic collision-aware rename
handler, fell to LLM synthesis, produced an empty diff (noop_failed) for 10 iters,
the stub survived, and DDL hit FK COLUMN_NOT_FOUND + fidelity precision drift ->
the gate rejected the model.

FIX (alias=v301-rename-merge-reclassify):
  - _v251_apply_pass1_priorities reclassifies such generic-action VREQs to
    rename_product (guarded: source product must exist and not be must_have/
    protected) so the existing handler collapses the stub deterministically.
  - Since v5.3.3 the new name comes from the LLM requirement spec (vreq_spec);
    no regex reads the directive text.

These tests register the spec the classifier would return and drive the REAL
notebook code end-to-end, asserting OBSERVABLE state change (stub removed, inbound
FK redirected, rename ledgered). test_control_without_a_rename_spec_the_stub_survives
proves the reclassifier is load-bearing (the same rename wording without a rename
spec leaves the stub = pre-patch behaviour), so the suite is non-tautological per
CLAUDE.md 8.10.
"""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

SRC = notebook_concat_source()
STUB = "volunteer.volunteer_deployment2"
RENAME_REASON = ("The stub table volunteer.volunteer_deployment2 must be renamed to "
                 "volunteer_redeployment because it duplicates the redeployment entity.")
apply_pass1 = ah._v251_apply_pass1_priorities


class _Log:
    def __init__(self):
        self.lines = []

    def info(self, msg, *a, **k):
        self.lines.append(str(msg))

    def warning(self, msg, *a, **k):
        self.lines.append(str(msg))


def _stub_model():
    return {
        "model": {
            "domains": [
                {
                    "name": "volunteer",
                    "products": [
                        {
                            "name": "volunteer_deployment2",
                            "attributes": [
                                {"name": "volunteer_deployment2_id", "is_primary_key": True},
                                {"name": "orig_site_id", "foreign_key_to": "field.project_site.project_site_id"},
                            ],
                        },
                        {
                            "name": "volunteer_redeployment",
                            "attributes": [{"name": "volunteer_redeployment_id", "is_primary_key": True}],
                        },
                    ],
                },
                {
                    "name": "field",
                    "products": [
                        {"name": "project_site", "attributes": [{"name": "project_site_id", "is_primary_key": True}]}
                    ],
                },
                {
                    "name": "workforce",
                    "products": [
                        {
                            "name": "timesheet",
                            "attributes": [
                                {"name": "timesheet_id", "is_primary_key": True},
                                {"name": "dep2_ref_id",
                                 "foreign_key_to": "volunteer.volunteer_deployment2.volunteer_deployment2_id"},
                            ],
                        }
                    ],
                },
            ]
        }
    }


def _product_names(model, domain):
    for d in model["model"]["domains"]:
        if d["name"] == domain:
            return [p["name"] for p in d["products"]]
    return []


def _find_attr(model, domain, product, attr):
    for d in model["model"]["domains"]:
        if d["name"] == domain:
            for p in d["products"]:
                if p["name"] == product:
                    for a in p["attributes"]:
                        if a["name"] == attr:
                            return a
    return None


def _priority(vreq_id, priority_id, reason=RENAME_REASON):
    return {"action": "table", "target": STUB, "priority_id": priority_id, "vreq_id": vreq_id, "reason": reason}


def _rename_spec(vreq_id, **fields):
    return vs.spec(vreq_id, "rename_product", [STUB], new_name="volunteer_redeployment", **fields)


# --- end-to-end reclassify + collapse (observable state change) ------------

def test_reclassify_collapses_stub_and_redirects_fk():
    model = _stub_model()
    vs.register(ah, model, _rename_spec("VREQ-024"))
    priority = _priority("VREQ-024", 24)
    log = _Log()
    new_model, outcomes, residual = apply_pass1([priority], model, log)

    assert "volunteer_deployment2" not in _product_names(new_model, "volunteer"), \
        "stub volunteer_deployment2 must be collapsed/removed"
    assert "volunteer_redeployment" in _product_names(new_model, "volunteer")
    fk = _find_attr(new_model, "workforce", "timesheet", "dep2_ref_id")
    assert fk is not None
    assert fk["foreign_key_to"] == "volunteer.volunteer_redeployment.volunteer_deployment2_id", \
        f"inbound FK must be redirected to the target, got {fk.get('foreign_key_to')}"
    assert not residual, "reclassified rename must not fall to LLM-synthesis residual"
    assert [(o.vreq_ids, o.status) for o in outcomes] == [(("VREQ-024",), "applied")], "VREQ-024 must be applied"
    assert priority["action"] == "rename_product"
    assert any("[v301-rename-merge-reclassify FIRED]" in line and "collision=True prior_action=table" in line for line in log.lines)
    assert ah.vov_rename_events() == [{"kind": "product", "old": "volunteer.volunteer_deployment2",
                                       "new": "volunteer.volunteer_redeployment", "cause": "VREQ-024"}]


@pytest.mark.parametrize("spec", [
    vs.spec("VREQ-025", "add_column", [STUB], columns=[{"name": "redeployment_priority", "type": "STRING"}]),
    _rename_spec("VREQ-025", interpretable=False, reason="two readings"),
    None,
], ids=["add_column_spec", "uninterpretable_rename_spec", "no_spec"])
def test_control_without_a_rename_spec_the_stub_survives(spec):
    """Non-tautology (CLAUDE.md 8.10): the reason still says 'must be renamed', but without an
    interpretable rename spec the generic 'table' VREQ is NOT reclassified, falls to residual, and
    the stub SURVIVES -- exactly the pre-patch failure behaviour. Proves the reclassifier is
    load-bearing and never reads the wording."""
    model = _stub_model()
    if spec:
        vs.register(ah, model, spec)
    priority = _priority("VREQ-025", 25)
    log = _Log()
    new_model, outcomes, residual = apply_pass1([priority], model, log)

    assert "volunteer_deployment2" in _product_names(new_model, "volunteer"), \
        "without a rename spec the stub must survive (pre-patch behaviour)"
    if spec and spec.get("action") == "add_column":
        assert priority["action"] == "add_attribute", "an add-column spec relabels the priority to the column action, never to a rename"
        assert _find_attr(new_model, "volunteer", "volunteer_deployment2", "redeployment_priority") is not None
        assert [o.vreq_ids for o in outcomes] == [("VREQ-025",)] and residual == []
    else:
        assert priority["action"] == "table", "non-rename VREQ must not be reclassified"
        assert [p["vreq_id"] for p in residual] == ["VREQ-025"] and outcomes == [], \
            "the un-reclassified VREQ should be residual, not silently applied"
    assert _find_attr(new_model, "workforce", "timesheet", "dep2_ref_id")["foreign_key_to"] == \
        "volunteer.volunteer_deployment2.volunteer_deployment2_id"
    assert not any("v301-rename-merge-reclassify FIRED" in line for line in log.lines)
    assert ah.vov_rename_events() == []


@pytest.mark.parametrize("flag", ["must_have", "protected", "is_protected", "user_specified"])
def test_must_have_source_not_reclassified(flag):
    """3b guard: a rename spec whose SOURCE product is must_have/protected
    must NOT be reclassified away."""
    model = _stub_model()
    for d in model["model"]["domains"]:
        if d["name"] == "volunteer":
            for p in d["products"]:
                if p["name"] == "volunteer_deployment2":
                    p[flag] = True
    vs.register(ah, model, _rename_spec("VREQ-026"))
    priority = _priority("VREQ-026", 26, "rename volunteer_deployment2 to volunteer_redeployment")
    _new_model, outcomes, residual = apply_pass1([priority], model, _Log())
    assert priority["action"] == "table", "must_have source product must not be reclassified/renamed"
    assert "volunteer_deployment2" in _product_names(model, "volunteer")
    assert [p["vreq_id"] for p in residual] == ["VREQ-026"] and outcomes == []
    assert ah.vov_rename_events() == []


# --- static contracts ------------------------------------------------------

def test_fired_alias_present():
    assert "[v301-rename-merge-reclassify FIRED]" in SRC


def test_version_is_301():
    import re as _re
    m = _re.search(r'__AGENT_VERSION__\s*=\s*"(\d+)\.(\d+)\.(\d+)"', SRC)
    assert m, "version constant not found"
    assert tuple(int(x) for x in m.groups()) >= (3, 0, 1), f"version {m.groups()} < 3.0.1"
