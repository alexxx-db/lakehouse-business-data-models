import type { BusyAutoRetry } from "@/lib/taxonomy/busy-retry";
import { formatElapsedSeconds } from "@/lib/date";
import { Button } from "@/components/ui/button";
import { StatusLine } from "@/components/settings/status-line";

export const BUSY_EXHAUSTED_COPY = "Still busy. Retry, or Cancel and come back later.";

type Props = {
  state: BusyAutoRetry;
  /** Label for the retry button where the step already names it ("Retry domains"). */
  retryLabel?: string;
  testId?: string;
};

/** What a busy part shows: the countdown with Retry now and Cancel, or, once
 *  the automatic attempts are used up, manual Retry and Cancel only. */
export function BusyCountdown({ state, retryLabel, testId = "busy-countdown" }: Props) {
  const message = state.exhausted
    ? BUSY_EXHAUSTED_COPY
    : state.remainingS === null
      ? "The model is busy. Retrying…"
      : `The model is busy. Retrying in ${formatElapsedSeconds(state.remainingS)}`;
  return (
    <div className="flex flex-wrap items-center gap-2" data-testid={testId} data-exhausted={state.exhausted}>
      <StatusLine tone="warn">{message}</StatusLine>
      <Button type="button" size="sm" variant="outline" className="h-7" onClick={state.retryNow} disabled={state.retrying}>
        {retryLabel ?? (state.exhausted ? "Retry" : "Retry now")}
      </Button>
      <Button type="button" size="sm" variant="ghost" className="h-7" onClick={state.cancel} disabled={state.retrying}>Cancel</Button>
    </div>
  );
}
