import { describe, expect, it } from "vitest";
import { render, screen, fireEvent, within } from "@testing-library/react";
import { EntityDrilldown } from "@/components/assessment/entity-drilldown";
import type { AssessEntityOut } from "@/lib/api";

const profile = (over: Record<string, unknown>) => ({
  system: "src_oracle_ccb",
  source_table: "oracle.bill",
  source_column: "amount",
  role: "populates",
  row_count: 5000,
  null_pct: 0.5,
  distinct_count: 1200,
  fk_orphans: 0,
  note: "",
  ...over,
});

const col = (over: Record<string, unknown>) => ({
  id: "c",
  entity_id: "e",
  attribute_id: "a",
  in_model: true,
  target: "t",
  status: "mapped",
  source_table: "sap.t",
  source_column: "x",
  transform: "",
  row_count: 10,
  null_pct: 0,
  distinct_count: 5,
  date_format: "",
  fk_orphans: null,
  evidence: "",
  dup_source: false,
  tier: "core",
  profiles_by_source: [],
  ...over,
});

const ent = (over: Record<string, unknown>) => ({
  id: "e",
  domain_run_id: "r1",
  product_id: "p",
  in_model: true,
  name: "x",
  grade: "partial",
  coverage_pct: 80,
  primary_source: "sap.t",
  row_count: 100,
  net_new_candidate: false,
  mapped: 1,
  gap: 0,
  deferred_fk: 0,
  dup_source: 0,
  letter_grade: "B",
  enrichment_pct: 60,
  core_sourced: 3,
  core_total: 4,
  enrichment_sourced: 3,
  enrichment_total: 5,
  deferred_fk_count: 1,
  grade_reason: "Generic reason",
  row_filter: "mandt = '100'",
  columns: [],
  structure: "sound",
  structure_refs: [],
  ...over,
});

describe("EntityDrilldown with source profiles", () => {
  it("shows a toggle button for columns with profiles", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({ system: "src_oracle_ccb", row_count: 5000 }),
            profile({ system: "src_sap_finance", row_count: 3000 }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    expect(screen.getByRole("button", { name: /2 systems/ })).toBeTruthy();
  });

  it("does not show a toggle for columns without profiles", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [col({ id: "c1", target: "bill_amount", profiles_by_source: [] })],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    expect(screen.queryByRole("button", { name: /systems/ })).toBeNull();
  });

  it("old runs without the field render exactly as before", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [col({ id: "c1", target: "bill_amount", profiles_by_source: undefined as any })],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    expect(screen.queryByRole("button", { name: /systems/ })).toBeNull();
  });

  it("expands and collapses profile rows on toggle", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [profile({ system: "src_oracle_ccb" })],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    const toggleBtn = screen.getByRole("button", { name: /1 system/ });
    expect(toggleBtn.getAttribute("aria-expanded")).toBe("false");
    fireEvent.click(toggleBtn);
    expect(toggleBtn.getAttribute("aria-expanded")).toBe("true");
    expect(screen.getByText("src_oracle_ccb")).toBeTruthy();
    fireEvent.click(toggleBtn);
    expect(toggleBtn.getAttribute("aria-expanded")).toBe("false");
    expect(screen.queryByText("src_oracle_ccb")).toBeNull();
  });

  it("formats numbers with thousands separators", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              row_count: 123456,
              distinct_count: 54321,
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    expect(screen.getByText(/123,456/)).toBeTruthy();
    expect(screen.getByText(/54,321/)).toBeTruthy();
  });

  it("highlights non-zero fk_orphans in amber", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              fk_orphans: 42,
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    const orphanCell = screen.getByText(/^42$/).closest("div");
    expect(orphanCell?.className).toContain("amber");
  });

  it("renders zero fk_orphans without amber highlighting", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              fk_orphans: 0,
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    const orphanLabel = screen.getByText("FK orphans:");
    const orphanDiv = orphanLabel.closest("div");
    expect(orphanDiv?.className).not.toContain("amber");
  });

  it("renders null values as dashes", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              row_count: null,
              null_pct: null,
              distinct_count: null,
              fk_orphans: null,
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    const dashes = screen.getAllByText(/^—$/);
    expect(dashes.length).toBeGreaterThanOrEqual(4);
  });

  it("shows profile note when present", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              note: "joined at account grain, 1:N to bill",
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    expect(screen.getByText(/joined at account grain, 1:N to bill/)).toBeTruthy();
  });

  it("shows profile role and source_table.source_column", () => {
    const e = ent({
      id: "e1",
      name: "bill",
      columns: [
        col({
          id: "c1",
          target: "bill_amount",
          profiles_by_source: [
            profile({
              system: "src_oracle_ccb",
              role: "enriches",
              source_table: "oracle.accounts",
              source_column: "account_balance",
            }),
          ],
        }),
      ],
    }) as unknown as AssessEntityOut;
    render(<EntityDrilldown entities={[e]} />);
    fireEvent.click(within(screen.getAllByRole("row")[1]).getByRole("button", { name: /bill/ }));
    fireEvent.click(screen.getByRole("button", { name: /1 system/ }));
    expect(screen.getByText(/enriches/)).toBeTruthy();
    expect(screen.getByText(/oracle\.accounts\.account_balance/)).toBeTruthy();
  });
});
