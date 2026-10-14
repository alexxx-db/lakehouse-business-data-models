"""v4.3.8 FIX I behavioral tests — reviewer-directive harvester makes the _v436/_v437
expander reachable on run_vov_pipeline's PRIORITY branch.

ROOT CAUSE this fixes (proven on the v4.3.6 live run 350260680270610, and the same on the
v4.3.7 fe-gcp run): run_vov_pipeline chose branch=priority because the staged next_vibes
contains the 75 auto **PRIORITY N** markers. That branch parses ONLY those markers via
_v251_parse_priorities and NEVER extracts the human REVIEWER-PRIORITY directives, so the
_v436 expander (FIX G) and _v437 bridge (FIX H) fired 0 times live — the 13 reviewer
directives fell entirely to the LLM orchestrator. FIX I adds _v437_harvest_reviewer_directives,
which deterministically parses each 'REVIEWER-PRIORITY N - slug: body' block into a RawVREQ so
the SAME expander classifies + expands it inside the priority branch.

FAIL-PRE proof: on v4.3.7 HEAD `_v437_harvest_reviewer_directives` does not exist, so
slice_functions raises (LookupError: def not found) and every test below errors pre-patch.
PASS-POST: the harvester returns the reviewer VReqs, the LLM reads each into a spec, and the
spec becomes the canonical priorities the priority branch applies.
"""
import re

import agent_helpers as ah
import vreq_spec_util as vs
from v435_helpers import concat_source, slice_functions


class _StubVREQ:
    def __init__(self, vreq_id="", intent="", target="", source_quote="",
                 source_chunk_id="", severity="medium", is_user_directive=False,
                 priority_id=9999):
        self.vreq_id = vreq_id
        self.intent = intent
        self.target = target
        self.source_quote = source_quote
        self.source_chunk_id = source_chunk_id
        self.severity = severity
        self.is_user_directive = is_user_directive
        self.priority_id = priority_id


# Real staged format: em-dash header, indented bullet body, blank-line separated blocks,
# and a trailing REVIEWER-PRESERVE block that must NOT be harvested (no canonical action).
_SAMPLE = (
    "================================================================================\n"
    "USER-KING REVIEWER DIRECTIVES - SUPREME AUTHORITY (CLAUDE.md 3c)\n"
    "================================================================================\n"
    "\n"
    "REVIEWER-PRIORITY 1 \u2014 retype_attribute: fix data-type correctness bugs.\n"
    "  - customer.contact.contact_value -> STRING (holds an email address)\n"
    "  - customer.profile.nps_score -> INT\n"
    "\n"
    "REVIEWER-PRIORITY 2 \u2014 vendor_neutral_descriptions: strip vendor names.\n"
    "  - \"Informatica MDM\" -> \"the customer master data system\"\n"
    "\n"
    "REVIEWER-PRIORITY 4 \u2014 deduplicate_consent: consent is the single source of truth.\n"
    "  - remove customer.profile.email_opt_in_flag, customer.profile.sms_opt_in_flag\n"
    "\n"
    "REVIEWER-PRIORITY 10 \u2014 scd_history_on_master: master tables customer.profile and "
    "customer.account must carry SCD-2 change history.\n"
    "\n"
    "REVIEWER-PRESERVE (do NOT regress these): keep the dbx_pii_* tags near-as-is.\n"
)


def _harvest_ns():
    src = concat_source()
    return slice_functions(
        ["_v437_harvest_reviewer_directives"],
        src, extra_globals={"re": re, "RawVREQ": _StubVREQ})


def _customer_model():
    columns = [("contact", "contact_value", "STRING"), ("profile", "nps_score", "STRING"),
               ("profile", "email_opt_in_flag", "BOOLEAN"), ("profile", "sms_opt_in_flag", "BOOLEAN")]
    return ah.widgets_flat_to_model(
        [{"domain": "customer"}],
        [{"domain": "customer", "product": p, "primary_key": f"{p}_id"} for p in ("contact", "profile", "account")],
        [{"domain": "customer", "product": p, "attribute": c, "type": t} for p, c, t in columns])


def test_fixI_harvest_parses_reviewer_priority_blocks():
    ns = _harvest_ns()
    out = ns["_v437_harvest_reviewer_directives"](_SAMPLE)
    slugs = {v.intent for v in out}
    ids = {v.priority_id for v in out}
    # 4 REVIEWER-PRIORITY blocks harvested; PRESERVE skipped (no canonical action)
    assert len(out) == 4, [(v.priority_id, v.intent) for v in out]
    assert slugs == {"retype_attribute", "vendor_neutral_descriptions",
                     "deduplicate_consent", "scd_history_on_master"}, slugs
    assert ids == {1, 2, 4, 10}, ids
    assert all(v.is_user_directive for v in out), "reviewer directives must be USER-KING"
    assert all("REVIEWER-PRIORITY" in v.source_quote for v in out), "block body must be kept"


def test_fixI_harvest_returns_empty_without_reviewer_block():
    ns = _harvest_ns()
    assert ns["_v437_harvest_reviewer_directives"]("just some auto priorities, no reviewer block") == []
    assert ns["_v437_harvest_reviewer_directives"]("") == []


def test_fixI_harvested_vreq_expands_to_canonical_priorities():
    # End-to-end: harvest -> the LLM spec of each harvested VReq -> canonical priorities. This is the
    # exact chain the priority branch now runs; pre-patch the harvester does not exist so this errors.
    by_id = {v.priority_id: v for v in ah._v437_harvest_reviewer_directives(_SAMPLE)}
    assert {i: v.vreq_id for i, v in by_id.items()} == {1: "REVIEWER-1", 2: "REVIEWER-2", 4: "REVIEWER-4", 10: "REVIEWER-10"}
    scd_columns = [{"name": "effective_from", "type": "TIMESTAMP"}, {"name": "effective_to", "type": "TIMESTAMP"},
                   {"name": "is_current", "type": "BOOLEAN"}]
    vs.register(ah, _customer_model(),
                vs.spec("REVIEWER-4", "drop_column", ["customer.profile.email_opt_in_flag", "customer.profile.sms_opt_in_flag"]),
                vs.spec("REVIEWER-10", "add_column", ["customer.profile", "customer.account"], columns=scd_columns),
                vs.spec("REVIEWER-2", "set_fields", [], breadth="model",
                        fields=[vs.field("products", "description"), vs.field("attributes", "description")]),
                vs.spec("REVIEWER-1", "retype_column", ["customer.contact.contact_value", "customer.profile.nps_score"],
                        interpretable=False, reason="the two columns take different types"))

    # P4 deduplicate_consent -> remove_attribute per FQN
    removes = [(p["action"], p["target"], p["column"]) for p in ah._vov_vreq_to_priorities(by_id[4])]
    assert removes == [("remove_attribute", "customer.profile", "email_opt_in_flag"),
                       ("remove_attribute", "customer.profile", "sms_opt_in_flag")], removes
    assert {p["vreq_id"] for p in ah._vov_vreq_to_priorities(by_id[4])} == {"REVIEWER-4"}

    # P10 scd -> the SCD-2 columns on the 2-part master tables
    scd = [(p["action"], p["target"]) for p in ah._vov_vreq_to_priorities(by_id[10])]
    assert scd == [("add_attribute", "customer.profile"), ("add_attribute", "customer.account")], scd

    assert ah._vov_vreq_to_priorities(by_id[2]) == []
    assert ah._vov_vreq_to_priorities(by_id[1]) == []
