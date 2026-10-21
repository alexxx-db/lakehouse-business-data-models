/**
 * Visit recorders for the home "Jump back in" list, mounted through the real
 * route layouts: the business layout records the business, the version-scope
 * layout records the version plus the last place inside it. A version visit
 * must not bump the parent business, and leaving the version records the
 * business again. Only `setUserPreference` is mocked.
 *
 * The layouts are cloned into a router under an `/_sidebar` id with the same
 * full route ids as the file routes, so `Route.useParams()` inside them
 * resolves.
 */
import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { StrictMode } from "react";
import { act, render, screen } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from "@tanstack/react-router";

const setUserPreference = vi.hoisted(() => vi.fn());

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return { ...actual, setUserPreference };
});

import { getUserPreferencesKey } from "@/lib/api";
import { Route as BusinessLayoutRoute } from "@/routes/_sidebar/businesses.$businessId";
import { Route as ScopeLayoutRoute } from "@/routes/_sidebar/businesses.$businessId.model.$version.$scope";

type Router = ReturnType<typeof buildRouter>;

function stub(testId: string) {
  return () => <div data-testid={testId} />;
}

function buildRouter(initial: string) {
  const rootRoute = createRootRoute({ component: () => <Outlet /> });
  const sidebar = createRoute({
    getParentRoute: () => rootRoute,
    id: "/_sidebar",
    component: () => <Outlet />,
  });
  const business = createRoute({
    getParentRoute: () => sidebar,
    path: "/businesses/$businessId",
    component: BusinessLayoutRoute.options.component as never,
  });
  const explorer = createRoute({
    getParentRoute: () => business,
    path: "/explorer",
    component: stub("explorer"),
  });
  const scope = createRoute({
    getParentRoute: () => business,
    path: "/model/$version/$scope",
    component: ScopeLayoutRoute.options.component as never,
  });
  const overview = createRoute({
    getParentRoute: () => scope,
    path: "/",
    component: stub("overview"),
  });
  const inputs = createRoute({
    getParentRoute: () => scope,
    path: "/inputs",
    component: stub("inputs"),
  });
  const domain = createRoute({
    getParentRoute: () => scope,
    path: "/$domainName",
    component: () => <Outlet />,
  });
  const domainIndex = createRoute({
    getParentRoute: () => domain,
    path: "/",
    component: stub("domain"),
  });
  const product = createRoute({
    getParentRoute: () => domain,
    path: "/$productName",
    component: stub("product"),
  });
  return createRouter({
    routeTree: rootRoute.addChildren([
      sidebar.addChildren([
        business.addChildren([
          explorer,
          scope.addChildren([overview, inputs, domain.addChildren([domainIndex, product])]),
        ]),
      ]),
    ]),
    history: createMemoryHistory({ initialEntries: [initial] }),
  });
}

let client: QueryClient;
let router: Router;

async function mount(initial: string, testId: string) {
  router = buildRouter(initial);
  render(
    <StrictMode>
      <QueryClientProvider client={client}>
        <RouterProvider router={router} />
      </QueryClientProvider>
    </StrictMode>,
  );
  await screen.findByTestId(testId);
}

async function go(to: string, testId: string) {
  await act(async () => {
    await router.navigate({ to } as never);
  });
  await screen.findByTestId(testId);
}

function writes(): Array<[string, string]> {
  return setUserPreference.mock.calls.map(
    ([{ key }, { value }]) => [key, value] as [string, string],
  );
}

beforeEach(() => {
  client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  setUserPreference.mockReset();
  setUserPreference.mockResolvedValue({ data: {} });
});

afterEach(() => {
  vi.restoreAllMocks();
});

describe("visit recorders", () => {
  it("writes the business key once from the explorer, even under StrictMode", async () => {
    await mount("/businesses/biz-1/explorer", "explorer");
    expect(writes()).toEqual([["visit:business:biz-1", "1"]]);
  });

  it("writes the version key with an overview value and does not bump the business", async () => {
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    expect(writes()).toEqual([["visit:version:biz-1:3:mvm", "{}"]]);
  });

  it("remembers the domain, ignores product moves, and returns to the overview", async () => {
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    expect(writes()).toEqual([["visit:version:biz-1:3:mvm", "{}"]]);

    await go("/businesses/biz-1/model/3/mvm/Sales", "domain");
    expect(writes().slice(1)).toEqual([["visit:version:biz-1:3:mvm", '{"domain":"Sales"}']]);

    setUserPreference.mockClear();
    await go("/businesses/biz-1/model/3/mvm/Sales/Customers", "product");
    await go("/businesses/biz-1/model/3/mvm/Sales/Orders", "product");
    expect(writes()).toEqual([]);

    await go("/businesses/biz-1/model/3/mvm", "overview");
    expect(writes()).toEqual([["visit:version:biz-1:3:mvm", "{}"]]);
    expect(writes().every(([key]) => !key.startsWith("visit:business:"))).toBe(true);
  });

  it("stores a domain name with special characters verbatim", async () => {
    await mount("/businesses/biz-1/model/3/mvm/Sales%20%26%20Marketing", "domain");
    expect(writes()).toEqual([
      ["visit:version:biz-1:3:mvm", '{"domain":"Sales & Marketing"}'],
    ]);
  });

  it("records the overview value for the inputs pages", async () => {
    await mount("/businesses/biz-1/model/3/mvm/inputs", "inputs");
    expect(writes()).toEqual([["visit:version:biz-1:3:mvm", "{}"]]);
  });

  it("writes a new key when the version changes", async () => {
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    await go("/businesses/biz-1/model/4/mvm", "overview");
    expect(writes()).toEqual([
      ["visit:version:biz-1:3:mvm", "{}"],
      ["visit:version:biz-1:4:mvm", "{}"],
    ]);
  });

  it("records the business again when leaving a version for the explorer", async () => {
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    await go("/businesses/biz-1/explorer", "explorer");
    expect(writes()).toEqual([
      ["visit:version:biz-1:3:mvm", "{}"],
      ["visit:business:biz-1", "1"],
    ]);
  });

  it("records the business on entry, again after a version visit", async () => {
    await mount("/businesses/biz-1/explorer", "explorer");
    await go("/businesses/biz-1/model/3/mvm", "overview");
    await go("/businesses/biz-1/explorer", "explorer");
    expect(writes().map(([key]) => key)).toEqual([
      "visit:business:biz-1",
      "visit:version:biz-1:3:mvm",
      "visit:business:biz-1",
    ]);
  });

  it.each([
    ["/businesses/biz-1/model/abc/foo", "non-numeric version and unknown scope"],
    ["/businesses/biz-1/model/03/mvm", "zero-padded version"],
    ["/businesses/biz-1/model/0/mvm", "zero version"],
    ["/businesses/biz-1/model/3/xyz", "unknown scope"],
  ])("writes no version key for %s (%s)", async (path) => {
    await mount(path, "overview");
    expect(writes()).toEqual([]);
  });

  it("refreshes the preferences query after each write", async () => {
    client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
    const invalidate = vi.spyOn(client, "invalidateQueries");
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    await vi.waitFor(() => expect(invalidate).toHaveBeenCalledTimes(1));
    expect(invalidate).toHaveBeenCalledWith({ queryKey: getUserPreferencesKey() });
  });

  it("still renders when the visit write fails", async () => {
    setUserPreference.mockRejectedValue(new Error("401"));
    await mount("/businesses/biz-1/model/3/mvm", "overview");
    expect(screen.getByTestId("overview")).toBeInTheDocument();
  });
});
