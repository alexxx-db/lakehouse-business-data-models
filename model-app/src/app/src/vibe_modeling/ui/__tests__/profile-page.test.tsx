/**
 * Profile page tests.
 *
 * The page renders the typed `/current-user` payload (`CurrentUserOut`:
 * `user_name`, `display_name`, `emails[].value`). The suspense hook is
 * stubbed via `vi.mock("@/lib/api")`, same pattern as
 * `sidebar-user-footer.test.tsx`.
 */
import { afterEach, describe, expect, it, vi } from "vitest";
import { screen } from "@testing-library/react";
import type { ComponentType } from "react";

const DEFAULT_USER = {
  user_name: "ada@example.com",
  display_name: "Ada Lovelace",
  emails: [{ value: "ada@example.com" }],
};

let userHook: () => unknown = () => ({ data: DEFAULT_USER });

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return {
    ...actual,
    useCurrentUserSuspense: () => userHook(),
  };
});

import { Route as ProfileRoute } from "@/routes/_sidebar/profile";
import { renderWithRouter } from "./helpers/router-wrapper";

const ProfilePage = ProfileRoute.options.component as ComponentType;

afterEach(() => {
  userHook = () => ({ data: DEFAULT_USER });
});

describe("Profile page", () => {
  it("renders display name, identity, initials and email", async () => {
    renderWithRouter(<ProfilePage />);
    expect(
      await screen.findByRole("heading", { name: "Ada Lovelace" }),
    ).toBeInTheDocument();
    expect(screen.getByText("AL")).toBeInTheDocument();
    // Identity line under the heading (no "@" prefix) + the contact email row.
    expect(screen.getAllByText("ada@example.com")).toHaveLength(2);
    expect(screen.queryByText(/^@/)).not.toBeInTheDocument();
  });

  it("shows the empty-email copy and no status badge for the anonymous fallback", async () => {
    userHook = () => ({
      data: { user_name: "anonymous", display_name: "Anonymous User", emails: [] },
    });
    renderWithRouter(<ProfilePage />);
    expect(
      await screen.findByRole("heading", { name: "Anonymous User" }),
    ).toBeInTheDocument();
    expect(screen.getByText("No email addresses available")).toBeInTheDocument();
    expect(screen.queryByText("Inactive")).not.toBeInTheDocument();
    expect(screen.queryByText("Active")).not.toBeInTheDocument();
  });
});
