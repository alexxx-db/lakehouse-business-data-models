-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce composition and compensation metrics derived from the employee master record. Supports headcount planning, pay equity analysis, labor cost benchmarking, and retention risk monitoring across restaurant units."
  source: "`vibe_restaurants_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the employee (e.g., Active, Terminated, On Leave). Primary filter for active headcount analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Classification of employment arrangement (e.g., Full-Time, Part-Time, Seasonal). Used to segment labor cost and scheduling capacity."
    - name: "department"
      expr: department
      comment: "Organizational department the employee belongs to (e.g., FOH, BOH, Management). Enables departmental labor cost and headcount breakdowns."
    - name: "job_title"
      expr: job_title
      comment: "Employee job title. Used to analyze compensation distribution and staffing levels by role."
    - name: "role_classification"
      expr: role_classification
      comment: "Broad role classification (e.g., Hourly, Salaried, Manager). Supports pay grade and labor percentage target analysis."
    - name: "work_schedule_type"
      expr: work_schedule_type
      comment: "Type of work schedule assigned (e.g., Fixed, Flexible, On-Call). Used to assess scheduling flexibility and coverage risk."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Recurring shift pattern for the employee. Supports shift coverage planning and fatigue risk analysis."
    - name: "union_member"
      expr: union_member
      comment: "Indicates whether the employee is a union member (True/False). Used for labor relations reporting and compliance tracking."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the employee is eligible for overtime pay (True/False). Critical for labor cost forecasting and scheduling compliance."
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "Indicates whether the employee holds a current ServSafe certification (True/False). Key food safety compliance dimension."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire date. Used to analyze hiring cohorts, tenure distribution, and seasonal hiring patterns."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination. Used to identify attrition trends and seasonal turnover patterns."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency code for salary amounts. Required for multi-currency compensation analysis."
    - name: "country"
      expr: country
      comment: "Country of the employee's address. Supports geographic workforce distribution analysis."
    - name: "state"
      expr: state
      comment: "State/province of the employee's address. Enables regional labor market and compliance analysis."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Total number of currently active employees. Core headcount KPI used in workforce planning, labor cost budgeting, and capacity management."
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total annualized salary cost across all employees in scope. Directly informs compensation budget, labor cost forecasting, and pay equity reviews."
    - name: "avg_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary amount per employee. Used for pay equity benchmarking, compensation band analysis, and competitive positioning."
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target across employees. Indicates the expected labor cost as a share of revenue, used to set scheduling and staffing efficiency benchmarks."
    - name: "total_overtime_eligible_employees"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Count of employees eligible for overtime. Used to assess overtime cost exposure and inform scheduling decisions to control labor spend."
    - name: "total_union_members"
      expr: COUNT(CASE WHEN union_member = TRUE THEN employee_id END)
      comment: "Total number of union member employees. Supports labor relations reporting, contract compliance monitoring, and collective bargaining analysis."
    - name: "servsafe_certified_count"
      expr: COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END)
      comment: "Number of employees with active ServSafe certification. Critical food safety compliance KPI; low values signal regulatory risk and training gaps."
    - name: "servsafe_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END) / NULLIF(COUNT(employee_id), 0), 2)
      comment: "Percentage of employees who are ServSafe certified. Tracks food safety compliance posture; below-threshold values trigger mandatory training interventions."
    - name: "avg_pay_grade"
      expr: AVG(CAST(pay_grade AS DOUBLE))
      comment: "Average pay grade across employees. Used to monitor compensation structure health, identify grade compression, and support promotion planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift execution metrics covering labor cost, scheduling adherence, overtime exposure, and daypart efficiency. Enables real-time and historical labor performance management at the unit and daypart level."
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  filter: is_deleted = FALSE
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the shift. Primary time dimension for daily labor cost and scheduling adherence reporting."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift date. Used for monthly labor cost trend analysis and period-over-period comparisons."
    - name: "daypart"
      expr: daypart
      comment: "Daypart segment of the shift (e.g., Morning, Midday, Evening, Night). Enables daypart-level labor efficiency and coverage analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., Regular, On-Call, Split). Used to analyze shift mix and its impact on labor cost and employee satisfaction."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (e.g., Scheduled, Completed, No-Show, Cancelled). Used to track schedule adherence and identify operational disruptions."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift incurred overtime (True/False). Key flag for overtime cost monitoring and scheduling compliance."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Indicates whether the shift was an on-call assignment (True/False). Used to assess on-call labor utilization and associated cost."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables unit-level labor performance benchmarking and cross-location comparisons."
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts in scope. Primary labor spend KPI used in P&L management, budget variance analysis, and unit-level cost control."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Used to benchmark shift cost efficiency across units, dayparts, and shift types."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all shifts. Core labor volume metric used in productivity analysis and labor cost per hour calculations."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours originally scheduled. Used alongside actual hours to measure scheduling adherence and identify over/under-staffing patterns."
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual hours worked to scheduled hours, expressed as a percentage. Measures scheduling execution quality; significant deviations indicate operational disruptions or chronic over/under-scheduling."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue at the shift level. Key efficiency ratio used to assess whether labor spend is within target thresholds by daypart and unit."
    - name: "total_overtime_shifts"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN shift_id END)
      comment: "Total number of shifts that incurred overtime. Tracks overtime exposure; high values signal scheduling inefficiency or chronic understaffing requiring corrective action."
    - name: "overtime_shift_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN shift_id END) / NULLIF(COUNT(shift_id), 0), 2)
      comment: "Percentage of shifts that incurred overtime. Compound efficiency KPI; elevated rates drive labor cost overruns and trigger scheduling policy reviews."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per shift in minutes. Used to monitor compliance with labor law break requirements and assess productive time utilization."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average hourly labor rate across shifts. Used for compensation benchmarking, budget forecasting, and identifying rate anomalies by unit or role."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financial metrics covering gross pay, net pay, tax withholding, overtime costs, and bonus distributions. Supports payroll accuracy auditing, labor cost management, and compensation analytics for restaurant operations."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: pay_period_start
      comment: "Start date of the pay period. Primary time dimension for payroll cycle analysis and period-over-period cost comparisons."
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start)
      comment: "Month of the pay period start. Used for monthly payroll cost trend analysis and budget variance reporting."
    - name: "pay_period_end"
      expr: pay_period_end
      comment: "End date of the pay period. Used alongside pay_period_start to define payroll cycle boundaries."
    - name: "pay_date"
      expr: pay_date
      comment: "Actual date employees were paid. Used for cash flow analysis and payroll disbursement timing."
    - name: "employee_type"
      expr: employee_type
      comment: "Type of employee for payroll purposes (e.g., Hourly, Salaried, Contractor). Enables payroll cost segmentation by workforce category."
    - name: "job_title"
      expr: job_title
      comment: "Job title at time of payroll record. Used to analyze compensation distribution and labor cost by role."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period associated with the payroll record. Aligns payroll costs to financial reporting periods for P&L accuracy."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the payroll record. Used for annual tax reporting, W-2 reconciliation, and year-over-year compensation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll amounts. Required for multi-currency payroll cost consolidation."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Indicates whether the payroll record includes a bonus payment (True/False). Used to separate base compensation from variable pay in cost analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the employee is a union member for this payroll record (True/False). Supports union labor cost tracking and contract compliance."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit associated with the payroll record. Enables unit-level payroll cost benchmarking."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay disbursed across all payroll records in scope. Primary payroll cost KPI used in labor budget management, P&L reporting, and period-over-period variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay after deductions. Used to assess actual cash outflow for payroll and reconcile with bank disbursements."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total tax withheld from employee paychecks. Critical for tax compliance reporting, remittance reconciliation, and regulatory filings."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_hours AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost calculated as overtime hours multiplied by overtime rate. Tracks premium labor spend; elevated values trigger scheduling and staffing reviews to reduce overtime exposure."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments disbursed. Used to track variable compensation spend, assess incentive program costs, and align bonus budgets with performance outcomes."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions across payroll records. Used to monitor benefits cost burden and reconcile with benefits administration systems."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue at the payroll record level. Key efficiency ratio for assessing whether total compensation spend is within target thresholds."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts recorded in payroll. Used for tip pooling compliance, minimum wage offset calculations, and FOH compensation analysis."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours paid. Used to measure base labor volume and distinguish regular from premium labor spend."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid across all payroll records. Tracks overtime volume; high values relative to regular hours signal chronic understaffing or scheduling inefficiency."
    - name: "overtime_hours_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE) + CAST(overtime_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours paid. Compound efficiency KPI; elevated rates directly increase labor cost and signal scheduling or staffing issues requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor demand forecasting metrics covering projected FTE requirements, labor cost estimates, and forecast accuracy by daypart and scenario. Enables proactive staffing decisions, budget alignment, and operational planning for restaurant units."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date for which the labor forecast applies. Primary time dimension for forecast-to-actual comparison and demand planning."
    - name: "forecast_date_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month of the forecast date. Used for monthly labor demand trend analysis and budget planning cycles."
    - name: "daypart"
      expr: daypart
      comment: "Daypart segment of the forecast (e.g., Morning, Midday, Evening, Night). Enables daypart-level staffing demand analysis and scheduling optimization."
    - name: "labor_forecast_status"
      expr: labor_forecast_status
      comment: "Status of the labor forecast (e.g., Draft, Approved, Superseded). Used to filter for active forecasts and track forecast lifecycle."
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario label (e.g., Base, Optimistic, Pessimistic). Supports scenario-based planning and sensitivity analysis for labor budgeting."
    - name: "model_version"
      expr: model_version
      comment: "Version of the forecasting model used. Enables model performance tracking and comparison across forecast iterations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for labor cost estimates. Required for multi-currency labor budget consolidation."
    - name: "labor_restaurant_unit_id"
      expr: labor_restaurant_unit_id
      comment: "Restaurant unit for which the forecast was generated. Enables unit-level forecast accuracy and staffing demand analysis."
  measures:
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost across all forecasts in scope. Primary forecast KPI used in labor budget planning, cost variance analysis, and financial planning cycles."
    - name: "avg_projected_labor_percent"
      expr: AVG(CAST(projected_labor_percent AS DOUBLE))
      comment: "Average projected labor cost as a percentage of revenue. Used to assess whether forecasted staffing levels are within target labor cost ratios before scheduling is finalized."
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected front-of-house FTE demand. Used to plan FOH staffing levels, assess guest experience capacity, and align hiring pipelines."
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected back-of-house FTE demand. Used to plan BOH staffing, kitchen capacity, and food production throughput."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for labor forecasts. Low confidence scores signal unreliable forecasts that require manual review before scheduling decisions are made."
    - name: "foh_boh_fte_ratio"
      expr: ROUND(SUM(CAST(projected_fte_foh AS DOUBLE)) / NULLIF(SUM(CAST(projected_fte_boh AS DOUBLE)), 0), 2)
      comment: "Ratio of projected FOH FTE to BOH FTE. Tracks staffing balance between guest-facing and kitchen operations; significant deviations from target ratios indicate service or production capacity imbalances."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule planning and labor efficiency metrics covering scheduled hours, FTE allocation by daypart, and labor percentage targets. Supports workforce planning, schedule optimization, and labor cost management across restaurant units."
  source: "`vibe_restaurants_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the schedule period. Primary time dimension for schedule planning and period-over-period labor analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the schedule period start. Used for monthly scheduling trend analysis and labor budget alignment."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the schedule period. Used to define schedule coverage windows and assess scheduling lead time."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (e.g., Draft, Approved, Published). Used to filter for active schedules and track schedule approval workflows."
    - name: "approved_by"
      expr: approved_by
      comment: "Name or identifier of the manager who approved the schedule. Used for accountability tracking and approval workflow analysis."
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit for which the schedule was created. Enables unit-level scheduling efficiency and labor cost benchmarking."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedule records in scope. Core labor volume KPI used in capacity planning, labor cost budgeting, and schedule efficiency analysis."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average scheduled labor cost as a percentage of revenue. Key efficiency ratio used to assess whether scheduled staffing levels are within target labor cost thresholds before the period begins."
    - name: "total_fte_morning"
      expr: SUM(CAST(fte_morning AS DOUBLE))
      comment: "Total FTE scheduled for morning daypart. Used to assess morning staffing capacity and align with forecasted demand for breakfast and opening operations."
    - name: "total_fte_midday"
      expr: SUM(CAST(fte_midday AS DOUBLE))
      comment: "Total FTE scheduled for midday daypart. Used to assess lunch rush staffing capacity and throughput planning."
    - name: "total_fte_evening"
      expr: SUM(CAST(fte_evening AS DOUBLE))
      comment: "Total FTE scheduled for evening daypart. Used to assess dinner service staffing capacity and guest experience planning."
    - name: "total_fte_night"
      expr: SUM(CAST(fte_night AS DOUBLE))
      comment: "Total FTE scheduled for night daypart. Used to assess late-night staffing levels and associated labor cost efficiency."
    - name: "total_fte_scheduled"
      expr: SUM(CAST(fte_total AS DOUBLE))
      comment: "Total FTE scheduled across all dayparts. Aggregate staffing volume KPI used in workforce capacity planning and labor cost forecasting."
    - name: "avg_labor_pct_morning"
      expr: AVG(CAST(labor_pct_morning AS DOUBLE))
      comment: "Average labor cost percentage for morning daypart. Used to identify daypart-specific labor inefficiencies and optimize staffing mix."
    - name: "avg_labor_pct_evening"
      expr: AVG(CAST(labor_pct_evening AS DOUBLE))
      comment: "Average labor cost percentage for evening daypart. Used to monitor dinner service labor efficiency and identify over/under-staffing patterns."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics covering actual hours worked, overtime, labor cost, and punch compliance. Provides the operational ground truth for labor cost management, payroll accuracy, and workforce productivity analysis."
  source: "`vibe_restaurants_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed. Primary time dimension for daily labor cost and attendance analysis."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of the work date. Used for monthly labor cost trend analysis and payroll period reconciliation."
    - name: "job_role"
      expr: job_role
      comment: "Job role of the employee at time of entry. Used to analyze labor cost and hours by role, supporting staffing mix optimization."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of the time entry (e.g., Pending, Approved, Rejected). Used to filter for approved entries and track payroll processing readiness."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (e.g., Regular, Overtime, Break). Used to segment labor hours and cost by entry category."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the time entry includes overtime hours (True/False). Key flag for overtime cost monitoring and scheduling compliance."
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Indicates whether a clock-in or clock-out punch was missed (True/False). Tracks time and attendance compliance; high rates signal process or system issues affecting payroll accuracy."
    - name: "approved_by_manager"
      expr: approved_by_manager
      comment: "Indicates whether the time entry was approved by a manager (True/False). Used to track approval workflow compliance and identify unapproved entries before payroll processing."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit associated with the time entry. Enables unit-level labor cost and attendance analysis."
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Operational labor spend KPI used for real-time cost monitoring, payroll reconciliation, and unit-level P&L management."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all time entries. Core labor volume metric used in productivity analysis, labor cost per hour calculations, and scheduling adherence measurement."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Used to measure base labor volume and distinguish regular from premium labor spend."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Tracks premium labor volume; high values relative to regular hours signal scheduling inefficiency and drive cost overruns."
    - name: "overtime_hours_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Compound efficiency KPI; elevated rates directly increase labor cost and signal scheduling or staffing issues requiring management intervention."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average hourly labor rate across time entries. Used for compensation benchmarking, budget forecasting, and identifying rate anomalies by unit or role."
    - name: "missed_punch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN missed_punch_flag = TRUE THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries with a missed punch. Tracks time and attendance process compliance; high rates indicate systemic issues that compromise payroll accuracy and create legal exposure."
    - name: "unapproved_entry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_by_manager = FALSE THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries not yet approved by a manager. Tracks payroll processing readiness; high rates before payroll close signal approval workflow failures that delay disbursement."
    - name: "labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour worked. Compound efficiency KPI that normalizes labor spend by volume; used to benchmark unit-level labor efficiency and identify cost outliers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics covering leave utilization, approval rates, coverage risk, and payroll impact. Supports workforce availability planning, compliance monitoring, and operational continuity management for restaurant units."
  source: "`vibe_restaurants_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of leave start date. Used for monthly leave volume trend analysis and workforce availability planning."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the leave period. Primary time dimension for leave scheduling and coverage planning."
    - name: "end_date"
      expr: end_date
      comment: "End date of the leave period. Used alongside start date to calculate leave duration and plan backfill coverage."
    - name: "request_type"
      expr: request_type
      comment: "Type of leave requested (e.g., Vacation, Sick, FMLA, Parental). Used to analyze leave patterns by category and assess compliance with leave entitlement policies."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the leave request (e.g., Pending, Approved, Denied, Cancelled). Used to track approval workflow efficiency and leave utilization."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Indicates whether the leave is paid (True/False). Used to assess paid leave liability and distinguish paid from unpaid leave in cost analysis."
    - name: "coverage_needed_flag"
      expr: coverage_needed_flag
      comment: "Indicates whether shift coverage is needed during the leave (True/False). Used to assess operational continuity risk and trigger backfill scheduling."
    - name: "backfill_assigned_flag"
      expr: backfill_assigned_flag
      comment: "Indicates whether a backfill has been assigned for the leave (True/False). Used to track coverage gap resolution and operational risk mitigation."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Indicates whether the leave has a payroll impact (True/False). Used to flag leave records requiring payroll adjustments and ensure accurate compensation processing."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit associated with the leave request. Enables unit-level leave utilization and coverage risk analysis."
  measures:
    - name: "total_leave_days_approved"
      expr: SUM(CAST(leave_days_approved AS DOUBLE))
      comment: "Total leave days approved across all requests. Core leave utilization KPI used in workforce availability planning, leave liability management, and staffing capacity analysis."
    - name: "total_leave_days_requested"
      expr: SUM(CAST(leave_days_requested AS DOUBLE))
      comment: "Total leave days requested. Used alongside approved days to measure leave approval rates and assess leave demand versus entitlement balances."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(leave_days_approved AS DOUBLE)) / NULLIF(SUM(CAST(leave_days_requested AS DOUBLE)), 0), 2)
      comment: "Percentage of requested leave days that were approved. Tracks leave policy application consistency; significant deviations by unit or manager signal compliance or fairness issues."
    - name: "coverage_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_needed_flag = TRUE AND backfill_assigned_flag = FALSE THEN leave_request_id END) / NULLIF(COUNT(CASE WHEN coverage_needed_flag = TRUE THEN leave_request_id END), 0), 2)
      comment: "Percentage of leave requests requiring coverage where no backfill has been assigned. Operational risk KPI; high rates indicate staffing gaps that directly threaten service levels and guest experience."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance remaining after approved leave. Used to monitor leave liability, identify employees at risk of leave exhaustion, and plan for future leave demand."
    - name: "total_leave_requests"
      expr: COUNT(leave_request_id)
      comment: "Total number of leave requests submitted. Used to track leave demand volume, identify seasonal patterns, and assess HR administrative workload."
    - name: "payroll_impact_leave_count"
      expr: COUNT(CASE WHEN payroll_impact_flag = TRUE THEN leave_request_id END)
      comment: "Number of leave requests with a payroll impact. Used to quantify payroll adjustment workload and ensure all impacted records are processed accurately before payroll close."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and effectiveness metrics covering completion rates, assessment performance, and compliance status by training category and delivery method. Supports food safety compliance, brand standard adherence, and workforce development management."
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "completion_timestamp_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month of training completion. Used for monthly training volume trend analysis and compliance deadline tracking."
    - name: "training_category"
      expr: training_category
      comment: "Category of training completed (e.g., Food Safety, Customer Service, Operations). Used to analyze training coverage by category and identify compliance gaps."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., Onboarding, Recertification, Compliance). Used to segment training volume and assess workforce readiness by training type."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (e.g., In-Person, eLearning, On-the-Job). Used to analyze training effectiveness and cost efficiency by delivery channel."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion (e.g., Compliant, Non-Compliant, Pending). Primary compliance dimension for regulatory and brand standard reporting."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Status of the training completion record (e.g., Completed, In Progress, Failed). Used to track training pipeline and identify employees with incomplete required training."
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Indicates whether the employee passed the training assessment (True/False). Key quality dimension for measuring training effectiveness and knowledge retention."
    - name: "required_for_role"
      expr: required_for_role
      comment: "Role for which the training is required. Used to assess role-specific training compliance and identify coverage gaps by position."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the training was conducted. Used to analyze training scheduling patterns and assess impact on operational coverage."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the training was completed. Enables unit-level training compliance and effectiveness benchmarking."
  measures:
    - name: "training_completion_count"
      expr: COUNT(training_completion_id)
      comment: "Total number of training completions recorded. Core training volume KPI used to track workforce development activity and compliance program throughput."
    - name: "assessment_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN training_completion_id END) / NULLIF(COUNT(training_completion_id), 0), 2)
      comment: "Percentage of training completions where the employee passed the assessment. Key training effectiveness KPI; low pass rates signal inadequate training content, delivery issues, or workforce skill gaps requiring intervention."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN training_completion_id END) / NULLIF(COUNT(training_completion_id), 0), 2)
      comment: "Percentage of training completions with a compliant status. Primary regulatory and brand standard compliance KPI; below-threshold values trigger mandatory remediation and may indicate audit risk."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions. Used to measure knowledge retention and training program quality; declining trends signal content or delivery effectiveness issues."
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average duration of training sessions in minutes. Used to assess training efficiency, estimate labor cost of training delivery, and benchmark against industry standards."
    - name: "total_training_hours"
      expr: ROUND(SUM(CAST(training_duration_minutes AS DOUBLE)) / 60.0, 2)
      comment: "Total training hours delivered across all completions. Used to quantify workforce development investment, assess training program scale, and calculate training cost per hour."
    - name: "avg_assessment_score_pct_of_max"
      expr: ROUND(100.0 * AVG(CAST(assessment_score AS DOUBLE)) / NULLIF(AVG(CAST(assessment_max_score AS DOUBLE)), 0), 2)
      comment: "Average assessment score as a percentage of the maximum possible score. Normalizes performance across assessments with different scoring scales; enables fair cross-category and cross-unit training effectiveness comparison."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance metrics covering certification status, expiration risk, mandatory compliance rates, and renewal tracking. Supports food safety regulatory compliance, brand standard adherence, and risk management for restaurant operations."
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Food Handler, ServSafe, Allergen Awareness). Used to analyze compliance coverage by certification category and identify gaps."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Pending Renewal). Primary compliance dimension for certification portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certification (e.g., Compliant, Non-Compliant, At Risk). Used for regulatory reporting and brand standard compliance tracking."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the role (True/False). Used to prioritize compliance monitoring and remediation for required certifications."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates whether the certification requires renewal (True/False). Used to proactively manage renewal pipelines and prevent compliance lapses."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification (e.g., National Restaurant Association, State Health Department). Used for regulatory source tracking and audit documentation."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of certification issuance. Used to analyze certification cohorts and track certification program throughput over time."
    - name: "last_verified_date_month"
      expr: DATE_TRUNC('MONTH', last_verified_date)
      comment: "Month of last verification. Used to identify certifications that have not been recently verified and may require re-validation."
  measures:
    - name: "total_certifications"
      expr: COUNT(certification_id)
      comment: "Total number of certification records. Baseline KPI for certification portfolio size and compliance program coverage."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of currently active certifications. Core compliance KPI used to assess workforce certification coverage and identify gaps requiring immediate remediation."
    - name: "mandatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND compliance_status = 'Compliant' THEN certification_id END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN certification_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are compliant. Critical regulatory compliance KPI; below-threshold values indicate immediate legal and operational risk requiring executive escalation."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN certification_id END)
      comment: "Number of expired certifications. Tracks compliance risk exposure; high counts signal systemic renewal process failures and potential regulatory violations."
    - name: "expiring_soon_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE AND certification_status = 'Active' THEN certification_id END)
      comment: "Number of active certifications that require renewal. Proactive risk KPI used to trigger renewal workflows before certifications lapse and create compliance gaps."
    - name: "non_compliant_mandatory_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND compliance_status = 'Non-Compliant' THEN certification_id END)
      comment: "Number of mandatory certifications that are non-compliant. Highest-priority compliance risk KPI; any non-zero value requires immediate management intervention to prevent regulatory violations and operational shutdowns."
$$;