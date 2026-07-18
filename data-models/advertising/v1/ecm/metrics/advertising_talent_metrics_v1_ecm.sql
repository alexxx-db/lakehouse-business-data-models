-- Metric views for domain: talent | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition performance metrics tracking hiring efficiency, cost, and pipeline conversion"
  source: "`advertising_ecm`.`talent`.`acquisition`"
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "job_family"
      expr: job_family
      comment: "Job family classification for role grouping"
    - name: "job_level"
      expr: job_level
      comment: "Seniority level of the position"
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Channel or source from which candidate was hired"
    - name: "posting_channel"
      expr: posting_channel
      comment: "Channel where job was posted"
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (accepted, declined, pending)"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the requisition"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month when application was submitted"
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month when offer was extended"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month when candidate actually started"
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of acquisition records"
    - name: "total_offers_extended"
      expr: COUNT(DISTINCT CASE WHEN offer_date IS NOT NULL THEN acquisition_id END)
      comment: "Number of unique offers extended"
    - name: "total_offers_accepted"
      expr: COUNT(DISTINCT CASE WHEN offer_status = 'Accepted' THEN acquisition_id END)
      comment: "Number of offers accepted by candidates"
    - name: "total_hires"
      expr: COUNT(DISTINCT CASE WHEN actual_start_date IS NOT NULL THEN acquisition_id END)
      comment: "Number of candidates who actually started"
    - name: "total_offered_base_salary"
      expr: SUM(CAST(offered_base_salary AS DOUBLE))
      comment: "Total base salary offered across all acquisitions"
    - name: "avg_offered_base_salary"
      expr: AVG(CAST(offered_base_salary AS DOUBLE))
      comment: "Average base salary offered per acquisition"
    - name: "total_agency_fees"
      expr: SUM(CAST(offered_base_salary AS DOUBLE) * CAST(agency_fee_pct AS DOUBLE) / 100.0)
      comment: "Total agency fees paid based on offered salary and fee percentage"
    - name: "avg_agency_fee_pct"
      expr: AVG(CAST(agency_fee_pct AS DOUBLE))
      comment: "Average agency fee percentage across acquisitions"
    - name: "unique_candidates"
      expr: COUNT(DISTINCT candidate_id)
      comment: "Number of unique candidates in acquisition pipeline"
    - name: "unique_requisitions"
      expr: COUNT(DISTINCT requisition_id)
      comment: "Number of unique requisitions being filled"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_candidate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate pipeline and sourcing effectiveness metrics"
  source: "`advertising_ecm`.`talent`.`candidate`"
  dimensions:
    - name: "candidate_type"
      expr: candidate_type
      comment: "Type of candidate (internal, external, referral)"
    - name: "status"
      expr: candidate_status
      comment: "Current status of candidate in pipeline"
    - name: "source"
      expr: source
      comment: "Source channel from which candidate was acquired"
    - name: "referral_source"
      expr: referral_source
      comment: "Specific referral source if applicable"
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest level of education attained"
    - name: "location_country"
      expr: location_country
      comment: "Country where candidate is located"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month when candidate applied"
    - name: "offer_extended_month"
      expr: DATE_TRUNC('MONTH', offer_extended_date)
      comment: "Month when offer was extended to candidate"
  measures:
    - name: "total_candidates"
      expr: COUNT(1)
      comment: "Total number of candidates in system"
    - name: "unique_candidates"
      expr: COUNT(DISTINCT candidate_id)
      comment: "Number of unique candidates"
    - name: "candidates_with_offers"
      expr: COUNT(DISTINCT CASE WHEN offer_extended_date IS NOT NULL THEN candidate_id END)
      comment: "Number of candidates who received offers"
    - name: "candidates_accepted_offers"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_date IS NOT NULL THEN candidate_id END)
      comment: "Number of candidates who accepted offers"
    - name: "avg_desired_salary"
      expr: AVG(CAST(desired_salary AS DOUBLE))
      comment: "Average salary desired by candidates"
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across candidate pool"
    - name: "avg_screening_score"
      expr: AVG(CAST(screening_score AS DOUBLE))
      comment: "Average screening score for candidates"
    - name: "candidates_willing_to_relocate"
      expr: COUNT(DISTINCT CASE WHEN willing_to_relocate = TRUE THEN candidate_id END)
      comment: "Number of candidates willing to relocate"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce capacity planning and utilization metrics for resource forecasting"
  source: "`advertising_ecm`.`talent`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of capacity plan"
    - name: "discipline"
      expr: discipline
      comment: "Discipline or functional area for capacity planning"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Type of planning scenario (baseline, optimistic, pessimistic)"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (monthly, quarterly, annual)"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when plan period starts"
    - name: "plan_end_month"
      expr: DATE_TRUNC('MONTH', plan_end_date)
      comment: "Month when plan period ends"
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total number of capacity plans"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available workforce hours across all plans"
    - name: "total_confirmed_demand_hours"
      expr: SUM(CAST(confirmed_demand_hours AS DOUBLE))
      comment: "Total confirmed demand hours"
    - name: "total_forecasted_demand_hours"
      expr: SUM(CAST(forecasted_demand_hours AS DOUBLE))
      comment: "Total forecasted demand hours"
    - name: "total_capacity_gap_hours"
      expr: SUM(CAST(capacity_gap_hours AS DOUBLE))
      comment: "Total capacity gap (shortfall or surplus) in hours"
    - name: "total_planned_headcount_fte"
      expr: SUM(CAST(planned_headcount_fte AS DOUBLE))
      comment: "Total planned full-time equivalent headcount"
    - name: "total_freelancer_hours_planned"
      expr: SUM(CAST(freelancer_hours_planned AS DOUBLE))
      comment: "Total freelancer hours planned"
    - name: "total_labor_cost_budget"
      expr: SUM(CAST(labor_cost_budget AS DOUBLE))
      comment: "Total labor cost budget across plans"
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue across capacity plans"
    - name: "avg_utilization_target_pct"
      expr: AVG(CAST(utilization_target_pct AS DOUBLE))
      comment: "Average utilization target percentage"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics for workforce financial analysis"
  source: "`advertising_ecm`.`talent`.`payroll_record`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, bi-weekly, monthly)"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker (employee, contractor, freelancer)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (direct deposit, check, wire)"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate (hourly, salary, commission)"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code for payroll"
    - name: "pay_date_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of pay date"
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month when pay period started"
  measures:
    - name: "total_payroll_records"
      expr: COUNT(1)
      comment: "Total number of payroll records"
    - name: "unique_workers_paid"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique workers who received payment"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount across all records"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay amount distributed to workers"
    - name: "total_base_pay"
      expr: SUM(CAST(base_pay_amount AS DOUBLE))
      comment: "Total base pay amount"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount paid"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission amount paid"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay amount"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all records"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions from gross pay"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal tax withheld"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state tax withheld"
    - name: "total_employer_tax_contribution"
      expr: SUM(CAST(employer_tax_contribution AS DOUBLE))
      comment: "Total employer tax contribution"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record"
    - name: "avg_hours_worked"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per payroll record"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management and talent development metrics"
  source: "`advertising_ecm`.`talent`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probation)"
    - name: "review_status"
      expr: review_status
      comment: "Current status of review (draft, submitted, completed)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of rating calibration process"
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment classification (high performer, solid contributor, needs improvement)"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when review was completed"
    - name: "review_period_start_month"
      expr: DATE_TRUNC('MONTH', review_period_start_date)
      comment: "Month when review period started"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN performance_review_id END)
      comment: "Number of completed performance reviews"
    - name: "unique_employees_reviewed"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique employees who received reviews"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_goal_attainment_score"
      expr: AVG(CAST(goal_attainment_score AS DOUBLE))
      comment: "Average goal attainment score"
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score_avg AS DOUBLE))
      comment: "Average competency score across all competencies"
    - name: "avg_leadership_score"
      expr: AVG(CAST(leadership_competency_score AS DOUBLE))
      comment: "Average leadership competency score"
    - name: "avg_collaboration_score"
      expr: AVG(CAST(collaboration_score AS DOUBLE))
      comment: "Average collaboration score"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage recommended"
    - name: "employees_recommended_for_promotion"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommended = TRUE THEN worker_id END)
      comment: "Number of employees recommended for promotion"
    - name: "employees_on_pip"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN worker_id END)
      comment: "Number of employees requiring performance improvement plan"
    - name: "succession_candidates"
      expr: COUNT(DISTINCT CASE WHEN succession_candidate = TRUE THEN worker_id END)
      comment: "Number of employees identified as succession candidates"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_resource_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource allocation and utilization metrics for workforce deployment optimization"
  source: "`advertising_ecm`.`talent`.`resource_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of resource allocation"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (project, campaign, initiative)"
    - name: "booking_type"
      expr: booking_type
      comment: "Type of booking (hard, soft, tentative)"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker (employee, contractor, freelancer)"
    - name: "department"
      expr: department
      comment: "Department to which resource is allocated"
    - name: "crew_role_designation"
      expr: crew_role_designation
      comment: "Specific crew role designation for production work"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when allocation starts"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when allocation ends"
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of resource allocations"
    - name: "unique_workers_allocated"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique workers with allocations"
    - name: "total_allocated_hours"
      expr: SUM(CAST(total_allocated_hours AS DOUBLE))
      comment: "Total hours allocated across all resources"
    - name: "total_allocated_hours_per_week"
      expr: SUM(CAST(allocated_hours_per_week AS DOUBLE))
      comment: "Total weekly hours allocated"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per resource"
    - name: "avg_utilization_target_pct"
      expr: AVG(CAST(utilization_target_percentage AS DOUBLE))
      comment: "Average utilization target percentage"
    - name: "billable_allocations"
      expr: COUNT(DISTINCT CASE WHEN billable_flag = TRUE THEN resource_allocation_id END)
      comment: "Number of billable resource allocations"
    - name: "non_billable_allocations"
      expr: COUNT(DISTINCT CASE WHEN billable_flag = FALSE THEN resource_allocation_id END)
      comment: "Number of non-billable resource allocations"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time tracking and utilization metrics for workforce productivity analysis"
  source: "`advertising_ecm`.`talent`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of timesheet"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker submitting timesheet"
    - name: "pay_period_type"
      expr: pay_period_type
      comment: "Type of pay period (weekly, bi-weekly, monthly)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit timesheet"
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month when pay period started"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when timesheet was submitted"
  measures:
    - name: "total_timesheets"
      expr: COUNT(1)
      comment: "Total number of timesheets"
    - name: "unique_workers_submitting"
      expr: COUNT(DISTINCT timesheet_worker_id)
      comment: "Number of unique workers who submitted timesheets"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours logged across all timesheets"
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours logged"
    - name: "total_non_billable_hours"
      expr: SUM(CAST(non_billable_hours AS DOUBLE))
      comment: "Total non-billable hours logged"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours logged"
    - name: "total_holiday_hours"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total holiday hours logged"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average utilization rate across timesheets"
    - name: "avg_hours_per_timesheet"
      expr: AVG(CAST(total_hours AS DOUBLE))
      comment: "Average total hours per timesheet"
    - name: "late_submissions"
      expr: COUNT(DISTINCT CASE WHEN is_late_submission = TRUE THEN timesheet_id END)
      comment: "Number of timesheets submitted late"
    - name: "amended_timesheets"
      expr: COUNT(DISTINCT CASE WHEN is_amended = TRUE THEN timesheet_id END)
      comment: "Number of timesheets that were amended"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent engagement and external workforce management metrics"
  source: "`advertising_ecm`.`talent`.`talent_engagement`"
  dimensions:
    - name: "talent_engagement_status"
      expr: talent_engagement_status
      comment: "Current status of talent engagement"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (freelance, contractor, consultant)"
    - name: "billing_arrangement"
      expr: billing_arrangement
      comment: "Billing arrangement for engagement"
    - name: "tax_classification"
      expr: tax_classification
      comment: "Tax classification of engaged talent"
    - name: "department"
      expr: department
      comment: "Department engaging the talent"
    - name: "exclusivity_category"
      expr: exclusivity_category
      comment: "Category of exclusivity arrangement"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when engagement started"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when engagement ended or is scheduled to end"
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of talent engagements"
    - name: "active_engagements"
      expr: COUNT(DISTINCT CASE WHEN talent_engagement_status = 'Active' THEN talent_engagement_id END)
      comment: "Number of currently active engagements"
    - name: "total_engagement_value"
      expr: SUM(CAST(total_engagement_value AS DOUBLE))
      comment: "Total value of all engagements"
    - name: "avg_engagement_value"
      expr: AVG(CAST(total_engagement_value AS DOUBLE))
      comment: "Average value per engagement"
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total hours allocated across all engagements"
    - name: "avg_agreed_rate"
      expr: AVG(CAST(agreed_rate AS DOUBLE))
      comment: "Average agreed rate across engagements"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage applied"
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total full-time equivalent capacity from engagements"
    - name: "exclusive_engagements"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN talent_engagement_id END)
      comment: "Number of exclusive talent engagements"
    - name: "engagements_with_usage_rights"
      expr: COUNT(DISTINCT CASE WHEN usage_rights_included = TRUE THEN talent_engagement_id END)
      comment: "Number of engagements including usage rights"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`talent_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce demographics and employment metrics for organizational analysis"
  source: "`advertising_ecm`.`talent`.`worker`"
  dimensions:
    - name: "worker_status"
      expr: worker_status
      comment: "Current employment status of worker"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "job_family"
      expr: job_family
      comment: "Job family classification"
    - name: "job_title"
      expr: job_title
      comment: "Current job title"
    - name: "department_code"
      expr: department_code
      comment: "Department code"
    - name: "office_location_code"
      expr: office_location_code
      comment: "Office location code"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (on-site, remote, hybrid)"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of worker"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of worker"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month when worker was hired"
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month when worker was terminated"
  measures:
    - name: "total_workers"
      expr: COUNT(1)
      comment: "Total number of worker records"
    - name: "unique_workers"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique workers"
    - name: "active_workers"
      expr: COUNT(DISTINCT CASE WHEN worker_status = 'Active' THEN worker_id END)
      comment: "Number of currently active workers"
    - name: "terminated_workers"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN worker_id END)
      comment: "Number of workers who have been terminated"
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE) / 100.0)
      comment: "Total full-time equivalent headcount"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage across workers"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across workers"
    - name: "avg_standard_weekly_hours"
      expr: AVG(CAST(standard_weekly_hours AS DOUBLE))
      comment: "Average standard weekly hours"
$$;
