import os
import sys

import pytest

_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, _ROOT)

import installer_sql as sql

_REPO = os.path.abspath(os.path.join(_ROOT, "..", "data-models", "automotive", "v1", "mvm", "schemas"))
_CUSTOMER = os.path.join(_REPO, "automotive_customer_schema_v1_mvm.sql")
_VEHICLE = os.path.join(_REPO, "automotive_vehicle_schema_v1_mvm.sql")
_CATALOGS = os.path.join(_REPO, "automotive_catalogs_v1_mvm.sql")
_FK = os.path.join(_REPO, "automotive_cross_domain_foreign_keys_v1_mvm.sql")
_FINANCE = os.path.join(_REPO, "automotive_finance_schema_v1_mvm.sql")


def _read(path):
    with open(path, "r") as f:
        return f.read()


@pytest.fixture
def automotive_raw():
    names = [
        "automotive_catalogs_v1_mvm.sql",
        "automotive_customer_schema_v1_mvm.sql",
        "automotive_vehicle_schema_v1_mvm.sql",
        "automotive_cross_domain_foreign_keys_v1_mvm.sql",
    ]
    paths = [_CATALOGS, _CUSTOMER, _VEHICLE, _FK]
    return {n: _read(p) for n, p in zip(names, paths)}


def test_parse_schema_metadata_extracts_domain_and_division():
    meta = sql.parse_schema_metadata(_read(_CUSTOMER), "automotive_ecm")
    assert "customer" in meta
    assert meta["customer"]["domain"] == "customer"
    assert meta["customer"]["division"] == "business"

    vmeta = sql.parse_schema_metadata(_read(_VEHICLE), "automotive_ecm")
    assert vmeta["vehicle"]["division"] == "operations"


def test_one_catalog_rewrite_is_single_target():
    raw = _read(_CUSTOMER)
    ctx = sql.build_layout_context(
        {"customer.sql": raw}, "automotive_ecm", "my_auto", "One Catalog"
    )
    out = sql.rewrite_model_sql(raw, "automotive_ecm", ctx)
    assert "`my_auto`.`customer`" in out
    assert "`automotive_ecm`" not in out
    assert ctx["target_catalogs"] == ["my_auto"]


def test_catalog_per_domain_splits_by_domain(automotive_raw):
    ctx = sql.build_layout_context(
        automotive_raw, "automotive_ecm", "automotive", "Catalog per Domain"
    )
    assert "cat_customer" in ctx["target_catalogs"]
    assert "cat_vehicle" in ctx["target_catalogs"]
    assert ctx["schema_catalog_map"]["customer"] == "cat_customer"
    assert ctx["schema_catalog_map"]["vehicle"] == "cat_vehicle"

    cust = sql.rewrite_model_sql(automotive_raw["automotive_customer_schema_v1_mvm.sql"], "automotive_ecm", ctx)
    assert "`cat_customer`.`customer`" in cust
    assert "`automotive_ecm`.`customer`" not in cust

    fk = sql.rewrite_model_sql(automotive_raw["automotive_cross_domain_foreign_keys_v1_mvm.sql"], "automotive_ecm", ctx)
    assert "`cat_aftersales`.`aftersales`" in fk or "`cat_customer`.`customer`" in fk
    assert "`automotive_ecm`." not in fk


def test_catalog_per_division_groups_by_division(automotive_raw):
    automotive_raw["automotive_finance_schema_v1_mvm.sql"] = _read(_FINANCE)
    ctx = sql.build_layout_context(
        automotive_raw, "automotive_ecm", "automotive", "Catalog per Division"
    )
    assert "cat_operations" in ctx["target_catalogs"]
    assert "cat_business" in ctx["target_catalogs"]
    assert "cat_corporate" in ctx["target_catalogs"]
    assert ctx["schema_catalog_map"]["vehicle"] == "cat_operations"
    assert ctx["schema_catalog_map"]["customer"] == "cat_business"
    assert ctx["schema_catalog_map"]["finance"] == "cat_corporate"

    veh = sql.rewrite_model_sql(automotive_raw["automotive_vehicle_schema_v1_mvm.sql"], "automotive_ecm", ctx)
    assert "`cat_operations`.`vehicle`" in veh


def test_default_prefix_applied_for_multi_catalog_styles():
    ctx = sql.build_layout_context(
        {"customer.sql": _read(_CUSTOMER)},
        "automotive_ecm",
        "automotive",
        "Catalog per Domain",
        "",
        "",
    )
    assert ctx["schema_catalog_map"]["customer"].startswith("cat_")


def test_create_catalog_stmts_dropped_from_plan_on_multi_layout(automotive_raw):
    ctx = sql.build_layout_context(
        automotive_raw, "automotive_ecm", "automotive", "Catalog per Domain"
    )
    rewritten = sql.rewrite_model_sql(automotive_raw["automotive_catalogs_v1_mvm.sql"], "automotive_ecm", ctx)
    stmts = sql.filter_catalog_statements(sql.split_sql(rewritten), ctx)
    catalog_stmts = [s for s in stmts if sql.categorize(s) == "catalog"]
    assert catalog_stmts == []


def test_cross_domain_fk_references_resolve_to_different_catalogs(automotive_raw):
    ctx = sql.build_layout_context(
        automotive_raw, "automotive_ecm", "automotive", "Catalog per Domain"
    )
    fk = sql.rewrite_model_sql(automotive_raw["automotive_cross_domain_foreign_keys_v1_mvm.sql"], "automotive_ecm", ctx)
    assert "`cat_aftersales`.`aftersales`" in fk
    assert "`cat_customer`.`customer`" in fk
    assert "`cat_compliance`.`compliance`" in fk
