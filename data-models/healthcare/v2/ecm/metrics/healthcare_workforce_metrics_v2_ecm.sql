-- Metric views for domain: workforce | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition KPIs: time-to-fill, cost-per-hire, and offer conversion used by HR leadership to steer hiring efficiency and staffing pipeline health."
  source: "`vibe_healthcare_v1`.`workforce`.`recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, filled, closed) for pipeline funnel analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage of the candidate in the recruiting pipeline for funnel conversion tracking."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel (job board, referral, agency) for sourcing ROI analysis."
    - name: "is_clinical_position"
      expr: is_clinical_position
      comment: "Whether the position is clinical, to segment clinical vs non-clinical hiring performance."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, per-diem) for workforce-mix planning."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the requisition was posted for hiring-trend analysis."
  measures:
    - name: "Requisition Count"
      expr: COUNT(1)
      comment: "Total recruitment records; baseline hiring pipeline volume."
    - name: "Avg Time To Fill Days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days from posting to fill; core recruiting-efficiency KPI leadership uses to reduce vacancy exposure."
    - name: "Avg Cost Per Hire"
      expr: AVG(CAST(cost_per_hire AS DOUBLE))
      comment: "Average cost incurred per hire; drives sourcing budget and channel decisions."
    - name: "Total Signing Bonus"
      expr: SUM(CAST(signing_bonus_amount AS DOUBLE))
      comment: "Total signing bonus spend; monitors competitive-hiring cost pressure."
    - name: "Avg Offered Salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average offered salary; informs compensation competitiveness and budget alignment."
    - name: "Total Openings"
      expr: SUM(CAST(number_of_openings AS INT))
      comment: "Total open positions being recruited; measures demand on talent-acquisition capacity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position and vacancy KPIs: FTE fill rate, vacancy, and critical-role coverage used by operations and finance to manage staffing capacity and labor budget."
  source: "`vibe_healthcare_v1`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Status of the position (active, frozen, closed) for capacity planning."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for workforce composition analysis."
    - name: "is_clinical"
      expr: is_clinical
      comment: "Clinical vs non-clinical positions for staffing-mix steering."
    - name: "is_critical_role"
      expr: is_critical_role
      comment: "Whether the position is a critical role, to prioritize fill efforts."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift-coverage planning."
  measures:
    - name: "Position Count"
      expr: COUNT(1)
      comment: "Total positions; baseline organizational size."
    - name: "Total Budgeted FTE"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Sum of budgeted FTE; the planned labor capacity leadership funds."
    - name: "Total Filled FTE"
      expr: SUM(CAST(filled_fte AS DOUBLE))
      comment: "Sum of filled FTE; actual staffed capacity for fill-rate calculation."
    - name: "Vacant Position Count"
      expr: COUNT(CASE WHEN is_vacant = TRUE THEN 1 END)
      comment: "Count of vacant positions; direct measure of unstaffed capacity and vacancy risk."
    - name: "Avg Pay Range Midpoint"
      expr: AVG(CAST(pay_range_midpoint AS DOUBLE))
      comment: "Average pay midpoint across positions; compensation-benchmark input for budget decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount and composition KPIs: FTE, clinical mix, and attrition indicators used by executives for labor-force planning and retention strategy."
  source: "`vibe_healthcare_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active/terminated/leave status for headcount and turnover analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce-mix analysis."
    - name: "job_title"
      expr: job_title
      comment: "Job title grouping for role-level workforce composition."
    - name: "is_clinical"
      expr: is_clinical
      comment: "Clinical vs non-clinical staff split for care-delivery staffing analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA exempt/non-exempt classification for labor-compliance monitoring."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for hiring and tenure trend analysis."
  measures:
    - name: "Headcount"
      expr: COUNT(1)
      comment: "Total employee records; baseline workforce size."
    - name: "Active Employee Count"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees; the true staffing base for planning."
    - name: "Terminated Employee Count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of terminated employees; attrition volume that triggers retention action."
    - name: "Total FTE"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Sum of FTE percentages; effective full-time-equivalent workforce capacity."
    - name: "Clinical Staff Count"
      expr: COUNT(CASE WHEN is_clinical = TRUE THEN 1 END)
      comment: "Count of clinical staff; key input for care-delivery capacity and ratios."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost and overtime KPIs: gross pay, overtime hours, and premium-labor exposure used by finance and operations to control labor spend and burnout risk."
  source: "`vibe_healthcare_v1`.`workforce`.`time_attendance`"
  dimensions:
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (regular, overtime, PTO) for labor-cost breakdown."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift-based labor-cost analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Timecard approval status for payroll-control monitoring."
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month worked for labor-cost trend analysis."
  measures:
    - name: "Time Entry Count"
      expr: COUNT(1)
      comment: "Total time/attendance records; baseline labor-activity volume."
    - name: "Total Gross Pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay; primary labor-cost KPI for budget control."
    - name: "Total Overtime Hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours; premium-labor and burnout-risk indicator leadership actively manages."
    - name: "Total Overtime Pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay; premium-labor cost exposure for finance."
    - name: "Total Regular Hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked; denominator for overtime-ratio analysis."
    - name: "Total Worked Hours"
      expr: SUM(CAST(worked_hours AS DOUBLE))
      comment: "Total worked hours; productivity and staffing-utilization base."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staffing coverage KPIs: agency usage, overtime, float, and nurse-to-patient ratio used by nursing operations to steer safe staffing and premium-labor reduction."
  source: "`vibe_healthcare_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_status"
      expr: shift_status
      comment: "Status of the scheduled shift for coverage monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, weekend) for coverage-pattern analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for unit-level staffing analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for staffing-trend analysis."
  measures:
    - name: "Shift Count"
      expr: COUNT(1)
      comment: "Total scheduled shifts; baseline staffing-activity volume."
    - name: "Agency Staff Shift Count"
      expr: COUNT(CASE WHEN is_agency_staff = TRUE THEN 1 END)
      comment: "Count of agency-staffed shifts; premium-labor dependency leadership seeks to reduce."
    - name: "Overtime Shift Count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Count of overtime shifts; premium-labor and fatigue-risk indicator."
    - name: "Float Shift Count"
      expr: COUNT(CASE WHEN is_float = TRUE THEN 1 END)
      comment: "Count of float-pool shifts; flexibility and coverage-gap indicator."
    - name: "Total Scheduled Hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours; planned staffing-capacity base."
    - name: "Total Actual Hours Worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked; schedule-adherence and productivity input."
    - name: "Avg Nurse To Patient Ratio"
      expr: AVG(CAST(nurse_to_patient_ratio AS DOUBLE))
      comment: "Average nurse-to-patient ratio; core patient-safety and staffing-quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety KPIs: recordable incidents, lost workdays, and severity used by safety and compliance leadership to reduce injury rates and OSHA exposure."
  source: "`vibe_healthcare_v1`.`workforce`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of workplace incident for root-cause and trend analysis."
    - name: "injury_type"
      expr: injury_type
      comment: "Injury classification for safety-program targeting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level for risk prioritization."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for safety-trend monitoring."
  measures:
    - name: "Incident Count"
      expr: COUNT(1)
      comment: "Total workplace incidents; baseline safety-event volume."
    - name: "Recordable Incident Count"
      expr: COUNT(CASE WHEN is_recordable = TRUE THEN 1 END)
      comment: "OSHA-recordable incidents; the regulated safety KPI that drives corrective action."
    - name: "Total Lost Workdays"
      expr: SUM(CAST(lost_workdays AS INT))
      comment: "Total lost workdays; measures productivity and cost impact of injuries."
    - name: "Total Restricted Workdays"
      expr: SUM(CAST(restricted_workdays AS INT))
      comment: "Total restricted-duty days; captures partial-disability labor impact."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave and absence KPIs: leave volume, FMLA usage, and paid-leave hours used by HR to manage coverage risk and leave-related labor cost."
  source: "`vibe_healthcare_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, sick) for absence-pattern analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Leave request status for approval-pipeline monitoring."
    - name: "is_fmla_eligible"
      expr: is_fmla_eligible
      comment: "FMLA eligibility flag for compliance tracking."
    - name: "leave_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month leave begins for coverage-planning trends."
  measures:
    - name: "Leave Request Count"
      expr: COUNT(1)
      comment: "Total leave requests; baseline absence volume."
    - name: "FMLA Leave Count"
      expr: COUNT(CASE WHEN is_fmla_eligible = TRUE THEN 1 END)
      comment: "Count of FMLA-eligible leaves; compliance and coverage-risk indicator."
    - name: "Paid Leave Count"
      expr: COUNT(CASE WHEN is_paid = TRUE THEN 1 END)
      comment: "Count of paid leaves; direct labor-cost driver of absence."
    - name: "Total Leave Hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total leave hours; measures coverage gap and lost-productivity magnitude."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management KPIs: completion, ratings, and goal attainment used by leadership to steer talent development and identify performance risk."
  source: "`vibe_healthcare_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review completion status for cycle-compliance tracking."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, probationary) for cohort analysis."
    - name: "rating_scale"
      expr: rating_scale
      comment: "Rating scale used, to normalize rating comparisons."
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month review completed for cycle-progress monitoring."
  measures:
    - name: "Review Count"
      expr: COUNT(1)
      comment: "Total performance reviews; baseline review volume."
    - name: "Completed Review Count"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Completed reviews; performance-cycle compliance KPI."
    - name: "Avg Overall Rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating; talent-quality indicator for development strategy."
    - name: "Total Goals Met"
      expr: SUM(CAST(goals_met_count AS INT))
      comment: "Total goals met across reviews; goal-attainment magnitude."
    - name: "Total Goals Set"
      expr: SUM(CAST(goals_total_count AS INT))
      comment: "Total goals set; denominator for goal-attainment rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits KPIs: enrollment volume, coverage mix, and employer contribution cost used by HR and finance to manage benefits spend and participation."
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status for participation tracking."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (employee, family) for benefits-mix analysis."
    - name: "life_event_type"
      expr: life_event_type
      comment: "Life event driving enrollment change for qualifying-event analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month coverage becomes effective for enrollment-trend analysis."
  measures:
    - name: "Enrollment Count"
      expr: COUNT(1)
      comment: "Total benefit enrollments; baseline participation volume."
    - name: "Active Enrollment Count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Active enrollments; true benefits-participation base."
    - name: "Total Employer Contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer benefits contribution; core benefits-cost KPI for finance."
    - name: "Total Employee Contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee contribution; cost-share indicator for benefits design."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_fte_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor-budget KPIs: budgeted vs actual FTE and salary variance used by finance to manage staffing-plan adherence and control agency/overtime reliance."
  source: "`vibe_healthcare_v1`.`workforce`.`fte_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for budget-cycle analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year budget tracking."
  measures:
    - name: "Budget Record Count"
      expr: COUNT(1)
      comment: "Total FTE budget records; baseline planning-line volume."
    - name: "Total Budgeted FTE"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Total budgeted FTE; the planned labor capacity finance funds."
    - name: "Total Actual FTE"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE; staffing-plan adherence measure."
    - name: "Total Agency FTE"
      expr: SUM(CAST(agency_fte AS DOUBLE))
      comment: "Total agency FTE; premium-labor reliance leadership seeks to minimize."
    - name: "Total Budgeted Salary"
      expr: SUM(CAST(budgeted_salary_amount AS DOUBLE))
      comment: "Total budgeted salary; planned labor-cost base."
    - name: "Total Actual Salary"
      expr: SUM(CAST(actual_salary_amount AS DOUBLE))
      comment: "Total actual salary; labor-cost variance input for finance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll KPIs: gross/net pay, deductions, and employer tax used by finance to monitor payroll spend and processing control."
  source: "`vibe_healthcare_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Payroll run status for processing-control monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle) for cost breakdown."
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Pay month for payroll-cost trend analysis."
  measures:
    - name: "Payroll Run Count"
      expr: COUNT(1)
      comment: "Total payroll runs; baseline processing volume."
    - name: "Total Gross Pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll; primary payroll-cost KPI for finance."
    - name: "Total Net Pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed; cash-outflow monitoring for treasury."
    - name: "Total Deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions; benefits/tax withholding magnitude."
    - name: "Total Employer Taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer taxes; fully-loaded labor-cost input."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_competency_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical competency KPIs: pass rate, scores, and remediation used by nursing education and compliance to ensure staff readiness and regulatory adherence."
  source: "`vibe_healthcare_v1`.`workforce`.`competency_assessment`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for competency-compliance tracking."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Achieved proficiency level for skill-readiness analysis."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Assessment method for validation-approach analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for compliance-trend monitoring."
  measures:
    - name: "Assessment Count"
      expr: COUNT(1)
      comment: "Total competency assessments; baseline validation volume."
    - name: "Passed Assessment Count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Passed assessments; competency-compliance KPI driving remediation decisions."
    - name: "Remediation Required Count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Assessments needing remediation; staff-readiness risk indicator."
    - name: "Avg Assessment Score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average competency score; quality-of-readiness measure for education programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_clinical_privilege`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical privileging KPIs: active privileges, expirations, and proctoring status used by medical staff office to manage credentialing compliance and coverage."
  source: "`vibe_healthcare_v1`.`workforce`.`clinical_privilege`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Privilege status (active, expired, suspended) for compliance monitoring."
    - name: "privilege_category"
      expr: privilege_category
      comment: "Privilege category for scope-of-practice analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of privilege expiration for renewal-planning trends."
  measures:
    - name: "Privilege Count"
      expr: COUNT(1)
      comment: "Total clinical privileges; baseline privileging volume."
    - name: "Active Privilege Count"
      expr: COUNT(CASE WHEN privilege_status = 'Active' THEN 1 END)
      comment: "Active privileges; care-coverage capacity indicator."
    - name: "Proctoring Pending Count"
      expr: COUNT(CASE WHEN proctoring_required_flag = TRUE AND proctoring_completed_flag = FALSE THEN 1 END)
      comment: "Privileges awaiting proctoring; credentialing-compliance risk driving action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of employee benefit enrollments"
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the benefit became effective"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee associated with the enrollment"
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollments"
$$;