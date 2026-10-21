import { useId, useMemo, useState } from "react";
import { Check as CheckIcon, ChevronsUpDown, Plus as PlusIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Command, CommandEmpty, CommandInput, CommandItem, CommandList } from "@/components/ui/command";

export type FreeTextComboboxProps = {
  value: string;
  onChange: (v: string) => void;
  /** Options in display order (the caller sorts). */
  options: string[];
  loading?: boolean;
  /** Listing failed: render a plain text input so the field never blocks. */
  error?: boolean;
  disabled?: boolean;
  ariaLabel: string;
  /** Trigger text when nothing is chosen. */
  placeholder: string;
  searchPlaceholder: string;
  emptyText: string;
  loadingText: string;
  fallbackPlaceholder: string;
  /** Prefix for the fallback / loading / use-custom test ids. */
  testIdPrefix: string;
};

/**
 * A picker over a fetched list that also accepts a typed value. Filters the
 * list client-side, case-insensitively anywhere in the name (cmdk's own
 * filter was unreliable, #111), and offers "Use '<input>'" when the typed
 * text matches no option exactly. Falls back to a plain input when the
 * listing failed, so a broken list never blocks the field.
 *
 * Items sit directly under `CommandList` (no `CommandGroup`): inside a
 * portalled Radix popover Chrome attached grouped options to the inner group
 * instead of the listbox, leaving an "empty listbox" for keyboard and
 * screen-reader users (the model-versioning work F4).
 */
export function FreeTextCombobox({
  value,
  onChange,
  options,
  loading,
  error,
  disabled,
  ariaLabel,
  placeholder,
  searchPlaceholder,
  emptyText,
  loadingText,
  fallbackPlaceholder,
  testIdPrefix,
}: FreeTextComboboxProps) {
  const [open, setOpen] = useState(false);
  const [search, setSearch] = useState("");
  const reactId = useId();
  const triggerId = `${reactId}-${testIdPrefix}-trigger`;

  const trimmedSearch = search.trim();
  const searchLower = trimmedSearch.toLowerCase();

  const filtered = useMemo(() => {
    if (!trimmedSearch) return options;
    return options.filter((o) => o.toLowerCase().includes(searchLower));
  }, [options, searchLower, trimmedSearch]);

  const exactMatch = useMemo(
    () => Boolean(trimmedSearch) && options.some((o) => o.toLowerCase() === searchLower),
    [options, searchLower, trimmedSearch],
  );
  const showCustomOption = Boolean(trimmedSearch) && !exactMatch;

  if (error) {
    return (
      <Input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={fallbackPlaceholder}
        disabled={disabled}
        aria-label={ariaLabel}
        data-testid={`${testIdPrefix}-fallback-input`}
      />
    );
  }
  if (loading) {
    return (
      <Button
        type="button"
        variant="outline"
        disabled
        className="w-full justify-between font-normal"
        data-testid={`${testIdPrefix}-loading`}
      >
        <span className="text-muted-foreground">{loadingText}</span>
        <ChevronsUpDown className="h-4 w-4 opacity-50 shrink-0 ml-2" />
      </Button>
    );
  }

  const choose = (v: string) => {
    onChange(v);
    setOpen(false);
    setSearch("");
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          id={triggerId}
          type="button"
          variant="outline"
          role="combobox"
          aria-expanded={open}
          aria-haspopup="listbox"
          aria-label={ariaLabel}
          disabled={disabled}
          className="w-full justify-between font-normal"
        >
          <span className={value ? "" : "text-muted-foreground"}>{value || placeholder}</span>
          <ChevronsUpDown className="h-4 w-4 opacity-50 shrink-0 ml-2" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="p-0 w-[var(--radix-popover-trigger-width)]" align="start">
        <Command shouldFilter={false} label={ariaLabel}>
          <CommandInput placeholder={searchPlaceholder} value={search} onValueChange={setSearch} />
          <CommandList>
            {filtered.length === 0 && !showCustomOption && <CommandEmpty>{emptyText}</CommandEmpty>}
            {filtered.map((o) => (
              <CommandItem
                key={o}
                value={o}
                onSelect={() => choose(o)}
                className="flex items-center justify-between"
              >
                <span className="truncate">{o}</span>
                {value === o && <CheckIcon className="h-4 w-4 shrink-0 ml-2" />}
              </CommandItem>
            ))}
            {showCustomOption && (
              <CommandItem
                // Unique value so cmdk doesn't conflate it with a real option
                // when the typed text is a prefix of one.
                value={`__use_custom__::${trimmedSearch}`}
                onSelect={() => choose(trimmedSearch)}
                className="flex items-center gap-2"
                data-testid={`${testIdPrefix}-use-custom`}
              >
                <PlusIcon className="h-4 w-4 shrink-0" />
                <span className="truncate">Use &ldquo;{trimmedSearch}&rdquo;</span>
              </CommandItem>
            )}
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}
