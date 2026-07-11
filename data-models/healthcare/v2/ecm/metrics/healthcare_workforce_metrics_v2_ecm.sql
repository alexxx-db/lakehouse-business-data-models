-- Metric views for domain: workforce | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount, staffing composition, and labor cost KPIs derived from the employee master."
  source: "`vibe_healthcare_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active/terminated/leave status used to segment headcount."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, per-diem, or contract classification."
    - name: "worker_category"
      expr: worker_category
      comment: "Worker category (employee, agency, contractor) for contingent labor analysis."
    - name: "clinical_role_type"
      expr: clinical_role_type
      comment: "Clinical vs non-clinical role classification for care-staffing analysis."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt classification for labor compliance."
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Primary clinical specialty for staffing mix analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for organizational rollups."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Hire month for hiring-trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Termination month for attrition trend analysis."
  measures:
    - name: "headcount"
      expr: COUNT(1)
      comment: "Total employee records; core headcount KPI for workforce planning."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of active employees for current staffing capacity."
    - name: "terminations"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of terminated employees driving turnover/attrition analysis."
    - name: "total_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Sum of FTE value; measures true staffing capacity beyond raw headcount."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate for labor cost benchmarking."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for margin analysis on billable clinical staff."
    - name: "oig_exclusion_check_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of workforce with OIG exclusion checks completed; compliance risk KPI."
    - name: "avg_cme_hours_completed"
      expr: AVG(CAST(cme_hours_completed AS DOUBLE))
      comment: "Average CME hours completed for provider continuing-education compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition funnel KPIs: time-to-fill, cost-per-hire, offer acceptance, and onboarding compliance."
  source: "`vibe_healthcare_v1`.`workforce`.`recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status for open/closed pipeline analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current pipeline stage for funnel analysis."
    - name: "hire_decision"
      expr: hire_decision
      comment: "Hire decision outcome for conversion analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Offer status to track offer acceptance/decline."
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Recruiting source channel for sourcing effectiveness."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of the requisition."
    - name: "is_clinical_position"
      expr: is_clinical_position
      comment: "Whether the requisition is for a clinical role."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Requisition posting month for hiring-velocity trend."
  measures:
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total recruitment records; sizing of hiring activity."
    - name: "hires"
      expr: COUNT(CASE WHEN hire_date IS NOT NULL THEN 1 END)
      comment: "Count of completed hires for staffing throughput."
    - name: "offers_accepted"
      expr: COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END)
      comment: "Count of accepted offers for offer-acceptance analysis."
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN offer_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Accepted offers as percent of extended offers; recruiting effectiveness KPI."
    - name: "avg_cost_per_hire"
      expr: AVG(CAST(cost_per_hire AS DOUBLE))
      comment: "Average cost per hire; core TA efficiency and budgeting KPI."
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days to fill a requisition; hiring-velocity KPI."
    - name: "avg_offered_salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average offered salary for compensation competitiveness analysis."
    - name: "onboarding_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN hire_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percent of hires with completed onboarding; readiness and compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave and absence management KPIs including FMLA utilization and approval outcomes."
  source: "`vibe_healthcare_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, medical, military, personal) for absence mix."
    - name: "request_status"
      expr: request_status
      comment: "Leave request status for approval-pipeline analysis."
    - name: "pay_status"
      expr: pay_status
      comment: "Paid vs unpaid leave status for cost impact."
    - name: "fmla_eligible"
      expr: fmla_eligible
      comment: "FMLA eligibility flag for compliance segmentation."
    - name: "requested_start_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Requested leave start month for seasonality analysis."
  measures:
    - name: "leave_request_count"
      expr: COUNT(1)
      comment: "Total leave requests; absence-volume KPI for staffing planning."
    - name: "approved_leave_count"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN 1 END)
      comment: "Count of approved leaves for coverage-gap planning."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Approved leaves as percent of all requests; process efficiency KPI."
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(leave_duration_days AS DOUBLE))
      comment: "Average leave duration in days; workforce availability impact KPI."
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours used; entitlement tracking and compliance KPI."
    - name: "avg_fmla_hours_remaining"
      expr: AVG(CAST(fmla_hours_remaining AS DOUBLE))
      comment: "Average FMLA hours remaining; leave-entitlement exposure KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours, overtime, and payroll cost KPIs from timekeeping records."
  source: "`vibe_healthcare_v1`.`workforce`.`time_attendance`"
  dimensions:
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type classification for labor-cost segmentation."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (worked, PTO, leave) for hours analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for day/night/weekend labor analysis."
    - name: "flsa_exempt"
      expr: flsa_exempt
      comment: "FLSA exempt flag for overtime eligibility analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Shift month for labor-cost trend analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked; base labor capacity KPI."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours; cost-driver and staffing-adequacy KPI."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay; core labor-cost KPI for budgeting."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay dollars; premium-labor cost KPI."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed; payroll cash-flow KPI."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate for wage benchmarking."
    - name: "total_on_call_hours"
      expr: SUM(CAST(on_call_hours AS DOUBLE))
      comment: "Total on-call hours; coverage-cost KPI for clinical staffing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling and staffing-adequacy KPIs including nurse-to-patient ratios and agency utilization."
  source: "`vibe_healthcare_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status for published/open shift analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status for filled vs open shift analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for staffing pattern analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (ICU, ED, med-surg) for unit-level staffing."
    - name: "is_agency_staff"
      expr: is_agency_staff
      comment: "Whether the shift is filled by agency staff; contingent-labor KPI dimension."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Shift month for scheduling-trend analysis."
  measures:
    - name: "scheduled_shift_count"
      expr: COUNT(1)
      comment: "Total scheduled shifts; scheduling-volume KPI."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours; planned labor capacity KPI."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked; schedule-adherence KPI."
    - name: "agency_shift_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_agency_staff = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of shifts filled by agency staff; contingent-labor reliance KPI."
    - name: "avg_nurse_to_patient_ratio"
      expr: AVG(CAST(nurse_to_patient_ratio AS DOUBLE))
      comment: "Average nurse-to-patient ratio; patient-safety and staffing-adequacy KPI."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total scheduled overtime hours; premium-labor exposure KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee safety and OSHA-recordable incident KPIs for workplace safety management."
  source: "`vibe_healthcare_v1`.`workforce`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Incident type for safety-pattern analysis."
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Injury or illness classification for root-cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level for prioritizing safety interventions."
    - name: "incident_status"
      expr: incident_status
      comment: "Incident investigation status."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause category for targeted prevention programs."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Incident month for safety-trend analysis."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total OSHA incidents; core workplace-safety KPI."
    - name: "recordable_incident_count"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "OSHA-recordable incidents; regulatory reporting KPI."
    - name: "recordable_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recordable incidents as percent of all incidents; safety-severity KPI."
    - name: "lost_time_incident_count"
      expr: COUNT(CASE WHEN is_fatality = TRUE OR is_hospitalized = TRUE THEN 1 END)
      comment: "Fatality/hospitalization incidents; high-severity safety KPI."
    - name: "bloodborne_exposure_count"
      expr: COUNT(CASE WHEN bloodborne_pathogen_exposure = TRUE THEN 1 END)
      comment: "Bloodborne pathogen exposures; healthcare-specific occupational-hazard KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent management KPIs from performance reviews including ratings, PIPs, and succession readiness."
  source: "`vibe_healthcare_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Review type for cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Review completion status for cycle-tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for talent distribution."
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment for succession and retention planning."
    - name: "review_period_end_month"
      expr: DATE_TRUNC('MONTH', review_period_end_date)
      comment: "Review period end month for cycle trend analysis."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total performance reviews; talent-process volume KPI."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score; workforce-performance KPI."
    - name: "high_potential_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_potential = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged high-potential; talent-pipeline strength KPI."
    - name: "pip_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pip_start_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews resulting in performance improvement plans; performance-risk KPI."
    - name: "merit_increase_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN merit_increase_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent eligible for merit increases; compensation-planning KPI."
    - name: "avg_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percent; compensation-cost planning KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_fte_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce budget vs actual KPIs for labor-cost control and vacancy management."
  source: "`vibe_healthcare_v1`.`workforce`.`fte_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget status for approval-cycle analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for budget-cycle grouping."
    - name: "job_family"
      expr: job_family
      comment: "Job family for labor-cost category analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for staffing-mix budgeting."
    - name: "is_union_position"
      expr: is_union_position
      comment: "Union position flag for labor-relations budgeting."
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Total budgeted FTE; workforce-plan capacity KPI."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE; realized staffing KPI."
    - name: "total_fte_variance"
      expr: SUM(CAST(fte_variance AS DOUBLE))
      comment: "Total FTE variance vs budget; staffing-plan adherence KPI."
    - name: "total_vacancy_fte"
      expr: SUM(CAST(vacancy_fte AS DOUBLE))
      comment: "Total vacancy FTE; open-position and coverage-risk KPI."
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost AS DOUBLE))
      comment: "Total budgeted labor cost; financial-plan KPI."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost; cost-control KPI."
    - name: "total_labor_cost_variance"
      expr: SUM(CAST(labor_cost_variance AS DOUBLE))
      comment: "Total labor cost variance vs budget; financial-steering KPI."
    - name: "total_agency_fte"
      expr: SUM(CAST(agency_fte AS DOUBLE))
      comment: "Total agency FTE; contingent-labor cost-exposure KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits enrollment KPIs including participation, cost, and ACA compliance."
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Benefit type (medical, dental, retirement) for participation mix."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status for active/waived analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee, family) for cost analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for benefits-cycle grouping."
    - name: "pretax_flag"
      expr: pretax_flag
      comment: "Pre-tax election flag for tax-treatment analysis."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total benefit enrollments; participation-volume KPI."
    - name: "total_employer_premium"
      expr: SUM(CAST(employer_premium_amount AS DOUBLE))
      comment: "Total employer premium cost; benefits-cost KPI."
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Total employee premium contribution; benefits cost-share KPI."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution (e.g., retirement match); benefits-cost KPI."
    - name: "aca_mec_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aca_minimum_essential_coverage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with ACA minimum essential coverage; employer-mandate compliance KPI."
    - name: "avg_annual_election_amount"
      expr: AVG(CAST(annual_election_amount AS DOUBLE))
      comment: "Average annual election amount; benefits utilization KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing KPIs covering gross/net pay, deductions, and processing accuracy."
  source: "`vibe_healthcare_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Payroll run type (regular, off-cycle, retroactive)."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Run status for processing-completion tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for disbursement analysis."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Retroactive run flag for correction-cost analysis."
    - name: "check_month"
      expr: DATE_TRUNC('MONTH', check_date)
      comment: "Check month for payroll-cost trend analysis."
  measures:
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total payroll runs; processing-volume KPI."
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay across runs; core payroll-cost KPI."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed; payroll cash-outflow KPI."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions; withholding-accuracy KPI."
    - name: "total_employer_taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer payroll taxes; labor-burden cost KPI."
    - name: "total_employer_benefits"
      expr: SUM(CAST(total_employer_benefits AS DOUBLE))
      comment: "Total employer benefit costs in payroll; total-compensation cost KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_employment_competency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing and privileging KPIs including primary-source verification and OIG/SAM exclusion checks."
  source: "`vibe_healthcare_v1`.`workforce`.`employment_competency`"
  dimensions:
    - name: "credential_status"
      expr: credential_status
      comment: "Credential status for active/expired analysis."
    - name: "credential_category"
      expr: credential_category
      comment: "Credential category for credentialing-workload analysis."
    - name: "application_decision"
      expr: application_decision
      comment: "Credentialing application decision outcome."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for privileging analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Credential expiration month for renewal-planning KPIs."
  measures:
    - name: "credential_count"
      expr: COUNT(1)
      comment: "Total credentialing records; workload-volume KPI."
    - name: "psv_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with primary-source verification; credentialing-compliance KPI."
    - name: "oig_exclusion_check_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with OIG exclusion checks; regulatory-compliance KPI."
    - name: "malpractice_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN malpractice_coverage_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with verified malpractice coverage; risk-management KPI."
    - name: "avg_competency_assessment_score"
      expr: AVG(CAST(competency_assessment_score AS DOUBLE))
      comment: "Average competency assessment score; clinical-quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of employee benefit enrollments"
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (e.g., health, dental, vision)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Benefit carrier name"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the enrollment"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the benefit became effective"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee associated with the enrollment"
  measures:
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Sum of employee premium contributions across all enrollments"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Sum of employer contributions across all enrollments"
    - name: "total_premium"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount (employee + employer)"
    - name: "average_premium_per_enrollment"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium per benefit enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollments"
$$;