-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor cost and efficiency metrics derived from payroll records. Enables executives to monitor total labor spend, overtime exposure, net pay obligations, and labor-as-a-percent-of-revenue targets by unit, period, and employee type."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: pay_period_start
      comment: "Start date of the pay period — used to trend labor cost over time."
    - name: "pay_period_end"
      expr: pay_period_end
      comment: "End date of the pay period — used to bound labor cost windows."
    - name: "employee_type"
      expr: employee_type
      comment: "Classification of the employee (e.g. full-time, part-time, seasonal) — enables labor cost segmentation."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (e.g. regular, bonus, off-cycle) — allows filtering to core recurring labor cost."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the employee in this payroll record — enables role-level labor cost analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period label for the payroll record — aligns labor cost to financial reporting cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payroll amounts are denominated — required for multi-currency operations."
    - name: "payroll_record_status"
      expr: payroll_record_status
      comment: "Processing status of the payroll record (e.g. processed, pending, voided) — filter to finalized records for accurate reporting."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the employee is a union member — enables union vs. non-union labor cost comparison."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Flags records that represent bonus payments — allows separation of base labor from incentive pay."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all records. Primary labor cost KPI used in P&L and labor-percent-of-sales analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees after deductions. Reflects actual cash outflow for payroll obligations."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid across all payroll records. High overtime signals scheduling inefficiency or understaffing."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours paid. Baseline for workforce capacity and scheduling analysis."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions withheld from payroll. Tracks the employee-side cost of benefit programs."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total taxes withheld across all payroll records. Used for tax compliance reporting and cash flow planning."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts reported through payroll. Relevant for tip compliance monitoring and total compensation analysis."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor-as-a-percent-of-sales across payroll records. Core operational efficiency KPI benchmarked against targets."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average hourly or salary pay rate across payroll records. Used to monitor wage inflation and pay equity."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments made. Tracks incentive pay spend relative to performance outcomes."
    - name: "overtime_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE) + CAST(overtime_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours paid. Elevated ratio signals scheduling or staffing problems requiring intervention."
    - name: "headcount_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees who received a payroll record in the period. Tracks active paid headcount."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift_operations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift metrics covering scheduling adherence, labor cost per shift, overtime exposure, and daypart staffing levels. Used by operations managers and workforce planners to optimize scheduling and control labor costs."
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for daily and weekly shift analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late-night) during which the shift falls — enables daypart-level staffing analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. opening, closing, mid) — used to analyze staffing patterns by shift category."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (e.g. completed, no-show, cancelled) — filter to completed shifts for actuals."
    - name: "station"
      expr: station
      comment: "Work station assignment for the shift (e.g. drive-thru, grill, front counter) — enables station-level labor analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift incurred overtime — used to identify overtime concentration by unit or daypart."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Indicates whether the shift was an on-call assignment — tracks on-call labor utilization."
    - name: "labor_rate_currency_code"
      expr: labor_rate_currency_code
      comment: "Currency of the labor rate for this shift — required for multi-currency labor cost reporting."
  measures:
    - name: "total_shift_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts. Primary cost KPI for shift-level operational management."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Baseline for workforce planning and schedule adherence measurement."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total hours actually worked across all shifts. Compared against scheduled hours to measure adherence."
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0), 2)
      comment: "Actual hours worked as a percentage of scheduled hours. Measures scheduling accuracy and workforce reliability."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average hourly labor rate across shifts. Tracks wage cost trends and informs scheduling decisions."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor-as-a-percent-of-sales at the shift level. Core operational efficiency metric for restaurant management."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN shift_id END)
      comment: "Number of shifts that incurred overtime. High count indicates scheduling gaps or demand spikes requiring corrective action."
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total number of shift records. Baseline volume metric for shift activity."
    - name: "avg_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Benchmarked against targets to identify high-cost shifts or stations."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(scheduled_hours AS DOUBLE))
      comment: "Total variance between actual and scheduled hours (positive = over-scheduled, negative = under-staffed). Drives scheduling optimization."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_budget_vs_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning metrics covering budgeted FTE, hours, and dollar targets by unit, department, and period. Enables finance and operations leadership to track budget utilization and identify variance from plan."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_budget`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the budget period — primary time dimension for budget cycle analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the budget period — bounds the budget window for reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the labor budget — enables annual budget rollup and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period label — aligns labor budget to financial reporting periods."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for which the budget applies — enables daypart-level labor planning."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g. original, revised, stretch) — allows comparison across budget versions."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval status of the budget (e.g. draft, approved, locked) — filter to approved budgets for official reporting."
    - name: "scenario"
      expr: scenario
      comment: "Budget scenario (e.g. base, optimistic, conservative) — enables scenario-based planning analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the labor budget (e.g. BOH, FOH, management) — enables category-level budget analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts — required for multi-currency operations."
  measures:
    - name: "total_labor_dollar_budget"
      expr: SUM(CAST(labor_dollar_budget AS DOUBLE))
      comment: "Total budgeted labor dollars. Primary financial planning KPI for workforce cost management."
    - name: "total_budgeted_hours"
      expr: SUM(CAST(hours_budget_total AS DOUBLE))
      comment: "Total budgeted labor hours across all records. Baseline for capacity planning and schedule building."
    - name: "total_budgeted_fte"
      expr: SUM(CAST(fte_budget_total AS DOUBLE))
      comment: "Total budgeted FTE count. Used to plan headcount requirements and hiring targets."
    - name: "boh_budgeted_hours"
      expr: SUM(CAST(hours_budget_boh AS DOUBLE))
      comment: "Total budgeted back-of-house labor hours. Tracks kitchen staffing investment against operational needs."
    - name: "foh_budgeted_hours"
      expr: SUM(CAST(hours_budget_foh AS DOUBLE))
      comment: "Total budgeted front-of-house labor hours. Tracks guest-facing staffing investment."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average budgeted labor-as-a-percent-of-sales target. Benchmark for operational efficiency planning."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost from the budget. Used to project P&L impact of workforce plans."
    - name: "boh_foh_hours_ratio"
      expr: ROUND(SUM(CAST(hours_budget_boh AS DOUBLE)) / NULLIF(SUM(CAST(hours_budget_foh AS DOUBLE)), 0), 2)
      comment: "Ratio of BOH to FOH budgeted hours. Informs kitchen-to-floor staffing balance decisions."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of labor budget records. Used to verify budget coverage across units and periods."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor forecast accuracy and projection metrics. Enables operations and finance leadership to evaluate forecast quality, projected labor cost, and staffing levels by unit, period, and daypart."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date for which the labor forecast applies — primary time dimension for forecast analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the forecast (breakfast, lunch, dinner) — enables daypart-level staffing projection."
    - name: "labor_forecast_status"
      expr: labor_forecast_status
      comment: "Status of the forecast (e.g. draft, published, superseded) — filter to active forecasts."
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (e.g. base, upside, downside) — enables scenario comparison."
    - name: "lto_flag"
      expr: lto_flag
      comment: "Indicates whether a limited-time offer is active during the forecast period — LTOs drive demand spikes requiring additional staffing."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether a promotion is active — promotions increase traffic and labor demand."
    - name: "week_number"
      expr: week_number
      comment: "Week number within the year — enables weekly staffing trend analysis."
    - name: "year"
      expr: year
      comment: "Year of the forecast — enables year-over-year forecast comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast cost estimates — required for multi-currency operations."
  measures:
    - name: "total_projected_labor_cost"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total projected labor cost from forecasts. Primary forward-looking labor spend KPI for financial planning."
    - name: "avg_projected_labor_percent"
      expr: AVG(CAST(projected_labor_percent AS DOUBLE))
      comment: "Average projected labor-as-a-percent-of-sales. Benchmarked against targets to identify periods of expected over/under-spend."
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected back-of-house FTE from forecasts. Drives kitchen staffing and scheduling decisions."
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected front-of-house FTE from forecasts. Drives guest-facing staffing and scheduling decisions."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for forecasts. Low confidence signals unreliable projections requiring manual review."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records. Used to verify forecast coverage across units and periods."
    - name: "lto_forecast_count"
      expr: COUNT(CASE WHEN lto_flag = TRUE THEN labor_forecast_id END)
      comment: "Number of forecast periods flagged with an active LTO. Tracks LTO-driven demand planning coverage."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_employee_workforce`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee headcount, compensation, and workforce composition metrics. Provides HR and executive leadership with visibility into active headcount, wage levels, overtime eligibility, and workforce demographics for strategic workforce planning."
  source: "`vibe_restaurants_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g. active, terminated, on-leave) — primary filter for active headcount analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (e.g. full-time, part-time, contractor) — enables workforce composition analysis."
    - name: "role_classification"
      expr: role_classification
      comment: "Role classification (e.g. crew, shift-lead, manager) — enables role-level workforce analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade of the employee — used for compensation band analysis and equity reviews."
    - name: "department"
      expr: department
      comment: "Department the employee belongs to — enables department-level headcount and cost analysis."
    - name: "work_schedule_type"
      expr: work_schedule_type
      comment: "Schedule type (e.g. fixed, flexible, rotating) — informs scheduling strategy and labor flexibility."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the employee is eligible for overtime pay — critical for labor cost risk assessment."
    - name: "union_member"
      expr: union_member
      comment: "Indicates union membership — enables union vs. non-union workforce segmentation."
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "Indicates whether the employee holds a valid ServSafe certification — tracks food safety compliance at the workforce level."
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired — used for tenure analysis and cohort-based retention studies."
    - name: "country"
      expr: country
      comment: "Country of the employee — enables geographic workforce distribution analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count. Fundamental headcount KPI for workforce planning and cost modeling."
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total annualized salary cost across all employees. Primary compensation cost KPI for budget planning."
    - name: "avg_salary"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average employee salary. Used for compensation benchmarking and pay equity analysis."
    - name: "overtime_eligible_headcount"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Number of employees eligible for overtime. Quantifies overtime cost exposure for labor risk management."
    - name: "servsafe_certified_count"
      expr: COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END)
      comment: "Number of employees with active ServSafe certification. Tracks food safety compliance coverage across the workforce."
    - name: "servsafe_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of employees who are ServSafe certified. Regulatory compliance KPI — low rate triggers training intervention."
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target set at the employee level. Informs unit-level labor efficiency expectations."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member = TRUE THEN employee_id END)
      comment: "Number of union member employees. Tracks union workforce size for labor relations and contract compliance."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance review metrics covering ratings, food safety scores, guest service scores, and labor efficiency. Used by HR and operations leadership to identify top performers, manage development pipelines, and drive corrective action."
  source: "`vibe_restaurants_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g. annual, mid-year, probationary) — enables comparison across review cycles."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the review (e.g. completed, pending, overdue) — filter to completed reviews for accurate scoring."
    - name: "review_method"
      expr: review_method
      comment: "Method used for the review (e.g. in-person, digital, 360) — tracks review process consistency."
    - name: "rating_scale"
      expr: rating_scale
      comment: "Rating scale used in the review (e.g. 1-5, 1-10) — required for normalizing scores across review types."
    - name: "shift_daypart"
      expr: shift_daypart
      comment: "Daypart associated with the reviewed employee's shift — enables daypart-level performance analysis."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Indicates whether the review triggered a corrective action — tracks disciplinary pipeline volume."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Indicates whether the reviewer recommended promotion — tracks internal talent pipeline health."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the review — ensures appropriate data access controls."
    - name: "review_period_start"
      expr: review_period_start
      comment: "Start of the review period — used to align performance data to operational periods."
    - name: "review_period_end"
      expr: review_period_end
      comment: "End of the review period — bounds the performance evaluation window."
  measures:
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating across all completed reviews. Primary talent quality KPI for HR and operations leadership."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score from performance reviews. Tracks food safety culture and compliance at the workforce level."
    - name: "avg_guest_service_score"
      expr: AVG(CAST(guest_service_score AS DOUBLE))
      comment: "Average guest service score from performance reviews. Directly linked to guest satisfaction and brand reputation."
    - name: "avg_speed_score"
      expr: AVG(CAST(speed_score AS DOUBLE))
      comment: "Average speed-of-service score from performance reviews. Tracks operational throughput quality at the employee level."
    - name: "avg_attendance_score"
      expr: AVG(CAST(attendance_score AS DOUBLE))
      comment: "Average attendance score from performance reviews. Tracks reliability and absenteeism risk across the workforce."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_flag = TRUE THEN performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that triggered a corrective action. Elevated rate signals systemic performance or compliance issues."
    - name: "promotion_recommendation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_recommendation = TRUE THEN performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with a promotion recommendation. Tracks internal talent pipeline depth and succession health."
    - name: "avg_labor_percentage_actual"
      expr: AVG(CAST(labor_percentage_actual AS DOUBLE))
      comment: "Average actual labor percentage recorded during the review period. Measures individual contribution to labor efficiency."
    - name: "total_reviews_completed"
      expr: COUNT(1)
      comment: "Total number of performance reviews. Tracks review program completion and coverage."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score_total AS DOUBLE))
      comment: "Average total competency score across all reviews. Composite skill assessment KPI for talent development planning."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_violations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor compliance violation metrics covering violation frequency, financial penalties, severity, and resolution rates. Used by HR, legal, and operations leadership to manage regulatory risk and drive corrective action."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of labor violation (e.g. missed break, overtime, wage theft) — enables violation category analysis."
    - name: "violation_code"
      expr: violation_code
      comment: "Regulatory violation code — maps violations to specific labor laws and regulations."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation (e.g. minor, major, critical) — prioritizes remediation efforts."
    - name: "labor_violation_status"
      expr: labor_violation_status
      comment: "Current status of the violation (e.g. open, resolved, appealed) — tracks remediation pipeline."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that governs the violation (e.g. DOL, state labor board) — enables jurisdiction-level compliance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the violation occurred — identifies high-risk operational windows."
    - name: "detection_method"
      expr: detection_method
      comment: "How the violation was detected (e.g. audit, employee report, system alert) — informs detection program effectiveness."
    - name: "compliance_reported"
      expr: compliance_reported
      comment: "Indicates whether the violation was reported to a regulatory body — tracks external disclosure obligations."
    - name: "violation_timestamp"
      expr: DATE_TRUNC('month', violation_timestamp)
      comment: "Month of the violation — used to trend violation frequency over time."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of labor violations. Primary compliance risk KPI — rising count triggers regulatory and operational intervention."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines levied for labor violations. Quantifies direct financial exposure from non-compliance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts assessed. Tracks full financial liability from labor compliance failures."
    - name: "total_overtime_hours_violated"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours associated with violations. Quantifies the scale of overtime-related compliance breaches."
    - name: "avg_fine_per_violation"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per violation. Tracks severity of financial penalties and informs risk prioritization."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN labor_violation_status = 'resolved' THEN labor_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that have been resolved. Low rate signals backlog in compliance remediation."
    - name: "reported_violation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_reported = TRUE THEN labor_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations reported to regulatory bodies. Tracks external disclosure exposure."
    - name: "distinct_employees_with_violations"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with labor violations. Identifies concentration of compliance risk in specific individuals."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and compliance metrics covering assessment pass rates, certification attainment, and training coverage. Used by HR and operations leadership to ensure workforce readiness, food safety compliance, and regulatory certification requirements are met."
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g. food safety, onboarding, leadership) — enables training category analysis."
    - name: "training_category"
      expr: training_category
      comment: "Category of the training program — groups related training for program-level analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the training was delivered (e.g. in-person, e-learning, on-the-job) — tracks channel effectiveness."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Completion status of the training record (e.g. completed, in-progress, failed) — filter to completed for pass rate analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion — tracks regulatory training obligation fulfillment."
    - name: "certification_required"
      expr: certification_required
      comment: "Indicates whether the training leads to a required certification — prioritizes compliance-critical training."
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Indicates whether the employee passed the training assessment — primary quality gate for training effectiveness."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which training was conducted — identifies scheduling patterns for training delivery."
    - name: "required_for_role"
      expr: required_for_role
      comment: "Role for which the training is required — enables role-based compliance gap analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completion records. Baseline training activity volume KPI."
    - name: "assessment_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN training_completion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions where the employee passed the assessment. Core training effectiveness KPI — low rate triggers curriculum review."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions. Tracks knowledge retention and training quality."
    - name: "avg_assessment_max_score"
      expr: AVG(CAST(assessment_max_score AS DOUBLE))
      comment: "Average maximum possible assessment score. Used to normalize pass rates across different assessment scales."
    - name: "certification_attainment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required = TRUE AND assessment_passed = TRUE THEN training_completion_id END) / NULLIF(COUNT(CASE WHEN certification_required = TRUE THEN training_completion_id END), 0), 2)
      comment: "Percentage of required-certification training completions where the employee passed. Regulatory compliance KPI — below threshold triggers mandatory re-training."
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT training_employee_id)
      comment: "Number of distinct employees who completed at least one training. Tracks training program reach across the workforce."
    - name: "compliance_training_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN training_completion_id END)
      comment: "Number of training completions that satisfy a compliance requirement. Tracks regulatory obligation fulfillment volume."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition metrics covering open requisitions, time-to-fill, offer acceptance rates, and budget utilization. Used by HR leadership to optimize recruiting efficiency, manage hiring costs, and ensure headcount targets are met."
  source: "`vibe_restaurants_v1`.`workforce`.`recruitment`"
  dimensions:
    - name: "recruitment_status"
      expr: recruitment_status
      comment: "Current status of the recruitment (e.g. open, filled, cancelled) — primary filter for active pipeline analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment being recruited for (e.g. full-time, part-time) — enables workforce composition planning."
    - name: "job_level"
      expr: job_level
      comment: "Level of the role being recruited (e.g. crew, supervisor, manager) — enables level-based recruiting analysis."
    - name: "posting_channel"
      expr: posting_channel
      comment: "Channel through which the job was posted (e.g. Indeed, internal, referral) — tracks sourcing channel effectiveness."
    - name: "source_of_candidate"
      expr: source_of_candidate
      comment: "Source of the candidate (e.g. referral, job board, walk-in) — informs sourcing strategy optimization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the recruitment (e.g. EEO compliant, under review) — tracks hiring compliance obligations."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the job was posted — used to trend recruiting activity and measure time-to-fill."
    - name: "closing_date"
      expr: closing_date
      comment: "Date the recruitment closed — bounds the recruiting cycle for time-to-fill calculation."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(1)
      comment: "Total number of recruitment records. Tracks overall hiring pipeline volume."
    - name: "total_recruiting_budget"
      expr: SUM(CAST(budget_usd AS DOUBLE))
      comment: "Total recruiting budget allocated across all requisitions. Tracks talent acquisition investment."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST((salary_range_min + salary_range_max) AS DOUBLE) / 2.0)
      comment: "Average midpoint of the salary range offered. Benchmarks compensation competitiveness in the talent market."
    - name: "avg_salary_range_min"
      expr: AVG(CAST(salary_range_min AS DOUBLE))
      comment: "Average minimum salary offered across requisitions. Tracks floor compensation levels for market competitiveness."
    - name: "avg_salary_range_max"
      expr: AVG(CAST(salary_range_max AS DOUBLE))
      comment: "Average maximum salary offered across requisitions. Tracks ceiling compensation levels for budget planning."
    - name: "distinct_positions_recruited"
      expr: COUNT(DISTINCT position_id)
      comment: "Number of distinct positions being recruited for. Tracks breadth of open headcount needs."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee onboarding completion and compliance metrics. Used by HR and operations leadership to track onboarding program effectiveness, compliance task completion rates, and time-to-productivity for new hires."
  source: "`vibe_restaurants_v1`.`workforce`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding record (e.g. in-progress, completed, stalled) — primary filter for active onboarding analysis."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (e.g. new-hire, rehire, transfer) — enables onboarding program segmentation."
    - name: "method"
      expr: method
      comment: "Onboarding delivery method (e.g. in-person, remote, hybrid) — tracks method effectiveness."
    - name: "i9_completed"
      expr: i9_completed
      comment: "Indicates whether the I-9 employment eligibility form was completed — critical legal compliance gate."
    - name: "food_handler_card_submitted"
      expr: food_handler_card_submitted
      comment: "Indicates whether the food handler card was submitted — tracks food safety compliance for new hires."
    - name: "servsafe_enrolled"
      expr: servsafe_enrolled
      comment: "Indicates whether the new hire was enrolled in ServSafe training — tracks food safety onboarding compliance."
    - name: "pos_access_provisioned"
      expr: pos_access_provisioned
      comment: "Indicates whether POS system access was provisioned — tracks operational readiness for new hires."
    - name: "uniform_issued"
      expr: uniform_issued
      comment: "Indicates whether the uniform was issued — tracks operational readiness milestone completion."
    - name: "training_completed"
      expr: training_completed
      comment: "Indicates whether all required training was completed during onboarding — primary readiness gate."
  measures:
    - name: "total_onboardings"
      expr: COUNT(1)
      comment: "Total number of onboarding records. Tracks new hire volume and onboarding program scale."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average onboarding completion percentage across all records. Tracks overall onboarding program throughput."
    - name: "i9_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN i9_completed = TRUE THEN onboarding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboardings with a completed I-9. Legal compliance KPI — below 100% is a regulatory risk."
    - name: "food_handler_card_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN food_handler_card_submitted = TRUE THEN onboarding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboardings with a submitted food handler card. Food safety compliance KPI for new hire readiness."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completed = TRUE THEN onboarding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboardings where all required training was completed. Tracks new hire readiness and time-to-productivity."
    - name: "pos_provisioning_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pos_access_provisioned = TRUE THEN onboarding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboardings with POS access provisioned. Tracks operational readiness for new hires to begin serving guests."
    - name: "servsafe_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN servsafe_enrolled = TRUE THEN onboarding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of new hires enrolled in ServSafe during onboarding. Tracks food safety training pipeline for new employees."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_leave_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request and absence management metrics. Used by HR and operations leadership to monitor leave utilization, payroll impact, and coverage gaps that affect restaurant staffing levels."
  source: "`vibe_restaurants_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of leave requested (e.g. FMLA, PTO, sick, bereavement) — enables leave category analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the leave request (e.g. approved, pending, denied) — filter to approved for actual leave analysis."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Indicates whether the leave is paid — enables paid vs. unpaid leave cost analysis."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Indicates whether the leave has a payroll impact — tracks leave records requiring payroll adjustment."
    - name: "coverage_needed_flag"
      expr: coverage_needed_flag
      comment: "Indicates whether shift coverage is needed for the leave — tracks operational staffing gaps from absences."
    - name: "backfill_assigned_flag"
      expr: backfill_assigned_flag
      comment: "Indicates whether a backfill was assigned for the leave — tracks coverage resolution rate."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the leave — used to trend leave volume over time."
    - name: "end_date"
      expr: end_date
      comment: "End date of the leave — bounds the absence window for staffing impact analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests. Tracks absence volume and leave program utilization."
    - name: "total_leave_days_approved"
      expr: SUM(CAST(leave_days_approved AS DOUBLE))
      comment: "Total approved leave days across all requests. Quantifies workforce capacity reduction from approved absences."
    - name: "total_leave_days_requested"
      expr: SUM(CAST(leave_days_requested AS DOUBLE))
      comment: "Total leave days requested. Tracks demand for leave and potential staffing impact."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(leave_days_approved AS DOUBLE)) / NULLIF(SUM(CAST(leave_days_requested AS DOUBLE)), 0), 2)
      comment: "Ratio of approved leave days to requested leave days. Tracks leave policy application consistency."
    - name: "coverage_gap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_needed_flag = TRUE AND backfill_assigned_flag = FALSE THEN leave_request_id END) / NULLIF(COUNT(CASE WHEN coverage_needed_flag = TRUE THEN leave_request_id END), 0), 2)
      comment: "Percentage of leave requests requiring coverage where no backfill was assigned. Tracks unresolved staffing gaps from absences."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance remaining after the request. Tracks leave liability and employee leave utilization patterns."
    - name: "payroll_impacted_leave_count"
      expr: COUNT(CASE WHEN payroll_impact_flag = TRUE THEN leave_request_id END)
      comment: "Number of leave requests with a payroll impact. Tracks the volume of absences requiring payroll adjustment."
    - name: "distinct_employees_on_leave"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with leave requests. Tracks breadth of workforce absence exposure."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification compliance metrics covering active certifications, expiration risk, and mandatory certification coverage. Used by HR, operations, and food safety leadership to ensure regulatory and operational certification requirements are met."
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. ServSafe, food handler, OSHA) — enables certification category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. active, expired, pending) — primary filter for compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certification record — tracks regulatory obligation fulfillment."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the role — prioritizes compliance gap remediation."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates whether the certification requires renewal — tracks upcoming renewal obligations."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification — enables issuer-level compliance analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the certification — used to identify certifications at risk of lapsing."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certification records. Baseline certification portfolio volume."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN certification_id END)
      comment: "Number of currently active certifications. Tracks compliant certification coverage across the workforce."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN certification_id END)
      comment: "Number of expired certifications. Directly quantifies regulatory compliance risk from lapsed credentials."
    - name: "mandatory_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND certification_status = 'active' THEN certification_id END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN certification_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. Critical compliance KPI — below threshold triggers immediate remediation."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with at least one certification record. Tracks certified workforce coverage."
    - name: "renewal_pending_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE AND certification_status != 'active' THEN certification_id END)
      comment: "Number of certifications requiring renewal that are not currently active. Tracks renewal backlog and compliance risk pipeline."
$$;
