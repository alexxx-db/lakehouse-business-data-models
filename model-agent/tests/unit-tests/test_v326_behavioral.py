"""v3.2.6 behavioral tests.

RC-A (vov-mislabeled-action-residual): next_vibes sometimes mislabels a
directive's ACTION (e.g. action='rename_attribute' whose body is actually
"ensure pension_plan attribute exists / add pension_plan_id FK", or
action='rename_attribute' whose body is "confirm key is employee_id; attach
glossary term"). The deterministic handler cannot parse the label-implied
fields and returns (False, 'rename-names-missing' / 'rename-new-name-missing').

PRE-PATCH: such a directive was TERMINALLY marked skipped_unsafe and never
added to _residual, so the LLM residual synthesizer (which reads the full
source_quote and could apply the real intent) never saw it -> the vibe was
silently lost even after the agentic loops (the dominant gov_transport mvm_v4 +
Retail ecm_v4 vibe-loss class, ground-truth 2026-06-05).

POST-PATCH: these label/body-mismatch diags are routed into _residual with
outcome status='requeued_residual' and a [vov-mislabeled-action-residual
FIRED v3.2.6] log line. Generic / industry-agnostic; DRY (reuses _residual).
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402
from test_v251_vov_priority_landing import _ListLogger  # noqa: E402


SRC = notebook_concat_source()


def _model_with_product():
    return {
        "model": {
            "domains": [
                {
                    "name": "hr",
                    "products": [
                        {
                            "name": "eligibility_rule",
                            "attributes": [
                                {"name": "eligibility_rule_id", "type": "BIGINT"}
                            ],
                        },
                        {
                            "name": "employee",
                            "attributes": [
                                {"name": "employee_id", "type": "BIGINT"}
                            ],
                        },
                    ],
                }
            ]
        }
    }


def test_rc_a_alias_and_marker_present():
    assert "vov-mislabeled-action-residual" in SRC
    assert "[vov-mislabeled-action-residual FIRED v3.2.6]" in SRC


def test_rc_a_mislabeled_rename_attribute_routes_to_residual():
    """action=rename_attribute but body has NO 'rename column X to Y' clause
    (it is actually an 'ensure/add' directive). Must route to LLM residual,
    not terminal skipped_unsafe."""
    model = _model_with_product()
    vs.register(ah, model, vs.spec("P019", "add_column", ["hr.eligibility_rule"], columns=[{"name": "pension_plan_id", "type": "BIGINT"}],
                                   fk_target="hr.eligibility_rule.eligibility_rule_id"))
    priorities = [
        {
            "priority_id": 19,
            "vreq_id": "P019",
            "action": "rename_attribute",
            "target": "hr.eligibility_rule",
            # mislabeled: body is an ENSURE/ADD directive, not a column rename
            "reason": (
                "ensure pension_plan attribute exists carrying LEORS/CJERS/TSERS "
                "values referenced by KPI-2 calculation; add pension_plan_id (BIGINT) "
                "FK to hr.eligibility_rule.eligibility_rule_id"
            ),
            "source_quote": "**PRIORITY 19 — rename_attribute: hr.eligibility_rule** — ensure pension_plan ...",
        }
    ]

    logger = _ListLogger()
    _updated, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logger)

    # POST-PATCH contract (would FAIL pre-patch: status was skipped_unsafe, residual empty):
    assert len(residual) == 1, "mislabeled directive must be routed into _residual for LLM synthesis"
    assert residual[0]["vreq_id"] == "P019"
    statuses = {o.batch_id: o.status for o in outcomes}
    assert statuses.get("P019") == "requeued_residual", f"expected requeued_residual, got {statuses}"
    assert any("vov-mislabeled-action-residual FIRED" in m for m in logger.warn_msgs)
    assert [a["name"] for a in model["model"]["domains"][0]["products"][0]["attributes"]] == ["eligibility_rule_id"]


def test_rc_a_mislabeled_rename_attribute_confirm_tag_routes_to_residual():
    """action=rename_attribute but body is a confirm+tag directive."""
    model = _model_with_product()
    vs.register(ah, model, vs.spec("P022", "check_only", ["hr.employee.employee_id"]))
    priorities = [
        {
            "priority_id": 22,
            "vreq_id": "P022",
            "action": "rename_attribute",
            "target": "hr.employee",
            "reason": (
                "confirm canonical key column is named employee_id (not employee_key); "
                "CDE-26 Employee-Key is a synonym tag value, not a separate column"
            ),
            "source_quote": "**PRIORITY 22 — rename_attribute: hr.employee** — confirm canonical key ...",
        }
    ]

    logger = _ListLogger()
    _updated, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logger)
    assert len(residual) == 1
    assert {o.status for o in outcomes} == {"requeued_residual"}


def test_rc_a_real_rename_still_applies_deterministically():
    """A genuine 'rename column X to Y' must STILL land in pass1 (not regress
    to residual). This is the discriminating negative case."""
    model = {
        "model": {
            "domains": [
                {
                    "name": "project",
                    "products": [
                        {
                            "name": "asset_impact",
                            "attributes": [
                                {"name": "related_asset_impact_id", "type": "BIGINT"}
                            ],
                        }
                    ],
                }
            ]
        }
    }
    priorities = [
        {
            "priority_id": 19,
            "vreq_id": "P019",
            "action": "rename_attribute",
            "target": "project.asset_impact",
            "reason": "rename column related_asset_impact_id to related_to_asset_impact_id — resolve duplicate FK",
        }
    ]
    vs.register(ah, model, vs.spec("P019", "rename_column", ["project.asset_impact.related_asset_impact_id"],
                                   new_name="related_to_asset_impact_id"))
    logger = _ListLogger()
    _updated, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logger)
    assert residual == [], "a genuine rename must apply deterministically, not route to residual"
    assert {o.status for o in outcomes} == {"applied"}
    attrs = model["model"]["domains"][0]["products"][0]["attributes"]
    names = [a["name"] for a in attrs]
    assert "related_to_asset_impact_id" in names
    assert "related_asset_impact_id" not in names
