import { useState } from "react";
import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { OutlineEditor } from "@/components/taxonomy/outline-editor";

const tree = {
  domains: [{ name: "Billing", schema_name: "", subdomains: [{ name: "Invoices", categories: ["Bill"] }] }],
  shared_masters: [], relationships: [], division_names: [], coverage: "Operations" as const,
};

const open = () => fireEvent.click(screen.getByTestId("domain-card-0"));

describe("OutlineEditor (domain dialog edits)", () => {
  it("adds a domain", () => {
    const onChange = vi.fn();
    render(<OutlineEditor tree={tree} onChange={onChange} />);
    fireEvent.change(screen.getByPlaceholderText("New domain"), { target: { value: "Assets" } });
    fireEvent.click(screen.getByRole("button", { name: "Add domain" }));
    expect(onChange.mock.calls[0][0].domains.map((d: any) => d.name)).toEqual(["Billing", "Assets"]);
  });

  it("renames a category inline", () => {
    const onChange = vi.fn();
    render(<OutlineEditor tree={tree} onChange={onChange} />);
    open();
    fireEvent.change(screen.getByDisplayValue("Bill"), { target: { value: "Invoice" } });
    expect(onChange.mock.calls[0][0].domains[0].subdomains[0].categories).toEqual(["Invoice"]);
  });

  it("removes a domain", () => {
    const onChange = vi.fn();
    render(<OutlineEditor tree={tree} onChange={onChange} />);
    open();
    fireEvent.click(screen.getByRole("button", { name: "Remove domain Billing" }));
    expect(onChange.mock.calls[0][0].domains).toEqual([]);
  });

  it("moves a category to another sub-domain", () => {
    const onChange = vi.fn();
    const t = { ...tree, domains: [{ ...tree.domains[0], subdomains: [
      { name: "Invoices", categories: ["Bill"] }, { name: "Payments", categories: [] },
    ] }] };
    render(<OutlineEditor tree={t} onChange={onChange} />);
    open();
    const sel = screen.getByLabelText("Move category 1 in Invoices");
    expect(Array.from(sel.querySelectorAll("option")).map((o) => o.textContent)).toEqual(["↪", "Billing › Payments"]);
    fireEvent.change(sel, { target: { value: "0:1" } });
    const subs = onChange.mock.calls[0][0].domains[0].subdomains;
    expect(subs[0].categories).toEqual([]);
    expect(subs[1].categories).toEqual(["Bill"]);
  });

  it("keeps the domain name input focused while typing", () => {
    const Harness = () => {
      const [t, setT] = useState<any>(tree);
      return <OutlineEditor tree={t} onChange={setT} />;
    };
    render(<Harness />);
    open();
    const input = screen.getByLabelText("Domain name") as HTMLInputElement;
    input.focus();
    fireEvent.change(input, { target: { value: "Billing2" } });
    const after = screen.getByLabelText("Domain name");
    expect(after).toBe(input);
    expect(document.activeElement).toBe(input);
    expect((after as HTMLInputElement).value).toBe("Billing2");
  });
});
