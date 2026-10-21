/**
 * FE half of the business-name parity contract: intake-form's BUSINESS_NAME_RE
 * must carry backend/models.py BUSINESS_NAME_PATTERN exactly and give the same
 * verdicts (shared fixture; the BE half is tests/test_app/test_business_name_parity.py).
 */
import { describe, expect, it } from "vitest";
import fixture from "../../../../../../tests/fixtures/business_name_fixture.json";
import { BUSINESS_NAME_RE } from "@/components/taxonomy/intake-form";

describe("BUSINESS_NAME_RE parity with the backend", () => {
  it("is the fixture pattern", () => {
    expect(BUSINESS_NAME_RE.source).toBe(fixture.pattern);
    expect(BUSINESS_NAME_RE.flags).toBe("");
  });

  it.each(fixture.cases as [string, boolean][])("%j -> %s", (name, valid) => {
    expect(BUSINESS_NAME_RE.test(name)).toBe(valid);
  });
});
