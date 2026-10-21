import { describe, expect, it } from "vitest";
import { joinCommaList, splitCommaList } from "@/lib/comma-list";

describe("splitCommaList (mirrors BusinessIn.business_domains normalization)", () => {
  it.each([
    [" sales, , finance,sales ,  hr ", ["sales", "finance", "hr"]],
    ["a,b", ["a", "b"]],
    [",,", []],
    ["", []],
    [null, []],
    [undefined, []],
    ["Grid & Gas Operations, Corporate", ["Grid & Gas Operations", "Corporate"]],
  ])("%j -> %j", (input, expected) => {
    expect(splitCommaList(input as string | null | undefined)).toEqual(expected);
  });

  it("round-trips to the stored form", () => {
    expect(joinCommaList(splitCommaList(" customer,billing, customer"))).toBe("customer, billing");
  });
});
