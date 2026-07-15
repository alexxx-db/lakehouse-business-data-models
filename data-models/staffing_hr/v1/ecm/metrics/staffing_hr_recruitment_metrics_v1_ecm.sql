-- Metric views for domain: recruitment | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core recruitment submittal metrics tracking candidate submission performance, conversion rates, and time-to-fill efficiency across the recruitment lifecycle."
  source: "`staffing_hr_ecm`.`recruitment`.`submittal`"
  dimensions:
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g., submitted, interviewing, offered, rejected, placed)"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement (e.g., direct hire, contract, temp-to-perm)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (e.g., temporary, permanent, contract-to-hire)"
    - name: "submittal_source"
      expr: submittal_source
      comment: "Source channel of the submittal (e.g., internal database, referral, job board)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (e.g., W2, 1099, corp-to-corp)"
    - name: "submittal_year"
      expr: YEAR(submittal_date)
      comment: "Year of submittal"
    - name: "submittal_quarter"
      expr: CONCAT('Q', QUARTER(submittal_date))
      comment: "Quarter of submittal"
    - name: "submittal_month"
      expr: DATE_TRUNC('MONTH', submittal_date)
      comment: "Month of submittal"
    - name: "is_backfill"
      expr: is_backfill
      comment: "Flag indicating if this is a backfill submittal"
    - name: "is_redeployment"
      expr: is_redeployment
      comment: "Flag indicating if this is a redeployment submittal"
    - name: "converted_to_placement"
      expr: converted_to_placement
      comment: "Flag indicating if submittal converted to placement"
  measures:
    - name: "total_submittals"
      expr: COUNT(submittal_id)
      comment: "Total number of candidate submittals"
    - name: "unique_candidates_submitted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of candidates submitted"
    - name: "unique_orders_submitted_to"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Distinct count of job orders receiving submittals"
    - name: "placement_conversion_count"
      expr: SUM(CASE WHEN converted_to_placement = TRUE THEN 1 ELSE 0 END)
      comment: "Count of submittals that converted to placements"
    - name: "placement_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN converted_to_placement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(submittal_id), 0), 2)
      comment: "Percentage of submittals that converted to placements"
    - name: "interview_requested_count"
      expr: SUM(CASE WHEN interview_requested_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of submittals where interview was requested"
    - name: "interview_scheduled_count"
      expr: SUM(CASE WHEN interview_scheduled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of submittals where interview was scheduled"
    - name: "offer_extended_count"
      expr: SUM(CASE WHEN offer_extended_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of submittals where offer was extended"
    - name: "offer_accepted_count"
      expr: SUM(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of submittals where offer was accepted"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN offer_extended_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of extended offers that were accepted"
    - name: "avg_proposed_bill_rate"
      expr: AVG(CAST(proposed_bill_rate AS DOUBLE))
      comment: "Average proposed bill rate across submittals"
    - name: "avg_proposed_pay_rate"
      expr: AVG(CAST(proposed_pay_rate AS DOUBLE))
      comment: "Average proposed pay rate across submittals"
    - name: "avg_qos_rating"
      expr: AVG(CAST(qos_rating AS DOUBLE))
      comment: "Average quality of service rating for submittals"
    - name: "rtr_obtained_count"
      expr: SUM(CASE WHEN rtr_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of submittals with right-to-represent obtained"
    - name: "rtr_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rtr_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(submittal_id), 0), 2)
      comment: "Percentage of submittals with right-to-represent obtained"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_interview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interview performance metrics tracking scheduling efficiency, completion rates, candidate quality ratings, and interview-to-hire conversion."
  source: "`staffing_hr_ecm`.`recruitment`.`interview`"
  dimensions:
    - name: "interview_status"
      expr: interview_status
      comment: "Current status of the interview (e.g., scheduled, completed, cancelled, no-show)"
    - name: "interview_type"
      expr: interview_type
      comment: "Type of interview (e.g., phone screen, technical, behavioral, panel)"
    - name: "format"
      expr: format
      comment: "Interview format (e.g., in-person, video, phone)"
    - name: "round"
      expr: round
      comment: "Interview round number"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Interview decision outcome (e.g., advance, reject, hold)"
    - name: "hire_recommendation"
      expr: hire_recommendation
      comment: "Hiring recommendation from interviewer (e.g., strong yes, yes, no, strong no)"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement"
    - name: "is_blind_interview"
      expr: is_blind_interview
      comment: "Flag indicating if this was a blind interview"
    - name: "is_reschedule"
      expr: is_reschedule
      comment: "Flag indicating if this interview was rescheduled"
    - name: "interview_year"
      expr: YEAR(scheduled_start_timestamp)
      comment: "Year of scheduled interview"
    - name: "interview_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month of scheduled interview"
  measures:
    - name: "total_interviews"
      expr: COUNT(interview_id)
      comment: "Total number of interviews"
    - name: "unique_candidates_interviewed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of candidates interviewed"
    - name: "completed_interviews"
      expr: SUM(CASE WHEN actual_start_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of interviews that were completed"
    - name: "interview_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_start_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(interview_id), 0), 2)
      comment: "Percentage of scheduled interviews that were completed"
    - name: "cancelled_interviews"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of cancelled interviews"
    - name: "rescheduled_interviews"
      expr: SUM(CASE WHEN is_reschedule = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interviews that were rescheduled"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall candidate rating from interviews"
    - name: "avg_technical_skills_rating"
      expr: AVG(CAST(technical_skills_rating AS DOUBLE))
      comment: "Average technical skills rating from interviews"
    - name: "avg_communication_rating"
      expr: AVG(CAST(communication_rating AS DOUBLE))
      comment: "Average communication rating from interviews"
    - name: "avg_culture_fit_rating"
      expr: AVG(CAST(culture_fit_rating AS DOUBLE))
      comment: "Average culture fit rating from interviews"
    - name: "positive_hire_recommendation_count"
      expr: SUM(CASE WHEN hire_recommendation IN ('yes', 'strong yes', 'hire', 'strong hire') THEN 1 ELSE 0 END)
      comment: "Count of interviews with positive hire recommendation"
    - name: "hire_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hire_recommendation IN ('yes', 'strong yes', 'hire', 'strong hire') THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN hire_recommendation IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed interviews with positive hire recommendation"
    - name: "feedback_submitted_count"
      expr: SUM(CASE WHEN feedback_submitted_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of interviews with feedback submitted"
    - name: "feedback_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN feedback_submitted_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_start_timestamp IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed interviews with feedback submitted"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_hiring_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hiring decision metrics tracking offer acceptance, time-to-fill, quality of hire, and placement economics including bill and pay rates."
  source: "`staffing_hr_ecm`.`recruitment`.`hiring_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Status of the hiring decision (e.g., pending, approved, rejected, withdrawn)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of hiring decision (e.g., hire, no-hire, hold)"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt/non-exempt)"
    - name: "eeoc_category"
      expr: eeoc_category
      comment: "EEOC job category for compliance reporting"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which candidate was sourced"
    - name: "offer_extended"
      expr: offer_extended
      comment: "Flag indicating if offer was extended"
    - name: "offer_accepted"
      expr: offer_accepted
      comment: "Flag indicating if offer was accepted"
    - name: "is_backfill"
      expr: is_backfill
      comment: "Flag indicating if this is a backfill hire"
    - name: "is_temp_to_perm"
      expr: is_temp_to_perm
      comment: "Flag indicating if this is a temp-to-perm conversion"
    - name: "fall_off_risk_flag"
      expr: fall_off_risk_flag
      comment: "Flag indicating candidate fall-off risk"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of hiring decision"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of hiring decision"
  measures:
    - name: "total_hiring_decisions"
      expr: COUNT(hiring_decision_id)
      comment: "Total number of hiring decisions"
    - name: "unique_candidates_decided"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of candidates with hiring decisions"
    - name: "offers_extended_count"
      expr: SUM(CASE WHEN offer_extended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of offers extended"
    - name: "offers_accepted_count"
      expr: SUM(CASE WHEN offer_accepted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of offers accepted"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offer_accepted = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN offer_extended = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of extended offers that were accepted"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for hiring decisions"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate for hiring decisions"
    - name: "total_bill_rate_value"
      expr: SUM(CAST(bill_rate AS DOUBLE))
      comment: "Total bill rate value across all hiring decisions"
    - name: "total_pay_rate_value"
      expr: SUM(CAST(pay_rate AS DOUBLE))
      comment: "Total pay rate value across all hiring decisions"
    - name: "avg_qos_score"
      expr: AVG(CAST(qos_score AS DOUBLE))
      comment: "Average quality of service score for hiring decisions"
    - name: "bgc_required_count"
      expr: SUM(CASE WHEN bgc_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hiring decisions requiring background check"
    - name: "fall_off_risk_count"
      expr: SUM(CASE WHEN fall_off_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hiring decisions with fall-off risk"
    - name: "fall_off_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fall_off_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(hiring_decision_id), 0), 2)
      comment: "Percentage of hiring decisions with fall-off risk"
    - name: "temp_to_perm_count"
      expr: SUM(CASE WHEN is_temp_to_perm = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temp-to-perm conversions"
    - name: "backfill_count"
      expr: SUM(CASE WHEN is_backfill = TRUE THEN 1 ELSE 0 END)
      comment: "Count of backfill hires"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_recruiter_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiter performance metrics tracking assignment workload, fill rates, submittal-to-hire ratios, and SLA compliance by recruiter and desk."
  source: "`staffing_hr_ecm`.`recruitment`.`recruiter_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the recruiter assignment (e.g., active, completed, cancelled)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., exclusive, shared, overflow)"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the assignment (e.g., critical, high, medium, low)"
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy employed for the assignment"
    - name: "is_exclusive_assignment"
      expr: is_exclusive_assignment
      comment: "Flag indicating if this is an exclusive assignment"
    - name: "is_rpo_engagement"
      expr: is_rpo_engagement
      comment: "Flag indicating if this is an RPO engagement"
    - name: "backfill_required"
      expr: backfill_required
      comment: "Flag indicating if backfill is required"
    - name: "fall_off_risk_flag"
      expr: fall_off_risk_flag
      comment: "Flag indicating fall-off risk"
    - name: "assigned_year"
      expr: YEAR(assigned_date)
      comment: "Year of assignment"
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month of assignment"
  measures:
    - name: "total_assignments"
      expr: COUNT(recruiter_assignment_id)
      comment: "Total number of recruiter assignments"
    - name: "unique_recruiters"
      expr: COUNT(DISTINCT recruiter_desk_id)
      comment: "Distinct count of recruiter desks with assignments"
    - name: "unique_orders_assigned"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Distinct count of job orders assigned to recruiters"
    - name: "filled_assignments"
      expr: SUM(CASE WHEN actual_fill_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of assignments that were filled"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_fill_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(recruiter_assignment_id), 0), 2)
      comment: "Percentage of assignments that were successfully filled"
    - name: "avg_submittal_to_hire_ratio"
      expr: AVG(CAST(submittal_to_hire_ratio AS DOUBLE))
      comment: "Average submittal-to-hire ratio across assignments"
    - name: "avg_interview_to_offer_ratio"
      expr: AVG(CAST(interview_to_offer_ratio AS DOUBLE))
      comment: "Average interview-to-offer ratio across assignments"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average recruiter performance score"
    - name: "avg_workload_weight"
      expr: AVG(CAST(workload_weight AS DOUBLE))
      comment: "Average workload weight per assignment"
    - name: "total_workload_weight"
      expr: SUM(CAST(workload_weight AS DOUBLE))
      comment: "Total workload weight across all assignments"
    - name: "avg_split_fee_percentage"
      expr: AVG(CAST(split_fee_percentage AS DOUBLE))
      comment: "Average split fee percentage for shared assignments"
    - name: "exclusive_assignments_count"
      expr: SUM(CASE WHEN is_exclusive_assignment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive assignments"
    - name: "rpo_engagements_count"
      expr: SUM(CASE WHEN is_rpo_engagement = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RPO engagements"
    - name: "reassigned_count"
      expr: SUM(CASE WHEN reassignment_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of assignments that were reassigned"
    - name: "fall_off_risk_count"
      expr: SUM(CASE WHEN fall_off_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments with fall-off risk"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance metrics tracking breach frequency, severity, resolution time, and financial penalties to manage client service level agreements."
  source: "`staffing_hr_ecm`.`recruitment`.`sla_breach`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Status of the SLA breach (e.g., open, resolved, disputed, waived)"
    - name: "breach_type"
      expr: breach_type
      comment: "Type of SLA breach (e.g., time-to-fill, quality, submittal volume)"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the breach (e.g., critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the breach"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the breach"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement"
    - name: "penalty_applicable"
      expr: penalty_applicable
      comment: "Flag indicating if penalty is applicable"
    - name: "is_repeat_breach"
      expr: is_repeat_breach
      comment: "Flag indicating if this is a repeat breach"
    - name: "client_notified"
      expr: client_notified
      comment: "Flag indicating if client was notified"
    - name: "breach_year"
      expr: YEAR(breach_date)
      comment: "Year of breach"
    - name: "breach_month"
      expr: DATE_TRUNC('MONTH', breach_date)
      comment: "Month of breach"
  measures:
    - name: "total_breaches"
      expr: COUNT(sla_breach_id)
      comment: "Total number of SLA breaches"
    - name: "unique_clients_with_breaches"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Distinct count of clients with SLA breaches"
    - name: "unique_orders_with_breaches"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Distinct count of job orders with SLA breaches"
    - name: "resolved_breaches"
      expr: SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of resolved SLA breaches"
    - name: "breach_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(sla_breach_id), 0), 2)
      comment: "Percentage of SLA breaches that have been resolved"
    - name: "avg_breach_magnitude"
      expr: AVG(CAST(breach_magnitude AS DOUBLE))
      comment: "Average magnitude of SLA breaches"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount across all SLA breaches"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA breach"
    - name: "breaches_with_penalty"
      expr: SUM(CASE WHEN penalty_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches with applicable penalties"
    - name: "penalty_application_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(sla_breach_id), 0), 2)
      comment: "Percentage of breaches with applicable penalties"
    - name: "repeat_breaches_count"
      expr: SUM(CASE WHEN is_repeat_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat SLA breaches"
    - name: "repeat_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_breach = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(sla_breach_id), 0), 2)
      comment: "Percentage of breaches that are repeat occurrences"
    - name: "client_notified_count"
      expr: SUM(CASE WHEN client_notified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches where client was notified"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value that triggered the breach"
    - name: "avg_sla_threshold_value"
      expr: AVG(CAST(sla_threshold_value AS DOUBLE))
      comment: "Average SLA threshold value"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_sourcing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing campaign effectiveness metrics tracking budget utilization, channel performance, and ROI to optimize talent acquisition spend."
  source: "`staffing_hr_ecm`.`recruitment`.`sourcing_campaign`"
  dimensions:
    - name: "sourcing_campaign_status"
      expr: sourcing_campaign_status
      comment: "Status of the sourcing campaign (e.g., active, completed, cancelled, on-hold)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of sourcing campaign (e.g., job board, social media, referral, event)"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary sourcing channel for the campaign"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the engagement"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type targeted by campaign"
    - name: "experience_level"
      expr: experience_level
      comment: "Experience level targeted by campaign"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the campaign"
    - name: "diversity_sourcing_flag"
      expr: diversity_sourcing_flag
      comment: "Flag indicating if this is a diversity sourcing campaign"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Flag indicating if positions are remote-eligible"
    - name: "is_security_clearance_required"
      expr: is_security_clearance_required
      comment: "Flag indicating if security clearance is required"
    - name: "campaign_year"
      expr: YEAR(start_date)
      comment: "Year of campaign start"
    - name: "campaign_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of campaign start"
  measures:
    - name: "total_campaigns"
      expr: COUNT(sourcing_campaign_id)
      comment: "Total number of sourcing campaigns"
    - name: "active_campaigns"
      expr: SUM(CASE WHEN sourcing_campaign_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active sourcing campaigns"
    - name: "completed_campaigns"
      expr: SUM(CASE WHEN sourcing_campaign_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed sourcing campaigns"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across all campaigns"
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "avg_actual_spend"
      expr: AVG(CAST(actual_spend AS DOUBLE))
      comment: "Average actual spend per campaign"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget utilized across campaigns"
    - name: "avg_bill_rate_target"
      expr: AVG(CAST(bill_rate_target AS DOUBLE))
      comment: "Average bill rate target across campaigns"
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate across campaigns"
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate across campaigns"
    - name: "diversity_campaigns_count"
      expr: SUM(CASE WHEN diversity_sourcing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diversity sourcing campaigns"
    - name: "remote_eligible_campaigns_count"
      expr: SUM(CASE WHEN is_remote_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns for remote-eligible positions"
    - name: "clearance_required_campaigns_count"
      expr: SUM(CASE WHEN is_security_clearance_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns requiring security clearance"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_job_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job posting performance metrics tracking posting status, fill rates, and requisition fulfillment to optimize job advertising effectiveness."
  source: "`staffing_hr_ecm`.`recruitment`.`job_posting`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the job posting (e.g., active, filled, expired, cancelled)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., full-time, part-time, contract, temporary)"
    - name: "posting_channel"
      expr: posting_channel
      comment: "Channel where job was posted (e.g., company website, job board, social media)"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (e.g., on-site, remote, hybrid)"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt/non-exempt)"
    - name: "eeoc_job_category"
      expr: eeoc_job_category
      comment: "EEOC job category for compliance reporting"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (e.g., W2, 1099, corp-to-corp)"
    - name: "bgc_required"
      expr: bgc_required
      comment: "Flag indicating if background check is required"
    - name: "drug_screen_required"
      expr: drug_screen_required
      comment: "Flag indicating if drug screen is required"
    - name: "security_clearance_required"
      expr: security_clearance_required
      comment: "Flag indicating if security clearance is required"
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Flag indicating if this is part of an MSP program"
    - name: "rpo_program_flag"
      expr: rpo_program_flag
      comment: "Flag indicating if this is part of an RPO program"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of posting"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting"
  measures:
    - name: "total_postings"
      expr: COUNT(job_posting_id)
      comment: "Total number of job postings"
    - name: "active_postings"
      expr: SUM(CASE WHEN posting_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active job postings"
    - name: "filled_postings"
      expr: SUM(CASE WHEN filled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of filled job postings"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN filled_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(job_posting_id), 0), 2)
      comment: "Percentage of job postings that were filled"
    - name: "expired_postings"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of expired job postings"
    - name: "avg_bill_rate_max"
      expr: AVG(CAST(bill_rate_max AS DOUBLE))
      comment: "Average maximum bill rate across postings"
    - name: "avg_bill_rate_min"
      expr: AVG(CAST(bill_rate_min AS DOUBLE))
      comment: "Average minimum bill rate across postings"
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate across postings"
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate across postings"
    - name: "bgc_required_count"
      expr: SUM(CASE WHEN bgc_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of postings requiring background check"
    - name: "drug_screen_required_count"
      expr: SUM(CASE WHEN drug_screen_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of postings requiring drug screen"
    - name: "security_clearance_required_count"
      expr: SUM(CASE WHEN security_clearance_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of postings requiring security clearance"
    - name: "msp_program_postings"
      expr: SUM(CASE WHEN msp_program_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of postings under MSP programs"
    - name: "rpo_program_postings"
      expr: SUM(CASE WHEN rpo_program_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of postings under RPO programs"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`recruitment_candidate_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate screening quality metrics tracking pass rates, disqualification reasons, and screening efficiency to improve candidate quality and reduce time-to-submittal."
  source: "`staffing_hr_ecm`.`recruitment`.`candidate_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening (e.g., scheduled, completed, passed, failed, cancelled)"
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening (e.g., phone screen, skills assessment, technical test)"
    - name: "screening_channel"
      expr: screening_channel
      comment: "Channel used for screening (e.g., phone, video, in-person)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the screening (e.g., pass, fail, conditional pass)"
    - name: "disqualification_category"
      expr: disqualification_category
      comment: "Category of disqualification if candidate did not pass"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement"
    - name: "screening_source"
      expr: screening_source
      comment: "Source of the screening"
    - name: "advanced_to_submittal"
      expr: advanced_to_submittal
      comment: "Flag indicating if candidate advanced to submittal"
    - name: "is_rescreening"
      expr: is_rescreening
      comment: "Flag indicating if this is a rescreening"
    - name: "eeoc_compliant"
      expr: eeoc_compliant
      comment: "Flag indicating if screening was EEOC compliant"
    - name: "rtr_obtained"
      expr: rtr_obtained
      comment: "Flag indicating if right-to-represent was obtained"
    - name: "work_authorization_confirmed"
      expr: work_authorization_confirmed
      comment: "Flag indicating if work authorization was confirmed"
    - name: "relocation_willingness"
      expr: relocation_willingness
      comment: "Flag indicating candidate willingness to relocate"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year of screening"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening"
  measures:
    - name: "total_screenings"
      expr: COUNT(candidate_screening_id)
      comment: "Total number of candidate screenings"
    - name: "unique_candidates_screened"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of candidates screened"
    - name: "completed_screenings"
      expr: SUM(CASE WHEN screening_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed screenings"
    - name: "passed_screenings"
      expr: SUM(CASE WHEN outcome IN ('pass', 'passed', 'approved') THEN 1 ELSE 0 END)
      comment: "Count of screenings with pass outcome"
    - name: "screening_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome IN ('pass', 'passed', 'approved') THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN screening_status = 'completed' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed screenings that passed"
    - name: "advanced_to_submittal_count"
      expr: SUM(CASE WHEN advanced_to_submittal = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings that advanced to submittal"
    - name: "submittal_advancement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN advanced_to_submittal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(candidate_screening_id), 0), 2)
      comment: "Percentage of screenings that advanced to submittal"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall screening score"
    - name: "avg_passing_threshold"
      expr: AVG(CAST(passing_threshold AS DOUBLE))
      comment: "Average passing threshold across screenings"
    - name: "avg_pay_rate_expectation"
      expr: AVG(CAST(pay_rate_expectation AS DOUBLE))
      comment: "Average pay rate expectation from candidates"
    - name: "rtr_obtained_count"
      expr: SUM(CASE WHEN rtr_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings where right-to-represent was obtained"
    - name: "rtr_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rtr_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(candidate_screening_id), 0), 2)
      comment: "Percentage of screenings with right-to-represent obtained"
    - name: "work_authorization_confirmed_count"
      expr: SUM(CASE WHEN work_authorization_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings with work authorization confirmed"
    - name: "eeoc_compliant_count"
      expr: SUM(CASE WHEN eeoc_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EEOC compliant screenings"
    - name: "rescreening_count"
      expr: SUM(CASE WHEN is_rescreening = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rescreenings"
$$;
