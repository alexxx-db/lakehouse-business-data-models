-- Metric views for domain: workforce | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure KPIs tracking pay range competitiveness, compa-ratio targets, bonus and commission eligibility, and merit cycle coverage. Used by Total Rewards and Finance to manage compensation equity, budget, and market alignment."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan (hourly, salaried, tipped, commission) for compensation structure analysis."
    - name: "compensation_plan_status"
      expr: compensation_plan_status
      comment: "Current status of the compensation plan (active, inactive, pending) for plan lifecycle management."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, semi-monthly, monthly) for payroll cadence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation plan for multi-currency compensation analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification (exempt, non-exempt) for overtime eligibility and wage compliance analysis."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether the plan includes bonus eligibility, used for incentive compensation coverage analysis."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether the plan includes commission eligibility, used for sales compensation structure analysis."
    - name: "usali_department"
      expr: usali_department
      comment: "USALI department classification for hospitality-standard labor cost reporting."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the compensation plan became effective for annual compensation cycle analysis."
  measures:
    - name: "avg_compa_ratio_target"
      expr: AVG(CAST(compa_ratio_target AS DOUBLE))
      comment: "Average compa-ratio target across compensation plans. Measures pay positioning relative to market midpoint — values below 1.0 indicate below-market pay risk."
    - name: "avg_midpoint_rate"
      expr: AVG(CAST(midpoint_rate AS DOUBLE))
      comment: "Average pay range midpoint rate. Used to benchmark compensation levels against market surveys and internal equity analysis."
    - name: "avg_pay_range_spread"
      expr: AVG(CAST(maximum_rate AS DOUBLE) - CAST(minimum_rate AS DOUBLE))
      comment: "Average spread between maximum and minimum pay rates. Wider spreads provide more flexibility for merit increases within grade."
    - name: "avg_target_bonus_percentage"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus percentage across eligible plans. Used to model total incentive compensation budget and benchmark against industry."
    - name: "avg_commission_rate_percentage"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate percentage across commission-eligible plans. Used to model variable pay cost and sales compensation competitiveness."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime pay multiplier across plans. Used to model overtime cost exposure and validate compliance with FLSA requirements."
    - name: "bonus_eligible_plan_count"
      expr: COUNT(CASE WHEN bonus_eligible = TRUE THEN compensation_plan_id END)
      comment: "Count of compensation plans with bonus eligibility. Measures incentive compensation program coverage across the workforce."
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total compensation plans. Used to assess compensation structure complexity and plan rationalization opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and disciplinary action KPIs tracking action types, grievance rates, legal holds, and termination outcomes. Used by HR and Legal to manage employee relations risk, union grievance exposure, and workforce conduct compliance."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the disciplinary action was issued, for property-level employee relations analysis."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for departmental disciplinary trend analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination) for severity distribution analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the disciplinary action (open, closed, appealed, expunged) for case management tracking."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of policy violation (attendance, conduct, performance, safety) for root cause analysis."
    - name: "grievance_filed"
      expr: grievance_filed
      comment: "Whether a union grievance was filed against this action, used for labor relations risk monitoring."
    - name: "legal_hold"
      expr: legal_hold
      comment: "Whether the action is under legal hold, used for litigation risk tracking."
    - name: "action_effective_year"
      expr: DATE_TRUNC('year', action_effective_date)
      comment: "Year the disciplinary action took effect for annual trend analysis."
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions issued. Primary employee relations volume KPI for workforce conduct monitoring."
    - name: "termination_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN disciplinary_action_id END)
      comment: "Count of disciplinary actions resulting in termination. Tracks involuntary turnover driven by conduct issues."
    - name: "grievance_count"
      expr: COUNT(CASE WHEN grievance_filed = TRUE THEN disciplinary_action_id END)
      comment: "Count of disciplinary actions with union grievances filed. Key labor relations KPI — high grievance rates signal management practice issues and union contract risk."
    - name: "legal_hold_count"
      expr: COUNT(CASE WHEN legal_hold = TRUE THEN disciplinary_action_id END)
      comment: "Count of disciplinary actions under legal hold. Tracks litigation exposure and legal department workload."
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN osha_recordable_incident = TRUE THEN disciplinary_action_id END)
      comment: "Count of disciplinary actions linked to OSHA-recordable incidents. Measures intersection of safety and conduct issues."
    - name: "grievance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grievance_filed = TRUE THEN disciplinary_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions that resulted in a union grievance. Elevated rates indicate management practice problems requiring HR intervention."
    - name: "paid_suspension_count"
      expr: COUNT(CASE WHEN is_paid_suspension = TRUE THEN disciplinary_action_id END)
      comment: "Count of paid suspensions. Tracks the cost of paid administrative leave during investigations — a significant but often untracked labor expense."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee headcount and workforce composition KPIs. Used by HR and executive leadership to monitor active headcount, turnover risk, workforce diversity, and compliance with labor certifications across properties."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`employee`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the employee is assigned, enabling property-level headcount and workforce analysis."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit (department) for departmental headcount and workforce composition reporting."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on-leave) for workforce status segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, seasonal, contractor) for workforce mix analysis."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (hourly, salaried) for compensation structure analysis."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (on-site, remote, hybrid) for workforce distribution analysis."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether the employee is a union member, used for labor relations and collective bargaining analysis."
    - name: "hire_date_year"
      expr: DATE_TRUNC('year', hire_date)
      comment: "Year of hire for cohort-based tenure and retention analysis."
  measures:
    - name: "active_employee_count"
      expr: COUNT(CASE WHEN employment_status = 'ACTIVE' THEN employee_id END)
      comment: "Count of currently active employees. Primary headcount KPI used in workforce planning, budgeting, and executive dashboards."
    - name: "total_employee_count"
      expr: COUNT(1)
      comment: "Total employee records including all statuses. Used as denominator for turnover rate and other workforce ratio calculations."
    - name: "terminated_employee_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees. Used to calculate turnover rate and identify retention risk patterns."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage across employees. Measures workforce utilization and part-time vs full-time mix for labor cost modeling."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE)) / 100.0
      comment: "Total FTE equivalent headcount (sum of FTE percentages divided by 100). Used for labor budget planning and productivity benchmarking."
    - name: "union_employee_count"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN employee_id END)
      comment: "Count of union-member employees. Tracks union density for labor relations strategy and collective bargaining preparation."
    - name: "food_safety_certified_count"
      expr: COUNT(CASE WHEN food_safety_certification_flag = TRUE THEN employee_id END)
      comment: "Count of employees with active food safety certification. Compliance KPI for F&B operations — insufficient certified staff triggers regulatory risk."
    - name: "osha_trained_count"
      expr: COUNT(CASE WHEN osha_training_current_flag = TRUE THEN employee_id END)
      comment: "Count of employees with current OSHA training. Safety compliance KPI — gaps trigger mandatory training remediation."
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average standard contracted hours per week. Used to model labor capacity and validate FTE calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_job_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition KPIs tracking open requisitions, time-to-fill, salary range competitiveness, and hiring pipeline health. Used by HR and department heads to manage recruiting velocity, headcount budget, and talent acquisition effectiveness."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`job_requisition`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the requisition was opened, enabling property-level hiring pipeline analysis."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit requesting the hire for departmental recruiting workload analysis."
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, in-progress, filled, cancelled) for pipeline stage analysis."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (backfill, new headcount, temporary) for hiring intent analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited (full-time, part-time, seasonal) for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition (critical, high, standard) for recruiting resource allocation."
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO job category for diversity and inclusion reporting and regulatory compliance."
    - name: "posting_start_month"
      expr: DATE_TRUNC('month', posting_start_date)
      comment: "Month the requisition was posted for recruiting trend analysis."
  measures:
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'OPEN' THEN job_requisition_id END)
      comment: "Count of currently open requisitions. Primary talent acquisition pipeline KPI — high open counts signal recruiting capacity constraints or budget approval delays."
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total requisitions created. Used to measure hiring volume and recruiting team workload."
    - name: "avg_salary_range_midpoint"
      expr: AVG((CAST(salary_range_min AS DOUBLE) + CAST(salary_range_max AS DOUBLE)) / 2.0)
      comment: "Average salary range midpoint across requisitions. Used to benchmark compensation competitiveness against market and validate budget assumptions."
    - name: "avg_salary_range_spread"
      expr: AVG(CAST(salary_range_max AS DOUBLE) - CAST(salary_range_min AS DOUBLE))
      comment: "Average spread between salary range min and max. Wider spreads indicate more flexibility in compensation negotiation."
    - name: "external_posting_count"
      expr: COUNT(CASE WHEN external_posting_flag = TRUE THEN job_requisition_id END)
      comment: "Count of requisitions posted externally. Measures external recruiting activity and associated sourcing costs."
    - name: "internal_posting_count"
      expr: COUNT(CASE WHEN internal_posting_flag = TRUE THEN job_requisition_id END)
      comment: "Count of requisitions posted internally. Tracks internal mobility opportunities — high internal fill rates indicate strong talent development culture."
    - name: "background_check_required_count"
      expr: COUNT(CASE WHEN background_check_required_flag = TRUE THEN job_requisition_id END)
      comment: "Count of requisitions requiring background checks. Used to forecast background check vendor costs and processing timelines."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_learning_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development KPIs tracking course catalog depth, compliance training coverage, cost per learner, and certification issuance. Used by HR and Compliance to manage training program effectiveness, regulatory compliance, and workforce capability development."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`learning_course`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the learning course is deployed, for property-level training coverage analysis."
    - name: "course_type"
      expr: course_type
      comment: "Type of course (e-learning, instructor-led, blended, on-the-job) for delivery method analysis."
    - name: "course_status"
      expr: course_status
      comment: "Current status of the course (active, inactive, draft, archived) for catalog management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for the course, used to analyze training modality mix and associated costs."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether the course is required for regulatory compliance, used to prioritize mandatory training completion."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether the course issues a certification upon completion, used to track credentialing program scope."
    - name: "language_code"
      expr: language_code
      comment: "Language of the course content for multilingual workforce training coverage analysis."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the course became effective for training catalog evolution analysis."
  measures:
    - name: "total_course_count"
      expr: COUNT(1)
      comment: "Total courses in the learning catalog. Measures training program breadth and catalog completeness."
    - name: "compliance_course_count"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN learning_course_id END)
      comment: "Count of mandatory compliance courses. Tracks regulatory training obligation coverage — gaps create compliance risk."
    - name: "certification_course_count"
      expr: COUNT(CASE WHEN certification_issued_flag = TRUE THEN learning_course_id END)
      comment: "Count of courses that issue certifications. Measures credentialing program scope for workforce qualification management."
    - name: "avg_cost_per_learner"
      expr: AVG(CAST(cost_per_learner AS DOUBLE))
      comment: "Average cost per learner across courses. Primary L&D efficiency KPI used to benchmark training investment and optimize delivery method mix."
    - name: "total_training_investment"
      expr: SUM(CAST(cost_per_learner AS DOUBLE))
      comment: "Total training cost per learner summed across courses. Proxy for total L&D investment used in budget planning."
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours. Used to estimate total training time investment and schedule training capacity."
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across courses. Used to assess assessment rigor and validate training quality standards."
    - name: "avg_continuing_education_credits"
      expr: AVG(CAST(continuing_education_credits AS DOUBLE))
      comment: "Average continuing education credits awarded per course. Tracks professional development value delivered through the training catalog."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management KPIs tracking leave utilization, FMLA exposure, leave balance, and payroll impact. Used by HR and operations to manage absence risk, ensure FMLA compliance, and forecast labor availability."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the leave request originated, for property-level absence management."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for departmental absence rate analysis."
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (vacation, sick, FMLA, personal, bereavement) for leave category analysis."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Sub-type of leave for granular absence categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request (pending, approved, denied) for leave pipeline monitoring."
    - name: "is_fmla_qualifying"
      expr: is_fmla_qualifying
      comment: "Whether the leave qualifies under FMLA, used for regulatory compliance tracking."
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the leave is paid or unpaid, used for payroll impact analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the leave was requested for trend analysis of absence patterns."
  measures:
    - name: "total_hours_requested"
      expr: SUM(CAST(hours_requested AS DOUBLE))
      comment: "Total leave hours requested. Primary absence volume KPI for workforce availability planning and coverage management."
    - name: "total_hours_taken"
      expr: SUM(CAST(hours_taken AS DOUBLE))
      comment: "Total leave hours actually taken. Measures realized absence impact on labor availability."
    - name: "total_hours_accrued"
      expr: SUM(CAST(hours_accrued AS DOUBLE))
      comment: "Total leave hours accrued across employees. Tracks leave liability on the balance sheet for financial reporting."
    - name: "total_remaining_balance_hours"
      expr: SUM(CAST(remaining_balance_hours AS DOUBLE))
      comment: "Total remaining leave balance hours. Measures accrued leave liability — large balances represent financial risk and must be managed."
    - name: "total_payroll_impact"
      expr: SUM(CAST(payroll_impact_amount AS DOUBLE))
      comment: "Total payroll cost impact of leave requests. Quantifies the financial cost of employee absences for budget variance analysis."
    - name: "total_carryover_hours"
      expr: SUM(CAST(carryover_hours AS DOUBLE))
      comment: "Total leave hours carried over from prior periods. Tracks leave liability accumulation and policy compliance with carryover caps."
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN is_fmla_qualifying = TRUE THEN leave_request_id END)
      comment: "Count of FMLA-qualifying leave requests. Regulatory compliance KPI — tracks FMLA exposure and ensures proper documentation and entitlement management."
    - name: "leave_request_count"
      expr: COUNT(1)
      comment: "Total leave requests submitted. Used to measure absence frequency and calculate absence rate per employee."
    - name: "avg_total_days_per_request"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average duration of leave requests in days. Identifies patterns in leave duration that may indicate abuse or medical complexity."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN approval_status = 'DENIED' THEN leave_request_id END)
      comment: "Count of denied leave requests. High denial rates may indicate policy inconsistency or employee relations risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_payroll_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll period management KPIs tracking period status, processing timelines, and calendar coverage. Used by Payroll and Finance to ensure payroll close completeness, detect processing delays, and manage fiscal calendar alignment."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`payroll_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of payroll period (weekly, bi-weekly, semi-monthly, monthly) for payroll cadence analysis."
    - name: "payroll_period_status"
      expr: payroll_period_status
      comment: "Current status of the payroll period (open, processing, closed, approved) for payroll close monitoring."
    - name: "country_code"
      expr: country_code
      comment: "Country code for multi-jurisdiction payroll period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll period for multi-currency payroll management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payroll period for annual payroll cost reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly payroll cost and headcount reporting."
    - name: "is_adjustment_period"
      expr: is_adjustment_period
      comment: "Whether this is an off-cycle adjustment period, used to track correction activity and associated costs."
    - name: "period_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of the payroll period start date for trend analysis."
  measures:
    - name: "total_period_count"
      expr: COUNT(1)
      comment: "Total payroll periods. Used to validate payroll calendar completeness and detect missing periods."
    - name: "open_period_count"
      expr: COUNT(CASE WHEN payroll_period_status = 'OPEN' THEN payroll_period_id END)
      comment: "Count of currently open payroll periods. Tracks payroll close backlog — multiple open periods indicate processing delays requiring escalation."
    - name: "adjustment_period_count"
      expr: COUNT(CASE WHEN is_adjustment_period = TRUE THEN payroll_period_id END)
      comment: "Count of off-cycle adjustment periods. High adjustment counts indicate payroll processing quality issues and increase compliance risk."
    - name: "year_end_period_count"
      expr: COUNT(CASE WHEN is_year_end_period = TRUE THEN payroll_period_id END)
      comment: "Count of year-end payroll periods. Used to validate year-end payroll close completeness for tax reporting and W-2 preparation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution KPIs tracking gross pay, net pay, tax burden, overtime costs, and labor cost composition per payroll run. Used by Finance and HR leadership to monitor payroll spend, tax liability, and compensation mix across properties and cost centers."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the payroll run was executed, enabling property-level payroll cost analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, bi-weekly, semi-monthly, monthly) for segmenting payroll cadence."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (regular, off-cycle, bonus, adjustment) for categorizing payroll activity."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Current status of the payroll run (calculated, approved, paid, posted) for pipeline monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payroll run was processed."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', payroll_period_start_date)
      comment: "Month bucket of the payroll period start date for trend analysis."
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "GL posting status of the payroll run, used to track financial close readiness."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs in scope. Primary payroll spend KPI used in labor cost reporting and budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Measures actual cash outflow for payroll funding and treasury planning."
    - name: "total_overtime_pay"
      expr: SUM(CAST(total_overtime_pay AS DOUBLE))
      comment: "Total overtime pay cost. Elevated overtime signals scheduling inefficiency or understaffing and triggers workforce planning action."
    - name: "total_regular_pay"
      expr: SUM(CAST(total_regular_pay AS DOUBLE))
      comment: "Total regular (straight-time) pay. Baseline labor cost component for budget benchmarking."
    - name: "total_bonus_pay"
      expr: SUM(CAST(total_bonus_pay AS DOUBLE))
      comment: "Total bonus pay disbursed. Tracks incentive compensation spend against budget and performance targets."
    - name: "total_commission_pay"
      expr: SUM(CAST(total_commission_pay AS DOUBLE))
      comment: "Total commission pay. Measures variable sales compensation cost tied to revenue-generating roles."
    - name: "total_employer_taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer-side payroll tax burden. Critical for total employment cost modeling and tax compliance reporting."
    - name: "total_tax_withholding"
      expr: SUM(CAST(total_tax_withholding AS DOUBLE))
      comment: "Total employee tax withholding remitted. Used for tax liability reconciliation and regulatory compliance."
    - name: "total_service_charge"
      expr: SUM(CAST(total_service_charge AS DOUBLE))
      comment: "Total service charge distributed through payroll. Hospitality-specific KPI for service charge compliance and distribution tracking."
    - name: "total_tip_allocation"
      expr: SUM(CAST(total_tip_allocation AS DOUBLE))
      comment: "Total tip allocation processed through payroll. Tracks tip compliance and IRS tip allocation requirements for hospitality operations."
    - name: "overtime_pay_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(total_overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay. Key efficiency ratio — high values indicate scheduling problems or chronic understaffing requiring immediate management intervention."
    - name: "employer_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_employer_taxes AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Employer tax cost as a percentage of gross pay. Used to model total employment cost and validate tax rate assumptions in labor budgets."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run. Baseline for detecting anomalous payroll runs that may indicate errors or fraud."
    - name: "total_pre_tax_deductions"
      expr: SUM(CAST(total_pre_tax_deductions AS DOUBLE))
      comment: "Total pre-tax benefit deductions (401k, FSA, health premiums). Measures benefit utilization and its impact on taxable wages."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Number of payroll runs processed. Used to validate payroll cadence completeness and detect missing or duplicate runs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance review KPIs tracking rating distributions, completion rates, and merit eligibility. Used by HR and department heads to evaluate workforce quality, identify high performers, and drive merit and succession decisions."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for departmental performance benchmarking."
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary, PIP) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (in-progress, completed, acknowledged) for completion tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for rating distribution analysis."
    - name: "review_period_year"
      expr: DATE_TRUNC('year', review_period_end_date)
      comment: "Year of the review period for annual performance trend analysis."
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Whether the employee is eligible for a merit increase based on this review, used for compensation planning."
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether a promotion was recommended, used for succession planning and talent pipeline analysis."
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether the employee is on a performance improvement plan, used for HR risk and retention monitoring."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'COMPLETED' THEN performance_review_id END)
      comment: "Count of completed performance reviews. Tracks review cycle completion rate — low completion rates indicate process compliance issues."
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews in scope. Used as denominator for completion rate and rating distribution calculations."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Primary workforce quality KPI used in talent calibration sessions and compensation planning."
    - name: "merit_eligible_count"
      expr: COUNT(CASE WHEN merit_increase_eligible_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees eligible for merit increase. Drives merit budget sizing and compensation planning cycles."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees recommended for promotion. Key succession planning KPI for talent pipeline depth assessment."
    - name: "pip_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees on performance improvement plans. Tracks workforce performance risk and HR intervention workload."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'COMPLETED' THEN performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews completed. HR process compliance KPI — low rates trigger escalation to department heads and HR business partners."
    - name: "succession_planning_count"
      expr: COUNT(CASE WHEN succession_planning_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees flagged for succession planning. Measures depth of leadership pipeline for critical role continuity planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce scheduling KPIs tracking scheduled vs actual labor hours, labor cost percentage, and scheduling efficiency. Used by operations and HR leadership to manage labor productivity and cost-per-occupied-room (CPOR) targets."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the schedule was created, enabling property-level scheduling performance comparison."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit (department) for departmental scheduling efficiency analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (weekly, bi-weekly, event-based) for scheduling pattern analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (draft, published, finalized) for scheduling pipeline monitoring."
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the schedule period for trend analysis of labor planning accuracy."
    - name: "is_overtime_approved"
      expr: is_overtime_approved
      comment: "Whether overtime was pre-approved for this schedule, used to track planned vs unplanned overtime exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the schedule labor cost figures."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedules in scope. Primary labor planning volume KPI for capacity and coverage analysis."
    - name: "total_actual_hours"
      expr: SUM(CAST(total_actual_hours AS DOUBLE))
      comment: "Total actual hours worked against schedules. Compared to scheduled hours to measure scheduling accuracy and adherence."
    - name: "total_scheduled_fte"
      expr: SUM(CAST(total_scheduled_fte AS DOUBLE))
      comment: "Total FTE equivalents scheduled. Used for headcount planning and labor model benchmarking."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost at schedule creation. Used for pre-period budget planning and labor cost forecasting."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred. Compared to estimated cost to measure scheduling accuracy and cost control effectiveness."
    - name: "labor_cost_variance"
      expr: ROUND(SUM(CAST(actual_labor_cost AS DOUBLE)) - SUM(CAST(estimated_labor_cost AS DOUBLE)), 2)
      comment: "Actual minus estimated labor cost variance. Positive variance indicates cost overrun; negative indicates favorable performance vs plan."
    - name: "avg_labor_cost_percentage"
      expr: AVG(CAST(labor_cost_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue across schedules. Core USALI KPI — industry benchmark is typically 30-35% for full-service hotels."
    - name: "avg_cpor_labor"
      expr: AVG(CAST(cpor_labor AS DOUBLE))
      comment: "Average cost per occupied room (CPOR) for labor. Hospitality-specific productivity KPI used to benchmark labor efficiency against comp set."
    - name: "hours_variance"
      expr: ROUND(SUM(CAST(total_actual_hours AS DOUBLE)) - SUM(CAST(total_scheduled_hours AS DOUBLE)), 2)
      comment: "Actual minus scheduled hours variance. Measures scheduling adherence — large positive variance indicates unplanned overtime or call-ins."
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of schedules created. Used to validate scheduling completeness across departments and properties."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time and cost KPIs derived from individual time entries. Tracks regular hours, overtime, labor cost, and productivity at the employee, property, and org-unit level. Core operational metric for USALI labor cost management."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the time entry was recorded, enabling property-level labor cost analysis."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit (department) for departmental labor cost and productivity reporting."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, holiday, sick, vacation) for labor category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry (pending, approved, rejected) for payroll readiness monitoring."
    - name: "entry_date_month"
      expr: DATE_TRUNC('month', entry_date)
      comment: "Month of the time entry for trend analysis of labor hours and costs."
    - name: "entry_date_week"
      expr: DATE_TRUNC('week', entry_date)
      comment: "Week of the time entry for weekly labor scheduling and cost variance analysis."
    - name: "shift_differential_code"
      expr: shift_differential_code
      comment: "Shift differential code applied to the entry, used to analyze premium pay distribution across shifts."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Indicates whether the time entry has been included in a payroll run, used for payroll close tracking."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours worked. Primary labor volume KPI for scheduling efficiency and USALI labor cost reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime is a leading indicator of scheduling gaps and drives corrective staffing action."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours. Tracks premium labor cost exposure from extended or holiday shifts."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all entry types. Aggregate labor volume used for productivity and cost-per-hour calculations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost from time entries. Core USALI labor expense KPI used in departmental P&L and budget variance reporting."
    - name: "total_tips_reported"
      expr: SUM(CAST(tips_reported_amount AS DOUBLE))
      comment: "Total tips reported by employees through time entries. Required for IRS tip compliance and hospitality compensation analysis."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Key scheduling efficiency ratio — values above threshold trigger management review of staffing levels."
    - name: "avg_labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_hours_worked AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour worked. Used to benchmark labor efficiency across departments and properties and detect wage anomalies."
    - name: "edited_entry_count"
      expr: SUM(CASE WHEN edited_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of time entries that were edited after initial submission. High edit rates signal timekeeping compliance issues or potential fraud risk."
    - name: "unapproved_hours"
      expr: SUM(CASE WHEN approval_status != 'APPROVED' THEN CAST(total_hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours in unapproved time entries. Tracks payroll close risk — unapproved hours block payroll processing and must be resolved before cutoff."
    - name: "time_entry_count"
      expr: COUNT(1)
      comment: "Total number of time entries. Used to validate timekeeping completeness and detect missing entries for active employees."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_benefit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit plan KPIs tracking employer and employee contribution costs, coverage tiers, and benefit program economics. Used by Total Rewards and Finance to manage benefit cost, ACA compliance, and benefit program ROI."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the benefit plan is offered, for property-level benefit cost analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (medical, dental, vision, life, 401k, FSA) for benefit category cost analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the benefit plan (active, inactive, pending) for plan lifecycle management."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for enrollment and cost tier analysis."
    - name: "aca_compliant_flag"
      expr: aca_compliant_flag
      comment: "Whether the plan meets ACA minimum essential coverage requirements — non-compliant plans create regulatory penalty exposure."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Whether the plan is COBRA-eligible, used for benefits continuation compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benefit plan cost figures."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual benefit cost trend analysis and open enrollment planning."
  measures:
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per benefit plan. Primary benefit cost KPI used in total compensation benchmarking and budget planning."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contribution cost. Aggregate benefit expense used in total labor cost modeling and P&L reporting."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution per benefit plan. Used to assess employee cost-sharing levels and benefit affordability."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average plan deductible amount. Used to assess plan richness and employee out-of-pocket exposure for benefit design decisions."
    - name: "avg_out_of_pocket_maximum"
      expr: AVG(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum across plans. Measures employee financial protection level and plan competitiveness."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount (for life/disability plans). Used to assess benefit adequacy relative to compensation levels."
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN aca_compliant_flag = TRUE THEN workforce_benefit_plan_id END)
      comment: "Count of ACA-compliant benefit plans. Regulatory compliance KPI — non-compliant plans trigger employer mandate penalties."
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total benefit plans offered. Used to assess benefit program breadth and rationalization opportunities."
    - name: "employer_cost_share_pct"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(employer_contribution_amount AS DOUBLE)) + SUM(CAST(employee_contribution_amount AS DOUBLE)), 0), 2)
      comment: "Employer contribution as a percentage of total benefit cost. Measures employer cost-sharing generosity — used in total rewards benchmarking and talent attraction strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce safety KPIs tracking OSHA-recordable incidents, injury severity, days away from work, and corrective action status. Used by Safety, HR, and Operations leadership to manage safety compliance, reduce incident rates, and minimize workers compensation liability."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the safety incident occurred, enabling property-level safety performance benchmarking."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit where the incident occurred for departmental safety analysis."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (slip/fall, strain, chemical exposure, etc.) for root cause and prevention analysis."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity classification of the injury for risk stratification and resource allocation."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA-recordable, used for regulatory reporting and OSHA 300 log management."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation (open, in-progress, closed) for compliance tracking."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the incident was deemed preventable, used to measure safety program effectiveness."
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of the incident for trend analysis of safety performance over time."
  measures:
    - name: "total_incident_count"
      expr: COUNT(1)
      comment: "Total number of workforce safety incidents. Primary safety volume KPI used in OSHA reporting and safety program evaluation."
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN workforce_safety_incident_id END)
      comment: "Count of OSHA-recordable incidents. Regulatory compliance KPI — directly impacts OSHA 300 log and workers compensation experience modifier."
    - name: "preventable_incident_count"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN workforce_safety_incident_id END)
      comment: "Count of preventable incidents. Measures safety program effectiveness — high preventable rates indicate systemic safety culture or training gaps."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of safety incidents. Quantifies financial impact of workplace injuries for insurance and risk management decisions."
    - name: "avg_estimated_cost_per_incident"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per safety incident. Used to prioritize high-cost incident types for targeted prevention investment."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN investigation_status != 'CLOSED' THEN workforce_safety_incident_id END)
      comment: "Count of incidents with open investigations. Tracks safety compliance backlog — open investigations beyond regulatory deadlines create legal exposure."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_recordable_flag = TRUE THEN workforce_safety_incident_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA-recordable. Benchmarked against industry rates to assess relative safety performance."
    - name: "preventable_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventable_flag = TRUE THEN workforce_safety_incident_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as preventable. Key safety culture metric — declining rates indicate improving safety program maturity."
$$;
