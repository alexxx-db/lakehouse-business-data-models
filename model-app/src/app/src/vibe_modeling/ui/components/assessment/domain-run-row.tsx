import { ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import type { AssessDomainRunOut } from "@/lib/api";
import { ingestRetryText, isIngestRetrying, isRelaunchable, isTerminal } from "@/lib/assessment";
import { useNow } from "@/lib/use-now";
import { StatusBadge } from "./status-badge";

/**
 * One domain's status line on the batch page: badge, latest message, run link, cancel.
 * While its results are being re-saved it shows the attempt and the next try (from the
 * structured `ingest_*` fields) over the full last error. Cancel is hidden then: stopping a
 * run mid-save isn't supported (the backend is to refuse it, and Cancel all to skip it).
 */
export function DomainRunRow({
  run,
  onCancel,
  cancelling = false,
  onRelaunch,
  relaunching = false,
}: {
  run: AssessDomainRunOut;
  onCancel: (domainRunId: string) => void;
  cancelling?: boolean;
  onRelaunch?: (domainRunId: string) => void;
  relaunching?: boolean;
}) {
  const retrying = isIngestRetrying(run);
  const now = useNow(retrying, 30000);
  return (
    <div className="flex items-center gap-3 rounded-md border p-3">
      <span className="w-48 truncate font-medium">{run.domain_name}</span>
      <StatusBadge status={run.status} attempt={run.attempt} resumeAt={run.resume_at} />
      {retrying ? (
        <span className="min-w-0 flex-1 text-sm" data-testid={`ingest-retry-${run.id}`}>
          <span className="block truncate text-warning">{ingestRetryText(run, now)}</span>
          {run.last_message && (
            <span className="block whitespace-pre-wrap break-words text-xs text-muted-foreground">
              {run.last_message}
            </span>
          )}
        </span>
      ) : (
        <span className="flex-1 truncate text-sm text-muted-foreground">
          {run.last_message || run.error_message}
        </span>
      )}
      {run.run_url && (
        <a
          href={run.run_url}
          target="_blank"
          rel="noreferrer"
          className="inline-flex items-center gap-1 text-sm text-primary hover:underline"
        >
          Open run <ExternalLink className="h-3 w-3" />
        </a>
      )}
      {!isTerminal(run.status) && !retrying && (
        <Button variant="outline" size="sm" onClick={() => onCancel(run.id)} disabled={cancelling}>
          Cancel
        </Button>
      )}
      {onRelaunch && isRelaunchable(run.status) && (
        <Button variant="outline" size="sm" onClick={() => onRelaunch(run.id)} disabled={relaunching}>
          Relaunch
        </Button>
      )}
    </div>
  );
}
