"""
v3.8.5 behavioral test for the canonical-key VREQ-011 lifecycle fix
(alias=canonical-key-attr-flag).

ROOT CAUSE (gov_transport v3.8.4 audit, VREQ-011 partial): when a vibe DECLARES a canonical/business
key for an entity, _v384_apply_canonical_keys honored it by setting product['primary_key'] and
re-pointing FKs -- but the PHYSICAL build/PK-tag determines the primary key from the
ATTRIBUTE-level is_primary_key flag (and a 'primary_key' tag token), NOT product['primary_key'].
There is NO sync step between them, so the canonical key never reached the physical table: the PK
constraint/tag stayed on the OLD surrogate column.

FIX: _v384_apply_canonical_keys now also flips the attribute flags -- sets is_primary_key=True on
the canonical column and is_primary_key=False on the old surrogate (stripping its 'primary_key'
tag token) so the physical PK follows the vibe-declared canonical key.

fail-pre/pass-post:
  - test_canonical_attr_flag_flips: canonical attr is_primary_key True, old surrogate False, old
    'primary_key' tag token stripped (pre-patch: both unchanged -> physical PK stays on surrogate).
  - test_product_field_and_fk_still_updated: the v3.8.4 behavior (product['primary_key'] + FK
    repoint) is preserved (no regression).
  - test_noop_when_no_canonical_directive: no directive -> nothing mutated.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


def _register(products, attributes, *specs):
    vs.register(ah, ah.widgets_flat_to_model([{"domain": "hr"}], products, attributes), *specs)


def _canonical_position_key():
    return vs.spec("VREQ-011", "set_primary_key", ["hr.position.position_number"])


def _model():
    products = [{"domain": "hr", "product": "position", "primary_key": "position_id"}]
    attributes = [
        {"domain": "hr", "product": "position", "attribute": "position_id", "is_primary_key": True, "tags": "primary_key,internal"},
        {"domain": "hr", "product": "position", "attribute": "position_number", "is_primary_key": False, "tags": "business_key"},
        # an FK in another product that references the old surrogate PK
        {"domain": "hr", "product": "employee", "attribute": "position_id", "is_primary_key": False, "tags": "", "foreign_key_to": "hr.position.position_id"},
    ]
    return products, attributes


def test_canonical_attr_flag_flips():
    products, attributes = _model()
    _register(products, attributes, _canonical_position_key())
    n = ah._v384_apply_canonical_keys(products, attributes, {}, None)
    assert n == 1, "canonical key should apply once"

    canon = next(a for a in attributes if a["attribute"] == "position_number" and a["product"] == "position")
    old = next(a for a in attributes if a["attribute"] == "position_id" and a["product"] == "position")

    assert canon["is_primary_key"] is True, "canonical column must be flagged PK so physical PK follows it (pre-patch: stayed False)"
    assert old["is_primary_key"] is False, "old surrogate must be demoted (pre-patch: stayed True -> physical PK on surrogate)"
    assert "primary_key" not in (old.get("tags") or "").lower(), "old surrogate 'primary_key' tag token must be stripped (else 'primary_key' in tags re-marks it PK)"


def test_product_field_and_fk_still_updated():
    products, attributes = _model()
    _register(products, attributes, _canonical_position_key())
    ah._v384_apply_canonical_keys(products, attributes, {}, None)
    assert products[0]["primary_key"] == "position_number", "v3.8.4 product field update must be preserved"
    fk = next(a for a in attributes if a["product"] == "employee")
    assert fk["foreign_key_to"] == "hr.position.position_number", "FK must repoint to canonical (v3.8.4 behavior preserved)"


def test_noop_when_no_canonical_directive():
    products, attributes = _model()
    _register(products, attributes, dict(vs.spec("VREQ-011", "set_fields", ["hr.position.position_number"], fields=[vs.field("attributes", "tags")]),
                                         tags=[{"key": "business_key", "value": "true"}]))
    n = ah._v384_apply_canonical_keys(products, attributes, {}, None)
    assert n == 0
    assert attributes[0]["is_primary_key"] is True and attributes[1]["is_primary_key"] is False, "no directive -> nothing mutated"
    assert products[0]["primary_key"] == "position_id" and attributes[2]["foreign_key_to"] == "hr.position.position_id"
