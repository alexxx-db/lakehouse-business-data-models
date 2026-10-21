/**
 * Help center — index + the two fully-written pages (flow, shortcuts) + the
 * shared coming-soon template. Guards the real shortcut content, the flow
 * stages, and the index topic list against drift, and fails on any DOM-nesting
 * warning (the kbd/badge caps sit inside text runs).
 */
import { describe, it, expect, vi } from "vitest";
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

vi.mock("@/lib/api", async (importOriginal) => ({
  ...(await importOriginal<typeof import("@/lib/api")>()),
  useGetAssessConfig: () => ({ data: { data: { installed: true, ready: true } } }),
}));

import { HelpIndexPage } from "@/routes/_sidebar/help.index";
import {
  FlowContent,
  ShortcutsContent,
  ComingSoonContent,
  AssessmentContent,
} from "@/components/help/help-content";
import { ASSESS_MODEL } from "@/lib/assessment";
import { HELP_TOPICS } from "@/components/help/help-topics";
import { useStrictConsole } from "./helpers/strict-console";

function withRouter(ui: ReactNode) {
  const rootRoute = createRootRoute({ component: () => <Outlet /> });
  const subject = createRoute({
    getParentRoute: () => rootRoute,
    path: "/",
    component: () => <>{ui}</>,
  });
  const helpIndex = createRoute({
    getParentRoute: () => rootRoute,
    path: "/help",
    component: () => <div data-testid="help-index-stub" />,
  });
  const helpTopic = createRoute({
    getParentRoute: () => rootRoute,
    path: "/help/$topic",
    component: () => <div data-testid="help-topic-stub" />,
  });
  const router = createRouter({
    routeTree: rootRoute.addChildren([subject, helpIndex, helpTopic]),
    history: createMemoryHistory({ initialEntries: ["/"] }),
  });
  return <RouterProvider router={router} />;
}

describe("Help index", () => {
  const dom = useStrictConsole();

  it("lists every topic under its group, marking unwritten ones", async () => {
    render(withRouter(<HelpIndexPage />));
    await screen.findByText(HELP_TOPICS[0].title);
    for (const topic of HELP_TOPICS) {
      expect(screen.getByText(topic.title)).toBeInTheDocument();
    }
    expect(screen.getByText("Getting started")).toBeInTheDocument();
    expect(screen.getByText("Reference")).toBeInTheDocument();
    // Three topics are coming-soon.
    expect(screen.getAllByText(/coming soon/i).length).toBeGreaterThanOrEqual(3);
    expect(dom.messages).toEqual([]);
  });
});

describe("Shortcuts page", () => {
  const dom = useStrictConsole();

  it("renders the real shortcuts, grouped, with a context-sensitivity note", async () => {
    render(withRouter(<ShortcutsContent />));
    expect(await screen.findByText("Global")).toBeInTheDocument();
    expect(
      screen.getByText(/Open model search/i),
    ).toBeInTheDocument();
    expect(screen.getByText(/Toggle the sidebar/i)).toBeInTheDocument();
    expect(screen.getByText(/Cancel \/ close the dialog/i)).toBeInTheDocument();
    // Key caps rendered.
    expect(screen.getAllByText("K").length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText("Esc")).toBeInTheDocument();
    expect(screen.getAllByText(/context-sensitive/i).length).toBeGreaterThanOrEqual(1);
    expect(dom.messages).toEqual([]);
  });
});

describe("Flow page", () => {
  const dom = useStrictConsole();

  it("renders the intro and the expanded stage prose", async () => {
    render(withRouter(<FlowContent />));
    expect(
      await screen.findByText(/Here's the loop, end to end/i),
    ).toBeInTheDocument();
    expect(screen.getByText(/Review and give feedback/i)).toBeInTheDocument();
    expect(screen.getByText(/mark domains as reviewed/i)).toBeInTheDocument();
    expect(dom.messages).toEqual([]);
  });
});

describe("Assessment page", () => {
  const dom = useStrictConsole();

  it("is listed in the help catalogue right after the flow topic", () => {
    const slugs = HELP_TOPICS.map((t) => t.slug);
    expect(slugs.indexOf("assessment")).toBe(slugs.indexOf("flow") + 1);
    const topic = HELP_TOPICS.find((t) => t.slug === "assessment")!;
    expect(topic.title).toBe("Assessing a model against your data");
    expect(topic.status).toBe("ready");
    expect(topic.group).toBe("Getting started");
  });

  it("renders its six sections and the settings link", async () => {
    render(withRouter(<AssessmentContent />));
    for (const h of [
      "What an assessment does",
      "Before you start",
      "Running one",
      "What you get",
      "After the assessment",
      "Time and cost",
    ]) {
      expect(await screen.findByRole("heading", { name: h })).toBeInTheDocument();
    }
    expect(screen.getAllByText(/read-only/i).length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText(/etl-development-framework/)).toBeInTheDocument();
    expect(screen.getByText(/30.60 minutes per domain/i)).toBeInTheDocument();
    expect(screen.getByText(new RegExp(ASSESS_MODEL))).toBeInTheDocument();
    expect(screen.getByText(/Databricks account team/)).toBeInTheDocument();
    const link = screen.getByRole("link", { name: /Settings → Assessment/ });
    expect(link).toHaveAttribute("href", expect.stringContaining("/settings"));
    expect(dom.messages).toEqual([]);
  });
});

describe("Coming-soon template", () => {
  const dom = useStrictConsole();

  it("renders a known-but-unwritten topic without looking broken", async () => {
    render(withRouter(<ComingSoonContent slug="glossary" />));
    expect(await screen.findByText("Glossary")).toBeInTheDocument();
    expect(screen.getByText(/coming soon/i)).toBeInTheDocument();
    expect(dom.messages).toEqual([]);
  });
});
