"""v4.3.6 FIX G behavioral tests — directive normalizer + multi-target expander.

ROOT CAUSE this fixes: human reviewer directives arrive as DESCRIPTIVE, MULTI-TARGET
VReqs (intent="deduplicate_consent", body="remove customer.profile.email_opt_in_flag,
..."). Their intent first-word is not a canonical verb, so the whole directive fell to the
empty-diff-prone LLM sandbox — which is exactly why the v4.3.5 cell-60
remove_attribute/retype handlers fired 0 times on the live retail VOV run.

The canonical action now comes from the LLM spec of the requirement, whatever its wording,
and `_vov_vreq_to_priorities` expands the spec into one canonical single-target priority per
named column, feeding the SAME cell-60 handlers.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

_EMPTY = {"model": {"domains": []}}

_P4 = ("Make customer.consent the SINGLE SOURCE OF TRUTH. remove "
       "customer.profile.email_opt_in_flag, customer.profile.sms_opt_in_flag, "
       "customer.profile.marketing_consent_flag, customer.profile.gdpr_consent_flag, "
       "customer.profile.ccpa_opt_out_flag, customer.account.marketing_opt_in, "
       "customer.account.data_sharing_consent, customer.account.marketing_opt_in_date, "
       "customer.account.marketing_opt_out_date, customer.contact.opt_in_marketing, "
       "customer.contact.opt_in_transactional, customer.contact.opt_in_date, "
       "customer.contact.opt_out_date")

_P4_COLUMNS = [t.strip() for t in _P4.split("remove ", 1)[1].split(",")]

_P1_TYPES = {"STRING": ["customer.contact.contact_value", "customer.preference.preference_value"],
             "INT": ["customer.profile.nps_score", "customer.contact.bounce_count"],
             "SMALLINT": ["customer.payment_method.expiry_month", "customer.payment_method.expiry_year"]}


def _vreq(vid, intent="", quote=""):
    return ah.RawVREQ(vreq_id=vid, intent=intent, target="", source_quote=quote, source_chunk_id="c")


def test_fixG_p4_expands_to_13_remove_attribute_priorities():
    vs.register(ah, _EMPTY, vs.spec("VREQ-004", "drop_column", _P4_COLUMNS))
    vreq = _vreq("VREQ-004", "deduplicate_consent", _P4)
    out = ah._vov_vreq_to_priorities(vreq)
    assert len(out) == 13, "expected 13 removes, got %d" % len(out)
    assert {p["action"] for p in out} == {"remove_attribute"}
    assert ("customer.profile", "email_opt_in_flag") in {(p["target"], p["column"]) for p in out}
    assert all(p["vreq_id"] == "VREQ-004" for p in out)
    assert ah._vreq_spec_allows_attribute_removal(vreq)


def test_fixG_p1_expands_each_retype_spec_to_one_priority_per_column_with_its_type():
    specs = [vs.spec(f"VREQ-001-{t}", "retype_column", columns + ["customer.contact"], column_type=t) for t, columns in _P1_TYPES.items()]
    vs.register(ah, _EMPTY, *specs)
    out = [p for s in specs for p in ah._vov_vreq_to_priorities(_vreq(s["id"], "retype_attribute"))]
    assert {p["action"] for p in out} == {"retype_attribute"}
    by_t = {p["target"]: p["target_state"] for p in out}
    assert by_t == {fqn: t for t, columns in _P1_TYPES.items() for fqn in columns}
    assert by_t["customer.contact.contact_value"] == "STRING"
    assert by_t["customer.profile.nps_score"] == "INT"
    assert by_t["customer.payment_method.expiry_month"] == "SMALLINT"


def test_fixG_fk_removal_directive_is_not_expanded():
    # An FK-removal directive must NOT be turned into remove_attribute (would drop a
    # real business column). Guard keeps it on the existing remove_fk path.
    vs.register(ah, _EMPTY, vs.spec("VREQ-X", "remove_fk", ["customer.order.customer_id"]))
    vreq = _vreq("VREQ-X", "remove_fk", "remove the foreign key customer.order.customer_id")
    out = ah._vov_vreq_to_priorities(vreq)
    assert [(p["action"], p["target"], p["column"]) for p in out] == [("remove_fk", "customer.order", "customer_id")]
    assert not ah._vreq_spec_allows_attribute_removal(vreq), "FK-removal must not license dropping the column"


def test_fixG_holistic_description_directive_is_not_expanded():
    # No removal/retype action + no named column -> stays on the LLM path (returns []).
    vs.register(ah, _EMPTY, vs.spec("VREQ-002", "set_fields", [], breadth="model", fields=[vs.field("attributes", "description"),
                                                                                         vs.field("products", "description")]))
    out = ah._vov_vreq_to_priorities(_vreq("VREQ-002", "vendor_neutral_descriptions",
                                           "strip vendor and product names from all column and table descriptions"))
    assert out == [], "holistic description directive must not expand: %r" % out
