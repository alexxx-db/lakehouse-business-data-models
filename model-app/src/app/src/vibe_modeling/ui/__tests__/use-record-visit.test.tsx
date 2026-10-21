/**
 * `useRecordVisit`: one PUT per distinct (key, value), a prefs refresh after a
 * successful write, a null key that writes nothing and re-arms the recorder,
 * and silent failures.
 */
import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { StrictMode, type ReactNode } from "react";
import { renderHook, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const setUserPreference = vi.hoisted(() => vi.fn());

vi.mock("@/lib/api", async () => {
  const actual = await vi.importActual<typeof import("@/lib/api")>("@/lib/api");
  return { ...actual, setUserPreference };
});

import { getUserPreferencesKey } from "@/lib/api";
import { useRecordVisit } from "@/components/home/recent-items";

let client: QueryClient;
let invalidate: ReturnType<typeof vi.spyOn>;
let consoleError: ReturnType<typeof vi.spyOn>;

function wrapper({ children }: { children: ReactNode }) {
  return (
    <StrictMode>
      <QueryClientProvider client={client}>{children}</QueryClientProvider>
    </StrictMode>
  );
}

beforeEach(() => {
  client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  invalidate = vi.spyOn(client, "invalidateQueries");
  consoleError = vi.spyOn(console, "error").mockImplementation(() => {});
  setUserPreference.mockReset();
  setUserPreference.mockResolvedValue({ data: {} });
});

afterEach(() => {
  consoleError.mockRestore();
});

describe("useRecordVisit", () => {
  it("writes once under StrictMode and then refreshes the preferences query", async () => {
    renderHook(() => useRecordVisit("visit:business:biz-1"), { wrapper });
    await waitFor(() => expect(invalidate).toHaveBeenCalledTimes(1));
    expect(setUserPreference).toHaveBeenCalledTimes(1);
    expect(setUserPreference).toHaveBeenCalledWith(
      { key: "visit:business:biz-1" },
      { value: "1" },
    );
    expect(invalidate).toHaveBeenCalledWith({ queryKey: getUserPreferencesKey() });
  });

  it("does not refresh the preferences query before the write lands", async () => {
    let resolve!: (v: unknown) => void;
    setUserPreference.mockReturnValue(new Promise((r) => (resolve = r)));
    renderHook(() => useRecordVisit("visit:business:biz-1"), { wrapper });
    expect(invalidate).not.toHaveBeenCalled();
    resolve({ data: {} });
    await waitFor(() => expect(invalidate).toHaveBeenCalledTimes(1));
  });

  it("writes again when the key or the value changes", async () => {
    const { rerender } = renderHook(
      ({ k, v }: { k: string | null; v?: string }) => useRecordVisit(k, v),
      { wrapper, initialProps: { k: "visit:business:a" } as { k: string | null; v?: string } },
    );
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(1));
    rerender({ k: "visit:business:a" });
    expect(setUserPreference).toHaveBeenCalledTimes(1);
    rerender({ k: "visit:business:b" });
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(2));
    rerender({ k: "visit:business:b", v: "2" });
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(3));
    expect(setUserPreference).toHaveBeenLastCalledWith(
      { key: "visit:business:b" },
      { value: "2" },
    );
  });

  it("writes nothing for a null key and records again once the key returns", async () => {
    const { rerender } = renderHook(
      ({ k }: { k: string | null }) => useRecordVisit(k),
      { wrapper, initialProps: { k: null as string | null } },
    );
    expect(setUserPreference).not.toHaveBeenCalled();
    rerender({ k: "visit:business:a" });
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(1));
    rerender({ k: null });
    rerender({ k: "visit:business:a" });
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(2));
  });

  it("swallows a rejected write without refreshing or logging", async () => {
    setUserPreference.mockRejectedValue(new Error("401"));
    renderHook(() => useRecordVisit("visit:business:biz-1"), { wrapper });
    await waitFor(() => expect(setUserPreference).toHaveBeenCalledTimes(1));
    await new Promise((r) => setTimeout(r, 0));
    expect(invalidate).not.toHaveBeenCalled();
    expect(consoleError).not.toHaveBeenCalled();
  });
});
