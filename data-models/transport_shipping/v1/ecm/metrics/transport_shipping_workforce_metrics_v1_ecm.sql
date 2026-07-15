-- Metric views for domain: workforce | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payroll metrics tracking labor costs, compensation components, and workforce cost efficiency for transport shipping operations."
  source: "`transport_shipping_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period for time-based payroll analysis"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, bi-weekly, monthly) for cohort analysis"
    - name: "department_code"
      expr: department_code
      comment: "Department for cost allocation and departmental labor analysis"
    - name: "location_code"
      expr: location_code
      comment: "Work location code for geographic labor cost comparison"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll amounts for multi-currency reporting"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (direct deposit, check, etc.)"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll record for processing pipeline tracking"
    - name: "job_code"
      expr: job_code
      comment: "Job classification code for role-based compensation analysis"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay across all payroll records — primary labor cost indicator"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees after all deductions"
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_amount AS DOUBLE))
      comment: "Total overtime pay — key indicator of staffing adequacy and labor cost overruns"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions including taxes, benefits, and garnishments"
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost_amount AS DOUBLE))
      comment: "Fully-loaded labor cost including employer contributions — true cost of workforce"
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record — compensation benchmarking metric"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked — workforce capacity and scheduling efficiency indicator"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked across all employees"
    - name: "total_employer_tax_burden"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer-side tax obligations — compliance and cost planning metric"
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction_amount AS DOUBLE))
      comment: "Total employee benefit deductions — benefits participation indicator"
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions — long-term workforce investment metric"
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Count of payroll records processed — operational volume baseline"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce absence and leave metrics tracking absenteeism patterns, operational impact, and leave utilization for transport shipping workforce planning."
  source: "`transport_shipping_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, personal, FMLA, etc.) for pattern analysis"
    - name: "absence_reason"
      expr: absence_reason
      comment: "Reason for absence — root cause analysis for absenteeism reduction"
    - name: "absence_status"
      expr: absence_status
      comment: "Current status of the absence request (approved, pending, denied)"
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the absence is paid leave — cost impact classification"
    - name: "impact_on_operations"
      expr: impact_on_operations
      comment: "Assessed operational impact level of the absence"
    - name: "coverage_arranged"
      expr: coverage_arranged
      comment: "Whether coverage was arranged for the absent employee"
    - name: "location_code"
      expr: location_code
      comment: "Work location for geographic absenteeism analysis"
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Whether the absence is intermittent — scheduling complexity indicator"
    - name: "start_date"
      expr: start_date
      comment: "Start date of absence for temporal trend analysis"
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total days of absence — primary absenteeism volume metric"
    - name: "total_absence_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours of absence — granular capacity loss measurement"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average duration of absence episodes — severity indicator"
    - name: "total_leave_balance_consumed"
      expr: SUM(CAST(leave_balance_consumed AS DOUBLE))
      comment: "Total leave balance consumed — leave liability tracking"
    - name: "absence_record_count"
      expr: COUNT(1)
      comment: "Count of absence records — frequency of absence events"
    - name: "distinct_absent_employees"
      expr: COUNT(DISTINCT primary_absence_employee_id)
      comment: "Number of unique employees with absences — breadth of absenteeism"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_hours_of_service_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DOT Hours of Service compliance metrics for transport drivers — critical for regulatory compliance, safety, and operational dispatch planning."
  source: "`transport_shipping_ecm`.`workforce`.`hours_of_service_log`"
  dimensions:
    - name: "duty_status"
      expr: duty_status
      comment: "Current duty status (driving, on-duty not driving, sleeper berth, off-duty)"
    - name: "cycle_type"
      expr: cycle_type
      comment: "HOS cycle type (60-hour/7-day or 70-hour/8-day)"
    - name: "violation_flag"
      expr: violation_flag
      comment: "Whether this log entry represents an HOS violation"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of HOS violation for compliance categorization"
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of HOS violation"
    - name: "certification_status"
      expr: certification_status
      comment: "Driver certification status of the log entry"
    - name: "dispatch_eligibility_flag"
      expr: dispatch_eligibility_flag
      comment: "Whether driver is eligible for dispatch based on remaining hours"
    - name: "rest_break_compliant_flag"
      expr: rest_break_compliant_flag
      comment: "Whether the required rest break was taken in compliance"
    - name: "log_date"
      expr: log_date
      comment: "Date of the HOS log entry for daily compliance tracking"
    - name: "log_entry_method"
      expr: log_entry_method
      comment: "Method of log entry (ELD automatic, manual, edited)"
  measures:
    - name: "total_driving_hours"
      expr: SUM(CAST(driving_hours_accumulated AS DOUBLE))
      comment: "Total accumulated driving hours — capacity utilization and compliance threshold tracking"
    - name: "total_on_duty_hours"
      expr: SUM(CAST(on_duty_hours_accumulated AS DOUBLE))
      comment: "Total on-duty hours — full duty time for 14-hour rule compliance"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total duration of all log entries — complete time accounting"
    - name: "avg_hours_remaining_to_drive"
      expr: AVG(CAST(hours_remaining_to_drive AS DOUBLE))
      comment: "Average remaining drivable hours — fleet dispatch capacity indicator"
    - name: "avg_hours_remaining_in_cycle"
      expr: AVG(CAST(hours_remaining_in_cycle AS DOUBLE))
      comment: "Average remaining cycle hours — weekly capacity planning metric"
    - name: "total_distance_traveled"
      expr: SUM(CAST(distance_traveled AS DOUBLE))
      comment: "Total distance traveled by drivers — productivity and route efficiency metric"
    - name: "violation_count"
      expr: SUM(CASE WHEN violation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of HOS violations — primary DOT compliance risk metric"
    - name: "distinct_drivers_logged"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique drivers with HOS logs — active driver fleet size"
    - name: "log_entry_count"
      expr: COUNT(1)
      comment: "Total HOS log entries — operational volume baseline"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_shift_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and workforce deployment metrics tracking labor utilization, overtime, and attendance for warehouse and transport operations."
  source: "`transport_shipping_ecm`.`workforce`.`shift_assignment`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (day, night, swing, split) for scheduling pattern analysis"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the shift assignment (confirmed, pending, cancelled)"
    - name: "attendance_status"
      expr: attendance_status
      comment: "Actual attendance outcome (present, absent, late, early departure)"
    - name: "is_overtime"
      expr: is_overtime
      comment: "Whether the shift is an overtime shift — cost and fatigue indicator"
    - name: "is_holiday_shift"
      expr: is_holiday_shift
      comment: "Whether the shift falls on a holiday — premium pay indicator"
    - name: "is_weekend_shift"
      expr: is_weekend_shift
      comment: "Whether the shift is on a weekend — scheduling preference analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation"
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date of the shift assignment for temporal analysis"
    - name: "job_role_code"
      expr: job_role_code
      comment: "Job role assigned to the shift for skills-based scheduling analysis"
  measures:
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked across all shift assignments — realized labor capacity"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours — planned labor capacity"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours on shift assignments — overtime cost driver"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost from shift assignments — direct operational cost"
    - name: "avg_hours_per_shift"
      expr: AVG(CAST(actual_hours_worked AS DOUBLE))
      comment: "Average hours worked per shift — shift efficiency metric"
    - name: "shift_assignment_count"
      expr: COUNT(1)
      comment: "Total shift assignments — scheduling volume"
    - name: "distinct_employees_scheduled"
      expr: COUNT(DISTINCT employee_id)
      comment: "Unique employees with shift assignments — active workforce deployment breadth"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition metrics tracking hiring pipeline, time-to-fill, and workforce planning effectiveness for transport shipping operations."
  source: "`transport_shipping_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, filled, cancelled, on-hold)"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new position, replacement, expansion)"
    - name: "job_family"
      expr: job_family
      comment: "Job family for role-category hiring analysis"
    - name: "job_function"
      expr: job_function
      comment: "Job function for functional area hiring trends"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition — urgency classification"
    - name: "is_safety_sensitive"
      expr: is_safety_sensitive
      comment: "Whether the role is safety-sensitive — DOT/regulatory hiring requirements"
    - name: "requires_dot_certification"
      expr: requires_dot_certification
      comment: "Whether DOT certification is required — specialized talent pool indicator"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Remote work eligibility — talent pool expansion indicator"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Recruitment sourcing channel for channel effectiveness analysis"
    - name: "requisition_open_date"
      expr: requisition_open_date
      comment: "Date requisition was opened for time-based pipeline analysis"
  measures:
    - name: "open_requisition_count"
      expr: SUM(CASE WHEN requisition_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open requisitions — hiring demand indicator"
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total requisitions — overall hiring activity volume"
    - name: "total_planned_fte"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE planned across requisitions — workforce growth indicator"
    - name: "avg_salary_range_midpoint"
      expr: AVG((CAST(salary_range_minimum AS DOUBLE) + CAST(salary_range_maximum AS DOUBLE)) / 2)
      comment: "Average salary midpoint across requisitions — compensation planning benchmark"
    - name: "avg_offer_acceptance_rate"
      expr: AVG(CAST(offer_acceptance_rate AS DOUBLE))
      comment: "Average offer acceptance rate — employer brand and compensation competitiveness indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance and talent management metrics tracking review outcomes, ratings distribution, and development needs for workforce optimization."
  source: "`transport_shipping_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for distribution analysis"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probationary, PIP)"
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (draft, submitted, calibrated, acknowledged)"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for rating consistency tracking"
    - name: "job_family"
      expr: job_family
      comment: "Job family for role-based performance comparison"
    - name: "department_code"
      expr: department_code
      comment: "Department for organizational performance comparison"
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether promotion was recommended — talent pipeline indicator"
    - name: "pip_flag"
      expr: pip_flag
      comment: "Whether employee is on performance improvement plan — risk indicator"
    - name: "review_period_end_date"
      expr: review_period_end_date
      comment: "End of review period for temporal performance trending"
  measures:
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score — organizational performance health"
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score — execution effectiveness metric"
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating — skills and capability health metric"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage — compensation progression metric"
    - name: "promotion_recommended_count"
      expr: SUM(CASE WHEN promotion_recommended_flag = true THEN 1 ELSE 0 END)
      comment: "Count of promotion recommendations — talent pipeline readiness"
    - name: "pip_count"
      expr: SUM(CASE WHEN pip_flag = true THEN 1 ELSE 0 END)
      comment: "Count of employees on PIP — performance risk indicator"
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total performance reviews — review cycle completion tracking"
    - name: "bonus_eligible_count"
      expr: SUM(CASE WHEN bonus_eligible_flag = true THEN 1 ELSE 0 END)
      comment: "Count of bonus-eligible employees — variable compensation exposure"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_driver_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Driver qualification and compliance metrics for DOT-regulated transport operations — tracking CDL status, medical certifications, and qualification file completeness."
  source: "`transport_shipping_ecm`.`workforce`.`driver_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Overall qualification status (qualified, disqualified, pending)"
    - name: "cdl_class"
      expr: cdl_class
      comment: "CDL class (A, B, C) for fleet capability analysis"
    - name: "mvr_status"
      expr: mvr_status
      comment: "Motor Vehicle Record status — driving history risk indicator"
    - name: "drug_test_result"
      expr: drug_test_result
      comment: "Most recent drug test result for compliance tracking"
    - name: "alcohol_test_result"
      expr: alcohol_test_result
      comment: "Most recent alcohol test result for compliance tracking"
    - name: "endorsement_hazmat"
      expr: endorsement_hazmat
      comment: "Whether driver has hazmat endorsement — specialized capability"
    - name: "endorsement_tanker"
      expr: endorsement_tanker
      comment: "Whether driver has tanker endorsement — specialized capability"
    - name: "clearinghouse_status"
      expr: clearinghouse_status
      comment: "FMCSA Clearinghouse query status — regulatory compliance"
    - name: "qualification_file_complete"
      expr: qualification_file_complete
      comment: "Whether the driver qualification file is complete — audit readiness"
    - name: "hos_eligibility_status"
      expr: hos_eligibility_status
      comment: "Hours of Service eligibility status for dispatch planning"
  measures:
    - name: "total_qualified_drivers"
      expr: SUM(CASE WHEN qualification_status = 'Qualified' THEN 1 ELSE 0 END)
      comment: "Count of fully qualified drivers — available driver capacity"
    - name: "total_disqualified_drivers"
      expr: SUM(CASE WHEN qualification_status = 'Disqualified' THEN 1 ELSE 0 END)
      comment: "Count of disqualified drivers — compliance risk and capacity gap"
    - name: "complete_qualification_files"
      expr: SUM(CASE WHEN qualification_file_complete = true THEN 1 ELSE 0 END)
      comment: "Count of complete qualification files — DOT audit readiness metric"
    - name: "hazmat_endorsed_drivers"
      expr: SUM(CASE WHEN endorsement_hazmat = true THEN 1 ELSE 0 END)
      comment: "Count of hazmat-endorsed drivers — specialized capacity for dangerous goods"
    - name: "driver_qualification_count"
      expr: COUNT(1)
      comment: "Total driver qualification records — fleet size baseline"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_labor_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost allocation metrics tracking how workforce costs are distributed across business units, freight modes, and operational functions for profitability analysis."
  source: "`transport_shipping_ecm`.`workforce`.`labor_cost_allocation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental labor cost tracking"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit for divisional cost analysis"
    - name: "freight_mode"
      expr: freight_mode
      comment: "Freight mode (air, ocean, ground, rail) for modal cost comparison"
    - name: "operational_function"
      expr: operational_function
      comment: "Operational function (warehouse, transport, customs, admin) for functional cost analysis"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation (direct, proportional, activity-based)"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the labor cost is billable to a customer — revenue recovery indicator"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic cost trending"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost comparison"
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic labor cost benchmarking"
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date of cost allocation for temporal analysis"
  measures:
    - name: "total_allocated_labor_cost"
      expr: SUM(CAST(total_labor_cost_amount AS DOUBLE))
      comment: "Total allocated labor cost — primary workforce cost metric for P&L"
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total hours allocated — labor capacity deployment metric"
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_amount AS DOUBLE))
      comment: "Total overtime cost allocated — premium labor cost indicator"
    - name: "total_benefits_cost"
      expr: SUM(CAST(benefits_amount AS DOUBLE))
      comment: "Total benefits cost allocated — fully-loaded cost component"
    - name: "total_base_salary_allocated"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary allocated — core compensation cost"
    - name: "total_bonus_allocated"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus cost allocated — variable compensation exposure"
    - name: "billable_labor_cost"
      expr: SUM(CASE WHEN is_billable = true THEN CAST(total_labor_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable labor cost — revenue-recoverable workforce investment"
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(allocated_amount AS DOUBLE) / NULLIF(CAST(allocated_hours AS DOUBLE), 0))
      comment: "Average cost per allocated hour — labor rate efficiency metric"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Count of labor cost allocation records — transaction volume"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation planning metrics tracking salary levels, pay equity, and total compensation structure for workforce cost management and talent retention."
  source: "`transport_shipping_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan (salary, hourly, commission, hybrid)"
    - name: "compensation_plan_status"
      expr: compensation_plan_status
      comment: "Status of the compensation plan (active, pending, expired)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency for compensation structure analysis"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt/non-exempt) for compliance and overtime eligibility"
    - name: "grade_band"
      expr: grade_band
      comment: "Compensation grade band for pay equity analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency compensation reporting"
    - name: "bonus_eligible_flag"
      expr: bonus_eligible_flag
      comment: "Whether employee is bonus eligible — variable pay exposure"
    - name: "reason_for_change"
      expr: reason_for_change
      comment: "Reason for compensation change (promotion, merit, market adjustment)"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of compensation plan for temporal analysis"
  measures:
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary — compensation competitiveness benchmark"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary commitment — fixed labor cost exposure"
    - name: "avg_target_bonus_pct"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus percentage — variable compensation structure metric"
    - name: "avg_compa_ratio"
      expr: AVG(CAST(base_salary_amount AS DOUBLE) / NULLIF(CAST(pay_range_midpoint AS DOUBLE), 0))
      comment: "Average compa-ratio (salary vs range midpoint) — pay equity and market positioning indicator"
    - name: "total_hazmat_premium"
      expr: SUM(CAST(hazmat_premium_amount AS DOUBLE))
      comment: "Total hazmat premium costs — specialized role premium exposure"
    - name: "total_shift_differential"
      expr: SUM(CAST(shift_differential_amount AS DOUBLE))
      comment: "Total shift differential costs — off-hours staffing premium"
    - name: "compensation_plan_count"
      expr: COUNT(1)
      comment: "Count of active compensation plans — workforce size proxy"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and development metrics tracking workforce capability building, compliance training completion, and training investment for transport shipping operations."
  source: "`transport_shipping_ecm`.`workforce`.`training_record`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of training (safety, compliance, technical, leadership)"
    - name: "training_type"
      expr: training_type
      comment: "Type of training delivery for effectiveness analysis"
    - name: "training_status"
      expr: training_status
      comment: "Status of training (completed, in-progress, expired, overdue)"
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether training is compliance-required — regulatory obligation tracking"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether training is mandatory for the role"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of training assessment"
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Achieved proficiency level post-training"
    - name: "job_family"
      expr: job_family
      comment: "Job family for role-based training analysis"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether training requires periodic renewal — ongoing compliance burden"
    - name: "completion_date"
      expr: completion_date
      comment: "Training completion date for temporal analysis"
  measures:
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested — workforce development capacity metric"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training investment — L&D budget utilization"
    - name: "avg_proficiency_score"
      expr: AVG(CAST(proficiency_score AS DOUBLE))
      comment: "Average proficiency score achieved — training effectiveness metric"
    - name: "avg_assessment_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score — knowledge retention indicator"
    - name: "training_completion_count"
      expr: SUM(CASE WHEN training_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of completed trainings — completion rate numerator"
    - name: "training_record_count"
      expr: COUNT(1)
      comment: "Total training records — training activity volume"
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Unique employees with training records — training reach metric"
    - name: "compliance_training_count"
      expr: SUM(CASE WHEN compliance_requirement_flag = true THEN 1 ELSE 0 END)
      comment: "Count of compliance-required training records — regulatory training volume"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`workforce_fte_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning metrics tracking planned vs actual headcount, budget utilization, and staffing gaps for strategic capacity management."
  source: "`transport_shipping_ecm`.`workforce`.`fte_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the FTE plan (draft, approved, active, closed)"
    - name: "job_family"
      expr: job_family
      comment: "Job family for role-category workforce planning"
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic workforce planning"
    - name: "is_critical_role"
      expr: is_critical_role
      comment: "Whether the planned role is critical — priority hiring indicator"
    - name: "is_safety_sensitive"
      expr: is_safety_sensitive
      comment: "Whether the role is safety-sensitive — regulatory staffing requirement"
    - name: "requires_dot_certification"
      expr: requires_dot_certification
      comment: "Whether DOT certification is required — specialized talent need"
    - name: "planning_period"
      expr: planning_period
      comment: "Planning period for temporal workforce strategy analysis"
    - name: "hiring_plan_status"
      expr: hiring_plan_status
      comment: "Status of the hiring plan associated with this FTE plan"
    - name: "region_code"
      expr: region_code
      comment: "Region for regional workforce capacity planning"
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned FTE — target workforce capacity"
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE — current workforce capacity"
    - name: "total_variance_fte"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (actual minus planned) — staffing gap indicator"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total workforce budget — labor cost planning envelope"
    - name: "avg_salary_per_fte"
      expr: AVG(CAST(average_salary AS DOUBLE))
      comment: "Average salary per planned FTE — unit cost planning metric"
    - name: "critical_role_count"
      expr: SUM(CASE WHEN is_critical_role = true THEN 1 ELSE 0 END)
      comment: "Count of critical role plans — priority staffing needs"
    - name: "fte_plan_count"
      expr: COUNT(1)
      comment: "Total FTE plan records — planning activity volume"
$$;
