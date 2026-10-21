import { beforeEach, describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";

const { assess } = vi.hoisted(() => ({ assess: { data: undefined as unknown } }));

vi.mock("@/lib/api", () => ({
  useGetAssessConfig: () => ({ data: assess.data }),
}));

vi.mock("@tanstack/react-router", () => ({
  Link: ({ children, to, params, search, ...rest }: any) => (
    <a
      href={`${String(to).replace("$businessId", params?.businessId)}?versionId=${search?.versionId ?? ""}&domainId=${search?.domainId ?? ""}`}
      {...rest}
    >
      {children}
    </a>
  ),
}));

import { AssessButton } from "@/components/assessment/assess-button";

const ready = (value: boolean) => ({ data: { installed: true, ready: value } });

describe("AssessButton", () => {
  beforeEach(() => {
    assess.data = ready(true);
  });

  it("renders nothing unless the assessment skill is ready", () => {
    for (const data of [undefined, ready(false), { data: { installed: false, ready: false } }]) {
      assess.data = data;
      const { container, unmount } = render(<AssessButton businessId="b1" versionId="v1" installed />);
      expect(container).toBeEmptyDOMElement();
      unmount();
    }
  });

  it("is disabled with an install hint when the version is not installed", () => {
    render(<AssessButton businessId="b1" versionId="v1" installed={false} />);
    const btn = screen.getByRole("button", { name: /assess/i }) as HTMLButtonElement;
    expect(btn.disabled).toBe(true);
    expect(screen.getByTitle("Install this version into a catalog to assess it")).toBeTruthy();
  });

  it("links to the wizard with version and domain when installed", () => {
    render(<AssessButton businessId="b1" versionId="v1" domainId="d1" installed />);
    const link = screen.getByRole("link", { name: /assess/i });
    expect(link.getAttribute("href")).toBe("/businesses/b1/assessments/new?versionId=v1&domainId=d1");
  });
});
