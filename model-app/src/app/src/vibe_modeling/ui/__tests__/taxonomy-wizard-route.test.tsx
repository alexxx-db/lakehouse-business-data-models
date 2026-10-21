/**
 * The wizard lives at /businesses/new/from-domains: it creates a new business,
 * so there is no business id in the path, and the "new" segment keeps the
 * sidebar layout from fetching `/api/businesses/<segment>` (the old
 * /businesses/from-domains URL logged two 404s). It is not nested in the
 * businesses.new layout.
 */
import { beforeAll, describe, expect, it, vi } from "vitest";
import { waitFor } from "@testing-library/react";

beforeAll(() => {
  if (!window.matchMedia) {
    Object.defineProperty(window, "matchMedia", {
      writable: true,
      value: (query: string) => ({
        matches: false, media: query, onchange: null,
        addListener: () => {}, removeListener: () => {},
        addEventListener: () => {}, removeEventListener: () => {}, dispatchEvent: () => false,
      }),
    });
  }
});

const m = vi.hoisted(() => ({ businessQueries: [] as { id: string; enabled: boolean }[] }));

vi.mock("@/components/explorer/business-tree", () => ({
  BusinessTree: () => <div data-testid="business-tree-stub" />,
}));
vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    useGetBusiness: (opts: { params: { business_id: string }; query?: { enabled?: boolean } }) => {
      m.businessQueries.push({ id: opts.params.business_id, enabled: opts.query?.enabled !== false });
      return { data: undefined };
    },
    useCurrentUserSuspense: () => ({ data: { user_name: "test-user", display_name: "Test User" } }),
  };
});

import { Layout } from "@/routes/_sidebar/route";
import routeTreeSource from "@/types/routeTree.gen.ts?raw";
import { renderWithRouter } from "./helpers/router-wrapper";

describe("Domain Taxonomy Builder route", () => {
  it("is /businesses/new/from-domains, outside the businesses.new layout", () => {
    // The generated tree registers the file as a sibling of businesses.new (id
    // "new_/...") with the full path the entry card links to.
    const entry = routeTreeSource.match(
      /'\/_sidebar\/businesses\/new_\/from-domains': \{[^}]*\}/,
    )?.[0];
    expect(entry).toContain("fullPath: '/businesses/new/from-domains'");
    expect(entry).toContain("parentRoute: typeof SidebarBusinessesRoute\n");
    expect(routeTreeSource).not.toContain("'/businesses/from-domains'");
  });

  it("the sidebar layout never fetches a business on the wizard URL", async () => {
    m.businessQueries = [];
    renderWithRouter(<Layout />, { initialPath: "/businesses/new/from-domains" });
    await waitFor(() => expect(m.businessQueries.length).toBeGreaterThan(0));
    expect(m.businessQueries.every((q) => !q.enabled)).toBe(true);
  });
});
