import { beforeEach, describe, expect, it, vi } from "vitest";
import { fireEvent, render, screen, waitFor, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const api = vi.hoisted(() => ({ answerAssessmentDecision: vi.fn(), clearAssessmentDecisionAnswer: vi.fn() }));
vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return { ...actual, ...api };
});

import { DecisionCard } from "@/components/assessment/decision-card";
import { DecisionList } from "@/components/assessment/decision-card";

const opt = (id: string, label: string, over: Record<string, unknown> = {}) => ({
  id, label, ordinal: 0, pros: [], cons: [], impact: "", recommended: false, ...over,
});
const decision = (over: Record<string, unknown> = {}) =>
  ({
    id: "d1", domain_run_id: "r1", gate: "G2", entity: "credit_check", question: "Include credit check?",
    context: "Credit check has no source table.", why_it_matters: "Blocks the order release flow.",
    recommendation_rationale: "Cheapest way to keep the flow working.", blocks_build: true,
    default_taken: "Deferred it", evidence: "vbak.cmgst populated 40%",
    affected: [{ entity: "credit_check", column: "status" }],
    options: [
      opt("o1", "Add source", { pros: ["Complete flow"], cons: ["Needs ingestion"], impact: "2 days", recommended: true }),
      opt("o2", "Defer", { pros: ["No work"], cons: ["Flow incomplete"], impact: "none" }),
    ],
    answer_status: "open", answer_option_id: null, answer_text: "", answered_by: "", answered_at: null, ...over,
  }) as never;
const mount = (ui: React.ReactElement) =>
  render(<QueryClientProvider client={new QueryClient()}>{ui}</QueryClientProvider>);

describe("DecisionCard", () => {
  beforeEach(() => vi.clearAllMocks());

  it("affected chip omits the dot when the column is empty", () => {
    mount(<DecisionCard decision={decision({ affected: [{ entity: "credit_check", column: "" }] })} domainRunId="r1" />);
    expect(screen.getByText("credit_check")).toBeTruthy();
    expect(screen.queryByText("credit_check.")).toBeNull();
  });

  it("renders context, why it matters, pros and cons per option", () => {
    mount(<DecisionCard decision={decision()} domainRunId="r1" />);
    expect(screen.getByText("Blocks build")).toBeTruthy();
    expect(screen.getByText("Context")).toBeTruthy();
    expect(screen.getByText("Credit check has no source table.")).toBeTruthy();
    expect(screen.getByText("Why it matters")).toBeTruthy();
    expect(screen.getByText("Complete flow")).toBeTruthy();
    expect(screen.getByText("Needs ingestion")).toBeTruthy();
    expect(screen.getByText("No work")).toBeTruthy();
    expect(screen.getByText("Flow incomplete")).toBeTruthy();
    expect(screen.getByText("2 days")).toBeTruthy();
    expect(screen.getByText("credit_check.status")).toBeTruthy();
    expect(screen.getByText(/Default the run took: Deferred it/)).toBeTruthy();
  });

  it("badges the recommended option and states the recommendation", () => {
    mount(<DecisionCard decision={decision()} domainRunId="r1" />);
    const col = screen.getByTestId("option-o1");
    expect(within(col).getByText("Recommended")).toBeTruthy();
    expect(within(screen.getByTestId("option-o2")).queryByText("Recommended")).toBeNull();
    expect(screen.getByText(/Recommended: Add source — Cheapest way/)).toBeTruthy();
  });

  it("preselects the recommended option only when unanswered", () => {
    const { unmount } = mount(<DecisionCard decision={decision()} domainRunId="r1" />);
    expect((screen.getByRole("radio", { name: "Add source" }) as HTMLInputElement).checked).toBe(true);
    unmount();
    mount(
      <DecisionCard
        decision={decision({ answer_status: "answered", answer_option_id: "o2", answered_by: "d@x.com" })}
        domainRunId="r1"
      />,
    );
    expect((screen.getByRole("radio", { name: "Defer" }) as HTMLInputElement).checked).toBe(true);
    expect((screen.getByRole("radio", { name: "Add source" }) as HTMLInputElement).checked).toBe(false);
  });

  it("saves the preselected recommended option", async () => {
    api.answerAssessmentDecision.mockResolvedValue({ data: {} });
    mount(<DecisionCard decision={decision()} domainRunId="r1" />);
    fireEvent.click(screen.getByRole("button", { name: "Save" }));
    await waitFor(() =>
      expect(api.answerAssessmentDecision).toHaveBeenCalledWith({ decision_id: "d1" }, { option_id: "o1", text: "" }),
    );
  });

  it("does not preselect for a text-only answer", () => {
    mount(
      <DecisionCard decision={decision({ answer_status: "answered", answer_text: "mine" })} domainRunId="r1" />,
    );
    expect((screen.getByRole("radio", { name: "Add source" }) as HTMLInputElement).checked).toBe(false);
  });

  it("falls back to the plain layout for old-shape decisions", () => {
    mount(
      <DecisionCard
        decision={decision({
          context: "", why_it_matters: "", recommendation_rationale: "", blocks_build: false, affected: [],
          options: [opt("o1", "Add source"), opt("o2", "Defer")],
        })}
        domainRunId="r1"
      />,
    );
    expect(screen.queryByText("Context")).toBeNull();
    expect(screen.queryByText("Why it matters")).toBeNull();
    expect(screen.queryByText("Pros")).toBeNull();
    expect(screen.queryByText("Blocks build")).toBeNull();
    expect(screen.queryByText(/Recommended/)).toBeNull();
    expect(screen.getByRole("radio", { name: "Add source" })).toBeTruthy();
    expect(screen.getByText(/Evidence/)).toBeTruthy();
  });
});

describe("DecisionList", () => {
  it("groups decisions by kind and displays them", () => {
    mount(
      <DecisionList
        decisions={[decision({ id: "a", question: "Blocking one" }), decision({ id: "b", question: "Other one", blocks_build: false })]}
        domainRunId="r1"
      />,
    );
    // Decisions without kind go to "Other" section
    expect(screen.getByText("Other")).toBeTruthy();
    expect(screen.getByText(/Blocking one/)).toBeTruthy();
    expect(screen.getByText(/Other one/)).toBeTruthy();
  });
  it("renders both open and answered decisions in their kind sections", () => {
    mount(
      <DecisionList
        decisions={[
          decision({ id: "s1", ordinal: 0, kind: "structure", question: "Struct open", answer_status: "open" }),
          decision({ id: "s2", ordinal: 1, kind: "structure", question: "Struct answered", answer_status: "answered", answered_by: "user@example.com" }),
          decision({ id: "src1", ordinal: 2, kind: "source", question: "Source open", answer_status: "open" }),
          decision({ id: "src2", ordinal: 3, kind: "source", question: "Source answered", answer_status: "answered", answered_by: "user@example.com" }),
        ]}
        domainRunId="r1"
      />,
    );
    // Check structure section
    expect(screen.getByText("Answered by running the next vibes")).toBeTruthy();
    expect(screen.getByText(/Struct open/)).toBeTruthy();
    expect(screen.getByText(/Struct answered/)).toBeTruthy();
    // Check source section
    expect(screen.getByText("Answer at the build gate")).toBeTruthy();
    expect(screen.getByText(/Source open/)).toBeTruthy();
    expect(screen.getByText(/Source answered/)).toBeTruthy();
  });
});
