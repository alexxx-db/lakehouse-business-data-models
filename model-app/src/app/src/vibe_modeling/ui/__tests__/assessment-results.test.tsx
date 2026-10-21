import { beforeEach, describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent, waitFor, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const api = vi.hoisted(() => ({
  useGetAssessmentResultsSuspense: vi.fn(),
  useListAssessmentDocs: vi.fn(),
  useGetAssessmentDocContent: vi.fn(),
  useGetAssessmentHandoffSuspense: vi.fn(),
  answerAssessmentDecision: vi.fn(),
  clearAssessmentDecisionAnswer: vi.fn(),
}));
vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return { ...actual, ...api };
});

import { DomainResults } from "@/components/assessment/domain-results";

const run = (over: Record<string, unknown> = {}) => ({
  id: "r1", domain_id: "d1", domain_name: "sales_order", status: "completed", model_quality_score: 72,
  skills_version: "0.4.0", skills_commit: "4c709f704d4e4bc977aeb4379409fb709f2ab7e4", genie_version: "v0.1.0-beta.2",
  metamodel_location: "", metamodel_version: "", results_valid: true, ...over,
});
const col = (over: Record<string, unknown>) => ({
  id: "c", entity_id: "e1", attribute_id: "a", in_model: true, target: "t", status: "mapped", source_table: "sap.vbak",
  source_column: "x", transform: "", row_count: 10, null_pct: 0, distinct_count: 5, date_format: "", fk_orphans: null,
  evidence: "", dup_source: false, ...over,
});
const decision = (over: Record<string, unknown> = {}) => ({
  id: "dec1", domain_run_id: "r1", gate: "2C", question: "Add net-new entity credit_check?", default_taken: "defer",
  evidence: "vbak.cmgst populated 40%", entity: "credit_check", answer_status: "open", answer_option_id: null,
  answer_text: "", answered_by: "", answered_at: null,
  options: [{ id: "o1", ordinal: 0, label: "add" }, { id: "o2", ordinal: 1, label: "defer" }, { id: "o3", ordinal: 2, label: "reject" }],
  ...over,
});
const results = (over: Record<string, unknown> = {}) => ({
  domain_run: run(),
  grades: { full: 0, partial: 1, blocked: 1 },
  entities: [
    { id: "e2", domain_run_id: "r1", product_id: null, in_model: false, name: "credit_check", grade: "blocked", coverage_pct: 0,
      primary_source: "", row_count: null, net_new_candidate: true, mapped: 0, gap: 0, deferred_fk: 0, dup_source: 0, columns: [] },
    { id: "e1", domain_run_id: "r1", product_id: "p1", in_model: true, name: "order", grade: "partial", coverage_pct: 81.5,
      primary_source: "sap.vbak", row_count: 1200, net_new_candidate: false, mapped: 3, gap: 0, deferred_fk: 1, dup_source: 2,
      columns: [
        col({ id: "c1", target: "confirmed_delivery_date", source_column: "vdatu", dup_source: true }),
        col({ id: "c2", target: "sold_to_customer_id", status: "deferred_fk", source_column: "kunnr" }),
      ] },
    { id: "e3", domain_run_id: "r1", product_id: "p2", in_model: true, name: "invoice", grade: "partial", coverage_pct: 30,
      primary_source: "sap.vbrk", row_count: 5, net_new_candidate: false, mapped: 1, gap: 1, deferred_fk: 0, dup_source: 0, columns: [] },
  ],
  gaps: [{ id: "g1", domain_run_id: "r1", entity: "order", column: "incoterms", gap_type: "NULL_SOURCE", description: "No source", status: "OPEN", ask: "Ingest vbkd" }],
  pending_decisions: [decision()],
  next_vibes: [{ id: "v1", domain_run_id: "r1", priority: 1, category: "add_column", text: "PRIORITY 1: add order.sales_organization", confidence: 0.8, problem: "", proposed_change: "", impact_if_skipped: "", urgency: "", affected_entities: [] }],
  ...over,
});

const mount = () =>
  render(
    <QueryClientProvider client={new QueryClient()}>
      <DomainResults domainRunId="r1" />
    </QueryClientProvider>,
  );
const openTab = (name: RegExp | string) => {
  const t = screen.getByRole("tab", { name });
  fireEvent.mouseDown(t, { button: 0 });
  fireEvent.click(t);
};

describe("DomainResults", () => {
  beforeEach(() => {
    Object.values(api).forEach((f) => f.mockReset());
    api.useGetAssessmentResultsSuspense.mockReturnValue({ data: results() });
    api.useListAssessmentDocs.mockReturnValue({ data: { folder_url: "https://ws/x", docs: [{ path: "docs/design/s2t.md", name: "s2t.md", category: "design" }] }, isLoading: false });
    api.useGetAssessmentDocContent.mockReturnValue({ data: { data: { path: "docs/design/s2t.md", content: "# S2T doc", truncated: false } }, isLoading: false, isError: false });
  });

  it("scorecard shows grades, score, skills and Genie versions", () => {
    mount();
    expect(screen.getByText("0 Full · 1 Partial · 1 Blocked")).toBeTruthy();
    expect(screen.getByText("Model quality score 72")).toBeTruthy();
    expect(screen.getByText(/Skills 0\.4\.0 \(4c709f7\)/)).toBeTruthy();
    expect(screen.getByText(/Genie v0\.1\.0-beta\.2/)).toBeTruthy();
    expect(screen.getByRole("tab", { name: "Hand-off" })).toBeTruthy();
  });

  it("entities table sorts blocked first, flags rows, and drills down on click", () => {
    mount();
    openTab("Entities");
    const rows = screen.getAllByRole("row").slice(1);
    expect(within(rows[0]).getByText("credit_check")).toBeTruthy();
    expect(within(rows[0]).getByText("Not in model")).toBeTruthy();
    const orderRow = rows.find((r) => within(r).queryByText("order"))!;
    expect(within(orderRow).getByText("Same source as another column")).toBeTruthy();
    expect(within(orderRow).getByText(/^Deferred FK/)).toBeTruthy();
    expect(within(rows.find((r) => within(r).queryByText("invoice"))!).getByTestId("coverage").className).toContain("amber");
    expect(within(orderRow).getByTestId("coverage").className).not.toContain("amber");
    expect(screen.queryByText("order columns")).toBeNull();
    fireEvent.click(within(orderRow).getByText("order"));
    expect(screen.getByText("order columns")).toBeTruthy();
    expect(screen.getByText("confirmed_delivery_date")).toBeTruthy();
  });

  it("lists gaps, next vibes and docs", () => {
    mount();
    openTab("Gaps");
    expect(screen.getByText("Ingest vbkd")).toBeTruthy();
    openTab("Next vibes");
    expect(screen.getByText("PRIORITY 1: add order.sales_organization")).toBeTruthy();
    expect(screen.getByText(/add the ones you keep as vibe inputs/i)).toBeTruthy();
    openTab("Docs");
    expect(screen.getByRole("button", { name: "s2t.md" })).toBeTruthy();
    expect(screen.getByRole("link", { name: "Browse folder" }).getAttribute("href")).toBe("https://ws/x");
  });

  it("decisions tab badge counts open decisions", () => {
    mount();
    expect(within(screen.getByRole("tab", { name: /Decisions/ })).getByText("1")).toBeTruthy();
  });

  it("saves an option plus free text", async () => {
    api.answerAssessmentDecision.mockResolvedValue({ data: decision() });
    mount();
    openTab(/Decisions/);
    expect((screen.getByRole("button", { name: "Save" }) as HTMLButtonElement).disabled).toBe(true);
    fireEvent.click(screen.getByRole("radio", { name: "add" }));
    fireEvent.change(screen.getByLabelText("Answer text"), { target: { value: "but later" } });
    fireEvent.click(screen.getByRole("button", { name: "Save" }));
    await waitFor(() =>
      expect(api.answerAssessmentDecision).toHaveBeenCalledWith({ decision_id: "dec1" }, { option_id: "o1", text: "but later" }),
    );
  });

  it("shows an answered decision and clears it", async () => {
    api.clearAssessmentDecisionAnswer.mockResolvedValue({ data: decision() });
    api.useGetAssessmentResultsSuspense.mockReturnValue({
      data: results({ pending_decisions: [decision({ answer_status: "answered", answer_option_id: "o2", answered_by: "dana@example.com", answered_at: "2026-10-09T10:00:00Z" })] }),
    });
    mount();
    expect(within(screen.getByRole("tab", { name: /Decisions/ })).getByText("0")).toBeTruthy();
    openTab(/Decisions/);
    expect(screen.getByText(/Answered by dana@example.com/)).toBeTruthy();
    expect((screen.getByRole("radio", { name: "defer" }) as HTMLInputElement).checked).toBe(true);
    fireEvent.click(screen.getByRole("button", { name: "Clear" }));
    await waitFor(() => expect(api.clearAssessmentDecisionAnswer).toHaveBeenCalledWith({ decision_id: "dec1" }));
  });

});
