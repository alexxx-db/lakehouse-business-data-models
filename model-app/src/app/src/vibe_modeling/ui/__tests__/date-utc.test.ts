/**
 * Offset-less backend timestamps (naive Postgres TIMESTAMPs) must read as UTC in
 * every `lib/date.ts` formatter. The file pins a non-UTC zone before `lib/date`
 * loads, so a formatter that parsed the string as local time would differ by the
 * zone offset; under a UTC runner the bug would be invisible.
 */
import { afterAll, afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const previousTz = vi.hoisted(() => {
  const prev = process.env.TZ;
  process.env.TZ = "America/New_York";
  return prev;
});

import { formatDate, formatDateTime, formatRelative } from "@/lib/date";

afterAll(() => {
  if (previousTz === undefined) delete process.env.TZ;
  else process.env.TZ = previousTz;
});

describe("offset-less ISO strings are UTC", () => {
  it("runs in a non-UTC zone", () => {
    expect(new Date("2026-07-01T12:00:00Z").getTimezoneOffset()).not.toBe(0);
  });

  it("formatDateTime", () => {
    expect(formatDateTime("2026-07-01T02:30:00")).toBe(formatDateTime("2026-07-01T02:30:00Z"));
    expect(formatDateTime("2026-07-01T02:30:00.123456")).toBe(formatDateTime("2026-07-01T02:30:00.123456Z"));
  });

  it("formatDate", () => {
    // 02:30 UTC is the previous evening in New York; a local-time parse would say 07-01.
    expect(formatDate("2026-07-01T02:30:00")).toBe("2026-06-30");
    expect(formatDate("2026-07-01T02:30:00")).toBe(formatDate("2026-07-01T02:30:00Z"));
  });

  describe("formatRelative", () => {
    beforeEach(() => {
      vi.useFakeTimers();
      vi.setSystemTime(new Date("2026-07-01T12:00:00Z"));
    });
    afterEach(() => {
      vi.useRealTimers();
    });

    it("measures from the UTC instant", () => {
      expect(formatRelative("2026-07-01T10:00:00")).toBe("2h ago");
      expect(formatRelative("2026-07-01T11:55:00")).toBe("5m ago");
    });

    it("leaves explicit offsets alone", () => {
      expect(formatRelative("2026-07-01T10:00:00+00:00")).toBe("2h ago");
      expect(formatRelative("2026-07-01T06:00:00-04:00")).toBe("2h ago");
    });
  });
});
