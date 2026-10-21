/**
 * The one admin-help block every assessment failure path renders: what it
 * shows, the exact text its Copy button copies, and the run → help mapping.
 */
import { beforeEach, describe, expect, it, vi } from "vitest";
import { fireEvent, render, screen, waitFor, within } from "@testing-library/react";

const { toastSuccess } = vi.hoisted(() => ({ toastSuccess: vi.fn() }));
vi.mock("sonner", () => ({ toast: { success: toastSuccess, error: vi.fn() } }));

import { AdminHelpBlock } from "@/components/assessment/admin-help-block";
import { ADMIN_HELP_CONTACT, ADMIN_HELP_LEAD, ADMIN_HELP_LEAD_CHECK, adminHelpText, runAdminHelp } from "@/lib/assessment";
import type { AssessDomainRunOut } from "@/lib/api";

const full = {
  message: "Hand-off failed: PERMISSION_DENIED on /Workspace/Users/a@b.com",
  job_url: "https://ws/jobs/7?o=1",
  run_url: "https://ws/jobs/7/runs/9?o=1",
  job_reader: "reader-app-id",
  runs_path: "/Volumes/cat/_metamodel/assess_runs/b1/d1",
};

let writeText: ReturnType<typeof vi.fn>;
beforeEach(() => {
  toastSuccess.mockClear();
  writeText = vi.fn().mockResolvedValue(undefined);
  Object.defineProperty(navigator, "clipboard", { value: { writeText }, configurable: true });
});

describe("AdminHelpBlock", () => {
  it("shows the lead, the error, both links, the reader and the runs folder", () => {
    render(<AdminHelpBlock help={full} testId="admin-help-block" />);
    const block = within(screen.getByTestId("admin-help-block"));
    expect(block.getByText(`${ADMIN_HELP_LEAD} ${ADMIN_HELP_CONTACT}`)).toBeInTheDocument();
    expect(ADMIN_HELP_CONTACT).toBe("Please contact your administrator with these details.");
    expect(block.getByText(full.message)).toBeInTheDocument();
    expect(block.getByRole("link", { name: /^open job$/i })).toHaveAttribute("href", full.job_url);
    expect(block.getByRole("link", { name: /open job run/i })).toHaveAttribute("href", full.run_url);
    expect(block.getByText("Ran as")).toBeInTheDocument();
    expect(block.getByText("reader-app-id")).toBeInTheDocument();
    expect(block.getByText(full.runs_path)).toBeInTheDocument();
    expect(screen.queryByRole("alert")).toBeNull();
  });

  it("is an alert only when live", () => {
    render(<AdminHelpBlock help={full} testId="launch-admin-help" live />);
    expect(screen.getByRole("alert")).toBe(screen.getByTestId("launch-admin-help"));
  });

  it("uses a custom lead on screen and in the copied text", async () => {
    render(<AdminHelpBlock help={{ message: "m" }} testId="t" lead={ADMIN_HELP_LEAD_CHECK} />);
    expect(screen.getByText(`${ADMIN_HELP_LEAD_CHECK} ${ADMIN_HELP_CONTACT}`)).toBeInTheDocument();
    fireEvent.click(screen.getByRole("button", { name: /copy details/i }));
    await waitFor(() => expect(writeText).toHaveBeenCalledWith(`${ADMIN_HELP_LEAD_CHECK} ${ADMIN_HELP_CONTACT}\nm`));
  });

  it("copies every detail as plain text, in a fixed order", async () => {
    render(<AdminHelpBlock help={full} testId="admin-help-block" />);
    fireEvent.click(screen.getByRole("button", { name: /copy details/i }));
    await waitFor(() => expect(writeText).toHaveBeenCalledTimes(1));
    expect(writeText.mock.calls[0][0]).toBe(
      [
        "This assessment step failed. Please contact your administrator with these details.",
        "Hand-off failed: PERMISSION_DENIED on /Workspace/Users/a@b.com",
        "Job: https://ws/jobs/7?o=1",
        "Job run: https://ws/jobs/7/runs/9?o=1",
        "Ran as: reader-app-id",
        "Files: /Volumes/cat/_metamodel/assess_runs/b1/d1",
      ].join("\n"),
    );
    await waitFor(() => expect(toastSuccess).toHaveBeenCalledWith("Copied to clipboard"));
  });

  it("leaves out the details it doesn't have", () => {
    render(<AdminHelpBlock help={{ message: "Couldn't add the next vibes to feedback" }} testId="admin-help-block" />);
    const block = within(screen.getByTestId("admin-help-block"));
    expect(block.queryByRole("link")).toBeNull();
    expect(block.queryByText("Ran as")).toBeNull();
    expect(block.queryByText("Files")).toBeNull();
    expect(adminHelpText({ message: "m" })).toBe(`${ADMIN_HELP_LEAD} ${ADMIN_HELP_CONTACT}\nm`);
  });

  it("lists not-ready reasons and copies them", () => {
    const help = { message: "Assessment isn't ready", not_ready: ["No reader service principal", "Job sync failed: x"] };
    render(<AdminHelpBlock help={help} testId="admin-help-block" />);
    expect(screen.getByText("No reader service principal")).toBeInTheDocument();
    expect(adminHelpText(help)).toBe(
      `${ADMIN_HELP_LEAD} ${ADMIN_HELP_CONTACT}\nAssessment isn't ready\n- No reader service principal\n- Job sync failed: x`,
    );
  });

  it("honours a custom test id", () => {
    render(<AdminHelpBlock help={{ message: "m" }} testId="launch-admin-help" />);
    expect(screen.getByTestId("launch-admin-help")).toBeInTheDocument();
  });
});

describe("runAdminHelp", () => {
  const run = (over: Partial<AssessDomainRunOut>) =>
    ({ status: "failed", error_message: "", last_message: "Mapping entities", run_url: "", job_url: "", job_reader: "", ...over }) as AssessDomainRunOut;

  it("maps the run's error, links and reader", () => {
    expect(
      runAdminHelp(run({ error_message: "boom", run_url: "https://ws/r", job_url: "https://ws/j", job_reader: "rdr" })),
    ).toEqual({ message: "boom", run_url: "https://ws/r", job_url: "https://ws/j", job_reader: "rdr" });
  });

  it("never passes off a progress message as the error", () => {
    expect(runAdminHelp(run({})).message).toBe("The assessment run failed.");
    expect(runAdminHelp(run({ status: "results_invalid" })).message).toBe("The assessment results could not be saved.");
  });

  it("drops empty links so the block omits them", () => {
    const help = runAdminHelp(run({ error_message: "boom" }));
    expect(help.job_url).toBeUndefined();
    expect(help.run_url).toBeUndefined();
    expect(help.job_reader).toBeUndefined();
  });
});
