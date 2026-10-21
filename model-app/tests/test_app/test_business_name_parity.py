"""BE half of the business-name parity contract (tests/fixtures/business_name_fixture.json).
The FE half is ui/__tests__/business-name-parity.test.ts against intake-form.tsx BUSINESS_NAME_RE."""

import json
from pathlib import Path

import pytest
from pydantic import ValidationError

from vibe_modeling.backend.models import BUSINESS_NAME_PATTERN, BusinessIn
from vibe_modeling.backend.taxonomy.models import TaxonomyIntake

FIXTURE = json.loads((Path(__file__).parents[1] / "fixtures" / "business_name_fixture.json").read_text())


def test_pattern_matches_the_fixture():
    assert BUSINESS_NAME_PATTERN == FIXTURE["pattern"]


@pytest.mark.parametrize("name,valid", FIXTURE["cases"])
def test_business_in_and_intake_give_the_fixture_verdict(name, valid):
    """Through the real Pydantic validation (pydantic-core's regex), not ``re``."""
    for build in (
        lambda: BusinessIn(name=name, description="d"),
        lambda: TaxonomyIntake(company_name=name, industry="Utility"),
    ):
        if valid:
            build()
        else:
            with pytest.raises(ValidationError):
                build()
