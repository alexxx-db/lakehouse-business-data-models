/**
 * Home / landing page (route `/`). Replaces the old redirect-to-businesses.
 * Covers the two jobs the page must do: orient a newcomer (the workflow strip
 * + "Learn how it works" link) and resume a returning user ("Jump back in"
 * with recency-ordered business, industry and model-version items). Also the empty state for a fresh workspace.
 * Also covers prune-on-load: stale and excess visit rows are deleted once per
 * mount, only after the business list and the preferences have finished
 * fetching.
 *
 * The suspense list hooks are mocked so the page renders synchronously; the
 * import dialog is stubbed to its trigger to avoid dragging its own fetches in.
 */
import { describe, it, expect, vi, beforeEach } from "vitest";
import { ReactNode, StrictMode, useSyncExternalStore } from "react";
import { act, render, screen, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { getUserPreferencesKey } from "@/lib/api";
import { PRUNE_CONCURRENCY } from "@/components/home/recent-items";
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from "@tanstack/react-router";

let businessesData: unknown[] = [];
let userPrefsData: unknown[] | undefined = [];
const listIndustriesSuspense = vi.hoisted(() => vi.fn());
const deleteUserPreferenceMock = vi.hoisted(() => vi.fn());

// The mocked list and preferences hooks read this store through
// `useSyncExternalStore`, so a test can flip `isFetching`, `dataUpdatedAt` or
// the preferences array and have the mounted page re-render.
const query = {
  listUpdatedAt: Date.now(),
  listFetching: false,
  prefsFetching: false,
  version: 0,
  listeners: new Set<() => void>(),
};
function setQuery(patch: Partial<Pick<typeof query, "listUpdatedAt" | "listFetching" | "prefsFetching">>) {
  Object.assign(query, patch);
  query.version += 1;
  for (const l of query.listeners) l();
}
function useQueryVersion() {
  return useSyncExternalStore(
    (l) => {
      query.listeners.add(l);
      return () => query.listeners.delete(l);
    },
    () => query.version,
  );
}

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    // Mirrors the backend `kind` filter so a kind-filtered home query would
    // drop the industry rows and fail the industry tests.
    useListBusinessesSuspense: (opts?: { params?: { kind?: string } }) => {
      useQueryVersion();
      const kind = opts?.params?.kind;
      return {
        data: kind
          ? businessesData.filter(
              (b) => ((b as { kind?: string }).kind ?? "business") === kind,
            )
          : businessesData,
        dataUpdatedAt: query.listUpdatedAt,
        isFetching: query.listFetching,
      };
    },
    useListIndustriesSuspense: listIndustriesSuspense,
    // ResumeSection reads visit times via the non-suspense preferences hook and
    // unwraps the envelope with a `select`, so the resolved `data` is the array.
    // `undefined` models a failed or pending fetch.
    useGetUserPreferences: () => {
      useQueryVersion();
      return { data: userPrefsData, isFetching: query.prefsFetching };
    },
    deleteUserPreference: deleteUserPreferenceMock,
    // The optional taxonomy card is covered in entry-points-taxonomy.test.tsx.
    useGetTaxonomyConfig: () => ({ data: undefined }),
  };
});

vi.mock("@/components/import/import-new-business-dialog", () => ({
  ImportNewBusinessDialog: ({ trigger }: { trigger: ReactNode }) => <>{trigger}</>,
}));

import { HomePage } from "@/routes/_sidebar/index";
import { useStrictConsole } from "./helpers/strict-console";

function makeClient() {
  return new QueryClient({
    defaultOptions: { queries: { retry: false }, mutations: { retry: false } },
  });
}

function withRouter(ui: ReactNode, client: QueryClient = makeClient()) {
  const rootRoute = createRootRoute({ component: () => <Outlet /> });
  const mk = (path: string) =>
    createRoute({
      getParentRoute: () => rootRoute,
      path,
      component: () => <div data-testid={`stub-${path}`} />,
    });
  const subject = createRoute({
    getParentRoute: () => rootRoute,
    path: "/",
    component: () => <>{ui}</>,
  });
  const router = createRouter({
    routeTree: rootRoute.addChildren([
      subject,
      mk("/help/$topic"),
      mk("/businesses/$businessId"),
      mk("/businesses/$businessId/model/$version/$scope"),
      mk("/businesses/$businessId/model/$version/$scope/$domainName"),
      mk("/businesses/new"),
      mk("/industries"),
    ]),
    history: createMemoryHistory({ initialEntries: ["/"] }),
  });
  return (
    <QueryClientProvider client={client}>
      <RouterProvider router={router} />
    </QueryClientProvider>
  );
}

beforeEach(() => {
  businessesData = [];
  userPrefsData = [];
  listIndustriesSuspense.mockReset();
  deleteUserPreferenceMock.mockReset();
  deleteUserPreferenceMock.mockResolvedValue({ data: { deleted: true } });
  query.listUpdatedAt = Date.now();
  query.listFetching = false;
  query.prefsFetching = false;
});

describe("Home page", () => {
  const dom = useStrictConsole();

  it("always shows the orientation strip and a link into help", async () => {
    render(withRouter(<HomePage />));
    expect(
      await screen.findByText(/You build your data model through iterations/i),
    ).toBeInTheDocument();
    expect(
      screen.getByRole("link", { name: /Learn how it works/i }),
    ).toBeInTheDocument();
    // Strip stage labels present.
    expect(screen.getByText("Start your model")).toBeInTheDocument();
    expect(dom.messages).toEqual([]);
  });

  it("resumes a returning user with their recent work, newest first", async () => {
    businessesData = [
      {
        id: "biz-1",
        name: "Retail Bank",
        kind: "business",
        created_at: "2026-09-15T10:00:00Z",
        model_count: 3,
      },
      {
        id: "biz-2",
        name: "Vesta Markets",
        kind: "business",
        created_at: "2026-09-10T10:00:00Z",
        model_count: 6,
      },
    ];
    render(withRouter(<HomePage />));
    expect(await screen.findByText("Jump back in")).toBeInTheDocument();
    expect(screen.getByText("Retail Bank")).toBeInTheDocument();
    expect(screen.getByText("Vesta Markets")).toBeInTheDocument();
    expect(screen.getByText(/3 model versions/i)).toBeInTheDocument();
    expect(dom.messages).toEqual([]);
  });

  it("orders a recently visited business ahead of a more recently created one", async () => {
    // biz-1 was created after biz-2, so creation-order would rank it first.
    businessesData = [
      {
        id: "biz-1",
        name: "Retail Bank",
        kind: "business",
        created_at: "2026-09-15T10:00:00Z",
        model_count: 3,
      },
      {
        id: "biz-2",
        name: "Vesta Markets",
        kind: "business",
        created_at: "2026-09-10T10:00:00Z",
        model_count: 6,
      },
    ];
    // A visit to biz-2, newer than biz-1's creation time, must float it to top.
    userPrefsData = [
      { key: "visit:business:biz-2", value: "1", updated_at: "2026-09-20T10:00:00Z" },
    ];
    render(withRouter(<HomePage />));
    await screen.findByText("Jump back in");
    const titles = screen
      .getAllByText(/^(Retail Bank|Vesta Markets)$/)
      .map((el) => el.textContent);
    expect(titles).toEqual(["Vesta Markets", "Retail Bank"]);
    expect(dom.messages).toEqual([]);
  });

  it("lists an industry from the businesses list with its badge, template subtitle and business link", async () => {
    businessesData = [
      {
        id: "ind-1",
        name: "Retail Banking",
        kind: "industry",
        created_at: "2026-09-12T10:00:00Z",
        model_count: 2,
      },
      {
        id: "biz-1",
        name: "Vesta Markets",
        kind: "business",
        created_at: "2026-09-10T10:00:00Z",
        model_count: 6,
      },
    ];
    render(withRouter(<HomePage />));
    await screen.findByText("Jump back in");
    expect(screen.getByText("Industry")).toBeInTheDocument();
    expect(screen.getByText("template")).toBeInTheDocument();
    const link = screen.getByRole("link", { name: /Retail Banking/ });
    expect(link).toHaveAttribute("href", "/businesses/ind-1");
    expect(listIndustriesSuspense).not.toHaveBeenCalled();
    expect(dom.messages).toEqual([]);
  });

  it("ranks a visited industry ahead of a newer business that was never visited", async () => {
    businessesData = [
      {
        id: "biz-1",
        name: "Retail Bank",
        kind: "business",
        created_at: "2026-09-15T10:00:00Z",
        model_count: 3,
      },
      {
        id: "ind-1",
        name: "Retail Banking",
        kind: "industry",
        created_at: "2026-09-01T10:00:00Z",
        model_count: 2,
      },
    ];
    userPrefsData = [
      { key: "visit:business:ind-1", value: "1", updated_at: "2026-09-20T10:00:00Z" },
    ];
    render(withRouter(<HomePage />));
    await screen.findByText("Jump back in");
    const titles = screen
      .getAllByText(/^(Retail Bank|Retail Banking)$/)
      .map((el) => el.textContent);
    expect(titles).toEqual(["Retail Banking", "Retail Bank"]);
    expect(dom.messages).toEqual([]);
  });

  describe("model version entries", () => {
    const retailBank = {
      id: "biz-1",
      name: "Retail Bank",
      kind: "business",
      created_at: "2026-09-01T10:00:00Z",
      model_count: 3,
      downloaded_scopes: ["ecm", "mvm"],
    };

    it("links a version visit without a remembered domain to the version overview", async () => {
      businessesData = [retailBank];
      userPrefsData = [
        {
          key: "visit:version:biz-1:3:mvm",
          value: "{}",
          updated_at: "2026-09-20T10:00:00Z",
        },
      ];
      render(withRouter(<HomePage />));
      await screen.findByText("Jump back in");
      expect(screen.getByText("Model version")).toBeInTheDocument();
      expect(screen.getByText("v3 MVM")).toBeInTheDocument();
      const link = screen.getByRole("link", { name: /Model version/ });
      expect(link).toHaveAttribute("href", "/businesses/biz-1/model/3/mvm?tab=overview");
      expect(dom.messages).toEqual([]);
    });

    it("links a version visit with a remembered domain to the domain products tab", async () => {
      businessesData = [retailBank];
      userPrefsData = [
        {
          key: "visit:version:biz-1:3:mvm",
          value: '{"domain":"Sales & Marketing"}',
          updated_at: "2026-09-20T10:00:00Z",
        },
      ];
      render(withRouter(<HomePage />));
      await screen.findByText("Jump back in");
      expect(screen.getByText("v3 MVM \u00b7 Sales & Marketing")).toBeInTheDocument();
      const href = screen.getByRole("link", { name: /Model version/ }).getAttribute("href")!;
      const url = new URL(href, "http://localhost");
      expect(decodeURIComponent(url.pathname)).toBe("/businesses/biz-1/model/3/mvm/Sales & Marketing");
      expect(url.searchParams.get("tab")).toBe("products");
      expect(dom.messages).toEqual([]);
    });

    it("lists the version next to its business, newest visit first, and skips unvisited and stale versions", async () => {
      businessesData = [retailBank];
      userPrefsData = [
        { key: "visit:business:biz-1", value: "1", updated_at: "2026-09-10T10:00:00Z" },
        { key: "visit:version:biz-1:3:mvm", value: "{}", updated_at: "2026-09-20T10:00:00Z" },
        { key: "visit:version:gone:1:mvm", value: "{}", updated_at: "2026-09-21T10:00:00Z" },
        { key: "visit:version:biz-1:2:xyz", value: "{}", updated_at: "2026-09-22T10:00:00Z" },
      ];
      render(withRouter(<HomePage />));
      await screen.findByText("Jump back in");
      const links = screen.getAllByRole("link", { name: /Retail Bank/ });
      expect(links.map((l) => l.getAttribute("href"))).toEqual([
        "/businesses/biz-1/model/3/mvm?tab=overview",
        "/businesses/biz-1",
      ]);
      expect(dom.messages).toEqual([]);
    });
  });

  describe("visit prune on load", () => {
    const OLD = "2026-01-01T10:00:00Z";
    const retailBank = {
      id: "biz-1",
      name: "Retail Bank",
      kind: "business",
      created_at: "2026-09-01T10:00:00Z",
      model_count: 3,
      downloaded_scopes: ["mvm"],
    };
    const staleRows = () => [
      { key: "visit:business:gone", value: "1", updated_at: OLD },
      { key: "visit:version:biz-1:2:ecm", value: "{}", updated_at: OLD },
      { key: "visit:business:biz-1", value: "1", updated_at: OLD },
      { key: "diagram.default_column_mode", value: "hide", updated_at: OLD },
    ];
    const staleKeys = ["visit:business:gone", "visit:version:biz-1:2:ecm"];

    function mountStrict(client = makeClient()) {
      return render(
        <StrictMode>{withRouter(<HomePage />, client)}</StrictMode>,
      );
    }

    it("deletes stale visit rows once per mount under StrictMode, then refreshes preferences once", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      const client = makeClient();
      const invalidate = vi.spyOn(client, "invalidateQueries");
      mountStrict(client);
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2));
      expect(deleteUserPreferenceMock.mock.calls.map((c) => c[0])).toEqual(
        staleKeys.map((key) => ({ key })),
      );
      await waitFor(() => expect(invalidate).toHaveBeenCalledTimes(1));
      expect(invalidate).toHaveBeenCalledWith({ queryKey: getUserPreferencesKey() });
      expect(dom.messages).toEqual([]);
    });

    it("does not prune again on re-render or after the preferences refetch it causes", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      mountStrict();
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2));

      act(() => {
        setQuery({ listUpdatedAt: query.listUpdatedAt + 1 });
      });
      userPrefsData = [
        { key: "visit:business:another-gone", value: "1", updated_at: OLD },
        ...staleRows(),
      ];
      act(() => {
        setQuery({ listFetching: true });
      });
      act(() => {
        setQuery({ listFetching: false });
      });
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2);
    });

    it("waits for the business list to finish fetching", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      query.listFetching = true;
      mountStrict();
      await screen.findByText("Jump back in");
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).not.toHaveBeenCalled();
      act(() => {
        setQuery({ listFetching: false, listUpdatedAt: Date.now() });
      });
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2));
    });

    it("waits for a preferences refetch to finish before pruning", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      query.prefsFetching = true;
      mountStrict();
      await screen.findByText("Jump back in");
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).not.toHaveBeenCalled();
      act(() => {
        setQuery({ prefsFetching: false });
      });
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2));
    });

    it("still renders and prunes nothing when preferences failed to load", async () => {
      businessesData = [retailBank];
      userPrefsData = undefined;
      mountStrict();
      expect(await screen.findByText("Retail Bank")).toBeInTheDocument();
      expect(screen.getByText("Browse industries")).toBeInTheDocument();
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).not.toHaveBeenCalled();
      expect(dom.messages).toEqual([]);
    });

    it("prunes nothing and skips the refresh when no row is stale", async () => {
      businessesData = [retailBank];
      userPrefsData = [{ key: "visit:business:biz-1", value: "1", updated_at: OLD }];
      const client = makeClient();
      const invalidate = vi.spyOn(client, "invalidateQueries");
      mountStrict(client);
      await screen.findByText("Jump back in");
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).not.toHaveBeenCalled();
      expect(invalidate).not.toHaveBeenCalled();
    });

    it("leaves recent rows inside the grace window alone", async () => {
      businessesData = [retailBank];
      userPrefsData = [
        {
          key: "visit:business:just-created",
          value: "1",
          updated_at: new Date(query.listUpdatedAt - 60_000).toISOString(),
        },
      ];
      mountStrict();
      await screen.findByText("Jump back in");
      await new Promise((r) => setTimeout(r, 20));
      expect(deleteUserPreferenceMock).not.toHaveBeenCalled();
    });

    it("swallows failed deletes and does not refresh preferences when none succeeded", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      deleteUserPreferenceMock.mockRejectedValue(new Error("boom"));
      const client = makeClient();
      const invalidate = vi.spyOn(client, "invalidateQueries");
      mountStrict(client);
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(2));
      await new Promise((r) => setTimeout(r, 20));
      expect(invalidate).not.toHaveBeenCalled();
      expect(screen.getByText("Retail Bank")).toBeInTheDocument();
    });

    it("refreshes preferences when only some deletes succeeded", async () => {
      businessesData = [retailBank];
      userPrefsData = staleRows();
      deleteUserPreferenceMock
        .mockRejectedValueOnce(new Error("boom"))
        .mockResolvedValueOnce({ data: { deleted: true } });
      const client = makeClient();
      const invalidate = vi.spyOn(client, "invalidateQueries");
      mountStrict(client);
      await waitFor(() => expect(invalidate).toHaveBeenCalledTimes(1));
    });

    it("deletes at most 4 rows at a time and at most 20 per load", async () => {
      businessesData = [retailBank];
      userPrefsData = Array.from({ length: 30 }, (_, i) => ({
        key: `visit:business:gone${i}`,
        value: "1",
        updated_at: OLD,
      }));
      let inFlight = 0;
      let peak = 0;
      deleteUserPreferenceMock.mockImplementation(async () => {
        inFlight += 1;
        peak = Math.max(peak, inFlight);
        await new Promise((r) => setTimeout(r, 5));
        inFlight -= 1;
        return { data: { deleted: true } };
      });
      mountStrict();
      await waitFor(() => expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(20));
      await waitFor(() => expect(inFlight).toBe(0));
      expect(peak).toBe(PRUNE_CONCURRENCY);
      expect(deleteUserPreferenceMock).toHaveBeenCalledTimes(20);
    });
  });

  it("hides Jump back in when there is no history, but keeps the entry points", async () => {
    render(withRouter(<HomePage />));
    // "Start something new" + entry points always render, so a newcomer can
    // start from the home page; the recency list does not.
    expect(await screen.findByText("Browse industries")).toBeInTheDocument();
    expect(screen.getByText("Import a model")).toBeInTheDocument();
    expect(screen.queryByText("Jump back in")).not.toBeInTheDocument();
    expect(dom.messages).toEqual([]);
  });
});
