"""
v3.8.4 behavioral test for the canonical-key root-cause fix (alias=canonical-key-apply).

ROOT CAUSE (gov_transport VREQ PK-convention): the vibe declared canonical keys
('`position_number` is the canonical position key') but the agent's surrogate-key heuristic
set product primary_key='position_id', overriding the explicit user directive (CLAUDE.md 3c
violation: heuristic beat vibe). 3/4 gov_transport canonical keys were already correct; position was not.

FIX: _v384_apply_canonical_keys honors every canonical key an LLM read from the vibe (a set_primary_key
requirement spec) as the product primary_key, AND re-points any FK that referenced the old PK column so
FK integrity is preserved (no 'FK points to non-PK' defect). Generic/industry-agnostic.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


class _Logger:
    def __init__(self):
        self.msgs = []

    def info(self, m):
        self.msgs.append(m)

    def warning(self, m):
        self.msgs.append(m)


def _register(products_data, attributes_data, *specs):
    vs.register(ah, ah.widgets_flat_to_model([{"domain": "hr"}], products_data, attributes_data), *specs)


def test_apply_honors_canonical_and_repoints_fk():
    """fail-pre/pass-post: position PK swaps to canonical AND the FK is re-pointed."""
    products_data = [
        {"domain": "hr", "product": "position", "primary_key": "position_id"},
        {"domain": "hr", "product": "employee", "primary_key": "employee_id"},
    ]
    attributes_data = [
        {"domain": "hr", "product": "position", "attribute": "position_id"},
        {"domain": "hr", "product": "position", "attribute": "position_number"},
        {"domain": "hr", "product": "employee", "attribute": "employee_id"},
        {"domain": "hr", "product": "employee_assignment", "attribute": "position_ref",
         "foreign_key_to": "hr.position.position_id"},
    ]
    _register(products_data, attributes_data, vs.spec("VREQ-001", "set_primary_key", ["hr.position.position_number"]),
              vs.spec("VREQ-002", "set_primary_key", ["hr.employee.employee_id"]))

    # PRE-state (the v383 defect): position PK is the surrogate; FK points at surrogate
    assert products_data[0]["primary_key"] == "position_id"
    assert attributes_data[3]["foreign_key_to"] == "hr.position.position_id"

    n = ah._v384_apply_canonical_keys(products_data, attributes_data, {}, _Logger())

    # POST-state: canonical honored, employee untouched (already canonical), FK re-pointed
    assert n == 1, n
    assert products_data[0]["primary_key"] == "position_number"
    assert products_data[1]["primary_key"] == "employee_id"  # no-op, already canonical
    assert attributes_data[3]["foreign_key_to"] == "hr.position.position_number"  # integrity preserved


def test_no_fabrication_when_column_absent():
    """If the declared canonical column does not exist on the product, do NOT change PK."""
    products_data = [{"domain": "hr", "product": "position", "primary_key": "position_id"}]
    attributes_data = [{"domain": "hr", "product": "position", "attribute": "position_id"}]
    _register(products_data, attributes_data, vs.spec("VREQ-001", "set_primary_key", ["hr.position.position_number"]))
    n = ah._v384_apply_canonical_keys(products_data, attributes_data, {}, _Logger())
    assert n == 0
    assert products_data[0]["primary_key"] == "position_id"


def test_noop_when_no_canonical_directive():
    products_data = [{"domain": "hr", "product": "position", "primary_key": "position_id"}]
    attributes_data = [{"domain": "hr", "product": "position", "attribute": "position_id"},
                       {"domain": "hr", "product": "position", "attribute": "position_number"}]
    _register(products_data, attributes_data,
              vs.spec("VREQ-001", "set_fields", ["hr.position.position_number"], fields=[vs.field("attributes", "description")]))
    n = ah._v384_apply_canonical_keys(products_data, attributes_data, {}, _Logger())
    assert n == 0
    assert products_data[0]["primary_key"] == "position_id"
