"""v3.8.0 behavioral test for deterministic bulk vibe-caps (items 15/16, core of 14).

Drives the production helpers with the requirement specs an LLM returns for the vibe and proves:
- tag-EVERY-attribute: verify FAILS pre-apply, the spec tag pass stamps 100%, verify PASSES post, idempotent.
- prefix-EVERY-attribute: apply renames every column AND rewires foreign_key_to (no orphan joins);
  verify FAILS pre, PASSES post; FK target component is rewritten.
- the column_prefix spec is the prefix the finalize step applies.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import slice_function_source  # noqa: E402


def _attrs():
    return [
        {"domain": "hr", "product": "employee", "attribute": "employee_id", "tags": ""},
        {"domain": "hr", "product": "employee", "attribute": "name", "tags": ""},
        {"domain": "hr", "product": "salary", "attribute": "amount", "tags": "",
         "foreign_key_to": "hr.employee.employee_id"},
    ]


def _register(*specs):
    vs.register(ah, {"model": {"domains": []}}, *specs)


def _tag_every_attribute(key, value):
    return dict(vs.spec("VREQ-015", "set_fields", [], breadth="model", fields=[vs.field("attributes", "tags")]), tags=[{"key": key, "value": value}])


def _prefix_every_column(vid, prefix):
    return dict(vs.spec(vid, "other", [], breadth="model"), policy="column_prefix", policy_value=prefix)


def test_tag_all_fail_pre_pass_post():
    attrs = _attrs()
    prods = [{"domain": "hr", "product": "employee", "primary_key": "employee_id", "tags": ""}]
    _register(_tag_every_attribute("source_system", "DDL"))
    ok_pre, _ = ah._v371_verify_tag_all(attrs, "source_system")
    assert ok_pre is False  # fail-pre proof
    assert ah._verify_from_spec(ah.vreq_spec("VREQ-015"), [], prods, attrs)["status"] == "failed"

    n = ah._vreq_spec_apply_tags(prods, attrs)
    assert n == 3
    assert prods[0]["tags"] == ""

    ok_post, diag = ah._v371_verify_tag_all(attrs, "source_system")
    assert ok_post is True, diag
    assert all("source_system=DDL" in a["tags"] for a in attrs)
    assert ah._verify_from_spec(ah.vreq_spec("VREQ-015"), [], prods, attrs)["status"] == "fulfilled"

    n2 = ah._vreq_spec_apply_tags(prods, attrs)
    assert n2 == 0  # idempotent


def test_prefix_all_rewires_fk():
    attrs = _attrs()
    prods = [{"domain": "hr", "product": "employee", "primary_key": "employee_id"}]
    _register(_prefix_every_column("VREQ-016", "ass_"))
    spec = ah.vreq_spec("VREQ-016")

    assert ah._verify_from_spec(spec, [], prods, attrs)["status"] == "failed"  # fail-pre proof

    n = ah._v371_apply_prefix_all(attrs, prods, "ass_")
    assert n == 3

    names = {a["attribute"] for a in attrs}
    assert names == {"ass_employee_id", "ass_name", "ass_amount"}
    fk = [a for a in attrs if a["attribute"] == "ass_amount"][0]["foreign_key_to"]
    assert fk == "hr.employee.ass_employee_id"  # FK rewired, no orphan
    assert prods[0]["primary_key"] == "ass_employee_id"  # PK rewired

    post = ah._verify_from_spec(spec, [], prods, attrs)
    assert post["status"] == "fulfilled", post["evidence"]


def test_prefix_all_idempotent():
    attrs = _attrs()
    ah._v371_apply_prefix_all(attrs, [], "ass_")
    n2 = ah._v371_apply_prefix_all(attrs, [], "ass_")
    assert n2 == 0


def test_the_column_prefix_spec_is_the_prefix_finalize_applies():
    _register(_prefix_every_column("VREQ-016", "src_"), dict(vs.spec("VREQ-017", "other", [], breadth="model"), policy="column_prefix"),
              dict(vs.spec("VREQ-018", "other", [], breadth="model"), policy="naming_convention", policy_value="snake_case"))
    assert ah._vreq_spec_policy_values("column_prefix") == ["src_"]
    assert ah.vreq_spec("VREQ-017")["interpretable"] is False
    finalize = slice_function_source("step_finalize_model_before_physical_schema")
    assert '_vreq_spec_policy_values("column_prefix")' in finalize
    assert "_v371_apply_prefix_all(attributes_data, products_data, _v371_pfx, logger)" in finalize
    assert "_vreq_spec_apply_tags(products_data, attributes_data, logger)" in finalize
