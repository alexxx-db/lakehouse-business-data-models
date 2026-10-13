"""v4.3.5 FIX B behavioral test (alias=verifier-removal-structural).

Root cause (RP11 lying-scoreboard): _verify_structural_target was additive-only. A
"remove/drop/consolidate the <column>" directive named an attribute to DELETE but no branch
checked ABSENCE, so it hit the col-is-None early return and fell to the coarse count-diff,
which false-fulfilled the removal. FIX B verifies the named column(s) are GONE from the
after-state; failed if any still present.

Fail-pre / pass-post: pre-patch the method returns None for a removal directive whose column
is still present (coarse-diff would false-credit it) -> the `status == failed` assertion
raises on None. Post-patch it deterministically returns failed (still present) / fulfilled
(absent).
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

_SPEC = vs.spec("RP11", "drop_column", ["customer.profile.email_opt_in_flag"])


def _attrs(include_removed_col: bool):
    rows = [{"domain": "customer", "product": "profile",
             "attribute": "profile_id", "foreign_key_to": "", "tags": None}]
    if include_removed_col:
        rows.append({"domain": "customer", "product": "profile",
                     "attribute": "email_opt_in_flag", "foreign_key_to": "", "tags": None})
    return rows


def _verdict(spec, include_removed_col: bool):
    base = ah.widgets_flat_to_model([], [{"domain": "customer", "product": "profile", "primary_key": "profile_id"}], _attrs(True))
    vs.register(ah, base, spec)
    return ah._verify_from_spec(ah.vreq_spec("RP11"), [], [], _attrs(include_removed_col), None, "RP11")


def test_fixB_reports_failed_when_column_still_present():
    result = _verdict(_SPEC, include_removed_col=True)
    assert result is not None and result["status"] == "failed", result


def test_fixB_reports_fulfilled_when_column_absent():
    result = _verdict(_SPEC, include_removed_col=False)
    assert result is not None and result["status"] == "fulfilled", result
    unread = _verdict(vs.spec("RP11", "drop_column"), include_removed_col=False)
    assert unread["status"] == "failed" and "drop_column names no target" in unread["evidence"], unread
