/**
 * `SidebarUserFooter` tests.
 *
 * The footer wraps a `useCurrentUserSuspense` consumer in a `<Suspense>`
 * so the unauth/loading state shows a skeleton. We stub the suspense
 * hook directly via `vi.mock("@/lib/api")` (same pattern as
 * `model-version-page.test.tsx`) so the footer renders synchronously.
 *
 * The footer also depends on `<SidebarMenuButton>` which requires the
 * shadcn `<SidebarProvider>` context — tests mount inside one.
 */
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";

const DEFAULT_USER = {
  user_name: "ada@example.com",
  display_name: "Ada Lovelace",
  emails: [{ value: "ada@example.com" }],
};

let userHook: () => unknown = () => ({
  data: DEFAULT_USER,
});

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    useCurrentUserSuspense: () => userHook(),
  };
});

import SidebarUserFooter from "@/components/apx/sidebar-user-footer";
import { SidebarProvider } from "@/components/ui/sidebar";

// SidebarProvider's `useIsMobile` calls window.matchMedia which jsdom
// doesn't ship. Stub once for the suite.
beforeEach(() => {
  Object.defineProperty(window, "matchMedia", {
    configurable: true,
    writable: true,
    value: vi.fn((q: string) => ({
      matches: false,
      media: q,
      onchange: null,
      addListener: vi.fn(),
      removeListener: vi.fn(),
      addEventListener: vi.fn(),
      removeEventListener: vi.fn(),
      dispatchEvent: vi.fn(),
    })),
  });
});

afterEach(() => {
  userHook = () => ({
    data: DEFAULT_USER,
  });
  vi.restoreAllMocks();
});

function renderFooter() {
  return render(
    <SidebarProvider>
      <SidebarUserFooter />
    </SidebarProvider>,
  );
}

describe("SidebarUserFooter", () => {
  it("renders the user's display name and user_name", () => {
    renderFooter();
    expect(screen.getByText("Ada Lovelace")).toBeInTheDocument();
    expect(screen.getByText("ada@example.com")).toBeInTheDocument();
  });

  it("builds avatar initials from display_name", () => {
    renderFooter();
    expect(screen.getByText("AL")).toBeInTheDocument();
  });

  it("hides the second line when user_name equals display_name", () => {
    userHook = () => ({
      data: {
        user_name: "alice@example.com",
        display_name: "alice@example.com",
        emails: [{ value: "alice@example.com" }],
      },
    });
    renderFooter();
    expect(screen.getAllByText("alice@example.com")).toHaveLength(1);
  });

  it("uses the first two letters of a single-word display_name", () => {
    userHook = () => ({
      data: { user_name: "alice", display_name: "alice", emails: [] },
    });
    renderFooter();
    expect(screen.getByText("AL")).toBeInTheDocument();
  });
});
