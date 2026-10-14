"""v4.3.5 FIX F behavioral test (alias=v435-move-parse-broaden).

Root cause: _v337_extract_move_target's verb gate only matched move/relocate/reassign, so
cross-domain rehome directives phrased "rehome/migrate/belongs in/should live under" returned
None and deferred the whole batch to the flaky LLM sandbox.

Since v5.3.3 an LLM reads every phrasing and returns a move_product spec; these tests prove each
phrasing reaches the classifier and its move spec builds the deterministic move, and that a move
reading without a usable destination builds no op.
"""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


def _model():
    return {"model": {"domains": [
        {"name": "sales", "products": [{"name": "returns", "primary_key": "returns_id", "attributes": [{"name": "returns_id"}]},
                                       {"name": "shipment", "primary_key": "shipment_id", "attributes": [{"name": "shipment_id"}]}]},
        {"name": "logistics", "products": []},
        {"name": "fulfillment", "products": []}]}}


@pytest.mark.parametrize("text,product,destination,expected", [
    ("Rehome the returns product to the logistics domain.", "returns", "logistics",
     ("move_product", "sales", "returns", "logistics")),
    ("The returns product should live under the logistics domain.", "returns", "Logistics",
     ("move_product", "sales", "returns", "logistics")),
    ("Migrate shipment into the fulfillment domain going forward.", "shipment", "`fulfillment`",
     ("move_product", "sales", "shipment", "fulfillment")),
    ("Move the returns product to the logistics domain.", "returns", "logistics",
     ("move_product", "sales", "returns", "logistics")),
], ids=["rehome", "should_live_under", "migrate", "move"])
def test_fixF_the_llm_reading_of_each_move_phrasing_builds_the_move(text, product, destination, expected):
    model = _model()
    llm = vs.SpecOnlyLLM([vs.spec("V1", "move_product", [f"sales.{product}"], destination_domain=destination)])
    ah.classify_vreq_specs(ah._vreq_spec_engine_call(llm), [{"id": "V1", "intent": text, "target": f"sales.{product}", "source_quote": text}], model)
    assert vs.requested_items(llm.prompts[0][1])[0]["intent"] == text
    assert ah._vreq_spec_det_ops(ah.vreq_spec("V1"), model) == [expected]


@pytest.mark.parametrize("destination,interpretable", [("", False), ("the logistics domain", False), ("Sales", True)])
def test_fixF_a_move_reading_without_a_new_domain_builds_no_op(destination, interpretable):
    model = _model()
    vs.register(ah, model, vs.spec("V1", "move_product", ["sales.returns"], destination_domain=destination))
    spec = ah.vreq_spec("V1")
    assert spec["interpretable"] is interpretable, spec["reason"]
    assert ah._vreq_spec_det_ops(spec, model) == []
