import { describe, it, expect } from "vitest";
import { render, screen, within } from "@testing-library/react";
import { TaxonomyDiagram } from "@/components/taxonomy/taxonomy-diagram";

const tree = {
  domains: [
    { name: "Customer & Premise", schema_name: "", subdomains: [{ name: "Customer Master", categories: ["Customer", "Contact"] }] },
    { name: "Billing", schema_name: "bill", subdomains: [] },
  ],
  shared_masters: [], relationships: [], division_names: [], coverage: "Operations" as const,
};

describe("TaxonomyDiagram", () => {
  it("renders a column per domain with schema, sub-domains, and category pills", () => {
    render(<TaxonomyDiagram tree={tree} />);
    const cols = screen.getAllByTestId("taxonomy-domain-column");
    expect(cols).toHaveLength(2);
    expect(within(cols[0]).getByText("customerpremise")).toBeTruthy();
    expect(within(cols[0]).getByText("Customer Master")).toBeTruthy();
    expect(within(cols[0]).getAllByTestId("taxonomy-category-pill")).toHaveLength(2);
    expect(within(cols[1]).getByText("bill")).toBeTruthy();
    expect(within(cols[1]).getByText(/no sub-domains yet/i)).toBeTruthy();
  });

  it("renders an empty state", () => {
    render(<TaxonomyDiagram tree={{ ...tree, domains: [] }} />);
    expect(screen.getByText(/add a domain/i)).toBeTruthy();
  });
});
