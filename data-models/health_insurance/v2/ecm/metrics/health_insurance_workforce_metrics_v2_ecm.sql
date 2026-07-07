-- Metric views for domain: workforce | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_background_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Background Check business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`background_check`"
  dimensions:
    - name: "Adjudication Decision"
      expr: adjudication_decision
    - name: "Adverse Action Reason"
      expr: adverse_action_reason
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Check Number"
      expr: check_number
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Background Check"
      expr: COUNT(DISTINCT background_check_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee compensation structure and cost metrics. Tracks total compensation spend, pay equity indicators, and incentive program utilization to support compensation strategy and budget governance."
  source: "`vibe_health_insurance_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (base, bonus, equity, commission) for compensation mix analysis."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record (active, pending, approved) for governance tracking."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation band analysis and equity review."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for compensation cost allocation and departmental budget tracking."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, monthly) for payroll cash flow planning."
    - name: "is_exempt"
      expr: is_exempt
      comment: "FLSA exempt status for overtime eligibility and labor law compliance analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year compensation became effective for annual compensation trend analysis."
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus (performance, retention, signing) for incentive program analysis."
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base salary/wage cost across all active compensation records. Primary labor cost KPI for budget planning and financial reporting."
    - name: "total_bonus_compensation"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation committed. Drives incentive program cost forecasting and budget variance analysis."
    - name: "total_equity_compensation"
      expr: SUM(CAST(equity_amount AS DOUBLE))
      comment: "Total equity compensation value. Informs total compensation cost and equity dilution planning."
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base compensation per record. Benchmarks pay levels against market and supports pay equity analysis."
    - name: "avg_incentive_target_pct"
      expr: AVG(CAST(incentive_target_pct AS DOUBLE))
      comment: "Average incentive target percentage. Benchmarks variable pay program design and informs total compensation competitiveness."
    - name: "compensation_range_spread"
      expr: AVG(CAST(salary_range_max AS DOUBLE) - CAST(salary_range_min AS DOUBLE))
      comment: "Average spread between salary range max and min. Measures pay band width — narrow spreads limit retention flexibility, wide spreads signal grade compression."
    - name: "compa_ratio_avg"
      expr: ROUND(AVG(base_amount / NULLIF((salary_range_min + salary_range_max) / 2.0, 0)), 4)
      comment: "Average compa-ratio (actual pay vs. midpoint). Core pay equity KPI — ratios below 0.8 or above 1.2 trigger compensation review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation Plan business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "Benefit Plan Name"
      expr: benefit_plan_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Until"
      expr: effective_until
    - name: "Equity Type"
      expr: equity_type
    - name: "Equity Units"
      expr: equity_units
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compensation Plan"
      expr: COUNT(DISTINCT compensation_plan_id)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Bonus Amount"
      expr: SUM(bonus_amount)
    - name: "Average Bonus Amount"
      expr: AVG(bonus_amount)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Variable Amount"
      expr: SUM(variable_amount)
    - name: "Average Variable Amount"
      expr: AVG(variable_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compliance event tracking metrics. Monitors compliance event volume, resolution rates, and overdue items to manage regulatory risk and workforce conduct. Note: workforce.compliance_event is distinct from compliance domain compliance_event per VREQ-007."
  source: "`vibe_health_insurance_v1`.`workforce`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event (training, background check, policy violation) for compliance portfolio analysis."
    - name: "compliance_event_status"
      expr: compliance_event_status
      comment: "Current status of the compliance event (open, resolved, escalated) for operational monitoring."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Outcome of the compliance event (pass, fail, remediated) for compliance effectiveness analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the compliance event occurred for trend analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the compliance event is still active/open. Used to filter open compliance items."
  measures:
    - name: "total_compliance_events"
      expr: COUNT(compliance_event_id)
      comment: "Total compliance events recorded. Baseline compliance activity volume KPI for regulatory risk monitoring."
    - name: "open_compliance_events"
      expr: COUNT(CASE WHEN is_active = TRUE THEN compliance_event_id END)
      comment: "Number of currently open compliance events. Elevated open count signals compliance backlog and regulatory exposure."
    - name: "compliance_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = FALSE AND compliance_outcome IS NOT NULL THEN compliance_event_id END) / NULLIF(COUNT(compliance_event_id), 0), 2)
      comment: "Percentage of compliance events that have been resolved. Core compliance program effectiveness KPI."
    - name: "overdue_compliance_events"
      expr: COUNT(CASE WHEN is_active = TRUE AND due_date < CURRENT_DATE() THEN compliance_event_id END)
      comment: "Number of compliance events past their due date. Regulatory risk KPI — overdue items trigger escalation and potential regulatory penalty."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary Action business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "Acknowledgment Status"
      expr: acknowledgment_status
    - name: "Acknowledgment Timestamp"
      expr: acknowledgment_timestamp
    - name: "Action Date"
      expr: action_date
    - name: "Action Number"
      expr: action_number
    - name: "Action Type"
      expr: action_type
    - name: "Appeal Deadline"
      expr: appeal_deadline
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Disciplinary Action Category"
      expr: disciplinary_action_category
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Disciplinary Action Status"
      expr: disciplinary_action_status
    - name: "Documentation Attached"
      expr: documentation_attached
    - name: "Duration Days"
      expr: duration_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Disciplinary Action"
      expr: COUNT(DISTINCT disciplinary_action_id)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and demographic metrics. Tracks active employee population, turnover indicators, and compensation benchmarks to support workforce planning and HR strategy decisions."
  source: "`vibe_health_insurance_v1`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Employee department for workforce segmentation and cost allocation analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or contractor classification for workforce composition analysis."
    - name: "employment_status_code"
      expr: employment_status_code
      comment: "Standardized employment status code (active, terminated, on-leave) for headcount reporting."
    - name: "job_family"
      expr: department
      comment: "Department used as proxy for job family grouping in workforce analytics."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the employee is currently active, used to filter active headcount."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for cohort analysis and tenure-based workforce segmentation."
    - name: "termination_year"
      expr: DATE_TRUNC('YEAR', termination_date)
      comment: "Year of termination for attrition trend analysis."
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center assignment for financial workforce cost allocation."
    - name: "organization_level"
      expr: organization_level
      comment: "Organizational hierarchy level for span-of-control and leadership density analysis."
    - name: "state"
      expr: state
      comment: "Employee work state for geographic workforce distribution and compliance reporting."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN is_active = TRUE THEN employee_id END)
      comment: "Total number of currently active employees. Core headcount KPI used in every workforce planning and budget review."
    - name: "total_terminated_employees"
      expr: COUNT(CASE WHEN is_active = FALSE AND termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees in the period. Drives attrition rate calculation and retention strategy decisions."
    - name: "total_salary_budget"
      expr: SUM(CASE WHEN is_active = TRUE THEN salary_amount ELSE 0 END)
      comment: "Total annualized salary cost for active employees. Critical input for budget planning, compensation benchmarking, and financial forecasting."
    - name: "avg_salary_amount"
      expr: AVG(CASE WHEN is_active = TRUE THEN salary_amount END)
      comment: "Average salary of active employees. Used for compensation equity analysis and market benchmarking."
    - name: "bonus_eligible_headcount"
      expr: COUNT(CASE WHEN bonus_eligible = TRUE AND is_active = TRUE THEN employee_id END)
      comment: "Number of active employees eligible for bonus. Drives incentive compensation budget planning."
    - name: "health_plan_eligible_headcount"
      expr: COUNT(CASE WHEN health_plan_eligible = TRUE AND is_active = TRUE THEN employee_id END)
      comment: "Active employees eligible for health plan benefits. Informs benefits cost forecasting and ACA compliance tracking."
    - name: "hipaa_training_compliant_headcount"
      expr: COUNT(CASE WHEN hipaa_training_completion_date IS NOT NULL AND is_active = TRUE THEN employee_id END)
      comment: "Active employees with completed HIPAA training. Regulatory compliance KPI — non-compliance triggers mandatory remediation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employee_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefits enrollment and cost metrics. Tracks enrollment rates, employer contribution costs, and ACA compliance to support benefits strategy and financial planning decisions."
  source: "`vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (medical, dental, vision, 401k) for benefits portfolio analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, terminated, COBRA) for benefits administration monitoring."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for benefits cost tier analysis."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Plan year for annual benefits cost and enrollment trend analysis."
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Whether the employee is COBRA-eligible. Drives COBRA administration and continuation coverage cost planning."
    - name: "is_aca_compliant"
      expr: is_aca_compliant
      comment: "ACA compliance flag for regulatory reporting and penalty risk monitoring."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "How the enrollment was initiated (open enrollment, QLE, new hire) for enrollment channel analysis."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN employee_benefit_enrollment_id END)
      comment: "Total active benefit enrollments. Baseline benefits participation KPI for ACA compliance and benefits cost forecasting."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contribution cost. Primary benefits cost KPI for financial planning and total compensation benchmarking."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contribution. Informs employee cost-sharing analysis and benefits affordability assessment."
    - name: "total_benefits_cost"
      expr: SUM(CAST(total_contribution_amount AS DOUBLE))
      comment: "Total combined benefits cost (employer + employee). Drives total compensation cost analysis and benefits budget planning."
    - name: "avg_employer_contribution_per_enrollment"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrolled employee. Benchmarks benefits generosity and informs plan design decisions."
    - name: "aca_non_compliant_count"
      expr: COUNT(CASE WHEN is_aca_compliant = FALSE AND is_active = TRUE THEN employee_benefit_enrollment_id END)
      comment: "Number of active enrollments flagged as ACA non-compliant. Regulatory risk KPI — non-compliance triggers IRS penalty exposure."
    - name: "cobra_enrollment_count"
      expr: COUNT(CASE WHEN is_cobra_eligible = TRUE THEN employee_benefit_enrollment_id END)
      comment: "Number of COBRA-eligible enrollments. Drives COBRA administration cost and continuation coverage liability planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employment Record business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`employment_record`"
  dimensions:
    - name: "Action Effective Date"
      expr: action_effective_date
    - name: "Action Number"
      expr: action_number
    - name: "Action Subtype"
      expr: action_subtype
    - name: "Action Type"
      expr: action_type
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employee Acknowledgment Status"
      expr: employee_acknowledgment_status
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Incident Description"
      expr: incident_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employment Record"
      expr: COUNT(DISTINCT employment_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount planning and budget variance metrics. Tracks FTE targets vs. actuals, vacancy rates, and budget utilization to support strategic workforce planning and financial governance."
  source: "`vibe_health_insurance_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan for annual workforce planning cycle analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan (draft, approved, active) for governance tracking."
    - name: "department_code"
      expr: department_code
      comment: "Department for cross-departmental headcount allocation analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial headcount budget allocation."
    - name: "is_contractor"
      expr: is_contractor
      comment: "Whether the planned headcount is for contractors vs. employees. Drives workforce mix strategy decisions."
    - name: "diversity_hiring_indicator"
      expr: diversity_hiring_indicator
      comment: "Whether the requisition has a diversity hiring target. Tracks DEI hiring program execution."
    - name: "planning_period"
      expr: planning_period
      comment: "Planning period (Q1, Q2, annual) for phased headcount planning analysis."
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Total approved FTE budget. Primary workforce capacity KPI for financial planning and organizational design."
    - name: "total_filled_fte"
      expr: SUM(CAST(filled_fte AS DOUBLE))
      comment: "Total filled FTE positions. Compared against approved FTE to measure hiring execution against plan."
    - name: "total_vacant_fte"
      expr: SUM(CAST(vacant_fte AS DOUBLE))
      comment: "Total vacant FTE positions. Drives urgency of recruitment and quantifies operational capacity risk from unfilled roles."
    - name: "vacancy_rate"
      expr: ROUND(100.0 * SUM(CAST(vacant_fte AS DOUBLE)) / NULLIF(SUM(CAST(approved_fte AS DOUBLE)), 0), 2)
      comment: "Percentage of approved FTE positions that are currently vacant. High vacancy rate signals hiring execution failure or budget constraint."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total dollar variance between planned and actual headcount costs. Core financial governance KPI for workforce budget management."
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percent AS DOUBLE))
      comment: "Average budget variance percentage across headcount plans. Tracks planning accuracy and drives forecast model improvement."
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days to fill planned positions. Recruitment efficiency KPI within the headcount planning context."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_job_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job Role business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`job_role`"
  dimensions:
    - name: "Compensation Band"
      expr: compensation_band
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Eeo Category"
      expr: eeo_category
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External System Source"
      expr: external_system_source
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Flsa Exempt Status"
      expr: flsa_exempt_status
    - name: "Hipaa Training Required"
      expr: hipaa_training_required
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Job Role"
      expr: COUNT(DISTINCT job_role_id)
    - name: "Total Pay Grade Max"
      expr: SUM(pay_grade_max)
    - name: "Average Pay Grade Max"
      expr: AVG(pay_grade_max)
    - name: "Total Pay Grade Min"
      expr: SUM(pay_grade_min)
    - name: "Average Pay Grade Min"
      expr: AVG(pay_grade_min)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee leave utilization and cost metrics. Tracks leave patterns, FMLA compliance, and payroll impact to support workforce availability planning and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, medical, parental) for leave composition and policy analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Approval status of the leave request for operational tracking."
    - name: "leave_request_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month leave begins for seasonal leave pattern analysis."
    - name: "fmla_eligible"
      expr: fmla_eligible
      comment: "Whether the leave qualifies under FMLA. Drives regulatory compliance tracking and legal risk management."
    - name: "payroll_impact"
      expr: payroll_impact
      comment: "Whether the leave has a payroll cost impact. Used to separate paid vs. unpaid leave for cost analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for leave cost allocation and departmental absence tracking."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(leave_request_id)
      comment: "Total leave requests submitted. Baseline absence volume metric for workforce availability planning."
    - name: "total_approved_days"
      expr: SUM(CAST(approved_days AS DOUBLE))
      comment: "Total approved leave days. Drives workforce capacity planning and backfill cost estimation."
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Compared against approved days to measure leave approval rate and policy adherence."
    - name: "total_payroll_cost_of_leave"
      expr: SUM(CASE WHEN payroll_impact = TRUE THEN payroll_amount ELSE 0 END)
      comment: "Total payroll cost attributable to approved leave. Quantifies the financial impact of workforce absence on labor costs."
    - name: "avg_approved_days_per_request"
      expr: AVG(CAST(approved_days AS DOUBLE))
      comment: "Average approved leave duration per request. Benchmarks leave utilization and identifies outlier leave patterns."
    - name: "fmla_leave_request_count"
      expr: COUNT(CASE WHEN fmla_eligible = TRUE THEN leave_request_id END)
      comment: "Number of FMLA-qualifying leave requests. Regulatory compliance KPI — drives FMLA administration and legal risk monitoring."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN leave_status = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(leave_request_id), 0), 2)
      comment: "Percentage of leave requests approved. Tracks leave policy consistency and manager compliance with leave administration."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Org Unit business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`org_unit`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Audit Status"
      expr: audit_status
    - name: "City"
      expr: city
    - name: "Org Unit Code"
      expr: org_unit_code
    - name: "Compliance Training Required"
      expr: compliance_training_required
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Classification"
      expr: data_classification
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Org Unit Description"
      expr: org_unit_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email"
      expr: email
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Org Unit"
      expr: COUNT(DISTINCT org_unit_id)
    - name: "Total Annual Budget Amount"
      expr: SUM(annual_budget_amount)
    - name: "Average Annual Budget Amount"
      expr: AVG(annual_budget_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll Cost Allocation business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation`"
  dimensions:
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Reason"
      expr: allocation_reason
    - name: "Allocation Sequence"
      expr: allocation_sequence
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Gl Account Code"
      expr: gl_account_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payroll Cost Allocation"
      expr: COUNT(DISTINCT payroll_cost_allocation_id)
    - name: "Total Allocated Benefit Cost"
      expr: SUM(allocated_benefit_cost)
    - name: "Average Allocated Benefit Cost"
      expr: AVG(allocated_benefit_cost)
    - name: "Total Allocated Employer Tax Amount"
      expr: SUM(allocated_employer_tax_amount)
    - name: "Average Allocated Employer Tax Amount"
      expr: AVG(allocated_employer_tax_amount)
    - name: "Total Allocated Gross Pay Amount"
      expr: SUM(allocated_gross_pay_amount)
    - name: "Average Allocated Gross Pay Amount"
      expr: AVG(allocated_gross_pay_amount)
    - name: "Total Allocation Amount Total"
      expr: SUM(allocation_amount_total)
    - name: "Average Allocation Amount Total"
      expr: AVG(allocation_amount_total)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and labor hour metrics at the disbursement level. Enables payroll cost management, overtime monitoring, and labor efficiency analysis across pay periods."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_disbursement`"
  dimensions:
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period start month for trend analysis of payroll costs over time."
    - name: "pay_period_end_date"
      expr: DATE_TRUNC('MONTH', pay_period_end_date)
      comment: "Pay period end month for payroll cycle reporting."
    - name: "payroll_disbursement_type"
      expr: payroll_disbursement_type
      comment: "Type of disbursement (regular, bonus, severance) for payroll composition analysis."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll disbursement for operational monitoring."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for payroll cost allocation and departmental budget tracking."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for payroll cost allocation across business segments."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check) for payroll operations monitoring."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll disbursed. Primary payroll cost KPI used in budget vs. actual reporting and financial close."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions. Represents actual cash outflow for payroll funding and treasury management."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal taxes withheld across all disbursements. Required for tax compliance reporting and remittance."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state taxes withheld. Required for multi-state tax compliance and remittance tracking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid. Elevated overtime signals understaffing or scheduling inefficiency — triggers workforce planning review."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Baseline labor input metric for productivity and capacity analysis."
    - name: "avg_gross_pay_per_disbursement"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per disbursement record. Benchmarks compensation levels and detects anomalies in payroll processing."
    - name: "overtime_to_regular_hours_ratio"
      expr: ROUND(SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)), 0), 4)
      comment: "Ratio of overtime to regular hours. A rising ratio signals workforce strain and drives staffing intervention decisions."
    - name: "total_other_deductions"
      expr: SUM(CAST(other_deductions_total AS DOUBLE))
      comment: "Total non-tax deductions (benefits, garnishments). Informs total compensation cost and benefits utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level financial summary metrics. Tracks total payroll cost, employer tax burden, and payroll cycle efficiency to support finance and HR leadership decisions."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_period_start"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Payroll period start month for trend analysis."
    - name: "payroll_cycle_code"
      expr: payroll_cycle_code
      comment: "Payroll cycle (weekly, bi-weekly, semi-monthly, monthly) for cycle-level cost analysis."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (regular, off-cycle, bonus) for payroll composition reporting."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Run status (pending, processed, posted) for operational monitoring of payroll close."
    - name: "is_manual_run"
      expr: is_manual_run
      comment: "Flag for manual off-cycle runs. High manual run frequency signals process inefficiency."
  measures:
    - name: "total_gross_payroll"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross payroll across all runs. Primary financial KPI for payroll cost management and budget variance reporting."
    - name: "total_net_payroll"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Represents actual cash outflow for treasury and liquidity planning."
    - name: "total_employer_tax_burden"
      expr: SUM(CAST(total_employer_tax AS DOUBLE))
      comment: "Total employer-side payroll taxes (FICA, FUTA, SUTA). Drives total labor cost calculations and tax compliance reporting."
    - name: "total_employee_deductions"
      expr: SUM(CAST(total_employee_deductions AS DOUBLE))
      comment: "Total employee deductions (benefits, retirement, garnishments). Informs benefits cost and net compensation analysis."
    - name: "manual_run_count"
      expr: COUNT(CASE WHEN is_manual_run = TRUE THEN payroll_run_id END)
      comment: "Number of manual off-cycle payroll runs. Elevated count signals process exceptions requiring operational review."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross payroll per run. Benchmarks run size and detects anomalous payroll cycles."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance rating and merit increase metrics. Enables talent management, succession planning, and compensation equity decisions based on performance outcomes."
  source: "`vibe_health_insurance_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Completion status of the review for operational tracking of review cycle close."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for talent segmentation and distribution analysis."
    - name: "department"
      expr: department
      comment: "Department for cross-departmental performance benchmarking."
    - name: "review_period_start_year"
      expr: DATE_TRUNC('YEAR', review_period_start)
      comment: "Review period year for annual performance trend analysis."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for tracking completion of the performance calibration process."
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Flag indicating employee is on a PIP. Drives targeted retention and coaching interventions."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the review has been finalized. Used to track review cycle completion rate."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN performance_review_id END)
      comment: "Total finalized performance reviews. Tracks review cycle completion — low completion rates trigger HR escalation."
    - name: "avg_goal_rating"
      expr: AVG(CAST(average_goal_rating AS DOUBLE))
      comment: "Average goal achievement rating across employees. Core talent performance KPI used in calibration and succession planning."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage awarded. Drives compensation budget planning and pay equity analysis."
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_recommendation_amount AS DOUBLE))
      comment: "Total recommended merit increase dollar amount. Critical input for compensation budget approval and financial planning."
    - name: "pip_employee_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN performance_review_id END)
      comment: "Number of employees on performance improvement plans. Elevated count signals talent risk and drives targeted retention investment."
    - name: "avg_salary_adjustment"
      expr: AVG(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Average salary adjustment amount per review. Benchmarks compensation change magnitude and informs pay band calibration."
    - name: "total_salary_adjustment"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustment dollars committed through performance reviews. Drives compensation budget variance and financial close."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`position`"
  dimensions:
    - name: "Bonus Eligible"
      expr: bonus_eligible
    - name: "Competency Level"
      expr: competency_level
    - name: "Compliance Training Completed"
      expr: compliance_training_completed
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Department Code"
      expr: department_code
    - name: "Position Description"
      expr: position_description
    - name: "Eeo1 Category"
      expr: eeo1_category
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employment Type"
      expr: employment_type
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Position"
      expr: COUNT(DISTINCT position_id)
    - name: "Total Fte Allocation"
      expr: SUM(fte_allocation)
    - name: "Average Fte Allocation"
      expr: AVG(fte_allocation)
    - name: "Total Pay Grade Max"
      expr: SUM(pay_grade_max)
    - name: "Average Pay Grade Max"
      expr: AVG(pay_grade_max)
    - name: "Total Pay Grade Mid"
      expr: SUM(pay_grade_mid)
    - name: "Average Pay Grade Mid"
      expr: AVG(pay_grade_mid)
    - name: "Total Pay Grade Min"
      expr: SUM(pay_grade_min)
    - name: "Average Pay Grade Min"
      expr: AVG(pay_grade_min)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_rbac_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Role-based access control assignment metrics. Tracks access provisioning, temporary access exposure, and HIPAA access compliance to support information security governance and regulatory audit readiness."
  source: "`vibe_health_insurance_v1`.`workforce`.`rbac_assignment`"
  dimensions:
    - name: "access_level"
      expr: access_level
      comment: "Access level granted (read, write, admin) for privilege distribution analysis."
    - name: "rbac_assignment_status"
      expr: rbac_assignment_status
      comment: "Current status of the access assignment (active, revoked, expired) for access governance."
    - name: "is_temporary"
      expr: is_temporary
      comment: "Whether the access is temporary. Temporary access requires tighter monitoring for HIPAA compliance."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the access assignment. High-risk access drives enhanced monitoring and periodic review."
    - name: "system_name"
      expr: system_name
      comment: "System to which access is granted for system-level access inventory analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework governing the access (HIPAA, SOX, HITRUST) for regulatory audit reporting."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year access was granted for access provisioning trend analysis."
  measures:
    - name: "total_active_access_assignments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN rbac_assignment_id END)
      comment: "Total active access assignments. Baseline access inventory KPI for security governance and HIPAA workforce access compliance."
    - name: "high_risk_access_count"
      expr: COUNT(CASE WHEN risk_level = 'High' AND is_active = TRUE THEN rbac_assignment_id END)
      comment: "Number of active high-risk access assignments. Security risk KPI — elevated count triggers access review and potential de-provisioning."
    - name: "temporary_access_count"
      expr: COUNT(CASE WHEN is_temporary = TRUE AND is_active = TRUE THEN rbac_assignment_id END)
      comment: "Number of active temporary access assignments. Temporary access overstay is a HIPAA and SOX compliance risk requiring monitoring."
    - name: "revoked_access_count"
      expr: COUNT(CASE WHEN rbac_assignment_status = 'Revoked' THEN rbac_assignment_id END)
      comment: "Number of revoked access assignments. Tracks access termination execution — delayed revocation after employee departure is a critical security risk."
    - name: "access_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_timestamp IS NOT NULL THEN rbac_assignment_id END) / NULLIF(COUNT(rbac_assignment_id), 0), 2)
      comment: "Percentage of access assignments with documented approval. HIPAA minimum necessary standard compliance KPI — unapproved access is an audit finding."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_rbac_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rbac Role business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`rbac_role`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Until"
      expr: effective_until
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Is Active"
      expr: is_active
    - name: "Master Entity Code"
      expr: master_entity_code
    - name: "Record Created At"
      expr: record_created_at
    - name: "Record Source System"
      expr: record_source_system
    - name: "Record Status"
      expr: record_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rbac Role"
      expr: COUNT(DISTINCT rbac_role_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_time_and_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time utilization and attendance metrics. Tracks hours worked, overtime exposure, and absence patterns to support operational scheduling, FLSA compliance, and labor cost management."
  source: "`vibe_health_insurance_v1`.`workforce`.`time_and_attendance`"
  dimensions:
    - name: "pay_period_code"
      expr: pay_period_code
      comment: "Pay period identifier for time and attendance cycle analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Period start month for labor hour trend analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department for cross-departmental labor utilization comparison."
    - name: "time_entry_method"
      expr: time_entry_method
      comment: "How time was entered (badge, manual, mobile) for data quality and compliance monitoring."
    - name: "manager_approval_status"
      expr: manager_approval_status
      comment: "Manager approval status for timesheet governance and payroll readiness tracking."
    - name: "flsa_compliance"
      expr: flsa_compliance
      comment: "FLSA compliance flag for labor law risk monitoring."
    - name: "overtime_eligibility"
      expr: overtime_eligibility
      comment: "Whether the employee is eligible for overtime pay. Drives overtime cost exposure analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift assignment for shift-level labor utilization and differential cost analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all employees and periods. Core labor capacity metric for productivity and cost analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Elevated overtime signals understaffing or scheduling inefficiency — drives hiring and scheduling decisions."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total hours worked. Key labor efficiency KPI — high overtime rate increases labor cost and burnout risk."
    - name: "total_pto_used_hours"
      expr: SUM(CAST(pto_used_hours AS DOUBLE))
      comment: "Total PTO hours consumed. Tracks leave liability utilization and informs workforce availability planning."
    - name: "total_sick_hours_used"
      expr: SUM(CAST(sick_hours_used AS DOUBLE))
      comment: "Total sick hours used. Elevated sick time signals workforce health issues or potential abuse — drives HR investigation."
    - name: "avg_hours_worked_per_record"
      expr: AVG(CAST(total_hours_worked AS DOUBLE))
      comment: "Average hours worked per time and attendance record. Benchmarks labor utilization and identifies under- or over-utilization patterns."
    - name: "flsa_non_compliant_records"
      expr: COUNT(CASE WHEN flsa_compliance = FALSE THEN time_and_attendance_id END)
      comment: "Number of time records flagged as FLSA non-compliant. Regulatory risk KPI — non-compliance triggers wage and hour liability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training Course business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`training_course`"
  dimensions:
    - name: "Certification Awarded"
      expr: certification_awarded
    - name: "Certification Validity End"
      expr: certification_validity_end
    - name: "Certification Validity Start"
      expr: certification_validity_start
    - name: "Training Course Code"
      expr: training_course_code
    - name: "Compliance Due Date"
      expr: compliance_due_date
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Cost Center"
      expr: cost_center
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "Training Course Description"
      expr: training_course_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "End Date"
      expr: end_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Training Course"
      expr: COUNT(DISTINCT training_course_id)
    - name: "Total Cost"
      expr: SUM(cost)
    - name: "Average Cost"
      expr: AVG(cost)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee training completion and compliance metrics. Tracks training throughput, pass rates, and expiration risk to support regulatory compliance (HIPAA, OSHA) and workforce development decisions."
  source: "`vibe_health_insurance_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Category of training (compliance, clinical, leadership) for training portfolio analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Training outcome (pass/fail) for quality and effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery mode (online, classroom, on-the-job) for modality effectiveness comparison."
    - name: "training_record_status"
      expr: training_record_status
      comment: "Record status for tracking completion pipeline."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month of training completion for throughput trend analysis."
    - name: "is_expired"
      expr: is_expired
      comment: "Whether the training certification has expired. Drives recertification urgency and compliance risk alerts."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required. Used to forecast future training demand and compliance deadlines."
  measures:
    - name: "total_training_completions"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN training_record_id END)
      comment: "Total successful training completions. Core workforce development KPI tracking compliance training throughput."
    - name: "training_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN training_record_id END) / NULLIF(COUNT(training_record_id), 0), 2)
      comment: "Percentage of training attempts resulting in a pass. Low pass rates signal training quality issues or employee readiness gaps."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average training assessment score. Benchmarks training effectiveness and identifies courses requiring curriculum improvement."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested across the workforce. Quantifies learning investment and supports L&D budget justification."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN is_expired = TRUE THEN training_record_id END)
      comment: "Number of expired training certifications. Regulatory compliance risk KPI — expired HIPAA or clinical certifications trigger mandatory remediation."
    - name: "avg_training_hours_per_completion"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per completed record. Benchmarks training intensity and informs scheduling and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification metrics for health insurance — tracks certification status, renewals, costs, and compliance for clinical and regulatory certifications critical to healthcare operations."
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (Clinical, Regulatory, Professional, Technical)"
    - name: "certification_category"
      expr: certification_category
      comment: "Category of certification for grouping analysis"
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current status of the certification (Active, Expired, Pending Renewal)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for expiring certifications"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required"
    - name: "issuing_organization"
      expr: issuing_organization
      comment: "Organization that issued the certification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of certification cost"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year of certification issuance"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of certification expiration for renewal planning"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records for compliance coverage tracking"
    - name: "active_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Active' THEN 1 END)
      comment: "Count of active certifications — measures current compliance posture"
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications — compliance risk indicator"
    - name: "mandatory_certification_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory certifications — regulatory compliance baseline"
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications for training budget management"
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average certification cost for budget planning"
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees holding certifications — certification penetration metric"
    - name: "renewal_pending_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE AND renewal_status != 'Renewed' THEN 1 END)
      comment: "Count of certifications pending renewal — proactive compliance management"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce Certification business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "Certification Category"
      expr: certification_category
    - name: "Certification Code"
      expr: certification_code
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Type"
      expr: certification_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Document Reference"
      expr: document_reference
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workforce Certification"
      expr: COUNT(DISTINCT workforce_certification_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_certification2`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce professional certification tracking metrics. Monitors certification currency, renewal compliance, and mandatory certification coverage to manage regulatory and credentialing risk. (Note: renamed from workforce_certification per VREQ-006.)"
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_certification2`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of professional certification (clinical, compliance, technical) for certification portfolio analysis."
    - name: "certification_category"
      expr: certification_category
      comment: "Certification category for grouping related certifications in compliance reporting."
    - name: "issuing_organization"
      expr: issuing_organization
      comment: "Certifying body (NCQA, URAC, state board) for accreditation source analysis."
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current certification status (active, expired, suspended) for compliance monitoring."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role. Drives compliance gap prioritization."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for tracking upcoming certification expirations and renewal pipeline."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of certification expiration for renewal planning and compliance forecasting."
    - name: "verification_status"
      expr: verification_status
      comment: "Primary source verification status. Unverified certifications represent credentialing compliance risk."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN is_active = TRUE THEN workforce_certification2_id END)
      comment: "Total active workforce certifications. Baseline credentialing coverage KPI for regulatory compliance."
    - name: "mandatory_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND is_active = TRUE AND workforce_certification_status = 'Active' THEN workforce_certification2_id END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN workforce_certification2_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active and compliant. Regulatory compliance KPI — below threshold triggers immediate remediation."
    - name: "expiring_certifications_count"
      expr: COUNT(CASE WHEN expiration_date IS NOT NULL AND expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN workforce_certification2_id END)
      comment: "Certifications expiring within 90 days. Proactive compliance risk KPI driving renewal outreach and scheduling."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of workforce certifications. Informs L&D budget planning and certification investment ROI analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification spend and supports vendor negotiation for bulk certification programs."
    - name: "verified_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN workforce_certification2_id END) / NULLIF(COUNT(workforce_certification2_id), 0), 2)
      comment: "Percentage of certifications with completed primary source verification. Credentialing quality KPI — unverified certifications represent regulatory and liability risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition efficiency and cost metrics. Tracks time-to-fill, offer acceptance rates, and recruitment pipeline health to support workforce planning and hiring strategy decisions. (Renamed from member_recruitment per VREQ-006.)"
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the recruitment requisition (open, filled, cancelled) for pipeline monitoring."
    - name: "department_code"
      expr: department_code
      comment: "Hiring department for cross-departmental recruitment demand analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level (entry, mid, senior, executive) for talent pipeline segmentation."
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Recruitment source (referral, job board, agency) for sourcing channel effectiveness analysis."
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the position is remote. Drives talent pool sizing and compensation benchmarking."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation structure (salary, hourly, contract) for workforce cost planning."
    - name: "job_posting_month"
      expr: DATE_TRUNC('MONTH', job_posting_date)
      comment: "Month position was posted for recruitment volume trend analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for recruitment cost allocation."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN workforce_recruitment_id END)
      comment: "Total open recruitment requisitions. Tracks unfilled headcount demand — high open req count signals hiring bottleneck or budget constraint."
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days to fill an open position. Core recruitment efficiency KPI — elevated time-to-fill increases vacancy cost and operational risk."
    - name: "total_salary_offer_amount"
      expr: SUM(CAST(salary_offer_amount AS DOUBLE))
      comment: "Total salary committed through accepted offers. Drives compensation budget planning and headcount cost forecasting."
    - name: "avg_salary_offer_amount"
      expr: AVG(CAST(salary_offer_amount AS DOUBLE))
      comment: "Average salary offer amount. Benchmarks offer competitiveness against market and informs compensation band calibration."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN workforce_recruitment_id END) / NULLIF(COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN workforce_recruitment_id END), 0), 2)
      comment: "Percentage of extended offers that were accepted. Low acceptance rate signals compensation or employer brand issues requiring strategic response."
    - name: "avg_applicants_per_requisition"
      expr: AVG(CAST(number_of_applicants AS DOUBLE))
      comment: "Average number of applicants per open requisition. Low applicant volume signals sourcing channel gaps or job posting quality issues."
    - name: "total_salary_adjustment_cost"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustment dollars negotiated during recruitment. Tracks compensation flexibility and budget variance from planned offer amounts."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce Recruitment business metrics"
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_recruitment`"
  dimensions:
    - name: "Application Deadline"
      expr: application_deadline
    - name: "Candidate Start Date"
      expr: candidate_start_date
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Department Code"
      expr: department_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version"
      expr: fhir_version
    - name: "Interview Stage Completed"
      expr: interview_stage_completed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workforce Recruitment"
      expr: COUNT(DISTINCT workforce_recruitment_id)
    - name: "Total Net Salary Amount"
      expr: SUM(net_salary_amount)
    - name: "Average Net Salary Amount"
      expr: AVG(net_salary_amount)
    - name: "Total Salary Adjustment Amount"
      expr: SUM(salary_adjustment_amount)
    - name: "Average Salary Adjustment Amount"
      expr: AVG(salary_adjustment_amount)
    - name: "Total Salary Offer Amount"
      expr: SUM(salary_offer_amount)
    - name: "Average Salary Offer Amount"
      expr: AVG(salary_offer_amount)
$$;
