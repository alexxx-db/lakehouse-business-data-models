-- Metric views for domain: utilization | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request performance metrics tracking approval rates, turnaround times, and financial impact of authorization decisions"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  dimensions:
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the prior authorization request (approved, denied, pending, etc.)"
    - name: "request_type"
      expr: request_type
      comment: "Type of prior authorization request (initial, urgent, standard, etc.)"
    - name: "service_type"
      expr: service_type
      comment: "Category of service being requested for authorization"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA request was submitted (portal, fax, phone, EDI)"
    - name: "is_appealable"
      expr: is_appealable
      comment: "Whether the authorization decision can be appealed"
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating if this is a duplicate of an existing request"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for denial reason when request is not approved"
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the prior authorization request was submitted"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the prior authorization request was submitted"
    - name: "decision_year"
      expr: YEAR(prior_auth_decision_date)
      comment: "Year the authorization decision was made"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross financial value of all PA requests before adjustments"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net financial value of all PA requests after adjustments"
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustments applied to PA request amounts"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross amount per prior authorization request"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average number of days from request submission to decision"
    - name: "unique_members_requesting_pa"
      expr: COUNT(DISTINCT plan_election_id)
      comment: "Distinct count of plan elections (member coverage periods) with PA requests"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization decision outcomes tracking approval rates, denial patterns, and clinical criteria compliance"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Final status of the authorization decision (approved, denied, partial, etc.)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of authorization decision (initial, appeal, reconsideration, etc.)"
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason for denied authorizations"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific code identifying the reason for denial"
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Whether clinical criteria were met for the authorization"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the decision is eligible for appeal"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the decision complies with regulatory requirements"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the authorization request was marked as urgent"
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Whether the authorized service is for telehealth delivery"
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Type of authorization period (single, recurring, ongoing, etc.)"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the authorization decision was made"
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of prior authorization decisions rendered"
    - name: "approved_decisions"
      expr: SUM(CASE WHEN decision_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of prior authorization decisions that were approved"
    - name: "denied_decisions"
      expr: SUM(CASE WHEN decision_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Count of prior authorization decisions that were denied"
    - name: "criteria_met_decisions"
      expr: SUM(CASE WHEN criteria_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of decisions where clinical criteria were met"
    - name: "appealable_decisions"
      expr: SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of decisions eligible for appeal"
    - name: "urgent_decisions"
      expr: SUM(CASE WHEN is_urgent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of decisions for urgent authorization requests"
    - name: "unique_members_with_decisions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members receiving authorization decisions"
    - name: "unique_providers_with_decisions"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers associated with authorization decisions"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_auth_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized service line financial and utilization metrics tracking approved services, pricing, and authorization outcomes"
  source: "`vibe_health_insurance_v1`.`utilization`.`auth_service_line`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the service line authorization"
    - name: "service_category"
      expr: service_category
      comment: "Category of the authorized service"
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code for the authorized service"
    - name: "hcpcs_code"
      expr: hcpcs_code
      comment: "HCPCS code for the authorized service or supply"
    - name: "place_of_service"
      expr: place_of_service
      comment: "Location where the authorized service will be delivered"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Whether the service line is for emergency care"
    - name: "is_experimental"
      expr: is_experimental
      comment: "Whether the service is considered experimental or investigational"
    - name: "is_partial_approval"
      expr: is_partial_approval
      comment: "Whether the authorization is a partial approval of the requested service"
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for denial if the service line was not fully authorized"
    - name: "diagnosis_icd_code"
      expr: diagnosis_icd_code
      comment: "ICD diagnosis code associated with the authorized service"
    - name: "authorization_year"
      expr: YEAR(authorized_start_date)
      comment: "Year the authorization period begins"
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorized_start_date)
      comment: "Month the authorization period begins"
    - name: "decision_year"
      expr: YEAR(decision_timestamp)
      comment: "Year the authorization decision was made"
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of authorized service lines"
    - name: "total_authorized_price"
      expr: SUM(CAST(authorized_price AS DOUBLE))
      comment: "Total authorized price amount across all service lines"
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total authorized quantity of services across all lines"
    - name: "avg_authorized_price"
      expr: AVG(CAST(authorized_price AS DOUBLE))
      comment: "Average authorized price per service line"
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(authorized_quantity AS DOUBLE))
      comment: "Average authorized quantity per service line"
    - name: "emergency_service_lines"
      expr: SUM(CASE WHEN is_emergency = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service lines authorized for emergency care"
    - name: "experimental_service_lines"
      expr: SUM(CASE WHEN is_experimental = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service lines for experimental or investigational services"
    - name: "partial_approval_lines"
      expr: SUM(CASE WHEN is_partial_approval = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service lines with partial approval"
    - name: "unique_members_authorized"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with authorized service lines"
    - name: "unique_providers_authorized"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers associated with authorized service lines"
    - name: "unique_facilities_authorized"
      expr: COUNT(DISTINCT authorized_facility_id)
      comment: "Distinct count of facilities where authorized services will be delivered"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission utilization and cost metrics tracking length of stay performance, readmissions, and cost variance"
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the inpatient admission"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (elective, emergency, urgent, etc.)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition of patient at discharge (home, transfer, expired, etc.)"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code for the admission"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the admission"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Whether the admission involved critical care services"
    - name: "is_readmission"
      expr: is_readmission
      comment: "Whether this admission is a readmission"
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Whether this is a readmission within 30 days of prior discharge"
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Whether the length of stay met the benchmark target"
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Authorization status from the payer perspective"
    - name: "review_status"
      expr: review_status
      comment: "Status of utilization review for the admission"
    - name: "review_decision"
      expr: review_decision
      comment: "Final decision from utilization review"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code for denial reason if admission was denied"
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of admission"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission"
    - name: "discharge_year"
      expr: YEAR(discharge_date)
      comment: "Year of discharge"
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for all admissions"
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected cost for all admissions based on benchmarks"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per admission"
    - name: "avg_expected_cost"
      expr: AVG(CAST(expected_cost_amount AS DOUBLE))
      comment: "Average expected cost per admission"
    - name: "avg_actual_los_days"
      expr: AVG(CAST(actual_los_days AS DOUBLE))
      comment: "Average actual length of stay in days"
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days based on benchmarks"
    - name: "avg_los_target_days"
      expr: AVG(CAST(los_target_days AS DOUBLE))
      comment: "Average target length of stay in days"
    - name: "readmissions"
      expr: SUM(CASE WHEN is_readmission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of admissions that are readmissions"
    - name: "readmissions_within_30_days"
      expr: SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readmissions occurring within 30 days of prior discharge"
    - name: "critical_care_admissions"
      expr: SUM(CASE WHEN is_critical_care = TRUE THEN 1 ELSE 0 END)
      comment: "Count of admissions involving critical care"
    - name: "los_benchmark_met_admissions"
      expr: SUM(CASE WHEN los_benchmark_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of admissions that met length of stay benchmark"
    - name: "unique_members_admitted"
      expr: COUNT(DISTINCT plan_election_id)
      comment: "Distinct count of plan elections (member coverage periods) with admissions"
    - name: "unique_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Distinct count of facilities with admissions"
    - name: "unique_attending_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of attending providers for admissions"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review performance metrics tracking length of stay management, discharge planning effectiveness, and readmission risk"
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
      comment: "Planned or actual discharge destination"
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Category of readmission risk (low, medium, high)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the concurrent review is flagged as critical"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Whether social work services are involved in discharge planning"
    - name: "discharge_barriers"
      expr: discharge_barriers
      comment: "Identified barriers to timely discharge"
    - name: "authorized_post_acute_service"
      expr: authorized_post_acute_service
      comment: "Post-acute services authorized for after discharge"
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of length of stay benchmark data"
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of the associated admission"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of the associated admission"
    - name: "review_year"
      expr: YEAR(review_start_timestamp)
      comment: "Year the concurrent review started"
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews performed"
    - name: "avg_current_los"
      expr: AVG(CAST(current_length_of_stay AS DOUBLE))
      comment: "Average current length of stay at time of review"
    - name: "avg_approved_los"
      expr: AVG(CAST(approved_length_of_stay AS DOUBLE))
      comment: "Average approved length of stay from concurrent review"
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean length of stay"
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average benchmark target length of stay"
    - name: "avg_los_benchmark_outlier_threshold"
      expr: AVG(CAST(los_benchmark_outlier_threshold AS DOUBLE))
      comment: "Average benchmark outlier threshold for length of stay"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across concurrent reviews"
    - name: "critical_reviews"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of concurrent reviews flagged as critical"
    - name: "reviews_with_social_work"
      expr: SUM(CASE WHEN social_work_involved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews involving social work services"
    - name: "unique_members_reviewed"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of member subscribers undergoing concurrent review"
    - name: "unique_providers_reviewed"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers associated with concurrent reviews"
    - name: "unique_admissions_reviewed"
      expr: COUNT(DISTINCT inpatient_admission_id)
      comment: "Distinct count of inpatient admissions undergoing concurrent review"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management case metrics tracking case volume, turnaround times, denial patterns, and compliance outcomes"
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the utilization management case"
    - name: "case_type"
      expr: case_type
      comment: "Type of utilization management case"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level assigned to the case"
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity level of the case"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization associated with the case"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Code representing the final disposition of the case"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code for denial reason if case resulted in denial"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code associated with the case"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Whether the case involves an appeal"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Whether the case is flagged as urgent"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the case meets compliance requirements"
    - name: "case_open_year"
      expr: YEAR(case_open_date)
      comment: "Year the case was opened"
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the case was opened"
    - name: "case_close_year"
      expr: YEAR(case_close_date)
      comment: "Year the case was closed"
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of utilization management cases"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from case open to close"
    - name: "avg_actual_los"
      expr: AVG(CAST(length_of_stay_actual AS DOUBLE))
      comment: "Average actual length of stay for cases involving admissions"
    - name: "avg_target_los"
      expr: AVG(CAST(length_of_stay_target AS DOUBLE))
      comment: "Average target length of stay for cases involving admissions"
    - name: "appeal_cases"
      expr: SUM(CASE WHEN appeal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases involving appeals"
    - name: "urgent_cases"
      expr: SUM(CASE WHEN urgency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases flagged as urgent"
    - name: "compliant_cases"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases meeting compliance requirements"
    - name: "unique_members_with_cases"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with utilization management cases"
    - name: "unique_providers_with_cases"
      expr: COUNT(DISTINCT primary_provider_id)
      comment: "Distinct count of primary providers associated with UM cases"
    - name: "unique_coordinators"
      expr: COUNT(DISTINCT coordinator_id)
      comment: "Distinct count of care coordinators managing UM cases"
$$;