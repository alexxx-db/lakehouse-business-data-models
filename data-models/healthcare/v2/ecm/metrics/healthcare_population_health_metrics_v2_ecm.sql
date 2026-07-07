-- Metric views for domain: population_health | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`population_health_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health cohort membership KPIs measuring cohort size, active membership retention, attribution, and average risk stratification. Steers population health management resource allocation and care management targeting."
  source: "`vibe_healthcare_v1`.`population_health`.`cohort_membership`"
  dimensions:
    - name: "membership_status"
      expr: cohort_membership_status
      comment: "Current status of the patient's membership in the cohort (e.g., active, exited) used to segment retained vs. churned cohort members."
    - name: "is_active"
      expr: is_active_flag
      comment: "Boolean flag indicating whether the patient is currently an active member of the cohort."
    - name: "attribution"
      expr: attribution_flag
      comment: "Boolean flag indicating whether the member is formally attributed to the cohort for value-based-care accountability."
    - name: "entry_reason"
      expr: entry_reason
      comment: "Reason the patient entered the cohort, used to analyze inbound drivers of cohort growth."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason the patient exited the cohort, used to analyze churn drivers and care-continuity gaps."
    - name: "membership_start_month"
      expr: DATE_TRUNC('MONTH', membership_start_date)
      comment: "Month a patient's cohort membership started, used for enrollment trend analysis."
    - name: "membership_end_month"
      expr: DATE_TRUNC('MONTH', membership_end_date)
      comment: "Month a patient's cohort membership ended, used for disenrollment trend analysis."
  measures:
    - name: "Distinct Cohort Members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of unique patients enrolled across cohorts — headline measure of population under management for capacity and care-management staffing decisions."
    - name: "Active Membership Count"
      expr: COUNT(DISTINCT CASE WHEN is_active_flag = TRUE THEN mpi_record_id END)
      comment: "Count of unique currently-active cohort members — drives active panel size for care coordination workload planning."
    - name: "Attributed Member Count"
      expr: COUNT(DISTINCT CASE WHEN attribution_flag = TRUE THEN mpi_record_id END)
      comment: "Count of unique attributed patients — the accountable population for value-based-care contract performance and shared-savings calculations."
    - name: "Average Member Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of cohort members — used to prioritize high-risk populations and forecast care-management intensity and cost."
    - name: "High Risk Member Count"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) >= 1.0 THEN mpi_record_id END)
      comment: "Count of unique members with elevated risk scores — targets intensive care management outreach and drives risk-based intervention decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`population_health_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cohort definition governance KPIs measuring active cohort inventory, dynamic-refresh coverage, and definition freshness. Steers population health analytics operations and data governance oversight."
  source: "`vibe_healthcare_v1`.`population_health`.`cohort_definition`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Classification of the cohort (e.g., chronic condition, quality measure, contract) used to segment the analytics portfolio."
    - name: "cohort_status"
      expr: cohort_definition_status
      comment: "Lifecycle status of the cohort definition used to distinguish live vs. retired cohorts."
    - name: "is_active"
      expr: active_flag
      comment: "Boolean flag indicating whether the cohort definition is currently active."
    - name: "is_dynamic"
      expr: is_dynamic_flag
      comment: "Boolean flag indicating whether cohort membership is auto-refreshed by logic rather than statically loaded."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "Configured refresh cadence of the cohort, used to assess data-freshness SLAs."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period the cohort applies to, used to align cohorts to quality reporting windows."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the cohort definition was created, used to track analytics portfolio growth."
  measures:
    - name: "Distinct Cohort Definitions"
      expr: COUNT(DISTINCT cohort_definition_id)
      comment: "Count of unique cohort definitions — headline measure of the population health analytics portfolio breadth for governance review."
    - name: "Active Cohort Definitions"
      expr: COUNT(DISTINCT CASE WHEN active_flag = TRUE THEN cohort_definition_id END)
      comment: "Count of unique active cohort definitions — the live analytical inventory that leadership monitors for coverage of managed populations."
    - name: "Dynamic Cohort Definitions"
      expr: COUNT(DISTINCT CASE WHEN is_dynamic_flag = TRUE THEN cohort_definition_id END)
      comment: "Count of unique dynamically-refreshed cohorts — indicates automation maturity and reduces manual analytics burden."
    - name: "Stale Cohort Definitions"
      expr: COUNT(DISTINCT CASE WHEN last_refreshed_timestamp < DATE_SUB(CURRENT_DATE(), 30) THEN cohort_definition_id END)
      comment: "Count of unique cohorts not refreshed in 30+ days — flags data-freshness risk requiring analytics operations intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`population_health_trial_match_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial matching KPIs measuring eligibility yield, average match quality, and patient conversion funnel. Steers research recruitment strategy and trial enrollment forecasting for academic medical centers."
  source: "`vibe_healthcare_v1`.`population_health`.`trial_match_evaluation`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility outcome of the trial-match evaluation used to segment eligible vs. ineligible patients."
    - name: "match_status"
      expr: match_status
      comment: "Match outcome status used to track the matching pipeline stages."
    - name: "is_eligible"
      expr: eligible_flag
      comment: "Boolean flag indicating the patient met eligibility criteria for the trial."
    - name: "patient_contacted"
      expr: patient_contacted_flag
      comment: "Boolean flag indicating the patient was contacted about the trial, used for recruitment funnel analysis."
    - name: "patient_interested"
      expr: patient_interest_flag
      comment: "Boolean flag indicating the patient expressed interest, used to measure recruitment conversion."
    - name: "matching_algorithm"
      expr: matching_algorithm
      comment: "Algorithm used to generate the match, enabling comparison of matching model effectiveness."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the trial-match evaluation was performed, used for recruitment trend analysis."
  measures:
    - name: "Total Match Evaluations"
      expr: COUNT(1)
      comment: "Count of trial-match evaluations performed — measures matching engine throughput and research operations activity for capacity planning."
    - name: "Distinct Evaluated Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of unique patients screened for trials — measures reach of the recruitment pipeline for research strategy decisions."
    - name: "Eligible Patient Count"
      expr: COUNT(DISTINCT CASE WHEN eligible_flag = TRUE THEN mpi_record_id END)
      comment: "Count of unique eligible patients — the recruitable pool that drives trial enrollment forecasting and site-feasibility decisions."
    - name: "Contacted Patient Count"
      expr: COUNT(DISTINCT CASE WHEN patient_contacted_flag = TRUE THEN mpi_record_id END)
      comment: "Count of unique patients contacted about trials — top of recruitment funnel for outreach efficiency measurement."
    - name: "Interested Patient Count"
      expr: COUNT(DISTINCT CASE WHEN patient_interest_flag = TRUE THEN mpi_record_id END)
      comment: "Count of unique patients expressing trial interest — the recruitment conversion outcome tied to enrollment revenue and study viability."
    - name: "Average Match Score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match quality score across evaluations — indicates matching model precision and helps prioritize highest-fit patients for outreach."
    - name: "Average Eligibility Score"
      expr: AVG(CAST(eligibility_score AS DOUBLE))
      comment: "Average eligibility score across evaluations — assesses how well the screened population fits trial criteria to guide protocol design."
$$;