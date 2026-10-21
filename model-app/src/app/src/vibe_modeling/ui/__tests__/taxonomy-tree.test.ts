import { describe, it, expect } from "vitest";
import fixture from "../../../../../../tests/fixtures/taxonomy_snake_fixture.json";
import type { TaxonomySection, TaxonomyTree } from "@/lib/api";
import {
  snake, domainSchema, emptyTree, addDomain, renameDomain, setDomainSchema, removeDomain,
  moveDomain, addSubdomain, renameSubdomain, removeSubdomain, moveSubdomain,
  addCategory, renameCategory, removeCategory, moveCategory, sanitize,
} from "@/lib/taxonomy/tree";

const base = (): TaxonomyTree => ({
  domains: [
    { name: "Customer & Premise", schema_name: "", subdomains: [{ name: "Customer Master", categories: ["Customer", "Contact"] }] },
    { name: "Billing", schema_name: "", subdomains: [{ name: "Invoices", categories: ["Bill"] }] },
  ],
  shared_masters: [{ entity: "customer", home_domain: "customerpremise" }],
  relationships: [],
  division_names: [],
  coverage: "Operations, Business and Corporate",
});

describe("snake parity with backend", () => {
  it.each(fixture as [string, string][])("%s -> %s", (raw, expected) => {
    expect(snake(raw)).toBe(expected);
  });
});

describe("tree ops", () => {
  it("emptyTree has one blank-free domain list and default coverage", () => {
    expect(emptyTree().domains).toEqual([]);
    expect(emptyTree().coverage).toBe("Operations, Business and Corporate");
  });

  it("does not mutate the input", () => {
    const t = base();
    addDomain(t, "Assets");
    expect(t.domains).toHaveLength(2);
  });

  it("renameDomain does not retarget masters of another domain whose schema equals the old one mid-typing", () => {
    const t = base();
    t.domains[0].name = "Customer";
    t.domains[1].name = "Customer";
    t.shared_masters = [{ entity: "customer", home_domain: "customer" }];
    // second domain also has schema "customer" -> renaming it must leave the masters with the first
    const r = renameDomain(t, 1, "Customer Service");
    expect(r.shared_masters![0].home_domain).toBe("customer");
    const r2 = setDomainSchema(t, 1, "billing");
    expect(r2.shared_masters![0].home_domain).toBe("customer");
  });

  it("renameDomain keeps shared masters pointing at the renamed schema", () => {
    const t = renameDomain(base(), 0, "Customer");
    expect(domainSchema(t.domains[0])).toBe("customer");
    expect(t.shared_masters![0].home_domain).toBe("customer");
  });

  it("renameDomain leaves an explicit schema name alone", () => {
    const t = renameDomain(setDomainSchema(base(), 0, "cust"), 0, "Customer");
    expect(t.domains[0].schema_name).toBe("cust");
    expect(t.shared_masters![0].home_domain).toBe("cust");
  });

  it("removeDomain drops shared masters homed there", () => {
    const t = removeDomain(base(), 0);
    expect(t.domains.map((d) => d.name)).toEqual(["Billing"]);
    expect(t.shared_masters).toEqual([]);
  });

  it("moveDomain reorders", () => {
    expect(moveDomain(base(), 1, 0).domains[0].name).toBe("Billing");
  });

  it("sub-domain ops", () => {
    let t = addSubdomain(base(), 0, "Programs");
    t = renameSubdomain(t, 0, 1, "Customer Programs");
    expect(t.domains[0].subdomains![1].name).toBe("Customer Programs");
    t = moveSubdomain(t, 0, 1, 1);
    expect(t.domains[1].subdomains!.map((s) => s.name)).toEqual(["Invoices", "Customer Programs"]);
    t = removeSubdomain(t, 1, 0);
    expect(t.domains[1].subdomains!.map((s) => s.name)).toEqual(["Customer Programs"]);
  });

  it("category ops", () => {
    let t = addCategory(base(), 0, 0, "Account");
    t = renameCategory(t, 0, 0, 2, "Customer Account");
    expect(t.domains[0].subdomains![0].categories).toEqual(["Customer", "Contact", "Customer Account"]);
    t = moveCategory(t, 0, 0, 1, 1, 0);
    expect(t.domains[1].subdomains![0].categories).toEqual(["Bill", "Contact"]);
    t = removeCategory(t, 1, 0, 0);
    expect(t.domains[1].subdomains![0].categories).toEqual(["Contact"]);
  });

  it("ignores blank names on add", () => {
    expect(addDomain(base(), "   ").domains).toHaveLength(2);
    expect(addCategory(base(), 0, 0, "").domains[0].subdomains![0].categories).toHaveLength(2);
  });
});

describe("sanitize (runs before every compile/condense — backend models are min_length=1)", () => {
  it("passes a clean tree through with no problems", () => {
    const r = sanitize(base(), {});
    expect(r.problems).toEqual([]);
    expect(r.tree).toEqual(base());
    expect(r.sections).toEqual({});
  });

  it("trims claims, drops empty claims (the 'Add a line' row), and drops sections left with zero claims", () => {
    const sections: Record<string, TaxonomySection> = {
      company: { claims: [{ text: "  Ridgeline is a utility. ", provenance: "user" }, { text: "", provenance: "user" }] },
      channels: { claims: [{ text: "   ", provenance: "industry" }] },
      processes: { claims: [] },
    };
    const r = sanitize(base(), sections);
    expect(r.sections).toEqual({ company: { claims: [{ text: "Ridgeline is a utility.", provenance: "user" }] } });
    expect(r.problems).toEqual([]);
  });

  it("drops blank categories and trims the rest", () => {
    const t = renameCategory(renameCategory(base(), 0, 0, 0, "   "), 0, 0, 1, " Contact ");
    expect(sanitize(t, {}).tree.domains[0].subdomains![0].categories).toEqual(["Contact"]);
  });

  it("reports a blank domain name as a problem", () => {
    const r = sanitize(renameDomain(base(), 1, "  "), {});
    expect(r.problems).toEqual(["Domain 2 needs a name."]);
  });

  it("reports a blank sub-domain name as a problem", () => {
    const r = sanitize(renameSubdomain(base(), 0, 0, ""), {});
    expect(r.problems).toEqual(["Sub-domain 1 in 'Customer & Premise' needs a name."]);
  });

  it("reports an empty domain list", () => {
    expect(sanitize(emptyTree(), {}).problems).toEqual(["Add at least one domain."]);
  });

  it("drops blank division names and incomplete masters/relationships", () => {
    const t = {
      ...base(),
      division_names: [" Retail ", ""],
      shared_masters: [{ entity: "customer", home_domain: "customerpremise" }, { entity: " ", home_domain: "billing" }],
      relationships: [{ source: "bill", targets: [" customer ", ""] }, { source: "x", targets: ["  "] }],
    };
    const r = sanitize(t, {});
    expect(r.tree.division_names).toEqual(["Retail"]);
    expect(r.tree.shared_masters).toEqual([{ entity: "customer", home_domain: "customerpremise" }]);
    expect(r.tree.relationships).toEqual([{ source: "bill", targets: ["customer"] }]);
  });

  it("does not mutate its inputs", () => {
    const t = renameCategory(base(), 0, 0, 0, "  ");
    const sections = { company: { claims: [{ text: "", provenance: "user" as const }] } };
    sanitize(t, sections);
    expect(t.domains[0].subdomains![0].categories![0]).toBe("  ");
    expect(sections.company.claims).toHaveLength(1);
  });
});

describe("no-op moves", () => {
  it("moveSubdomain to the same domain returns the same tree", () => {
    const t = base();
    expect(moveSubdomain(t, 0, 0, 0)).toBe(t);
  });
  it("moveCategory to the same sub-domain returns the same tree", () => {
    const t = base();
    expect(moveCategory(t, 0, 0, 0, 0, 0)).toBe(t);
  });
});
