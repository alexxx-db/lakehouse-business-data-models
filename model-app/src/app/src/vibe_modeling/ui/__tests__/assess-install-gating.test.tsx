/**
 * When the optional bronze assessment skill is not installed, the Settings →
 * Assessment tab is gone entirely (the taxonomy builder's rule); installed
 * but not ready, it shows. The help-index Assessment card shows only once ready.
 */
import { afterEach, describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Suspense, type ReactNode } from "react";
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from "@tanstack/react-router";

const { assess } = vi.hoisted(() => ({ assess: { installed: false, ready: false } }));

vi.mock("@/lib/assessment", async (importOriginal) => ({
  ...(await importOriginal<typeof import("@/lib/assessment")>()),
  useAssessReady: () => assess,
}));
vi.mock("@/components/explorer/breadcrumb-context", () => ({ useBreadcrumbs: () => {} }));

import { Route as SettingsRoute } from "@/routes/_sidebar/settings";
import { HelpIndexPage } from "@/routes/_sidebar/help.index";
import { firstRunFetcher } from "./helpers/first-run";

afterEach(() => {
  assess.installed = false;
  assess.ready = false;
  vi.unstubAllGlobals();
});

function renderAt(path: string, routePath: string, component: () => ReactNode) {
  const rootRoute = createRootRoute({ component: () => <Outlet /> });
  const sidebar = createRoute({ getParentRoute: () => rootRoute, id: "/_sidebar", component: () => <Outlet /> });
  const subject = createRoute({
    getParentRoute: () => sidebar,
    path: routePath,
    validateSearch: SettingsRoute.options.validateSearch as any,
    component: component as any,
  });
  const helpTopic = createRoute({ getParentRoute: () => rootRoute, path: "/help/$topic", component: () => <div /> });
  const router = createRouter({
    routeTree: rootRoute.addChildren([sidebar.addChildren([subject]), helpTopic]),
    history: createMemoryHistory({ initialEntries: [path] }),
    defaultPendingMs: 0,
  });
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  render(
    <QueryClientProvider client={qc}>
      <Suspense fallback={null}>
        <RouterProvider router={router} />
      </Suspense>
    </QueryClientProvider>,
  );
}

const renderSettings = (tab = "agent") =>
  renderAt(`/settings?tab=${tab}`, "/settings", SettingsRoute.options.component as () => ReactNode);

describe("Settings → Assessment tab", () => {
  it("is absent when the skill is not installed", async () => {
    vi.stubGlobal("fetch", firstRunFetcher());
    renderSettings();
    expect(await screen.findByRole("tab", { name: "Agent" })).toBeInTheDocument();
    expect(screen.queryByRole("tab", { name: "Assessment" })).toBeNull();
  });

  it("falls back to the Agent tab for an assessment deep link when not installed", async () => {
    vi.stubGlobal("fetch", firstRunFetcher());
    renderSettings("assessment");
    expect(await screen.findByRole("tab", { name: "Agent" })).toHaveAttribute("aria-selected", "true");
  });

  it("shows when installed, even before it is ready", async () => {
    assess.installed = true;
    vi.stubGlobal("fetch", firstRunFetcher());
    renderSettings();
    expect(await screen.findByRole("tab", { name: "Assessment" })).toBeInTheDocument();
  });
});

describe("Help index Assessment card", () => {
  const renderHelp = () => renderAt("/help", "/help", HelpIndexPage);

  it("is absent when the skill is not installed", async () => {
    renderHelp();
    expect(await screen.findByText("How the modeling flow works")).toBeInTheDocument();
    expect(screen.queryByText("Assessing a model against your data")).toBeNull();
  });

  it("is absent when installed but not ready", async () => {
    assess.installed = true;
    renderHelp();
    expect(await screen.findByText("How the modeling flow works")).toBeInTheDocument();
    expect(screen.queryByText("Assessing a model against your data")).toBeNull();
  });

  it("shows once ready", async () => {
    assess.installed = true;
    assess.ready = true;
    renderHelp();
    expect(await screen.findByText("Assessing a model against your data")).toBeInTheDocument();
  });
});
