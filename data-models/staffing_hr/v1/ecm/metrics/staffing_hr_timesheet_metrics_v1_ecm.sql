-- Metric views for domain: timesheet | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core timesheet metrics tracking hours worked, billing, payroll, and approval performance across assignments and pay periods"
  source: "`staffing_hr_ecm`.`timesheet`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the timesheet (e.g., pending, approved, rejected)"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period for the timesheet"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period for the timesheet"
    - name: "pay_period_type"
      expr: pay_period_type
      comment: "Type of pay period (e.g., weekly, bi-weekly, semi-monthly)"
    - name: "worker_type"
      expr: worker_type
      comment: "Classification of worker (e.g., temporary, permanent, contractor)"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification of the worker (exempt vs non-exempt)"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the timesheet is under dispute"
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Flag indicating whether the timesheet was submitted after the deadline"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the timesheet was submitted"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when the timesheet was approved"
  measures:
    - name: "total_timesheets"
      expr: COUNT(1)
      comment: "Total number of timesheets submitted"
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all timesheets"
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours across all timesheets"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked (non-overtime)"
    - name: "total_overtime_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_doubletime_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total paid time off hours claimed"
    - name: "total_holiday_hours"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total holiday hours worked or paid"
    - name: "total_billing_amount"
      expr: SUM(CAST(billable_hours AS DOUBLE) * CAST(bill_rate AS DOUBLE))
      comment: "Total billing amount calculated from billable hours and bill rate"
    - name: "total_payroll_amount"
      expr: SUM(CAST(regular_hours AS DOUBLE) * CAST(pay_rate AS DOUBLE) + CAST(ot_hours AS DOUBLE) * CAST(ot_pay_rate AS DOUBLE))
      comment: "Total payroll amount calculated from regular and overtime hours with respective pay rates"
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem expenses claimed across timesheets"
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amounts claimed on timesheets"
    - name: "avg_hours_per_timesheet"
      expr: AVG(CAST(total_hours AS DOUBLE))
      comment: "Average total hours per timesheet"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across timesheets"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across timesheets"
    - name: "overtime_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(ot_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are overtime hours"
    - name: "billable_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(billable_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable to clients"
    - name: "disputed_timesheet_count"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of timesheets currently under dispute"
    - name: "late_submission_count"
      expr: SUM(CASE WHEN is_late_submission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of timesheets submitted after the deadline"
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_submission = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timesheets submitted late"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timesheets that are disputed"
    - name: "unique_assignments"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments represented in timesheets"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers who submitted timesheets"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with timesheet activity"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet approval workflow metrics tracking approval cycle time, SLA compliance, escalations, and approval efficiency"
  source: "`staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status in the workflow"
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current stage of the approval workflow"
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken in the approval workflow (e.g., approved, rejected, escalated)"
    - name: "approval_channel"
      expr: approval_channel
      comment: "Channel through which approval was submitted (e.g., web, mobile, email)"
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the person approving the timesheet"
    - name: "sla_compliant_flag"
      expr: sla_compliant_flag
      comment: "Flag indicating whether the approval met SLA requirements"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the timesheet is disputed"
    - name: "final_approved_flag"
      expr: final_approved_flag
      comment: "Flag indicating whether the timesheet received final approval"
    - name: "billing_released_flag"
      expr: billing_released_flag
      comment: "Flag indicating whether billing has been released"
    - name: "payroll_released_flag"
      expr: payroll_released_flag
      comment: "Flag indicating whether payroll has been released"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when the timesheet was submitted for approval"
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_timestamp)
      comment: "Month when the approval action was taken"
  measures:
    - name: "total_approval_workflows"
      expr: COUNT(1)
      comment: "Total number of approval workflow instances"
    - name: "total_regular_hours_approved"
      expr: SUM(CAST(total_regular_hours AS DOUBLE))
      comment: "Total regular hours approved through workflow"
    - name: "total_overtime_hours_approved"
      expr: SUM(CAST(total_ot_hours AS DOUBLE))
      comment: "Total overtime hours approved through workflow"
    - name: "total_doubletime_hours_approved"
      expr: SUM(CAST(total_dt_hours AS DOUBLE))
      comment: "Total double-time hours approved through workflow"
    - name: "total_per_diem_approved"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem amount approved through workflow"
    - name: "sla_compliant_count"
      expr: SUM(CASE WHEN sla_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of approvals that met SLA requirements"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of approvals that breached SLA requirements"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals that met SLA requirements"
    - name: "final_approved_count"
      expr: SUM(CASE WHEN final_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of timesheets that received final approval"
    - name: "disputed_workflow_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workflows with disputes"
    - name: "billing_released_count"
      expr: SUM(CASE WHEN billing_released_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workflows where billing has been released"
    - name: "payroll_released_count"
      expr: SUM(CASE WHEN payroll_released_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workflows where payroll has been released"
    - name: "avg_resubmission_count"
      expr: AVG(CAST(resubmission_count AS DOUBLE))
      comment: "Average number of resubmissions per timesheet approval workflow"
    - name: "unique_approvers"
      expr: COUNT(DISTINCT staff_profile_id)
      comment: "Number of unique staff members who approved timesheets"
    - name: "unique_workers_in_workflow"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers whose timesheets went through approval workflow"
    - name: "approval_efficiency_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN final_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows that resulted in final approval"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet adjustment metrics tracking billing and payroll corrections, adjustment reasons, and financial impact of changes"
  source: "`staffing_hr_ecm`.`timesheet`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., hours correction, rate correction, billing adjustment)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, approved, applied)"
    - name: "reason_code"
      expr: reason_code
      comment: "Code indicating the reason for the adjustment"
    - name: "affects_billing"
      expr: affects_billing
      comment: "Flag indicating whether the adjustment affects client billing"
    - name: "affects_payroll"
      expr: affects_payroll
      comment: "Flag indicating whether the adjustment affects worker payroll"
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag indicating whether the adjustment is retroactive to a prior period"
    - name: "client_approved"
      expr: client_approved
      comment: "Flag indicating whether the client approved the adjustment"
    - name: "approval_level"
      expr: approval_level
      comment: "Level of approval required or obtained for the adjustment"
    - name: "requestor_role"
      expr: requestor_role
      comment: "Role of the person who requested the adjustment"
    - name: "work_date"
      expr: work_date
      comment: "Date of the work being adjusted"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the adjustment was submitted"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when the adjustment was approved"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of timesheet adjustments"
    - name: "total_hours_adjusted"
      expr: SUM(CAST(hours_adjusted AS DOUBLE))
      comment: "Total hours after adjustment"
    - name: "total_hours_original"
      expr: SUM(CAST(hours_original AS DOUBLE))
      comment: "Total hours before adjustment"
    - name: "net_hours_change"
      expr: SUM(CAST(hours_adjusted AS DOUBLE) - CAST(hours_original AS DOUBLE))
      comment: "Net change in hours due to adjustments (adjusted minus original)"
    - name: "total_bill_amount_adjusted"
      expr: SUM(CAST(bill_amount_adjusted AS DOUBLE))
      comment: "Total billing amount after adjustment"
    - name: "total_bill_amount_original"
      expr: SUM(CAST(bill_amount_original AS DOUBLE))
      comment: "Total billing amount before adjustment"
    - name: "net_billing_impact"
      expr: SUM(CAST(bill_amount_adjusted AS DOUBLE) - CAST(bill_amount_original AS DOUBLE))
      comment: "Net financial impact on billing due to adjustments (adjusted minus original)"
    - name: "total_pay_amount_adjusted"
      expr: SUM(CAST(pay_amount_adjusted AS DOUBLE))
      comment: "Total payroll amount after adjustment"
    - name: "total_pay_amount_original"
      expr: SUM(CAST(pay_amount_original AS DOUBLE))
      comment: "Total payroll amount before adjustment"
    - name: "net_payroll_impact"
      expr: SUM(CAST(pay_amount_adjusted AS DOUBLE) - CAST(pay_amount_original AS DOUBLE))
      comment: "Net financial impact on payroll due to adjustments (adjusted minus original)"
    - name: "billing_adjustments_count"
      expr: SUM(CASE WHEN affects_billing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments that affect client billing"
    - name: "payroll_adjustments_count"
      expr: SUM(CASE WHEN affects_payroll = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments that affect worker payroll"
    - name: "retroactive_adjustments_count"
      expr: SUM(CASE WHEN is_retroactive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments that are retroactive to prior periods"
    - name: "client_approved_adjustments_count"
      expr: SUM(CASE WHEN client_approved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments approved by the client"
    - name: "avg_bill_rate_change"
      expr: AVG(CAST(bill_rate_adjusted AS DOUBLE) - CAST(bill_rate_original AS DOUBLE))
      comment: "Average change in bill rate due to adjustments"
    - name: "avg_pay_rate_change"
      expr: AVG(CAST(pay_rate_adjusted AS DOUBLE) - CAST(pay_rate_original AS DOUBLE))
      comment: "Average change in pay rate due to adjustments"
    - name: "unique_assignments_adjusted"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with adjustments"
    - name: "unique_workers_adjusted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with timesheet adjustments"
    - name: "unique_clients_adjusted"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with timesheet adjustments"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence and leave metrics tracking absence hours, FMLA usage, PTO consumption, and absence approval performance"
  source: "`staffing_hr_ecm`.`timesheet`.`absence_record`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (e.g., sick leave, vacation, FMLA, unpaid leave)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the absence record"
    - name: "is_paid"
      expr: is_paid
      comment: "Flag indicating whether the absence is paid"
    - name: "fmla_qualifying"
      expr: fmla_qualifying
      comment: "Flag indicating whether the absence qualifies under FMLA"
    - name: "client_notified"
      expr: client_notified
      comment: "Flag indicating whether the client was notified of the absence"
    - name: "documentation_received"
      expr: documentation_received
      comment: "Flag indicating whether required documentation was received"
    - name: "payroll_processed"
      expr: payroll_processed
      comment: "Flag indicating whether payroll has been processed for the absence"
    - name: "replacement_requested"
      expr: replacement_requested
      comment: "Flag indicating whether a replacement worker was requested"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether the absence processing breached SLA"
    - name: "unexcused_flag"
      expr: unexcused_flag
      comment: "Flag indicating whether the absence is unexcused"
    - name: "termination_trigger"
      expr: termination_trigger
      comment: "Flag indicating whether the absence triggered termination procedures"
    - name: "absence_start_month"
      expr: DATE_TRUNC('MONTH', absence_start_date)
      comment: "Month when the absence started"
  measures:
    - name: "total_absence_records"
      expr: COUNT(1)
      comment: "Total number of absence records"
    - name: "total_absence_hours"
      expr: SUM(CAST(absence_hours AS DOUBLE))
      comment: "Total hours of absence across all records"
    - name: "total_absence_days"
      expr: SUM(CAST(absence_duration_days AS DOUBLE))
      comment: "Total days of absence across all records"
    - name: "total_fmla_hours"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours used across all absence records"
    - name: "total_pto_hours_consumed"
      expr: SUM(CAST(pto_hours_consumed AS DOUBLE))
      comment: "Total PTO hours consumed due to absences"
    - name: "total_scheduled_hours_lost"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours lost due to absences"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(absence_duration_days AS DOUBLE))
      comment: "Average duration of absences in days"
    - name: "avg_absence_hours"
      expr: AVG(CAST(absence_hours AS DOUBLE))
      comment: "Average hours per absence record"
    - name: "fmla_qualifying_count"
      expr: SUM(CASE WHEN fmla_qualifying = TRUE THEN 1 ELSE 0 END)
      comment: "Count of absences that qualify under FMLA"
    - name: "paid_absence_count"
      expr: SUM(CASE WHEN is_paid = TRUE THEN 1 ELSE 0 END)
      comment: "Count of paid absences"
    - name: "unpaid_absence_count"
      expr: SUM(CASE WHEN is_paid = FALSE THEN 1 ELSE 0 END)
      comment: "Count of unpaid absences"
    - name: "unexcused_absence_count"
      expr: SUM(CASE WHEN unexcused_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of unexcused absences"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of absence records that breached SLA"
    - name: "termination_trigger_count"
      expr: SUM(CASE WHEN termination_trigger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of absences that triggered termination procedures"
    - name: "replacement_requested_count"
      expr: SUM(CASE WHEN replacement_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Count of absences where replacement worker was requested"
    - name: "documentation_received_count"
      expr: SUM(CASE WHEN documentation_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of absences where required documentation was received"
    - name: "client_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN client_notified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of absences where client was notified"
    - name: "unexcused_absence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN unexcused_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of absences that are unexcused"
    - name: "unique_workers_with_absences"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with absence records"
    - name: "unique_assignments_with_absences"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with absence records"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet dispute metrics tracking dispute volume, resolution time, financial impact, and dispute outcomes"
  source: "`staffing_hr_ecm`.`timesheet`.`timesheet_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., hours dispute, rate dispute, billing dispute)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under review, resolved, escalated)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (e.g., approved, denied, partially approved)"
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party who initiated the dispute (e.g., worker, client, staffing agency)"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party determined to be responsible for the dispute"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the dispute was escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether dispute resolution breached SLA"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the dispute was submitted"
    - name: "disputed_work_date"
      expr: disputed_work_date
      comment: "Date of the work being disputed"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the dispute was submitted"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when the dispute was resolved"
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of timesheet disputes"
    - name: "total_disputed_hours"
      expr: SUM(CAST(disputed_hours AS DOUBLE))
      comment: "Total hours under dispute"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount under dispute"
    - name: "total_resolved_hours"
      expr: SUM(CAST(resolved_hours AS DOUBLE))
      comment: "Total hours resolved through dispute process"
    - name: "total_resolved_amount"
      expr: SUM(CAST(resolved_amount AS DOUBLE))
      comment: "Total financial amount resolved through dispute process"
    - name: "total_claimed_hours"
      expr: SUM(CAST(claimed_hours AS DOUBLE))
      comment: "Total hours claimed by the disputing party"
    - name: "total_recorded_hours"
      expr: SUM(CAST(recorded_hours AS DOUBLE))
      comment: "Total hours originally recorded in the timesheet"
    - name: "total_ot_hours_disputed"
      expr: SUM(CAST(ot_hours_disputed AS DOUBLE))
      comment: "Total overtime hours under dispute"
    - name: "total_dt_hours_disputed"
      expr: SUM(CAST(dt_hours_disputed AS DOUBLE))
      comment: "Total double-time hours under dispute"
    - name: "total_per_diem_disputed"
      expr: SUM(CAST(per_diem_amount_disputed AS DOUBLE))
      comment: "Total per diem amount under dispute"
    - name: "escalated_dispute_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputes that were escalated"
    - name: "sla_breach_dispute_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputes that breached resolution SLA"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that were escalated"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that breached resolution SLA"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average financial amount per dispute"
    - name: "avg_disputed_hours"
      expr: AVG(CAST(disputed_hours AS DOUBLE))
      comment: "Average hours per dispute"
    - name: "unique_workers_with_disputes"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with timesheet disputes"
    - name: "unique_assignments_with_disputes"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with timesheet disputes"
    - name: "unique_clients_with_disputes"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with timesheet disputes"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`timesheet_approved_hours_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved hours summary metrics tracking finalized billable and payable amounts, gross margin, and transmission status to billing and payroll systems"
  source: "`staffing_hr_ecm`.`timesheet`.`approved_hours_summary`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hours summary"
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating whether the hours summary is approved"
    - name: "is_amended"
      expr: is_amended
      comment: "Flag indicating whether the hours summary was amended after initial approval"
    - name: "billing_transmission_status"
      expr: billing_transmission_status
      comment: "Status of transmission to billing system"
    - name: "payroll_transmission_status"
      expr: payroll_transmission_status
      comment: "Status of transmission to payroll system"
    - name: "worker_type"
      expr: worker_type
      comment: "Classification of worker (e.g., temporary, permanent, contractor)"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status of the worker"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location (e.g., on-site, remote, hybrid)"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
  measures:
    - name: "total_approved_summaries"
      expr: COUNT(1)
      comment: "Total number of approved hours summaries"
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours approved across all summaries"
    - name: "total_regular_hours_approved"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours approved"
    - name: "total_overtime_hours_approved"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours approved"
    - name: "total_doubletime_hours_approved"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours approved"
    - name: "total_pto_hours_approved"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours approved"
    - name: "total_holiday_hours_approved"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total holiday hours approved"
    - name: "total_billable_amount"
      expr: SUM(CAST(total_billable_amount AS DOUBLE))
      comment: "Total billable amount approved for client invoicing"
    - name: "total_payable_amount"
      expr: SUM(CAST(total_payable_amount AS DOUBLE))
      comment: "Total payable amount approved for worker payroll"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin (billable minus payable) across approved summaries"
    - name: "total_per_diem_units"
      expr: SUM(CAST(per_diem_units AS DOUBLE))
      comment: "Total per diem units approved"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across approved summaries"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across approved summaries"
    - name: "avg_burden_rate_pct"
      expr: AVG(CAST(burden_rate_pct AS DOUBLE))
      comment: "Average burden rate percentage across approved summaries"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billable_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage (gross margin divided by billable amount)"
    - name: "amended_summaries_count"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of summaries that were amended after initial approval"
    - name: "unique_workers_approved"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with approved hours summaries"
    - name: "unique_assignments_approved"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with approved hours summaries"
    - name: "unique_clients_approved"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with approved hours summaries"
$$;
