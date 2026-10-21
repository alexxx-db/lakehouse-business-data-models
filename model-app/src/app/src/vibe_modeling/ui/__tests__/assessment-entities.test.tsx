import { describe, expect, it } from "vitest";
import { render, screen, fireEvent, within } from "@testing-library/react";
import { EntityDrilldown } from "@/components/assessment/entity-drilldown";
import type { AssessEntityOut } from "@/lib/api";

const col = (over: Record<string, unknown>) => ({
  id: "c", entity_id: "e", attribute_id: "a", in_model: true, target: "t", status: "mapped", source_table: "sap.t",
  source_column: "x", transform: "", row_count: 10, null_pct: 0, distinct_count: 5, date_format: "", fk_orphans: null,
  evidence: "", dup_source: false, tier: "core", ...over,
});
const ent = (over: Record<string, unknown>) => ({
  id: "e", domain_run_id: "r1", product_id: "p", in_model: true, name: "x", grade: "partial", coverage_pct: 80,
  primary_source: "sap.t", row_count: 100, net_new_candidate: false, mapped: 1, gap: 0, deferred_fk: 0, dup_source: 0,
  letter_grade: "B", enrichment_pct: 60, core_sourced: 3, core_total: 4, enrichment_sourced: 3, enrichment_total: 5,
  deferred_fk_count: 1, grade_reason: "Generic reason", row_filter: "mandt = '100'", columns: [], ...over,
});
const entities = [
  ent({ id: "e1", name: "invoice", letter_grade: "A" }),
  ent({ id: "e2", name: "meter_read", letter_grade: "F", grade: "blocked", grade_reason: "Core mostly sourced", columns: [
    col({ id: "c1", target: "enr_col", tier: "enrichment" }),
    col({ id: "c2", target: "core_col", tier: "core" }),
    col({ id: "c3", target: "fk_col", tier: "deferred_fk", status: "deferred_fk" }),
  ] }),
  ent({ id: "e3", name: "order", letter_grade: "C", columns: [col({ id: "c4", target: "o_col" })] }),
  ent({ id: "e4", name: "legacy", letter_grade: null, enrichment_pct: null, core_sourced: null, core_total: null,
    enrichment_sourced: null, enrichment_total: null, deferred_fk_count: null, coverage_pct: 30, grade: "blocked" }),
] as unknown as AssessEntityOut[];

const bodyRows = () => screen.getAllByRole("row").slice(1);
const rowOf = (name: string) => bodyRows().find((r) => within(r).queryByText(name))!;

describe("EntityDrilldown", () => {
  it("orders rows worst letter first, nulls last", () => {
    render(<EntityDrilldown entities={entities} />);
    const names = bodyRows().map((r) => ["meter_read", "order", "invoice", "legacy"].find((n) => within(r).queryByText(n)));
    expect(names).toEqual(["meter_read", "order", "invoice", "legacy"]);
  });

  it("shows Core n/n and Enrichment %, dashes for old runs", () => {
    render(<EntityDrilldown entities={entities} />);
    expect(within(rowOf("invoice")).getByText("3/4")).toBeTruthy();
    expect(within(rowOf("invoice")).getByText("60%")).toBeTruthy();
    const legacy = rowOf("legacy");
    expect(within(legacy).getAllByText("—").length).toBeGreaterThanOrEqual(2);
    expect(within(legacy).getAllByText("Blocked").length).toBe(2);
    expect(within(legacy).getByTestId("coverage").className).toContain("amber");
  });

  it("expands the drill-down as the very next row and collapses on another click", () => {
    render(<EntityDrilldown entities={entities} />);
    const table = screen.getByRole("table");
    const btn = within(rowOf("meter_read")).getByRole("button", { name: /meter_read/ });
    expect(btn.getAttribute("aria-expanded")).toBe("false");
    fireEvent.click(btn);
    const rows = within(table).getAllByRole("row");
    const idx = rows.findIndex((r) => within(r).queryByText("meter_read") && within(r).queryByRole("button", { name: /meter_read/ }));
    expect(within(rows[idx + 1]).getByText("Core mostly sourced")).toBeTruthy();
    expect(within(rows[idx + 1]).getByText(/mandt = '100'/)).toBeTruthy();
    expect(btn.getAttribute("aria-expanded")).toBe("true");
    fireEvent.click(within(rowOf("order")).getByRole("button", { name: /order/ }));
    expect(screen.queryByText("Core mostly sourced")).toBeNull();
    expect(screen.getByText("o_col")).toBeTruthy();
  });

  it("filters columns by tier chip, Core first by default", () => {
    render(<EntityDrilldown entities={entities} />);
    fireEvent.click(within(rowOf("meter_read")).getByRole("button", { name: /meter_read/ }));
    const targets = () => screen.getAllByText(/_col$/).map((e) => e.textContent!.trim());
    expect(targets()).toEqual(["core_col", "enr_col", "fk_col"]);
    fireEvent.click(screen.getByRole("button", { name: /^Core \(1\)/ }));
    expect(targets()).toEqual(["core_col"]);
    expect(screen.getByRole("button", { name: /^All \(3\)/ })).toBeTruthy();
  });

  it("adds an Unclassified chip and hides empty tier chips", () => {
    const e = ent({ id: "e9", name: "mixed", columns: [
      col({ id: "m1", target: "a_col", tier: "core" }),
      col({ id: "m2", target: "b_col", tier: "" }),
    ] }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(rowOf("mixed")).getByRole("button", { name: /mixed/ }));
    expect(screen.getByRole("button", { name: /^All \(2\)/ })).toBeTruthy();
    expect(screen.getByRole("button", { name: /^Core \(1\)/ })).toBeTruthy();
    fireEvent.click(screen.getByRole("button", { name: /^Unclassified \(1\)/ }));
    expect(screen.getAllByText(/_col$/).map((x) => x.textContent!.trim())).toEqual(["b_col"]);
    expect(screen.queryByRole("button", { name: /^Technical \(/ })).toBeNull();
    expect(screen.queryByRole("button", { name: /^Enrichment \(/ })).toBeNull();
  });

  it("shows the deferred FK count on the badge", () => {
    render(<EntityDrilldown entities={entities} />);
    expect(within(rowOf("invoice")).getByText("Deferred FK 1")).toBeTruthy();
  });
});
