/**
 * Shared workflow diagram - the same five stages must render in both the terse
 * home-page strip and the expanded help-flow variant, so the two surfaces read
 * as the same picture. Guards the stage content and the loop-back / publish
 * affordances against silent drift. Publish is a terminal node (not a
 * clickable pill); the loop meaning is carried by a visible caption.
 */
import { describe, it, expect } from "vitest";
import { ReactNode } from "react";
import { render, screen } from "@testing-library/react";
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from "@tanstack/react-router";

import {
  WorkflowDiagram,
  WORKFLOW_STAGES,
  POST_PUBLISH_STAGES,
} from "@/components/flow/workflow-diagram";
import { useStrictConsole } from "./helpers/strict-console";

/** The expanded variant links into /help, so it needs router context. */
function withRouter(ui: ReactNode) {
  const rootRoute = createRootRoute({ component: () => <Outlet /> });
  const subject = createRoute({
    getParentRoute: () => rootRoute,
    path: "/",
    component: () => <>{ui}</>,
  });
  const helpTopic = createRoute({
    getParentRoute: () => rootRoute,
    path: "/help/$topic",
    component: () => <div />,
  });
  const router = createRouter({
    routeTree: rootRoute.addChildren([subject, helpTopic]),
    history: createMemoryHistory({ initialEntries: ["/"] }),
  });
  return <RouterProvider router={router} />;
}

describe("WorkflowDiagram", () => {
  const dom = useStrictConsole();

  it("renders all five stage labels in the strip variant", () => {
    render(<WorkflowDiagram variant="strip" />);
    for (const stage of WORKFLOW_STAGES) {
      expect(screen.getByText(stage.label)).toBeInTheDocument();
    }
    // Publish renders as a split terminal node (label + sub), not a pill.
    expect(screen.getByText("Publish")).toBeInTheDocument();
    expect(screen.getByText(/to Unity Catalog/i)).toBeInTheDocument();
    // The Publish node must not be a clickable control.
    const publish = screen.getByText("Publish");
    expect(publish.closest("button")).toBeNull();
    expect(publish.closest("a")).toBeNull();
    expect(dom.messages).toEqual([]);
  });

  it("renders stage prose, the Publish terminal, and the loop caption in the expanded variant", async () => {
    const { container } = render(withRouter(<WorkflowDiagram variant="expanded" />));
    await screen.findByText(/Begin from an industry template/i);
    // Every stage's fuller prose telling should be present.
    expect(
      screen.getByText(/Begin from an industry template/i),
    ).toBeInTheDocument();
    expect(screen.getByText(/produces a new model version/i)).toBeInTheDocument();
    // Publish is a terminal node with its full label, not a button/link.
    const publish = screen.getByText(/^Publish$/);
    expect(publish).toBeInTheDocument();
    expect(publish.closest("button")).toBeNull();
    expect(publish.closest("a")).toBeNull();
    expect(screen.getByText("Publish to Unity Catalog")).toBeInTheDocument();
    // The loop is iterative, not linear; the loop-back caption must show.
    expect(
      screen.getByText(/repeat until it reflects your business/i),
    ).toBeInTheDocument();
    // The decorative loop-back rail is drawn as an aria-hidden SVG, so the
    // visual affordance can't be silently dropped without this failing.
    expect(
      container.querySelector('svg.absolute[aria-hidden="true"]'),
    ).not.toBeNull();
    expect(dom.messages).toEqual([]);
  });

  it("hides the After-you-publish phase unless assessment is ready", () => {
    render(<WorkflowDiagram variant="strip" />);
    expect(screen.queryByText("After you publish")).toBeNull();
    for (const stage of POST_PUBLISH_STAGES) {
      expect(screen.queryByText(stage.label)).toBeNull();
    }
    expect(screen.queryByText("Hand off to Genie Code")).toBeNull();
  });

  it("hides the After-you-publish section and help link in the expanded variant unless ready", async () => {
    render(withRouter(<WorkflowDiagram variant="expanded" />));
    expect(await screen.findByText(/Step 05 loops back to step 02/i)).toBeInTheDocument();
    expect(screen.queryByRole("heading", { name: "After you publish" })).toBeNull();
    expect(screen.queryByRole("link", { name: /Read more about assessments/i })).toBeNull();
  });

  it("renders the After-you-publish band in the strip variant", () => {
    render(<WorkflowDiagram variant="strip" assessment />);
    expect(screen.getByText("After you publish")).toBeInTheDocument();
    expect(POST_PUBLISH_STAGES.map((s) => s.n)).toEqual([6, 7]);
    for (const stage of POST_PUBLISH_STAGES) {
      expect(screen.getByText(stage.label)).toBeInTheDocument();
      expect(screen.getByText(stage.phrase)).toBeInTheDocument();
    }
    expect(screen.getByText("Hand off to Genie Code")).toBeInTheDocument();
    expect(screen.getByText("build → validate → document")).toBeInTheDocument();
    expect(
      screen.getByText("Assessment next vibes feed your next modeling iteration."),
    ).toBeInTheDocument();
    // The 01-05 loop caption is unchanged.
    expect(screen.getByText(/Step 05 loops back to step 02/i)).toBeInTheDocument();
  });

  it("renders the After-you-publish section in the expanded variant, outside the loop rail", async () => {
    const { container } = render(withRouter(<WorkflowDiagram variant="expanded" assessment />));
    expect(await screen.findByRole("heading", { name: "After you publish" })).toBeInTheDocument();
    for (const stage of POST_PUBLISH_STAGES) {
      expect(screen.getByText(stage.label)).toBeInTheDocument();
      expect(screen.getByText(stage.prose)).toBeInTheDocument();
    }
    expect(screen.getByText("Hand off to Genie Code")).toBeInTheDocument();
    expect(screen.getByText(/ready prompts to continue the assessment/i)).toBeInTheDocument();
    const link = screen.getByRole("link", { name: /Read more about assessments/i });
    expect(link).toHaveAttribute("href", "/help/assessment");
    // Still exactly one loop rail, and the loop caption is intact.
    expect(container.querySelectorAll('svg.absolute[aria-hidden="true"]')).toHaveLength(1);
    expect(screen.getByText(/Step 05 loops back to step 02/i)).toBeInTheDocument();
  });
});
