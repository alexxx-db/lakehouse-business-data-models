import { createFileRoute } from "@tanstack/react-router";
import { AssessBoundary } from "@/components/assessment/assess-boundary";
import { BatchStatus } from "@/components/assessment/batch-status";

export const Route = createFileRoute("/_sidebar/businesses/$businessId/assessments/$batchId")({
  component: () => {
    const { businessId, batchId } = Route.useParams();
    return (
      <AssessBoundary>
        <BatchStatus businessId={businessId} batchId={batchId} />
      </AssessBoundary>
    );
  },
});
