-- Metric views for domain: workforce | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, and demographic distributions for strategic workforce planning and DEI reporting"
  source: "`sports_entertainment_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, seasonal, etc.)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit assignment for organizational segmentation"
    - name: "department_code"
      expr: department_code
      comment: "Department code for functional area analysis"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-based workforce analysis"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt/non-exempt) for compliance reporting"
    - name: "work_country_code"
      expr: work_country_code
      comment: "Country of work location for geographic workforce distribution"
    - name: "is_union_member"
      expr: is_union_member
      comment: "Union membership flag for labor relations analysis"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity for DEI reporting and analysis"
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Ethnicity code for DEI compliance and diversity metrics"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort analysis and retention tracking"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition trend analysis"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count for workforce size tracking"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees for current workforce capacity"
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees for attrition analysis"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary spend across workforce for compensation budget tracking"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per employee for compensation benchmarking"
    - name: "union_member_count"
      expr: COUNT(DISTINCT CASE WHEN is_union_member = TRUE THEN employee_id END)
      comment: "Count of union members for labor relations planning"
    - name: "ada_accommodation_count"
      expr: COUNT(DISTINCT CASE WHEN ada_accommodation_flag = TRUE THEN employee_id END)
      comment: "Count of employees with ADA accommodations for compliance tracking"
    - name: "osha_trained_count"
      expr: COUNT(DISTINCT CASE WHEN osha_safety_trained = TRUE THEN employee_id END)
      comment: "Count of OSHA-trained employees for safety compliance monitoring"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_employment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employment lifecycle event metrics tracking hires, terminations, promotions, and transfers for workforce mobility and retention analysis"
  source: "`sports_entertainment_ecm`.`workforce`.`employment_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of employment event (hire, termination, promotion, transfer, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Status of the employment event (pending, approved, completed, cancelled)"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of organizational movement (lateral, promotion, demotion, etc.)"
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary, retirement, etc.)"
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Categorized exit reason for attrition root cause analysis"
    - name: "rehire_eligible"
      expr: rehire_eligible
      comment: "Rehire eligibility flag for talent pipeline management"
    - name: "cba_governed"
      expr: cba_governed
      comment: "CBA governance flag for labor relations compliance"
    - name: "event_year"
      expr: YEAR(effective_date)
      comment: "Year of event for trend analysis"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of event for seasonal pattern analysis"
    - name: "from_job_grade"
      expr: from_job_grade
      comment: "Starting job grade for career progression analysis"
    - name: "to_job_grade"
      expr: to_job_grade
      comment: "Ending job grade for promotion tracking"
  measures:
    - name: "total_events"
      expr: COUNT(DISTINCT employment_event_id)
      comment: "Total employment events for workforce activity volume"
    - name: "hire_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Hire' THEN employment_event_id END)
      comment: "Count of new hires for talent acquisition effectiveness"
    - name: "termination_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Termination' THEN employment_event_id END)
      comment: "Count of terminations for attrition rate calculation"
    - name: "promotion_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Promotion' THEN employment_event_id END)
      comment: "Count of promotions for internal mobility and career development tracking"
    - name: "transfer_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Transfer' THEN employment_event_id END)
      comment: "Count of transfers for organizational flexibility measurement"
    - name: "voluntary_separation_count"
      expr: COUNT(DISTINCT CASE WHEN separation_type = 'Voluntary' THEN employment_event_id END)
      comment: "Count of voluntary separations for retention risk assessment"
    - name: "involuntary_separation_count"
      expr: COUNT(DISTINCT CASE WHEN separation_type = 'Involuntary' THEN employment_event_id END)
      comment: "Count of involuntary separations for performance management tracking"
    - name: "exit_interview_completion_count"
      expr: COUNT(DISTINCT CASE WHEN exit_interview_completed = TRUE THEN employment_event_id END)
      comment: "Count of completed exit interviews for feedback capture rate"
    - name: "severance_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN severance_eligible = TRUE THEN employment_event_id END)
      comment: "Count of severance-eligible separations for cost forecasting"
    - name: "rehire_eligible_separation_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible = TRUE THEN employment_event_id END)
      comment: "Count of rehire-eligible separations for boomerang talent pipeline"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll and compensation metrics for labor cost analysis, overtime tracking, and compensation compliance monitoring"
  source: "`sports_entertainment_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, bi-weekly, monthly) for payroll cycle analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for labor cost segmentation"
    - name: "pay_group_code"
      expr: pay_group_code
      comment: "Pay group code for payroll processing segmentation"
    - name: "run_type"
      expr: run_type
      comment: "Payroll run type (regular, off-cycle, bonus, etc.)"
    - name: "run_status"
      expr: run_status
      comment: "Payroll run status for processing quality tracking"
    - name: "is_union_member"
      expr: is_union_member
      comment: "Union membership flag for labor cost analysis by bargaining unit"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check, etc.) for disbursement analysis"
    - name: "pay_year"
      expr: YEAR(pay_date)
      comment: "Year of pay date for annual compensation analysis"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of pay date for monthly labor cost tracking"
    - name: "pay_period_start"
      expr: pay_period_start_date
      comment: "Pay period start date for period-based analysis"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay for labor cost tracking before deductions"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay for actual cash disbursement to employees"
    - name: "total_base_pay"
      expr: SUM(CAST(base_pay_amount AS DOUBLE))
      comment: "Total base pay excluding premiums and overtime for regular compensation cost"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay for premium labor cost tracking"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked for capacity and scheduling analysis"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked for baseline capacity measurement"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions for benefit cost and tax withholding tracking"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld for tax compliance reporting"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld for multi-state tax compliance"
    - name: "total_fica_social_security"
      expr: SUM(CAST(fica_social_security_amount AS DOUBLE))
      comment: "Total FICA social security withholding for payroll tax tracking"
    - name: "total_employer_fica"
      expr: SUM(CAST(employer_fica_amount AS DOUBLE))
      comment: "Total employer FICA contribution for true labor cost calculation"
    - name: "total_union_dues"
      expr: SUM(CAST(union_dues_amount AS DOUBLE))
      comment: "Total union dues deducted for labor relations financial tracking"
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement contributions for benefit cost analysis"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record for compensation benchmarking"
    - name: "payroll_record_count"
      expr: COUNT(DISTINCT payroll_record_id)
      comment: "Count of payroll records for processing volume tracking"
    - name: "direct_deposit_count"
      expr: COUNT(DISTINCT CASE WHEN direct_deposit_flag = TRUE THEN payroll_record_id END)
      comment: "Count of direct deposit payments for payment method adoption rate"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment requisition metrics for talent acquisition effectiveness, time-to-fill, and hiring pipeline health"
  source: "`sports_entertainment_ecm`.`workforce`.`requisition`"
  dimensions:
    - name: "status"
      expr: requisition_status
      comment: "Requisition status (open, filled, cancelled, on-hold) for pipeline stage analysis"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new position, replacement, backfill) for hiring demand classification"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce mix planning"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation and urgency tracking"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-based hiring demand analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for budget and hiring allocation tracking"
    - name: "union_covered_flag"
      expr: union_covered_flag
      comment: "Union coverage flag for labor relations hiring compliance"
    - name: "remote_work_eligible_flag"
      expr: remote_work_eligible_flag
      comment: "Remote work eligibility for flexible work policy tracking"
    - name: "posted_year"
      expr: YEAR(posted_date)
      comment: "Year requisition was posted for annual hiring trend analysis"
    - name: "posted_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month requisition was posted for seasonal hiring pattern analysis"
    - name: "target_start_month"
      expr: DATE_TRUNC('MONTH', target_start_date)
      comment: "Target start month for workforce capacity planning"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT requisition_id)
      comment: "Total requisition count for hiring demand volume"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN requisition_id END)
      comment: "Count of open requisitions for active hiring pipeline size"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN requisition_id END)
      comment: "Count of filled requisitions for hiring success rate calculation"
    - name: "cancelled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Cancelled' THEN requisition_id END)
      comment: "Count of cancelled requisitions for demand volatility tracking"
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS DOUBLE))
      comment: "Total number of open positions across all requisitions for capacity gap measurement"
    - name: "total_positions_filled"
      expr: SUM(CAST(positions_filled AS DOUBLE))
      comment: "Total positions filled for hiring throughput tracking"
    - name: "avg_salary_range_min"
      expr: AVG(CAST(salary_range_minimum AS DOUBLE))
      comment: "Average minimum salary range for compensation market positioning"
    - name: "avg_salary_range_max"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE))
      comment: "Average maximum salary range for compensation budget planning"
    - name: "high_priority_requisitions"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'High' THEN requisition_id END)
      comment: "Count of high-priority requisitions for critical hiring focus"
    - name: "remote_eligible_requisitions"
      expr: COUNT(DISTINCT CASE WHEN remote_work_eligible_flag = TRUE THEN requisition_id END)
      comment: "Count of remote-eligible requisitions for flexible work strategy tracking"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics for talent assessment, calibration quality, and development planning effectiveness"
  source: "`sports_entertainment_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review status (draft, submitted, completed, calibrated) for process completion tracking"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probation, project) for review cycle analysis"
    - name: "overall_rating_label"
      expr: overall_rating_label
      comment: "Overall rating label (exceeds, meets, needs improvement) for performance distribution"
    - name: "nine_box_placement"
      expr: nine_box_placement
      comment: "Nine-box grid placement for talent segmentation and succession planning"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for rating consistency and fairness tracking"
    - name: "retention_risk_rating"
      expr: retention_risk_rating
      comment: "Retention risk rating for flight risk identification"
    - name: "readiness_tier"
      expr: readiness_tier
      comment: "Readiness tier for succession planning pipeline health"
    - name: "pip_flag"
      expr: pip_flag
      comment: "Performance improvement plan flag for underperformance management tracking"
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Promotion recommendation flag for internal mobility pipeline"
    - name: "succession_nominated"
      expr: succession_nominated
      comment: "Succession nomination flag for leadership pipeline development"
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Review cycle year for annual performance trend analysis"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit for organizational performance comparison"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total performance reviews for review cycle volume tracking"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed reviews for process completion rate"
    - name: "calibrated_reviews"
      expr: COUNT(DISTINCT CASE WHEN calibration_status = 'Calibrated' THEN performance_review_id END)
      comment: "Count of calibrated reviews for rating consistency quality"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating for organizational performance level"
    - name: "avg_calibrated_rating"
      expr: AVG(CAST(calibrated_rating AS DOUBLE))
      comment: "Average calibrated rating for post-calibration performance distribution"
    - name: "avg_goal_achievement_rating"
      expr: AVG(CAST(goal_achievement_rating AS DOUBLE))
      comment: "Average goal achievement rating for objective attainment measurement"
    - name: "avg_competency_rating"
      expr: AVG(CAST(competency_rating AS DOUBLE))
      comment: "Average competency rating for skill and behavior assessment"
    - name: "pip_count"
      expr: COUNT(DISTINCT CASE WHEN pip_flag = TRUE THEN performance_review_id END)
      comment: "Count of performance improvement plans for underperformance intervention tracking"
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommended = TRUE THEN performance_review_id END)
      comment: "Count of promotion recommendations for internal mobility pipeline size"
    - name: "succession_nominated_count"
      expr: COUNT(DISTINCT CASE WHEN succession_nominated = TRUE THEN performance_review_id END)
      comment: "Count of succession nominations for leadership bench strength"
    - name: "merit_increase_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN merit_increase_recommended = TRUE THEN performance_review_id END)
      comment: "Count of merit increase recommendations for compensation budget forecasting"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage for compensation planning"
    - name: "high_retention_risk_count"
      expr: COUNT(DISTINCT CASE WHEN retention_risk_rating = 'High' THEN performance_review_id END)
      comment: "Count of high retention risk employees for proactive retention intervention"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics for training completion, compliance certification, and skill development effectiveness"
  source: "`sports_entertainment_ecm`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status (enrolled, in-progress, completed, withdrawn) for training pipeline tracking"
    - name: "learning_type"
      expr: learning_type
      comment: "Type of learning (course, certification, on-the-job, etc.) for development method analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (online, classroom, blended) for training modality effectiveness"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Mandatory training flag for compliance training tracking"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail status for training effectiveness measurement"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential earned for certification portfolio analysis"
    - name: "credential_verification_status"
      expr: credential_verification_status
      comment: "Credential verification status for compliance audit readiness"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of enrollment (manager-assigned, self-enrolled, system-required) for demand driver analysis"
    - name: "department_code"
      expr: department_code
      comment: "Department code for training investment by function"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for annual training volume trends"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for seasonal training pattern analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of completion for training throughput tracking"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT learning_enrollment_id)
      comment: "Total learning enrollments for training activity volume"
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN learning_enrollment_id END)
      comment: "Count of completed enrollments for training completion rate calculation"
    - name: "in_progress_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'In Progress' THEN learning_enrollment_id END)
      comment: "Count of in-progress enrollments for active training pipeline size"
    - name: "passed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'Pass' THEN learning_enrollment_id END)
      comment: "Count of passed enrollments for training effectiveness measurement"
    - name: "failed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'Fail' THEN learning_enrollment_id END)
      comment: "Count of failed enrollments for training quality improvement"
    - name: "mandatory_enrollments"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE THEN learning_enrollment_id END)
      comment: "Count of mandatory enrollments for compliance training coverage"
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered for learning investment measurement"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per enrollment for program intensity analysis"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total training cost for learning and development budget tracking"
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per enrollment for cost efficiency benchmarking"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training score for learning outcome quality"
    - name: "credentials_issued"
      expr: COUNT(DISTINCT CASE WHEN credential_issue_date IS NOT NULL THEN learning_enrollment_id END)
      comment: "Count of credentials issued for certification attainment tracking"
    - name: "credentials_verified"
      expr: COUNT(DISTINCT CASE WHEN credential_verification_status = 'Verified' THEN learning_enrollment_id END)
      comment: "Count of verified credentials for compliance audit readiness"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident metrics for OSHA compliance, injury tracking, and safety program effectiveness measurement"
  source: "`sports_entertainment_ecm`.`workforce`.`osha_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Incident status (reported, under investigation, closed) for case management tracking"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (injury, illness, near-miss, property damage) for hazard classification"
    - name: "osha_recordability"
      expr: osha_recordability
      comment: "OSHA recordability determination for regulatory reporting compliance"
    - name: "osha_log_type"
      expr: osha_log_type
      comment: "OSHA log type (300, 300A, 301) for regulatory form classification"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of injury (laceration, fracture, strain, etc.) for injury pattern analysis"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected for ergonomic and hazard targeting"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for preventive action prioritization"
    - name: "location_type"
      expr: location_type
      comment: "Location type (venue, office, field, etc.) for site-specific safety analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce segment safety comparison"
    - name: "fatality_flag"
      expr: fatality_flag
      comment: "Fatality flag for critical incident tracking"
    - name: "hospitalization_flag"
      expr: hospitalization_flag
      comment: "Hospitalization flag for severe injury tracking"
    - name: "work_related"
      expr: work_related
      comment: "Work-related flag for OSHA recordability determination"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident for annual safety trend analysis"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for seasonal safety pattern identification"
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT osha_incident_id)
      comment: "Total OSHA incidents for overall safety performance tracking"
    - name: "recordable_incidents"
      expr: COUNT(DISTINCT CASE WHEN osha_recordability = 'Recordable' THEN osha_incident_id END)
      comment: "Count of OSHA recordable incidents for regulatory reporting and TRIR calculation"
    - name: "fatality_count"
      expr: COUNT(DISTINCT CASE WHEN fatality_flag = TRUE THEN osha_incident_id END)
      comment: "Count of fatalities for critical safety failure tracking"
    - name: "hospitalization_count"
      expr: COUNT(DISTINCT CASE WHEN hospitalization_flag = TRUE THEN osha_incident_id END)
      comment: "Count of hospitalizations for severe injury rate calculation"
    - name: "amputation_count"
      expr: COUNT(DISTINCT CASE WHEN amputation_flag = TRUE THEN osha_incident_id END)
      comment: "Count of amputations for catastrophic injury tracking"
    - name: "lost_consciousness_count"
      expr: COUNT(DISTINCT CASE WHEN lost_consciousness = TRUE THEN osha_incident_id END)
      comment: "Count of incidents with loss of consciousness for severity assessment"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days away from work for DART rate calculation and productivity impact"
    - name: "total_days_restricted_duty"
      expr: SUM(CAST(days_restricted_duty AS DOUBLE))
      comment: "Total days on restricted duty for modified work impact measurement"
    - name: "avg_days_away_from_work"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per incident for injury severity benchmarking"
    - name: "medical_treatment_beyond_first_aid_count"
      expr: COUNT(DISTINCT CASE WHEN medical_treatment_beyond_first_aid = TRUE THEN osha_incident_id END)
      comment: "Count of incidents requiring medical treatment beyond first aid for recordability assessment"
    - name: "investigation_completed_count"
      expr: COUNT(DISTINCT CASE WHEN investigation_completed_date IS NOT NULL THEN osha_incident_id END)
      comment: "Count of completed investigations for incident response quality"
    - name: "corrective_action_completed_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_completed_date IS NOT NULL THEN osha_incident_id END)
      comment: "Count of completed corrective actions for hazard remediation effectiveness"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_shift_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor utilization metrics for event staffing, overtime management, and labor cost control"
  source: "`sports_entertainment_ecm`.`workforce`.`shift_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (scheduled, confirmed, completed, cancelled) for shift fulfillment tracking"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (regular, event, on-call, emergency) for labor demand classification"
    - name: "role_during_shift"
      expr: role_during_shift
      comment: "Role performed during shift for skill deployment analysis"
    - name: "worker_category"
      expr: worker_category
      comment: "Worker category (employee, contingent, contractor) for workforce mix tracking"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Overtime flag for premium labor cost identification"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "No-show flag for attendance reliability measurement"
    - name: "manager_approval_status"
      expr: manager_approval_status
      comment: "Manager approval status for timesheet approval workflow tracking"
    - name: "payroll_processing_status"
      expr: payroll_processing_status
      comment: "Payroll processing status for payment cycle tracking"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status for overtime eligibility compliance"
    - name: "shift_year"
      expr: YEAR(shift_date)
      comment: "Year of shift for annual labor utilization trends"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for seasonal staffing pattern analysis"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of shift for daily staffing analysis"
  measures:
    - name: "total_shifts"
      expr: COUNT(DISTINCT shift_assignment_id)
      comment: "Total shift assignments for staffing volume tracking"
    - name: "completed_shifts"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Completed' THEN shift_assignment_id END)
      comment: "Count of completed shifts for shift fulfillment rate"
    - name: "no_show_count"
      expr: COUNT(DISTINCT CASE WHEN no_show_flag = TRUE THEN shift_assignment_id END)
      comment: "Count of no-shows for attendance reliability and staffing risk"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours for capacity planning and demand forecasting"
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked for labor utilization measurement"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours for baseline labor cost calculation"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours for premium labor cost tracking"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours for extreme premium labor cost"
    - name: "total_event_day_premium_hours"
      expr: SUM(CAST(event_day_premium_hours AS DOUBLE))
      comment: "Total event-day premium hours for event-driven labor cost"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost for shift-based cost tracking and budget management"
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per shift for cost efficiency benchmarking"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for compensation benchmarking"
    - name: "total_break_deduction_hours"
      expr: SUM(CAST(break_deduction_hours AS DOUBLE))
      comment: "Total break deduction hours for accurate payable hours calculation"
    - name: "total_travel_time_hours"
      expr: SUM(CAST(travel_time_hours AS DOUBLE))
      comment: "Total travel time hours for mobile workforce cost tracking"
    - name: "overtime_shift_count"
      expr: COUNT(DISTINCT CASE WHEN overtime_flag = TRUE THEN shift_assignment_id END)
      comment: "Count of overtime shifts for premium labor frequency tracking"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`workforce_labor_relations_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor relations and grievance metrics for union case management, arbitration tracking, and labor compliance risk"
  source: "`sports_entertainment_ecm`.`workforce`.`labor_relations_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Case status (open, under review, resolved, escalated) for case lifecycle tracking"
    - name: "case_type"
      expr: case_type
      comment: "Type of case (grievance, arbitration, unfair labor practice, etc.) for issue classification"
    - name: "case_source"
      expr: case_source
      comment: "Source of case (employee, union, management) for origination analysis"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution (settled, arbitrated, withdrawn, etc.) for outcome tracking"
    - name: "grievance_step"
      expr: grievance_step
      comment: "Grievance procedure step for escalation level tracking"
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Appeal filed flag for case complexity and escalation measurement"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Appeal outcome for final resolution tracking"
    - name: "disciplinary_action_type"
      expr: disciplinary_action_type
      comment: "Type of disciplinary action for corrective action pattern analysis"
    - name: "legal_counsel_engaged"
      expr: legal_counsel_engaged
      comment: "Legal counsel engagement flag for high-risk case identification"
    - name: "osha_related"
      expr: osha_related
      comment: "OSHA-related flag for safety-driven labor relations issues"
    - name: "filed_year"
      expr: YEAR(filed_date)
      comment: "Year case was filed for annual labor relations trend analysis"
    - name: "filed_month"
      expr: DATE_TRUNC('MONTH', filed_date)
      comment: "Month case was filed for seasonal pattern identification"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month of resolution for case closure throughput tracking"
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT labor_relations_case_id)
      comment: "Total labor relations cases for overall case volume tracking"
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN labor_relations_case_id END)
      comment: "Count of open cases for active caseload management"
    - name: "resolved_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Resolved' THEN labor_relations_case_id END)
      comment: "Count of resolved cases for case closure rate calculation"
    - name: "grievance_cases"
      expr: COUNT(DISTINCT CASE WHEN case_type = 'Grievance' THEN labor_relations_case_id END)
      comment: "Count of grievance cases for union relations health measurement"
    - name: "arbitration_cases"
      expr: COUNT(DISTINCT CASE WHEN case_type = 'Arbitration' THEN labor_relations_case_id END)
      comment: "Count of arbitration cases for escalated dispute tracking"
    - name: "appeal_filed_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed = TRUE THEN labor_relations_case_id END)
      comment: "Count of cases with appeals filed for dispute complexity measurement"
    - name: "legal_counsel_engaged_count"
      expr: COUNT(DISTINCT CASE WHEN legal_counsel_engaged = TRUE THEN labor_relations_case_id END)
      comment: "Count of cases with legal counsel for high-risk case volume"
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fine amounts for financial penalty tracking and risk quantification"
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per case for penalty severity benchmarking"
    - name: "total_suspension_days"
      expr: SUM(CAST(suspension_days AS DOUBLE))
      comment: "Total suspension days for disciplinary action impact measurement"
    - name: "osha_related_cases"
      expr: COUNT(DISTINCT CASE WHEN osha_related = TRUE THEN labor_relations_case_id END)
      comment: "Count of OSHA-related cases for safety-driven labor relations issues"
    - name: "prior_case_total"
      expr: SUM(CAST(prior_case_count AS DOUBLE))
      comment: "Total prior case count for repeat offender identification"
$$;