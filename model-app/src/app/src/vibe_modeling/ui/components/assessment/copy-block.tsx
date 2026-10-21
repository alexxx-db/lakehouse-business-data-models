import { Copy } from "lucide-react";
import { Button } from "@/components/ui/button";
import { copyToClipboard } from "@/lib/notify";

/** A code/SQL snippet with a copy-to-clipboard button; shared by the readiness
 *  panel and the Settings → Assessment setup checklist. */
export function CopyBlock({ text, label = "Copy SQL" }: { text: string; label?: string }) {
  return (
    <div className="relative">
      <pre className="overflow-x-auto rounded-md border bg-muted/40 p-2 pr-10 text-xs">{text}</pre>
      <Button
        type="button"
        variant="ghost"
        size="icon"
        className="absolute right-1 top-1 h-6 w-6"
        aria-label={label}
        onClick={() => void copyToClipboard(text)}
      >
        <Copy className="h-3.5 w-3.5" />
      </Button>
    </div>
  );
}
