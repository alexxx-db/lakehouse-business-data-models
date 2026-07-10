-- Metric views for domain: workforce | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount, compensation, and talent pipeline metrics derived from the employee master. Used by HR leadership and finance to monitor workforce size, cost, and composition."
  source: "`vibe_manufacturing_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active, terminated, or on-leave status for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce mix analysis."
    - name: "department_name"
      expr: department_name
      comment: "Department for organizational headcount and cost distribution."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for talent and compensation benchmarking."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation equity and budget analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Union vs. non-union workforce segmentation for labor relations reporting."
    - name: "is_active"
      expr: is_active
      comment: "Active employee flag for current headcount filtering."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for cohort and attrition trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for attrition trend analysis."
    - name: "work_permit_required_flag"
      expr: work_permit_required_flag
      comment: "Identifies employees requiring work permits for compliance monitoring."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level classification for workforce capability planning."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Used as the baseline headcount KPI for workforce planning and budget allocation."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active employees. Core metric for capacity planning and organizational sizing."
    - name: "total_annual_salary_cost"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annualized salary cost across the workforce. Primary input for compensation budgeting and financial planning."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary per employee. Used for compensation benchmarking and equity analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly employees. Drives labor cost modeling for production and operations."
    - name: "total_training_hours_ytd"
      expr: SUM(CAST(training_hours_ytd AS DOUBLE))
      comment: "Total year-to-date training hours across all employees. Measures investment in workforce development and compliance training."
    - name: "avg_training_hours_ytd"
      expr: AVG(CAST(training_hours_ytd AS DOUBLE))
      comment: "Average training hours per employee year-to-date. Benchmarks learning investment per head for L&D strategy."
    - name: "employees_with_expiring_work_permits"
      expr: COUNT(CASE WHEN work_permit_required_flag = TRUE AND work_permit_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of employees whose work permits expire within 90 days. Critical compliance risk metric for HR and legal teams."
    - name: "employees_with_expiring_safety_certs"
      expr: COUNT(CASE WHEN safety_certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of employees with safety certifications expiring within 90 days. Drives proactive safety compliance management."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END)
      comment: "Count of union-member employees. Used for labor relations reporting and collective bargaining scope analysis."
    - name: "terminated_employee_count"
      expr: COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated employees in the period. Numerator for attrition rate calculation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost, tax, and deduction metrics derived from payroll run results. Used by finance and HR to monitor total labor cost, tax liabilities, and payroll composition by period and cost center."
  source: "`vibe_manufacturing_v1`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll processing status (processed, pending, error) for operational monitoring."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, monthly) for payroll cycle analysis."
    - name: "pay_group"
      expr: pay_group
      comment: "Pay group classification for segmented payroll cost reporting."
    - name: "department_code"
      expr: department_code
      comment: "Department code for cost allocation and departmental labor cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check) for payroll operations monitoring."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period start month for trend analysis of payroll costs over time."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow and accrual reporting."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost KPI for financial planning and P&L reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees. Used for cash flow planning and treasury management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. Monitored to control unplanned labor cost and assess staffing adequacy."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments. Tracks variable compensation spend against budget."
    - name: "total_employer_tax"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer-side tax liability. Required for tax compliance reporting and financial accruals."
    - name: "total_employer_benefits_cost"
      expr: SUM(CAST(employer_benefits_cost_amount AS DOUBLE))
      comment: "Total employer benefits cost. Measures total compensation cost beyond base salary for true labor cost analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost_amount AS DOUBLE))
      comment: "Total all-in labor cost including pay, taxes, and benefits. The definitive labor cost KPI for executive reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Operational metric for workforce scheduling efficiency and cost control."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked. Baseline for productivity and labor utilization analysis."
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record. Used for compensation benchmarking and anomaly detection."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions. Tracks benefit obligation and regulatory compliance with retirement plan funding."
    - name: "total_capex_allocated_labor"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE) * CAST(capex_allocation_percentage AS DOUBLE) / 100.0)
      comment: "Total labor cost allocated to capital projects (CapEx). Critical for fixed asset capitalization and project cost accounting."
    - name: "total_opex_allocated_labor"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE) * CAST(opex_allocation_percentage AS DOUBLE) / 100.0)
      comment: "Total labor cost allocated to operating expenses (OpEx). Used for P&L cost center reporting."
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Total payroll records processed. Used to validate payroll run completeness and detect missing employee payments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance, talent calibration, and succession pipeline metrics. Used by HR and executive leadership to assess workforce quality, identify high performers, and manage talent risk."
  source: "`vibe_manufacturing_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for talent distribution analysis."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probation) for review cycle management."
    - name: "review_status"
      expr: review_status
      comment: "Completion status of the review for process compliance monitoring."
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Review cycle year for year-over-year performance trend analysis."
    - name: "department_at_review"
      expr: department_at_review
      comment: "Department at time of review for departmental performance benchmarking."
    - name: "merit_increase_eligible"
      expr: merit_increase_eligible
      comment: "Eligibility flag for merit increases to support compensation planning."
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Promotion recommendation flag for succession and career development planning."
    - name: "succession_plan_candidate"
      expr: succession_plan_candidate
      comment: "Succession plan candidate flag for leadership pipeline reporting."
    - name: "performance_improvement_plan_required"
      expr: performance_improvement_plan_required
      comment: "PIP flag for identifying at-risk employees requiring intervention."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration completion status for ensuring rating consistency across departments."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of completed performance reviews. Measures HR process compliance and review cycle completion rate."
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance review records. Denominator for completion rate and distribution calculations."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Key talent quality indicator used in calibration and compensation decisions."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score. Measures how effectively employees are meeting their objectives."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score AS DOUBLE))
      comment: "Average competency rating score. Assesses workforce capability levels for talent development planning."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended = TRUE THEN 1 END)
      comment: "Count of employees recommended for promotion. Drives succession planning and internal mobility decisions."
    - name: "pip_required_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_required = TRUE THEN 1 END)
      comment: "Count of employees requiring a performance improvement plan. Signals workforce performance risk requiring management intervention."
    - name: "succession_candidate_count"
      expr: COUNT(CASE WHEN succession_plan_candidate = TRUE THEN 1 END)
      comment: "Count of employees identified as succession plan candidates. Measures leadership pipeline depth for organizational resilience."
    - name: "merit_eligible_count"
      expr: COUNT(CASE WHEN merit_increase_eligible = TRUE THEN 1 END)
      comment: "Count of employees eligible for merit increases. Drives compensation budget planning for the next cycle."
    - name: "compliance_training_completion_count"
      expr: COUNT(CASE WHEN compliance_training_completed = TRUE THEN 1 END)
      comment: "Count of employees who completed required compliance training. Tracks regulatory training obligation fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce absence, leave utilization, and FMLA compliance metrics. Used by HR and operations to monitor absenteeism trends, accrual consumption, and regulatory leave compliance."
  source: "`vibe_manufacturing_v1`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type_code"
      expr: absence_type_code
      comment: "Type of absence (sick, vacation, FMLA, etc.) for leave category analysis."
    - name: "absence_reason_code"
      expr: absence_reason_code
      comment: "Reason code for absence to identify patterns and root causes."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the absence request for process compliance monitoring."
    - name: "is_fmla_protected"
      expr: is_fmla_protected
      comment: "FMLA protection flag for regulatory compliance tracking."
    - name: "is_paid"
      expr: is_paid
      comment: "Paid vs. unpaid absence classification for payroll cost impact analysis."
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Intermittent leave flag for identifying chronic absenteeism patterns."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of absence start for trend analysis of absenteeism over time."
    - name: "medical_certification_required"
      expr: medical_certification_required
      comment: "Medical certification requirement flag for compliance process monitoring."
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total absence days across all employees. Primary absenteeism KPI for workforce availability and productivity impact assessment."
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total absence hours. Used for precise labor capacity planning and shift coverage analysis."
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average absence duration in days. Identifies whether absences are short-term or long-term, informing return-to-work programs."
    - name: "total_accrual_balance_deducted"
      expr: SUM(CAST(accrual_balance_deducted AS DOUBLE))
      comment: "Total accrual balance consumed by absences. Tracks leave liability reduction for financial accrual management."
    - name: "fmla_absence_count"
      expr: COUNT(CASE WHEN is_fmla_protected = TRUE THEN 1 END)
      comment: "Count of FMLA-protected absences. Monitors regulatory leave compliance and legal exposure."
    - name: "total_absence_events"
      expr: COUNT(1)
      comment: "Total number of absence events. Denominator for frequency and rate calculations."
    - name: "unapproved_absence_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' OR approval_status = 'Rejected' THEN 1 END)
      comment: "Count of unapproved or rejected absence requests. Flags process compliance gaps and potential attendance policy violations."
    - name: "medical_cert_outstanding_count"
      expr: COUNT(CASE WHEN medical_certification_required = TRUE AND medical_certification_received = FALSE THEN 1 END)
      comment: "Count of absences where medical certification is required but not yet received. Drives HR follow-up for compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time, cost, and productivity metrics from time entry records. Used by operations, finance, and HR to monitor labor utilization, overtime exposure, and direct labor cost by activity."
  source: "`vibe_manufacturing_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "labor_type"
      expr: labor_type
      comment: "Labor type classification (direct, indirect, overhead) for cost allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Time entry approval status for payroll processing compliance monitoring."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Overtime eligibility flag for labor cost risk monitoring."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level labor cost and productivity analysis."
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code for work order and project labor cost allocation."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work date for labor cost trend analysis."
    - name: "payroll_processed"
      expr: payroll_processed
      comment: "Payroll processing flag to identify unprocessed time entries that may delay payroll."
    - name: "oee_productive_time"
      expr: oee_productive_time
      comment: "OEE productive time flag for linking labor time to equipment effectiveness metrics."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries. Core labor utilization metric for capacity and productivity management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total direct labor cost from time entries. Primary input for job costing, project cost tracking, and P&L reporting."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour. Used for standard cost setting and variance analysis against actual rates."
    - name: "total_shift_premium_cost"
      expr: SUM(CAST(shift_premium_amount AS DOUBLE))
      comment: "Total shift premium cost. Monitors premium pay exposure for off-shift and weekend operations."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced during logged time. Enables labor productivity (units per hour) analysis when combined with hours worked."
    - name: "unprocessed_time_entry_count"
      expr: COUNT(CASE WHEN payroll_processed = FALSE THEN 1 END)
      comment: "Count of time entries not yet processed through payroll. Operational metric for payroll close completeness."
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total time entry records. Baseline volume metric for time capture compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance, expiry risk, and training investment metrics. Used by HR, safety, and compliance teams to ensure employees maintain required certifications and regulatory credentials."
  source: "`vibe_manufacturing_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current certification status (active, expired, suspended) for compliance monitoring."
    - name: "certification_category"
      expr: certification_category
      comment: "Certification category for grouping by safety, quality, technical, or regulatory type."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level for workforce capability tier analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Issuing authority for regulatory body compliance tracking."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Flag indicating whether the certification is a regulatory compliance requirement."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Renewal requirement flag for proactive expiry management."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certification expiry for renewal pipeline planning."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status for audit readiness and credential authenticity monitoring."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Baseline for compliance coverage and certification portfolio analysis."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications. Measures current compliance posture of the workforce."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications. Critical compliance risk metric — expired certs may create regulatory liability."
    - name: "certifications_expiring_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of certifications expiring within 90 days. Drives proactive renewal scheduling to prevent compliance gaps."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in workforce certifications. Tracks training and compliance spend for budget management."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Used for per-head compliance cost benchmarking and budget forecasting."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed for certifications. Measures workforce development investment and regulatory training fulfillment."
    - name: "unverified_certification_count"
      expr: COUNT(CASE WHEN verification_status != 'Verified' THEN 1 END)
      comment: "Count of certifications not yet verified. Audit risk metric — unverified credentials may not satisfy regulatory requirements."
    - name: "mandatory_compliance_cert_count"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Count of mandatory compliance certifications. Denominator for regulatory compliance coverage rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce assignment, FTE allocation, and compensation structure metrics. Used by HR and finance to monitor workforce deployment, pay equity, and organizational cost distribution."
  source: "`vibe_manufacturing_v1`.`workforce`.`assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (active, ended, pending) for workforce deployment monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type for classifying permanent, temporary, or rotational deployments."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce mix and cost structure analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family for compensation benchmarking and workforce capability analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level for organizational hierarchy and pay grade analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation equity and band analysis."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Union membership flag for labor relations and collective bargaining scope."
    - name: "primary_assignment_flag"
      expr: primary_assignment_flag
      comment: "Primary assignment flag to distinguish primary from secondary assignments in FTE calculations."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of assignment start for workforce deployment trend analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total assignment records. Baseline for workforce deployment coverage analysis."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE) / 100.0)
      comment: "Total FTE (full-time equivalent) across all assignments. Core workforce capacity metric for headcount planning and budget."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage per assignment. Identifies part-time workforce concentration and capacity gaps."
    - name: "total_base_pay_cost"
      expr: SUM(CAST(base_pay_rate AS DOUBLE))
      comment: "Total base pay rate across all assignments. Drives compensation budget planning and cost center allocation."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate per assignment. Used for compensation equity analysis and market benchmarking."
    - name: "avg_bonus_target_percentage"
      expr: AVG(CAST(bonus_target_percentage AS DOUBLE))
      comment: "Average bonus target percentage. Informs variable compensation budget and incentive plan design."
    - name: "avg_scheduled_weekly_hours"
      expr: AVG(CAST(scheduled_weekly_hours AS DOUBLE))
      comment: "Average scheduled weekly hours per assignment. Monitors workforce scheduling patterns and overtime risk."
    - name: "overtime_eligible_assignment_count"
      expr: COUNT(CASE WHEN overtime_eligible_flag = TRUE THEN 1 END)
      comment: "Count of overtime-eligible assignments. Quantifies overtime cost exposure for labor budget risk management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline, time-to-fill, and open position metrics. Used by HR leadership and hiring managers to monitor recruiting efficiency, headcount gaps, and hiring cost."
  source: "`vibe_manufacturing_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status (open, filled, cancelled) for pipeline stage analysis."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Requisition type (backfill, new headcount, contract) for demand classification."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for segmenting permanent vs. contingent hiring demand."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for tracking requisition authorization bottlenecks."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triaging critical vs. standard hiring needs."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Remote work eligibility for talent pool and sourcing strategy analysis."
    - name: "opened_date_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month requisition was opened for hiring demand trend analysis."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel for recruiting effectiveness and cost-per-hire analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total requisition records. Baseline for hiring demand volume and pipeline size."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' AND is_active = TRUE THEN 1 END)
      comment: "Count of currently open requisitions. Measures unfilled headcount demand and recruiting backlog."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST((salary_range_min + salary_range_max) AS DOUBLE) / 2.0)
      comment: "Average salary range midpoint across requisitions. Used for compensation budget planning and market positioning."
    - name: "avg_salary_range_max"
      expr: AVG(CAST(salary_range_max AS DOUBLE))
      comment: "Average maximum salary range. Tracks compensation ceiling exposure for budget risk management."
    - name: "total_salary_range_min"
      expr: SUM(CAST(salary_range_min AS DOUBLE))
      comment: "Total minimum salary commitment for open requisitions. Minimum labor cost exposure from open headcount."
    - name: "security_clearance_required_count"
      expr: COUNT(CASE WHEN security_clearance_required = TRUE THEN 1 END)
      comment: "Count of requisitions requiring security clearance. Identifies specialized hiring pipeline complexity and lead time risk."
    - name: "background_check_required_count"
      expr: COUNT(CASE WHEN background_check_required = TRUE THEN 1 END)
      comment: "Count of requisitions requiring background checks. Tracks compliance-sensitive hiring volume."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling efficiency, overtime, and productive hours metrics. Used by operations and HR to optimize shift coverage, minimize overtime, and maximize productive labor time."
  source: "`vibe_manufacturing_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status (published, confirmed, cancelled) for scheduling process monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, weekend) for shift mix and premium cost analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Overtime flag for monitoring unplanned overtime scheduling."
    - name: "is_night_shift"
      expr: is_night_shift
      comment: "Night shift flag for shift differential cost and safety compliance monitoring."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for premium pay and scheduling compliance analysis."
    - name: "schedule_exception_flag"
      expr: schedule_exception_flag
      comment: "Exception flag for identifying scheduling deviations requiring management attention."
    - name: "schedule_date_month"
      expr: DATE_TRUNC('MONTH', schedule_date)
      comment: "Month of scheduled shift for trend analysis of labor deployment."
    - name: "shift_name"
      expr: shift_name
      comment: "Shift name for granular shift-level performance analysis."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Total scheduled labor hours. Core capacity planning metric for production and operations scheduling."
    - name: "total_net_productive_hours"
      expr: SUM(CAST(net_productive_hours AS DOUBLE))
      comment: "Total net productive hours after breaks and non-productive time. Measures actual available labor capacity."
    - name: "avg_net_productive_hours_per_shift"
      expr: AVG(CAST(net_productive_hours AS DOUBLE))
      comment: "Average net productive hours per shift. Benchmarks shift efficiency and identifies low-productivity patterns."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Count of overtime shifts scheduled. Monitors unplanned overtime exposure and staffing adequacy."
    - name: "cancelled_shift_count"
      expr: COUNT(CASE WHEN schedule_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled shifts. Measures scheduling instability and its impact on production continuity."
    - name: "total_shifts_scheduled"
      expr: COUNT(1)
      comment: "Total shifts scheduled. Baseline for scheduling volume and coverage rate calculations."
    - name: "exception_shift_count"
      expr: COUNT(CASE WHEN schedule_exception_flag = TRUE THEN 1 END)
      comment: "Count of shifts with scheduling exceptions. Operational metric for identifying recurring scheduling problems."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program portfolio, cost, and compliance coverage metrics. Used by HR and L&D leadership to manage training investment, regulatory compliance coverage, and workforce development effectiveness."
  source: "`vibe_manufacturing_v1`.`workforce`.`training_course`"
  dimensions:
    - name: "course_status"
      expr: course_status
      comment: "Course status (active, retired, draft) for training catalog management."
    - name: "course_type"
      expr: course_type
      comment: "Course type (instructor-led, e-learning, on-the-job) for delivery method analysis."
    - name: "course_category"
      expr: course_category
      comment: "Course category for training portfolio segmentation by topic area."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for cost and effectiveness benchmarking across modalities."
    - name: "certification_awarded"
      expr: certification_awarded
      comment: "Flag indicating whether the course awards a certification for compliance tracking."
    - name: "recurrence_required"
      expr: recurrence_required
      comment: "Recurrence requirement flag for identifying mandatory recurring training obligations."
    - name: "assessment_required"
      expr: assessment_required
      comment: "Assessment requirement flag for quality assurance of training effectiveness."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month course became effective for training catalog lifecycle analysis."
  measures:
    - name: "total_courses"
      expr: COUNT(1)
      comment: "Total training courses in the catalog. Baseline for training portfolio breadth analysis."
    - name: "active_courses"
      expr: COUNT(CASE WHEN course_status = 'Active' THEN 1 END)
      comment: "Count of currently active training courses. Measures available training capacity for workforce development."
    - name: "total_cost_per_participant"
      expr: SUM(CAST(cost_per_participant AS DOUBLE))
      comment: "Sum of per-participant costs across all courses. Used for training budget planning and cost benchmarking."
    - name: "avg_cost_per_participant"
      expr: AVG(CAST(cost_per_participant AS DOUBLE))
      comment: "Average cost per participant per course. Benchmarks training investment efficiency across delivery methods."
    - name: "avg_course_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours. Used for scheduling and capacity planning of training programs."
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across courses. Monitors assessment rigor and quality standards."
    - name: "certification_awarding_course_count"
      expr: COUNT(CASE WHEN certification_awarded = TRUE THEN 1 END)
      comment: "Count of courses that award certifications. Measures the training portfolio's contribution to workforce credentialing."
    - name: "regulatory_linked_course_count"
      expr: COUNT(CASE WHEN regulatory_requirement_id IS NOT NULL THEN 1 END)
      comment: "Count of courses linked to regulatory requirements. Measures compliance training coverage in the training portfolio."
$$;