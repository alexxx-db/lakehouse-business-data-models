/** Step 2 guidance: the modeling agent's naming rules, so users (and the checks on each card) are not a surprise. */
export function NamingRulesPanel() {
  return (
    <details open data-testid="naming-rules" className="rounded-md border bg-muted/30 px-3 py-2 text-xs">
      <summary className="cursor-pointer text-sm font-medium">Naming rules (from the modeling agent)</summary>
      <ul className="mt-2 list-disc space-y-1 pl-5 text-muted-foreground">
        <li>
          <span className="font-medium text-foreground">Domains:</span> one lowercase word, singular, up to 20 characters
          {" "}— e.g. <code>customer</code>, <code>billing</code>, <code>fieldservice</code>. Name a real department
          (&quot;would you find it on the org chart?&quot;), never a catch-all such as analytics, data, system, shared,
          common or services. The display name can stay friendly; the schema name is what the agent uses.
        </li>
        <li>
          <span className="font-medium text-foreground">Sub-domains:</span> exactly two words in business language, e.g.
          &quot;Meter Reading&quot;. No two sub-domains in a domain share a word, every name is unique across the model,
          and each domain gets at least two.
        </li>
        <li>
          <span className="font-medium text-foreground">The model:</span> at least 3 domains; mostly Operations and
          Business, with Corporate kept to about a fifth.
        </li>
      </ul>
    </details>
  );
}
