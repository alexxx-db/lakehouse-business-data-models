-- Metric views for domain: workforce | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking headcount, demographics, tenure, and employment status for strategic workforce planning and compliance reporting."
  source: "`vibe_automotive_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.) for headcount segmentation"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor, temporary) for workforce composition analysis"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-based workforce analysis"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for organizational unit analysis"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier for site-level workforce planning"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Union membership indicator for labor relations analysis"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation structure analysis"
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO category for diversity and compliance reporting"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort and retention analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic workforce distribution"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating for talent management"
    - name: "iatf_competency_status"
      expr: iatf_competency_status
      comment: "IATF 16949 competency status for quality system compliance"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count for workforce size tracking"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees for current workforce capacity"
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary expense for workforce cost planning"
    - name: "avg_salary"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary per employee for compensation benchmarking"
    - name: "union_member_count"
      expr: COUNT(DISTINCT CASE WHEN union_member_flag = TRUE THEN employee_id END)
      comment: "Count of union members for labor relations planning"
    - name: "overtime_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Count of overtime-eligible employees for capacity planning"
    - name: "iatf_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iatf_competency_status = 'Certified' THEN employee_id END)
      comment: "Count of IATF-certified employees for quality system compliance"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days for retention analysis"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and time tracking metrics for production efficiency, labor cost allocation, and overtime management."
  source: "`vibe_automotive_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work for daily labor tracking"
    - name: "work_week"
      expr: DATE_TRUNC('WEEK', work_date)
      comment: "Week of work for weekly labor planning"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for monthly labor cost analysis"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier for individual labor tracking"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for departmental labor cost allocation"
    - name: "production_order_id"
      expr: production_order_id
      comment: "Production order identifier for job costing"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-based labor analysis"
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (direct, indirect, overhead) for cost classification"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial allocation"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, absence) for labor mix analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for time entry compliance tracking"
    - name: "union_code"
      expr: union_code
      comment: "Union code for labor agreement compliance"
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked for baseline labor capacity"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours for overtime cost management"
    - name: "total_shift_differential_hours"
      expr: SUM(CAST(shift_differential_hours AS DOUBLE))
      comment: "Total shift differential hours for premium pay tracking"
    - name: "total_labor_hours"
      expr: SUM((CAST(regular_hours AS DOUBLE)) + (CAST(overtime_hours AS DOUBLE)))
      comment: "Total labor hours (regular plus overtime) for total labor input"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_rate_amount AS DOUBLE) * (CAST(regular_hours AS DOUBLE) + CAST(overtime_hours AS DOUBLE) * CAST(overtime_multiplier AS DOUBLE)))
      comment: "Total labor cost including overtime premium for labor expense tracking"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate_amount AS DOUBLE))
      comment: "Average labor rate per hour for cost benchmarking"
    - name: "overtime_percentage"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)) + SUM(CAST(overtime_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of total hours for overtime management"
    - name: "time_entry_count"
      expr: COUNT(time_entry_id)
      comment: "Count of time entries for time tracking compliance"
    - name: "unique_employees_worked"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of unique employees who worked for active workforce tracking"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll expense and compensation metrics for financial planning, labor cost control, and payroll compliance."
  source: "`vibe_automotive_v1`.`workforce`.`payroll_result`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Pay period start date for payroll cycle analysis"
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Pay period month for monthly payroll expense tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting alignment"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier for individual payroll tracking"
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental payroll allocation"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial cost allocation"
    - name: "employee_type"
      expr: employee_type
      comment: "Employee type for workforce segment payroll analysis"
    - name: "payroll_group"
      expr: payroll_group
      comment: "Payroll group for payroll processing segmentation"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Pay rate type (hourly, salary) for compensation structure analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check) for payroll operations"
    - name: "is_union_member"
      expr: is_union_member
      comment: "Union membership flag for labor agreement compliance"
    - name: "payroll_result_status"
      expr: payroll_result_status
      comment: "Payroll result status for payroll processing tracking"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay for total labor cost before deductions"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay for actual cash disbursement to employees"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary for baseline compensation expense"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay for premium labor cost tracking"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments for variable compensation expense"
    - name: "total_benefit_deduction"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions for employee benefit cost tracking"
    - name: "total_tax_deduction"
      expr: SUM(CAST(tax_deduction AS DOUBLE))
      comment: "Total tax withholdings for payroll tax compliance"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer benefit contributions for total compensation cost"
    - name: "total_union_dues"
      expr: SUM(CAST(union_dues AS DOUBLE))
      comment: "Total union dues deducted for labor relations tracking"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per employee for compensation benchmarking"
    - name: "overtime_pay_percentage"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Overtime pay as percentage of gross pay for overtime cost control"
    - name: "payroll_record_count"
      expr: COUNT(payroll_result_id)
      comment: "Count of payroll records for payroll processing volume"
    - name: "unique_employees_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of unique employees paid for active payroll headcount"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence and leave metrics for workforce availability, absenteeism management, and labor capacity planning."
  source: "`vibe_automotive_v1`.`workforce`.`absence_record`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Absence start date for absence tracking"
    - name: "absence_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Absence month for monthly absenteeism analysis"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier for individual absence tracking"
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, FMLA, etc.) for absence category analysis"
    - name: "absence_category"
      expr: absence_category
      comment: "Absence category for high-level absence classification"
    - name: "absence_record_status"
      expr: absence_record_status
      comment: "Absence record status (approved, pending, denied) for absence approval tracking"
    - name: "medical_certification_flag"
      expr: medical_certification_flag
      comment: "Medical certification indicator for compliance tracking"
    - name: "union_leave_flag"
      expr: union_leave_flag
      comment: "Union leave indicator for labor agreement compliance"
    - name: "shift_impact_flag"
      expr: shift_impact_flag
      comment: "Shift impact indicator for production capacity planning"
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total absence days for workforce availability impact"
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total absence hours for labor capacity loss"
    - name: "absence_record_count"
      expr: COUNT(absence_record_id)
      comment: "Count of absence records for absenteeism frequency"
    - name: "unique_employees_absent"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of unique employees with absences for absenteeism prevalence"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average absence duration in days for absence severity"
    - name: "medical_certified_absence_count"
      expr: COUNT(CASE WHEN medical_certification_flag = TRUE THEN absence_record_id END)
      comment: "Count of medically certified absences for compliance tracking"
    - name: "shift_impact_absence_count"
      expr: COUNT(CASE WHEN shift_impact_flag = TRUE THEN absence_record_id END)
      comment: "Count of absences impacting shifts for production capacity risk"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident metrics for OSHA compliance, safety performance tracking, and risk management."
  source: "`vibe_automotive_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_timestamp"
      expr: incident_timestamp
      comment: "Incident timestamp for incident tracking"
    - name: "incident_date"
      expr: DATE(incident_timestamp)
      comment: "Incident date for daily safety tracking"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Incident month for monthly safety performance"
    - name: "safety_employee_id"
      expr: safety_employee_id
      comment: "Employee identifier for individual safety tracking"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident for incident classification"
    - name: "incident_category"
      expr: incident_category
      comment: "Incident category for high-level safety analysis"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Injury severity (minor, moderate, severe) for risk assessment"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "OSHA recordable indicator for regulatory compliance"
    - name: "lost_time_indicator"
      expr: lost_time_indicator
      comment: "Lost time indicator for lost time injury rate calculation"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level safety performance"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center code for area-level safety analysis"
    - name: "shift"
      expr: shift
      comment: "Shift for shift-based safety pattern analysis"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected for injury pattern analysis"
    - name: "incident_status"
      expr: incident_status
      comment: "Incident status for investigation tracking"
  measures:
    - name: "total_incidents"
      expr: COUNT(safety_incident_id)
      comment: "Total safety incidents for overall safety performance"
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN safety_incident_id END)
      comment: "Count of OSHA recordable incidents for regulatory compliance"
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN lost_time_indicator = TRUE THEN safety_incident_id END)
      comment: "Count of lost time incidents for LTIR calculation"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days away from work due to incidents for severity impact"
    - name: "avg_days_away_per_incident"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away per incident for incident severity"
    - name: "unique_employees_injured"
      expr: COUNT(DISTINCT safety_employee_id)
      comment: "Count of unique employees injured for safety exposure"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and competency metrics for workforce development, IATF compliance, and skills management."
  source: "`vibe_automotive_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "completion_date"
      expr: completion_date
      comment: "Training completion date for training tracking"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Training completion month for monthly training activity"
    - name: "training_employee_id"
      expr: training_employee_id
      comment: "Employee identifier for individual training tracking"
    - name: "training_course_id"
      expr: training_course_id
      comment: "Training course identifier for course-level analysis"
    - name: "course_type"
      expr: course_type
      comment: "Course type for training category analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (classroom, online, OJT) for training modality analysis"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail status for training effectiveness"
    - name: "iatf_competency_flag"
      expr: iatf_competency_flag
      comment: "IATF competency indicator for quality system compliance"
    - name: "safety_certification_flag"
      expr: safety_certification_flag
      comment: "Safety certification indicator for safety compliance"
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Recertification required indicator for training renewal tracking"
    - name: "training_record_status"
      expr: training_record_status
      comment: "Training record status for training completion tracking"
    - name: "competency_category"
      expr: competency_category
      comment: "Competency category for skills taxonomy analysis"
  measures:
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered for training investment"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours earned for competency development"
    - name: "training_record_count"
      expr: COUNT(training_record_id)
      comment: "Count of training records for training activity volume"
    - name: "unique_employees_trained"
      expr: COUNT(DISTINCT training_employee_id)
      comment: "Count of unique employees trained for training reach"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training score for training effectiveness"
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN training_record_id END)
      comment: "Count of passed training records for training success rate"
    - name: "iatf_training_count"
      expr: COUNT(CASE WHEN iatf_competency_flag = TRUE THEN training_record_id END)
      comment: "Count of IATF competency training for quality system compliance"
    - name: "safety_certification_count"
      expr: COUNT(CASE WHEN safety_certification_flag = TRUE THEN training_record_id END)
      comment: "Count of safety certifications for safety compliance"
    - name: "avg_training_hours_per_employee"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per record for training intensity"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics for talent assessment, merit planning, and workforce development."
  source: "`vibe_automotive_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_date"
      expr: review_date
      comment: "Review date for performance review tracking"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Review month for monthly performance review activity"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier for individual performance tracking"
    - name: "reviewer_employee_id"
      expr: reviewer_employee_id
      comment: "Reviewer identifier for reviewer analysis"
    - name: "review_type"
      expr: review_type
      comment: "Review type (annual, mid-year, probation) for review cycle analysis"
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle for performance period tracking"
    - name: "review_period_year"
      expr: review_period_year
      comment: "Review period year for annual performance analysis"
    - name: "review_status"
      expr: review_status
      comment: "Review status for review completion tracking"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for performance calibration process"
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Promotion recommendation for talent pipeline analysis"
  measures:
    - name: "review_count"
      expr: COUNT(performance_review_id)
      comment: "Count of performance reviews for review completion tracking"
    - name: "unique_employees_reviewed"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of unique employees reviewed for review coverage"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating for workforce performance level"
    - name: "avg_technical_rating"
      expr: AVG(CAST(technical_rating AS DOUBLE))
      comment: "Average technical rating for technical competency assessment"
    - name: "avg_leadership_rating"
      expr: AVG(CAST(leadership_rating AS DOUBLE))
      comment: "Average leadership rating for leadership capability assessment"
    - name: "avg_teamwork_rating"
      expr: AVG(CAST(teamwork_rating AS DOUBLE))
      comment: "Average teamwork rating for collaboration effectiveness"
    - name: "avg_communication_rating"
      expr: AVG(CAST(communication_rating AS DOUBLE))
      comment: "Average communication rating for communication effectiveness"
    - name: "avg_innovation_rating"
      expr: AVG(CAST(innovation_rating AS DOUBLE))
      comment: "Average innovation rating for innovation capability"
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score for goal attainment"
    - name: "avg_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percentage for compensation planning"
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommendation IS NOT NULL AND promotion_recommendation != 'None' THEN performance_review_id END)
      comment: "Count of promotion recommendations for talent pipeline"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_labor_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost allocation metrics for production costing, cost center management, and financial planning."
  source: "`vibe_automotive_v1`.`workforce`.`labor_cost_allocation`"
  dimensions:
    - name: "allocation_date"
      expr: allocation_date
      comment: "Allocation date for labor cost tracking"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Allocation month for monthly labor cost analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting alignment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual labor cost analysis"
    - name: "production_order_id"
      expr: production_order_id
      comment: "Production order identifier for job costing"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for departmental labor cost"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for cost center allocation"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier for site-level labor cost"
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (direct, indirect) for cost classification"
    - name: "cost_allocation_type"
      expr: cost_allocation_type
      comment: "Cost allocation type for allocation method analysis"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method for allocation logic tracking"
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code for activity-based costing"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-based cost analysis"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Overtime indicator for premium labor cost tracking"
    - name: "labor_cost_allocation_status"
      expr: labor_cost_allocation_status
      comment: "Allocation status for allocation completion tracking"
  measures:
    - name: "total_allocated_cost"
      expr: SUM(CAST(allocated_cost AS DOUBLE))
      comment: "Total allocated labor cost for production costing"
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total allocated labor hours for labor input tracking"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate for cost rate benchmarking"
    - name: "allocation_record_count"
      expr: COUNT(labor_cost_allocation_id)
      comment: "Count of allocation records for allocation volume"
    - name: "direct_labor_cost"
      expr: SUM(CASE WHEN labor_category = 'Direct' THEN CAST(allocated_cost AS DOUBLE) ELSE 0 END)
      comment: "Total direct labor cost for product costing"
    - name: "indirect_labor_cost"
      expr: SUM(CASE WHEN labor_category = 'Indirect' THEN CAST(allocated_cost AS DOUBLE) ELSE 0 END)
      comment: "Total indirect labor cost for overhead tracking"
    - name: "overtime_labor_cost"
      expr: SUM(CASE WHEN overtime_flag = TRUE THEN CAST(allocated_cost AS DOUBLE) ELSE 0 END)
      comment: "Total overtime labor cost for premium cost tracking"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning and workforce capacity metrics for strategic workforce planning, budget management, and capacity forecasting."
  source: "`vibe_automotive_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Plan start date for planning period tracking"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Plan month for monthly headcount planning"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual headcount planning"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier for org-level planning"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier for site-level headcount planning"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (budget, forecast, actual) for planning scenario analysis"
    - name: "headcount_category"
      expr: headcount_category
      comment: "Headcount category for workforce segment planning"
    - name: "job_family_code"
      expr: job_family_code
      comment: "Job family code for role-based planning"
    - name: "period_type"
      expr: period_type
      comment: "Period type (monthly, quarterly, annual) for planning granularity"
    - name: "headcount_plan_status"
      expr: headcount_plan_status
      comment: "Plan status for plan approval tracking"
    - name: "unionized_flag"
      expr: unionized_flag
      comment: "Unionized indicator for labor agreement planning"
  measures:
    - name: "total_planned_headcount"
      expr: SUM(CAST(planned_headcount AS DOUBLE))
      comment: "Total planned headcount for workforce capacity planning"
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS DOUBLE))
      comment: "Total actual headcount for plan vs actual tracking"
    - name: "total_variance_headcount"
      expr: SUM(CAST(variance_headcount AS DOUBLE))
      comment: "Total headcount variance for planning accuracy"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total headcount budget for financial planning"
    - name: "avg_attrition_rate"
      expr: AVG(CAST(attrition_rate AS DOUBLE))
      comment: "Average attrition rate for retention planning"
    - name: "avg_capacity_factor"
      expr: AVG(CAST(capacity_factor AS DOUBLE))
      comment: "Average capacity factor for productivity planning"
    - name: "plan_count"
      expr: COUNT(headcount_plan_id)
      comment: "Count of headcount plans for planning activity"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_talent_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition and recruitment metrics for hiring effectiveness, time-to-fill, and recruitment cost management."
  source: "`vibe_automotive_v1`.`workforce`.`talent_requisition`"
  dimensions:
    - name: "posting_date"
      expr: posting_date
      comment: "Requisition posting date for recruitment tracking"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for monthly recruitment activity"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for departmental hiring"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier for org-level hiring"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status (open, filled, cancelled) for hiring pipeline"
    - name: "job_code"
      expr: job_code
      comment: "Job code for role-based recruitment analysis"
    - name: "headcount_type"
      expr: headcount_type
      comment: "Headcount type (new, replacement) for hiring reason analysis"
    - name: "priority"
      expr: priority
      comment: "Requisition priority for hiring urgency"
    - name: "is_internal_requisition"
      expr: is_internal_requisition
      comment: "Internal requisition indicator for internal mobility"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel for recruitment source effectiveness"
    - name: "remote_option"
      expr: remote_option
      comment: "Remote option indicator for remote work analysis"
    - name: "compliance_iatf_required"
      expr: compliance_iatf_required
      comment: "IATF compliance required indicator for quality system hiring"
  measures:
    - name: "requisition_count"
      expr: COUNT(talent_requisition_id)
      comment: "Count of talent requisitions for hiring volume"
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN talent_requisition_id END)
      comment: "Count of open requisitions for hiring pipeline"
    - name: "filled_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN talent_requisition_id END)
      comment: "Count of filled requisitions for hiring success"
    - name: "total_headcount_quantity"
      expr: SUM(CAST(headcount_quantity AS DOUBLE))
      comment: "Total headcount quantity for hiring demand"
    - name: "total_recruitment_budget"
      expr: SUM(CAST(recruitment_budget AS DOUBLE))
      comment: "Total recruitment budget for hiring cost planning"
    - name: "avg_budgeted_salary"
      expr: AVG(CAST(budgeted_salary AS DOUBLE))
      comment: "Average budgeted salary for compensation planning"
    - name: "avg_time_to_fill_days"
      expr: AVG(DATEDIFF(filled_date, posting_date))
      comment: "Average time to fill in days for hiring efficiency"
$$;
