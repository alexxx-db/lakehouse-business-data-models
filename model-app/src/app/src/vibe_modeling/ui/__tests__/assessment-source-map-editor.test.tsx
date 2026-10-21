import { describe, expect, it, vi } from "vitest";
import { useState } from "react";
import { act } from "@testing-library/react";
import type { SourceIn } from "@/lib/api";

// Native <select> stand-in for Radix Select so jsdom can drive it. Mirrors the
// controlled contract: value "" must show the placeholder option.
vi.mock("@/components/ui/select", async () => {
  const React = await import("react");
  const SelectTrigger = (_: any) => null;
  const SelectValue = (_: any) => null;
  const SelectContent = (_: any) => null;
  const SelectItem = ({ value, children }: any) => <option value={value}>{children}</option>;
  const Select = ({ value, onValueChange, children }: any) => {
    const kids = React.Children.toArray(children) as any[];
    const trig = kids.find((k) => k.type === SelectTrigger);
    const content = kids.find((k) => k.type === SelectContent);
    const placeholder = (React.Children.toArray(trig.props.children)[0] as any)?.props?.placeholder ?? "";
    return (
      <select aria-label={trig.props["aria-label"]} value={value} onChange={(e) => onValueChange(e.target.value)}>
        <option value="">{placeholder}</option>
        {content.props.children}
      </select>
    );
  };
  return { Select, SelectTrigger, SelectValue, SelectContent, SelectItem };
});
import { render, screen, fireEvent } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { SourceMapEditor } from "@/components/assessment/source-map-editor";

const rows = [
  { source_name: "src_sap", catalog_name: "raw", schema_name: "sap" },
  { source_name: "src_crm", catalog_name: "raw", schema_name: "crm" },
];

function setup(value = rows, onChange = vi.fn()) {
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  render(
    <QueryClientProvider client={qc}>
      <SourceMapEditor
        value={value}
        onChange={onChange}
        catalogsOverride={[{ name: "raw" }, { name: "lake" }]}
        schemasOverride={["sap", "crm"]}
      />
    </QueryClientProvider>,
  );
  return onChange;
}

describe("SourceMapEditor", () => {
  it("renders one row per source", () => {
    setup();
    const inputs = screen.getAllByLabelText("Source name") as HTMLInputElement[];
    expect(inputs.map((i) => i.value)).toEqual(["src_sap", "src_crm"]);
  });

  it("Add source appends an empty row", () => {
    const onChange = setup();
    fireEvent.click(screen.getByRole("button", { name: /add source/i }));
    expect(onChange).toHaveBeenCalledWith([
      ...rows,
      { source_name: "", catalog_name: "", schema_name: "" },
    ]);
  });

  it("remove deletes a row", () => {
    const onChange = setup();
    fireEvent.click(screen.getAllByRole("button", { name: /remove source/i })[0]);
    expect(onChange).toHaveBeenCalledWith([rows[1]]);
  });

  it("editing the source name emits the updated list", () => {
    const onChange = setup();
    fireEvent.change(screen.getAllByLabelText("Source name")[0], { target: { value: "src_new" } });
    expect(onChange).toHaveBeenCalledWith([{ ...rows[0], source_name: "src_new" }, rows[1]]);
  });

  it("flags an invalid source name", () => {
    setup([{ source_name: "src a", catalog_name: "raw", schema_name: "sap" }]);
    expect(screen.getByText("Letters, digits and _ only")).toBeTruthy();
  });

  it("does not flag a valid or empty source name", () => {
    setup([{ source_name: "", catalog_name: "", schema_name: "" }, rows[0]]);
    expect(screen.queryByText("Letters, digits and _ only")).toBeNull();
  });

  it("shows the placeholder and flags the row when the catalog changes", () => {
    const seen: SourceIn[][] = [];
    function Harness() {
      const [v, setV] = useState<SourceIn[]>([{ source_name: "s", catalog_name: "", schema_name: "" }]);
      seen.push(v);
      return (
        <SourceMapEditor
          value={v}
          onChange={setV}
          catalogsOverride={[{ name: "raw" }, { name: "lake" }]}
          schemasOverride={["sap", "crm"]}
        />
      );
    }
    const qc = new QueryClient();
    render(
      <QueryClientProvider client={qc}>
        <Harness />
      </QueryClientProvider>,
    );
    const catalog = () => screen.getByLabelText("Catalog") as HTMLSelectElement;
    const schema = () => screen.getByLabelText("Schema") as HTMLSelectElement;
    act(() => { fireEvent.change(catalog(), { target: { value: "raw" } }); });
    act(() => { fireEvent.change(schema(), { target: { value: "sap" } }); });
    expect(schema().value).toBe("sap");
    act(() => { fireEvent.change(catalog(), { target: { value: "lake" } }); });
    expect(schema().value).toBe("");
    expect(schema().options[schema().selectedIndex].text).toBe("Pick a schema");
    expect(seen[seen.length - 1][0].schema_name).toBe("");
  });

  it("keeps row state with its row after removing an earlier row", () => {
    function Harness() {
      const [v, setV] = useState<SourceIn[]>(rows);
      return <SourceMapEditor value={v} onChange={setV} catalogsOverride={[{ name: "raw" }]} schemasOverride={["sap", "crm"]} />;
    }
    render(
      <QueryClientProvider client={new QueryClient()}>
        <Harness />
      </QueryClientProvider>,
    );
    fireEvent.click(screen.getAllByRole("button", { name: /remove source/i })[0]);
    expect((screen.getByLabelText("Source name") as HTMLInputElement).value).toBe("src_crm");
    expect((screen.getByLabelText("Schema") as HTMLSelectElement).value).toBe("crm");
  });
});
