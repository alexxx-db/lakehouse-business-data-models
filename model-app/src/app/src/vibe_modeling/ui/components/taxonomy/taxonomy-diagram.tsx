import { memo } from "react";
import type { TaxonomyIssue, TaxonomyTree } from "@/lib/api";
import { DomainCard, domainProblems, domainWarnings } from "./domain-card";

type Props = {
  tree: TaxonomyTree;
  onOpen?: (i: number) => void;
  /** Server compile issues for exactly this tree (attributed per card by `domains`). */
  issues?: TaxonomyIssue[];
};

/** Responsive grid of domain cards. Pass `onOpen` to make the cards clickable (opens the edit dialog). */
export const TaxonomyDiagram = memo(function TaxonomyDiagram({ tree, onOpen, issues = [] }: Props) {
  if (tree.domains.length === 0) {
    return <div className="rounded-md border border-dashed p-8 text-center text-sm text-muted-foreground">Add a domain to see the diagram.</div>;
  }
  return (
    <div className="grid grid-cols-[repeat(auto-fill,minmax(14rem,1fr))] items-start gap-3" data-testid="taxonomy-diagram">
      {tree.domains.map((d, i) => (
        <DomainCard key={i} domain={d} index={i} onOpen={onOpen} hasError={domainProblems(tree, i, issues).length > 0} hasWarning={domainWarnings(issues, i).length > 0} />
      ))}
    </div>
  );
});
