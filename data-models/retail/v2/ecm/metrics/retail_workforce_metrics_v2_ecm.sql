-- Metric views for domain: workforce | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_associate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount and workforce composition metrics derived from the associate master record. Supports strategic decisions on staffing levels, workforce mix, retention, and labor compliance."
  source: "`vibe_retail_v1`.`workforce`.`associate`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the associate (e.g., active, terminated, on-leave) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Classification of the associate's employment arrangement (e.g., full-time, part-time, seasonal, contractor)."
    - name: "pay_type"
      expr: pay_type
      comment: "Compensation basis for the associate (e.g., hourly, salaried) used to segment labor cost analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band assigned to the associate, used for compensation equity and budget analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "Fair Labor Standards Act classification (exempt vs. non-exempt) relevant to overtime eligibility and compliance."
    - name: "primary_work_location_type"
      expr: primary_work_location_type
      comment: "Type of primary work location (e.g., store, distribution center, corporate) for workforce distribution analysis."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Indicates whether the associate is a union member, used for labor relations and CBA compliance reporting."
    - name: "rehire_eligible_flag"
      expr: rehire_eligible_flag
      comment: "Indicates whether a terminated associate is eligible for rehire, used in talent pipeline planning."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the associate was hired, used for cohort-based tenure and retention analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for associate termination, used to identify voluntary vs. involuntary attrition patterns."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status of the associate, used for I-9 compliance monitoring."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of associate records. Used as the baseline headcount figure for workforce planning and cost modeling."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'active' THEN 1 END)
      comment: "Count of currently active associates. The primary headcount KPI used in staffing dashboards and labor budget variance analysis."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN 1 END)
      comment: "Number of associates who are union members. Used to monitor union density and assess CBA coverage obligations."
    - name: "union_membership_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_membership_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the workforce that holds union membership. A key labor relations metric tracked by HR leadership and legal."
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average contracted standard hours per week across associates. Used to assess workforce capacity and distinguish full-time equivalents from part-time workers."
    - name: "total_standard_hours_per_week"
      expr: SUM(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Total contracted standard hours per week across all associates. Used to compute aggregate FTE capacity for labor planning."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible_flag = TRUE THEN 1 END)
      comment: "Number of terminated associates eligible for rehire. Informs talent acquisition strategy and reduces external sourcing costs."
    - name: "work_auth_expiring_count"
      expr: COUNT(CASE WHEN work_authorization_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of associates whose work authorization expires within the next 90 days. A compliance risk metric requiring proactive HR action to avoid I-9 violations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and cost metrics derived from time entry records. Supports operational decisions on overtime management, labor cost control, shift efficiency, and payroll accuracy."
  source: "`vibe_retail_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed, used for daily and weekly labor trend analysis."
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work date, used for monthly labor cost and hours trend reporting."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (e.g., regular, overtime, holiday) for labor cost categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry (e.g., approved, pending, rejected) used to identify payroll processing bottlenecks."
    - name: "shift_differential_eligible"
      expr: shift_differential_eligible
      comment: "Indicates whether the time entry qualifies for shift differential pay, used in premium labor cost analysis."
    - name: "is_holiday_work"
      expr: is_holiday_work
      comment: "Indicates whether the hours were worked on a holiday, used to track premium pay obligations."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether the time entry has an exception (e.g., missed punch, early departure) requiring manager review."
    - name: "exception_type"
      expr: exception_type
      comment: "Category of time entry exception (e.g., missed punch, unapproved overtime) for exception management reporting."
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the time entry, used for departmental labor cost allocation."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Indicates whether the time entry has been included in a payroll run, used to track payroll processing completeness."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours worked. The primary labor volume metric used in scheduling efficiency and budget variance analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. A critical cost control metric — excessive overtime signals understaffing or scheduling inefficiency."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. Tracks premium labor cost exposure from extended or holiday shifts."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked across all time entries. Used as the denominator in productivity and labor cost per hour calculations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount across all time entries. The primary financial metric for labor spend management and P&L impact."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across time entries. Used to monitor wage inflation and benchmark against labor budget assumptions."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. A key scheduling efficiency KPI — high rates indicate chronic understaffing or poor schedule adherence."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of time entries flagged with an exception. High exception rates indicate timekeeping compliance issues and payroll processing risk."
    - name: "avg_labor_cost_per_hour"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE) / NULLIF(CAST(actual_hours_worked AS DOUBLE), 0))
      comment: "Average labor cost per hour worked. Used to track effective hourly labor cost trends and compare against budgeted rates."
    - name: "shift_differential_hours"
      expr: SUM(CASE WHEN shift_differential_eligible = TRUE THEN CAST(actual_hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours eligible for shift differential pay. Used to quantify premium pay exposure from evening, overnight, and weekend scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics derived from individual payroll records. Supports financial planning, compensation equity analysis, and payroll accuracy monitoring."
  source: "`vibe_retail_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date on which the associate was paid, used for payroll period trend analysis."
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of pay date, used for monthly payroll cost aggregation and budget comparison."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (e.g., weekly, bi-weekly, semi-monthly) used to normalize payroll cost comparisons."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., direct deposit, check) used for payroll operations and banking reconciliation."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record (e.g., processed, pending, reversed) used to monitor payroll run completeness."
    - name: "department_code"
      expr: department_code
      comment: "Department code for the payroll record, used for departmental labor cost allocation and GL posting."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for the payroll record, used for financial reporting and budget variance analysis."
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period covered by this record, used for period-over-period payroll trend analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay across all payroll records. The primary payroll cost metric used in P&L reporting and labor budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to associates after all deductions. Used in cash flow planning and treasury management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. A key cost control metric — sustained high overtime pay signals scheduling or staffing gaps."
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay_amount AS DOUBLE))
      comment: "Total regular (straight-time) pay. Used as the baseline compensation cost in labor budget models."
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay_amount AS DOUBLE))
      comment: "Total bonus pay disbursed. Used to track variable compensation spend against merit cycle budgets."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments). Used in benefits cost analysis and net pay reconciliation."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld. Used for tax liability reporting and IRS compliance."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions deducted from payroll. Used to monitor 401(k) and pension funding obligations."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record. Used to benchmark compensation levels and detect anomalies in payroll processing."
    - name: "overtime_pay_as_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay_amount AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay. A strategic labor efficiency KPI — high ratios indicate premium labor cost exposure and scheduling inefficiency."
    - name: "total_ytd_gross_pay"
      expr: SUM(CAST(year_to_date_gross_pay_amount AS DOUBLE))
      comment: "Sum of year-to-date gross pay amounts. Used for annual compensation tracking and W-2 preparation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution and financial summary metrics. Supports payroll operations management, cost forecasting, and GL reconciliation."
  source: "`vibe_retail_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (e.g., regular, off-cycle, bonus, reversal) used to categorize payroll processing activity."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Current status of the payroll run (e.g., pending, processed, posted, reversed) for operational monitoring."
    - name: "frequency"
      expr: frequency
      comment: "Pay frequency of the run (e.g., weekly, bi-weekly) used to normalize cost comparisons across pay cycles."
    - name: "pay_date"
      expr: pay_date
      comment: "Scheduled pay date for the run, used for cash flow planning and treasury management."
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of the pay date, used for monthly payroll cost aggregation."
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "Status of the GL posting for the payroll run, used to monitor financial close completeness."
    - name: "is_final_run"
      expr: is_final_run
      comment: "Indicates whether this is the final payroll run for the period, used to distinguish preliminary from finalized payroll costs."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year associated with the payroll run, used for annual tax reporting and W-2 reconciliation."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(1)
      comment: "Total number of payroll runs executed. Used to monitor payroll processing volume and identify off-cycle run frequency."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay across all payroll runs. The primary payroll cost metric for financial reporting and budget variance."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed across all runs. Used for cash disbursement planning and bank reconciliation."
    - name: "total_employer_tax"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer-side payroll tax cost (FICA, FUTA, SUTA). A significant non-wage labor cost tracked in total compensation budgets."
    - name: "total_payroll_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total all-in payroll cost including gross pay, employer taxes, and benefits. The comprehensive labor cost figure used in P&L and budget reporting."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll run. Used to detect anomalies and benchmark run-level payroll costs across periods."
    - name: "employer_tax_as_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(employer_tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay_amount AS DOUBLE)), 0), 2)
      comment: "Employer payroll tax as a percentage of gross pay. Used to model total employment cost and assess tax burden trends."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_compensation_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation change and merit increase metrics. Supports strategic decisions on pay equity, merit budget utilization, and compensation program effectiveness."
  source: "`vibe_retail_v1`.`workforce`.`compensation_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of compensation change (e.g., merit, promotion, market adjustment, equity) used to categorize pay change drivers."
    - name: "change_reason"
      expr: change_reason
      comment: "Business reason for the compensation change, used to analyze pay change patterns and equity."
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR approval status of the compensation change (e.g., approved, pending, rejected) for workflow monitoring."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating associated with the compensation change, used to validate pay-for-performance alignment."
    - name: "new_pay_grade"
      expr: new_pay_grade
      comment: "Pay grade after the compensation change, used for grade distribution and equity analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., hourly, annual) used to normalize compensation change amounts for comparison."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Indicates whether the compensation change is retroactive, used to track retroactive pay liability."
    - name: "change_effective_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Month the compensation change became effective, used for trend analysis of pay change activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation change, used for multi-currency compensation reporting."
  measures:
    - name: "total_compensation_changes"
      expr: COUNT(1)
      comment: "Total number of compensation change events. Used to monitor pay change activity volume and merit cycle participation rates."
    - name: "total_budget_impact"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total annualized budget impact of all compensation changes. The primary financial metric for merit cycle cost management and budget utilization."
    - name: "avg_pay_rate_change_pct"
      expr: AVG(CAST(pay_rate_change_percentage AS DOUBLE))
      comment: "Average percentage pay rate change across all compensation events. Used to benchmark merit increase levels against market and guideline targets."
    - name: "avg_compa_ratio_after"
      expr: AVG(CAST(compa_ratio_after AS DOUBLE))
      comment: "Average compa-ratio after compensation changes. A pay equity metric — ratios significantly below 1.0 indicate underpaid associates relative to the midpoint."
    - name: "avg_compa_ratio_before"
      expr: AVG(CAST(compa_ratio_before AS DOUBLE))
      comment: "Average compa-ratio before compensation changes. Used alongside the post-change ratio to measure the equity improvement impact of the merit cycle."
    - name: "total_retroactive_amount"
      expr: SUM(CAST(retroactive_amount AS DOUBLE))
      comment: "Total retroactive pay amount across all compensation changes. High retroactive amounts indicate delays in processing pay changes and create payroll liability risk."
    - name: "total_lump_sum_amount"
      expr: SUM(CAST(lump_sum_amount AS DOUBLE))
      comment: "Total lump sum compensation paid. Used to track one-time pay awards separate from base pay changes in merit budget analysis."
    - name: "avg_pay_rate_change_amount"
      expr: AVG(CAST(pay_rate_change_amount AS DOUBLE))
      comment: "Average absolute pay rate change amount. Used to assess the dollar magnitude of compensation adjustments across the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review outcomes and merit eligibility metrics. Supports talent management decisions on promotion, merit increases, performance improvement plans, and succession planning."
  source: "`vibe_retail_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g., annual, mid-year, PIP, disciplinary) used to segment review outcomes by process."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating assigned (e.g., exceeds expectations, meets expectations, needs improvement) for workforce performance distribution analysis."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Current status of the review (e.g., in-progress, completed, acknowledged) used to monitor review cycle completion rates."
    - name: "pip_flag"
      expr: pip_flag
      comment: "Indicates whether the associate is on a Performance Improvement Plan, used to track at-risk employee population."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of the calibration process for the review, used to ensure rating distribution consistency across managers."
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Indicates whether the associate is eligible for a merit increase based on this review, used in merit budget planning."
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Indicates whether a promotion was recommended, used to track internal mobility and succession pipeline health."
    - name: "review_period_start_month"
      expr: DATE_TRUNC('MONTH', review_period_start_date)
      comment: "Month the review period started, used for cohort-based performance trend analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of action associated with the review (e.g., promotion, demotion, termination recommendation) for workforce action tracking."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews. Used as the baseline for review cycle completion rate calculations."
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN performance_review_status = 'completed' THEN 1 END)
      comment: "Number of completed performance reviews. Used to track review cycle completion rates and identify manager compliance gaps."
    - name: "review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_review_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance reviews completed. A talent management process KPI — low completion rates indicate manager accountability gaps."
    - name: "pip_count"
      expr: COUNT(CASE WHEN pip_flag = TRUE THEN 1 END)
      comment: "Number of associates currently on a Performance Improvement Plan. Used to monitor at-risk employee population and potential involuntary attrition."
    - name: "promotion_recommendation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in a promotion recommendation. Used to assess internal mobility health and succession pipeline depth."
    - name: "merit_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN merit_increase_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed associates eligible for a merit increase. Used in merit budget planning and pay-for-performance program design."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average numeric performance rating score. Used to track workforce performance trends and calibration consistency across review cycles."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage recommended in reviews. Used to benchmark merit award levels against budget guidelines and market data."
    - name: "termination_recommended_count"
      expr: COUNT(CASE WHEN termination_recommended_flag = TRUE THEN 1 END)
      comment: "Number of reviews where termination was recommended. A workforce risk metric used by HR leadership to anticipate involuntary attrition and manage legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and compliance metrics derived from leave request records. Supports workforce availability planning, FMLA compliance monitoring, and absence cost management."
  source: "`vibe_retail_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave requested (e.g., FMLA, personal, medical, parental) used to categorize absence patterns."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Sub-category of leave type for more granular absence analysis and compliance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request (e.g., approved, pending, denied) used to monitor leave administration efficiency."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Indicates whether the leave qualifies under FMLA, used for federal compliance reporting and legal risk management."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Indicates whether the leave is paid, used to distinguish paid vs. unpaid absence cost impact."
    - name: "intermittent_leave_flag"
      expr: intermittent_leave_flag
      comment: "Indicates whether the leave is intermittent (taken in separate blocks), used to track scheduling disruption from intermittent absences."
    - name: "medical_certification_required_flag"
      expr: medical_certification_required_flag
      comment: "Indicates whether medical certification is required for the leave, used to monitor documentation compliance."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month the leave was requested to start, used for seasonal absence trend analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests submitted. Used as the baseline for leave utilization and approval rate calculations."
    - name: "approved_leave_requests"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of approved leave requests. Used to track leave approval rates and workforce availability impact."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests that were approved. Used to monitor leave administration consistency and identify potential denial pattern risks."
    - name: "total_days_approved"
      expr: SUM(CAST(total_days_approved AS DOUBLE))
      comment: "Total approved leave days across all requests. The primary workforce availability impact metric used in scheduling and capacity planning."
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total leave days requested. Used alongside approved days to calculate leave approval ratios and assess absence demand."
    - name: "avg_days_approved_per_request"
      expr: AVG(CAST(total_days_approved AS DOUBLE))
      comment: "Average number of days approved per leave request. Used to benchmark leave duration and identify outlier cases requiring HR review."
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN fmla_eligible_flag = TRUE THEN 1 END)
      comment: "Number of FMLA-eligible leave requests. A compliance metric — organizations must track FMLA usage to ensure entitlement limits are not exceeded and legal obligations are met."
    - name: "medical_cert_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_certification_required_flag = TRUE AND medical_certification_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN medical_certification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of leave requests requiring medical certification where certification was received. A compliance KPI — low rates indicate documentation gaps that create legal exposure."
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total approved leave hours. Used for precise workforce capacity planning and payroll cost impact of paid leave."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and cost metrics derived from training enrollment records. Supports workforce development decisions, compliance risk management, and training ROI analysis."
  source: "`vibe_retail_v1`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., compliance, skills, leadership, onboarding) used to categorize training investment and completion rates."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the training enrollment (e.g., completed, in-progress, not-started, failed) for training pipeline monitoring."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e.g., e-learning, instructor-led, on-the-job) used to analyze effectiveness and cost by modality."
    - name: "compliance_training_flag"
      expr: compliance_training_flag
      comment: "Indicates whether the training is mandatory for regulatory compliance, used to prioritize completion tracking."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Indicates whether the training is mandatory for the role, used to identify non-compliance risk in the workforce."
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Indicates whether the training is past its due date, used to identify compliance risk and trigger escalation."
    - name: "certification_earned_flag"
      expr: certification_earned_flag
      comment: "Indicates whether a certification was earned upon completion, used to track credentialing outcomes."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of training enrollment, used for training activity trend analysis."
    - name: "pass_fail_indicator"
      expr: pass_fail_indicator
      comment: "Pass or fail outcome of the training assessment, used to measure training effectiveness and identify knowledge gaps."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of training enrollments. Used as the baseline for completion rate and training investment calculations."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Number of completed training enrollments. Used to track training throughput and workforce development progress."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training enrollments completed. A key workforce development and compliance KPI — low rates for mandatory training indicate regulatory risk."
    - name: "compliance_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_training_flag = TRUE AND completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_training_flag = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate specifically for compliance-mandatory training. A regulatory risk metric — rates below 100% expose the organization to audit findings and penalties."
    - name: "overdue_training_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Number of training enrollments that are past their due date. A compliance risk metric requiring immediate management action for mandatory training."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training enrollments. Used to track training investment and calculate cost-per-completion for ROI analysis."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across completed training enrollments. Used to measure training effectiveness and identify programs requiring curriculum improvement."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered. Used to measure workforce development investment in time and benchmark against industry standards."
    - name: "avg_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per enrollment. Used to benchmark training program efficiency and identify high-cost delivery methods."
    - name: "certification_earned_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_earned_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN completion_status = 'completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed enrollments that resulted in a certification. Used to measure credentialing program effectiveness and workforce qualification levels."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline and recruiting efficiency metrics. Supports strategic decisions on hiring velocity, sourcing effectiveness, and workforce planning gap closure."
  source: "`vibe_retail_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g., open, filled, cancelled, on-hold) used to monitor recruiting pipeline health."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g., backfill, new headcount, internal transfer) used to categorize hiring demand drivers."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for (e.g., full-time, part-time, seasonal) used to segment hiring activity."
    - name: "job_family"
      expr: job_family
      comment: "Job family of the open position, used for workforce planning and skills gap analysis."
    - name: "job_level"
      expr: job_level
      comment: "Level of the open position (e.g., entry, mid, senior, manager) used to analyze hiring mix and compensation budget."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition (e.g., critical, high, standard) used to focus recruiting resources on highest-impact openings."
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Indicates whether the position is eligible for remote work, used to analyze talent pool accessibility."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the requisition was opened, used for hiring demand trend analysis."
    - name: "hiring_location_type"
      expr: hiring_location_type
      comment: "Type of hiring location (e.g., store, distribution center, corporate) used to segment recruiting activity by workforce segment."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of open and historical requisitions. Used as the baseline for recruiting pipeline and fill rate calculations."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'open' THEN 1 END)
      comment: "Number of currently open requisitions. A key workforce planning metric — high open counts indicate hiring gaps that risk operational capacity."
    - name: "avg_budgeted_salary_midpoint"
      expr: AVG((CAST(budgeted_salary_min AS DOUBLE) + CAST(budgeted_salary_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of the budgeted salary range across requisitions. Used to benchmark compensation competitiveness and validate budget assumptions."
    - name: "total_budgeted_salary_max"
      expr: SUM(CAST(budgeted_salary_max AS DOUBLE))
      comment: "Total maximum budgeted salary exposure across all open requisitions. Used in headcount budget planning to size the maximum compensation commitment."
    - name: "avg_salary_range_spread"
      expr: AVG(CAST(budgeted_salary_max AS DOUBLE) - CAST(budgeted_salary_min AS DOUBLE))
      comment: "Average spread between minimum and maximum budgeted salary. Used to assess pay range width and compensation flexibility in recruiting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning and variance metrics. Supports financial planning decisions on headcount investment, labor cost targets, and budget utilization by location and cost center."
  source: "`vibe_retail_v1`.`workforce`.`labor_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the labor budget (e.g., draft, approved, locked) used to identify finalized vs. in-progress budgets."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g., annual, quarterly, monthly) used to segment budget analysis by planning horizon."
    - name: "budget_version_code"
      expr: budget_version_code
      comment: "Version identifier for the labor budget, used to compare original budget vs. revised forecasts."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month the planning period starts, used for time-series budget trend analysis."
    - name: "budgeted_labor_cost_currency_code"
      expr: budgeted_labor_cost_currency_code
      comment: "Currency of the labor budget, used for multi-currency budget consolidation."
  measures:
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost_amount AS DOUBLE))
      comment: "Total budgeted labor cost amount. The primary financial planning metric for labor spend management and P&L budget setting."
    - name: "total_budgeted_regular_hours"
      expr: SUM(CAST(budgeted_regular_hours AS DOUBLE))
      comment: "Total budgeted regular hours. Used to plan workforce capacity and validate FTE assumptions in the labor budget."
    - name: "total_budgeted_overtime_hours"
      expr: SUM(CAST(budgeted_overtime_hours AS DOUBLE))
      comment: "Total budgeted overtime hours. Used to set overtime cost expectations and benchmark against actual overtime incurred."
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte_count AS DOUBLE))
      comment: "Total planned full-time equivalent headcount in the labor budget. The primary headcount planning metric used in workforce strategy and financial modeling."
    - name: "avg_budgeted_labor_cost_pct_of_sales"
      expr: AVG(CAST(budgeted_labor_cost_percent_of_sales AS DOUBLE))
      comment: "Average budgeted labor cost as a percentage of sales. A strategic retail KPI — labor as a percent of sales is a primary efficiency metric for store and DC operations."
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percent AS DOUBLE))
      comment: "Average attrition assumption percentage built into the labor budget. Used to validate budget realism and adjust headcount plans for expected turnover."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staffing plan execution and headcount variance metrics. Supports operational decisions on workforce gap closure, FTE allocation, and labor cost management by location and org unit."
  source: "`vibe_retail_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "staffing_plan_status"
      expr: staffing_plan_status
      comment: "Status of the staffing plan (e.g., draft, approved, active, closed) used to identify actionable vs. historical plans."
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle identifier (e.g., annual, Q1, Q2) used to segment staffing plans by planning horizon."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the staffing plan becomes effective, used for time-series headcount planning analysis."
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total budgeted FTE count across all staffing plans. The primary headcount planning metric used in workforce strategy and financial modeling."
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS DOUBLE))
      comment: "Total actual headcount recorded against staffing plans. Used to measure staffing plan execution and identify locations with headcount gaps."
    - name: "total_headcount_allocated"
      expr: SUM(CAST(headcount_allocated AS DOUBLE))
      comment: "Total headcount allocated in staffing plans. Used to track allocation vs. actual fill rates across the organization."
    - name: "total_fte_variance"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (planned minus actual). Negative variance indicates understaffing; positive indicates overstaffing. A critical operational metric for store and DC management."
    - name: "avg_fte_variance"
      expr: AVG(CAST(variance_fte AS DOUBLE))
      comment: "Average FTE variance per staffing plan. Used to identify systematic over- or under-staffing patterns across locations or org units."
    - name: "total_annual_labor_budget"
      expr: SUM(CAST(annual_labor_budget AS DOUBLE))
      comment: "Total annual labor budget across all staffing plans. Used for consolidated labor cost planning and financial reporting."
    - name: "total_annual_labor_cost_budget"
      expr: SUM(CAST(annual_labor_cost_budget AS DOUBLE))
      comment: "Total annual labor cost budget (including benefits and taxes) across staffing plans. The all-in labor cost planning figure used in P&L budgeting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits enrollment and cost metrics. Supports strategic decisions on benefits program design, cost management, ACA compliance, and employee benefits utilization."
  source: "`vibe_retail_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit enrolled in (e.g., medical, dental, vision, 401k, FSA) used to analyze enrollment distribution and cost by benefit category."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the benefit enrollment (e.g., active, terminated, waived) used to track active benefit coverage."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier selected (e.g., employee-only, employee+spouse, family) used to analyze benefit cost by coverage level."
    - name: "plan_year"
      expr: plan_year
      comment: "Benefit plan year, used for annual enrollment trend analysis and year-over-year cost comparison."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method used to enroll (e.g., online, paper, open enrollment, life event) used to optimize enrollment channel strategy."
    - name: "aca_eligible_flag"
      expr: aca_eligible_flag
      comment: "Indicates whether the associate is ACA-eligible, used for Affordable Care Act compliance reporting."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Indicates whether the associate is eligible for COBRA continuation coverage, used for benefits administration compliance."
    - name: "qualifying_life_event_type"
      expr: qualifying_life_event_type
      comment: "Type of qualifying life event triggering a mid-year enrollment change, used to analyze enrollment change drivers."
    - name: "enrollment_effective_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month the enrollment became effective, used for benefits cost trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of benefit enrollments. Used as the baseline for enrollment rate and cost per enrollee calculations."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Number of currently active benefit enrollments. Used to track benefits coverage levels and ACA minimum coverage obligations."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution to benefits. A major non-wage labor cost — tracked in total compensation budgets and benefits cost management."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution to benefits. Used to analyze employee cost-sharing levels and assess benefits affordability."
    - name: "total_premium_cost"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total benefits premium cost (employer + employee). The comprehensive benefits cost metric used in total compensation analysis."
    - name: "avg_employer_contribution_per_enrollment"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per benefit enrollment. Used to benchmark benefits generosity and model cost impact of plan design changes."
    - name: "employer_cost_share_rate"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Employer share of total benefits premium as a percentage. Used to assess benefits cost-sharing strategy and benchmark against market norms."
    - name: "aca_eligible_enrollment_count"
      expr: COUNT(CASE WHEN aca_eligible_flag = TRUE THEN 1 END)
      comment: "Number of ACA-eligible benefit enrollments. Used for Affordable Care Act employer mandate compliance reporting and penalty risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling efficiency and labor cost metrics. Supports operational decisions on schedule optimization, overtime management, and labor cost per shift."
  source: "`vibe_retail_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the shift schedule (e.g., published, confirmed, cancelled) used to monitor scheduling process completion."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., opening, closing, mid, overnight) used to analyze labor cost and coverage by shift category."
    - name: "is_overtime_eligible"
      expr: is_overtime_eligible
      comment: "Indicates whether the shift is eligible for overtime pay, used to track premium labor cost exposure in scheduling."
    - name: "is_holiday_shift"
      expr: is_holiday_shift
      comment: "Indicates whether the shift falls on a holiday, used to track holiday premium pay obligations."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the scheduled shift, used for daily and weekly labor scheduling trend analysis."
    - name: "schedule_week_start_date"
      expr: schedule_week_start_date
      comment: "Start date of the schedule week, used for weekly labor cost and hours aggregation."
    - name: "shift_priority"
      expr: shift_priority
      comment: "Priority level of the shift, used to identify critical coverage requirements and scheduling gaps."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system or method used to generate the schedule (e.g., automated, manual) used to assess scheduling tool effectiveness."
  measures:
    - name: "total_shifts_scheduled"
      expr: COUNT(1)
      comment: "Total number of shifts scheduled. Used as the baseline for scheduling coverage and cancellation rate calculations."
    - name: "cancelled_shifts"
      expr: COUNT(CASE WHEN schedule_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled shifts. High cancellation rates indicate scheduling instability and potential service coverage gaps."
    - name: "shift_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled shifts that were cancelled. A scheduling quality KPI — high rates indicate workforce availability issues or poor schedule planning."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Used to measure scheduled labor capacity and compare against actual hours worked."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for all scheduled shifts. Used in pre-period labor cost forecasting and budget variance management."
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_hours AS DOUBLE))
      comment: "Average hours per scheduled shift. Used to assess shift length distribution and identify scheduling patterns that drive overtime."
    - name: "holiday_shift_count"
      expr: COUNT(CASE WHEN is_holiday_shift = TRUE THEN 1 END)
      comment: "Number of holiday shifts scheduled. Used to quantify holiday premium pay obligations and plan holiday staffing budgets."
    - name: "overtime_eligible_shift_count"
      expr: COUNT(CASE WHEN is_overtime_eligible = TRUE THEN 1 END)
      comment: "Number of shifts eligible for overtime pay. Used to monitor overtime exposure in the schedule before shifts are worked."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_wf_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification status and compliance metrics. Supports decisions on regulatory compliance, job eligibility, and certification renewal risk management."
  source: "`vibe_retail_v1`.`workforce`.`wf_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., active, expired, suspended, pending) used to monitor workforce credential compliance."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., food safety, forklift, first aid, professional license) used to categorize compliance requirements."
    - name: "is_compliance_required"
      expr: is_compliance_required
      comment: "Indicates whether the certification is required for regulatory compliance, used to prioritize renewal tracking."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the role, used to identify associates at risk of job ineligibility."
    - name: "job_eligibility_flag"
      expr: job_eligibility_flag
      comment: "Indicates whether the certification is required for job eligibility, used to prevent non-compliant associates from performing regulated tasks."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of issuing authority (e.g., federal, state, industry body) used to categorize certification regulatory source."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification (e.g., verified, pending, failed) used to ensure credential authenticity."
    - name: "reimbursement_eligible_flag"
      expr: reimbursement_eligible_flag
      comment: "Indicates whether the certification cost is eligible for employer reimbursement, used in benefits cost tracking."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of workforce certifications on record. Used as the baseline for compliance coverage and expiration risk calculations."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN 1 END)
      comment: "Number of currently active certifications. Used to measure current workforce compliance credential coverage."
    - name: "expiring_certifications_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND certification_status = 'active' THEN 1 END)
      comment: "Number of active certifications expiring within 90 days. A proactive compliance risk metric — requires renewal action to prevent workforce eligibility gaps."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN 1 END)
      comment: "Number of expired certifications. A compliance risk metric — expired certifications for mandatory roles create regulatory and safety liability."
    - name: "compliance_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliance_required = TRUE AND certification_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_compliance_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of compliance-required certifications that are currently active. A regulatory compliance KPI — rates below 100% indicate immediate risk of non-compliance."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of workforce certifications. Used to track credentialing investment and calculate cost per certified associate."
    - name: "total_reimbursement_amount"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total employer reimbursement for certification costs. Used to track tuition and credentialing reimbursement program spend."
    - name: "avg_continuing_education_hours_completed"
      expr: AVG(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed per certification. Used to monitor ongoing professional development compliance for licensed roles."
$$;