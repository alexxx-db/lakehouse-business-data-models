"""v4.4.1 behavioral tests — reviewer directives on the final nested data_model (CLAUDE.md 8.10).

v5.3.3 deleted the regex reviewer finalization: an LLM reads each harvested reviewer requirement into a
spec and the engine applies the spec through its deterministic ops (split / move) and pass-1 priorities
(remove_fk / drop_column). The P-tests register the spec an LLM returns for the reviewer's directive and
assert the model change. The G-tests exercise `_v443_structural_hardening`.
"""
import re

import conftest  # noqa: F401
import agent_helpers as ah
import vreq_spec_util as vs
from v435_helpers import concat_source, slice_functions
from notebook_source_util import pk_predicate_globals, vov_ledger_globals


class _Log:
    def info(self, *a, **k):
        pass

    def warning(self, *a, **k):
        pass

    def error(self, *a, **k):
        pass

    def debug(self, *a, **k):
        pass


def _apply_op(dm, spec):
    vs.register(ah, dm, spec)
    return ah._v410_deterministic_selffix(dm, {"id": spec["id"]}, _Log())


def _apply_priorities(dm, spec):
    vs.register(ah, dm, spec)
    vreq = ah.RawVREQ(vreq_id=spec["id"], intent="", target="", source_quote="", source_chunk_id="c1")
    return ah._v251_apply_pass1_priorities(ah._vov_vreq_to_priorities(vreq), dm, _Log())


def _base_model():
    return {
        "model": {
            "domains": [
                {
                    "name": "customer",
                    "products": [
                        {
                            "name": "profile",
                            "attributes": [
                                {"name": "profile_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                                {"name": "source_system_code", "type": "STRING",
                                 "description": "Populated by Informatica MDM for the golden record; sample brand such as Nike."},
                                {"name": "email", "type": "STRING", "description": "Email address.",
                                 "business_glossary_term": "Email",
                                 "tag_set": [{"key": "dbx_business_glossary_term", "value": "Email"},
                                             {"key": "pii", "value": "true"}]},
                                {"name": "status_code", "type": "INT", "description": "Status.",
                                 "value_regex": "^[0-9]+$",
                                 "tag_set": [{"key": "dbx_value_regex", "value": "^[0-9]+$"}]},
                                {"name": "region_name", "type": "STRING", "description": "Region name descriptor.",
                                 "business_glossary_term": "Customer Home Region",
                                 "tag_set": [{"key": "dbx_business_glossary_term", "value": "Customer Home Region"}]},
                            ],
                        },
                        {
                            "name": "preference",
                            "attributes": [
                                {"name": "preference_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                                {"name": "preference_value", "type": "STRING", "description": "A value."},
                            ],
                        },
                        {
                            "name": "segment",
                            "attributes": [
                                {"name": "segment_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                            ],
                        },
                        {
                            "name": "loyalty",
                            "attributes": [
                                {"name": "loyalty_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                                {"name": "campaign_id", "type": "BIGINT", "foreign_key_to": "marketing.campaign.campaign_id", "tags": "foreign_key"},
                                {"name": "location_id", "type": "BIGINT", "foreign_key_to": "store.location.location_id", "tags": "foreign_key"},
                                {"name": "profile_id", "type": "BIGINT", "foreign_key_to": "customer.profile.profile_id", "tags": "foreign_key"},
                            ],
                        },
                        {
                            "name": "wishlist",
                            "attributes": [
                                {"name": "wishlist_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                                {"name": "campaign_id", "type": "BIGINT", "foreign_key_to": "marketing.campaign.campaign_id", "tags": "foreign_key"},
                            ],
                        },
                    ],
                },
                {
                    "name": "marketing",
                    "products": [
                        {"name": "segment", "attributes": [
                            {"name": "segment_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"}]},
                        {"name": "campaign", "attributes": [
                            {"name": "campaign_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"}]},
                    ],
                },
                {
                    "name": "store",
                    "products": [
                        {"name": "location", "attributes": [
                            {"name": "location_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"}]},
                    ],
                },
            ]
        }
    }


def _cust(dm):
    return next(d for d in dm["model"]["domains"] if d["name"] == "customer")


def _prod(dom, name):
    return next((p for p in dom["products"] if p["name"] == name), None)


def _attr(prod, name):
    return next((a for a in prod["attributes"] if a["name"] == name), None)


# ============================================================ P6
def test_p6_materializes_all_three_children_no_columns_lost():
    dm = _base_model()
    split = vs.spec("VREQ-006", "split_product", ["customer.preference"], split_into=[
        {"product": "communication_preference", "columns": ["preference_value"]},
        {"product": "dietary_restriction", "columns": []},
        {"product": "customer_attribute", "columns": ["attribute_key", "attribute_value"]}])
    ok, evidence = _apply_op(dm, split)
    assert ok is True, evidence
    cust = _cust(dm)
    for child in ("communication_preference", "dietary_restriction", "customer_attribute"):
        assert _prod(cust, child) is not None, "missing child %s" % child
    cols = {a["name"] for a in _prod(cust, "customer_attribute")["attributes"]}
    assert "attribute_key" in cols and "attribute_value" in cols, cols
    assert _attr(_prod(cust, "communication_preference"), "preference_value") is not None
    assert _attr(_prod(cust, "preference"), "preference_value") is None
    before = repr(dm)
    assert _apply_op(dm, dict(split, id="VREQ-016"))[0] is None
    assert repr(dm) == before, "a split whose children already exist must change nothing"


# ============================================================ P7
def test_p7_dedupes_moved_product_from_root_and_rewires():
    dm = _base_model()
    mk = next(d for d in dm["model"]["domains"] if d["name"] == "marketing")
    mk["products"].append({"name": "affinity", "attributes": [
        {"name": "affinity_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
        {"name": "segment_id", "type": "BIGINT", "foreign_key_to": "customer.segment.segment_id", "tags": "foreign_key"},
    ]})
    ok, evidence = _apply_op(dm, vs.spec("VREQ-007", "move_product", ["customer.segment"], destination_domain="marketing"))
    assert _prod(_cust(dm), "segment") is None, (ok, evidence)
    assert _prod(mk, "segment") is not None
    aff_fk = _attr(_prod(mk, "affinity"), "segment_id")["foreign_key_to"]
    assert aff_fk.lower().startswith("marketing.segment."), aff_fk


# ============================================================ P9
def test_p9_prunes_transactional_out_keeps_reference_out():
    dm = _base_model()
    _model, outcomes, residual = _apply_priorities(dm, vs.spec("VREQ-009", "remove_fk", ["customer.loyalty.campaign_id",
                                                                                          "customer.wishlist.campaign_id"]))
    assert [o.status for o in outcomes] == ["applied", "applied"] and residual == [], outcomes
    loyalty = _prod(_cust(dm), "loyalty")
    assert _attr(loyalty, "campaign_id")["foreign_key_to"] == ""
    assert _attr(_prod(_cust(dm), "wishlist"), "campaign_id")["foreign_key_to"] == ""
    assert _attr(loyalty, "location_id")["foreign_key_to"] == "store.location.location_id"
    assert _attr(loyalty, "profile_id")["foreign_key_to"] == "customer.profile.profile_id"


# ============================================================ P11
def test_p11_drops_reviewer_named_redundant_role_columns():
    dm = _base_model()
    prof = _prod(_cust(dm), "profile")
    prof["attributes"].extend([
        {"name": "customer_type", "type": "STRING", "description": "Legal entity type."},
        {"name": "vip_flag", "type": "BOOLEAN", "description": "VIP flag."},
        {"name": "employee_flag", "type": "BOOLEAN", "description": "Employee flag."},
        {"name": "account_tier", "type": "STRING", "description": "Account tier."},
        {"name": "priority_flag", "type": "BOOLEAN"},
    ])
    _apply_priorities(dm, vs.spec("VREQ-011", "drop_column", ["customer.profile.vip_flag", "customer.profile.employee_flag",
                                                              "customer.profile.account_tier"]))
    cols = {a["name"] for a in _prod(_cust(dm), "profile")["attributes"]}
    assert not {"vip_flag", "employee_flag", "account_tier"} & cols, cols
    assert {"customer_type", "priority_flag", "email", "profile_id"} <= cols, cols


# =========================================================================================
# v4.4.3 — generic structural hardening (G1/G3/G9/G12), operation-agnostic, no reviewer text.
# Fail-pre proof: on v4.4.2 HEAD `_v443_structural_hardening` does not exist -> slice_functions
# raises LookupError -> every test below errors. Pass-post: it exists and flips the four gate
# classes on the FINAL nested data_model regardless of operation (so the shrink MVM hardens too).
# =========================================================================================


def _harden_ns():
    return slice_functions(["_v443_structural_hardening"], concat_source(), extra_globals={"re": re, **pk_predicate_globals(), **vov_ledger_globals()})


def _harden_model():
    # deliberately NON-retail domain names to prove genericity (no "customer"/"retail" hardcoding)
    return {
        "model": {
            "domains": [
                {"name": "party", "description": "", "products": [
                    # G1: has party_account_id but NO pk flag -> must be asserted
                    {"name": "party_account", "description": "", "attributes": [
                        {"name": "party_account_id", "type": "BIGINT"},
                        {"name": "opened_at", "type": "TIMESTAMP"},
                    ]},
                    # G12: SCD cols with empty descriptions
                    {"name": "party_profile", "attributes": [
                        {"name": "party_profile_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key",
                         "description": "PK."},
                        {"name": "effective_start_date", "type": "DATE", "description": ""},
                        {"name": "scd_status", "type": "VARCHAR", "description": ""},
                    ]},
                ]},
                {"name": "billing", "products": [
                    # G3: FK STRING -> target BIGINT PK ; G9: campaign_code twin where target OWNS it -> drop
                    {"name": "invoice", "attributes": [
                        {"name": "invoice_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                        {"name": "campaign_id", "type": "STRING", "foreign_key_to": "marketing.campaign.campaign_id",
                         "tags": "foreign_key"},
                        {"name": "campaign_code", "type": "VARCHAR"},
                    ]},
                    # G9 safety: order_code twin where target does NOT own it -> KEEP (own natural key)
                    {"name": "credit_note", "attributes": [
                        {"name": "credit_note_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                        {"name": "order_id", "type": "BIGINT", "foreign_key_to": "sales.order.order_id",
                         "tags": "foreign_key"},
                        {"name": "order_code", "type": "VARCHAR"},
                    ]},
                ]},
                {"name": "marketing", "products": [
                    {"name": "campaign", "attributes": [
                        {"name": "campaign_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                        {"name": "campaign_code", "type": "VARCHAR"},
                    ]},
                ]},
                {"name": "sales", "products": [
                    {"name": "order", "attributes": [
                        {"name": "order_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    ]},  # NOTE: order does NOT own order_code
                ]},
            ]
        }
    }


def _find_prod(dm, dom, prod):
    d = next(x for x in dm["model"]["domains"] if x["name"] == dom)
    return next(p for p in d["products"] if p["name"] == prod)


def test_g1_asserts_pk_on_table_missing_flag():
    ns = _harden_ns()
    dm = _harden_model()
    ns["_v443_structural_hardening"](dm, _Log())
    acct = _find_prod(dm, "party", "party_account")
    pk = next(a for a in acct["attributes"] if a["name"] == "party_account_id")
    assert pk.get("is_primary_key") is True, "G1 must flag <product>_id as PK when none present"


def test_g1_reads_the_primary_key_tag_inside_a_tag_list():
    ns = _harden_ns()
    dm = _harden_model()
    party = next(d for d in dm["model"]["domains"] if d["name"] == "party")
    party["products"].append({"name": "party_note", "attributes": [
        {"name": "party_note_id", "type": "BIGINT", "tags": "primary_key,role=primary_key"},
        {"name": "note_text", "type": "STRING"},
    ]})
    party["products"].append({"name": "party_address", "attributes": [
        {"name": "party_address_id", "type": "BIGINT", "tags": "primary_key,restricted,pii_address"},
    ]})
    ns["_v443_structural_hardening"](dm, _Log())
    for prod in ("party_note", "party_address"):
        pk = _find_prod(dm, "party", prod)["attributes"][0]
        assert "is_primary_key" not in pk, f"live R20 361205040527084 wrote is_primary_key into model.json for {prod}"
    acct = _find_prod(dm, "party", "party_account")
    assert next(a for a in acct["attributes"] if a["name"] == "party_account_id").get("is_primary_key") is True


def test_g3_coerces_fk_type_to_target_pk_type():
    ns = _harden_ns()
    dm = _harden_model()
    ns["_v443_structural_hardening"](dm, _Log())
    inv = _find_prod(dm, "billing", "invoice")
    fk = next(a for a in inv["attributes"] if a["name"] == "campaign_id")
    assert fk["type"].split("(")[0] == "BIGINT", "G3 must coerce STRING FK to target BIGINT PK type"


def test_g9_drops_denorm_twin_only_when_target_owns_it():
    ns = _harden_ns()
    dm = _harden_model()
    ns["_v443_structural_hardening"](dm, _Log())
    inv = _find_prod(dm, "billing", "invoice")
    cols = {a["name"] for a in inv["attributes"]}
    assert "campaign_code" not in cols, "G9 must drop denormalized twin the target owns"


def test_g9_keeps_own_natural_key_when_target_does_not_own_it():
    ns = _harden_ns()
    dm = _harden_model()
    ns["_v443_structural_hardening"](dm, _Log())
    cn = _find_prod(dm, "billing", "credit_note")
    cols = {a["name"] for a in cn["attributes"]}
    assert "order_code" in cols, "G9 must NOT drop a table's own natural key (target does not own it)"


def test_g12_backfills_empty_descriptions_non_boilerplate():
    ns = _harden_ns()
    dm = _harden_model()
    ns["_v443_structural_hardening"](dm, _Log())
    prof = _find_prod(dm, "party", "party_profile")
    for a in prof["attributes"]:
        assert str(a.get("description") or "").strip(), "G12 must backfill every empty description"
    scd = next(a for a in prof["attributes"] if a["name"] == "scd_status")
    assert "current" in scd["description"].lower() or "historical" in scd["description"].lower()
    acct = _find_prod(dm, "party", "party_account")
    dom = next(x for x in dm["model"]["domains"] if x["name"] == "party")
    assert str(dom.get("description") or "").strip() and str(acct.get("description") or "").strip()


def test_g12_preserves_existing_descriptions():
    ns = _harden_ns()
    dm = _harden_model()
    prof = _find_prod(dm, "party", "party_profile")
    before = next(a for a in prof["attributes"] if a["name"] == "party_profile_id")["description"]
    ns["_v443_structural_hardening"](dm, _Log())
    after = next(a for a in prof["attributes"] if a["name"] == "party_profile_id")["description"]
    assert after == before == "PK.", "existing descriptions must be preserved verbatim"


def test_g11_canonicalizes_invalid_type_to_databricks_type():
    """v4.4.4 — a non-Databricks type (TEXT) the LLM/self-fixer introduces must be canonicalized
    to a valid Databricks SQL type at the serialization boundary (fail-pre: TEXT survives)."""
    ns = _harden_ns()
    dm = {
        "model": {
            "domains": [
                {"name": "compliance", "products": [
                    {"name": "consent", "attributes": [
                        {"name": "consent_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                        {"name": "audit_trail", "type": "TEXT"},
                        {"name": "captured_at", "type": "DATETIME"},
                    ]},
                ]},
            ]
        }
    }
    ns["_v443_structural_hardening"](dm, _Log())
    cons = _find_prod(dm, "compliance", "consent")
    at = next(a for a in cons["attributes"] if a["name"] == "audit_trail")["type"].upper()
    ca = next(a for a in cons["attributes"] if a["name"] == "captured_at")["type"].upper()
    assert at == "STRING", "TEXT must canonicalize to STRING (got %s)" % at
    assert ca == "TIMESTAMP", "DATETIME must canonicalize to TIMESTAMP (got %s)" % ca


# =========================================================================================
# v4.4.6 — PK-self-ref corruption repair (G5/G2) + siloed-table relink (G7).
# Fail-pre proof: on the committed v4.4.5 notebook these two passes are absent, so the corrupted
# PK's name stays mangled (dangling inbound FK survives; PK self-references) and the silo keeps
# zero links. git-stash the working tree -> these two tests FAIL; pop -> they PASS.
# =========================================================================================


def _corrupt_pk_model():
    # NON-retail names to prove genericity. audit_finding's PK column was renamed into a self-ref FK
    # (name=related_audit_finding_id, column_name=audit_finding_id, tagged primary_key, self-FK to own
    # PK), orphaning the logical PK so an inbound FK from another table dangles.
    return {
        "model": {
            "domains": [
                {"name": "compliance", "products": [
                    {"name": "audit_finding", "primary_key": "audit_finding_id", "attributes": [
                        {"name": "related_audit_finding_id", "column_name": "audit_finding_id",
                         "type": "BIGINT", "is_primary_key": None,
                         "tags": "primary_key,self_ref_fk=true,renamed_from=audit_finding_id",
                         "tag_set": [{"key": "primary_key", "value": ""},
                                     {"key": "self_ref_fk", "value": "true"},
                                     {"key": "renamed_from", "value": "audit_finding_id"}],
                         "foreign_key_to": "compliance.audit_finding.audit_finding_id"},
                        {"name": "parent_audit_finding_id", "column_name": "parent_audit_finding_id",
                         "type": "BIGINT", "tags": "self_ref_fk",
                         "foreign_key_to": "compliance.audit_finding.audit_finding_id"},
                        {"name": "title", "type": "STRING", "description": "Title."},
                    ]},
                ]},
                {"name": "operations", "products": [
                    # inbound FK to the orphaned PK -> dangles until the PK name is repaired
                    {"name": "corrective_action", "primary_key": "corrective_action_id", "attributes": [
                        {"name": "corrective_action_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                        {"name": "audit_finding_id", "type": "BIGINT",
                         "foreign_key_to": "compliance.audit_finding.audit_finding_id", "tags": "foreign_key"},
                    ]},
                ]},
            ]
        }
    }


def _has_col(prod, name):
    return any((a.get("name") or a.get("column_name")) == name for a in prod["attributes"])


def test_g5g2_repairs_corrupted_self_ref_pk_column():
    ns = _harden_ns()
    dm = _corrupt_pk_model()
    ns["_v443_structural_hardening"](dm, _Log())
    af = _find_prod(dm, "compliance", "audit_finding")
    # the logical PK name is restored (was mangled to related_audit_finding_id)
    assert _has_col(af, "audit_finding_id"), "declared PK column name must be restored"
    pk = next(a for a in af["attributes"] if (a.get("name") or a.get("column_name")) == "audit_finding_id")
    # a PK must not self-reference
    assert not (pk.get("foreign_key_to") or ""), "repaired PK must not carry a self-FK"
    # the bogus self_ref_fk / renamed_from tags are stripped; primary_key stays
    assert "self_ref_fk" not in str(pk.get("tags") or "")
    assert "renamed_from" not in str(pk.get("tags") or "")
    assert pk.get("is_primary_key") is True
    # the mangled name is gone
    assert not _has_col(af, "related_audit_finding_id"), "mangled PK alias must be removed"
    # a LEGIT separate self-ref (parent_audit_finding_id) is untouched
    assert _has_col(af, "parent_audit_finding_id")


def test_g5g2_repair_resolves_the_dangling_inbound_fk():
    """After repair the inbound FK from operations.corrective_action resolves to a real PK column."""
    ns = _harden_ns()
    dm = _corrupt_pk_model()
    ns["_v443_structural_hardening"](dm, _Log())
    af = _find_prod(dm, "compliance", "audit_finding")
    pk_names = {(a.get("name") or a.get("column_name")) for a in af["attributes"]}
    ca = _find_prod(dm, "operations", "corrective_action")
    fk = next(a for a in ca["attributes"] if a["name"] == "audit_finding_id")["foreign_key_to"]
    assert fk.split(".")[-1] in pk_names, "inbound FK target column must now exist on the target table"


def test_g5g2_leaves_healthy_pk_untouched():
    """A table whose declared PK name is already present must not be altered."""
    ns = _harden_ns()
    dm = {
        "model": {"domains": [
            {"name": "sales", "products": [
                {"name": "order", "primary_key": "order_id", "attributes": [
                    {"name": "order_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "prior_order_id", "type": "BIGINT",
                     "foreign_key_to": "sales.order.order_id", "tags": "self_ref_fk"},
                ]},
            ]},
        ]}
    }
    ns["_v443_structural_hardening"](dm, _Log())
    order = _find_prod(dm, "sales", "order")
    # the legitimate self-ref FK (not a PK) survives; the PK is untouched
    prior = next(a for a in order["attributes"] if a["name"] == "prior_order_id")
    assert prior["foreign_key_to"] == "sales.order.order_id"


def test_g7_relinks_siloed_table_to_best_same_domain_parent():
    ns = _harden_ns()
    # payment_instrument is a total silo (0 in / 0 out); payment_method (same domain, shared token
    # 'payment', fewer attrs) is the best parent. Generic token-overlap, no 'payment' hardcode.
    dm = {
        "model": {"domains": [
            {"name": "finance", "products": [
                {"name": "payment_method", "primary_key": "payment_method_id", "attributes": [
                    {"name": "payment_method_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "method_name", "type": "STRING"},
                    {"name": "is_active", "type": "BOOLEAN"},
                ]},
                {"name": "payment_run", "primary_key": "payment_run_id", "attributes": [
                    {"name": "payment_run_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "run_date", "type": "DATE"},
                    {"name": "run_status", "type": "STRING"},
                    {"name": "total_amount", "type": "DECIMAL(18,2)"},
                    {"name": "approved_by", "type": "STRING"},
                ]},
                {"name": "payment_instrument", "primary_key": "payment_instrument_id", "attributes": [
                    {"name": "payment_instrument_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "token", "type": "STRING"},
                ]},
                # a hub that already links to payment_method so payment_method is NOT itself a silo
                {"name": "settlement", "primary_key": "settlement_id", "attributes": [
                    {"name": "settlement_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "payment_method_id", "type": "BIGINT",
                     "foreign_key_to": "finance.payment_method.payment_method_id", "tags": "foreign_key"},
                ]},
            ]},
        ]}
    }
    ns["_v443_structural_hardening"](dm, _Log())
    pi = _find_prod(dm, "finance", "payment_instrument")
    fks = [a.get("foreign_key_to") for a in pi["attributes"] if a.get("foreign_key_to")]
    assert fks, "silo must be relinked with at least one FK"
    # tie-break: max token overlap, fewest attributes -> payment_method (3 attrs) over payment_run (5)
    assert fks[0] == "finance.payment_method.payment_method_id", "silo must link to best-match parent: %r" % fks


def test_g7_leaves_isolated_table_untouched_when_no_token_match():
    """A silo with NO same-domain token match must be left as-is (no invented FK)."""
    ns = _harden_ns()
    dm = {
        "model": {"domains": [
            {"name": "reference", "products": [
                {"name": "currency", "primary_key": "currency_id", "attributes": [
                    {"name": "currency_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "iso_code", "type": "STRING"},
                ]},
                {"name": "calendar_day", "primary_key": "calendar_day_id", "attributes": [
                    {"name": "calendar_day_id", "type": "BIGINT", "is_primary_key": True, "tags": "primary_key"},
                    {"name": "day_date", "type": "DATE"},
                ]},
            ]},
        ]}
    }
    ns["_v443_structural_hardening"](dm, _Log())
    cur = _find_prod(dm, "reference", "currency")
    assert not any(a.get("foreign_key_to") for a in cur["attributes"]), "no invented FK when no token match"
