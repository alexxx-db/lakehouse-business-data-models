import { ASSESS_MODEL, useAssessReady } from "@/lib/assessment";
import { Link } from "@tanstack/react-router";
import { Construction } from "lucide-react";
import { HelpPage } from "@/components/help/help-page";
import { WorkflowDiagram } from "@/components/flow/workflow-diagram";
import { getHelpTopic } from "@/components/help/help-topics";

/** A single key cap, styled as a physical key. */
export function Kbd({ children }: { children: React.ReactNode }) {
  return (
    <kbd className="inline-flex h-6 min-w-[1.5rem] items-center justify-center rounded-sm border border-border bg-muted px-1.5 text-xs font-medium text-foreground">
      {children}
    </kbd>
  );
}

interface Shortcut {
  keys: string[];
  /** Rendered between key caps (e.g. "then", "+"). Defaults to "+". */
  joiner?: string;
  description: string;
}

interface ShortcutGroup {
  heading: string;
  note?: string;
  shortcuts: Shortcut[];
}

/** The app's real shortcuts, verbatim from the help-system brief. */
const SHORTCUT_GROUPS: ShortcutGroup[] = [
  {
    heading: "Global",
    shortcuts: [
      { keys: ["⌘ / Ctrl", "K"], description: "Open model search (jump to any domain, product, or attribute)" },
      { keys: ["⌘ / Ctrl", "B"], description: "Toggle the sidebar" },
      { keys: ["f"], description: "Add feedback / vibe input (when viewing a model)" },
    ],
  },
  {
    heading: "Editing (in an input or comment box)",
    shortcuts: [
      { keys: ["⌘ / Ctrl", "Enter"], description: "Save / submit" },
      { keys: ["Esc"], description: "Cancel / close the dialog" },
    ],
  },
];

function ShortcutRow({ shortcut }: { shortcut: Shortcut }) {
  const joiner = shortcut.joiner ?? "+";
  return (
    <div className="flex items-baseline justify-between gap-4 border-b border-border py-2 last:border-b-0">
      <span className="text-sm text-muted-foreground">{shortcut.description}</span>
      <span className="flex shrink-0 items-center gap-1">
        {shortcut.keys.map((k, i) => (
          <span key={i} className="flex items-center gap-1">
            {i > 0 && <span className="text-xs text-muted-foreground">{joiner}</span>}
            <Kbd>{k}</Kbd>
          </span>
        ))}
      </span>
    </div>
  );
}

export function ShortcutsContent() {
  return (
    <HelpPage
      title="Keyboard shortcuts"
      intro="Move faster with the keyboard. Shortcuts are context-sensitive — some only fire in a particular view."
      related={["flow"]}
    >
      <div className="space-y-8">
        {SHORTCUT_GROUPS.map((group) => (
          <section key={group.heading}>
            <h2 className="mb-1 text-sm font-semibold">{group.heading}</h2>
            {group.note && (
              <p className="mb-2 text-xs text-muted-foreground">{group.note}</p>
            )}
            <div className="rounded-sm border border-border px-3">
              {group.shortcuts.map((s, i) => (
                <ShortcutRow key={i} shortcut={s} />
              ))}
            </div>
          </section>
        ))}
        <p className="text-xs text-muted-foreground">
          Shortcuts are context-sensitive: <Kbd>f</Kbd> only fires while viewing a
          model, not while you are typing in an input or comment box.
        </p>
      </div>
    </HelpPage>
  );
}

export function FlowContent() {
  const { ready: assessReady } = useAssessReady();
  return (
    <HelpPage
      title="How the modeling flow works"
      intro="You shape a data model by giving an AI agent feedback and re-running. Here's the loop, end to end."
      related={["shortcuts", "vibes"]}
    >
      <WorkflowDiagram variant="expanded" className="mt-2" assessment={assessReady} />
    </HelpPage>
  );
}

function Section({ heading, children }: { heading: string; children: React.ReactNode }) {
  return (
    <section className="space-y-2">
      <h2 className="text-base font-semibold">{heading}</h2>
      {children}
    </section>
  );
}

const P = "text-sm leading-relaxed text-muted-foreground";
const UL = "list-disc space-y-1 pl-5 text-sm leading-relaxed text-muted-foreground";
const OL = "list-decimal space-y-1 pl-5 text-sm leading-relaxed text-muted-foreground";

export function AssessmentContent() {
  return (
    <HelpPage
      title="Assessing a model against your data"
      intro="An assessment checks an installed model version against your bronze sources, so you can see what you can build now, what is missing, and what to ask your ingestion team for."
      related={["flow", "shortcuts"]}
    >
      <div className="space-y-8">
        <Section heading="What an assessment does">
          <p className={P}>
            It runs the <code>domain-model-assessment</code> skill headless with the Genie Code
            CLI inside a Databricks job - one job run per domain you select - as a dedicated
            read-only reader service principal. It only reads (SELECT and DESCRIBE); it never
            creates or writes tables. Any model edits it proposes are written as SQL into a
            document, not applied. For each domain it:
          </p>
          <ul className={UL}>
            <li>reads the installed model version's metamodel;</li>
            <li>
              profiles the bronze sources you mapped (row counts, null percentages, distinct
              counts, date formats, foreign-key orphans);
            </li>
            <li>maps every target column to a bronze source column by meaning, not by name;</li>
            <li>grades each entity Full, Partial or Blocked;</li>
            <li>writes a gap registry - the ingestion asks;</li>
            <li>
              records pending decisions: questions it would normally ask a person, where it takes
              the most conservative default and logs the question;
            </li>
            <li>suggests next vibes - model changes for your next modeling iteration.</li>
          </ul>
          <p className={P}>For hybrid output it also derives a gold layer.</p>
        </Section>

        <Section heading="Before you start">
          <ul className={UL}>
            <li>The model version is installed into a catalog.</li>
            <li>
              A workspace admin has set up the reader service principal in{" "}
              <Link to="/settings" search={{ tab: "assessment" }} className="text-primary hover:underline">
                Settings → Assessment
              </Link>
              , which has copy-paste steps.
            </li>
            <li>
              The reader has SELECT on the model catalog and SELECT on every bronze schema you
              map.
            </li>
            <li>The reader can use the SQL warehouse.</li>
            <li>
              The app's service principal has CREATE VOLUME on the deployment catalog's{" "}
              <code>_metamodel</code> schema, so Save can create the runs volume. The installer
              grants this.
            </li>
          </ul>
          <p className={P}>
            Launch is blocked if the reader cannot read the model catalog, any mapped bronze
            schema, or the SQL warehouse.
          </p>
        </Section>

        <Section heading="Running one">
          <ol className={OL}>
            <li>
              Click Assess on an installed model version or on a domain page.
            </li>
            <li>Pick the domains to assess.</li>
            <li>
              Map each bronze source to its <code>catalog.schema</code>. The mapping is saved for
              the business, so later assessments start pre-filled.
            </li>
            <li>Choose the output model, ETL type and reasoning effort.</li>
            <li>The readiness check must pass - it shows the exact GRANT for anything missing.</li>
            <li>Launch.</li>
          </ol>
        </Section>

        <Section heading="What you get">
          <ul className={UL}>
            <li>
              A grade per entity: Full (everything it needs is available in your sources),
              Partial (some columns have no usable source), Blocked (it cannot be built from
              what you have).
            </li>
            <li>Column mappings with the profile statistics behind them.</li>
            <li>A gap registry listing what is missing and what to ask for.</li>
            <li>Pending decisions you can answer in the app.</li>
            <li>
              Next vibes. These are shown read-only; you can add them as vibe inputs for your
              next modeling iteration yourself.
            </li>
            <li>The assessment's markdown documents.</li>
          </ul>
        </Section>

        <Section heading="After the assessment">
          <p className={P}>
            The assessment stops before the iteration loop and before it generates build hand-off
            documents, and it is read-only, so building happens in Genie Code. After you have
            answered the pending decisions, Hand off to Genie Code copies the project
            (conventions.yml, the docs and your decisions) to a workspace folder with copy-paste
            prompts, to run in order:
          </p>
          <ol className={OL}>
            <li>Continue the assessment (Phase 5 and Phase 6, using your decisions).</li>
            <li>
              Build, with <code>etl-development-framework</code>.
            </li>
            <li>
              Validate, with <code>domain-model-validation</code>.
            </li>
            <li>
              Document, with <code>domain-documentation</code>.
            </li>
          </ol>
        </Section>

        <Section heading="Time and cost">
          <p className={P}>
            Expect 30-60 minutes per domain. If the model hits rate limits it can take longer -
            the job waits and resumes automatically. Assessments use workspace foundation-model
            tokens. By default two domain runs go at once; an admin can change this in Settings →
            Assessment.
          </p>
          <p className={P}>
            Calls to {ASSESS_MODEL} count against your workspace's pay-per-token rate limit for that
            model - by default about 200K input and 20K output tokens per minute. All domain runs
            share that one limit, so raising the number of concurrent runs mostly makes them take
            turns rather than finish sooner. This is optional: assessments work on the default
            limit, but if you want them to run faster, ask your Databricks account team to request
            a higher rate limit for {ASSESS_MODEL} on this workspace.
          </p>
        </Section>
      </div>
    </HelpPage>
  );
}

/** Shared coming-soon body for topics that share the template but aren't
 *  written yet. Reads the topic's own title/description from the registry. */
export function ComingSoonContent({ slug }: { slug: string }) {
  const topic = getHelpTopic(slug);
  return (
    <HelpPage
      title={topic?.title ?? "Help"}
      intro={topic?.description}
      related={["flow", "shortcuts"]}
    >
      <div className="flex items-start gap-3 rounded-sm border border-dashed border-border bg-muted/40 p-4">
        <Construction className="mt-0.5 h-5 w-5 shrink-0 text-muted-foreground" />
        <div className="space-y-1">
          <p className="text-sm font-medium">This page is coming soon.</p>
          <p className="text-sm text-muted-foreground">
            We're still writing it. In the meantime,{" "}
            <Link to="/help/$topic" params={{ topic: "flow" }} className="text-primary hover:underline">
              How the modeling flow works
            </Link>{" "}
            covers the end-to-end loop, and the{" "}
            <Link to="/help" className="text-primary hover:underline">
              help index
            </Link>{" "}
            lists everything available today.
          </p>
        </div>
      </div>
    </HelpPage>
  );
}
