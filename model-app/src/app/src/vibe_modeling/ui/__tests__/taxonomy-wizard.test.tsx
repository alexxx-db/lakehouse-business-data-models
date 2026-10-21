import { describe, it, expect, vi, beforeEach } from "vitest";
import { render, screen, fireEvent, waitFor, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { createMemoryHistory, createRootRoute, createRoute, createRouter, Outlet, RouterProvider } from "@tanstack/react-router";

const m = vi.hoisted(() => ({
  createTaxonomyDraft: vi.fn(),
  getTaxonomyExample: vi.fn(),
  retryTaxonomyDraftPart: vi.fn(),
  cancelTaxonomyDraft: vi.fn(),
  compileTaxonomy: vi.fn(),
  hook: { current: { draft: undefined, error: null, lost: false } as any },
  config: { current: {} as any },
  role: { current: undefined as string | undefined },
}));
vi.mock("@/lib/api", async (orig) => ({
  ...(await orig<any>()),
  createTaxonomyDraft: m.createTaxonomyDraft, getTaxonomyExample: m.getTaxonomyExample,
  retryTaxonomyDraftPart: m.retryTaxonomyDraftPart, cancelTaxonomyDraft: m.cancelTaxonomyDraft,
  compileTaxonomy: m.compileTaxonomy,
  useGetTaxonomyConfig: () => m.config.current,
}));
vi.mock("@/lib/hooks", async (orig) => ({ ...(await orig<any>()), useUserRole: () => m.role.current }));
vi.mock("@/lib/taxonomy/use-taxonomy-draft", async (orig) => ({
  ...(await orig<any>()),
  useTaxonomyDraft: (id: string | null) => (id ? m.hook.current : { draft: undefined, error: null, lost: false }),
}));
vi.mock("@/components/business/sector-select", () => ({ SectorSelect: () => <div /> }));
vi.mock("@/components/taxonomy/review-step", () => ({ ReviewStep: () => <div data-testid="review-step" /> }));

const SECTIONS = ["company", "channels", "processes", "terminology", "systems_of_record", "regulatory"];
const TREE = {
  domains: [{ name: "Customer & Premise", schema_name: "", subdomains: [{ name: "Customer Master", categories: ["Customer"] }] }],
  shared_masters: [], relationships: [], division_names: [], coverage: "Operations, Business and Corporate",
};
const EXAMPLE_TREE = { ...TREE, domains: [{ ...TREE.domains[0], name: "Ridgeline Domain" }] };
const EXAMPLE_SECTIONS = { company: { claims: [{ text: "Ridgeline is a utility.", provenance: "user" }] } };
const COMPILED = { clamp: "", business_vibes: "", business_domains: "customer", csv: "", issues: [] };
const running = { draft_id: "d1", status: "running", parts: { tree: { status: "running" }, ...Object.fromEntries(SECTIONS.map((k) => [k, { status: "pending" }])) } };
const treeDone = { ...running, parts: { ...running.parts, tree: { status: "done", tree: TREE } } };

const READY = {
  installed: true, ready: true, model_service: "main.ai.drafter", install_default_model_service: "",
  max_concurrency: 6, last_check: null,
};
const configResult = (data: any) => ({ data: { data }, error: null, isLoading: false });

beforeEach(() => {
  m.config.current = configResult(READY);
  m.role.current = undefined;
});

async function renderGate() {
  const { Route } = await import("@/routes/_sidebar/businesses.new_.from-domains");
  const root = createRootRoute({ component: () => <Outlet /> });
  const wiz = createRoute({ getParentRoute: () => root, path: "/businesses/new/from-domains", component: Route.options.component as any });
  const home = createRoute({ getParentRoute: () => root, path: "/", component: () => <div /> });
  const settings = createRoute({ getParentRoute: () => root, path: "/settings", component: () => <div /> });
  const router = createRouter({
    routeTree: root.addChildren([wiz, home, settings]),
    history: createMemoryHistory({ initialEntries: ["/businesses/new/from-domains"] }),
  });
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  render(<QueryClientProvider client={qc}><RouterProvider router={router as any} /></QueryClientProvider>);
  await screen.findByText("Build from your domains");
}

describe("wizard gate", () => {
  it("not installed: explains it is enabled at install time and shows no wizard", async () => {
    m.config.current = configResult({ ...READY, installed: false, ready: false, model_service: "" });
    await renderGate();
    expect(screen.getByTestId("taxonomy-gate").textContent).toMatch(/doesn't include the Domain Taxonomy Builder/);
    expect(screen.queryByLabelText(/company name/i)).toBeNull();
  });

  it("installed without a model service: asks an admin to choose one; link only for admins", async () => {
    m.config.current = configResult({ ...READY, ready: false, model_service: "" });
    await renderGate();
    expect(screen.getByTestId("taxonomy-gate").textContent).toMatch(/An admin must choose a model service in Settings/);
    expect(screen.queryByRole("link", { name: /open settings/i })).toBeNull();
    expect(screen.queryByLabelText(/company name/i)).toBeNull();
  });

  it("refused last check, admin: shows the reason and the Settings link, never 'must choose'", async () => {
    m.role.current = "app_admin";
    m.config.current = configResult({
      ...READY, ready: false,
      last_check: { status: "denied", message: "The app's service principal may not use it.", checked_at: "2026-10-19T10:00:00Z" },
    });
    await renderGate();
    const gate = screen.getByTestId("taxonomy-gate");
    expect(gate.textContent).toMatch(/may not use it/);
    expect(gate.textContent).toMatch(/checked again automatically/);
    expect(gate.textContent).not.toMatch(/must choose a model service/);
    expect(screen.getByRole("link", { name: /open settings/i })).toBeTruthy();
  });

  it("refused last check, non-admin: unavailable and re-checked automatically, no reason, no link", async () => {
    m.config.current = configResult({
      ...READY, ready: false,
      last_check: { status: "denied", message: "The app's service principal may not use it.", checked_at: "2026-10-19T10:00:00Z" },
    });
    await renderGate();
    const gate = screen.getByTestId("taxonomy-gate");
    expect(gate.textContent).toBe(
      "The Domain Taxonomy Builder is unavailable right now. It is checked again automatically.",
    );
    expect(screen.queryByRole("link", { name: /open settings/i })).toBeNull();
  });

  it("no model service, admin: asks to choose one and links to Settings", async () => {
    m.role.current = "app_admin";
    m.config.current = configResult({ ...READY, ready: false, model_service: "" });
    await renderGate();
    expect(screen.getByTestId("taxonomy-gate").textContent).toMatch(/An admin must choose a model service/);
    expect(screen.getByRole("link", { name: /open settings/i })).toBeTruthy();
  });

  it("config read failed: shows the error and no wizard", async () => {
    m.config.current = { data: undefined, error: new Error("network down"), isLoading: false };
    await renderGate();
    expect(screen.getByTestId("taxonomy-gate").textContent).toMatch(/network down/);
    expect(screen.queryByLabelText(/company name/i)).toBeNull();
  });

  it("ready: renders the wizard, and keeps it when ready later flips off", async () => {
    await renderGate();
    expect(await screen.findByLabelText(/company name/i)).toBeTruthy();
    m.config.current = configResult({ ...READY, ready: false });
    fireEvent.change(screen.getByLabelText(/company name/i), { target: { value: "Acme" } });
    expect(screen.getByLabelText(/company name/i)).toBeTruthy();
    expect(screen.queryByTestId("taxonomy-gate")).toBeNull();
  });
});

async function renderWizard() {
  const { Route } = await import("@/routes/_sidebar/businesses.new_.from-domains");
  const root = createRootRoute({ component: () => <Outlet /> });
  const wiz = createRoute({ getParentRoute: () => root, path: "/businesses/new/from-domains", component: Route.options.component as any });
  const home = createRoute({ getParentRoute: () => root, path: "/", component: () => <div /> });
  const router = createRouter({
    routeTree: root.addChildren([wiz, home]),
    history: createMemoryHistory({ initialEntries: ["/businesses/new/from-domains"] }),
  });
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  render(<QueryClientProvider client={qc}><RouterProvider router={router as any} /></QueryClientProvider>);
  await screen.findByText("Build from your domains");
  await waitFor(() => expect(m.getTaxonomyExample).toHaveBeenCalled());
  return qc;
}

function fillIntake() {
  fireEvent.change(screen.getByLabelText(/company name/i), { target: { value: "Acme" } });
  fireEvent.change(screen.getByLabelText(/^industry/i), { target: { value: "Utility" } });
}

async function draftToStep2(draft: any) {
  m.hook.current = { draft, error: null, lost: false };
  fillIntake();
  fireEvent.click(screen.getByRole("button", { name: /draft with claude/i }));
  await screen.findByTestId("domain-card-0");
}

beforeEach(() => {
  m.hook.current = { draft: undefined, error: null, lost: false };
  m.createTaxonomyDraft.mockReset().mockResolvedValue({ data: { draft_id: "d1" } });
  m.getTaxonomyExample.mockReset().mockResolvedValue({
    data: { company_name: "Ridgeline Energy", industry: "Utility", tree: EXAMPLE_TREE, sections: EXAMPLE_SECTIONS, description: "x" },
  });
  m.retryTaxonomyDraftPart.mockReset();
  m.cancelTaxonomyDraft.mockReset();
  m.compileTaxonomy.mockReset().mockResolvedValue({ data: COMPILED });
});

describe("Build from your domains wizard", () => {
  it("drafts and shows the progress checklist while running", async () => {
    await renderWizard();
    m.hook.current = { draft: running, error: null, lost: false };
    fillIntake();
    fireEvent.click(screen.getByRole("button", { name: /draft with claude/i }));
    await waitFor(() => expect(m.createTaxonomyDraft).toHaveBeenCalledWith(expect.objectContaining({ company_name: "Acme", industry: "Utility" })));
    expect(await screen.findByText(/claude is drafting/i)).toBeTruthy();
  });

  it("renders the drafted tree in the editor and diagram", async () => {
    await renderWizard();
    await draftToStep2(treeDone);
    expect(screen.getAllByTestId("taxonomy-domain-column")).toHaveLength(1);
  });

  it("labels the org_divisions preset as business edit does, apart from the division names", async () => {
    await renderWizard();
    await draftToStep2(treeDone);
    const preset = screen.getByLabelText(/^Organization divisions/) as HTMLSelectElement;
    expect(preset.tagName).toBe("SELECT");
    expect(preset.value).toBe("Operations, Business and Corporate");
    expect((screen.getByLabelText(/^Division names/) as HTMLInputElement).tagName).toBe("INPUT");
    expect(screen.queryByText(/^Coverage/)).toBeNull();
  });

  it("shows compile issues inline on Step 2 (debounced compile of the sanitized tree)", async () => {
    m.compileTaxonomy.mockResolvedValue({
      data: { ...COMPILED, issues: [{ severity: "warning", message: "'customer' appears in billing, customer - make it a shared master with one home." }] },
    });
    await renderWizard();
    await draftToStep2(treeDone);
    expect(await screen.findByText(/make it a shared master/i)).toBeTruthy();
    expect(m.compileTaxonomy.mock.calls[0][0]).toMatchObject({ strictness: "strict", sections: {} });
  });

  it("attributes server issues to cards only once the debounced compile for this exact tree settles", async () => {
    const TWO = { ...TREE, domains: [TREE.domains[0], { name: "Billings", schema_name: "", subdomains: [] }] };
    const plural = { severity: "warning", message: "Domain 'Billings': 'billings' looks plural (DOM-RUL-004).", rule_id: "DOM-RUL-004", domains: [1] };
    m.compileTaxonomy.mockResolvedValue({ data: { ...COMPILED, issues: [plural] } });
    await renderWizard();
    await draftToStep2({ ...treeDone, parts: { ...treeDone.parts, tree: { status: "done", tree: TWO } } });
    const badge = () => within(screen.getByTestId("domain-card-1")).queryByTestId("domain-attention");
    await waitFor(() => expect(badge()?.getAttribute("data-severity")).toBe("warning"));
    expect(within(screen.getByTestId("domain-card-0")).queryByTestId("domain-attention")).toBeNull();

    // Editing: the compiled indices may be stale, so the badge drops out until the next compile lands.
    let land!: (v: any) => void;
    m.compileTaxonomy.mockImplementation(() => new Promise((r) => { land = r; }));
    fireEvent.change(screen.getByPlaceholderText("New domain"), { target: { value: "Safety" } });
    fireEvent.click(screen.getByRole("button", { name: "Add domain" }));
    expect(badge()).toBeNull();
    await waitFor(() => expect(m.compileTaxonomy.mock.calls.length).toBeGreaterThanOrEqual(2)); // debounced compile in flight
    expect(badge()).toBeNull();
    land({ data: { ...COMPILED, issues: [plural] } });
    await waitFor(() => expect(badge()).not.toBeNull());
  });

  it("hides server badges while a blank name blocks the compile", async () => {
    const TWO = { ...TREE, domains: [TREE.domains[0], { name: "Billings", schema_name: "", subdomains: [] }] };
    const plural = { severity: "warning", message: "looks plural", rule_id: "DOM-RUL-004", domains: [1] };
    m.compileTaxonomy.mockResolvedValue({ data: { ...COMPILED, issues: [plural] } });
    await renderWizard();
    await draftToStep2({ ...treeDone, parts: { ...treeDone.parts, tree: { status: "done", tree: TWO } } });
    await waitFor(() => expect(within(screen.getByTestId("domain-card-1")).queryByTestId("domain-attention")).not.toBeNull());
    fireEvent.click(screen.getByTestId("domain-card-0"));
    fireEvent.change(screen.getByLabelText("Domain name"), { target: { value: " " } });
    fireEvent.click(screen.getByRole("button", { name: "Done" }));
    expect(within(screen.getByTestId("domain-card-0")).getByTestId("domain-attention").getAttribute("data-severity")).toBe("error");
    await new Promise((r) => setTimeout(r, 500)); // past the debounce
    expect(within(screen.getByTestId("domain-card-1")).queryByTestId("domain-attention")).toBeNull();
  });

  it("edits the division names on Step 2", async () => {
    await renderWizard();
    await draftToStep2(treeDone);
    fireEvent.change(screen.getByLabelText(/^Division names/), { target: { value: "Retail, Wholesale" } });
    await waitFor(() =>
      expect(m.compileTaxonomy).toHaveBeenLastCalledWith(
        expect.objectContaining({ tree: expect.objectContaining({ division_names: ["Retail", "Wholesale"] }) }),
      ),
    );
    expect((screen.getByLabelText(/^Division names/) as HTMLInputElement).value).toBe("Retail, Wholesale");
  });

  it("gates Step 3 Continue on the systems-of-record confirm", async () => {
    await renderWizard();
    await draftToStep2(treeDone);
    fireEvent.click(screen.getByRole("button", { name: "Continue" }));
    const cont = await screen.findByRole("button", { name: "Continue" });
    expect((cont as HTMLButtonElement).disabled).toBe(true);
    fireEvent.click(screen.getByLabelText(/checked the systems of record/i));
    expect((screen.getByRole("button", { name: "Continue" }) as HTMLButtonElement).disabled).toBe(false);
  });

  it("Retry writes the returned draft into the query cache so polling resumes", async () => {
    const sectionDone = (k: string) => ({ status: "done", section: { claims: [{ text: `${k} text`, provenance: "industry" }] } });
    const failed = {
      ...treeDone, status: "failed",
      parts: { ...treeDone.parts, ...Object.fromEntries(SECTIONS.map((k) => [k, sectionDone(k)])), terminology: { status: "failed", error: "boom" } },
    };
    const rerun = { ...failed, status: "running", parts: { ...failed.parts, terminology: { status: "pending" } } };
    m.retryTaxonomyDraftPart.mockResolvedValueOnce({ data: rerun });
    const qc = await renderWizard();
    await draftToStep2(failed);
    fireEvent.click(screen.getByRole("button", { name: "Continue" }));
    fireEvent.click(await screen.findByRole("button", { name: /retry/i }));
    await waitFor(() => expect(m.retryTaxonomyDraftPart).toHaveBeenCalledWith({ draft_id: "d1", part: "terminology" }));
    await waitFor(() => expect(qc.getQueryData(["taxonomy-draft", "d1"])).toEqual(rerun));
  });

  it("Cancel writes the returned draft into the query cache", async () => {
    const cancelled = { ...running, status: "cancelled" };
    m.cancelTaxonomyDraft.mockResolvedValueOnce({ data: cancelled });
    const qc = await renderWizard();
    await draftToStep2(treeDone);
    fireEvent.click(screen.getByRole("button", { name: "Cancel drafting" }));
    await waitFor(() => expect(qc.getQueryData(["taxonomy-draft", "d1"])).toEqual(cancelled));
  });

  it("Start from the Ridgeline example loads the example tree AND sections without calling Claude", async () => {
    await renderWizard();
    fillIntake();
    fireEvent.click(screen.getByRole("button", { name: "Start from the Ridgeline example" }));
    expect((await screen.findByTestId("domain-card-0")).textContent).toContain("Ridgeline Domain");
    fireEvent.click(screen.getByRole("button", { name: "Continue" }));
    expect(await screen.findByDisplayValue("Ridgeline is a utility.")).toBeTruthy();
    expect(m.createTaxonomyDraft).not.toHaveBeenCalled();
  });

  it("Start blank opens an empty editor without calling Claude", async () => {
    await renderWizard();
    fillIntake();
    fireEvent.click(screen.getByRole("button", { name: "Start blank" }));
    expect(await screen.findByText(/add a domain to see the diagram/i)).toBeTruthy();
    expect(await screen.findByText("Add at least one domain.")).toBeTruthy(); // after the 400 ms debounce
    expect(m.createTaxonomyDraft).not.toHaveBeenCalled();
  });

  it("offers Draft again when the draft is lost", async () => {
    await renderWizard();
    m.hook.current = { draft: undefined, error: null, lost: true };
    fillIntake();
    fireEvent.click(screen.getByRole("button", { name: /draft with claude/i }));
    fireEvent.click(await screen.findByRole("button", { name: /draft again/i }));
    await waitFor(() => expect(m.createTaxonomyDraft).toHaveBeenCalledTimes(2));
    expect(m.createTaxonomyDraft.mock.calls[1][0]).toMatchObject({ company_name: "Acme" });
  });

  describe("Draft again after a lost draft", () => {
    const company = { claims: [{ text: "We run the grid.", provenance: "industry" }] };
    const allDone = {
      ...treeDone, status: "done",
      parts: { ...treeDone.parts, ...Object.fromEntries(SECTIONS.map((k) => [k, { status: "done", section: k === "company" ? company : { claims: [{ text: `${k} text`, provenance: "industry" }] } }])) },
    };
    const redrafted = { ...running, draft_id: "d2", status: "done", parts: {
      tree: { status: "done", tree: EXAMPLE_TREE },
      ...Object.fromEntries(SECTIONS.map((k) => [k, { status: "done", section: { claims: [{ text: `fresh ${k}`, provenance: "industry" }] } }])),
    } };

    it("keeps the edited tree and sections and stays on the step", async () => {
      await renderWizard();
      await draftToStep2(allDone);
      fireEvent.change(screen.getByPlaceholderText("New domain"), { target: { value: "Safety" } });
      fireEvent.click(screen.getByRole("button", { name: "Add domain" }));
      fireEvent.click(screen.getByRole("button", { name: "Continue" }));
      const notes = (await screen.findAllByLabelText(/your notes/i))[0] as HTMLTextAreaElement;
      fireEvent.change(notes, { target: { value: "We also sell water." } });

      m.hook.current = { draft: undefined, error: null, lost: true };
      fireEvent.change(notes, { target: { value: "We also sell water and gas." } }); // re-render with the lost poll
      m.createTaxonomyDraft.mockResolvedValueOnce({ data: { draft_id: "d2" } });
      fireEvent.click(await screen.findByRole("button", { name: /draft again/i }));
      await waitFor(() => expect(m.createTaxonomyDraft).toHaveBeenCalledTimes(2));
      m.hook.current = { draft: redrafted, error: null, lost: false };
      fireEvent.change(notes, { target: { value: "We also sell water and gas!" } });

      // Still on step 3 with the user's own sections; the redraft fills nothing they already have.
      expect(screen.getByTestId("section-card-company")).toBeTruthy();
      expect((screen.getAllByLabelText(/your notes/i)[0] as HTMLTextAreaElement).value).toBe("We also sell water and gas!");
      expect(screen.getByDisplayValue("We run the grid.")).toBeTruthy();
      expect(screen.queryByDisplayValue("fresh company")).toBeNull();
      fireEvent.click(screen.getByRole("button", { name: "Back" }));
      expect((await screen.findByTestId("domain-card-1")).textContent).toContain("Safety");
      expect(screen.getByTestId("domain-card-0").textContent).toContain("Customer & Premise");
    });

    it("the first Draft from the intake still starts fresh", async () => {
      await renderWizard();
      await draftToStep2(allDone);
      fireEvent.click(screen.getByRole("button", { name: "Back" }));
      m.hook.current = { draft: running, error: null, lost: false };
      fireEvent.click(await screen.findByRole("button", { name: /draft with claude/i }));
      expect(await screen.findByText(/waiting for the domain draft/i)).toBeTruthy();
      expect(screen.queryByTestId("domain-card-0")).toBeNull();
    });
  });

  describe("fallback after a non-done tree", () => {
    const treeWith = (status: string) => ({ ...running, status: "failed", parts: { ...Object.fromEntries(SECTIONS.map((k) => [k, { status, error: "boom" }])), tree: { status, error: "boom" } } });
    async function toStep1(status: string) {
      await renderWizard();
      m.hook.current = { draft: treeWith(status), error: null, lost: false };
      fillIntake();
      fireEvent.click(screen.getByRole("button", { name: /draft with claude/i }));
      await screen.findByRole("button", { name: "Start blank" });
    }

    it("cancelled tree shows the fallback plus Back; Back keeps the intake values", async () => {
      await toStep1("cancelled");
      expect(screen.getByRole("button", { name: "Retry domains" })).toBeTruthy();
      expect(screen.getByRole("button", { name: "Start from the Ridgeline example" })).toBeTruthy();
      fireEvent.click(screen.getByRole("button", { name: "Back" }));
      expect((await screen.findByLabelText(/company name/i) as HTMLInputElement).value).toBe("Acme");
      expect((screen.getByLabelText(/^industry/i) as HTMLInputElement).value).toBe("Utility");
    });

    it("timed-out tree shows the fallback", async () => {
      await toStep1("timed_out");
      expect(screen.getByRole("button", { name: "Retry domains" })).toBeTruthy();
    });

    it("busy tree counts down in place of the waiting line, with the other fallbacks", async () => {
      vi.spyOn(Math, "random").mockReturnValue(0.5);
      const busy = { ...running, status: "busy", parts: { ...Object.fromEntries(SECTIONS.map((k) => [k, { status: "busy", error: "waiting for the domains" }])), tree: { status: "busy", error: "The model is busy" } } };
      m.retryTaxonomyDraftPart.mockResolvedValue({ data: busy });
      await renderWizard();
      m.hook.current = { draft: busy, error: null, lost: false };
      fillIntake();
      fireEvent.click(screen.getByRole("button", { name: /draft with claude/i }));
      const countdown = await screen.findByTestId("tree-busy-countdown");
      // Only the tree counts down; one countdown on the page.
      expect(screen.getAllByTestId(/busy-countdown/)).toHaveLength(1);
      await waitFor(() => expect(countdown.textContent).toContain("The model is busy. Retrying in 00:15"));
      expect(screen.queryByText(/waiting for the domain draft/i)).toBeNull();
      expect(screen.getByRole("button", { name: "Start blank" })).toBeTruthy();
      expect(screen.getByRole("button", { name: "Start from the Ridgeline example" })).toBeTruthy();
      fireEvent.click(screen.getByRole("button", { name: "Retry domains" }));
      await waitFor(() => expect(m.retryTaxonomyDraftPart).toHaveBeenCalledWith({ draft_id: "d1", part: "tree" }));
      vi.restoreAllMocks();
    });

    it("Start blank after a failed tree: cards with no error banner and a usable Your notes box", async () => {
      await toStep1("failed");
      fireEvent.click(screen.getByRole("button", { name: "Start blank" }));
      fireEvent.change(await screen.findByPlaceholderText("New domain"), { target: { value: "Billing" } });
      fireEvent.click(screen.getByRole("button", { name: "Add domain" }));
      fireEvent.click(await screen.findByRole("button", { name: "Continue" }));
      expect(await screen.findByTestId("section-card-company")).toBeTruthy();
      expect(screen.queryByText(/didn't finish/i)).toBeNull();
      expect(screen.queryByRole("button", { name: /retry/i })).toBeNull();
      const notes = screen.getAllByLabelText(/your notes/i)[0] as HTMLTextAreaElement;
      fireEvent.change(notes, { target: { value: "We sell water." } });
      expect(notes.value).toBe("We sell water.");
    });

    it("Start from example after a failed tree: cards with no error or Retry", async () => {
      await toStep1("failed");
      fireEvent.click(screen.getByRole("button", { name: "Start from the Ridgeline example" }));
      await screen.findByTestId("domain-card-0");
      fireEvent.click(screen.getByRole("button", { name: "Continue" }));
      expect(await screen.findByDisplayValue("Ridgeline is a utility.")).toBeTruthy();
      expect(screen.queryByText(/didn't finish/i)).toBeNull();
      expect(screen.queryByRole("button", { name: /retry/i })).toBeNull();
    });
  });
});
