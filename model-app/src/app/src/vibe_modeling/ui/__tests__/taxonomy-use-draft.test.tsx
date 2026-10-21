import { describe, it, expect, vi, beforeEach } from "vitest";
import { act, renderHook, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import type { ReactNode } from "react";

const { getTaxonomyDraft } = vi.hoisted(() => ({ getTaxonomyDraft: vi.fn() }));
vi.mock("@/lib/api", async (orig) => ({ ...(await orig<any>()), getTaxonomyDraft }));

import { ApiError } from "@/lib/api";
import { useTaxonomyDraft } from "@/lib/taxonomy/use-taxonomy-draft";

const draft = (status: string) => ({ draft_id: "d1", status, parts: {} });

function setup() {
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  const wrapper = ({ children }: { children: ReactNode }) => <QueryClientProvider client={qc}>{children}</QueryClientProvider>;
  const hook = renderHook(() => useTaxonomyDraft("d1", { pollMs: 20 }), { wrapper });
  return { qc, ...hook };
}

// Braces matter: mockReset() returns the mock, and a beforeEach returning a function is run as teardown.
beforeEach(() => {
  getTaxonomyDraft.mockReset();
});

describe("useTaxonomyDraft", () => {
  it("polls while running and stops once done", async () => {
    getTaxonomyDraft.mockResolvedValueOnce({ data: draft("running") }).mockResolvedValue({ data: draft("done") });
    const { result } = setup();
    await waitFor(() => expect(result.current.draft?.status).toBe("done"));
    const calls = getTaxonomyDraft.mock.calls.length;
    await new Promise((r) => setTimeout(r, 120));
    expect(getTaxonomyDraft.mock.calls.length).toBe(calls);
  });

  it("resumes polling when a retry response puts a finished draft back to running", async () => {
    getTaxonomyDraft.mockResolvedValue({ data: draft("done") });
    const { qc, result } = setup();
    await waitFor(() => expect(result.current.draft?.status).toBe("done"));
    await new Promise((r) => setTimeout(r, 120));
    expect(getTaxonomyDraft).toHaveBeenCalledTimes(1); // polling stopped

    // What the wizard does with the retry/cancel response:
    getTaxonomyDraft.mockReset();
    getTaxonomyDraft.mockResolvedValueOnce({ data: draft("running") }).mockResolvedValue({ data: draft("done") });
    act(() => {
      qc.setQueryData(["taxonomy-draft", "d1"], draft("running"));
    });
    expect(qc.getQueryData<{ status: string }>(["taxonomy-draft", "d1"])?.status).toBe("running");
    await waitFor(() => expect(getTaxonomyDraft.mock.calls.length).toBeGreaterThanOrEqual(2)); // polled again
    await waitFor(() => expect(result.current.draft?.status).toBe("done"));
  });

  it("reports lost on a 404", async () => {
    getTaxonomyDraft.mockImplementation(async () => { throw new ApiError(404, "Not Found", { detail: "Draft not found" }); });
    const { result } = setup();
    await waitFor(() => expect(result.current.lost).toBe(true));
  });
});
