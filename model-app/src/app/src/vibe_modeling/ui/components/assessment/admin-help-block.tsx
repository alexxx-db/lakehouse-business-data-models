import type { ReactNode } from "react";
import { AlertTriangle, Copy, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import type { AdminHelp } from "@/lib/api-error";
import { ADMIN_HELP_CONTACT, ADMIN_HELP_LEAD, adminHelpText } from "@/lib/assessment";
import { copyToClipboard } from "@/lib/notify";

function Detail({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div className="flex gap-2">
      <dt className="w-16 shrink-0 text-muted-foreground">{label}</dt>
      <dd className="min-w-0 break-all">{children}</dd>
    </div>
  );
}

function OutLink({ href, children }: { href: string; children: ReactNode }) {
  return (
    <a href={href} target="_blank" rel="noreferrer" className="inline-flex items-center gap-1 text-primary hover:underline">
      {children} <ExternalLink className="h-3 w-3" />
    </a>
  );
}

/**
 * An assessment failure only an administrator can fix: the error, the job and
 * job-run links, the identity the job ran as and the runs-volume folder when
 * known, and a Copy button that copies all of it as plain text
 * (`adminHelpText`) for the user to send to the admin. Every assessment
 * failure path renders this one block. `live` (an alert) is for blocks a user
 * action just produced; blocks rendered with the page get no live role.
 */
export function AdminHelpBlock({
  help,
  testId,
  lead = ADMIN_HELP_LEAD,
  live = false,
}: {
  help: AdminHelp;
  testId: string;
  lead?: string;
  live?: boolean;
}) {
  return (
    <div
      role={live ? "alert" : undefined}
      data-testid={testId}
      className="space-y-2 rounded-md border border-destructive/40 p-3 text-sm"
    >
      <div className="flex items-start gap-2">
        <AlertTriangle className="mt-0.5 h-4 w-4 shrink-0 text-destructive" aria-hidden />
        <p className="font-medium text-destructive">
          {lead} {ADMIN_HELP_CONTACT}
        </p>
      </div>
      <p className="whitespace-pre-wrap break-words font-mono text-xs">{help.message}</p>
      {help.not_ready && help.not_ready.length > 0 && (
        <ul className="list-disc space-y-0.5 pl-5 text-xs">
          {help.not_ready.map((reason) => (
            <li key={reason}>{reason}</li>
          ))}
        </ul>
      )}
      {(help.job_url || help.run_url || help.job_reader || help.runs_path) && (
        <dl className="space-y-1 text-xs">
          {help.job_url && (
            <Detail label="Job">
              <OutLink href={help.job_url}>Open job</OutLink>
            </Detail>
          )}
          {help.run_url && (
            <Detail label="Job run">
              <OutLink href={help.run_url}>Open job run</OutLink>
            </Detail>
          )}
          {help.job_reader && (
            <Detail label="Ran as">
              <span className="font-mono">{help.job_reader}</span>
            </Detail>
          )}
          {help.runs_path && (
            <Detail label="Files">
              <span className="font-mono">{help.runs_path}</span>
            </Detail>
          )}
        </dl>
      )}
      <Button type="button" variant="outline" size="sm" onClick={() => void copyToClipboard(adminHelpText(help, lead))}>
        <Copy className="mr-1.5 h-3.5 w-3.5" />
        Copy details
      </Button>
    </div>
  );
}
