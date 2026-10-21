/**
 * Client-side auto-retry for a draft part the server reported `busy` (no free
 * model slot, or the model service rate-limited the call). The server keeps
 * no backoff: this countdown is the backoff, and a busy part holds no slot
 * while it waits.
 */
import { useCallback, useEffect, useRef, useState } from "react";
import { useNow } from "@/lib/use-now";
import { LIVE_PART_STATUSES } from "@/lib/taxonomy/part-status";

/** Seconds before automatic attempt 1..6 (about 19 minutes in total). */
export const BUSY_RETRY_SCHEDULE_S = [15, 30, 60, 120, 300, 600] as const;
/** Each wait is the schedule value ± this fraction, so users who hit busy together spread out. */
export const BUSY_RETRY_JITTER = 0.2;

/** Wait before attempt `attempt` (0-based), jittered. */
export function busyRetryDelayMs(attempt: number): number {
  const base = BUSY_RETRY_SCHEDULE_S[Math.min(attempt, BUSY_RETRY_SCHEDULE_S.length - 1)];
  const jitter = 1 + (Math.random() * 2 - 1) * BUSY_RETRY_JITTER;
  return Math.round(base * jitter * 1000);
}


export type BusyAutoRetry = {
  /** The part is busy right now. */
  busy: boolean;
  /** Seconds until the next automatic attempt; null when none is scheduled. */
  remainingS: number | null;
  /** All automatic attempts used: only manual Retry and Cancel remain. */
  exhausted: boolean;
  /** A retry call is in flight: the buttons are disabled until it settles. */
  retrying: boolean;
  /** Retry at once. Counts as the current attempt and moves the schedule on.
   *  Ignored while a retry is already in flight. */
  retryNow: () => void;
  /** Stop the countdown at once, then cancel the draft. */
  cancel: () => void;
};

export type BusyAutoRetryOptions = {
  /** The existing per-part Retry path (retryTaxonomyDraftPart + cache write). */
  retry: () => Promise<unknown> | void;
  /** Cancel the draft (cancelTaxonomyDraft + cache write). */
  cancel: () => Promise<unknown> | void;
  /** A new value (a new draft) resets the schedule. */
  resetKey?: unknown;
};

/**
 * Counts down and retries one busy part on `BUSY_RETRY_SCHEDULE_S`. At zero,
 * or on `retryNow`, it calls `retry`; the next wait starts once that call has
 * settled and the part is still busy. After the 6th attempt it stops. A part
 * that ends anything other than busy (done, failed, cancelled, timed out)
 * resets the schedule, and so does a change of `resetKey`.
 */
export function useBusyAutoRetry(
  status: string | undefined,
  { retry, cancel, resetKey }: BusyAutoRetryOptions,
): BusyAutoRetry {
  const [attempt, setAttempt] = useState(0);
  const [deadline, setDeadline] = useState<number | null>(null);
  const [inFlight, setInFlight] = useState(false);
  const [stopped, setStopped] = useState(false);
  const inFlightRef = useRef(false);
  const actions = useRef({ retry, cancel });
  actions.current = { retry, cancel };
  const keyRef = useRef(resetKey);
  const busy = status === "busy";
  const exhausted = attempt >= BUSY_RETRY_SCHEDULE_S.length;

  useEffect(() => {
    if (Object.is(keyRef.current, resetKey)) return;
    keyRef.current = resetKey;
    setAttempt(0);
    setDeadline(null);
    setStopped(false);
  }, [resetKey]);

  useEffect(() => {
    if (busy) return;
    setDeadline(null);
    setStopped(false);
    // A retry passes through pending/running on its way back: that keeps the schedule.
    if (!LIVE_PART_STATUSES.has(status ?? "")) setAttempt(0);
  }, [busy, status]);

  const retryNow = useCallback(() => {
    if (inFlightRef.current) return;
    inFlightRef.current = true;
    setDeadline(null);
    setStopped(false);
    setAttempt((a) => a + 1);
    setInFlight(true);
    void Promise.resolve()
      .then(() => actions.current.retry())
      .finally(() => {
        inFlightRef.current = false;
        setInFlight(false);
      });
  }, []);

  const stopAndCancel = useCallback(() => {
    setDeadline(null);
    setStopped(true);
    void actions.current.cancel();
  }, []);

  useEffect(() => {
    if (!busy || exhausted || inFlight || stopped || deadline !== null) return;
    setDeadline(Date.now() + busyRetryDelayMs(attempt));
  }, [busy, exhausted, inFlight, stopped, deadline, attempt]);

  useEffect(() => {
    if (deadline === null) return;
    const t = setTimeout(retryNow, Math.max(0, deadline - Date.now()));
    return () => clearTimeout(t);
  }, [deadline, retryNow]);

  const now = useNow(deadline !== null);
  const remainingS = deadline === null ? null : Math.max(0, Math.ceil((deadline - now) / 1000));
  return { busy, remainingS, exhausted, retrying: inFlight, retryNow, cancel: stopAndCancel };
}
