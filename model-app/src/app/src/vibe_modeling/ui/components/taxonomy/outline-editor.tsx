import { useState } from "react";
import type { TaxonomyIssue } from "@/lib/api";
import { addDomain } from "@/lib/taxonomy/tree";
import { TaxonomyDiagram } from "./taxonomy-diagram";
import { DomainDialog } from "./domain-dialog";
import { AddRow, type Props } from "./domain-editor";
import { NamingRulesPanel } from "./naming-rules-panel";

/** Step 2 domains view: "Add domain" + responsive card grid; clicking a card opens the per-domain edit dialog.
 *  `issues` are the server compile's issues for exactly this tree; the cards and dialog attribute them. */
export function OutlineEditor({ tree, onChange, issues }: Props & { issues?: TaxonomyIssue[] }) {
  const [openIndex, setOpenIndex] = useState<number | null>(null);
  return (
    <div className="space-y-3">
      <NamingRulesPanel />
      <div className="max-w-sm"><AddRow placeholder="New domain" label="Add domain" onAdd={(v) => onChange(addDomain(tree, v))} /></div>
      <TaxonomyDiagram tree={tree} onOpen={setOpenIndex} issues={issues} />
      <DomainDialog tree={tree} index={openIndex} onIndexChange={setOpenIndex} onChange={onChange} issues={issues} />
    </div>
  );
}
