import { useState } from "react";
import { describe, it, expect } from "vitest";
import { render, screen, fireEvent, within } from "@testing-library/react";
import { OutlineEditor } from "@/components/taxonomy/outline-editor";

const base = {
  domains: [
    { name: "Billing", schema_name: "", subdomains: [{ name: "Invoices", categories: ["Bill"] }, { name: "Payments", categories: [] }] },
    { name: "Assets", schema_name: "", subdomains: [{ name: "Meters", categories: ["Meter"] }] },
    { name: "Customer", schema_name: "", subdomains: [] },
  ],
  shared_masters: [], relationships: [], division_names: [], coverage: "Operations" as const,
};

const Harness = ({ initial = base, issues }: { initial?: any; issues?: any[] }) => {
  const [t, setT] = useState<any>(initial);
  return <OutlineEditor tree={t} onChange={setT} issues={issues} />;
};
const issue = (severity: "error" | "warning", message: string, domains: number[], rule_id = "") => ({ severity, message, domains, rule_id });
const dialog = () => screen.getByTestId("domain-dialog");

describe("Domain grid + edit dialog", () => {
  it("renders every domain as a card in the grid and no dialog by default", () => {
    render(<Harness />);
    expect(screen.getAllByTestId("taxonomy-domain-column")).toHaveLength(3);
    expect(screen.getByTestId("domain-card-1").getAttribute("role")).toBe("button");
    expect(screen.queryByTestId("domain-dialog")).toBeNull();
  });

  it("clicking a card opens the dialog for that domain; Enter/Space also open it", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-1"));
    expect(within(dialog()).getByText("Edit domain: Assets")).toBeTruthy();
    fireEvent.click(screen.getByRole("button", { name: "Done" }));
    expect(screen.queryByTestId("domain-dialog")).toBeNull();
    fireEvent.keyDown(screen.getByTestId("domain-card-2"), { key: "Enter" });
    expect(within(dialog()).getByText("Edit domain: Customer")).toBeTruthy();
    fireEvent.click(screen.getByRole("button", { name: "Done" }));
    fireEvent.keyDown(screen.getByTestId("domain-card-0"), { key: " " });
    expect(within(dialog()).getByText("Edit domain: Billing")).toBeTruthy();
  });

  it("editing a sub-domain name in the dialog updates the grid card live", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-0"));
    fireEvent.change(within(dialog()).getByLabelText("Sub-domain Invoices"), { target: { value: "Invoicing" } });
    expect(within(screen.getByTestId("domain-card-0")).getByText("Invoicing")).toBeTruthy();
  });

  it("keeps the dialog name input focused while typing", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-0"));
    const input = within(dialog()).getByLabelText("Domain name") as HTMLInputElement;
    input.focus();
    fireEvent.change(input, { target: { value: "Billing2" } });
    expect(within(dialog()).getByLabelText("Domain name")).toBe(input);
    expect(document.activeElement).toBe(input);
    expect(input.value).toBe("Billing2");
  });

  it("Prev / Next step through domains and are disabled at the ends", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-0"));
    expect((screen.getByRole("button", { name: "Previous domain" }) as HTMLButtonElement).disabled).toBe(true);
    fireEvent.click(screen.getByRole("button", { name: "Next domain" }));
    expect(within(dialog()).getByText("Edit domain: Assets")).toBeTruthy();
    fireEvent.click(screen.getByRole("button", { name: "Next domain" }));
    expect((screen.getByRole("button", { name: "Next domain" }) as HTMLButtonElement).disabled).toBe(true);
    fireEvent.click(screen.getByRole("button", { name: "Previous domain" }));
    expect(within(dialog()).getByText("Edit domain: Assets")).toBeTruthy();
  });

  it("deleting closes the dialog and removes the card", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-1"));
    fireEvent.click(within(dialog()).getByRole("button", { name: "Remove domain Assets" }));
    expect(screen.queryByTestId("domain-dialog")).toBeNull();
    expect(screen.getAllByTestId("taxonomy-domain-column")).toHaveLength(2);
    expect(screen.queryByText("Assets")).toBeNull();
  });

  it("moving the domain up/down makes the dialog follow it", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-1"));
    fireEvent.click(within(dialog()).getByRole("button", { name: "Move domain Assets up" }));
    expect(within(dialog()).getByText("Edit domain: Assets")).toBeTruthy();
    expect(within(screen.getByTestId("domain-card-0")).getByText("Assets")).toBeTruthy();
    expect((within(dialog()).getByRole("button", { name: "Move domain Assets up" }) as HTMLButtonElement).disabled).toBe(true);
  });

  it("moving a sub-domain to another domain shows up on the other card immediately", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-0"));
    fireEvent.change(within(dialog()).getByLabelText("Move sub-domain Payments to domain"), { target: { value: "2" } });
    expect(within(screen.getByTestId("domain-card-2")).getByText("Payments")).toBeTruthy();
    expect(within(screen.getByTestId("domain-card-0")).queryByText("Payments")).toBeNull();
  });

  it("shows a live preview of the domain in the dialog", () => {
    render(<Harness />);
    fireEvent.click(screen.getByTestId("domain-card-1"));
    expect(within(within(dialog()).getByTestId("domain-preview")).getByText("Meters")).toBeTruthy();
  });

  it("adds a domain from the button above the grid", () => {
    render(<Harness />);
    fireEvent.change(screen.getByPlaceholderText("New domain"), { target: { value: "Safety" } });
    fireEvent.click(screen.getByRole("button", { name: "Add domain" }));
    expect(screen.getAllByTestId("taxonomy-domain-column")).toHaveLength(4);
  });

  it("flags a blank name locally and a duplicate schema from the server's issue, and shows the error in the dialog", () => {
    const t = { ...base, domains: [
      { name: "  ", schema_name: "", subdomains: [] },
      { name: "A", schema_name: "dup", subdomains: [] },
      { name: "B", schema_name: "dup", subdomains: [] },
      { name: "OK", schema_name: "", subdomains: [] },
    ] };
    const dup = issue("error", "Domains 'A' and 'B' both map to schema 'dup' (DOM-RUL-016).", [1, 2], "DOM-RUL-016");
    render(<Harness initial={t} issues={[dup]} />);
    expect(within(screen.getByTestId("domain-card-0")).getByText(/needs attention/i)).toBeTruthy();
    expect(within(screen.getByTestId("domain-card-1")).getByText(/needs attention/i)).toBeTruthy();
    expect(within(screen.getByTestId("domain-card-2")).getByText(/needs attention/i)).toBeTruthy();
    expect(within(screen.getByTestId("domain-card-3")).queryByText(/needs attention/i)).toBeNull();
    fireEvent.click(screen.getByTestId("domain-card-0"));
    expect(within(dialog()).getByText(/needs a name/i)).toBeTruthy();
  });

  it("uses theme-aware accents (dark: variants) rather than inline pastels", () => {
    render(<Harness />);
    const card = screen.getAllByTestId("taxonomy-domain-column")[0];
    expect(card.className).toMatch(/dark:bg-/);
    expect(card.getAttribute("style") ?? "").not.toMatch(/background/);
  });

  it("a model-level issue (no domains) marks no card", () => {
    render(<Harness issues={[issue("error", "A taxonomy needs at least 3 domains (DOM-RUL-032); this one has 2.", [], "DOM-RUL-032")]} />);
    expect(screen.queryAllByTestId("domain-attention")).toHaveLength(0);
  });

  describe("naming rules (server issues)", () => {
    const sub = (n: string) => ({ name: n, categories: ["x"] });
    const rules = {
      ...base,
      domains: [
        { name: "Customers", schema_name: "", subdomains: [sub("Party Master"), sub("Service Location")] },
        { name: "Billing", schema_name: "bill_ing", subdomains: [sub("Meter Reading"), sub("Bill Production")] },
        { name: "Grid", schema_name: "", subdomains: [sub("Grid Assets"), sub("Network Control")] },
        { name: "Asset", schema_name: "", subdomains: [sub("Maintenance")] },
      ],
    };
    // What POST /taxonomy/compile returns for `rules` (backend taxonomy/rules.py).
    const ruleIssues = [
      issue("warning", "Domain 'Customers': 'customers' looks plural - use the singular form, e.g. 'customer' not 'customers' (DOM-RUL-004).", [0], "DOM-RUL-004"),
      issue("error", "Domain 'Billing': schema name 'bill_ing' must be one lowercase word - letters and digits only, no underscores, starting with a letter (DOM-RUL-002).", [1], "DOM-RUL-002"),
      issue("warning", "Domain 'Asset' has only one sub-domain - give it at least two (DOM-RUL-020).", [3], "DOM-RUL-020"),
      issue("warning", "Sub-domain 'Maintenance' in 'Asset' should be exactly two words (DOM-RUL-021).", [3], "DOM-RUL-021"),
    ];

    it("renders the naming-rules panel above the grid, open by default", () => {
      render(<Harness />);
      const panel = screen.getByTestId("naming-rules");
      expect(panel.tagName).toBe("DETAILS");
      expect((panel as HTMLDetailsElement).open).toBe(true);
      expect(within(panel).getByText("Naming rules (from the modeling agent)")).toBeTruthy();
      expect(within(panel).getByText(/one lowercase word, singular, up to 20 characters/i)).toBeTruthy();
      expect(within(panel).getByText(/exactly two words/i)).toBeTruthy();
      expect(within(panel).getByText(/at least 3 domains/i)).toBeTruthy();
      expect(panel.compareDocumentPosition(screen.getByTestId("taxonomy-diagram")) & Node.DOCUMENT_POSITION_FOLLOWING).toBeTruthy();
    });

    it("marks error cards red and warning-only cards amber, both 'Needs attention'", () => {
      render(<Harness initial={rules} issues={ruleIssues} />);
      const err = within(screen.getByTestId("domain-card-1")).getByTestId("domain-attention");
      expect(err.getAttribute("data-severity")).toBe("error");
      const warn = within(screen.getByTestId("domain-card-0")).getByTestId("domain-attention");
      expect(warn.getAttribute("data-severity")).toBe("warning");
      expect(warn.textContent).toMatch(/needs attention/i);
      expect(within(screen.getByTestId("domain-card-2")).queryByTestId("domain-attention")).toBeNull();
    });

    it("lists rule errors and warnings for the domain in the dialog, with the schema hint", () => {
      render(<Harness initial={rules} issues={ruleIssues} />);
      fireEvent.click(screen.getByTestId("domain-card-1"));
      expect(within(dialog()).getByText(/must be one lowercase word/i)).toBeTruthy();
      expect(within(dialog()).getByText(/one lowercase word, ≤20 chars/i)).toBeTruthy();
      fireEvent.click(within(dialog()).getByRole("button", { name: "Done" }));
      fireEvent.click(screen.getByTestId("domain-card-0"));
      expect(within(dialog()).getByText(/looks plural/i)).toBeTruthy();
      fireEvent.click(within(dialog()).getByRole("button", { name: "Done" }));
      fireEvent.click(screen.getByTestId("domain-card-3"));
      expect(within(dialog()).getByText(/should be exactly two words/i)).toBeTruthy();
    });

    it("without issues there are no rule badges; blank names still show at once", () => {
      render(<Harness initial={rules} />);
      expect(screen.queryAllByTestId("domain-attention")).toHaveLength(0);
      fireEvent.click(screen.getByTestId("domain-card-2"));
      fireEvent.change(within(dialog()).getByLabelText("Domain name"), { target: { value: " " } });
      expect(within(dialog()).getByText(/needs a name/i)).toBeTruthy();
    });
  });
});
