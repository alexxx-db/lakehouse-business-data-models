import { describe, expect, it } from "vitest";
import { render, screen } from "@testing-library/react";
import { AssessedDomains } from "@/components/assessment/assessed-domains";

describe("AssessedDomains", () => {
  it("renders one name", () => {
    render(<AssessedDomains names={["sales"]} />);
    expect(screen.getByText("sales")).toBeTruthy();
  });

  it("renders 3 names comma-separated", () => {
    render(<AssessedDomains names={["sales", "inventory", "finance"]} />);
    expect(screen.getByText("sales, inventory, finance")).toBeTruthy();
  });

  it("shows +N more when there are more than 3 names", () => {
    render(<AssessedDomains names={["sales", "inventory", "finance", "hr", "it"]} />);
    expect(screen.getByText("sales, inventory, finance")).toBeTruthy();
    expect(screen.getByText("+2 more")).toBeTruthy();
    expect(screen.getByText("+2 more")).toHaveClass("text-muted-foreground");
  });

  it("puts the full list in the title attribute for hover on 5 names", () => {
    const { container } = render(<AssessedDomains names={["sales", "inventory", "finance", "hr", "it"]} />);
    const wrapper = container.firstChild as HTMLElement;
    expect(wrapper.getAttribute("title")).toBe("sales, inventory, finance, hr, it");
  });

  it("removes duplicates while keeping order", () => {
    render(<AssessedDomains names={["sales", "inventory", "sales", "finance"]} />);
    expect(screen.getByText("sales, inventory, finance")).toBeTruthy();
  });

  it("skips empty names", () => {
    render(<AssessedDomains names={["sales", "", "inventory"]} />);
    expect(screen.getByText("sales, inventory")).toBeTruthy();
  });

  it("renders — (muted) when given an empty list", () => {
    render(<AssessedDomains names={[]} />);
    const muted = screen.getByText("—");
    expect(muted).toBeTruthy();
    expect(muted).toHaveClass("text-muted-foreground");
  });

  it("renders — (muted) when all names are empty", () => {
    render(<AssessedDomains names={["", "", ""]} />);
    const muted = screen.getByText("—");
    expect(muted).toBeTruthy();
    expect(muted).toHaveClass("text-muted-foreground");
  });

  it("does not set title attribute when 3 or fewer unique names", () => {
    const { container: container1 } = render(<AssessedDomains names={["sales"]} />);
    expect((container1.firstChild as HTMLElement).getAttribute("title")).toBeNull();

    const { container: container2 } = render(<AssessedDomains names={["sales", "inventory", "finance"]} />);
    expect((container2.firstChild as HTMLElement).getAttribute("title")).toBeNull();
  });
});
