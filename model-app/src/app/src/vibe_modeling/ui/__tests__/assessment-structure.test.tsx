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
import { DecisionCard } from "@/components/assessment/decision-card";
import { EntityDrilldown } from "@/components/assessment/entity-drilldown";
import type { AssessEntityOut } from "@/lib/api";

const ent = (over: Record<string, unknown>) =>
  ({
    id: "e", domain_run_id: "r1", product_id: "p", in_model: true, name: "x", grade: "partial", coverage_pct: 80,
    primary_source: "s", row_count: 1, net_new_candidate: false, mapped: 1, gap: 0, deferred_fk: 0, dup_source: 0,
    letter_grade: "B", enrichment_pct: 60, core_sourced: 3, core_total: 4, deferred_fk_count: 0, columns: [],
    structure: "sound", structure_refs: [], ...over,
  }) as unknown as AssessEntityOut;
const dec = (over: Record<string, unknown>) => ({
  id: "d", domain_run_id: "r1", gate: "G", question: "Q?", entity: "x", default_taken: "", evidence: "", context: "",
  why_it_matters: "", recommendation_rationale: "", blocks_build: false, affected: [], kind: "structure", ordinal: 0,
  options: [], answer_status: "open", answer_option_id: null, answer_text: "", answered_by: "", answered_at: null, ...over,
});
const results = () => ({
  domain_run: { id: "r1", domain_id: "d1", domain_name: "s", status: "completed", model_quality_score: 70, skills_version: "", skills_commit: "", genie_version: "", metamodel_location: "", metamodel_version: "", results_valid: true },
  grades: { full: 0, partial: 3, blocked: 0 }, letter_counts: { A: 1, B: 1, C: 1, D: 0, F: 0 },
  structure_counts: { sound: 1, review: 1, rework: 1 },
  entities: [
    ent({ id: "e1", name: "tariff_rider", letter_grade: "A", structure: "rework", structure_refs: ["D2"] }),
    ent({ id: "e2", name: "other", letter_grade: "B" }),
    ent({ id: "e3", name: "pay", letter_grade: "C", structure: "review", structure_refs: ["Vibe 1"] }),
  ],
  gaps: [], next_vibes: [],
  pending_decisions: [
    dec({ id: "da", ordinal: 0, kind: "source", question: "Source q" }),
    dec({ id: "db", ordinal: 1, kind: "structure", question: "Shape q", blocks_build: true }),
  ],
});

const mount = (ui: React.ReactElement) => render(<QueryClientProvider client={new QueryClient()}>{ui}</QueryClientProvider>);
const rowOf = (name: string) => screen.getAllByRole("row").find((r) => within(r).queryByText(name))!;

describe("assessment structure axis", () => {
  beforeEach(() => {
    Object.values(api).forEach((f) => f.mockReset());
    api.useGetAssessmentResultsSuspense.mockReturnValue({ data: results() });
    api.useListAssessmentDocs.mockReturnValue({ data: { folder_url: "", docs: [] }, isLoading: false });
    api.useGetAssessmentDocContent.mockReturnValue({ data: undefined, isLoading: false, isError: false });
    api.useGetAssessmentHandoffSuspense.mockReturnValue({ data: undefined });
  });

  it("renders the structure badge text and refs in the entities table", () => {
    mount(<EntityDrilldown entities={results().entities} />);
    const r = rowOf("tariff_rider");
    expect(within(r).getByText("Rework")).toBeTruthy();
    expect(within(r).getByText("D2")).toBeTruthy();
    expect(within(rowOf("other")).getByText("Sound")).toBeTruthy();
    expect(within(rowOf("pay")).getByText("Review")).toBeTruthy();
  });

  it("sorts letter first, then structure within an equal gate", () => {
    const es = [
      ent({ id: "a", name: "sound_one", structure: "sound" }),
      ent({ id: "b", name: "rework_one", structure: "rework", structure_refs: ["D1"] }),
    ];
    mount(<EntityDrilldown entities={es} />);
    const names = screen.getAllByRole("row").slice(1).map((r) => ["sound_one", "rework_one"].find((n) => within(r).queryByText(n)));
    expect(names).toEqual(["rework_one", "sound_one"]);
  });

  it("shows structure chips on the scorecard", () => {
    mount(<DomainResults domainRunId="r1" />);
    expect(screen.getByText("1 Sound")).toBeTruthy();
    expect(screen.getByText("1 Review")).toBeTruthy();
    expect(screen.getByText("1 Rework")).toBeTruthy();
  });

  it("labels each decision card with its kind and D-number and anchors it", () => {
    mount(<DecisionCard decision={dec({ ordinal: 2, kind: "scope" }) as never} domainRunId="r1" />);
    expect(screen.getByText("Scope")).toBeTruthy();
    expect(screen.getByText("D3")).toBeTruthy();
    expect(document.getElementById("decision-D3")).toBeTruthy();
  });

  it("a D ref jumps to the Decisions tab and scrolls to that card", async () => {
    const scroll = vi.fn();
    Element.prototype.scrollIntoView = scroll;
    mount(<DomainResults domainRunId="r1" />);
    const t = screen.getByRole("tab", { name: /Entities/ });
    fireEvent.mouseDown(t, { button: 0 });
    fireEvent.click(t);
    fireEvent.click(within(rowOf("tariff_rider")).getByRole("button", { name: "Go to D2" }));
    expect(screen.getByRole("tab", { name: /Decisions/ }).getAttribute("aria-selected")).toBe("true");
    expect(document.getElementById("decision-D2")).toBeTruthy();
    await waitFor(() => expect(scroll).toHaveBeenCalled());
  });
});
