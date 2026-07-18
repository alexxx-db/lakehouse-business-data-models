-- Metric views for domain: matter | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core matter performance metrics tracking matter lifecycle, financial performance, and operational efficiency for legal engagements"
  source: "`legal_ecm`.`matter`.`matter`"
  dimensions:
    - name: "matter_status"
      expr: matter_status
      comment: "Current status of the matter (open, closed, pending, etc.)"
    - name: "matter_type"
      expr: matter_type
      comment: "Type classification of the matter (litigation, transactional, advisory, etc.)"
    - name: "practice_area"
      expr: practice_area_id
      comment: "Practice area identifier for the matter"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement structure (hourly, contingency, fixed, blended, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the matter"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk classification of the matter (high, medium, low)"
    - name: "office_code"
      expr: office_code
      comment: "Office code responsible for the matter"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification level"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the matter"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the matter was opened"
    - name: "open_quarter"
      expr: CONCAT('Q', QUARTER(open_date), '-', YEAR(open_date))
      comment: "Quarter and year the matter was opened"
    - name: "close_year"
      expr: YEAR(close_date)
      comment: "Year the matter was closed"
  measures:
    - name: "total_matters"
      expr: COUNT(1)
      comment: "Total count of matters"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all matters"
    - name: "avg_budget_per_matter"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget amount per matter"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts across matters"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per matter"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all matters"
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per matter"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique clients with matters"
    - name: "matters_with_conflict_clearance"
      expr: SUM(CASE WHEN conflict_cleared_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of matters with completed conflict clearance"
    - name: "conflict_clearance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conflict_cleared_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of matters with conflict clearance completed"
    - name: "matters_with_engagement_letter"
      expr: SUM(CASE WHEN engagement_letter_signed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of matters with signed engagement letters"
    - name: "engagement_letter_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN engagement_letter_signed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of matters with signed engagement letters"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance and variance metrics tracking matter financial planning, rate management, and budget compliance"
  source: "`legal_ecm`.`matter`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (approved, pending, rejected, etc.)"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (phase, matter, timekeeper, etc.)"
    - name: "currency"
      expr: currency
      comment: "Currency code for budget amounts"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of billing rate (standard, discounted, blended, etc.)"
    - name: "rate_approval_status"
      expr: rate_approval_status
      comment: "Approval status of the billing rate"
    - name: "timekeeper_role"
      expr: timekeeper_role
      comment: "Role of the timekeeper for rate budgeting"
    - name: "client_agreed"
      expr: client_agreed_flag
      comment: "Whether the budget has been agreed by the client"
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the budget was approved"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the budget became effective"
  measures:
    - name: "total_budgets"
      expr: COUNT(1)
      comment: "Total count of budget records"
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount across all budget records"
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per budget record"
    - name: "total_hourly_rate_amount"
      expr: SUM(CAST(hourly_rate_amount AS DOUBLE))
      comment: "Total hourly rate amounts"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate_amount AS DOUBLE))
      comment: "Average hourly billing rate"
    - name: "avg_variance_threshold"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average variance threshold percentage for budget monitoring"
    - name: "client_agreed_budgets"
      expr: SUM(CASE WHEN client_agreed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budgets agreed by clients"
    - name: "client_agreement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN client_agreed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of budgets with client agreement"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with budgets"
    - name: "distinct_timekeepers"
      expr: COUNT(DISTINCT timekeeper_id)
      comment: "Count of unique timekeepers with budget records"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter phase performance metrics tracking phase execution, budget variance, and timeline adherence for matter lifecycle management"
  source: "`legal_ecm`.`matter`.`phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (active, completed, pending, etc.)"
    - name: "phase_type"
      expr: phase_type
      comment: "Type classification of the phase"
    - name: "phase_name"
      expr: phase_name
      comment: "Name of the phase"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the phase"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the phase is billable to the client"
    - name: "is_contingent"
      expr: is_contingent
      comment: "Whether the phase is contingent fee based"
    - name: "is_active"
      expr: is_active
      comment: "Whether the phase is currently active"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the phase was planned to start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the phase actually started"
  measures:
    - name: "total_phases"
      expr: COUNT(1)
      comment: "Total count of matter phases"
    - name: "total_budgeted_fees"
      expr: SUM(CAST(budgeted_fees AS DOUBLE))
      comment: "Total budgeted fees across all phases"
    - name: "total_actual_fees"
      expr: SUM(CAST(actual_fees_to_date AS DOUBLE))
      comment: "Total actual fees incurred to date across phases"
    - name: "total_budgeted_hours"
      expr: SUM(CAST(budgeted_hours AS DOUBLE))
      comment: "Total budgeted hours across all phases"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours_to_date AS DOUBLE))
      comment: "Total actual hours worked to date across phases"
    - name: "total_budgeted_disbursements"
      expr: SUM(CAST(budgeted_disbursements AS DOUBLE))
      comment: "Total budgeted disbursements across all phases"
    - name: "total_actual_disbursements"
      expr: SUM(CAST(actual_disbursements_to_date AS DOUBLE))
      comment: "Total actual disbursements incurred to date"
    - name: "avg_budgeted_fees_per_phase"
      expr: AVG(CAST(budgeted_fees AS DOUBLE))
      comment: "Average budgeted fees per phase"
    - name: "avg_actual_fees_per_phase"
      expr: AVG(CAST(actual_fees_to_date AS DOUBLE))
      comment: "Average actual fees per phase"
    - name: "avg_budgeted_hours_per_phase"
      expr: AVG(CAST(budgeted_hours AS DOUBLE))
      comment: "Average budgeted hours per phase"
    - name: "avg_actual_hours_per_phase"
      expr: AVG(CAST(actual_hours_to_date AS DOUBLE))
      comment: "Average actual hours per phase"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with phases"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_judgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Judgment outcome and financial impact metrics tracking litigation results, monetary awards, and appeal activity for matter resolution analysis"
  source: "`legal_ecm`.`matter`.`judgment`"
  dimensions:
    - name: "judgment_status"
      expr: judgment_status
      comment: "Current status of the judgment"
    - name: "judgment_type"
      expr: judgment_type
      comment: "Type classification of the judgment"
    - name: "prevailing_party"
      expr: prevailing_party
      comment: "Party that prevailed in the judgment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for monetary amounts"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Status of judgment enforcement"
    - name: "for_client"
      expr: for_client
      comment: "Whether the judgment was in favor of the client"
    - name: "final_judgment"
      expr: final_judgment_flag
      comment: "Whether this is a final judgment"
    - name: "default_judgment"
      expr: default_judgment_flag
      comment: "Whether this is a default judgment"
    - name: "consent_judgment"
      expr: consent_judgment_flag
      comment: "Whether this is a consent judgment"
    - name: "appeal_filed"
      expr: CASE WHEN appeal_filed_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether an appeal has been filed"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year the judgment was entered"
    - name: "entry_quarter"
      expr: CONCAT('Q', QUARTER(entry_date), '-', YEAR(entry_date))
      comment: "Quarter and year the judgment was entered"
  measures:
    - name: "total_judgments"
      expr: COUNT(1)
      comment: "Total count of judgments"
    - name: "total_judgment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of all judgments"
    - name: "avg_judgment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average judgment amount"
    - name: "total_attorney_fees_awarded"
      expr: SUM(CAST(attorney_fees_awarded AS DOUBLE))
      comment: "Total attorney fees awarded across judgments"
    - name: "total_cost_award_amount"
      expr: SUM(CAST(cost_award_amount AS DOUBLE))
      comment: "Total cost awards across judgments"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate on judgments"
    - name: "favorable_judgments"
      expr: SUM(CASE WHEN for_client = TRUE THEN 1 ELSE 0 END)
      comment: "Count of judgments in favor of the client"
    - name: "win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN for_client = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of judgments won by the client"
    - name: "appeals_filed"
      expr: SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of judgments with appeals filed"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of judgments that were appealed"
    - name: "satisfied_judgments"
      expr: SUM(CASE WHEN satisfaction_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of judgments that have been satisfied"
    - name: "satisfaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN satisfaction_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of judgments that have been satisfied"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with judgments"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter disbursement and expense metrics tracking cost recovery, reimbursable expenses, and write-off analysis for matter profitability"
  source: "`legal_ecm`.`matter`.`matter_disbursement`"
  dimensions:
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type classification of the disbursement"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the disbursement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for disbursement amounts"
    - name: "billable"
      expr: billable_flag
      comment: "Whether the disbursement is billable to the client"
    - name: "reimbursable"
      expr: reimbursable_flag
      comment: "Whether the disbursement is reimbursable"
    - name: "write_off"
      expr: write_off_flag
      comment: "Whether the disbursement has been written off"
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-progress status of the disbursement"
    - name: "office_code"
      expr: office_code
      comment: "Office code for the disbursement"
    - name: "utbms_expense_code"
      expr: utbms_expense_code
      comment: "UTBMS expense classification code"
    - name: "incurred_year"
      expr: YEAR(incurred_date)
      comment: "Year the disbursement was incurred"
    - name: "incurred_quarter"
      expr: CONCAT('Q', QUARTER(incurred_date), '-', YEAR(incurred_date))
      comment: "Quarter and year the disbursement was incurred"
  measures:
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total count of disbursement records"
    - name: "total_disbursement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total disbursement amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on disbursements"
    - name: "total_amount_including_tax"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total disbursement amount including tax"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off"
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount per record"
    - name: "billable_disbursements"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable disbursements"
    - name: "billable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disbursements that are billable"
    - name: "reimbursable_disbursements"
      expr: SUM(CASE WHEN reimbursable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reimbursable disbursements"
    - name: "write_off_count"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disbursements written off"
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN write_off_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disbursements written off"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with disbursements"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_hearing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hearing activity and outcome metrics tracking court appearances, continuances, and ruling effectiveness for litigation management"
  source: "`legal_ecm`.`matter`.`hearing`"
  dimensions:
    - name: "hearing_status"
      expr: hearing_status
      comment: "Current status of the hearing"
    - name: "hearing_type"
      expr: hearing_type
      comment: "Type classification of the hearing"
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of appearance (in-person, virtual, telephonic, etc.)"
    - name: "adr_proceeding"
      expr: adr_proceeding_flag
      comment: "Whether this is an ADR proceeding"
    - name: "appearance_required"
      expr: appearance_required_flag
      comment: "Whether appearance is required"
    - name: "client_attendance"
      expr: client_attendance_flag
      comment: "Whether client attended the hearing"
    - name: "continuance"
      expr: continuance_flag
      comment: "Whether the hearing was continued"
    - name: "ruling_issued"
      expr: ruling_issued_flag
      comment: "Whether a ruling was issued"
    - name: "transcript_ordered"
      expr: transcript_ordered_date IS NOT NULL
      comment: "Whether a transcript was ordered"
    - name: "virtual_platform"
      expr: virtual_platform
      comment: "Virtual meeting platform used"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the hearing was scheduled"
    - name: "scheduled_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date), '-', YEAR(scheduled_date))
      comment: "Quarter and year the hearing was scheduled"
  measures:
    - name: "total_hearings"
      expr: COUNT(1)
      comment: "Total count of hearings"
    - name: "hearings_with_ruling"
      expr: SUM(CASE WHEN ruling_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hearings where a ruling was issued"
    - name: "ruling_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ruling_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hearings that resulted in a ruling"
    - name: "continuances"
      expr: SUM(CASE WHEN continuance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hearings that were continued"
    - name: "continuance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN continuance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hearings that were continued"
    - name: "client_attended_hearings"
      expr: SUM(CASE WHEN client_attendance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hearings with client attendance"
    - name: "transcripts_ordered"
      expr: SUM(CASE WHEN transcript_ordered_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of hearings with transcripts ordered"
    - name: "transcripts_received"
      expr: SUM(CASE WHEN transcript_received_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of hearings with transcripts received"
    - name: "virtual_hearings"
      expr: SUM(CASE WHEN virtual_meeting_url IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of virtual hearings"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with hearings"
    - name: "distinct_judges"
      expr: COUNT(DISTINCT judge_id)
      comment: "Count of unique judges presiding over hearings"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter task execution and efficiency metrics tracking task completion, budget variance, and resource utilization for matter workflow management"
  source: "`legal_ecm`.`matter`.`task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task"
    - name: "task_category"
      expr: task_category
      comment: "Category classification of the task"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the task"
    - name: "billable"
      expr: billable_flag
      comment: "Whether the task is billable"
    - name: "client_visible"
      expr: client_visible_flag
      comment: "Whether the task is visible to the client"
    - name: "is_milestone"
      expr: is_milestone_flag
      comment: "Whether the task is a milestone"
    - name: "approval_required"
      expr: approval_required_flag
      comment: "Whether the task requires approval"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task classification code"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the task is due"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the task was completed"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total count of tasks"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all tasks"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all tasks"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all tasks"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all tasks"
    - name: "total_budget_variance_hours"
      expr: SUM(CAST(budget_variance_hours AS DOUBLE))
      comment: "Total hours variance from budget"
    - name: "total_budget_variance_cost"
      expr: SUM(CAST(budget_variance_cost AS DOUBLE))
      comment: "Total cost variance from budget"
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per task"
    - name: "avg_actual_hours"
      expr: AVG(CAST(actual_hours AS DOUBLE))
      comment: "Average actual hours per task"
    - name: "completed_tasks"
      expr: SUM(CASE WHEN completion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of completed tasks"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed"
    - name: "billable_tasks"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable tasks"
    - name: "milestone_tasks"
      expr: SUM(CASE WHEN is_milestone_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestone tasks"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with tasks"
$$;


CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter risk exposure and mitigation metrics tracking risk severity, financial exposure, and regulatory reporting for enterprise risk management"
  source: "`legal_ecm`.`matter`.`matter_risk`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk"
    - name: "risk_category"
      expr: risk_category
      comment: "Category classification of the risk"
    - name: "subcategory"
      expr: subcategory
      comment: "Risk subcategory"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact severity rating of the risk"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk occurring"
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of risk mitigation efforts"
    - name: "escalation_required"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "pi_notification_required"
      expr: pi_notification_required_flag
      comment: "Whether professional indemnity notification is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial exposure"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the risk was identified"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total count of matter risks"
    - name: "total_financial_exposure"
      expr: SUM(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Total financial exposure amount across all risks"
    - name: "avg_financial_exposure"
      expr: AVG(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Average financial exposure per risk"
    - name: "escalated_risks"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring escalation"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks requiring escalation"
    - name: "pi_notification_risks"
      expr: SUM(CASE WHEN pi_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring professional indemnity notification"
    - name: "regulatory_reporting_risks"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring regulatory reporting"
    - name: "closed_risks"
      expr: SUM(CASE WHEN closure_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of closed risks"
    - name: "risk_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks that have been closed"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with identified risks"
$$;
