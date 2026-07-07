-- Metric views for domain: workforce | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount and workforce composition metrics derived from the employee master. Used by HR leadership and finance to track active workforce size, turnover risk, and labor cost exposure by segment."
  source: "`vibe_manufacturing_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the employee (Active, Terminated, On Leave, etc.) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (Full-Time, Part-Time, Contract, Temporary) for workforce composition analysis."
    - name: "department_name"
      expr: department_name
      comment: "Department name for organizational headcount breakdown."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for workforce planning and compensation benchmarking."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation distribution analysis."
    - name: "union_code"
      expr: union_code
      comment: "Union affiliation code for labor relations and agreement compliance tracking."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort analysis and workforce vintage tracking."
    - name: "work_location_name"
      expr: work_location_name
      comment: "Work location name for geographic headcount distribution."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating for talent segmentation and retention risk analysis."
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status to identify compliance gaps in the workforce."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Primary headcount KPI used in workforce planning and capacity reviews."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active employees. Core metric for operational capacity and labor cost forecasting."
    - name: "total_annual_salary_cost"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annualized salary cost across the workforce. Key input for labor budget planning and cost center allocation."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary per employee. Used for compensation benchmarking and equity analysis."
    - name: "total_hourly_rate_cost"
      expr: SUM(CAST(hourly_rate AS DOUBLE))
      comment: "Sum of hourly rates for hourly workforce. Used to estimate variable labor cost exposure."
    - name: "avg_training_hours_ytd"
      expr: AVG(CAST(training_hours_ytd AS DOUBLE))
      comment: "Average year-to-date training hours per employee. Tracks workforce development investment and compliance with training mandates."
    - name: "total_training_hours_ytd"
      expr: SUM(CAST(training_hours_ytd AS DOUBLE))
      comment: "Total training hours invested year-to-date across the workforce. Measures organizational learning investment."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END)
      comment: "Count of union members. Critical for labor relations management and collective bargaining scope assessment."
    - name: "work_permit_expiry_risk_count"
      expr: COUNT(CASE WHEN work_permit_required_flag = TRUE AND work_permit_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of employees with work permits expiring within 90 days. Proactive compliance risk indicator for HR and legal teams."
    - name: "safety_cert_expiry_risk_count"
      expr: COUNT(CASE WHEN safety_certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of employees with safety certifications expiring within 90 days. Operational safety compliance risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and labor expense metrics derived from payroll results. Used by finance, HR, and operations leadership to monitor total labor cost, overtime exposure, and payroll composition by period and cost center."
  source: "`vibe_manufacturing_v1`.`workforce`.`payroll_result`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period for time-series payroll cost analysis."
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period for payroll period boundary analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (Weekly, Bi-Weekly, Monthly) for payroll cycle analysis."
    - name: "pay_group"
      expr: pay_group
      comment: "Payroll group for segmenting labor cost by workforce category."
    - name: "department_code"
      expr: department_code
      comment: "Department code for cost center-level payroll expense attribution."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll run (Processed, Pending, Error) for payroll operations monitoring."
    - name: "payment_method_value"
      expr: CAST(payment_method AS STRING)
      comment: "Payment method for payroll disbursement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency payroll cost normalization."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay disbursed. Primary payroll cost KPI for finance and HR leadership budget reviews."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions. Measures actual cash outflow for payroll funding and treasury planning."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. High overtime signals capacity constraints or scheduling inefficiencies requiring management action."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Operational metric for identifying overloaded departments and shift planning gaps."
    - name: "avg_overtime_hours_per_employee"
      expr: AVG(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Average overtime hours per payroll record. Used to identify systemic overtime patterns vs. isolated spikes."
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost_amount AS DOUBLE))
      comment: "Total all-in labor cost including employer taxes and benefits. True cost-of-workforce metric for P&L and cost center reporting."
    - name: "total_employer_tax"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer tax burden. Used for tax planning and total compensation cost modeling."
    - name: "total_employer_benefits_cost"
      expr: SUM(CAST(employer_benefits_cost_amount AS DOUBLE))
      comment: "Total employer-side benefits cost. Key input for total compensation benchmarking and benefits program ROI."
    - name: "total_bonus_paid"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments disbursed. Tracks variable compensation spend against budget and performance targets."
    - name: "total_regular_hours_worked"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked across the workforce. Baseline for productivity and labor efficiency calculations."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours_worked AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours_worked AS DOUBLE)) + SUM(CAST(overtime_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Ratio KPI for identifying unsustainable labor patterns and scheduling risk."
    - name: "total_union_dues"
      expr: SUM(CAST(union_dues_amount AS DOUBLE))
      comment: "Total union dues deducted. Tracks labor relations financial obligations and union membership scope."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions. Measures deferred compensation liability and benefits program utilization."
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Total number of payroll result records processed. Used for payroll operations completeness and audit verification."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time tracking and productivity metrics derived from time entries. Used by operations, finance, and HR to monitor productive hours, overtime exposure, labor cost by activity, and time entry compliance."
  source: "`vibe_manufacturing_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work for daily labor utilization trending."
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for monthly labor cost and hours reporting."
    - name: "labor_type"
      expr: labor_type
      comment: "Type of labor (Direct, Indirect, Overhead) for cost allocation and productivity analysis."
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code for granular labor cost attribution to production activities."
    - name: "job_code"
      expr: job_code
      comment: "Job code for labor cost tracking by job classification."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level productivity and overtime analysis."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of the time entry (Approved, Pending, Rejected) for payroll readiness monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for time entry compliance and payroll processing readiness."
    - name: "location_code"
      expr: location_code
      comment: "Work location code for geographic labor distribution analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code for identifying time entry anomalies and compliance issues."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries. Primary labor utilization metric for capacity and productivity management."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Baseline for standard labor cost calculation."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours logged. Tracks overtime exposure for cost control and scheduling optimization."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Direct input for job costing, project cost tracking, and P&L reporting."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per time entry. Used for labor cost benchmarking and rate variance analysis."
    - name: "total_shift_premium_amount"
      expr: SUM(CAST(shift_premium_amount AS DOUBLE))
      comment: "Total shift premium pay. Measures the cost of off-hours and weekend scheduling decisions."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total units produced as recorded in time entries. Links labor hours to production output for efficiency measurement."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Ratio KPI for identifying scheduling inefficiency and labor cost risk."
    - name: "unapproved_time_entry_count"
      expr: COUNT(CASE WHEN approved_flag = FALSE THEN 1 END)
      comment: "Count of unapproved time entries. Payroll processing risk metric — high counts indicate approval bottlenecks."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per time entry. Used for labor compliance monitoring against regulatory break requirements."
    - name: "labor_cost_per_unit_produced"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(quantity_produced AS DOUBLE)), 0), 4)
      comment: "Labor cost per unit produced. Core manufacturing efficiency KPI linking labor spend to production output."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence and leave management metrics derived from absence records. Used by HR, operations, and compliance to monitor absenteeism rates, FMLA exposure, paid vs. unpaid leave patterns, and workforce availability risk."
  source: "`vibe_manufacturing_v1`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (Sick, Vacation, FMLA, Personal) for leave category analysis."
    - name: "absence_status"
      expr: absence_status
      comment: "Current status of the absence record (Approved, Pending, Denied) for leave management monitoring."
    - name: "absence_reason_code"
      expr: absence_reason_code
      comment: "Reason code for absence to identify root causes of workforce unavailability."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the absence request for HR workflow compliance tracking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of absence start for seasonal absenteeism trend analysis."
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the absence is paid or unpaid for compensation impact analysis."
    - name: "is_fmla_protected"
      expr: is_fmla_protected
      comment: "FMLA protection flag for legal compliance monitoring and exposure tracking."
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Intermittent leave flag for identifying chronic absenteeism patterns."
  measures:
    - name: "total_absence_records"
      expr: COUNT(1)
      comment: "Total number of absence records. Baseline absenteeism volume metric for HR trend analysis."
    - name: "total_absence_days"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total calendar days of absence. Primary workforce availability impact metric for operations planning."
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of absence. Used for precise labor capacity loss calculation and payroll impact assessment."
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of absence per record. Identifies whether absenteeism is driven by short-term or long-term leave patterns."
    - name: "fmla_absence_count"
      expr: COUNT(CASE WHEN is_fmla_protected = TRUE THEN 1 END)
      comment: "Count of FMLA-protected absences. Legal compliance metric — high counts signal workforce health issues and legal exposure."
    - name: "fmla_absence_days"
      expr: SUM(CASE WHEN is_fmla_protected = TRUE THEN total_days ELSE 0 END)
      comment: "Total days of FMLA-protected leave. Measures the operational impact of legally protected absences."
    - name: "unpaid_absence_count"
      expr: COUNT(CASE WHEN is_paid = FALSE THEN 1 END)
      comment: "Count of unpaid absence records. Tracks workforce financial hardship indicators and policy compliance."
    - name: "total_accrual_balance_deducted"
      expr: SUM(CAST(accrual_balance_deducted AS DOUBLE))
      comment: "Total accrual balance deducted across all absences. Measures leave liability drawdown and accrual sustainability."
    - name: "pending_approval_absence_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Count of absence records pending approval. HR workflow efficiency metric — high counts indicate approval bottlenecks."
    - name: "intermittent_absence_count"
      expr: COUNT(CASE WHEN is_intermittent = TRUE THEN 1 END)
      comment: "Count of intermittent leave records. Identifies chronic absenteeism patterns that impact scheduling reliability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance and talent management metrics derived from performance reviews. Used by HR, talent management, and executive leadership to assess workforce quality, identify high performers, manage succession risk, and drive merit decisions."
  source: "`vibe_manufacturing_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (Annual, Mid-Year, Probationary) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (Completed, In Progress, Overdue) for review completion monitoring."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating label for talent distribution analysis."
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Review cycle year for year-over-year performance trend analysis."
    - name: "review_completion_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Month of review completion for review cycle pacing and deadline compliance."
    - name: "merit_increase_eligible"
      expr: merit_increase_eligible
      comment: "Merit increase eligibility flag for compensation planning segmentation."
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Promotion recommendation flag for talent pipeline and succession planning."
    - name: "performance_improvement_plan_required"
      expr: performance_improvement_plan_required
      comment: "PIP requirement flag for identifying at-risk employees requiring intervention."
    - name: "succession_plan_candidate"
      expr: succession_plan_candidate
      comment: "Succession planning candidate flag for leadership pipeline tracking."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of completed performance reviews. Measures review cycle completion rate for HR compliance."
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance review records. Denominator for review completion rate calculations."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Primary talent quality KPI for workforce calibration and compensation decisions."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score AS DOUBLE))
      comment: "Average competency score across reviews. Measures workforce skill proficiency against job profile requirements."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score. Tracks how effectively the workforce delivers against set objectives."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended = TRUE THEN 1 END)
      comment: "Count of employees recommended for promotion. Measures internal talent pipeline depth for succession planning."
    - name: "pip_required_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_required = TRUE THEN 1 END)
      comment: "Count of employees requiring a performance improvement plan. Risk metric for workforce quality and potential involuntary turnover."
    - name: "succession_candidate_count"
      expr: COUNT(CASE WHEN succession_plan_candidate = TRUE THEN 1 END)
      comment: "Count of succession planning candidates. Measures leadership pipeline strength and organizational resilience."
    - name: "merit_eligible_count"
      expr: COUNT(CASE WHEN merit_increase_eligible = TRUE THEN 1 END)
      comment: "Count of employees eligible for merit increases. Input for compensation budget planning and retention investment."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across all reviews. Aggregate workforce performance health indicator."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance reviews completed. HR process compliance KPI — low rates indicate manager accountability gaps."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance and expiry metrics. Used by HR, safety, and compliance teams to monitor certification coverage, identify expiry risks, and ensure regulatory and operational compliance across the workforce."
  source: "`vibe_manufacturing_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_category"
      expr: certification_category
      comment: "Category of certification (Safety, Technical, Regulatory, Quality) for compliance domain segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Pending Renewal) for compliance monitoring."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level or tier for workforce skill depth analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Issuing body or authority for certification source and credibility analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for certification examinations for training effectiveness measurement."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification for audit readiness and compliance assurance."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of certification expiry for forward-looking renewal planning."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the certification satisfies for compliance reporting segmentation."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of workforce certification records. Baseline for certification coverage analysis."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications. Measures current compliance coverage across the workforce."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of expired certifications. Critical compliance risk metric — expired certs may create regulatory and safety violations."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of certifications expiring within 90 days. Proactive renewal pipeline metric for HR and compliance teams."
    - name: "avg_examination_score"
      expr: AVG(CAST(examination_score AS DOUBLE))
      comment: "Average examination score for certifications. Measures training program effectiveness and workforce readiness."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost invested in workforce certifications. Measures training and compliance investment for ROI analysis."
    - name: "avg_training_hours_completed"
      expr: AVG(CAST(training_hours_completed AS DOUBLE))
      comment: "Average training hours completed per certification. Tracks learning investment per credential."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed for certifications. Aggregate workforce development investment metric."
    - name: "compliance_required_cert_count"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Count of certifications that are mandatory for regulatory compliance. Scope metric for compliance program management."
    - name: "unverified_certification_count"
      expr: COUNT(CASE WHEN verification_status != 'Verified' THEN 1 END)
      comment: "Count of certifications not yet verified. Audit risk metric — unverified certs may not satisfy regulatory requirements."
    - name: "certification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_status IN ('Pass', 'Fail') THEN 1 END), 0), 2)
      comment: "Percentage of certification attempts that resulted in a pass. Training program effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition and open position metrics derived from requisitions. Used by HR, talent acquisition, and business leaders to monitor hiring velocity, open role risk, and recruitment pipeline health."
  source: "`vibe_manufacturing_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (Open, Filled, Cancelled, On Hold) for pipeline stage analysis."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (Backfill, New Headcount, Temporary) for workforce planning categorization."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for (Full-Time, Part-Time, Contract) for workforce composition planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requisition for hiring governance and budget control monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition for resource allocation in talent acquisition."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel used for recruitment for channel effectiveness analysis."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the requisition was opened for hiring demand trend analysis."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Remote work eligibility flag for workforce flexibility and talent pool analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of requisitions. Baseline hiring demand metric for workforce planning."
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently open requisitions. Measures unfilled headcount demand and operational capacity risk."
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days to fill a requisition. Core talent acquisition efficiency KPI — high values indicate recruiting bottlenecks."
    - name: "total_budgeted_salary_exposure"
      expr: SUM(CAST(budgeted_salary AS DOUBLE))
      comment: "Total budgeted salary for open requisitions. Measures uncommitted labor cost exposure in the hiring pipeline."
    - name: "avg_budgeted_salary"
      expr: AVG(CAST(budgeted_salary AS DOUBLE))
      comment: "Average budgeted salary per requisition. Used for compensation benchmarking and budget planning."
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS DOUBLE))
      comment: "Total number of open positions across all requisitions. Aggregate unfilled headcount demand metric."
    - name: "filled_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions. Measures talent acquisition throughput and hiring success rate."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions successfully filled. Talent acquisition effectiveness KPI for HR leadership."
    - name: "avg_applicant_count"
      expr: AVG(CAST(applicant_count AS DOUBLE))
      comment: "Average number of applicants per requisition. Measures talent pipeline depth and employer brand attractiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor utilization metrics derived from shift schedules. Used by operations, production, and HR to monitor scheduled capacity, overtime scheduling, shift coverage, and workforce deployment efficiency."
  source: "`vibe_manufacturing_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the scheduled shift for daily capacity planning and coverage analysis."
    - name: "schedule_month"
      expr: schedule_month
      comment: "Month of the schedule for monthly labor capacity trend analysis."
    - name: "schedule_week"
      expr: schedule_week
      comment: "Week of the schedule for weekly shift coverage and staffing level monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (Day, Night, Weekend, Holiday) for shift mix and premium cost analysis."
    - name: "shift_status"
      expr: shift_status
      comment: "Status of the shift schedule (Confirmed, Cancelled, Pending) for schedule reliability monitoring."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Overall schedule status for workforce planning completeness tracking."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Overtime flag for identifying scheduled overtime patterns and cost exposure."
    - name: "is_night_shift"
      expr: is_night_shift
      comment: "Night shift flag for shift premium cost analysis and workforce health monitoring."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for holiday premium cost tracking and scheduling compliance."
    - name: "shift_priority"
      expr: shift_priority
      comment: "Shift priority level for critical coverage and escalation analysis."
  measures:
    - name: "total_scheduled_shifts"
      expr: COUNT(1)
      comment: "Total number of scheduled shifts. Baseline workforce deployment volume metric."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled labor hours. Primary capacity planning metric for operations and production management."
    - name: "total_net_productive_hours"
      expr: SUM(CAST(net_productive_hours AS DOUBLE))
      comment: "Total net productive hours after breaks. Measures actual available labor capacity for production planning."
    - name: "total_scheduled_duration_hours"
      expr: SUM(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Total scheduled duration in hours. Used for labor cost forecasting and shift coverage analysis."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Count of overtime-scheduled shifts. Tracks planned overtime exposure for cost and compliance management."
    - name: "night_shift_count"
      expr: COUNT(CASE WHEN is_night_shift = TRUE THEN 1 END)
      comment: "Count of night shifts scheduled. Measures shift premium cost exposure and workforce health risk."
    - name: "cancelled_shift_count"
      expr: COUNT(CASE WHEN shift_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled shifts. Operational reliability metric — high cancellations indicate scheduling instability."
    - name: "schedule_exception_count"
      expr: COUNT(CASE WHEN schedule_exception_flag = TRUE THEN 1 END)
      comment: "Count of schedule exceptions. Measures scheduling plan adherence and deviation frequency."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per shift. Used for labor compliance monitoring against regulatory break requirements."
    - name: "overtime_shift_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overtime = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled shifts that are overtime. Ratio KPI for identifying chronic overtime scheduling patterns."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce assignment and position allocation metrics. Used by HR and finance to monitor FTE utilization, compensation structure, employment mix, and organizational deployment efficiency."
  source: "`vibe_manufacturing_v1`.`workforce`.`assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the assignment (Active, Terminated, On Leave) for workforce deployment monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (Permanent, Temporary, Secondment) for workforce flexibility analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce composition and cost structure analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family for compensation benchmarking and workforce planning segmentation."
    - name: "job_level"
      expr: job_level
      comment: "Job level for organizational hierarchy and compensation band analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation distribution and equity analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency for payroll planning and cash flow management."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of assignment effective start for workforce change trend analysis."
    - name: "union_code"
      expr: union_code
      comment: "Union code for labor relations and collective agreement compliance monitoring."
    - name: "time_type"
      expr: time_type
      comment: "Time type (Full-Time, Part-Time) for FTE composition analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of workforce assignments. Baseline deployment volume metric."
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END)
      comment: "Count of currently active assignments. Measures current workforce deployment capacity."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Total FTE equivalent across all assignments. Core workforce capacity metric for headcount planning and budget management."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage per assignment. Measures workforce utilization intensity and part-time workforce proportion."
    - name: "total_base_pay_cost"
      expr: SUM(CAST(base_pay_rate AS DOUBLE))
      comment: "Total base pay rate across all assignments. Aggregate compensation cost baseline for budget planning."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate per assignment. Used for compensation benchmarking and equity analysis."
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_percentage AS DOUBLE))
      comment: "Average bonus target percentage across assignments. Measures variable compensation exposure for budget planning."
    - name: "avg_scheduled_weekly_hours"
      expr: AVG(CAST(scheduled_weekly_hours AS DOUBLE))
      comment: "Average scheduled weekly hours per assignment. Measures workforce utilization and identifies under/over-scheduling."
    - name: "union_assignment_count"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN 1 END)
      comment: "Count of union-covered assignments. Tracks labor relations scope and collective agreement coverage."
    - name: "primary_assignment_count"
      expr: COUNT(CASE WHEN primary_assignment_flag = TRUE THEN 1 END)
      comment: "Count of primary assignments. Used to identify employees with multiple assignments and complex cost allocation scenarios."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program portfolio and investment metrics derived from training courses. Used by HR, L&D, and compliance to monitor training catalog coverage, cost per participant, mandatory compliance training, and program effectiveness."
  source: "`vibe_manufacturing_v1`.`workforce`.`training_course`"
  dimensions:
    - name: "course_category"
      expr: course_category
      comment: "Category of training course (Safety, Technical, Leadership, Compliance) for portfolio analysis."
    - name: "course_type"
      expr: course_type
      comment: "Type of course (Instructor-Led, eLearning, On-the-Job) for delivery method effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for training cost and accessibility analysis."
    - name: "course_status"
      expr: course_status
      comment: "Status of the course (Active, Retired, Draft) for training catalog management."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Mandatory flag for separating compliance-required training from elective development."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. retired training offerings."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework the course satisfies for regulatory training coverage analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the course became effective for training catalog vintage analysis."
  measures:
    - name: "total_courses"
      expr: COUNT(1)
      comment: "Total number of training courses in the catalog. Measures training portfolio breadth."
    - name: "active_course_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active training courses. Measures available training capacity for workforce development."
    - name: "mandatory_course_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory compliance training courses. Measures regulatory training obligation scope."
    - name: "total_cost_per_participant"
      expr: SUM(CAST(cost_per_participant AS DOUBLE))
      comment: "Total cost per participant across all courses. Aggregate training investment metric for L&D budget management."
    - name: "avg_cost_per_participant"
      expr: AVG(CAST(cost_per_participant AS DOUBLE))
      comment: "Average cost per participant per course. Training ROI input metric for program investment decisions."
    - name: "avg_course_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours. Used for scheduling and workforce availability planning for training delivery."
    - name: "total_training_capacity_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours available across all active courses. Measures workforce development capacity."
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across courses. Measures training rigor and quality standards."
    - name: "certification_awarding_course_count"
      expr: COUNT(CASE WHEN certification_awarded = TRUE THEN 1 END)
      comment: "Count of courses that award certifications. Measures training programs contributing to workforce certification compliance."
    - name: "recurrence_required_course_count"
      expr: COUNT(CASE WHEN recurrence_required = TRUE THEN 1 END)
      comment: "Count of courses requiring periodic recurrence. Measures ongoing training compliance obligation volume."
$$;