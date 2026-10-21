import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";
import { STRUCTURE_CLASS, STRUCTURE_LABEL } from "@/lib/assessment";

/**
 * Structure chip (Sound green, Review amber, Rework red; the label is always shown) followed by the
 * decision / vibe refs that drove it. A ref is a button when onJump is supplied.
 */
export function StructureBadge({
  structure,
  refs,
  onJump,
}: {
  structure?: string | null;
  refs?: string[] | null;
  onJump?: (ref: string) => void;
}) {
  if (!structure) return <span className="text-muted-foreground">—</span>;
  return (
    <span className="inline-flex flex-wrap items-center gap-1">
      <Badge variant="outline" className={cn("font-semibold", STRUCTURE_CLASS[structure])}>
        {STRUCTURE_LABEL[structure] ?? structure}
      </Badge>
      {(refs ?? []).map((r) =>
        onJump ? (
          <button
            key={r}
            type="button"
            aria-label={`Go to ${r}`}
            className="text-xs font-medium text-primary hover:underline"
            onClick={(ev) => {
              ev.stopPropagation();
              onJump(r);
            }}
          >
            {r}
          </button>
        ) : (
          <span key={r} className="text-xs text-muted-foreground">{r}</span>
        ),
      )}
    </span>
  );
}
