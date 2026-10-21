/**
 * Settings save errors go through `apiErrorMessage`. The fetch-based ApiError
 * (lib/api.ts) has no `response`, so the old axios-style read fell back to
 * "HTTP 4xx: ..." or rendered a non-string `detail`. Checked on the metamodel
 * catalog card: a string detail, a Pydantic detail array, an object detail.
 */
import { afterEach, describe, expect, it, vi } from "vitest";
import { fireEvent, render, screen } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

import { MetamodelCatalogCard } from "@/routes/_sidebar/settings";

function stub(putStatus: number, putBody: unknown) {
  vi.stubGlobal("fetch", vi.fn(async (url: string, init?: RequestInit) => {
    const method = init?.method ?? "GET";
    const json = (status: number, body: unknown) =>
      new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } });
    if (url.startsWith("/api/config/metamodel-catalog")) {
      return method === "PUT" ? json(putStatus, putBody) : json(200, { metamodel_catalog: "", is_configured: false });
    }
    return json(200, {});
  }));
}

afterEach(() => vi.unstubAllGlobals());

async function saveCatalog() {
  render(
    <QueryClientProvider client={new QueryClient({ defaultOptions: { queries: { retry: false }, mutations: { retry: false } } })}>
      <MetamodelCatalogCard />
    </QueryClientProvider>,
  );
  fireEvent.change(await screen.findByLabelText("Metamodel catalog"), { target: { value: "my_catalog" } });
  fireEvent.click(screen.getByRole("button", { name: /save/i }));
}

describe("Settings save error text", () => {
  it.each([
    ["string detail", 403, { detail: "App admin access required" }, "App admin access required"],
    ["Pydantic detail", 422, { detail: [{ msg: "String should match pattern", loc: ["body"] }] }, "String should match pattern"],
    ["object detail", 400, { detail: { error: "x", message: "Catalog is locked" } }, "Catalog is locked"],
  ])("shows the backend's %s", async (_label, status, body, text) => {
    stub(status, body);
    await saveCatalog();
    expect(await screen.findByText(text)).toBeTruthy();
    expect(screen.queryByText(/^HTTP \d{3}/)).toBeNull();
  });
});
