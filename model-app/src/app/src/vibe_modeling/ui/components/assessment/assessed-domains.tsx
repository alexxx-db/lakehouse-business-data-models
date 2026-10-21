/** Displays domain names assessed in a batch, with truncation and hover tooltip. */
export function AssessedDomains({ names }: { names: string[] }) {
  // Remove duplicates while preserving order, skip empty names
  const unique = Array.from(new Set(names.filter((n) => n)));

  if (unique.length === 0) {
    return <span className="text-muted-foreground">—</span>;
  }

  const displayed = unique.slice(0, 3);
  const extra = unique.length - displayed.length;
  const allNames = unique.join(", ");

  return (
    <div title={unique.length > 3 ? allNames : undefined}>
      {displayed.join(", ")}
      {extra > 0 && <span className="text-muted-foreground"> +{extra} more</span>}
    </div>
  );
}
