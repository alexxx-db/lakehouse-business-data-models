import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { MastersRelationshipsEditor } from "@/components/taxonomy/masters-relationships-editor";

const tree = {
  domains: [
    { name: "Billing", schema_name: "", subdomains: [] },
    { name: "", schema_name: "", subdomains: [] },
  ],
  shared_masters: [{ entity: "customer", home_domain: "billing" }],
  relationships: [], division_names: [], coverage: "Operations" as const,
};

const setup = () => {
  const onChange = vi.fn();
  render(<MastersRelationshipsEditor tree={tree} onChange={onChange} />);
  return onChange;
};
const typeEntity = (v: string) => fireEvent.change(screen.getByPlaceholderText(/entity/i), { target: { value: v } });
const typeRel = (v: string) => fireEvent.change(screen.getByPlaceholderText(/->/), { target: { value: v } });
const addRel = () => fireEvent.click(screen.getByRole("button", { name: "Add relationship" }));

describe("shared masters", () => {
  it("adds a master with a home", () => {
    const onChange = setup();
    typeEntity("Asset Item");
    fireEvent.change(screen.getByLabelText("Shared master home domain"), { target: { value: "billing" } });
    fireEvent.click(screen.getByRole("button", { name: "Add shared master" }));
    expect(onChange.mock.calls[0][0].shared_masters.at(-1)).toEqual({ entity: "asset_item", home_domain: "billing" });
  });

  it("disables Add and hints when no home is picked", () => {
    const onChange = setup();
    typeEntity("asset");
    expect((screen.getByRole("button", { name: "Add shared master" }) as HTMLButtonElement).disabled).toBe(true);
    expect(screen.getByText("Pick a home domain")).toBeTruthy();
    expect(onChange).not.toHaveBeenCalled();
  });

  it("rejects a duplicate entity", () => {
    const onChange = setup();
    typeEntity("Customer");
    fireEvent.change(screen.getByLabelText("Shared master home domain"), { target: { value: "billing" } });
    fireEvent.click(screen.getByRole("button", { name: "Add shared master" }));
    expect(screen.getByRole("alert").textContent).toMatch(/already homed in billing/);
    expect(onChange).not.toHaveBeenCalled();
  });

  it("does not offer a blank-name domain as a home", () => {
    setup();
    const opts = Array.from(screen.getByLabelText("Shared master home domain").querySelectorAll("option")).map((o) => o.value);
    expect(opts).toEqual(["", "billing"]);
  });
});

describe("relationships", () => {
  it("adds a simple relationship", () => {
    const onChange = setup();
    typeRel("bill -> service_agreement");
    addRel();
    expect(onChange.mock.calls[0][0].relationships).toEqual([{ source: "bill", targets: ["service_agreement"] }]);
  });

  it("splits + targets", () => {
    const onChange = setup();
    typeRel("bill -> a + b");
    addRel();
    expect(onChange.mock.calls[0][0].relationships[0].targets).toEqual(["a", "b"]);
  });

  it.each(["bill", "a -> b -> c", "!!! -> x", "a ->  "])("rejects %j and keeps the text", (v) => {
    const onChange = setup();
    typeRel(v);
    addRel();
    expect(screen.getByRole("alert")).toBeTruthy();
    expect((screen.getByPlaceholderText(/->/) as HTMLInputElement).value).toBe(v);
    expect(onChange).not.toHaveBeenCalled();
    typeRel(v + "x");
    expect(screen.queryByRole("alert")).toBeNull();
  });

  it("explains the one-arrow rule", () => {
    setup();
    typeRel("a -> b -> c");
    addRel();
    expect(screen.getByRole("alert").textContent).toMatch(/one arrow/i);
  });
});

describe("explanations", () => {
  it("explains shared masters and key relationships", () => {
    setup();
    expect(screen.getByText(/Each is modeled once, in its home domain/)).toBeTruthy();
    expect(screen.getByText(/Links the model must get right/)).toBeTruthy();
  });
});
