import type { ReactNode } from "react";
import { Link } from "@tanstack/react-router";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { apiErrorMessage } from "@/lib/api-error";
import { StatusLine } from "@/components/settings/status-line";
import { useAssessReady } from "@/lib/assessment";
import { useUserRole } from "@/lib/hooks";

export const NOT_INSTALLED_TEXT =
  "This installation doesn't include the bronze assessment skill. It is enabled at install time.";
export const NOT_READY_TEXT = "Assessment isn't set up yet. Ask your administrator.";

/** The page shown in place of an assessment page when the skill isn't installed. */
export function AssessNotInstalled() {
  return (
    <p className="text-sm text-muted-foreground" data-testid="assess-not-installed">
      {NOT_INSTALLED_TEXT}
    </p>
  );
}

/** `GET /assess/config` failed: whether the skill is installed is unknown, so say so and offer a retry. */
export function AssessConfigError({ error, onRetry }: { error: unknown; onRetry: () => void }) {
  return (
    <div className="space-y-2 text-sm" data-testid="assess-config-error">
      <p>Couldn't load the assessment settings: {apiErrorMessage(error)}</p>
      <Button type="button" variant="outline" size="sm" onClick={onRetry}>
        Try again
      </Button>
    </div>
  );
}

/**
 * The "not set up yet" notice for an installed but not-ready skill. App admins
 * also see the `missing` reasons and a link to Settings → Assessment.
 */
export function AssessNotReady({ missing }: { missing: string[] }) {
  const isAdmin = useUserRole() === "app_admin";
  return (
    <div className="space-y-1.5 rounded-md border bg-muted/30 p-3 text-sm" data-testid="assess-not-ready">
      <p>{NOT_READY_TEXT}</p>
      {isAdmin && (
        <>
          {missing.map((reason) => (
            <StatusLine key={reason} tone="warn">
              {reason}
            </StatusLine>
          ))}
          <Link to="/settings" search={{ tab: "assessment" }} className="text-xs text-primary hover:underline">
            Open Settings → Assessment
          </Link>
        </>
      )}
    </div>
  );
}

/**
 * Gate for the assessment pages: waits for `GET /assess/config`, shows an
 * error with a retry when it fails, the not-installed page when the skill
 * isn't installed, and with `requireReady`
 * the not-ready notice until it can launch. Pages that only read existing
 * results gate on installed alone, so results stay readable while not ready.
 */
export function AssessGate({
  requireReady = false,
  className,
  children,
}: {
  requireReady?: boolean;
  /** Wrapper class for the gate's own states (e.g. page padding); children render unwrapped. */
  className?: string;
  children: ReactNode;
}) {
  const { installed, ready, loading, missing, error, refetch } = useAssessReady();
  let state: ReactNode = null;
  if (loading) state = <Skeleton className="h-24 w-full" />;
  else if (error) state = <AssessConfigError error={error} onRetry={refetch} />;
  else if (!installed) state = <AssessNotInstalled />;
  else if (requireReady && !ready) state = <AssessNotReady missing={missing} />;
  if (state === null) return <>{children}</>;
  return <div className={className}>{state}</div>;
}
