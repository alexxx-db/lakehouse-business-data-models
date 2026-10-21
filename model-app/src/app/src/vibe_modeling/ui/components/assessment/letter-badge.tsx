import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

export const LETTER_CLASS: Record<string, string> = {
  A: "bg-green-100 text-green-800 border-green-300",
  B: "bg-teal-100 text-teal-800 border-teal-300",
  C: "bg-amber-100 text-amber-800 border-amber-300",
  D: "bg-orange-100 text-orange-800 border-orange-300",
  F: "bg-red-100 text-red-800 border-red-300",
};

const GATE_LABEL: Record<string, string> = { full: "Full", partial: "Partial", blocked: "Blocked" };

/** Letter-grade chip (A green … F red); with no letter it shows the gate label only. */
export function LetterBadge({ letter, gate }: { letter: string | null; gate: string }) {
  if (!letter) return <Badge variant="outline">{GATE_LABEL[gate] ?? gate}</Badge>;
  return (
    <Badge variant="outline" className={cn("font-semibold", LETTER_CLASS[letter])}>
      {letter}
    </Badge>
  );
}
