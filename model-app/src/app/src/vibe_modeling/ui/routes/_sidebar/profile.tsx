import { createFileRoute, Link } from "@tanstack/react-router";
import { Suspense } from "react";
import { QueryErrorResetBoundary } from "@tanstack/react-query";
import { ErrorBoundary } from "react-error-boundary";
import { useCurrentUserSuspense } from "@/lib/api";
import selector from "@/lib/selector";
import { userInitials } from "@/lib/utils";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Skeleton } from "@/components/ui/skeleton";
import { Separator } from "@/components/ui/separator";
import { Mail, AlertCircle } from "lucide-react";

export const Route = createFileRoute("/_sidebar/profile")({
  component: () => <Profile />,
});

function ProfileContent() {
  const { data: user } = useCurrentUserSuspense(selector());

  return (
    <div className="space-y-6">
      {/* Header Card */}
      <Card className="border-primary/20">
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row items-center gap-6">
            <Avatar className="h-24 w-24">
              <AvatarFallback className="text-2xl font-semibold tracking-tight bg-primary/10">
                {userInitials(user.display_name)}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1 text-center md:text-left space-y-2">
              <h1 className="text-2xl font-semibold tracking-tight">
                {user.display_name}
              </h1>
              <p className="text-muted-foreground">{user.user_name}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Contact Information */}
      <div className="grid gap-6 md:grid-cols-2">
        <Card className="border-primary/20">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Mail className="h-5 w-5" />
              Contact Information
            </CardTitle>
            <CardDescription>Email addresses</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {user.emails.length > 0 ? (
              user.emails.map((email, index) => (
                <div key={email.value}>
                  {index > 0 && <Separator className="mb-4" />}
                  <p className="text-sm break-all">{email.value}</p>
                </div>
              ))
            ) : (
              <p className="text-sm text-muted-foreground">
                No email addresses available
              </p>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

function ProfileSkeleton() {
  return (
    <div className="space-y-6">
      {/* Header Card Skeleton */}
      <Card className="border-primary/20">
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row items-center gap-6">
            <Skeleton className="h-24 w-24 rounded-full" />
            <div className="flex-1 space-y-2 text-center md:text-left">
              <Skeleton className="h-8 w-48 mx-auto md:mx-0" />
              <Skeleton className="h-4 w-32 mx-auto md:mx-0" />
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Contact Card Skeleton */}
      <div className="grid gap-6 md:grid-cols-2">
        <Card className="border-primary/20">
          <CardHeader>
            <Skeleton className="h-6 w-48" />
            <Skeleton className="h-4 w-32" />
          </CardHeader>
          <CardContent className="space-y-2">
            <Skeleton className="h-4 w-full" />
            <Skeleton className="h-4 w-3/4" />
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

function Profile() {
  return (
    <QueryErrorResetBoundary>
      {({ reset }) => (
        <ErrorBoundary
          onReset={reset}
          fallbackRender={({ resetErrorBoundary }) => (
            <Card className="border-destructive/50">
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-destructive">
                  <AlertCircle className="h-5 w-5" />
                  Failed to Load Profile
                </CardTitle>
                <CardDescription>
                  There was an error loading your profile information. Make sure
                  the backend is running and you're authenticated.
                </CardDescription>
              </CardHeader>
              <CardContent className="flex gap-2">
                <Button variant="outline" onClick={resetErrorBoundary}>
                  Try Again
                </Button>
                <Button variant="outline" asChild>
                  <Link to="/">Go Home</Link>
                </Button>
              </CardContent>
            </Card>
          )}
        >
          <Suspense fallback={<ProfileSkeleton />}>
            <ProfileContent />
          </Suspense>
        </ErrorBoundary>
      )}
    </QueryErrorResetBoundary>
  );
}
