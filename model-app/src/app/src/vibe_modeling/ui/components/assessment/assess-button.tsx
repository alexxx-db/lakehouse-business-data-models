import { Link } from "@tanstack/react-router";
import { ClipboardCheck } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useAssessReady } from "@/lib/assessment";

const NOT_INSTALLED_HINT = "Install this version into a catalog to assess it";

/**
 * Entry point into the assessment wizard from a model version / domain page.
 * Hidden unless the optional assessment skill is ready (`useAssessReady`).
 * Disabled until the version is installed (deployed with a catalog), since the
 * assessment reads the installed tables.
 */
export function AssessButton({
  businessId,
  versionId,
  domainId,
  installed,
}: {
  businessId: string;
  versionId: string;
  domainId?: string;
  installed: boolean;
}) {
  const { ready } = useAssessReady();
  if (!ready) return null;
  if (!installed) {
    return (
      <span title={NOT_INSTALLED_HINT} className="inline-flex">
        <Button variant="outline" size="sm" disabled>
          <ClipboardCheck className="mr-1.5 h-4 w-4" />
          Assess
        </Button>
      </span>
    );
  }
  return (
    <Button variant="outline" size="sm" asChild>
      <Link
        to="/businesses/$businessId/assessments/new"
        params={{ businessId }}
        search={{ versionId, domainId }}
      >
        <ClipboardCheck className="mr-1.5 h-4 w-4" />
        Assess
      </Link>
    </Button>
  );
}
