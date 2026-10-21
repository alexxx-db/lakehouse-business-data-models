import { Link } from "@tanstack/react-router";
import {
  RECENT_KIND_META,
  type RecentItem,
} from "@/components/home/recent-items";
import { formatRelative } from "@/lib/date";

/** Renders the deep-link for a recent item. A `model_version` item reopens the
 *  last place visited inside the version: the remembered domain, else the
 *  version overview. `business` and `industry` items (both `businesses` rows)
 *  link to the business detail surface. */
function RecentItemLink({
  item,
  children,
  className,
}: {
  item: RecentItem;
  children: React.ReactNode;
  className?: string;
}) {
  if (item.kind === "model_version") {
    const version = String(item.version);
    if (item.domain) {
      return (
        <Link
          to="/businesses/$businessId/model/$version/$scope/$domainName"
          params={{
            businessId: item.businessId,
            version,
            scope: item.scope,
            domainName: item.domain,
          }}
          search={{ tab: "products" }}
          className={className}
        >
          {children}
        </Link>
      );
    }
    return (
      <Link
        to="/businesses/$businessId/model/$version/$scope"
        params={{ businessId: item.businessId, version, scope: item.scope }}
        search={{ tab: "overview" }}
        className={className}
      >
        {children}
      </Link>
    );
  }
  return (
    <Link
      to="/businesses/$businessId"
      params={{ businessId: item.businessId }}
      className={className}
    >
      {children}
    </Link>
  );
}

export function JumpBackInList({ items }: { items: RecentItem[] }) {
  return (
    <ul className="grid gap-2 sm:grid-cols-2">
      {items.map((item) => {
        const meta = RECENT_KIND_META[item.kind];
        return (
          <li key={item.key}>
            <RecentItemLink
              item={item}
              className="group flex items-center gap-3 rounded-md border border-border bg-card p-3 transition-colors hover:border-input hover:bg-accent"
            >
              <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-sm border border-border bg-muted text-muted-foreground">
                <meta.Icon className="h-4 w-4" />
              </span>
              <span className="min-w-0 flex-1">
                <span className="flex items-center gap-2">
                  <span className="truncate text-sm font-medium">{item.title}</span>
                  <span className="shrink-0 rounded-sm border border-border px-1.5 py-px text-[10px] font-medium uppercase tracking-wide text-muted-foreground">
                    {meta.label}
                  </span>
                </span>
                {item.subtitle && (
                  <span className="block truncate text-xs text-muted-foreground">
                    {item.subtitle}
                  </span>
                )}
              </span>
              <span className="shrink-0 text-xs text-muted-foreground">
                {formatRelative(item.timestamp)}
              </span>
            </RecentItemLink>
          </li>
        );
      })}
    </ul>
  );
}

export default JumpBackInList;
