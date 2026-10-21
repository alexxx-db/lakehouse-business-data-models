import { describe, expect, it } from "vitest";
import { linkDecisionsToVibes, vibeRef } from "@/lib/assessment";

describe("vibeRef", () => {
  it("returns Vibe {priority} for prioritized vibes", () => {
    const vibes = [
      { priority: 1 },
      { priority: 2 },
      { priority: null },
    ] as any[];
    expect(vibeRef(vibes[0], vibes)).toBe("Vibe 1");
    expect(vibeRef(vibes[1], vibes)).toBe("Vibe 2");
  });

  it("returns Vibe {index+1} for unprioritized vibes", () => {
    const vibes = [
      { priority: 1 },
      { priority: null },
      { priority: null },
    ] as any[];
    expect(vibeRef(vibes[1], vibes)).toBe("Vibe 1");
    expect(vibeRef(vibes[2], vibes)).toBe("Vibe 2");
  });

  it("handles all unprioritized vibes", () => {
    const vibes = [{ priority: null }, { priority: null }, { priority: null }] as any[];
    expect(vibeRef(vibes[0], vibes)).toBe("Vibe 1");
    expect(vibeRef(vibes[1], vibes)).toBe("Vibe 2");
    expect(vibeRef(vibes[2], vibes)).toBe("Vibe 3");
  });
});

describe("linkDecisionsToVibes", () => {
  it("fixture 1: matches decisions to vibes by entity affinity", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [{ entity: "bill" }] },
      { ordinal: 1, kind: "structure", entity: "tariff_rider", affected: [{ entity: "tariff_rider" }, { entity: "rate_schedule" }] },
      { ordinal: 2, kind: "structure", entity: "payment", affected: [{ entity: "payment" }, { entity: "bill" }] },
      { ordinal: 3, kind: "structure", entity: "bill_line_item", affected: [{ entity: "bill_line_item" }, { entity: "payment" }] },
      { ordinal: 4, kind: "source", entity: "meter_read", affected: [] },
      { ordinal: 5, kind: "source", entity: "collection_case", affected: [] },
      { ordinal: 6, kind: "source", entity: "payment_arrangement", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill", "bill_line_item"] },
      { id: "v2", priority: 2, affected_entities: ["tariff_rider", "rate_schedule"] },
      { id: "v3", priority: 3, affected_entities: ["payment", "bill"] },
      { id: "v4", priority: 4, affected_entities: ["bill_line_item", "payment"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
      D2: "Vibe 2",
      D3: "Vibe 3",
      D4: "Vibe 4",
    });
    expect(result.decisionsForVibe).toEqual({
      v1: ["D1"],
      v2: ["D2"],
      v3: ["D3"],
      v4: ["D4"],
    });
  });

  it("fixture 2: matches when vibe order differs", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 3, kind: "structure", entity: "payment", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["payment", "bill"] }, // matches D4 first (entity payment) by first entity
      { id: "v3", priority: 3, affected_entities: ["bill", "bill_line_item"] }, // matches D1 (entity bill)
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // D1 (entity bill) should match V3 (first entity bill, then v1 has bill as 2nd)
    // D4 (entity payment) should match V1 (first entity payment)
    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 3",
      D4: "Vibe 1",
    });
    expect(result.decisionsForVibe).toEqual({
      v1: ["D4"],
      v3: ["D1"],
    });
  });

  it("respects explicit D{n} mentions in vibe text", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "payment", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, text: "Fix D1", affected_entities: ["payment"] }, // Explicit D1
      { id: "v2", priority: 2, problem: "Address D2", affected_entities: ["bill"] }, // Explicit D2
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
      D2: "Vibe 2",
    });
  });

  it("respects explicit mention in proposed_change", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, proposed_change: "Implement D1 changes", affected_entities: ["other"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision["D1"]).toBe("Vibe 1");
  });

  it("only links structure decisions", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "source", entity: "meter", affected: [] },
      { ordinal: 2, kind: "scope", entity: "domain_x", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill", "meter", "domain_x"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // Only D1 (structure) should be linked
    expect(result.vibeForDecision).toEqual({ D1: "Vibe 1" });
    expect(result.decisionsForVibe).toEqual({ v1: ["D1"] });
  });

  it("does not link decisions with no matching vibes", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "payment", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["other"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({});
    expect(result.decisionsForVibe).toEqual({});
  });

  it("handles entity name normalization (lowercase, trim)", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "  Bill  ", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision["D1"]).toBe("Vibe 1");
  });

  it("handles affected_entities normalization", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [{ entity: "BILL_LINE_ITEM" }] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill_line_item"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision["D1"]).toBe("Vibe 1");
  });

  it("prioritizes first entity match over overlap count", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [{ entity: "line" }, { entity: "header" }] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["line", "header"] }, // First entity matches neither, but 2 overlap
      { id: "v2", priority: 2, affected_entities: ["bill", "other"] }, // First entity matches bill
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // Should match v2 because first entity (bill) matches decision entity
    expect(result.vibeForDecision["D1"]).toBe("Vibe 2");
  });

  it("handles unprioritized vibes", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "payment", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: null, affected_entities: ["bill"] },
      { id: "v2", priority: null, affected_entities: ["payment"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
      D2: "Vibe 2",
    });
  });

  it("handles mixed prioritized and unprioritized vibes", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "payment", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 2, affected_entities: ["bill"] },
      { id: "v2", priority: null, affected_entities: ["payment"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 2",
      D2: "Vibe 1",
    });
  });

  it("prefers unclaimed vibes over claimed ones", () => {
    // D1 and D2 both match entity bill; V1 and V3 both have bill
    // D1 links V1 (unclaimed), D2 should link V3 (unclaimed) even though V1 has higher score
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill"] },
      { id: "v3", priority: 3, affected_entities: ["bill", "x"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
      D2: "Vibe 3",
    });
    expect(result.decisionsForVibe).toEqual({
      v1: ["D1"],
      v3: ["D2"],
    });
  });

  it("allows multiple decisions to link same vibe when all candidates are claimed", () => {
    // D1 and D2 both match bill; only V1 has bill
    // D1 links V1, D2 must also link V1 (the only candidate)
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
      D2: "Vibe 1",
    });
    expect(result.decisionsForVibe).toEqual({
      v1: ["D1", "D2"],
    });
  });

  it("explicit mention takes precedence over claim status", () => {
    // V1 has explicit D2 mention, so D2 should link V1 even after D1 claims it
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "payment", affected: [] },
      { ordinal: 1, kind: "structure", entity: "bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, text: "Implement D2 changes", affected_entities: ["bill", "payment"] },
      { id: "v3", priority: 3, affected_entities: ["payment"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // D1 (entity payment) links V3 (unclaimed, best match for payment)
    // D2 (entity bill) links V1 (explicit D2 mention, overrides claimed status)
    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 3",
      D2: "Vibe 1",
    });
    expect(result.decisionsForVibe).toEqual({
      v3: ["D1"],
      v1: ["D2"],
    });
  });

  it("resolves explicit mentions in first pass, blocking entity match", () => {
    // D1/D2 both match entity bill; V1 text mentions D2; V3 has bill affected
    // D2 should claim V1 via explicit mention (pass 1), leaving D1 to claim V3 (pass 2)
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [] },
      { ordinal: 1, kind: "structure", entity: "bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, text: "Address D2 feedback", affected_entities: ["bill"] },
      { id: "v3", priority: 3, affected_entities: ["bill"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // D2 claims V1 via explicit mention (pass 1), D1 claims V3 via entity (pass 2, unclaimed preferred)
    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 3",
      D2: "Vibe 1",
    });
    expect(result.decisionsForVibe).toEqual({
      v3: ["D1"],
      v1: ["D2"],
    });
  });

  it("normalizes entity names with qualified names (e.g., schema.table)", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "meter_to_cash.bill", affected: [] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // "meter_to_cash.bill" should normalize to "bill", matching vibe
    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
    });
  });

  it("normalizes affected entity names with qualified names", () => {
    const decisions = [
      { ordinal: 0, kind: "structure", entity: "bill", affected: [{ entity: "schema.bill_line_item" }] },
    ] as any[];

    const vibes = [
      { id: "v1", priority: 1, affected_entities: ["bill_line_item"] },
    ] as any[];

    const result = linkDecisionsToVibes(decisions, vibes);

    // "schema.bill_line_item" should normalize to "bill_line_item", matching vibe
    expect(result.vibeForDecision).toEqual({
      D1: "Vibe 1",
    });
  });
});
