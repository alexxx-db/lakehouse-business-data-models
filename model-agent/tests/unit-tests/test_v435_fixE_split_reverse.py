"""v4.3.5 FIX E behavioral test (alias=vov-split-product / vov-reverse-fk).

Root cause: split_product and reverse_fk did not exist as deterministic VOV actions, so
reviewer P6 (split the preference god-table) and P9 (reverse a wrong-direction FK) fell to the
LLM sandbox and churned. FIX E adds deterministic ops and nested-model appliers.

Since v5.3.3 an LLM reads the requirement and returns a split_product or reverse_fk spec; the
spec builds the deterministic op, the batch applies it without the LLM sandbox, and the appliers
mutate the model (child tables created + source columns moved; source FK dropped + counterpart
FK added).
"""
import logging
import sys
import types
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402


def test_fixE_split_and_reverse_specs_route_deterministically():
    mdl = {"domains": [
        {"name": "customer", "products": [
            {"name": "preference", "primary_key": "preference_id", "attributes": [
                {"name": "preference_id", "type": "BIGINT"},
                {"name": "customer_id", "type": "BIGINT"},
                {"name": "attr_key", "type": "STRING"},
                {"name": "attr_value", "type": "STRING"},
            ]},
            {"name": "master", "primary_key": "customer_id", "attributes": [{"name": "customer_id", "type": "BIGINT"}]},
        ]},
        {"name": "sales", "products": [
            {"name": "order_line", "primary_key": "order_line_id", "attributes": [
                {"name": "order_line_id", "type": "BIGINT"},
                {"name": "customer_id", "type": "BIGINT", "foreign_key_to": "customer.master.customer_id"},
            ]},
        ]},
    ]}
    vs.register(ah, mdl,
                vs.spec("P6", "split_product", ["customer.preference"], split_into=[
                    {"product": "preference_core", "columns": ["preference_id", "customer_id"]},
                    {"product": "preference_value", "columns": ["preference_id", "attr_key", "attr_value"]}]),
                vs.spec("P9", "reverse_fk", ["sales.order_line.customer_id"]),
                vs.spec("P7", "split_product", ["customer.preference"]),
                vs.spec("P8", "reverse_fk", ["sales.order_line"]))
    split = ("split_product", "customer", "preference", [("preference_core", ["preference_id", "customer_id"]),
                                                         ("preference_value", ["preference_id", "attr_key", "attr_value"])])
    reverse = ("reverse_fk", "sales", "order_line", ("customer_id", None))
    batch = types.SimpleNamespace(batch_id="B1", vreq_ids=("P6", "P9"))
    assert ah._v337_build_ops(batch, mdl) == ([split, reverse], True)
    new_model, summary = ah._v337_deterministic_mutate(batch, mdl, logging.getLogger("test_v435_fixE"))
    assert new_model is not None and "split customer.preference -> preference_core+preference_value" in summary
    assert "reverse_fk sales.order_line.customer_id" in summary
    assert ah._v337_build_ops(types.SimpleNamespace(vreq_ids=("P6", "P7")), mdl) == ([], False)
    assert ah._v337_build_ops(types.SimpleNamespace(vreq_ids=("P8",)), mdl) == ([], False)


def test_fixE_apply_split_product_creates_children_and_moves_columns():
    apply_split = ah._v337_apply_split_product
    mdl = {"domains": [
        {"name": "customer", "products": [
            {"name": "preference", "primary_key": "preference_id", "attributes": [
                {"name": "preference_id", "type": "BIGINT"},
                {"name": "customer_id", "type": "BIGINT"},
                {"name": "attr_key", "type": "STRING"},
                {"name": "attr_value", "type": "STRING"},
            ]},
        ]},
    ]}
    spec = [("preference_core", ["preference_id", "customer_id"]),
            ("preference_value", ["preference_id", "attr_key", "attr_value"])]
    r = apply_split(mdl, "customer", "preference", spec)
    assert r is not None, "split applier returned None"
    prods = {p["name"]: p for p in mdl["domains"][0]["products"]}
    assert "preference_core" in prods and "preference_value" in prods
    src_cols = {a["name"] for a in prods["preference"]["attributes"]}
    # attr_key/attr_value moved out of the source god-table; PK stays
    assert "attr_key" not in src_cols and "attr_value" not in src_cols
    assert "preference_id" in src_cols
    val_cols = {a["name"] for a in prods["preference_value"]["attributes"]}
    assert {"attr_key", "attr_value"}.issubset(val_cols)


def test_fixE_apply_reverse_fk_flips_direction():
    apply_rev = ah._v337_apply_reverse_fk
    mdl = {"domains": [
        {"name": "sales", "products": [
            {"name": "order_line", "primary_key": "order_line_id", "attributes": [
                {"name": "order_line_id", "type": "BIGINT"},
                {"name": "customer_id", "type": "BIGINT",
                 "foreign_key_to": "customer.master.customer_id"},
            ]},
        ]},
        {"name": "customer", "products": [
            {"name": "master", "primary_key": "customer_id",
             "attributes": [{"name": "customer_id", "type": "BIGINT"}]},
        ]},
    ]}
    r = apply_rev(mdl, "sales", "order_line", ("customer_id", None))
    assert r is not None, "reverse_fk applier returned None"
    # source FK dropped
    ol = mdl["domains"][0]["products"][0]
    src = next(a for a in ol["attributes"] if a["name"] == "customer_id")
    assert not src.get("foreign_key_to"), "source FK not dropped"
    # counterpart FK added on customer.master pointing back to sales.order_line PK
    master = mdl["domains"][1]["products"][0]
    back = [a for a in master["attributes"] if a.get("foreign_key_to", "").startswith("sales.order_line.")]
    assert back, "counterpart FK not added on customer.master"
