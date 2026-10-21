/**
 * The version-overview and product pages own a friendly not-found card. The
 * sidebar tree and stale "Jump back in" links navigate between params on the
 * same mounted route, so the boundary must reset when the params change or the
 * card sticks (and names the wrong version). Each test starts on a 404, moves
 * to params that fail with a 500, and expects the card gone and the 500 handed
 * to the parent boundary. The real route components are cloned under the file
 * routes' ids so `Route.useParams()` resolves.
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

const modelSummary = vi.hoisted(() => vi.fn());
const productDetail = vi.hoisted(() => vi.fn());

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    useGetBusinessSuspense: () => ({ data: { id: "biz-1", name: "Retail Bank" } }),
    useListVersionsSuspense: () => ({ data: [] }),
    useGetExplorerVersionsSuspense: () => ({ data: [] }),
    useGetModelSummarySuspense: modelSummary,
    useGetProductDetailSuspense: productDetail,
  };
});

import { ApiError } from "@/lib/api";
import { Route as VersionIndexRoute } from "@/routes/_sidebar/businesses.$businessId.model.$version.$scope.index";
import { Route as ProductRoute } from "@/routes/_sidebar/businesses.$businessId.model.$version.$scope.$domainName.$productName";

const notFound = () => new ApiError(404, "Not Found", null);
const serverError = () => new ApiError(500, "Internal Server Error", null);

let consoleError: ReturnType<typeof vi.spyOn>;

function renderRoute(
  routePath: string,
  route: typeof VersionIndexRoute | typeof ProductRoute,
  initial: string,
) {
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
  const leaf = createRoute({
    getParentRoute: () => sidebar,
    path: routePath,
    component: route.options.component as never,
    validateSearch: route.options.validateSearch as never,
  });
  const router = createRouter({
    routeTree: rootRoute.addChildren([sidebar.addChildren([leaf as never])]),
    history: createMemoryHistory({ initialEntries: [initial] }),
  });
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  render(
    <QueryClientProvider client={qc}>
      <RouterProvider router={router} />
    </QueryClientProvider>,
  );
  return router;
}

async function moveTo(router: ReturnType<typeof renderRoute>, to: string) {
  await act(async () => {
    await router.navigate({ to } as never);
  });
}

beforeEach(() => {
  modelSummary.mockReset();
  productDetail.mockReset();
  consoleError = vi.spyOn(console, "error").mockImplementation(() => {});
});

afterEach(() => {
  consoleError.mockRestore();
});

describe("not-found boundary reset on param change", () => {
  it("clears the version card when the route moves to another version", async () => {
    modelSummary.mockImplementation((opts: { params: { version_int: number } }) => {
      throw opts.params.version_int === 3 ? notFound() : serverError();
    });
    const router = renderRoute(
      "/businesses/$businessId/model/$version/$scope/",
      VersionIndexRoute,
      "/businesses/biz-1/model/3/mvm",
    );
    expect(await screen.findByText("Model version not found")).toBeInTheDocument();
    expect(screen.getByText(/Version v3 MVM doesn't exist/)).toBeInTheDocument();

    await moveTo(router, "/businesses/biz-1/model/4/mvm");

    expect(await screen.findByTestId("outer-caught")).toBeInTheDocument();
    expect(screen.queryByText("Model version not found")).not.toBeInTheDocument();
  });

  it("clears the product card when the route moves to another product", async () => {
    productDetail.mockImplementation((opts: { params: { product_name: string } }) => {
      throw opts.params.product_name === "Gone" ? notFound() : serverError();
    });
    const router = renderRoute(
      "/businesses/$businessId/model/$version/$scope/$domainName/$productName",
      ProductRoute,
      "/businesses/biz-1/model/3/mvm/Sales/Gone",
    );
    expect(await screen.findByText("Product not found")).toBeInTheDocument();

    await moveTo(router, "/businesses/biz-1/model/3/mvm/Sales/Orders");

    expect(await screen.findByTestId("outer-caught")).toBeInTheDocument();
    expect(screen.queryByText("Product not found")).not.toBeInTheDocument();
  });
});
