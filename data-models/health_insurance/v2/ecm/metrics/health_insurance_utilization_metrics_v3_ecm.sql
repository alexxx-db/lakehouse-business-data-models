-- Metric views for domain: utilization | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request metrics tracking approval rates, turnaround times, and financial impact for utilization management decisions"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of prior authorization request (e.g., inpatient, outpatient, pharmacy)"
    - name: "service_type"
      expr: service_type
      comment: "Category of service being requested for authorization"
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the prior authorization request (approved, denied, pending)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA request was submitted (portal, fax, phone, EDI)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code indicating reason for denial if request was not approved"
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether the PA decision can be appealed"
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating whether this is a duplicate of an existing request"
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the prior authorization request was submitted"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the prior authorization request was submitted"
    - name: "decision_year"
      expr: YEAR(prior_auth_decision_date)
      comment: "Year the prior authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', prior_auth_decision_date)
      comment: "Month the prior authorization decision was made"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross dollar amount across all PA requests"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net dollar amount after adjustments across all PA requests"
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment amount across all PA requests"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross dollar amount per PA request"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from request submission to decision"
    - name: "distinct_members"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with prior authorization requests"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers submitting prior authorization requests"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with PA requests"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization decision metrics tracking approval rates, denial patterns, and clinical criteria compliance for quality and regulatory oversight"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_type"
      expr: decision_type
      comment: "Type of prior authorization decision (approval, denial, partial approval)"
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the PA decision"
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason for trend analysis"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific code indicating reason for denial"
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Flag indicating whether clinical criteria were met"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the decision is eligible for appeal"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether this was an urgent authorization request"
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Flag indicating whether the service is telehealth-based"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the decision meets regulatory compliance requirements"
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Type of authorization period (single service, date range, ongoing)"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the prior authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the prior authorization decision was made"
    - name: "authorization_start_year"
      expr: YEAR(authorization_start_date)
      comment: "Year the authorization period begins"
    - name: "authorization_start_month"
      expr: DATE_TRUNC('MONTH', authorization_start_date)
      comment: "Month the authorization period begins"
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of prior authorization decisions made"
    - name: "distinct_pa_requests"
      expr: COUNT(DISTINCT pa_request_id)
      comment: "Count of unique PA requests with decisions"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of unique members with PA decisions"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers associated with PA decisions"
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(authorization_quantity AS DOUBLE))
      comment: "Average authorized quantity per decision"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management case metrics tracking case volume, turnaround times, denial rates, and length of stay performance for operational efficiency and quality oversight"
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of utilization management case (prospective, concurrent, retrospective)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the UM case (open, closed, pending)"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the case (high, medium, low)"
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity level of the case"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization associated with the case"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for denial if applicable"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Code indicating final disposition of the case"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Flag indicating whether the case has been appealed"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating whether the case is urgent"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the case meets compliance requirements"
    - name: "open_year"
      expr: YEAR(case_open_date)
      comment: "Year the UM case was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the UM case was opened"
    - name: "close_year"
      expr: YEAR(case_close_date)
      comment: "Year the UM case was closed"
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', case_close_date)
      comment: "Month the UM case was closed"
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of utilization management cases"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of unique members with UM cases"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique primary providers associated with UM cases"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with UM cases"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from case open to close"
    - name: "avg_length_of_stay_actual"
      expr: AVG(CAST(length_of_stay_actual AS DOUBLE))
      comment: "Average actual length of stay in days across UM cases"
    - name: "avg_length_of_stay_target"
      expr: AVG(CAST(length_of_stay_target AS DOUBLE))
      comment: "Average target length of stay in days across UM cases"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission metrics tracking length of stay performance, readmission rates, cost variance, and authorization compliance for hospital utilization management"
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_type"
      expr: admission_type
      comment: "Type of inpatient admission (emergency, elective, urgent)"
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the admission"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition of patient at discharge (home, SNF, rehab, expired)"
    - name: "review_status"
      expr: review_status
      comment: "Status of utilization review for the admission"
    - name: "review_decision"
      expr: review_decision
      comment: "Final decision from utilization review (approved, denied, modified)"
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Status of payer authorization for the admission"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for denial if applicable"
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether this is a readmission"
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag indicating whether readmission occurred within 30 days"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag indicating whether critical care services were provided"
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Flag indicating whether length of stay met benchmark targets"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code for the admission"
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of inpatient admission"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of inpatient admission"
    - name: "discharge_year"
      expr: YEAR(discharge_date)
      comment: "Year of discharge"
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge"
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions"
    - name: "distinct_members"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with inpatient admissions"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with admissions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost across all inpatient admissions"
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected cost across all inpatient admissions"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per inpatient admission"
    - name: "avg_expected_cost"
      expr: AVG(CAST(expected_cost_amount AS DOUBLE))
      comment: "Average expected cost per inpatient admission"
    - name: "avg_actual_los_days"
      expr: AVG(CAST(actual_los_days AS DOUBLE))
      comment: "Average actual length of stay in days"
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days"
    - name: "avg_los_target_days"
      expr: AVG(CAST(los_target_days AS DOUBLE))
      comment: "Average target length of stay in days"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review metrics tracking real-time inpatient utilization, length of stay variance, readmission risk, and discharge planning effectiveness for active case management"
  source: "`vibe_health_insurance_v1`.`utilization`.`concurrent_review`"
  dimensions:
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review"
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review being performed"
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Planned discharge destination (home, SNF, rehab, hospice)"
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Category of readmission risk (low, medium, high)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the case is critical"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating whether social work services are involved"
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of admission for the concurrent review"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for the concurrent review"
    - name: "actual_discharge_year"
      expr: YEAR(actual_discharge_date)
      comment: "Year of actual discharge"
    - name: "actual_discharge_month"
      expr: DATE_TRUNC('MONTH', actual_discharge_date)
      comment: "Month of actual discharge"
    - name: "planned_discharge_year"
      expr: YEAR(planned_discharge_date)
      comment: "Year of planned discharge"
    - name: "planned_discharge_month"
      expr: DATE_TRUNC('MONTH', planned_discharge_date)
      comment: "Month of planned discharge"
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews performed"
    - name: "distinct_members"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with concurrent reviews"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers associated with concurrent reviews"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with concurrent reviews"
    - name: "avg_current_los"
      expr: AVG(CAST(current_length_of_stay AS DOUBLE))
      comment: "Average current length of stay in days at time of review"
    - name: "avg_approved_los"
      expr: AVG(CAST(approved_length_of_stay AS DOUBLE))
      comment: "Average approved length of stay in days"
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean length of stay in days"
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average benchmark target length of stay in days"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across concurrent reviews"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_retrospective_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retrospective review metrics tracking post-service medical necessity determinations, claim adjustments, and documentation compliance for payment integrity and quality assurance"
  source: "`vibe_health_insurance_v1`.`utilization`.`retrospective_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the retrospective review"
    - name: "review_type"
      expr: review_type
      comment: "Type of retrospective review being performed"
    - name: "medical_necessity_outcome"
      expr: medical_necessity_outcome
      comment: "Outcome of medical necessity determination (approved, denied, modified)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for denial if applicable"
    - name: "documentation_completeness_flag"
      expr: documentation_completeness_flag
      comment: "Flag indicating whether documentation was complete"
    - name: "retro_review_deadline_flag"
      expr: retro_review_deadline_flag
      comment: "Flag indicating whether review met regulatory deadline requirements"
    - name: "compliance_state"
      expr: compliance_state
      comment: "State jurisdiction for compliance purposes"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year the service was provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the service was provided"
    - name: "review_initiation_year"
      expr: YEAR(review_initiation_date)
      comment: "Year the retrospective review was initiated"
    - name: "review_initiation_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Month the retrospective review was initiated"
    - name: "review_completion_year"
      expr: YEAR(review_completion_date)
      comment: "Year the retrospective review was completed"
    - name: "review_completion_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Month the retrospective review was completed"
  measures:
    - name: "total_retrospective_reviews"
      expr: COUNT(1)
      comment: "Total number of retrospective reviews performed"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT header_id)
      comment: "Count of unique claims subject to retrospective review"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of unique members with retrospective reviews"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers subject to retrospective review"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with retrospective reviews"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total dollar amount of adjustments resulting from retrospective reviews"
    - name: "avg_adjusted_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average dollar amount of adjustment per retrospective review"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_tat_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround time compliance metrics tracking regulatory deadline adherence, variance analysis, and root cause patterns for operational performance and regulatory risk management"
  source: "`vibe_health_insurance_v1`.`utilization`.`tat_compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of turnaround time compliance event"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Status of compliance with turnaround time requirements"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether turnaround time requirements were met"
    - name: "review_type"
      expr: review_type
      comment: "Type of review associated with the compliance event"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the request (urgent, standard, expedited)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction for compliance requirements"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause for non-compliance"
    - name: "root_cause_detail"
      expr: root_cause_detail
      comment: "Detailed description of root cause for non-compliance"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the compliance event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the compliance event occurred"
    - name: "decision_year"
      expr: YEAR(decision_timestamp)
      comment: "Year the decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month the decision was made"
  measures:
    - name: "total_compliance_events"
      expr: COUNT(1)
      comment: "Total number of turnaround time compliance events tracked"
    - name: "distinct_pa_requests"
      expr: COUNT(DISTINCT pa_request_id)
      comment: "Count of unique PA requests associated with compliance events"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of unique members associated with compliance events"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers associated with compliance events"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average variance in days from turnaround time standard"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours from turnaround time standard"
    - name: "avg_tat_standard_days"
      expr: AVG(CAST(tat_standard_days AS DOUBLE))
      comment: "Average turnaround time standard in days"
    - name: "avg_tat_standard_hours"
      expr: AVG(CAST(tat_standard_hours AS DOUBLE))
      comment: "Average turnaround time standard in hours"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_auth_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization service line metrics tracking authorized quantities, pricing, and clinical criteria compliance at the line-item level for detailed utilization and financial analysis"
  source: "`vibe_health_insurance_v1`.`utilization`.`auth_service_line`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the authorization for this service line"
    - name: "service_category"
      expr: service_category
      comment: "Category of service being authorized"
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code for the authorized service"
    - name: "hcpcs_code"
      expr: hcpcs_code
      comment: "HCPCS code for the authorized service"
    - name: "place_of_service"
      expr: place_of_service
      comment: "Place where the service will be provided"
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for denial if service line was not authorized"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether this is an emergency service"
    - name: "is_experimental"
      expr: is_experimental
      comment: "Flag indicating whether this is an experimental service"
    - name: "is_partial_approval"
      expr: is_partial_approval
      comment: "Flag indicating whether this is a partial approval"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for authorized quantity (visits, days, units)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for authorized price"
    - name: "authorized_start_year"
      expr: YEAR(authorized_start_date)
      comment: "Year the authorization period begins"
    - name: "authorized_start_month"
      expr: DATE_TRUNC('MONTH', authorized_start_date)
      comment: "Month the authorization period begins"
    - name: "authorized_end_year"
      expr: YEAR(authorized_end_date)
      comment: "Year the authorization period ends"
    - name: "authorized_end_month"
      expr: DATE_TRUNC('MONTH', authorized_end_date)
      comment: "Month the authorization period ends"
    - name: "decision_year"
      expr: YEAR(decision_timestamp)
      comment: "Year the authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month the authorization decision was made"
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of authorization service lines"
    - name: "distinct_pa_requests"
      expr: COUNT(DISTINCT pa_request_id)
      comment: "Count of unique PA requests with service lines"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of unique members with authorized service lines"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers associated with authorized service lines"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans associated with authorized service lines"
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total authorized quantity across all service lines"
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(authorized_quantity AS DOUBLE))
      comment: "Average authorized quantity per service line"
    - name: "total_authorized_price"
      expr: SUM(CAST(authorized_price AS DOUBLE))
      comment: "Total authorized price across all service lines"
    - name: "avg_authorized_price"
      expr: AVG(CAST(authorized_price AS DOUBLE))
      comment: "Average authorized price per service line"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management program metrics tracking program enrollment, accreditation status, and regulatory compliance for strategic program oversight and quality assurance"
  source: "`vibe_health_insurance_v1`.`utilization`.`um_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of utilization management program"
    - name: "um_program_status"
      expr: um_program_status
      comment: "Current status of the UM program"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the program serves (commercial, Medicare, Medicaid)"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the UM program (NCQA, URAC)"
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Category of accreditation"
    - name: "gap_analysis_status"
      expr: gap_analysis_status
      comment: "Status of gap analysis for accreditation or compliance"
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Flag indicating whether prior authorization is required for this program"
    - name: "clinical_criteria_set"
      expr: clinical_criteria_set
      comment: "Clinical criteria set used by the program (InterQual, MCG, proprietary)"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the UM program became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the UM program became effective"
    - name: "accreditation_survey_year"
      expr: YEAR(accreditation_survey_date)
      comment: "Year of accreditation survey"
    - name: "accreditation_survey_month"
      expr: DATE_TRUNC('MONTH', accreditation_survey_date)
      comment: "Month of accreditation survey"
  measures:
    - name: "total_um_programs"
      expr: COUNT(1)
      comment: "Total number of utilization management programs"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Count of unique health plans with UM programs"
    - name: "distinct_risk_pools"
      expr: COUNT(DISTINCT pool_id)
      comment: "Count of unique risk pools associated with UM programs"
$$;
