-- Metric views for domain: hr | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking headcount composition, compensation benchmarks, and attrition signals across the construction enterprise. Used by CHROs and project executives to steer workforce planning and cost management."
  source: "`vibe_construction_v1`.`hr`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, On Leave) for workforce segmentation."
    - name: "employee_type"
      expr: employee_type
      comment: "Classification of employee type (Full-Time, Part-Time, Contractor) for headcount analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for organizational cost and headcount breakdown."
    - name: "location_code"
      expr: location_code
      comment: "Work location code enabling site-level workforce distribution analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation type (Salary, Hourly, Commission) for pay structure analysis."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity and inclusion reporting."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort analysis."
    - name: "performance_rating_last_year"
      expr: performance_rating_last_year
      comment: "Last year performance rating for talent segmentation and retention risk analysis."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Total number of active employees. Core workforce sizing metric used in capacity planning and project staffing decisions."
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total employee records including all statuses. Baseline for attrition rate and workforce composition calculations."
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total annualised base salary cost across the workforce. Key input for labour cost budgeting and project cost allocation."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary per employee. Used to benchmark compensation competitiveness and identify pay equity gaps."
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated employees in the period. Numerator for attrition rate calculation and retention risk monitoring."
    - name: "attrition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of employees who have been terminated relative to total workforce. Critical retention KPI tracked by HR leadership and project executives."
    - name: "hse_training_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_training_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN employment_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active employees who have completed mandatory HSE training. Regulatory compliance KPI critical for construction site safety obligations."
    - name: "distinct_departments"
      expr: COUNT(DISTINCT department_code)
      comment: "Number of distinct departments with active workforce. Used for organisational span-of-control analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and variance metrics for construction workforce. Enables finance and HR leadership to monitor total labour cost, overtime exposure, and payroll accuracy across pay cycles."
  source: "`vibe_construction_v1`.`hr`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: DATE_TRUNC('month', pay_period_start)
      comment: "Pay period start month for trend analysis of payroll costs over time."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll processing status (Processed, Pending, Reversed) for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll payment for multi-currency construction operations."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (Bank Transfer, Cheque) for payroll disbursement analysis."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flag indicating off-cycle payroll runs, which signal exceptions and additional processing cost."
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus paid for incentive compensation analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll cost reporting and statutory compliance."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary paid across all payroll records. Primary labour cost metric for project cost control and budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Cash flow metric for treasury and payroll operations management."
    - name: "total_deduction_tax"
      expr: SUM(CAST(deduction_tax AS DOUBLE))
      comment: "Total tax deducted from payroll. Statutory compliance metric for tax authority reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid across the workforce. Key productivity and cost control metric — high overtime signals understaffing or schedule pressure on construction projects."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments made. Incentive compensation cost metric used in total remuneration analysis."
    - name: "avg_gross_salary_per_record"
      expr: AVG(CAST(gross_salary AS DOUBLE))
      comment: "Average gross salary per payroll record. Benchmark for pay equity and compensation band compliance."
    - name: "total_ytd_gross"
      expr: SUM(CAST(year_to_date_gross AS DOUBLE))
      comment: "Sum of year-to-date gross earnings across all employees. Annual labour cost accumulation metric for budget tracking."
    - name: "off_cycle_payroll_count"
      expr: COUNT(CASE WHEN is_off_cycle = TRUE THEN 1 END)
      comment: "Number of off-cycle payroll records. Operational efficiency metric — high off-cycle counts indicate payroll process exceptions and increased processing cost."
    - name: "total_site_allowance"
      expr: SUM(CAST(allowance_site AS DOUBLE))
      comment: "Total site allowances paid to construction workers. Project-specific labour cost component for site cost allocation."
    - name: "total_project_allowance"
      expr: SUM(CAST(allowance_project AS DOUBLE))
      comment: "Total project allowances paid. Direct project labour cost component for job costing and project profitability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level metrics for monitoring payroll cycle performance, cost totals, and processing efficiency. Used by payroll managers and CFOs to oversee payroll operations."
  source: "`vibe_construction_v1`.`hr`.`payroll_run`"
  dimensions:
    - name: "pay_cycle"
      expr: pay_cycle
      comment: "Pay cycle (Weekly, Fortnightly, Monthly) for payroll frequency analysis."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (Regular, Bonus, Termination) for cost categorisation."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Current status of the payroll run (Pending, Processed, Approved) for operational monitoring."
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Month of pay date for trend analysis of payroll cost over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-currency reporting."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag for manually processed payroll runs, indicating exception handling."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial period alignment of payroll costs."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(1)
      comment: "Total number of payroll runs processed. Baseline operational metric for payroll cycle management."
    - name: "total_gross_payroll_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount across all runs. Primary labour cost metric for financial reporting and budget control."
    - name: "total_net_payroll_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Cash outflow metric for treasury management."
    - name: "total_deductions_amount"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll runs. Used to reconcile gross-to-net payroll and validate statutory compliance."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll per run. Benchmark for detecting anomalous payroll runs that may indicate errors or fraud."
    - name: "manual_run_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN 1 END)
      comment: "Number of manually processed payroll runs. Process quality metric — high manual run counts indicate automation gaps and increased error risk."
    - name: "manual_run_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payroll runs that are manual. Payroll automation efficiency KPI — target is near zero for a mature payroll function."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance metrics for talent management, succession planning, and compensation decisions. Used by HR business partners and senior leadership to assess workforce capability and identify high performers."
  source: "`vibe_construction_v1`.`hr`.`performance_review`"
  dimensions:
    - name: "review_cycle"
      expr: review_cycle
      comment: "Performance review cycle (Annual, Mid-Year, Quarterly) for temporal segmentation."
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (Standard, Probation, Project-End) for review purpose analysis."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating category for talent distribution analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Review lifecycle status (Draft, Submitted, Approved) for process completion monitoring."
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR approval status for governance and compliance tracking of review completions."
    - name: "review_period_start_year"
      expr: YEAR(review_period_start)
      comment: "Year of review period for annual performance trend analysis."
    - name: "promotion_eligibility"
      expr: promotion_eligibility
      comment: "Flag indicating promotion eligibility for talent pipeline analysis."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN lifecycle_status = 'Approved' THEN 1 END)
      comment: "Total number of completed and approved performance reviews. Process completion KPI for HR governance."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lifecycle_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance reviews that have been approved and completed. HR process effectiveness KPI — low completion rates signal management engagement issues."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average performance rating score across all reviews. Workforce capability benchmark used in talent calibration sessions."
    - name: "avg_technical_competency"
      expr: AVG(CAST(technical_competency AS DOUBLE))
      comment: "Average technical competency score. Critical for construction firms to assess workforce technical capability against project requirements."
    - name: "avg_safety_competency"
      expr: AVG(CAST(safety_competency AS DOUBLE))
      comment: "Average safety competency score. Key metric for construction HSE compliance — low scores trigger mandatory safety retraining."
    - name: "promotion_eligible_count"
      expr: COUNT(CASE WHEN promotion_eligibility = TRUE THEN 1 END)
      comment: "Number of employees flagged as promotion-eligible. Talent pipeline depth metric for succession planning."
    - name: "compensation_change_count"
      expr: COUNT(CASE WHEN compensation_change_flag = TRUE THEN 1 END)
      comment: "Number of reviews resulting in a compensation change. Compensation action rate metric for budget impact forecasting."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score across all reviews. Measures how effectively the workforce delivers against set objectives."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics for monitoring workforce availability, leave liability, and absence patterns on construction projects. Used by project managers and HR to manage resource availability."
  source: "`vibe_construction_v1`.`hr`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (Annual, Sick, Parental, Unpaid) for absence pattern analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of the leave request (Pending, Approved, Rejected) for workflow monitoring."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Approval decision outcome for leave request approval rate analysis."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Flag distinguishing paid from unpaid leave for payroll liability analysis."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year for annual leave liability and accrual trend analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of leave start for seasonal absence pattern analysis."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Flag indicating whether the leave request has a payroll impact for cost tracking."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests submitted. Baseline absence volume metric."
    - name: "approved_leave_requests"
      expr: COUNT(CASE WHEN leave_status = 'Approved' THEN 1 END)
      comment: "Number of approved leave requests. Used to calculate workforce availability impact."
    - name: "total_leave_days"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total leave days taken across all approved requests. Workforce availability metric critical for construction project scheduling."
    - name: "avg_leave_days_per_request"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average leave duration per request. Benchmark for identifying unusually long absences that may signal workforce issues."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN leave_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests that are approved. HR process consistency metric — significant variation by manager signals policy compliance issues."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average remaining leave balance after approved requests. Leave liability indicator for financial provisioning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_leave_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave liability and accrual metrics for financial provisioning and workforce availability planning. Used by finance and HR to manage leave entitlement obligations."
  source: "`vibe_construction_v1`.`hr`.`leave_balance`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave entitlement (Annual, Sick, Long Service) for liability categorisation."
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the leave balance record for active liability tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the leave balance for current vs historical analysis."
    - name: "accrual_period"
      expr: accrual_period
      comment: "Accrual period for leave entitlement accumulation analysis."
    - name: "as_of_date_month"
      expr: DATE_TRUNC('month', as_of_date)
      comment: "Month of balance snapshot for leave liability trend analysis."
    - name: "carryover_allowed"
      expr: carryover_allowed
      comment: "Flag indicating whether leave can be carried over, affecting year-end liability calculations."
  measures:
    - name: "total_accrued_balance"
      expr: SUM(CAST(accrued_balance AS DOUBLE))
      comment: "Total accrued leave balance across all employees. Primary leave liability metric for financial provisioning and balance sheet obligations."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available leave balance. Workforce availability metric — high available balances indicate leave liability risk."
    - name: "total_taken_balance"
      expr: SUM(CAST(taken_balance AS DOUBLE))
      comment: "Total leave days taken. Actual absence volume for workforce availability and productivity analysis."
    - name: "total_forfeited_balance"
      expr: SUM(CAST(forfeited_balance AS DOUBLE))
      comment: "Total leave days forfeited. Indicates leave management effectiveness — high forfeitures may signal excessive workload preventing leave uptake."
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available leave balance per employee. Benchmark for identifying employees with excessive leave accumulation requiring management intervention."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(accrual_rate AS DOUBLE))
      comment: "Average leave accrual rate across the workforce. Used to project future leave liability growth for financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline metrics for monitoring hiring velocity, open position costs, and workforce gap closure. Used by HR directors and project executives to manage talent acquisition for construction projects."
  source: "`vibe_construction_v1`.`hr`.`recruitment_requisition`"
  dimensions:
    - name: "recruitment_requisition_status"
      expr: recruitment_requisition_status
      comment: "Current status of the requisition (Open, Filled, Cancelled) for pipeline stage analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for (Permanent, Contract, Casual) for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority level for resource allocation in the recruitment function."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade of the open position for compensation band and seniority analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the requisition was posted for recruitment pipeline trend analysis."
    - name: "remote_option"
      expr: remote_option
      comment: "Flag indicating remote work eligibility, relevant for construction office vs site roles."
    - name: "external_job_posting"
      expr: external_job_posting
      comment: "Flag indicating external job posting for sourcing channel analysis."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(CASE WHEN recruitment_requisition_status = 'Open' THEN 1 END)
      comment: "Total number of open recruitment requisitions. Workforce gap metric — high open counts signal project staffing risk."
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total recruitment requisitions across all statuses. Baseline hiring demand metric."
    - name: "total_approved_headcount"
      expr: SUM(CAST(expected_fte AS DOUBLE))
      comment: "Total approved FTE headcount across all requisitions. Workforce demand metric for capacity planning."
    - name: "avg_salary_max"
      expr: AVG(CAST(salary_max AS DOUBLE))
      comment: "Average maximum salary offered across requisitions. Compensation market positioning metric for talent attraction strategy."
    - name: "avg_salary_min"
      expr: AVG(CAST(salary_min AS DOUBLE))
      comment: "Average minimum salary offered across requisitions. Lower bound compensation benchmark for budget planning."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recruitment_requisition_status = 'Filled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions that have been filled. Recruitment effectiveness KPI — low fill rates indicate talent acquisition bottlenecks impacting project delivery."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recruitment_requisition_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions cancelled. Signals workforce planning accuracy — high cancellation rates indicate poor demand forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel conversion metrics for optimising talent acquisition. Used by HR directors to measure candidate pipeline quality, offer acceptance rates, and sourcing channel effectiveness."
  source: "`vibe_construction_v1`.`hr`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage of the application in the recruitment funnel."
    - name: "source"
      expr: source
      comment: "Sourcing channel for the application (Job Board, Referral, Agency) for channel effectiveness analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for rejection to identify common disqualification patterns and improve job descriptions."
    - name: "application_date_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for recruitment pipeline volume trend analysis."
    - name: "offer_accepted"
      expr: offer_accepted
      comment: "Flag indicating whether the job offer was accepted for offer acceptance rate analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of job applications received. Recruitment pipeline volume metric."
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN application_status IN ('Offer Extended', 'Offer Accepted', 'Offer Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of extended offers that are accepted. Key talent attraction metric — low acceptance rates signal compensation or employer brand issues."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across all assessed candidates. Candidate quality benchmark for sourcing channel comparison."
    - name: "avg_offer_salary_gross"
      expr: AVG(CAST(offer_salary_gross AS DOUBLE))
      comment: "Average gross salary offered to candidates. Compensation benchmarking metric for market competitiveness assessment."
    - name: "total_offers_extended"
      expr: COUNT(CASE WHEN offer_salary_gross > 0 THEN 1 END)
      comment: "Total number of applications that reached the offer stage. Funnel conversion metric for recruitment efficiency."
    - name: "avg_salary_adjustment"
      expr: AVG(CAST(salary_adjustment AS DOUBLE))
      comment: "Average salary adjustment from initial offer. Negotiation metric indicating compensation flexibility and candidate leverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_compensation_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation review metrics for managing salary equity, budget utilisation, and pay increase effectiveness. Used by CHROs and finance to govern compensation cycles and control labour cost growth."
  source: "`vibe_construction_v1`.`hr`.`compensation_review`"
  dimensions:
    - name: "review_cycle"
      expr: review_cycle
      comment: "Compensation review cycle (Annual, Mid-Year, Promotion) for temporal analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the compensation review for governance tracking."
    - name: "increase_type"
      expr: increase_type
      comment: "Type of salary increase (Merit, Promotion, Market Adjustment) for compensation action categorisation."
    - name: "department_code"
      expr: department_code
      comment: "Department for organisational compensation equity analysis."
    - name: "grade_level"
      expr: grade_level
      comment: "Job grade level for pay band compliance and internal equity analysis."
    - name: "review_year"
      expr: review_year
      comment: "Review year for annual compensation cycle trend analysis."
    - name: "is_promoted"
      expr: is_promoted
      comment: "Flag indicating promotion-linked compensation changes for promotion cost analysis."
  measures:
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total compensation budget consumed across all reviews. Primary budget utilisation metric for compensation cycle management."
    - name: "total_budget_remaining"
      expr: SUM(CAST(budget_remaining_amount AS DOUBLE))
      comment: "Total compensation budget remaining. Budget control metric for mid-cycle reallocation decisions."
    - name: "avg_increase_percentage"
      expr: AVG(CAST(increase_percentage AS DOUBLE))
      comment: "Average salary increase percentage across all reviews. Compensation inflation metric used to benchmark against market and CPI."
    - name: "avg_internal_equity_score"
      expr: AVG(CAST(internal_equity_score AS DOUBLE))
      comment: "Average internal equity score. Pay equity metric — low scores indicate compensation disparities requiring remediation."
    - name: "avg_market_rate"
      expr: AVG(CAST(market_rate AS DOUBLE))
      comment: "Average market rate benchmark across reviewed positions. Used to assess whether compensation is competitive for talent retention."
    - name: "avg_new_salary"
      expr: AVG(CAST(new_salary AS DOUBLE))
      comment: "Average new salary post-review. Compensation level benchmark for workforce cost forecasting."
    - name: "promotion_count"
      expr: COUNT(CASE WHEN is_promoted = TRUE THEN 1 END)
      comment: "Number of employees promoted during the review cycle. Talent mobility metric for career development and succession pipeline health."
    - name: "equity_grant_count"
      expr: COUNT(CASE WHEN is_equity_granted = TRUE THEN 1 END)
      comment: "Number of equity grants awarded. Long-term incentive metric for retention strategy effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and compliance metrics for construction workforce development. Used by HSE managers and HR to ensure mandatory certification compliance and track workforce capability investment."
  source: "`vibe_construction_v1`.`hr`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Enrollment status (Enrolled, Completed, Failed, Withdrawn) for training pipeline analysis."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (Safety, Technical, Compliance, Leadership) for investment categorisation."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (Classroom, Online, On-the-Job) for modality effectiveness analysis."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Pass/fail outcome for training assessment quality analysis."
    - name: "compliance_required"
      expr: compliance_required
      comment: "Flag indicating mandatory compliance training for regulatory obligation tracking."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month of scheduled training delivery for capacity planning."
    - name: "training_provider"
      expr: training_provider
      comment: "Training provider for vendor performance and cost analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments. Baseline workforce development investment metric."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training enrollments completed. Workforce development effectiveness KPI — low rates on mandatory safety training trigger regulatory risk."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed training enrollments that resulted in a pass. Training quality and workforce competency metric."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training expenditure across all enrollments. Workforce development investment metric for ROI analysis."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all evaluated training enrollments. Workforce competency benchmark."
    - name: "total_training_hours"
      expr: SUM(CAST(hours AS DOUBLE))
      comment: "Total training hours delivered. Workforce capability investment metric — used to calculate training hours per employee."
    - name: "compliance_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_required = TRUE AND training_enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_required = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for mandatory compliance training. Critical regulatory KPI for construction HSE and legal obligations."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_issued = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed training enrollments that resulted in a certificate. Certification yield metric for workforce qualification tracking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost metrics for managing employee benefits programs. Used by HR and finance to monitor benefits uptake, cost exposure, and plan effectiveness."
  source: "`vibe_construction_v1`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Waived) for benefits participation analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (Health, Dental, Life, Retirement) for cost categorisation."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (Employee Only, Employee+Spouse, Family) for cost tier analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual benefits cost trend analysis."
    - name: "open_enrollment_flag"
      expr: open_enrollment_flag
      comment: "Flag indicating open enrollment period changes for annual enrollment cycle analysis."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Flag indicating benefit waiver for participation rate analysis."
    - name: "mid_year_change_flag"
      expr: mid_year_change_flag
      comment: "Flag for mid-year benefit changes indicating qualifying life events."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Total active benefit enrollments. Benefits participation baseline metric."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution to employee benefits. Primary benefits cost metric for total compensation budgeting."
    - name: "total_employee_contribution"
      expr: SUM(CAST(elected_contribution_amount AS DOUBLE))
      comment: "Total employee-elected contribution amounts. Benefits cost-sharing metric for plan design optimisation."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Per-employee benefits cost benchmark for budget forecasting."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligible employees who waived benefits. Plan attractiveness metric — high waiver rates signal uncompetitive benefit offerings."
    - name: "avg_benefit_cost_share"
      expr: AVG(CAST(benefit_cost_share AS DOUBLE))
      comment: "Average benefit cost share per enrollment. Cost-sharing ratio metric for benefits program financial sustainability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_separation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee separation and attrition metrics for workforce retention analysis. Used by CHROs and project executives to understand turnover drivers, severance costs, and rehire eligibility."
  source: "`vibe_construction_v1`.`hr`.`separation`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (Resignation, Termination, Retirement, Redundancy) for attrition cause analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Specific reason for termination for root cause analysis of voluntary and involuntary attrition."
    - name: "separation_status"
      expr: separation_status
      comment: "Processing status of the separation for offboarding workflow monitoring."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Flag indicating rehire eligibility for talent pool management."
    - name: "exit_interview_completed"
      expr: exit_interview_completed
      comment: "Flag indicating exit interview completion for attrition insight data quality."
    - name: "effective_separation_month"
      expr: DATE_TRUNC('month', effective_separation_date)
      comment: "Month of effective separation for attrition trend analysis."
    - name: "exit_interview_theme"
      expr: exit_interview_theme
      comment: "Primary theme from exit interview for systemic attrition driver identification."
  measures:
    - name: "total_separations"
      expr: COUNT(1)
      comment: "Total number of employee separations. Attrition volume metric for workforce stability monitoring."
    - name: "total_severance_paid"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance payments made. Financial liability metric for workforce restructuring cost management."
    - name: "total_final_pay"
      expr: SUM(CAST(final_pay_amount AS DOUBLE))
      comment: "Total final pay disbursed to separated employees. Cash flow metric for payroll closure obligations."
    - name: "exit_interview_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_interview_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of separations with completed exit interviews. Data quality metric for attrition insight — low rates reduce ability to identify retention improvement opportunities."
    - name: "rehire_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rehire_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of separated employees eligible for rehire. Talent pool quality metric for future recruitment cost reduction."
    - name: "avg_severance_amount"
      expr: AVG(CAST(severance_pay_amount AS DOUBLE))
      comment: "Average severance payment per separation. Benchmark for severance policy consistency and cost forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace grievance metrics for monitoring employee relations health and legal risk. Used by HR directors and legal counsel to track grievance volumes, resolution rates, and escalation patterns."
  source: "`vibe_construction_v1`.`hr`.`grievance`"
  dimensions:
    - name: "grievance_category"
      expr: grievance_category
      comment: "Category of grievance (Harassment, Discrimination, Pay, Working Conditions) for issue type analysis."
    - name: "grievance_status"
      expr: grievance_status
      comment: "Current status of the grievance (Open, Under Investigation, Resolved, Escalated) for case management."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation process for resolution timeline monitoring."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of resolved grievances for pattern analysis and policy improvement."
    - name: "lodged_month"
      expr: DATE_TRUNC('month', lodged_timestamp)
      comment: "Month grievance was lodged for trend analysis of employee relations climate."
    - name: "location_code"
      expr: location_code
      comment: "Location where grievance originated for site-level employee relations monitoring."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total number of grievances lodged. Employee relations health metric — rising counts signal deteriorating workplace culture."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN grievance_status = 'Open' THEN 1 END)
      comment: "Number of currently open grievances. Operational backlog metric for HR case management capacity."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grievance_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances that have been resolved. HR effectiveness metric — low resolution rates increase legal exposure."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_grievance_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances that were escalated. Legal risk indicator — high escalation rates signal inadequate first-line resolution capability."
    - name: "total_compensation_awarded"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation awarded in grievance resolutions. Financial liability metric for employee relations cost management."
    - name: "avg_compensation_awarded"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation awarded per resolved grievance. Benchmark for settlement cost forecasting and policy review."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning accuracy and FTE variance metrics for construction project staffing. Used by project executives and HR to monitor planned vs actual headcount and identify staffing gaps."
  source: "`vibe_construction_v1`.`hr`.`workforce_headcount_plan`"
  dimensions:
    - name: "workforce_headcount_plan_status"
      expr: workforce_headcount_plan_status
      comment: "Status of the headcount plan (Draft, Approved, Active, Closed) for planning cycle monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (Annual, Project, Departmental) for planning scope analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce composition and skills gap analysis."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade for seniority mix and compensation band planning."
    - name: "period"
      expr: period
      comment: "Planning period for temporal headcount demand analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the headcount plan takes effect for annual planning cycle analysis."
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned FTE across all headcount plans. Workforce demand metric for project staffing and budget planning."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE achieved. Workforce supply metric for comparing against planned demand."
    - name: "total_fte_variance"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (planned minus actual). Staffing gap metric — negative variance indicates understaffing risk on construction projects."
    - name: "avg_attrition_rate_pct"
      expr: AVG(CAST(attrition_rate_percent AS DOUBLE))
      comment: "Average planned attrition rate across headcount plans. Workforce stability assumption metric for planning accuracy assessment."
    - name: "fte_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_fte AS DOUBLE)) / NULLIF(SUM(CAST(planned_fte AS DOUBLE)), 0), 2)
      comment: "FTE variance as a percentage of planned FTE. Workforce planning accuracy KPI — large variances indicate poor demand forecasting or recruitment execution failures."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case metrics for monitoring workplace conduct, case resolution effectiveness, and legal risk. Used by HR directors and legal counsel to manage conduct risk across construction operations."
  source: "`vibe_construction_v1`.`hr`.`disciplinary_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case (Misconduct, Gross Misconduct, Performance) for conduct risk categorisation."
    - name: "disciplinary_case_status"
      expr: disciplinary_case_status
      comment: "Current status of the disciplinary case for case management monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the disciplinary case (Warning, Dismissal, No Action) for conduct management effectiveness analysis."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the case for resource allocation in HR case management."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Flag indicating whether an appeal was filed for legal risk monitoring."
    - name: "raised_month"
      expr: DATE_TRUNC('month', raised_timestamp)
      comment: "Month the case was raised for conduct trend analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total disciplinary cases raised. Workplace conduct health metric — rising counts signal cultural or management issues."
    - name: "open_cases"
      expr: COUNT(CASE WHEN disciplinary_case_status = 'Open' THEN 1 END)
      comment: "Number of currently open disciplinary cases. HR operational backlog metric."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary cases where an appeal was filed. Process fairness metric — high appeal rates indicate procedural inconsistency and legal risk."
    - name: "case_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disciplinary_case_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary cases that have been closed. Case management efficiency metric."
    - name: "termination_outcome_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary cases resulting in termination. Conduct severity metric for workforce risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_succession_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Succession planning depth and readiness metrics for critical role continuity. Used by C-suite and HR to ensure leadership pipeline strength across construction operations."
  source: "`vibe_construction_v1`.`hr`.`succession_plan`"
  dimensions:
    - name: "succession_plan_status"
      expr: succession_plan_status
      comment: "Status of the succession plan (Active, Draft, Superseded) for pipeline currency monitoring."
    - name: "readiness_level"
      expr: readiness_level
      comment: "Successor readiness level (Ready Now, 1-2 Years, 3+ Years) for pipeline depth analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the succession gap (High, Medium, Low) for critical role prioritisation."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of succession plan (Emergency, Developmental, Long-Term) for planning horizon analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the succession plan takes effect for pipeline refresh cycle analysis."
  measures:
    - name: "total_succession_plans"
      expr: COUNT(1)
      comment: "Total active succession plans. Leadership pipeline coverage metric."
    - name: "ready_now_successors"
      expr: COUNT(CASE WHEN readiness_level = 'Ready Now' THEN 1 END)
      comment: "Number of successors rated as ready now. Immediate leadership continuity metric — low counts signal critical succession risk."
    - name: "high_risk_succession_gaps"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk succession gaps. Critical talent risk metric requiring immediate executive attention and development investment."
    - name: "succession_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN succession_plan_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of succession plans that are currently active. Pipeline currency metric for talent management governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_kpi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HR KPI definition and performance target metrics for organisational performance management. Used by HR leadership and org unit managers to monitor KPI health, target achievement, and measurement quality."
  source: "`vibe_construction_v1`.`hr`.`kpi`"
  dimensions:
    - name: "kpi_category"
      expr: kpi_category
      comment: "Category of KPI (Safety, Productivity, Compliance, Financial) for performance domain analysis."
    - name: "kpi_type"
      expr: kpi_type
      comment: "Type of KPI (Leading, Lagging) for performance management framework analysis."
    - name: "kpi_status"
      expr: kpi_status
      comment: "Current status of the KPI (Active, Retired, Draft) for KPI portfolio management."
    - name: "frequency"
      expr: frequency
      comment: "Measurement frequency (Daily, Weekly, Monthly, Quarterly) for reporting cadence analysis."
    - name: "target_direction"
      expr: target_direction
      comment: "Direction of improvement (Increase, Decrease, Maintain) for KPI interpretation."
    - name: "reporting_level"
      expr: reporting_level
      comment: "Reporting level (Executive, Operational, Project) for audience-appropriate KPI filtering."
  measures:
    - name: "total_active_kpis"
      expr: COUNT(CASE WHEN kpi_status = 'Active' THEN 1 END)
      comment: "Total number of active KPIs in the HR performance framework. Portfolio coverage metric."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all KPIs. Benchmark for assessing ambition level of performance targets."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across KPIs. Starting point benchmark for measuring performance improvement."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across KPIs. Measurement reliability metric — low scores indicate KPI data cannot be trusted for decision-making."
    - name: "key_kpi_count"
      expr: COUNT(CASE WHEN is_key_performance_indicator = TRUE THEN 1 END)
      comment: "Number of KPIs designated as key performance indicators. Strategic focus metric for executive dashboard governance."
$$;