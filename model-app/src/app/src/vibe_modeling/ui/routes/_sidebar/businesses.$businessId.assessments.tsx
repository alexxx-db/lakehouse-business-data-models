import { createFileRoute, Outlet } from "@tanstack/react-router";
import { AssessGate } from "@/components/assessment/assess-gate";

export const Route = createFileRoute("/_sidebar/businesses/$businessId/assessments")({
  component: () => (
    <AssessGate className="p-6">
      <Outlet />
    </AssessGate>
  ),
});
