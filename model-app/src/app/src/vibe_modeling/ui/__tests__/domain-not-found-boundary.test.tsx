/**
 * Domain page not-found boundary. The domain request 404s when the domain or
 * the whole model version is gone, so the card covers both and links to the
 * version overview (which has its own not-found card). Other errors are
 * re-thrown to the parent boundary. The real route component is cloned under
 * the file route's id so `Route.useParams()` resolves.
 */
import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { act, render, screen } from "@testing-library/react";
import { ErrorBoundary } from "react-error-boundary";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from "@tanstack/react-router";

const domainDetail = vi.hoisted(() => vi.fn());

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    useGetBusinessSuspense: () => ({ data: { id: "biz-1", name: "Retail Bank" } }),
    useGetDomainDetailSuspense: domainDetail,
  };
});

import { ApiError } from "@/lib/api";
import { Route as DomainIndexRoute } from "@/routes/_sidebar/businesses.$businessId.model.$version.$scope.$domainName.index";

let consoleError: ReturnType<typeof vi.spyOn>;

function renderDomainPage(path: string) {
  const rootRoute = createRootRoute({
    component: () => (
      <ErrorBoundary fallbackRender={() => <div data-testid="outer-caught" />}>
        <Outlet />
      </ErrorBoundary>
    ),
  });
  const sidebar = createRoute({
    getParentRoute: () => rootRoute,
    id: "/_sidebar",
    component: () => <Outlet />,
  });
  const domain = createRoute({
    getParentRoute: () => sidebar,
    path: "/businesses/$businessId/model/$version/$scope/$domainName",
    component: () => <Outlet />,
  });
  const domainIndex = createRoute({
    getParentRoute: () => domain,
    path: "/",
    component: DomainIndexRoute.options.component as never,
    validateSearch: DomainIndexRoute.options.validateSearch as never,
  });
  const overview = createRoute({
    getParentRoute: () => sidebar,
    path: "/businesses/$businessId/model/$version/$scope",
    component: () => <div data-testid="overview" />,
  });
  const router = createRouter({
    routeTree: rootRoute.addChildren([
      sidebar.addChildren([domain.addChildren([domainIndex as never]), overview]),
    ]),
    history: createMemoryHistory({ initialEntries: [path] }),
  });
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  const utils = render(
    <QueryClientProvider client={qc}>
      <RouterProvider router={router} />
    </QueryClientProvider>,
  );
  return { ...utils, router };
}

beforeEach(() => {
  domainDetail.mockReset();
  consoleError = vi.spyOn(console, "error").mockImplementation(() => {});
});

afterEach(() => {
  consoleError.mockRestore();
});

describe("domain page not-found boundary", () => {
  it("renders a card covering domain and version, with a link to the version overview", async () => {
    domainDetail.mockImplementation(() => {
      throw new ApiError(404, "Not Found", { detail: "Domain not found" });
    });
    renderDomainPage("/businesses/biz-1/model/3/mvm/Gone?tab=products");

    expect(await screen.findByText("Domain not found")).toBeInTheDocument();
    expect(
      screen.getByText(/This domain or model version is no longer available in v3 MVM\./),
    ).toBeInTheDocument();
    const link = screen.getByRole("link", { name: /Back to v3 MVM overview/ });
    expect(link).toHaveAttribute("href", "/businesses/biz-1/model/3/mvm?tab=overview");
    expect(screen.queryByTestId("outer-caught")).not.toBeInTheDocument();
  });

  it("re-throws other errors to the parent boundary", async () => {
    domainDetail.mockImplementation(() => {
      throw new ApiError(500, "Internal Server Error", null);
    });
    renderDomainPage("/businesses/biz-1/model/3/mvm/Sales");

    expect(await screen.findByTestId("outer-caught")).toBeInTheDocument();
    expect(screen.queryByText("Domain not found")).not.toBeInTheDocument();
  });

  it("clears the card when the same mounted route moves to another domain", async () => {
    domainDetail.mockImplementation(
      (opts: { params: { domain_name: string } }) => {
        throw opts.params.domain_name === "Gone"
          ? new ApiError(404, "Not Found", null)
          : new ApiError(500, "Internal Server Error", null);
      },
    );
    const { router } = renderDomainPage("/businesses/biz-1/model/3/mvm/Gone");
    expect(await screen.findByText("Domain not found")).toBeInTheDocument();

    await act(async () => {
      await router.navigate({ to: "/businesses/biz-1/model/3/mvm/Sales" } as never);
    });

    expect(await screen.findByTestId("outer-caught")).toBeInTheDocument();
    expect(screen.queryByText("Domain not found")).not.toBeInTheDocument();
  });
});
