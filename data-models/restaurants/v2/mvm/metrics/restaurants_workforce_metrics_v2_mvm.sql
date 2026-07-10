-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, compensation, and turnover analysis"
  source: "`vibe_restaurants_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, seasonal, etc.)"
    - name: "role_classification"
      expr: role_classification
      comment: "Classification of employee role (hourly, salaried, management, etc.)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade or band assigned to employee"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether employee is eligible for overtime pay"
    - name: "union_member"
      expr: union_member
      comment: "Whether employee is a union member"
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "Whether employee holds current ServSafe certification"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year employee was terminated (null if active)"
    - name: "country"
      expr: country
      comment: "Country where employee is located"
    - name: "state"
      expr: state
      comment: "State or province where employee is located"
    - name: "city"
      expr: city
      comment: "City where employee is located"
  measures:
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count - primary headcount metric for workforce planning and capacity analysis"
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary expense across all employees - critical for labor cost management and budgeting"
    - name: "avg_salary"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary per employee - key compensation benchmarking metric"
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target across employees - operational efficiency benchmark"
    - name: "terminated_employees"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of employees with termination dates - turnover analysis metric"
    - name: "servsafe_certified_count"
      expr: COUNT(DISTINCT CASE WHEN servsafe_certified = TRUE THEN employee_id END)
      comment: "Count of ServSafe certified employees - food safety compliance metric"
    - name: "overtime_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Count of overtime-eligible employees - labor scheduling and cost planning metric"
    - name: "union_member_count"
      expr: COUNT(DISTINCT CASE WHEN union_member = TRUE THEN employee_id END)
      comment: "Count of union member employees - labor relations and compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll and compensation metrics including gross pay, net pay, overtime, tips, taxes, and labor cost analysis"
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: pay_period_start
      comment: "Start date of the pay period"
    - name: "pay_period_end"
      expr: pay_period_end
      comment: "End date of the pay period"
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was paid"
    - name: "pay_year"
      expr: YEAR(pay_date)
      comment: "Year of payroll payment"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of payroll payment"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for compliance reporting"
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll (regular, bonus, adjustment, etc.)"
    - name: "employee_type"
      expr: employee_type
      comment: "Type of employee (full-time, part-time, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for payroll amounts"
    - name: "is_bonus"
      expr: is_bonus
      comment: "Whether this payroll record includes bonus payment"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Whether employee is a union member"
    - name: "payroll_record_status"
      expr: payroll_record_status
      comment: "Status of payroll record (processed, pending, voided, etc.)"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll before deductions - primary labor cost metric for P&L and budgeting"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net payroll after deductions - actual cash outflow for workforce compensation"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked - operational efficiency and scheduling effectiveness metric"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked - baseline labor capacity metric"
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total tax withholdings - compliance and cash flow planning metric"
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips paid to employees - service quality indicator and compensation metric"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation - incentive program effectiveness and retention metric"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid - sales performance and variable compensation metric"
    - name: "total_benefit_deduction"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions - employee benefits cost metric"
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as percentage of revenue - key restaurant profitability metric"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across payroll records - compensation benchmarking metric"
    - name: "avg_overtime_rate"
      expr: AVG(CAST(overtime_rate AS DOUBLE))
      comment: "Average overtime pay rate - premium labor cost metric"
    - name: "payroll_record_count"
      expr: COUNT(DISTINCT payroll_record_id)
      comment: "Total distinct payroll records processed - payroll volume and processing efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level labor metrics including scheduled vs actual hours, labor cost, labor percentage, and shift utilization"
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift"
    - name: "shift_year"
      expr: YEAR(shift_date)
      comment: "Year of the shift"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of shift (morning, midday, evening, night)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (regular, split, double, etc.)"
    - name: "shift_status"
      expr: shift_status
      comment: "Status of shift (scheduled, completed, cancelled, no-show, etc.)"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether shift includes overtime hours"
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Whether shift is on-call status"
    - name: "is_deleted"
      expr: is_deleted
      comment: "Whether shift has been deleted"
    - name: "labor_rate_currency_code"
      expr: labor_rate_currency_code
      comment: "Currency code for labor rate"
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled shift hours - labor planning and capacity metric"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked - realized labor capacity and schedule adherence metric"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts - primary operational expense metric for unit-level P&L"
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as percentage of revenue - key profitability and efficiency metric"
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average hourly labor rate - compensation cost metric"
    - name: "total_shifts"
      expr: COUNT(DISTINCT shift_id)
      comment: "Total distinct shifts - scheduling volume and staffing level metric"
    - name: "overtime_shifts"
      expr: COUNT(DISTINCT CASE WHEN overtime_flag = TRUE THEN shift_id END)
      comment: "Count of shifts with overtime - premium labor cost indicator"
    - name: "on_call_shifts"
      expr: COUNT(DISTINCT CASE WHEN on_call_flag = TRUE THEN shift_id END)
      comment: "Count of on-call shifts - staffing flexibility metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics including clock-in/out, total hours, overtime, breaks, and labor cost at entry level"
  source: "`vibe_restaurants_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work performed"
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work performed"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work performed"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, holiday, etc.)"
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of time entry (approved, pending, rejected, etc.)"
    - name: "pay_code"
      expr: pay_code
      comment: "Pay code for time entry classification"
    - name: "approved_by_manager"
      expr: approved_by_manager
      comment: "Whether time entry has been approved by manager"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether time entry includes overtime"
    - name: "break_flag"
      expr: break_flag
      comment: "Whether time entry is for break time"
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Whether employee missed a clock punch (compliance risk indicator)"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all time entries - primary labor capacity and utilization metric"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked - baseline labor capacity metric"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked - premium labor cost and scheduling efficiency metric"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries - operational expense metric for unit-level profitability"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per time entry - compensation cost metric"
    - name: "total_time_entries"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Total distinct time entries - time tracking volume and compliance metric"
    - name: "missed_punch_count"
      expr: COUNT(DISTINCT CASE WHEN missed_punch_flag = TRUE THEN time_entry_id END)
      comment: "Count of missed punch entries - compliance risk and time tracking quality metric"
    - name: "unapproved_entries"
      expr: COUNT(DISTINCT CASE WHEN approved_by_manager = FALSE THEN time_entry_id END)
      comment: "Count of unapproved time entries - payroll processing risk and manager oversight metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce scheduling metrics including FTE by daypart, labor percentage, scheduled hours, and schedule approval status"
  source: "`vibe_restaurants_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of scheduling period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of scheduling period"
    - name: "schedule_year"
      expr: YEAR(period_start_date)
      comment: "Year of schedule period"
    - name: "schedule_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of schedule period"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of schedule (draft, published, approved, locked, etc.)"
    - name: "version"
      expr: version
      comment: "Version of schedule (for revision tracking)"
    - name: "approved_by"
      expr: approved_by
      comment: "Manager or user who approved the schedule"
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours across all schedules - labor planning and capacity metric"
    - name: "total_fte"
      expr: SUM(CAST(fte_total AS DOUBLE))
      comment: "Total full-time equivalent employees scheduled - workforce capacity and headcount planning metric"
    - name: "total_fte_morning"
      expr: SUM(CAST(fte_morning AS DOUBLE))
      comment: "Total FTE scheduled for morning daypart - daypart staffing level metric"
    - name: "total_fte_midday"
      expr: SUM(CAST(fte_midday AS DOUBLE))
      comment: "Total FTE scheduled for midday daypart - peak period staffing metric"
    - name: "total_fte_evening"
      expr: SUM(CAST(fte_evening AS DOUBLE))
      comment: "Total FTE scheduled for evening daypart - dinner service staffing metric"
    - name: "total_fte_night"
      expr: SUM(CAST(fte_night AS DOUBLE))
      comment: "Total FTE scheduled for night daypart - late-night staffing metric"
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost percentage across schedules - profitability and efficiency planning metric"
    - name: "avg_labor_pct_morning"
      expr: AVG(CAST(labor_pct_morning AS DOUBLE))
      comment: "Average labor percentage for morning daypart - daypart profitability metric"
    - name: "avg_labor_pct_midday"
      expr: AVG(CAST(labor_pct_midday AS DOUBLE))
      comment: "Average labor percentage for midday daypart - peak period efficiency metric"
    - name: "avg_labor_pct_evening"
      expr: AVG(CAST(labor_pct_evening AS DOUBLE))
      comment: "Average labor percentage for evening daypart - dinner service efficiency metric"
    - name: "avg_labor_pct_night"
      expr: AVG(CAST(labor_pct_night AS DOUBLE))
      comment: "Average labor percentage for night daypart - late-night efficiency metric"
    - name: "total_schedules"
      expr: COUNT(DISTINCT schedule_id)
      comment: "Total distinct schedules - scheduling volume and planning activity metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification and compliance metrics including certification status, expiration tracking, and mandatory compliance"
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (food safety, alcohol service, first aid, etc.)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of certification (active, expired, pending, revoked, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (compliant, non-compliant, grace period, etc.)"
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization or authority that issued the certification"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether certification is mandatory for the position"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether certification requires periodic renewal"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year certification was issued"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year certification expires"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month certification expires (for renewal planning)"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total distinct certifications - compliance coverage and training investment metric"
    - name: "mandatory_certifications"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE THEN certification_id END)
      comment: "Count of mandatory certifications - regulatory compliance risk metric"
    - name: "expired_certifications"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE() THEN certification_id END)
      comment: "Count of expired certifications - compliance risk and training gap metric"
    - name: "expiring_soon_certifications"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN certification_id END)
      comment: "Count of certifications expiring within 30 days - proactive compliance management metric"
    - name: "non_compliant_certifications"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN certification_id END)
      comment: "Count of non-compliant certifications - regulatory risk and audit exposure metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and development metrics including completion rates, assessment scores, certification attainment, and compliance status"
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (onboarding, safety, skills, compliance, etc.)"
    - name: "training_category"
      expr: training_category
      comment: "Category of training content"
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Status of training completion (completed, in-progress, failed, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status resulting from training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (in-person, online, hybrid, etc.)"
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Whether employee passed the training assessment"
    - name: "certification_required"
      expr: certification_required
      comment: "Whether training leads to required certification"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when training was completed"
    - name: "completion_year"
      expr: YEAR(completion_timestamp)
      comment: "Year training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month training was completed"
  measures:
    - name: "total_training_completions"
      expr: COUNT(DISTINCT training_completion_id)
      comment: "Total training completions - workforce development investment and activity metric"
    - name: "passed_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_passed = TRUE THEN training_completion_id END)
      comment: "Count of passed training assessments - training effectiveness and knowledge retention metric"
    - name: "failed_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_passed = FALSE THEN training_completion_id END)
      comment: "Count of failed training assessments - training quality and employee readiness risk metric"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training - training effectiveness and knowledge quality metric"
    - name: "certification_required_count"
      expr: COUNT(DISTINCT CASE WHEN certification_required = TRUE THEN training_completion_id END)
      comment: "Count of training completions that require certification - compliance training volume metric"
    - name: "compliant_training_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'compliant' THEN training_completion_id END)
      comment: "Count of training completions resulting in compliance - regulatory readiness metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position and role metrics including salary bands, FTE equivalency, labor targets, and position classification"
  source: "`vibe_restaurants_v1`.`workforce`.`position`"
  dimensions:
    - name: "title"
      expr: title
      comment: "Position title"
    - name: "classification"
      expr: classification
      comment: "Position classification (exempt, non-exempt, etc.)"
    - name: "level"
      expr: level
      comment: "Position level or grade"
    - name: "position_status"
      expr: position_status
      comment: "Status of position (active, inactive, frozen, etc.)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift for position (day, night, rotating, etc.)"
    - name: "pay_band"
      expr: pay_band
      comment: "Pay band or salary range for position"
    - name: "is_manager"
      expr: is_manager
      comment: "Whether position is a management role"
    - name: "flsa_exempt"
      expr: flsa_exempt
      comment: "Whether position is exempt from FLSA overtime rules"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether position is eligible for overtime pay"
    - name: "union_eligible"
      expr: union_eligible
      comment: "Whether position is eligible for union membership"
  measures:
    - name: "total_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Total distinct positions - organizational structure and role diversity metric"
    - name: "total_fte_equivalency"
      expr: SUM(CAST(fte_equivalency AS DOUBLE))
      comment: "Total FTE equivalency across all positions - workforce capacity planning metric"
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target by position - operational efficiency benchmark"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across positions - compensation cost metric"
    - name: "avg_salary_min"
      expr: AVG(CAST(salary_min AS DOUBLE))
      comment: "Average minimum salary across positions - compensation floor metric"
    - name: "avg_salary_max"
      expr: AVG(CAST(salary_max AS DOUBLE))
      comment: "Average maximum salary across positions - compensation ceiling metric"
    - name: "management_positions"
      expr: COUNT(DISTINCT CASE WHEN is_manager = TRUE THEN position_id END)
      comment: "Count of management positions - organizational span of control metric"
    - name: "overtime_eligible_positions"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible = TRUE THEN position_id END)
      comment: "Count of overtime-eligible positions - labor cost risk and scheduling complexity metric"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department-level metrics including budget, headcount, turnover rate, area, and operational performance"
  source: "`vibe_restaurants_v1`.`workforce`.`department`"
  dimensions:
    - name: "name"
      expr: name
      comment: "Department name"
    - name: "department_type"
      expr: department_type
      comment: "Type of department (operations, support, management, etc.)"
    - name: "department_status"
      expr: department_status
      comment: "Current status of department (active, inactive, restructuring, etc.)"
    - name: "classification"
      expr: classification
      comment: "Classification of department"
    - name: "service_level"
      expr: service_level
      comment: "Service level or tier of department"
    - name: "is_franchise"
      expr: is_franchise
      comment: "Whether department is part of franchise operation"
    - name: "is_primary"
      expr: is_primary
      comment: "Whether department is primary department"
    - name: "region_code"
      expr: region_code
      comment: "Region code for department location"
    - name: "country_code"
      expr: country_code
      comment: "Country code for department location"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year department opened"
  measures:
    - name: "total_departments"
      expr: COUNT(DISTINCT department_id)
      comment: "Total distinct departments - organizational structure and complexity metric"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget across all departments - financial planning and resource allocation metric"
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per department - departmental resource level metric"
    - name: "total_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total square footage across departments - facility capacity and space utilization metric"
    - name: "avg_turnover_rate"
      expr: AVG(CAST(turnover_rate AS DOUBLE))
      comment: "Average employee turnover rate by department - retention and organizational health metric"
$$;