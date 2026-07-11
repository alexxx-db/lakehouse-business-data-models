-- Metric views for domain: workforce | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution metrics tracking gross pay, net pay, tax withholding, and labor cost efficiency across properties and cost centers"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (approved, posted, paid)"
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (regular, off-cycle, adjustment)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, semi-monthly, monthly)"
    - name: "pay_date"
      expr: pay_date
      comment: "Date employees are paid"
    - name: "pay_year"
      expr: YEAR(pay_date)
      comment: "Year of pay date for trend analysis"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of pay date for period analysis"
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "General ledger posting status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll amounts"
  measures:
    - name: "total_gross_pay_amount"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay across all employees before deductions and taxes"
    - name: "total_net_pay_amount"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees after all deductions and taxes"
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(total_tax_withholding AS DOUBLE))
      comment: "Total tax withholding across federal, state, local, Medicare, and Social Security"
    - name: "total_employer_tax_burden"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer-side payroll tax burden"
    - name: "total_overtime_pay_amount"
      expr: SUM(CAST(total_overtime_pay AS DOUBLE))
      comment: "Total overtime pay indicating labor scheduling efficiency"
    - name: "total_bonus_pay_amount"
      expr: SUM(CAST(total_bonus_pay AS DOUBLE))
      comment: "Total bonus compensation paid"
    - name: "total_commission_pay_amount"
      expr: SUM(CAST(total_commission_pay AS DOUBLE))
      comment: "Total commission compensation paid"
    - name: "total_service_charge_amount"
      expr: SUM(CAST(total_service_charge AS DOUBLE))
      comment: "Total service charges distributed to employees"
    - name: "total_tip_allocation_amount"
      expr: SUM(CAST(total_tip_allocation AS DOUBLE))
      comment: "Total tip allocation distributed to employees"
    - name: "payroll_run_count"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Number of distinct payroll runs executed"
    - name: "employee_count_paid"
      expr: SUM(CAST(employee_count AS DOUBLE))
      comment: "Total number of employees paid across all payroll runs"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run"
    - name: "avg_net_pay_per_employee"
      expr: AVG(CAST(total_net_pay AS DOUBLE))
      comment: "Average net pay per payroll run"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time tracking metrics for regular hours, overtime, labor cost, and productivity analysis"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the time entry"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year of time entry for trend analysis"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of time entry for period analysis"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, PTO, etc.)"
    - name: "entry_source"
      expr: entry_source
      comment: "Source of time entry (clock, manual, import)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code for time entry anomalies"
    - name: "shift_differential_code"
      expr: shift_differential_code
      comment: "Shift differential code applied"
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether time entry has been processed in payroll"
    - name: "edited_flag"
      expr: edited_flag
      comment: "Whether time entry was edited after initial submission"
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked indicating scheduling efficiency"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entry types"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost for time entries"
    - name: "total_tips_reported"
      expr: SUM(CAST(tips_reported_amount AS DOUBLE))
      comment: "Total tips reported by employees"
    - name: "time_entry_count"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Number of distinct time entries"
    - name: "edited_entry_count"
      expr: COUNT(DISTINCT CASE WHEN edited_flag = TRUE THEN time_entry_id END)
      comment: "Number of time entries that were edited after submission"
    - name: "exception_entry_count"
      expr: COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL THEN time_entry_id END)
      comment: "Number of time entries with exceptions requiring review"
    - name: "avg_regular_hours_per_entry"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours per time entry"
    - name: "avg_labor_cost_per_hour"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per time entry"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics tracking leave utilization, FMLA compliance, and workforce availability"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (vacation, sick, FMLA, personal, etc.)"
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Subtype of leave for detailed categorization"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of leave request"
    - name: "request_status"
      expr: request_status
      comment: "Overall status of leave request"
    - name: "is_fmla_qualifying"
      expr: is_fmla_qualifying
      comment: "Whether leave qualifies under FMLA"
    - name: "is_paid"
      expr: is_paid
      comment: "Whether leave is paid or unpaid"
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Whether leave is intermittent FMLA"
    - name: "is_ada_accommodation"
      expr: is_ada_accommodation
      comment: "Whether leave is an ADA accommodation"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of leave request for trend analysis"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of leave request for period analysis"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year leave starts"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month leave starts"
  measures:
    - name: "total_hours_requested"
      expr: SUM(CAST(hours_requested AS DOUBLE))
      comment: "Total leave hours requested"
    - name: "total_hours_taken"
      expr: SUM(CAST(hours_taken AS DOUBLE))
      comment: "Total leave hours actually taken"
    - name: "total_hours_accrued"
      expr: SUM(CAST(hours_accrued AS DOUBLE))
      comment: "Total leave hours accrued"
    - name: "total_carryover_hours"
      expr: SUM(CAST(carryover_hours AS DOUBLE))
      comment: "Total leave hours carried over from prior period"
    - name: "total_remaining_balance_hours"
      expr: SUM(CAST(remaining_balance_hours AS DOUBLE))
      comment: "Total remaining leave balance hours"
    - name: "total_days_requested"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total leave days requested"
    - name: "total_payroll_impact"
      expr: SUM(CAST(payroll_impact_amount AS DOUBLE))
      comment: "Total payroll impact of leave requests"
    - name: "leave_request_count"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Number of distinct leave requests"
    - name: "fmla_request_count"
      expr: COUNT(DISTINCT CASE WHEN is_fmla_qualifying = TRUE THEN leave_request_id END)
      comment: "Number of FMLA-qualifying leave requests for compliance tracking"
    - name: "ada_accommodation_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_accommodation = TRUE THEN leave_request_id END)
      comment: "Number of ADA accommodation leave requests for compliance tracking"
    - name: "intermittent_leave_count"
      expr: COUNT(DISTINCT CASE WHEN is_intermittent = TRUE THEN leave_request_id END)
      comment: "Number of intermittent leave requests"
    - name: "avg_hours_per_request"
      expr: AVG(CAST(hours_requested AS DOUBLE))
      comment: "Average hours requested per leave request"
    - name: "avg_days_per_request"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average days per leave request"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics tracking employee ratings, goal achievement, and talent development outcomes"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of performance review (draft, completed, acknowledged)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probationary, project)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category"
    - name: "guest_service_rating"
      expr: guest_service_rating
      comment: "Guest service performance rating"
    - name: "leadership_rating"
      expr: leadership_rating
      comment: "Leadership performance rating"
    - name: "reliability_rating"
      expr: reliability_rating
      comment: "Reliability performance rating"
    - name: "teamwork_rating"
      expr: teamwork_rating
      comment: "Teamwork performance rating"
    - name: "technical_skills_rating"
      expr: technical_skills_rating
      comment: "Technical skills performance rating"
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Whether employee is eligible for merit increase"
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether promotion is recommended"
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether employee is on performance improvement plan"
    - name: "succession_planning_flag"
      expr: succession_planning_flag
      comment: "Whether employee is identified for succession planning"
    - name: "review_year"
      expr: YEAR(review_completion_date)
      comment: "Year review was completed"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Month review was completed"
  measures:
    - name: "performance_review_count"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Number of performance reviews completed"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "total_goals_met"
      expr: SUM(CAST(goals_met_count AS DOUBLE))
      comment: "Total number of goals met across all reviews"
    - name: "total_goals_assigned"
      expr: SUM(CAST(goals_total_count AS DOUBLE))
      comment: "Total number of goals assigned across all reviews"
    - name: "merit_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN merit_increase_eligible_flag = TRUE THEN performance_review_id END)
      comment: "Number of employees eligible for merit increase"
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Number of employees recommended for promotion"
    - name: "pip_count"
      expr: COUNT(DISTINCT CASE WHEN performance_improvement_plan_flag = TRUE THEN performance_review_id END)
      comment: "Number of employees on performance improvement plans"
    - name: "succession_candidate_count"
      expr: COUNT(DISTINCT CASE WHEN succession_planning_flag = TRUE THEN performance_review_id END)
      comment: "Number of employees identified for succession planning"
    - name: "completed_review_count"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'completed' THEN performance_review_id END)
      comment: "Number of completed performance reviews"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce safety metrics tracking OSHA recordable incidents, injury severity, lost time, and safety compliance"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity classification of injury"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by incident"
    - name: "incident_location"
      expr: incident_location
      comment: "Location where incident occurred"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether incident is OSHA recordable"
    - name: "privacy_case_flag"
      expr: privacy_case_flag
      comment: "Whether incident is a privacy case under OSHA"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether incident was preventable"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of incident investigation"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
  measures:
    - name: "safety_incident_count"
      expr: COUNT(DISTINCT workforce_safety_incident_id)
      comment: "Total number of workforce safety incidents"
    - name: "osha_recordable_count"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN workforce_safety_incident_id END)
      comment: "Number of OSHA recordable incidents for regulatory compliance"
    - name: "preventable_incident_count"
      expr: COUNT(DISTINCT CASE WHEN preventable_flag = TRUE THEN workforce_safety_incident_id END)
      comment: "Number of preventable incidents indicating safety program effectiveness"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days employees were away from work due to incidents"
    - name: "total_days_restricted_duty"
      expr: SUM(CAST(days_on_restricted_duty AS DOUBLE))
      comment: "Total days employees were on restricted duty due to incidents"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of safety incidents"
    - name: "avg_days_away_per_incident"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per incident"
    - name: "avg_estimated_cost_per_incident"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per safety incident"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor scheduling metrics tracking scheduled hours, labor cost, overtime approval, and labor efficiency ratios"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of schedule (draft, published, finalized)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (weekly, bi-weekly, monthly)"
    - name: "is_active"
      expr: is_active
      comment: "Whether schedule is currently active"
    - name: "is_overtime_approved"
      expr: is_overtime_approved
      comment: "Whether overtime is approved for this schedule"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of schedule period"
    - name: "period_year"
      expr: YEAR(period_start_date)
      comment: "Year of schedule period"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of schedule period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of labor cost amounts"
  measures:
    - name: "schedule_count"
      expr: COUNT(DISTINCT schedule_id)
      comment: "Number of distinct schedules"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedules"
    - name: "total_actual_hours"
      expr: SUM(CAST(total_actual_hours AS DOUBLE))
      comment: "Total actual hours worked"
    - name: "total_scheduled_fte"
      expr: SUM(CAST(total_scheduled_fte AS DOUBLE))
      comment: "Total scheduled full-time equivalents"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for schedules"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred"
    - name: "total_labor_variance_hours"
      expr: SUM(CAST(labor_variance_hours AS DOUBLE))
      comment: "Total variance between scheduled and actual hours"
    - name: "avg_labor_cost_percentage"
      expr: AVG(CAST(labor_cost_percentage AS DOUBLE))
      comment: "Average labor cost as percentage of revenue"
    - name: "avg_cpor_labor"
      expr: AVG(CAST(cpor_labor AS DOUBLE))
      comment: "Average cost per occupied room for labor"
    - name: "avg_forecast_occupancy_rate"
      expr: AVG(CAST(forecast_occupancy_rate AS DOUBLE))
      comment: "Average forecasted occupancy rate used for scheduling"
    - name: "avg_forecast_adr"
      expr: AVG(CAST(forecast_adr AS DOUBLE))
      comment: "Average forecasted ADR used for scheduling"
    - name: "avg_forecast_revpar"
      expr: AVG(CAST(forecast_revpar AS DOUBLE))
      comment: "Average forecasted RevPAR used for scheduling"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_learning_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics tracking course enrollment capacity, completion requirements, and training investment"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`learning_course`"
  dimensions:
    - name: "course_status"
      expr: course_status
      comment: "Status of learning course (active, inactive, archived)"
    - name: "course_type"
      expr: course_type
      comment: "Type of course (onboarding, compliance, technical, leadership)"
    - name: "course_category"
      expr: course_category
      comment: "Category of course content"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of course delivery (online, classroom, blended)"
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether course is a compliance requirement"
    - name: "assessment_required_flag"
      expr: assessment_required_flag
      comment: "Whether course requires assessment"
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether course issues certification upon completion"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the course"
    - name: "language_code"
      expr: language_code
      comment: "Language of course content"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body for the course"
  measures:
    - name: "learning_course_count"
      expr: COUNT(DISTINCT learning_course_id)
      comment: "Number of distinct learning courses"
    - name: "compliance_course_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_requirement_flag = TRUE THEN learning_course_id END)
      comment: "Number of compliance-required courses"
    - name: "certification_course_count"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN learning_course_id END)
      comment: "Number of courses that issue certifications"
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_capacity AS DOUBLE))
      comment: "Total enrollment capacity across all courses"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total duration hours of all courses"
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits offered"
    - name: "total_cost_per_learner"
      expr: SUM(CAST(cost_per_learner AS DOUBLE))
      comment: "Total cost per learner across all courses"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration hours per course"
    - name: "avg_cost_per_learner"
      expr: AVG(CAST(cost_per_learner AS DOUBLE))
      comment: "Average cost per learner per course"
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across courses"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary action metrics tracking violation categories, action types, grievance outcomes, and workforce conduct trends"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Status of disciplinary action (active, completed, expunged)"
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination)"
    - name: "violation_category"
      expr: violation_category
      comment: "Category of violation"
    - name: "grievance_filed"
      expr: grievance_filed
      comment: "Whether a grievance was filed"
    - name: "grievance_status"
      expr: grievance_status
      comment: "Status of grievance if filed"
    - name: "is_paid_suspension"
      expr: is_paid_suspension
      comment: "Whether suspension was paid"
    - name: "is_expunged"
      expr: is_expunged
      comment: "Whether action has been expunged from record"
    - name: "is_eligible_for_rehire"
      expr: is_eligible_for_rehire
      comment: "Whether employee is eligible for rehire after termination"
    - name: "osha_recordable_incident"
      expr: osha_recordable_incident
      comment: "Whether related to OSHA recordable incident"
    - name: "legal_hold"
      expr: legal_hold
      comment: "Whether action is under legal hold"
    - name: "union_representative_notified"
      expr: union_representative_notified
      comment: "Whether union representative was notified"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
  measures:
    - name: "disciplinary_action_count"
      expr: COUNT(DISTINCT disciplinary_action_id)
      comment: "Total number of disciplinary actions"
    - name: "termination_count"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN disciplinary_action_id END)
      comment: "Number of terminations"
    - name: "suspension_count"
      expr: COUNT(DISTINCT CASE WHEN suspension_start_date IS NOT NULL THEN disciplinary_action_id END)
      comment: "Number of suspensions"
    - name: "grievance_filed_count"
      expr: COUNT(DISTINCT CASE WHEN grievance_filed = TRUE THEN disciplinary_action_id END)
      comment: "Number of actions with grievances filed"
    - name: "expunged_action_count"
      expr: COUNT(DISTINCT CASE WHEN is_expunged = TRUE THEN disciplinary_action_id END)
      comment: "Number of expunged disciplinary actions"
    - name: "legal_hold_count"
      expr: COUNT(DISTINCT CASE WHEN legal_hold = TRUE THEN disciplinary_action_id END)
      comment: "Number of actions under legal hold"
    - name: "total_suspension_days"
      expr: SUM(CAST(suspension_days AS DOUBLE))
      comment: "Total suspension days across all actions"
    - name: "avg_suspension_days"
      expr: AVG(CAST(suspension_days AS DOUBLE))
      comment: "Average suspension days per action"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure metrics tracking pay ranges, bonus eligibility, commission rates, and market pricing competitiveness"
  source: "`vibe_travel_hospitality_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "compensation_plan_status"
      expr: compensation_plan_status
      comment: "Status of compensation plan (active, inactive, pending)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan (hourly, salary, commission)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of compensation plan"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification (exempt, non-exempt)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, semi-monthly, monthly)"
    - name: "rate_unit"
      expr: rate_unit
      comment: "Unit of rate (hourly, daily, annual)"
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether position is bonus eligible"
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether position is commission eligible"
    - name: "merit_increase_eligible"
      expr: merit_increase_eligible
      comment: "Whether position is merit increase eligible"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether position is overtime eligible"
    - name: "tip_credit_eligible"
      expr: tip_credit_eligible
      comment: "Whether position is tip credit eligible"
    - name: "service_charge_eligible"
      expr: service_charge_eligible
      comment: "Whether position is service charge eligible"
    - name: "is_unionized"
      expr: is_unionized
      comment: "Whether position is unionized"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation amounts"
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment for compensation plan"
    - name: "usali_department"
      expr: usali_department
      comment: "USALI department code"
  measures:
    - name: "compensation_plan_count"
      expr: COUNT(DISTINCT compensation_plan_id)
      comment: "Number of distinct compensation plans"
    - name: "avg_minimum_rate"
      expr: AVG(CAST(minimum_rate AS DOUBLE))
      comment: "Average minimum rate across compensation plans"
    - name: "avg_midpoint_rate"
      expr: AVG(CAST(midpoint_rate AS DOUBLE))
      comment: "Average midpoint rate across compensation plans"
    - name: "avg_maximum_rate"
      expr: AVG(CAST(maximum_rate AS DOUBLE))
      comment: "Average maximum rate across compensation plans"
    - name: "avg_compa_ratio_target"
      expr: AVG(CAST(compa_ratio_target AS DOUBLE))
      comment: "Average compa-ratio target indicating market competitiveness"
    - name: "avg_target_bonus_percentage"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus percentage"
    - name: "avg_commission_rate_percentage"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier"
    - name: "bonus_eligible_plan_count"
      expr: COUNT(DISTINCT CASE WHEN bonus_eligible = TRUE THEN compensation_plan_id END)
      comment: "Number of bonus-eligible compensation plans"
    - name: "commission_eligible_plan_count"
      expr: COUNT(DISTINCT CASE WHEN commission_eligible = TRUE THEN compensation_plan_id END)
      comment: "Number of commission-eligible compensation plans"
    - name: "unionized_plan_count"
      expr: COUNT(DISTINCT CASE WHEN is_unionized = TRUE THEN compensation_plan_id END)
      comment: "Number of unionized compensation plans"
$$;