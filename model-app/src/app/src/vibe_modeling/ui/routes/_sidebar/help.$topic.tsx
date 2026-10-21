import { createFileRoute } from "@tanstack/react-router";
import {
  FlowContent,
  AssessmentContent,
  ShortcutsContent,
  ComingSoonContent,
} from "@/components/help/help-content";
import { getHelpTopic } from "@/components/help/help-topics";
import { HelpPage } from "@/components/help/help-page";
import { AssessGate } from "@/components/assessment/assess-gate";
import { useAssessReady } from "@/lib/assessment";

export const Route = createFileRoute("/_sidebar/help/$topic")({
  component: HelpTopicPage,
});

function HelpTopicPage() {
  const { topic } = Route.useParams();
  const { ready: assessReady } = useAssessReady();

  if (topic === "flow") return <FlowContent />;
  if (topic === "assessment") {
    // Like the help-index card: the page shows once the skill is ready; before that, why not.
    if (assessReady) return <AssessmentContent />;
    return (
      <HelpPage title="Assessing a model against your data" related={["flow", "shortcuts"]}>
        <AssessGate requireReady>{null}</AssessGate>
      </HelpPage>
    );
  }
  if (topic === "shortcuts") return <ShortcutsContent />;

  // Known-but-unwritten topics render the shared coming-soon template.
  if (getHelpTopic(topic)) return <ComingSoonContent slug={topic} />;

  // Unknown slug — keep the reading chrome, don't crash.
  return (
    <HelpPage title="Topic not found" related={["flow", "shortcuts"]}>
      <p className="text-sm text-muted-foreground">
        We couldn't find that help topic. It may have moved or been renamed.
      </p>
    </HelpPage>
  );
}
