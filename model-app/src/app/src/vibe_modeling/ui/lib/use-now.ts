import { useEffect, useState } from "react";

/** The current time, re-rendering every `intervalMs` while `active` (a ticking
 *  elapsed or remaining-time display). Returns `Date.now()` at render time.
 *  Kept apart from `lib/hooks.ts` so it pulls in no API client. */
export function useNow(active: boolean, intervalMs = 1000): number {
  const [, setTick] = useState(0);
  useEffect(() => {
    if (!active) return;
    const id = setInterval(() => setTick((t) => t + 1), intervalMs);
    return () => clearInterval(id);
  }, [active, intervalMs]);
  return Date.now();
}
