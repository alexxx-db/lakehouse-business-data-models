-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift-level KPIs covering labor cost, hours utilization, overtime exposure, and scheduling adherence. Used by restaurant GMs and workforce planners to manage daily labor efficiency."
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the shift, used for daily and weekly trend analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late-night) for intra-day labor analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (regular, split, on-call) for workforce mix analysis."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (scheduled, completed, no-show, cancelled)."
    - name: "station"
      expr: station
      comment: "Kitchen or service station assignment for station-level labor analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift incurred overtime, used to flag overtime exposure."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Indicates whether the shift was an on-call assignment."
  measures:
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total number of shifts. Baseline volume metric for workforce scheduling coverage."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts. Primary cost driver for restaurant P&L management."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Benchmarks cost efficiency across dayparts and stations."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Used to assess planned labor coverage."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total hours actually worked. Compared against scheduled hours to measure adherence."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of sales per shift. Core restaurant profitability KPI."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Number of shifts that incurred overtime. Drives compliance risk and cost overrun alerts."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(scheduled_hours AS DOUBLE))
      comment: "Total variance between actual and scheduled hours. Negative = under-staffing; positive = over-staffing."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average hourly labor rate across shifts. Used for wage benchmarking and budget variance analysis."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per shift. Monitors compliance with mandatory break regulations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular clock-in/clock-out KPIs for labor cost accuracy, overtime detection, and missed-punch compliance. Used by payroll managers and operations directors."
  source: "`vibe_restaurants_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the time entry, used for daily labor cost reporting."
    - name: "job_role"
      expr: job_role
      comment: "Employee job role at time of entry, for role-level labor cost analysis."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, break) for payroll classification."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of the time entry (approved, pending, disputed) for payroll readiness tracking."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the entry includes overtime hours."
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Indicates a missed clock-in or clock-out punch, a compliance and payroll accuracy risk."
    - name: "approved_by_manager"
      expr: approved_by_manager
      comment: "Whether the time entry has been manager-approved, for payroll lock-down tracking."
  measures:
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total number of time entries. Baseline volume for payroll processing completeness."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Core input for straight-time payroll calculation."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Directly drives premium labor cost and compliance exposure."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked including regular and overtime. Used for labor cost and productivity analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Primary payroll cost driver for restaurant operations."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average effective labor rate per hour. Used for wage benchmarking and budget variance."
    - name: "missed_punch_count"
      expr: COUNT(CASE WHEN missed_punch_flag = TRUE THEN 1 END)
      comment: "Number of missed punch events. High counts indicate timekeeping compliance risk and payroll inaccuracy."
    - name: "unapproved_entry_count"
      expr: COUNT(CASE WHEN approved_by_manager = FALSE THEN 1 END)
      comment: "Number of time entries not yet manager-approved. Blocks payroll finalization and indicates process gaps."
    - name: "overtime_entry_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Number of entries with overtime. Used to identify overtime concentration by role or unit."
    - name: "avg_total_hours_per_entry"
      expr: AVG(CAST(total_hours AS DOUBLE))
      comment: "Average hours per time entry. Detects anomalously long or short shifts for audit purposes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation KPIs for financial reporting, labor cost management, and workforce cost benchmarking. Used by finance, HR, and operations leadership."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: pay_period_start
      comment: "Start date of the pay period for period-over-period payroll trend analysis."
    - name: "pay_period_end"
      expr: pay_period_end
      comment: "End date of the pay period for payroll cycle reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for alignment with financial reporting cycles."
    - name: "employee_type"
      expr: employee_type
      comment: "Employee classification (full-time, part-time, seasonal) for workforce cost segmentation."
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level compensation benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll amounts for multi-currency reporting."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll tax reporting and compliance."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Indicates whether the record includes a bonus payment for incentive cost tracking."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates union membership for union vs. non-union labor cost comparison."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost metric for P&L and budget variance reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Used for cash flow and payroll funding planning."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total taxes withheld across all payroll records. Required for tax liability reporting."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions. Used to track total compensation cost including benefits."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments. Tracks incentive compensation spend against budget."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips included in payroll. Used for tip compliance and total compensation reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours across payroll records. Drives premium labor cost and compliance risk."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of sales. Core restaurant profitability KPI for executive review."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across employees. Used for wage benchmarking and equity analysis."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours paid. Used to compute straight-time labor cost and productivity ratios."
    - name: "total_other_deductions"
      expr: SUM(CAST(other_deductions AS DOUBLE))
      comment: "Total miscellaneous deductions. Ensures full compensation cost visibility for finance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning KPIs for tracking budgeted vs. estimated labor costs, FTE targets, and labor percentage goals by unit and period. Used by finance and operations leadership for budget cycle management."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget tracking and variance reporting."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the budget period for time-series budget analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the budget period."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for intra-day labor budget allocation analysis."
    - name: "scenario"
      expr: scenario
      comment: "Budget scenario (base, optimistic, conservative) for scenario planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of budget amounts for multi-currency reporting."
    - name: "version"
      expr: version
      comment: "Budget version for tracking revisions and comparing original vs. revised budgets."
  measures:
    - name: "total_labor_dollar_budget"
      expr: SUM(CAST(labor_dollar_budget AS DOUBLE))
      comment: "Total budgeted labor dollars. Primary financial planning metric for workforce cost management."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost. Used to compare budget vs. estimate for variance analysis."
    - name: "total_hours_budget"
      expr: SUM(CAST(hours_budget_total AS DOUBLE))
      comment: "Total budgeted labor hours. Used for staffing level planning and scheduling."
    - name: "total_fte_budget"
      expr: SUM(CAST(fte_budget_total AS DOUBLE))
      comment: "Total budgeted FTE count. Used for headcount planning and organizational sizing."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average targeted labor cost percentage. Core restaurant profitability planning KPI."
    - name: "total_boh_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate_boh AS DOUBLE))
      comment: "Total back-of-house labor cost estimate. Used for kitchen staffing cost management."
    - name: "total_foh_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate_foh AS DOUBLE))
      comment: "Total front-of-house labor cost estimate. Used for service staffing cost management."
    - name: "avg_labor_percent_target_boh"
      expr: AVG(CAST(labor_percent_target_boh AS DOUBLE))
      comment: "Average BOH labor percentage target. Benchmarks kitchen labor efficiency goals."
    - name: "avg_labor_percent_target_foh"
      expr: AVG(CAST(labor_percent_target_foh AS DOUBLE))
      comment: "Average FOH labor percentage target. Benchmarks service labor efficiency goals."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor demand forecasting KPIs for projected FTE needs, labor cost estimates, and forecast accuracy. Used by workforce planners and operations managers to optimize staffing levels."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date for which the labor forecast applies, used for daily and weekly planning."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for intra-day staffing demand forecasting."
    - name: "labor_forecast_status"
      expr: labor_forecast_status
      comment: "Status of the forecast (draft, approved, published) for forecast lifecycle management."
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (base, upside, downside) for scenario-based planning."
    - name: "lto_flag"
      expr: lto_flag
      comment: "Indicates whether a limited-time offer is active, which affects demand and staffing needs."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether a promotion is active, which affects traffic and labor demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of forecast cost amounts."
  measures:
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total forecasted labor cost. Used to project future labor spend and compare against budget."
    - name: "avg_projected_labor_percent"
      expr: AVG(CAST(projected_labor_percent AS DOUBLE))
      comment: "Average projected labor cost as a percentage of sales. Core forward-looking profitability KPI."
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected BOH FTE demand. Used for kitchen staffing planning and scheduling."
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected FOH FTE demand. Used for service staffing planning and scheduling."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average forecast confidence score. Low scores indicate unreliable forecasts requiring manual review."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records. Used to assess forecast coverage completeness across units and dates."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_tip_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tip compliance KPIs for monitoring declared vs. allocated tips, minimum wage gap exposure, and regulatory compliance status. Used by payroll managers and legal/compliance teams."
  source: "`vibe_restaurants_v1`.`workforce`.`tip_compliance`"
  dimensions:
    - name: "compliance_date"
      expr: compliance_date
      comment: "Date of the compliance record for period-over-period compliance trend analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (compliant, non-compliant, under-review) for compliance dashboard filtering."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period label for regulatory submission grouping."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start date of the reporting period."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End date of the reporting period."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance flag for quick compliant vs. non-compliant segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of tip amounts for multi-currency reporting."
  measures:
    - name: "total_declared_tips"
      expr: SUM(CAST(declared_tips_amount AS DOUBLE))
      comment: "Total tips declared by employees. Used to assess tip reporting completeness and accuracy."
    - name: "total_allocated_tips"
      expr: SUM(CAST(allocated_tips_amount AS DOUBLE))
      comment: "Total tips allocated by the employer. Compared against declared tips to identify under-reporting."
    - name: "total_reported_tips"
      expr: SUM(CAST(reported_tips_amount AS DOUBLE))
      comment: "Total tips reported for tax purposes. Required for IRS Form 8027 and regulatory compliance."
    - name: "total_minimum_wage_shortfall"
      expr: SUM(CAST(minimum_wage_shortfall AS DOUBLE))
      comment: "Total minimum wage shortfall amount. Quantifies employer liability when tip credit does not cover minimum wage gap."
    - name: "total_tip_pool_contribution"
      expr: SUM(CAST(tip_pool_contribution AS DOUBLE))
      comment: "Total tips contributed to the tip pool. Used for tip pool compliance and distribution auditing."
    - name: "total_tip_pool_distribution"
      expr: SUM(CAST(tip_pool_distribution AS DOUBLE))
      comment: "Total tips distributed from the tip pool. Compared against contributions to verify pool balance."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN is_compliant = FALSE THEN 1 END)
      comment: "Number of non-compliant tip records. Drives regulatory risk alerts and corrective action prioritization."
    - name: "avg_effective_hourly_rate"
      expr: AVG(CAST(effective_hourly_rate AS DOUBLE))
      comment: "Average effective hourly rate including tips. Used to verify minimum wage compliance across tipped employees."
    - name: "avg_tip_rate_pct"
      expr: AVG(CAST(tip_rate_pct AS DOUBLE))
      comment: "Average tip rate as a percentage of sales. Benchmarks tipping behavior and informs tip credit calculations."
    - name: "total_shortfall_amount"
      expr: SUM(CAST(shortfall_amount AS DOUBLE))
      comment: "Total shortfall amount requiring employer make-up pay. Direct financial liability metric for compliance management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor law violation KPIs for tracking violation frequency, financial penalties, severity, and resolution status. Used by HR compliance, legal, and operations leadership to manage regulatory risk."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of labor violation (overtime, break, wage) for violation category analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation (low, medium, high, critical) for risk prioritization."
    - name: "labor_violation_status"
      expr: labor_violation_status
      comment: "Current status of the violation (open, resolved, escalated) for case management tracking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the violation occurred for operational pattern analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the violation for jurisdiction-level compliance reporting."
    - name: "detection_method"
      expr: detection_method
      comment: "How the violation was detected (automated, manual, audit) for process improvement analysis."
    - name: "compliance_reported"
      expr: compliance_reported
      comment: "Whether the violation has been reported to the regulatory body."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of labor violations. Primary compliance risk metric for executive and legal review."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines assessed for labor violations. Quantifies direct financial exposure from non-compliance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred. Includes fines and other regulatory penalties for full liability assessment."
    - name: "total_overtime_hours_in_violation"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours associated with violations. Used to quantify overtime compliance exposure."
    - name: "open_violation_count"
      expr: COUNT(CASE WHEN labor_violation_status = 'open' THEN 1 END)
      comment: "Number of unresolved violations. High open counts indicate systemic compliance risk requiring intervention."
    - name: "avg_fine_per_violation"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine per violation. Used to benchmark penalty severity and prioritize corrective actions."
    - name: "unreported_violation_count"
      expr: COUNT(CASE WHEN compliance_reported = FALSE THEN 1 END)
      comment: "Number of violations not yet reported to regulators. Indicates regulatory reporting backlog and risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance KPIs for tracking ratings, competency scores, food safety compliance, and promotion readiness. Used by HR and operations leadership for talent management decisions."
  source: "`vibe_restaurants_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probationary) for review cycle analysis."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the review (draft, submitted, acknowledged) for completion tracking."
    - name: "department"
      expr: department
      comment: "Department of the reviewed employee for department-level performance benchmarking."
    - name: "review_period_start"
      expr: review_period_start
      comment: "Start of the review period for cohort-based performance trend analysis."
    - name: "review_period_end"
      expr: review_period_end
      comment: "End of the review period."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Whether the employee was recommended for promotion, for talent pipeline analysis."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Whether the review triggered a corrective action, for performance risk tracking."
    - name: "training_completed"
      expr: training_completed
      comment: "Whether required training was completed prior to review, for compliance linkage."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews completed. Baseline for review cycle completion rate."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating. Primary talent quality KPI for workforce health assessment."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score. Critical compliance KPI for restaurant brand standard adherence."
    - name: "avg_guest_service_score"
      expr: AVG(CAST(guest_service_score AS DOUBLE))
      comment: "Average guest service score. Directly linked to guest satisfaction and revenue outcomes."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score_total AS DOUBLE))
      comment: "Average total competency score. Used for skills gap analysis and training investment decisions."
    - name: "promotion_recommendation_count"
      expr: COUNT(CASE WHEN promotion_recommendation = TRUE THEN 1 END)
      comment: "Number of employees recommended for promotion. Tracks internal talent pipeline depth."
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END)
      comment: "Number of reviews triggering corrective actions. Indicates performance risk concentration."
    - name: "avg_labor_percentage_actual"
      expr: AVG(CAST(labor_percentage_actual AS DOUBLE))
      comment: "Average actual labor percentage at time of review. Links individual performance to unit-level cost outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification compliance KPIs for tracking certification coverage, expiration risk, and mandatory certification gaps. Used by HR compliance and operations managers."
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (food handler, ServSafe, HACCP) for certification category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending) for compliance dashboard filtering."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certification for regulatory reporting."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for accreditation tracking."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role, for compliance gap prioritization."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires renewal, for proactive expiration management."
    - name: "related_role"
      expr: related_role
      comment: "Job role associated with the certification for role-level compliance analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certification records. Baseline for certification coverage assessment."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN 1 END)
      comment: "Number of currently active certifications. Used to assess workforce compliance readiness."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN 1 END)
      comment: "Number of expired certifications. High counts indicate compliance risk and potential regulatory exposure."
    - name: "mandatory_non_compliant_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND compliance_status != 'compliant' THEN 1 END)
      comment: "Number of mandatory certifications that are non-compliant. Critical risk metric for health and safety audits."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with at least one certification record. Used for workforce compliance coverage rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management KPIs for tracking leave utilization, approval rates, payroll impact, and coverage gaps. Used by HR managers and operations directors for workforce availability planning."
  source: "`vibe_restaurants_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of leave request (vacation, sick, FMLA, personal) for leave category analysis."
    - name: "request_status"
      expr: request_status
      comment: "Status of the leave request (pending, approved, denied) for approval pipeline tracking."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the leave period for time-series leave demand analysis."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Whether the leave is paid, for paid vs. unpaid leave cost analysis."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Whether the leave has a payroll impact, for payroll planning and cost forecasting."
    - name: "coverage_needed_flag"
      expr: coverage_needed_flag
      comment: "Whether coverage is needed for the absent employee, for scheduling gap management."
    - name: "backfill_assigned_flag"
      expr: backfill_assigned_flag
      comment: "Whether a backfill has been assigned, for coverage gap resolution tracking."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests. Baseline for leave demand and HR workload assessment."
    - name: "total_days_requested"
      expr: SUM(CAST(leave_days_requested AS DOUBLE))
      comment: "Total leave days requested. Used to quantify workforce availability impact."
    - name: "total_days_approved"
      expr: SUM(CAST(leave_days_approved AS DOUBLE))
      comment: "Total leave days approved. Used to measure actual workforce availability reduction."
    - name: "coverage_gap_count"
      expr: COUNT(CASE WHEN coverage_needed_flag = TRUE AND backfill_assigned_flag = FALSE THEN 1 END)
      comment: "Number of leave requests with coverage needed but no backfill assigned. Indicates operational risk from staffing gaps."
    - name: "payroll_impact_request_count"
      expr: COUNT(CASE WHEN payroll_impact_flag = TRUE THEN 1 END)
      comment: "Number of leave requests with payroll impact. Used for payroll cost forecasting during leave periods."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance remaining after approval. Used to monitor leave liability and accrual management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and assessment KPIs for tracking workforce skill development, compliance training coverage, and assessment performance. Used by HR and operations leadership."
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of training (food safety, customer service, operations) for training investment analysis."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e-learning, in-person, on-the-job) for delivery method effectiveness analysis."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Status of the training completion (completed, in-progress, failed) for completion rate tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record for regulatory training requirement tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for training effectiveness and cost-per-completion analysis."
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Whether the employee passed the training assessment, for pass rate analysis."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether the training leads to a required certification, for compliance training prioritization."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which training was conducted for scheduling impact analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completions. Baseline for workforce development activity volume."
    - name: "assessment_pass_count"
      expr: COUNT(CASE WHEN assessment_passed = TRUE THEN 1 END)
      comment: "Number of training completions where the assessment was passed. Used to compute pass rates."
    - name: "assessment_fail_count"
      expr: COUNT(CASE WHEN assessment_passed = FALSE THEN 1 END)
      comment: "Number of failed assessments. High counts indicate training effectiveness gaps requiring curriculum review."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score. Used to benchmark training quality and identify knowledge gaps."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_minutes AS DOUBLE) / 60.0)
      comment: "Total training hours invested. Used to quantify workforce development spend and ROI."
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average training duration in minutes. Used for training program design and scheduling planning."
    - name: "distinct_trained_employees"
      expr: COUNT(DISTINCT training_employee_id)
      comment: "Number of distinct employees who completed training. Used to measure training coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics for headcount, compensation, and labor allocation."
  source: "`vibe_restaurants_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Unique employee identifier"
    - name: "department"
      expr: department
      comment: "Department name"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full‑time, part‑time, etc.)"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
    - name: "union_member"
      expr: union_member
      comment: "Union membership flag"
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "ServSafe certification status"
  measures:
    - name: "employee_count"
      expr: COUNT(1)
      comment: "Number of employee records"
    - name: "total_salary_amount"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary amount across all employees"
    - name: "average_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary amount per employee"
    - name: "average_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target across employees"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run financial metrics for cost and payout analysis."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll run"
    - name: "pay_cycle"
      expr: pay_cycle
      comment: "Pay cycle (e.g., weekly, bi‑weekly)"
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll (e.g., regular, bonus)"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
  measures:
    - name: "run_record_count"
      expr: COUNT(1)
      comment: "Number of payroll run records"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll amount after deductions"
    - name: "total_deductions_amount"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total payroll deductions"
$$;