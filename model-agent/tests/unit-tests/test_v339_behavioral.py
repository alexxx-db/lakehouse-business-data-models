import os
import sys

sys.path.insert(0, os.path.dirname(__file__))

import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
from version_test_util import assert_valid_single_digit_semver, assert_version_at_least  # noqa: E402


def _directive():
    return ah._vibe_exact_metric_view_directive


def test_rc4_toplevel_sizing_fallback_fires_when_nested_empty():
    """RC4: nested vibe_classification.sizing_directives is empty at KPI-first time on the
    base-model path, but the merged directives live at top-level widgets_values['sizing_directives'].
    The directive MUST read the top-level store. (Pre-patch returns (None, []) -> FAIL.)"""
    fn = _directive()
    wv = {
        "vibe_classification": {},  # nested copy lost by KPI-first time
        "sizing_directives": {
            "max_metric_views": 3,
            "min_metric_views": 3,
            "explicit_metric_views": [
                "Vacancy Rate",
                "Retirement Eligibility",
                "Total Positions and Active Employees",
            ],
        },
    }
    count, names = fn(wv)
    assert count == 3, f"expected exact count 3 from top-level sizing, got {count}"
    assert names == [
        "Vacancy Rate",
        "Retirement Eligibility",
        "Total Positions and Active Employees",
    ], names


def test_rc4_nested_sizing_still_preferred_no_regression():
    """When the nested copy HAS the MV keys, it is used; top-level is not needed."""
    fn = _directive()
    wv = {
        "vibe_classification": {"sizing_directives": {"max_metric_views": 2, "explicit_metric_views": ["A", "B"]}},
        "sizing_directives": {"max_metric_views": 9},  # must NOT override the nested copy
    }
    count, names = fn(wv)
    assert count == 2, count
    assert names == ["A", "B"], names


def test_rc4_silent_when_no_mv_directive():
    """No MV count anywhere -> returns None so size-based defaults are untouched (user-vibe-silent)."""
    fn = _directive()
    count, names = fn({"vibe_classification": {}, "sizing_directives": {"max_domains": 2}})
    assert count is None, count
    assert names == [], names


def test_v339_version_constant():
    assert_valid_single_digit_semver()
    assert_version_at_least("4.2.7")
