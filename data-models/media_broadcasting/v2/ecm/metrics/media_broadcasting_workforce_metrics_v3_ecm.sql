-- Metric views for domain: workforce | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics. Tracks active employee population, tenure distribution, and demographic breakdowns to support workforce planning and diversity reporting."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave, etc.) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce composition analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level/grade for hierarchical workforce analysis and compensation benchmarking."
    - name: "job_title"
      expr: job_title
      comment: "Employee job title for role-based workforce segmentation."
    - name: "gender"
      expr: gender
      comment: "Gender for diversity and inclusion reporting."
    - name: "nationality"
      expr: nationality
      comment: "Employee nationality for global workforce distribution analysis."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status for compliance and risk monitoring."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort-based tenure and attrition analysis."
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis."
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition trend analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Used as the baseline headcount figure for workforce planning and capacity analysis."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees. Primary KPI for workforce capacity and operational staffing levels."
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of employees with a termination date. Used to calculate attrition rates and workforce stability."
    - name: "avg_tenure_years"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date) / 365.25)
      comment: "Average employee tenure in years. Indicates workforce stability and retention effectiveness; low values signal retention risk."
    - name: "work_auth_expiring_count"
      expr: COUNT(CASE WHEN work_authorization_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Employees whose work authorization expires within 90 days. Critical compliance KPI to prevent unauthorized employment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics. Tracks gross pay, net pay, deductions, and overtime costs to support financial planning, labor cost management, and payroll compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, monthly) for payroll cycle analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check) for payroll operations monitoring."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll processing status for operational quality tracking."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Pay period month for trend analysis of labor costs over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll for multi-currency labor cost reporting."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost KPI used in financial planning, budget variance analysis, and P&L reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Used for cash flow planning and payroll funding requirements."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay cost. High overtime signals understaffing or scheduling inefficiency; drives hiring and scheduling decisions."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Used alongside overtime pay to assess labor utilization and scheduling effectiveness."
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay AS DOUBLE))
      comment: "Total bonus compensation paid. Tracks variable pay spend against budget and incentive plan effectiveness."
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay AS DOUBLE))
      comment: "Total base/regular pay. Core fixed labor cost component for budget planning."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments). Used for benefits cost analysis and compliance verification."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels and identifies anomalies in pay distribution."
    - name: "overtime_pay_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay. Executives use this to assess labor efficiency; values above threshold trigger staffing reviews."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Foundation for labor utilization and productivity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance measurement and talent management metrics. Tracks rating distributions, calibration outcomes, and promotion eligibility to support talent decisions and succession planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (Draft, Submitted, Approved) for process completion tracking."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for fairness and consistency monitoring across review cycles."
    - name: "review_period_start"
      expr: DATE_TRUNC('year', review_period_start_date)
      comment: "Review period year for year-over-year performance trend analysis."
    - name: "promotion_eligible_flag"
      expr: promotion_eligible_flag
      comment: "Whether the employee was flagged as promotion-eligible. Used for talent pipeline and succession planning."
    - name: "development_plan_required_flag"
      expr: development_plan_required_flag
      comment: "Whether a development plan was required. Indicates performance improvement needs."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of completed performance reviews. Tracks review cycle completion rate for HR process governance."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating across the workforce. Primary talent health KPI used in calibration and compensation planning."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score. Measures how effectively employees are meeting their objectives; drives OKR and incentive plan adjustments."
    - name: "promotion_eligible_count"
      expr: COUNT(CASE WHEN promotion_eligible_flag = TRUE THEN 1 END)
      comment: "Number of employees flagged as promotion-eligible. Key input for succession planning and talent pipeline depth assessment."
    - name: "promotion_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed employees eligible for promotion. Indicates talent pipeline health and career development effectiveness."
    - name: "employee_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN employee_dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where employees filed a dispute. High rates signal fairness concerns and calibration quality issues."
    - name: "avg_technical_skills_rating"
      expr: AVG(CAST(technical_skills_rating AS DOUBLE))
      comment: "Average technical skills rating. Used to identify skill gaps and prioritize training investments in technical competencies."
    - name: "avg_recommended_comp_adjustment_pct"
      expr: AVG(CAST(recommended_compensation_adjustment_percent AS DOUBLE))
      comment: "Average recommended compensation adjustment percentage. Directly informs merit budget planning and compensation cycle decisions."
    - name: "development_plan_required_count"
      expr: COUNT(CASE WHEN development_plan_required_flag = TRUE THEN 1 END)
      comment: "Count of employees requiring a development plan. Quantifies the performance improvement workload for HR business partners."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management and workforce availability metrics. Tracks leave volumes, types, approval rates, and FMLA utilization to support workforce scheduling and compliance management."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (vacation, sick, FMLA, parental) for leave pattern analysis."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Leave subtype for granular leave category reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Leave approval status for process efficiency and compliance monitoring."
    - name: "fmla_protected_flag"
      expr: fmla_protected_flag
      comment: "Whether the leave is FMLA-protected. Critical for legal compliance tracking."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether the leave is paid. Used for leave liability and cost analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of leave request for seasonal absence pattern analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests. Baseline volume metric for leave management capacity planning."
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total leave days requested. Quantifies workforce availability impact for operational scheduling."
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total actual leave days taken. Measures realized workforce absence for productivity and cost impact analysis."
    - name: "avg_days_per_request"
      expr: AVG(CAST(total_days_requested AS DOUBLE))
      comment: "Average leave days per request. Benchmarks leave duration patterns and identifies outliers requiring manager review."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved. Low rates may indicate policy inconsistency or manager compliance issues."
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN fmla_protected_flag = TRUE THEN 1 END)
      comment: "Count of FMLA-protected leave requests. Critical compliance metric to ensure legal obligations are met."
    - name: "fmla_leave_days"
      expr: SUM(CASE WHEN fmla_protected_flag = TRUE THEN CAST(total_days_requested AS DOUBLE) ELSE 0 END)
      comment: "Total FMLA-protected leave days. Used for FMLA entitlement tracking and compliance reporting."
    - name: "leave_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_days_taken AS DOUBLE)) / NULLIF(SUM(CAST(total_days_requested AS DOUBLE)), 0), 2)
      comment: "Ratio of actual days taken to days requested. Measures leave forecast accuracy and scheduling reliability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_leave_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave liability and accrual metrics. Tracks available balances, accrual rates, and projected year-end balances to manage leave liability exposure and ensure policy compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`leave_balance`"
  dimensions:
    - name: "leave_type_code"
      expr: leave_type_code
      comment: "Leave type code for balance analysis by leave category."
    - name: "leave_type_name"
      expr: leave_type_name
      comment: "Human-readable leave type name for reporting."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Employee eligibility status for leave type compliance monitoring."
    - name: "policy_tier"
      expr: policy_tier
      comment: "Leave policy tier for benefit level segmentation."
    - name: "balance_as_of_month"
      expr: DATE_TRUNC('month', balance_as_of_date)
      comment: "Month of balance snapshot for trend analysis of leave liability over time."
  measures:
    - name: "total_available_balance_days"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available leave balance days across all employees. Represents the organization's leave liability exposure."
    - name: "total_liability_amount"
      expr: SUM(CAST(liability_amount AS DOUBLE))
      comment: "Total financial liability for accrued leave. Critical for balance sheet reporting and financial planning."
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available leave balance per employee. Benchmarks leave utilization and identifies employees at risk of forfeiture."
    - name: "total_forfeited_balance"
      expr: SUM(CAST(forfeited_balance AS DOUBLE))
      comment: "Total forfeited leave days. High forfeiture indicates employees are not taking adequate leave, a wellness and retention risk signal."
    - name: "total_projected_year_end_balance"
      expr: SUM(CAST(projected_year_end_balance AS DOUBLE))
      comment: "Total projected year-end leave balance. Used for year-end liability forecasting and budget planning."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(accrual_rate AS DOUBLE))
      comment: "Average leave accrual rate. Used to validate policy consistency and model future liability growth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline and recruiting efficiency metrics. Tracks open requisitions, time-to-fill, salary range competitiveness, and hiring funnel health to support workforce planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current requisition status (Open, Filled, Cancelled) for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (backfill, new headcount, contract) for hiring demand analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for workforce composition planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority for resource allocation in recruiting operations."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Whether the role is remote-eligible for talent market reach analysis."
    - name: "open_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month requisition was opened for hiring volume trend analysis."
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO job category for diversity hiring compliance reporting."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of requisitions. Baseline hiring demand volume metric."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN 1 END)
      comment: "Count of currently open requisitions. Primary talent acquisition pipeline depth KPI for workforce planning."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST((salary_range_minimum + salary_range_maximum) AS DOUBLE) / 2.0)
      comment: "Average midpoint of salary ranges across requisitions. Used to benchmark compensation competitiveness against market."
    - name: "avg_salary_range_spread"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE) - CAST(salary_range_minimum AS DOUBLE))
      comment: "Average salary range spread (max minus min). Indicates compensation flexibility and grade band width for negotiation."
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(close_date, open_date))
      comment: "Average days from requisition open to close. Key recruiting efficiency KPI; high values indicate bottlenecks in the hiring process."
    - name: "security_clearance_required_count"
      expr: COUNT(CASE WHEN security_clearance_required = TRUE THEN 1 END)
      comment: "Count of requisitions requiring security clearance. Used for specialized recruiting resource planning in broadcast operations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development effectiveness metrics. Tracks training completion rates, assessment scores, certification outcomes, and training costs to optimize L&D investment and ensure regulatory compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Training enrollment status (Enrolled, Completed, Withdrawn) for completion tracking."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (mandatory, voluntary, regulatory) for compliance vs. development analysis."
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Delivery method (in-person, online, blended) for L&D channel effectiveness analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether training is mandatory. Used to prioritize compliance completion tracking."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether training is required by regulation. Critical for compliance audit readiness."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for training volume trend analysis."
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Whether a certificate was issued upon completion. Tracks credentialing outcomes."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments. Baseline L&D activity volume metric."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments completed. Primary L&D effectiveness KPI; low rates for mandatory training trigger compliance escalation."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across completed training. Measures knowledge retention and training quality effectiveness."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training expenditure. Used for L&D budget management and ROI analysis."
    - name: "avg_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training enrollment. Benchmarks L&D spend efficiency across delivery methods and providers."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed. Measures L&D investment in employee development and regulatory compliance hours."
    - name: "regulatory_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE AND enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for regulatory-required training. Critical compliance KPI; below 100% triggers immediate remediation."
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Withdrawn' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments withdrawn. High withdrawal rates signal scheduling conflicts, course quality issues, or workload problems."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and headcount budget metrics. Tracks approved FTE targets, budget utilization, attrition assumptions, and diversity hiring goals to support strategic workforce planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_approval_status"
      expr: plan_approval_status
      comment: "Approval status of the headcount plan for governance tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (annual, rolling, scenario) for planning cycle analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan for year-over-year workforce planning comparison."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce composition and skills planning analysis."
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (base, optimistic, conservative) for scenario-based workforce modeling."
    - name: "critical_role_flag"
      expr: critical_role_flag
      comment: "Whether the plan covers critical roles. Used to prioritize succession and retention investments."
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_count AS DOUBLE))
      comment: "Total approved FTE headcount across plans. Primary workforce capacity planning KPI for budget and resource allocation."
    - name: "total_current_filled_fte"
      expr: SUM(CAST(current_filled_fte AS DOUBLE))
      comment: "Total currently filled FTE positions. Measures actual staffing against approved headcount."
    - name: "total_variance_fte"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (approved minus filled). Negative values indicate overstaffing; positive values indicate open capacity."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total headcount budget across plans. Used for workforce cost planning and budget variance analysis."
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percentage AS DOUBLE))
      comment: "Average attrition assumption used in headcount planning. Benchmarks planning assumptions against actual attrition for forecast accuracy."
    - name: "avg_diversity_hiring_target_pct"
      expr: AVG(CAST(diversity_hiring_target_percentage AS DOUBLE))
      comment: "Average diversity hiring target percentage. Tracks DEI commitment in workforce planning and hiring strategy."
    - name: "headcount_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(current_filled_fte AS DOUBLE)) / NULLIF(SUM(CAST(approved_fte_count AS DOUBLE)), 0), 2)
      comment: "Percentage of approved FTE positions currently filled. Key operational readiness KPI; low rates indicate hiring gaps affecting business capacity."
    - name: "total_contractor_fte"
      expr: SUM(CAST(contractor_fte_count AS DOUBLE))
      comment: "Total contractor FTE in headcount plans. Tracks contingent workforce dependency and associated cost/risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_separation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee attrition and offboarding metrics. Tracks separation volumes, types, severance costs, and rehire eligibility to support retention strategy and workforce continuity planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`separation_record`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary, retirement) for attrition root cause analysis."
    - name: "separation_reason_code"
      expr: separation_reason_code
      comment: "Coded reason for separation for structured attrition analysis and trend reporting."
    - name: "separation_status"
      expr: separation_status
      comment: "Current status of the separation process for offboarding completion tracking."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Whether the employee is eligible for rehire. Used for talent pool management and boomerang employee strategy."
    - name: "severance_eligible_flag"
      expr: severance_eligible_flag
      comment: "Whether the employee is eligible for severance. Used for financial liability planning."
    - name: "separation_month"
      expr: DATE_TRUNC('month', separation_date)
      comment: "Month of separation for attrition trend analysis and seasonal pattern identification."
    - name: "exit_interview_completed_flag"
      expr: exit_interview_completed_flag
      comment: "Whether an exit interview was completed. Tracks offboarding quality and insight capture rate."
  measures:
    - name: "total_separations"
      expr: COUNT(1)
      comment: "Total number of employee separations. Primary attrition volume metric for workforce stability analysis."
    - name: "voluntary_separations"
      expr: COUNT(CASE WHEN separation_type = 'Voluntary' THEN 1 END)
      comment: "Count of voluntary separations. Voluntary attrition is the primary retention risk signal for leadership action."
    - name: "involuntary_separations"
      expr: COUNT(CASE WHEN separation_type = 'Involuntary' THEN 1 END)
      comment: "Count of involuntary separations. Tracks workforce restructuring activity and associated legal/HR risk."
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance paid to separated employees. Key financial liability metric for workforce restructuring cost management."
    - name: "avg_severance_weeks"
      expr: AVG(CAST(severance_weeks AS DOUBLE))
      comment: "Average severance weeks granted. Benchmarks severance policy consistency and cost per separation."
    - name: "total_final_paycheck_amount"
      expr: SUM(CAST(final_paycheck_amount AS DOUBLE))
      comment: "Total final paycheck amounts for separated employees. Used for payroll closure cost tracking."
    - name: "exit_interview_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_interview_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of separations with completed exit interviews. Low rates reduce insight into attrition drivers, a talent strategy risk."
    - name: "rehire_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rehire_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of separated employees eligible for rehire. Indicates quality of separations and boomerang talent pool size."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure and cost metrics. Tracks salary levels, bonus eligibility, pay equity, and compensation plan status to support total rewards strategy and budget planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Compensation plan status for active plan governance."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan (base, incentive, executive) for total rewards analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency for payroll cycle planning."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation equity and band analysis."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt/non-exempt) for overtime compliance analysis."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether the plan includes bonus eligibility for incentive compensation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency compensation reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation plan became effective for trend analysis."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all active compensation plans. Primary fixed labor cost KPI for budget planning and P&L management."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary. Used for compensation benchmarking, pay equity analysis, and market competitiveness assessment."
    - name: "avg_target_bonus_pct"
      expr: AVG(CAST(target_bonus_percent AS DOUBLE))
      comment: "Average target bonus percentage. Quantifies variable pay commitment for incentive budget planning."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage. Used for sales compensation plan design and cost modeling."
    - name: "bonus_eligible_count"
      expr: COUNT(CASE WHEN bonus_eligible = TRUE THEN 1 END)
      comment: "Count of employees on bonus-eligible compensation plans. Quantifies incentive plan participation for budget forecasting."
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average standard hours per week across compensation plans. Used for FTE calculation and labor cost normalization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and disciplinary metrics. Tracks disciplinary action volumes, types, outcomes, and escalation rates to support HR risk management and workplace conduct governance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination) for severity analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the disciplinary action for case management tracking."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of policy violation for root cause and pattern analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the disciplinary action for effectiveness measurement."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed. High appeal rates signal fairness concerns in disciplinary processes."
    - name: "termination_triggered_flag"
      expr: termination_triggered_flag
      comment: "Whether the action resulted in termination. Used for involuntary attrition analysis."
    - name: "action_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month of disciplinary action for trend and seasonality analysis."
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions issued. Baseline employee relations risk volume metric."
    - name: "termination_triggered_count"
      expr: COUNT(CASE WHEN termination_triggered_flag = TRUE THEN 1 END)
      comment: "Count of disciplinary actions that resulted in termination. Tracks involuntary attrition driven by conduct issues."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions that were appealed. High rates indicate process fairness issues requiring HR policy review."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Count of disciplinary actions requiring legal review. Quantifies legal risk exposure from employee relations cases."
    - name: "suspension_days_total"
      expr: SUM(DATEDIFF(suspension_end_date, suspension_start_date))
      comment: "Total suspension days issued. Measures productivity impact and severity of disciplinary outcomes."
    - name: "union_notification_required_count"
      expr: COUNT(CASE WHEN union_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of disciplinary actions requiring union notification. Critical for labor relations compliance and CBA adherence."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost metrics. Tracks enrollment rates, premium costs, employer contributions, and benefit plan utilization to support total rewards strategy and benefits budget management."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Benefit enrollment status (Active, Terminated, Waived) for participation analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Benefit plan type (medical, dental, vision, 401k) for benefits mix analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for cost tier analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Benefit plan year for year-over-year cost and participation trend analysis."
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying life event triggering enrollment change for benefits administration analysis."
    - name: "wellness_program_participant_flag"
      expr: wellness_program_participant_flag
      comment: "Whether the employee participates in wellness programs. Used for wellness ROI and health cost correlation analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total benefit enrollments. Baseline benefits participation volume metric."
    - name: "total_premium_cost"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total benefit premium cost. Primary benefits cost KPI for total rewards budget management."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution to benefits. Measures the organization's benefits investment and cost per employee."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution to benefits. Used for cost-sharing analysis and benefits affordability assessment."
    - name: "avg_premium_per_enrollment"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium per enrollment. Benchmarks benefits cost efficiency and plan design competitiveness."
    - name: "employer_cost_share_rate"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Employer share of total benefit premiums as a percentage. Measures benefits generosity and competitiveness of the total rewards package."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Waived' THEN 1 END)
      comment: "Count of benefit waivers. High waiver rates may indicate affordability issues or coverage gaps in the benefits offering."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and timesheet compliance metrics. Tracks regular, overtime, and PTO hours, approval rates, and payroll processing status to support labor cost management and workforce scheduling."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval status for process compliance monitoring."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the timesheet has been processed in payroll. Used for payroll cycle completion tracking."
    - name: "pay_period_month"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Pay period month for labor hours trend analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for labor cost analysis by compensation level."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours submitted. Primary labor utilization metric for capacity planning and productivity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours submitted. High overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours taken. Used for leave liability management and workforce availability planning."
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total approved hours across all timesheets. Authoritative labor hours figure for payroll and cost allocation."
    - name: "timesheet_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timesheets approved. Low rates indicate process bottlenecks affecting payroll processing timeliness."
    - name: "overtime_hours_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of regular hours. Key labor efficiency KPI; high ratios trigger staffing and scheduling reviews."
    - name: "avg_hours_submitted_per_timesheet"
      expr: AVG(CAST(total_hours_submitted AS DOUBLE))
      comment: "Average total hours submitted per timesheet. Benchmarks workforce utilization and identifies anomalous time reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and grievance management metrics. Tracks grievance volumes, resolution rates, severity, and union involvement to support HR risk management and labor relations governance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance (harassment, discrimination, wage dispute) for root cause analysis."
    - name: "grievance_status"
      expr: grievance_status
      comment: "Current status of the grievance for case management and resolution tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the grievance for risk prioritization and escalation management."
    - name: "union_involved_flag"
      expr: union_involved_flag
      comment: "Whether the union is involved. Used for labor relations risk monitoring and CBA compliance."
    - name: "external_agency_reported_flag"
      expr: external_agency_reported_flag
      comment: "Whether the grievance was reported to an external agency (EEOC, NLRB). Indicates elevated legal and reputational risk."
    - name: "retaliation_reported_flag"
      expr: retaliation_reported_flag
      comment: "Whether retaliation was reported. Critical risk indicator requiring immediate HR and legal escalation."
    - name: "filed_month"
      expr: DATE_TRUNC('month', filed_date)
      comment: "Month grievance was filed for trend and seasonality analysis."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total grievances filed. Primary employee relations risk volume metric for HR governance."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN grievance_status NOT IN ('Resolved', 'Closed', 'Withdrawn') THEN 1 END)
      comment: "Count of unresolved grievances. Tracks active HR risk exposure and case backlog requiring management attention."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN grievance_status IN ('Resolved', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances resolved. Measures HR effectiveness in addressing employee concerns and reducing legal risk."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, filed_date))
      comment: "Average days from grievance filing to resolution. Long resolution times increase legal exposure and employee dissatisfaction."
    - name: "external_agency_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_agency_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances escalated to external agencies. High rates signal systemic HR failures with significant legal and reputational risk."
    - name: "retaliation_claim_count"
      expr: COUNT(CASE WHEN retaliation_reported_flag = TRUE THEN 1 END)
      comment: "Count of grievances with retaliation claims. Critical legal risk KPI requiring immediate executive attention and remediation."
    - name: "union_grievance_count"
      expr: COUNT(CASE WHEN union_involved_flag = TRUE THEN 1 END)
      comment: "Count of union-involved grievances. Tracks labor relations health and CBA compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance and skills currency metrics. Tracks certification status, expiry risk, regulatory requirements, and continuing education to ensure workforce competency and compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (Active, Expired, Pending) for compliance monitoring."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification for skills inventory and gap analysis."
    - name: "certification_category"
      expr: certification_category
      comment: "Certification category for workforce competency domain analysis."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the certification is required by regulation. Critical for compliance audit readiness."
    - name: "is_required_for_role"
      expr: is_required_for_role
      comment: "Whether the certification is required for the employee's role. Used for role-based compliance tracking."
    - name: "employer_sponsored"
      expr: employer_sponsored
      comment: "Whether the certification was employer-sponsored. Used for L&D investment tracking."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of certification expiry for renewal pipeline planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Baseline workforce credentials inventory metric."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications. Measures current workforce compliance and competency currency."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Certifications expiring within 90 days. Critical compliance risk KPI for proactive renewal management."
    - name: "regulatory_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE AND certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of regulatory-required certifications that are currently active. Below 100% represents a compliance violation risk."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications. Used for L&D budget management and ROI analysis of credentialing investments."
    - name: "avg_exam_score"
      expr: AVG(CAST(exam_score AS DOUBLE))
      comment: "Average certification exam score. Measures workforce competency depth and training effectiveness."
    - name: "avg_continuing_education_hours_completed"
      expr: AVG(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed. Tracks workforce investment in ongoing professional development."
$$;