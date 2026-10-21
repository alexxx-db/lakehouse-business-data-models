/**
 * Settings → Platform "Domain Taxonomy Builder" card: hidden unless installed;
 * model-service picker with free-text fallback; concurrency 1-16; Test; the
 * last_check line (green ok, amber busy, red refusals); Save shows a refusal
 * inline; "Reset to install default" vs "Clear".
 */
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

import { TaxonomyBuilderCard } from "@/components/settings/taxonomy-builder-card";

type Route = { status: number; body: unknown };
type Call = { method: string; url: string; body: unknown };

const BASE = {
  installed: true, ready: true, model_service: "main.ai.drafter", install_default_model_service: "",
  max_concurrency: 6, last_check: null as unknown,
};

let routes: Record<string, Route | ((call: Call) => Route)>;
let calls: Call[];

function stubFetch() {
  vi.stubGlobal("fetch", vi.fn(async (url: string, init?: RequestInit) => {
    const method = init?.method ?? "GET";
    const call = { method, url, body: init?.body ? JSON.parse(String(init.body)) : undefined };
    calls.push(call);
    const key = `${method} ${url.split("?")[0]}`;
    const r = routes[key];
    if (!r) return new Response(JSON.stringify({ detail: `no stub for ${key}` }), { status: 500 });
    const { status, body } = typeof r === "function" ? r(call) : r;
    return new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } });
  }));
}

function renderCard() {
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false }, mutations: { retry: false } } });
  render(
    <QueryClientProvider client={qc}>
      <TaxonomyBuilderCard />
    </QueryClientProvider>,
  );
}

const check = (status: string, message: string) => ({ status, message, checked_at: "2026-10-19T10:00:00Z" });

beforeEach(() => {
  calls = [];
  routes = {
    "GET /api/config/taxonomy": { status: 200, body: BASE },
    "GET /api/config/taxonomy/model-services": { status: 200, body: { services: [], message: null } },
  };
  stubFetch();
});

afterEach(() => {
  vi.unstubAllGlobals();
});

const findCard = () => screen.findByTestId("taxonomy-builder-card");

describe("TaxonomyBuilderCard", () => {
  it("renders nothing when the feature is not installed", async () => {
    routes["GET /api/config/taxonomy"] = { status: 200, body: { ...BASE, installed: false, ready: false } };
    renderCard();
    await waitFor(() => expect(calls.some((c) => c.url === "/api/config/taxonomy")).toBe(true));
    expect(screen.queryByTestId("taxonomy-builder-card")).toBeNull();
    expect(calls.some((c) => c.url.includes("model-services"))).toBe(false);
  });

  it("renders nothing when the config read fails", async () => {
    routes["GET /api/config/taxonomy"] = { status: 500, body: { detail: "down" } };
    renderCard();
    await waitFor(() => expect(calls.length).toBeGreaterThan(0));
    expect(screen.queryByTestId("taxonomy-builder-card")).toBeNull();
  });

  it("offers the listed services in a picker", async () => {
    routes["GET /api/config/taxonomy/model-services"] = {
      status: 200, body: { services: ["main.ai.drafter", "system.ai.claude-sonnet-5-5"], message: null },
    };
    renderCard();
    await findCard();
    const trigger = await screen.findByRole("combobox", { name: "Model service" });
    expect(trigger.textContent).toContain("main.ai.drafter");
  });

  it("falls back to free text when the list is empty, and saves the typed name with concurrency", async () => {
    routes["PUT /api/config/taxonomy"] = ({ body }) => ({
      status: 200,
      body: { ...BASE, ...(body as object), last_check: check("ok", "'x' answered the test call.") },
    });
    renderCard();
    await findCard();
    const input = await screen.findByTestId("taxonomy-model-service-fallback-input");
    fireEvent.change(input, { target: { value: "other.ai.svc" } });
    fireEvent.change(screen.getByLabelText(/concurrent model calls/i), { target: { value: "3" } });
    fireEvent.click(screen.getByRole("button", { name: /^save$/i }));
    await waitFor(() => expect(screen.getByText("Saved")).toBeTruthy());
    expect(calls.find((c) => c.method === "PUT")?.body).toEqual({ model_service: "other.ai.svc", max_concurrency: 3 });
    const line = screen.getByTestId("taxonomy-last-check");
    expect(line.getAttribute("data-tone")).toBe("ok");
  });

  it("shows a refused save inline (400 detail.message)", async () => {
    routes["PUT /api/config/taxonomy"] = {
      status: 400,
      body: { detail: { error: "model_service_refused", status: "denied", message: "The app's service principal may not use it." } },
    };
    renderCard();
    await findCard();
    fireEvent.change(await screen.findByTestId("taxonomy-model-service-fallback-input"), { target: { value: "x.y.z" } });
    fireEvent.click(screen.getByRole("button", { name: /^save$/i }));
    expect((await screen.findByTestId("taxonomy-save-error")).textContent).toMatch(/may not use it/);
  });

  it("disables Save for concurrency outside 1-16", async () => {
    renderCard();
    await findCard();
    fireEvent.change(await screen.findByTestId("taxonomy-model-service-fallback-input"), { target: { value: "x.y.z" } });
    fireEvent.change(screen.getByLabelText(/concurrent model calls/i), { target: { value: "17" } });
    expect((screen.getByRole("button", { name: /^save$/i }) as HTMLButtonElement).disabled).toBe(true);
    expect(screen.getByText(/Between 1 and 16/)).toBeTruthy();
  });

  it.each([
    ["ok", "ok", /Working/],
    ["busy", "warn", /Busy/],
    ["denied", "error", /Access denied/],
    ["not_found", "error", /Not found/],
    ["error", "error", /Test call failed/],
  ])("last_check %s renders with tone %s", async (status, tone, label) => {
    routes["GET /api/config/taxonomy"] = { status: 200, body: { ...BASE, last_check: check(status, "detail text") } };
    renderCard();
    const line = await screen.findByTestId("taxonomy-last-check");
    expect(line.getAttribute("data-tone")).toBe(tone);
    expect(line.textContent).toMatch(label);
    expect(line.textContent).toContain("detail text");
  });

  it("Test calls the test endpoint and shows the refreshed result", async () => {
    let tested = false;
    routes["POST /api/config/taxonomy/test"] = () => {
      tested = true;
      return { status: 200, body: check("denied", "no access") };
    };
    routes["GET /api/config/taxonomy"] = () => ({
      status: 200, body: { ...BASE, last_check: tested ? check("denied", "no access") : null },
    });
    renderCard();
    await findCard();
    fireEvent.click(screen.getByRole("button", { name: /^test$/i }));
    const line = await screen.findByTestId("taxonomy-last-check");
    expect(line.getAttribute("data-tone")).toBe("error");
    expect(line.textContent).toContain("no access");
  });

  it("with an install default offers Reset (writes it at once) and no Clear", async () => {
    routes["GET /api/config/taxonomy"] = {
      status: 200, body: { ...BASE, install_default_model_service: "system.ai.claude-sonnet-5-5" },
    };
    routes["PUT /api/config/taxonomy"] = ({ body }) => ({ status: 200, body: { ...BASE, ...(body as object) } });
    renderCard();
    await findCard();
    expect(screen.queryByRole("button", { name: /clear/i })).toBeNull();
    fireEvent.click(screen.getByRole("button", { name: /reset to install default/i }));
    await waitFor(() => expect(calls.some((c) => c.method === "PUT")).toBe(true));
    expect(calls.find((c) => c.method === "PUT")?.body).toEqual({
      model_service: "system.ai.claude-sonnet-5-5", max_concurrency: 6,
    });
  });

  it("without an install default offers Clear (saves empty) and no Reset", async () => {
    routes["PUT /api/config/taxonomy"] = ({ body }) => ({ status: 200, body: { ...BASE, ...(body as object), ready: false } });
    renderCard();
    await findCard();
    expect(screen.queryByRole("button", { name: /reset to install default/i })).toBeNull();
    fireEvent.click(screen.getByRole("button", { name: /clear/i }));
    await waitFor(() => expect(calls.some((c) => c.method === "PUT")).toBe(true));
    expect(calls.find((c) => c.method === "PUT")?.body).toEqual({ model_service: "", max_concurrency: 6 });
  });

  it("labels Test 'Test saved service' while the form has unsaved changes", async () => {
    renderCard();
    await findCard();
    expect(screen.getByRole("button", { name: /^test$/i })).toBeTruthy();
    fireEvent.change(await screen.findByTestId("taxonomy-model-service-fallback-input"), { target: { value: "x.y.z" } });
    expect(screen.getByRole("button", { name: /^test saved service$/i })).toBeTruthy();
  });
});
