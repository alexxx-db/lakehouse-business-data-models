import { createFileRoute, Outlet, useParams } from "@tanstack/react-router";
import {
  useRecordVisit,
  versionPlaceValue,
  versionVisitKey,
} from "@/components/home/recent-items";

/**
 * Outlet route for `(version, scope)` model pages. The `$scope` segment is
 * passed through to children via `Route.useParams()`. Validation against
 * the {ecm, mvm} set happens at the leaf components rather than here so a
 * stale link surfaces a useful error message in the page rather than a
 * router-level catch.
 *
 * Also records the version visit for the home "Jump back in" list. The value
 * is the last place visited inside the version: the domain when a domain page
 * (or one of its products) is open, else the version overview (also for the
 * inputs pages). Moving between products of one domain keeps the same value,
 * so it does not rewrite.
 */
function ModelScopeLayout() {
  const { businessId, version, scope } = Route.useParams();
  const { domainName } = useParams({ strict: false }) as { domainName?: string };
  useRecordVisit(
    versionVisitKey(businessId, version, scope),
    versionPlaceValue(domainName),
  );
  return <Outlet />;
}

export const Route = createFileRoute(
  "/_sidebar/businesses/$businessId/model/$version/$scope"
)({
  component: ModelScopeLayout,
});
