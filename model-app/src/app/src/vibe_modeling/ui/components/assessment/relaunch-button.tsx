import { Button } from "@/components/ui/button";
import type { AssessBatchOut } from "@/lib/api";
import { isRelaunchable, useAssessReady } from "@/lib/assessment";
import { AdminHelpBlock } from "./admin-help-block";
import { ReadinessPanel } from "./readiness-panel";
import { useRelaunch } from "./use-relaunch";

/**
 * List-row "Relaunch" for a batch with any failed / cancelled / results-invalid run (default selection).
 * Hidden unless the skill is ready to launch (`useAssessReady`). A refused or failed relaunch shows
 * its readiness checks or admin-help block inline under the button.
 */
export function RelaunchButton({ businessId, batch }: { businessId: string; batch: AssessBatchOut }) {
  const { relaunch, pending, blocked, help } = useRelaunch(businessId, batch.id);
  const { ready } = useAssessReady();
  if (!ready || !batch.domain_runs.some((r) => isRelaunchable(r.status))) return null;
  return (
    <div className="space-y-2">
      <Button variant="outline" size="sm" onClick={() => relaunch()} disabled={pending}>
        Relaunch
      </Button>
      {blocked && (
        <div className="space-y-2">
          <p className="text-sm text-destructive">{blocked.message}</p>
          <ReadinessPanel readiness={blocked.readiness} />
        </div>
      )}
      {help && <AdminHelpBlock help={help} testId={`relaunch-admin-help-${batch.id}`} live />}
    </div>
  );
}
