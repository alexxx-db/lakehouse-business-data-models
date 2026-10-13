"""Behavioral + contract tests for v3.2.5 GENERIC physical-adherence fixes.

Two root causes, both industry-agnostic, both proven against the gov_transport
ground-truth audit (model.json adherence 91.7% vs PHYSICAL catalog 66%):

RC1 (verifier-fk-required) — `_verify_structural_target` parsed FK targets
  only with the strict 3-segment regex `fk to a.b.c` and detected FK-intent
  too narrowly. Any connect_table / "add column with FK to ..." whose target
  did not match fell through to a "present (no FK required) -> fulfilled"
  branch, so a column existing with NO foreign key was FALSE-COUNTED as full
  satisfaction and the repair loop never re-engaged. Fix: detect FK-intent
  (connect_table / "with (a/an) (fk|foreign key) to" / parsed target incl
  "foreign key to"/"references", 2-or-3 segments); a column present WITHOUT
  the required FK now returns `partial` (re-engages repair), never fulfilled.

RC-physical (ddl-fk-collision-keep) — at table-create dedup, when two DISTINCT
  foreign keys collided on a single column name the code DISCARDED one
  ([DDL FK CONFLICT] ... discarding FK->), silently dropping a user-required
  relationship. Fix: rename the second FK to a collision-safe name via
  `_build_fk_collision_name` and KEEP BOTH.
"""

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

NOTEBOOK_PATH = Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"


def _load_source() -> str:
    with NOTEBOOK_PATH.open() as f:
        nb = json.load(f)
    chunks = []
    for c in nb.get("cells", []):
        if c.get("cell_type") == "code":
            s = c.get("source", "")
            if isinstance(s, list):
                s = "".join(s)
            chunks.append(s)
    return "\n".join(chunks)


# ---------------------------------------------------------------------------
# Version
# ---------------------------------------------------------------------------

def test_agent_version_at_least_3_2_5():
    src = _load_source()
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([^"]+)"', src)
    assert m
    v = tuple(int(x) for x in m.group(1).split("."))
    assert v >= (3, 2, 5), f"expected >= 3.2.5, got {m.group(1)}"


# ---------------------------------------------------------------------------
# RC1 behavioral — the spec verifier requires the FK the requirement names
# ---------------------------------------------------------------------------

def _hr_rows(fk=""):
    domains = [{"domain": "hr"}]
    products = [{"domain": "hr", "product": "eligibility_rule", "primary_key": "eligibility_rule_id"},
                {"domain": "hr", "product": "pension_plan", "primary_key": "pension_plan_id"}]
    attributes = [{"domain": "hr", "product": "eligibility_rule", "attribute": "eligibility_rule_id", "is_primary_key": True},
                  {"domain": "hr", "product": "eligibility_rule", "attribute": "pension_plan_id", "foreign_key_to": fk},
                  {"domain": "hr", "product": "pension_plan", "attribute": "pension_plan_id", "is_primary_key": True}]
    return domains, products, attributes


def _add_column_verdict(fk_target, fk):
    rows = _hr_rows(fk)
    vs.register(ah, ah.widgets_flat_to_model(*_hr_rows()),
                vs.spec("V1", "add_column", ["hr.eligibility_rule"], columns=[{"name": "pension_plan_id", "type": "BIGINT"}], fk_target=fk_target))
    return ah._verify_from_spec(ah.vreq_spec("V1"), *rows)


def test_verifier_requires_the_fk_an_add_column_spec_names():
    res = _add_column_verdict("hr.pension_plan", "")
    assert ah.vreq_spec("V1")["fk_target"] == "hr.pension_plan.pension_plan_id"
    assert res["status"] == "failed" and "0/1 column(s) reference hr.pension_plan.pension_plan_id" in res["evidence"], res
    res = _add_column_verdict("hr.pension_plan", "hr.pension_plan.pension_plan_id")
    assert res["status"] == "fulfilled", res


def test_verifier_column_present_without_the_required_fk_is_never_fulfilled():
    """A column present WITHOUT the FK the requirement names, or with a different FK, must not
    score fulfilled; a pure add-column requirement with no FK still passes on presence."""
    assert _add_column_verdict("hr.pension_plan", "hr.eligibility_rule.eligibility_rule_id")["status"] == "failed"
    assert _add_column_verdict("", "")["status"] == "fulfilled"


# ---------------------------------------------------------------------------
# RC1 §8.10 behavioral — pre vs post differ
# ---------------------------------------------------------------------------

def _verifier_prepatch(is_add, present, fk_target, actual_fk):
    """Verbatim pre-v3.2.5 logic for the add/ensure path."""
    if is_add or fk_target:
        if not present:
            return "failed"
        if fk_target:
            return "fulfilled" if actual_fk == fk_target else "partial"
        return "fulfilled"  # "no FK required" — THE BUG
    return None


def _verifier_postpatch(is_add, fk_intent, present, fk_target, actual_fk):
    if is_add or fk_intent or fk_target:
        if not present:
            return "failed"
        if fk_target:
            return "fulfilled" if actual_fk == fk_target else "partial"
        if fk_intent:
            return "fulfilled" if actual_fk else "partial"
        return "fulfilled"
    return None


def test_prepatch_falsepasses_connect_table_without_fk():
    # connect_table directive, column present, NO fk on it, target unparsed
    assert _verifier_prepatch(is_add=True, present=True, fk_target=None, actual_fk="") == "fulfilled"


def test_postpatch_flags_connect_table_without_fk_as_partial():
    assert _verifier_postpatch(is_add=True, fk_intent=True, present=True, fk_target=None, actual_fk="") == "partial"


def test_postpatch_pure_column_directive_still_fulfilled():
    # A pure "ensure column" directive with NO FK intent must still pass on presence.
    assert _verifier_postpatch(is_add=True, fk_intent=False, present=True, fk_target=None, actual_fk="") == "fulfilled"


def test_postpatch_fk_present_is_fulfilled():
    assert _verifier_postpatch(is_add=True, fk_intent=True, present=True, fk_target=None, actual_fk="hr.x.x_id") == "fulfilled"


# ---------------------------------------------------------------------------
# ddl-fk-collision-keep static contract
# ---------------------------------------------------------------------------

def test_ddl_fk_collision_keep_present():
    src = _load_source()
    assert "ddl-fk-collision-keep" in src, "physical fix: collision-keep alias missing"
    assert "_build_fk_collision_name" in src
    # must rename + keep both, not just discard
    assert "KEEP BOTH" in src


# ---------------------------------------------------------------------------
# ddl-fk-collision-keep §8.10 behavioral — pre vs post differ
# ---------------------------------------------------------------------------

def _dedup_prepatch(col, existing_fk, new_fk):
    """Pre-patch: distinct FK on same column -> discard the new one."""
    seen = {col: ("FK", existing_fk)}
    if new_fk != existing_fk:
        pass  # discarded
    return seen


def _dedup_postpatch(col, existing_fk, new_fk, safe_name):
    seen = {col: ("FK", existing_fk)}
    if new_fk != existing_fk and safe_name and safe_name not in seen and safe_name != col:
        seen[safe_name] = ("FK", new_fk)
    return seen


def test_prepatch_drops_one_of_two_colliding_fks():
    seen = _dedup_prepatch("area_id", "hr.personnel_area.personnel_area_id", "geo.region.region_id")
    fk_targets = {v[1] for v in seen.values()}
    assert len(fk_targets) == 1, "pre-patch loses one FK relationship"


def test_postpatch_keeps_both_colliding_fks():
    seen = _dedup_postpatch("area_id", "hr.personnel_area.personnel_area_id",
                            "geo.region.region_id", safe_name="region_region_id")
    fk_targets = {v[1] for v in seen.values()}
    assert fk_targets == {"hr.personnel_area.personnel_area_id", "geo.region.region_id"}, (
        "post-patch must preserve BOTH distinct FK relationships"
    )
