-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Patient Index strategic metrics: identity resolution quality, duplicate management, and patient population characteristics"
  source: "`vibe_healthcare_v1`.`patient`.`mpi_record`"
  dimensions:
    - name: "mpi_record_status"
      expr: mpi_record_status
      comment: "Current status of the MPI record (active, merged, inactive)"
    - name: "identity_resolution_status"
      expr: identity_resolution_status
      comment: "Status of identity resolution process for data quality monitoring"
    - name: "identity_confidence_tier"
      expr: identity_confidence_tier
      comment: "Confidence level tier for identity matching (high, medium, low)"
    - name: "patient_class"
      expr: patient_class
      comment: "Classification of patient type (inpatient, outpatient, emergency)"
    - name: "sex_at_birth"
      expr: sex_at_birth
      comment: "Biological sex at birth for demographic analysis"
    - name: "race_code"
      expr: race_code
      comment: "Race code for health equity and disparity analysis"
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Ethnicity code for health equity reporting"
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Indicator whether patient is deceased"
    - name: "is_duplicate_flag"
      expr: is_duplicate_flag
      comment: "Flag indicating potential duplicate record requiring resolution"
    - name: "is_overlay_flag"
      expr: is_overlay_flag
      comment: "Flag indicating overlay record requiring correction"
    - name: "vip_flag"
      expr: vip_flag
      comment: "VIP patient indicator for special handling"
    - name: "restricted_access_flag"
      expr: restricted_access_flag
      comment: "Restricted access flag for confidential patient records"
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Flag indicating interpreter services required"
    - name: "first_registration_year"
      expr: YEAR(first_registration_date)
      comment: "Year of first patient registration for cohort analysis"
    - name: "first_registration_month"
      expr: DATE_TRUNC('MONTH', first_registration_date)
      comment: "Month of first patient registration for trend analysis"
  measures:
    - name: "total_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Total unique patient count in master patient index"
    - name: "duplicate_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END)
      comment: "Count of records flagged as potential duplicates requiring resolution"
    - name: "overlay_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_overlay_flag = TRUE THEN mpi_record_id END)
      comment: "Count of overlay records requiring correction"
    - name: "duplicate_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END) / NULLIF(COUNT(DISTINCT mpi_record_id), 0), 2)
      comment: "Percentage of records flagged as duplicates - key data quality metric"
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average identity match confidence score for quality monitoring"
    - name: "deceased_patient_count"
      expr: COUNT(DISTINCT CASE WHEN deceased_flag = TRUE THEN mpi_record_id END)
      comment: "Count of deceased patients for mortality tracking"
    - name: "vip_patient_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN mpi_record_id END)
      comment: "Count of VIP patients requiring special handling protocols"
    - name: "restricted_access_patient_count"
      expr: COUNT(DISTINCT CASE WHEN restricted_access_flag = TRUE THEN mpi_record_id END)
      comment: "Count of patients with restricted access for compliance monitoring"
    - name: "interpreter_required_patient_count"
      expr: COUNT(DISTINCT CASE WHEN interpreter_required_flag = TRUE THEN mpi_record_id END)
      comment: "Count of patients requiring interpreter services for resource planning"
    - name: "merge_event_count"
      expr: COUNT(DISTINCT CASE WHEN surviving_mpi_record_id IS NOT NULL THEN mpi_record_id END)
      comment: "Count of records that have been merged into surviving records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient registration and admission operational metrics: throughput, quality, and compliance"
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of registration event (admission, discharge, transfer, update)"
    - name: "event_status"
      expr: event_status
      comment: "Status of the registration event"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient, outpatient, emergency, observation)"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (elective, urgent, emergency, newborn)"
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class for revenue cycle analysis"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for outcome tracking"
    - name: "registration_source"
      expr: registration_source
      comment: "Source system or channel of registration"
    - name: "mpi_match_status"
      expr: mpi_match_status
      comment: "Status of MPI matching for data quality monitoring"
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether insurance eligibility was verified"
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Whether patient consent was obtained"
    - name: "advance_directive_flag"
      expr: advance_directive_flag
      comment: "Whether advance directive is on file"
    - name: "vip_flag"
      expr: vip_flag
      comment: "VIP patient indicator"
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Flag indicating potential duplicate registration"
    - name: "registration_date"
      expr: registration_date
      comment: "Date of registration event"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year of registration for trend analysis"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration for seasonal analysis"
    - name: "registration_day_of_week"
      expr: DAYOFWEEK(registration_date)
      comment: "Day of week for staffing pattern analysis"
  measures:
    - name: "total_registration_count"
      expr: COUNT(DISTINCT registration_event_id)
      comment: "Total count of registration events for volume tracking"
    - name: "eligibility_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN eligibility_verified_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registrations with verified insurance eligibility - key revenue cycle metric"
    - name: "consent_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_obtained_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registrations with documented consent - compliance metric"
    - name: "advance_directive_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN advance_directive_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registrations with advance directive on file - quality metric"
    - name: "duplicate_registration_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN duplicate_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registrations flagged as duplicates - data quality metric"
    - name: "avg_mpi_match_score"
      expr: AVG(CAST(mpi_match_score AS DOUBLE))
      comment: "Average MPI match confidence score for identity resolution quality"
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average registration data completeness score for quality monitoring"
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days for capacity planning"
    - name: "emergency_admission_count"
      expr: COUNT(DISTINCT CASE WHEN admission_type = 'Emergency' THEN registration_event_id END)
      comment: "Count of emergency admissions for resource allocation"
    - name: "vip_registration_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN registration_event_id END)
      comment: "Count of VIP patient registrations for special handling"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_insurance_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance coverage and eligibility metrics: verification rates, coverage gaps, and revenue cycle efficiency"
  source: "`vibe_healthcare_v1`.`patient`.`insurance_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of insurance coverage (active, inactive, pending)"
    - name: "network_status"
      expr: network_status
      comment: "Network status (in-network, out-of-network) for reimbursement analysis"
    - name: "cob_priority"
      expr: cob_priority
      comment: "Coordination of benefits priority (primary, secondary, tertiary)"
    - name: "eligibility_verification_status"
      expr: eligibility_verification_status
      comment: "Status of eligibility verification for revenue cycle monitoring"
    - name: "eligibility_verification_method"
      expr: eligibility_verification_method
      comment: "Method used for eligibility verification (real-time, batch, manual)"
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required"
    - name: "referral_required"
      expr: referral_required
      comment: "Whether referral is required for services"
    - name: "medicare_part"
      expr: medicare_part
      comment: "Medicare part (A, B, C, D) for Medicare population analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year coverage became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month coverage became effective for enrollment trends"
    - name: "benefit_year"
      expr: YEAR(benefit_year_start)
      comment: "Benefit year for deductible and out-of-pocket tracking"
  measures:
    - name: "total_coverage_count"
      expr: COUNT(DISTINCT insurance_coverage_id)
      comment: "Total count of insurance coverage records"
    - name: "active_coverage_count"
      expr: COUNT(DISTINCT CASE WHEN coverage_status = 'Active' THEN insurance_coverage_id END)
      comment: "Count of active insurance coverages"
    - name: "eligibility_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN eligibility_verification_status = 'Verified' THEN insurance_coverage_id END) / NULLIF(COUNT(DISTINCT insurance_coverage_id), 0), 2)
      comment: "Percentage of coverages with verified eligibility - critical revenue cycle metric"
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN prior_auth_required = TRUE THEN insurance_coverage_id END) / NULLIF(COUNT(DISTINCT insurance_coverage_id), 0), 2)
      comment: "Percentage of coverages requiring prior authorization for workflow planning"
    - name: "referral_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_required = TRUE THEN insurance_coverage_id END) / NULLIF(COUNT(DISTINCT insurance_coverage_id), 0), 2)
      comment: "Percentage of coverages requiring referrals for access management"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount for patient financial counseling"
    - name: "avg_deductible_met_amount"
      expr: AVG(CAST(deductible_met_amount AS DOUBLE))
      comment: "Average amount of deductible already met"
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum for financial risk assessment"
    - name: "avg_out_of_pocket_met"
      expr: AVG(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Average out-of-pocket amount already met"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount for patient cost estimation"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance percentage for cost-sharing analysis"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amount across all coverages"
    - name: "total_deductible_met_amount"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible amount met across all coverages"
    - name: "in_network_coverage_count"
      expr: COUNT(DISTINCT CASE WHEN network_status = 'In-Network' THEN insurance_coverage_id END)
      comment: "Count of in-network coverages for network adequacy monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary care attribution and value-based care metrics: panel management, risk stratification, and quality program participation"
  source: "`vibe_healthcare_v1`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current status of PCP attribution (active, pending, terminated)"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used for attribution (claims-based, enrollment, visit-based)"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source of attribution data (payer, internal, HIE)"
    - name: "is_primary_attribution"
      expr: is_primary_attribution
      comment: "Whether this is the primary attribution relationship"
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier (low, medium, high, very high) for care management prioritization"
    - name: "care_management_enrolled"
      expr: care_management_enrolled
      comment: "Whether patient is enrolled in care management program"
    - name: "hedis_eligible"
      expr: hedis_eligible
      comment: "Whether patient is eligible for HEDIS quality measures"
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Whether patient is eligible for MIPS quality reporting"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (HMO, PPO, ACO, Medicare Advantage)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for population health analysis"
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Social determinants of health flag for targeted interventions"
    - name: "data_sharing_opt_out"
      expr: data_sharing_opt_out
      comment: "Whether patient opted out of data sharing"
    - name: "measurement_year"
      expr: measurement_year
      comment: "Quality measurement year for performance tracking"
    - name: "attribution_year"
      expr: YEAR(effective_date)
      comment: "Year attribution became effective"
    - name: "attribution_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month attribution became effective for panel growth tracking"
  measures:
    - name: "total_attributed_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Total count of attributed patients for panel size tracking"
    - name: "active_attribution_count"
      expr: COUNT(DISTINCT CASE WHEN attribution_status = 'Active' THEN pcp_attribution_id END)
      comment: "Count of active attribution relationships"
    - name: "primary_attribution_count"
      expr: COUNT(DISTINCT CASE WHEN is_primary_attribution = TRUE THEN mpi_record_id END)
      comment: "Count of patients with primary PCP attribution"
    - name: "care_management_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN care_management_enrolled = TRUE THEN mpi_record_id END) / NULLIF(COUNT(DISTINCT mpi_record_id), 0), 2)
      comment: "Percentage of attributed patients enrolled in care management - key value-based care metric"
    - name: "hedis_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hedis_eligible = TRUE THEN mpi_record_id END) / NULLIF(COUNT(DISTINCT mpi_record_id), 0), 2)
      comment: "Percentage of patients eligible for HEDIS quality measures"
    - name: "mips_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN mpi_record_id END) / NULLIF(COUNT(DISTINCT mpi_record_id), 0), 2)
      comment: "Percentage of patients eligible for MIPS reporting"
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_risk_score AS DOUBLE))
      comment: "Average HCC risk score for population risk assessment and capitation"
    - name: "avg_attribution_confidence_score"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average attribution confidence score for data quality monitoring"
    - name: "high_risk_patient_count"
      expr: COUNT(DISTINCT CASE WHEN risk_stratification_tier IN ('High', 'Very High') THEN mpi_record_id END)
      comment: "Count of high-risk patients requiring intensive care management"
    - name: "sdoh_flagged_patient_count"
      expr: COUNT(DISTINCT CASE WHEN sdoh_flag = TRUE THEN mpi_record_id END)
      comment: "Count of patients with social determinants of health needs"
    - name: "data_sharing_opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_sharing_opt_out = TRUE THEN mpi_record_id END) / NULLIF(COUNT(DISTINCT mpi_record_id), 0), 2)
      comment: "Percentage of patients who opted out of data sharing - privacy compliance metric"
    - name: "avg_visit_count_lookback"
      expr: AVG(CAST(visit_count_lookback AS DOUBLE))
      comment: "Average visit count in lookback period for engagement assessment"
    - name: "total_hcc_risk_score"
      expr: SUM(CAST(hcc_risk_score AS DOUBLE))
      comment: "Total HCC risk score across attributed population for capitation calculation"
    - name: "unique_pcp_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique PCPs with attributed patients for provider network analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time eligibility verification metrics: verification success rates, rejection analysis, and revenue cycle efficiency"
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of eligibility verification (verified, rejected, pending, error)"
    - name: "verification_type"
      expr: verification_type
      comment: "Type of verification (real-time, batch, manual)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (270/271, portal, phone)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage being verified"
    - name: "network_status"
      expr: network_status
      comment: "Network status result (in-network, out-of-network, unknown)"
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required"
    - name: "referral_required"
      expr: referral_required
      comment: "Whether referral is required"
    - name: "coordination_of_benefits_flag"
      expr: coordination_of_benefits_flag
      comment: "Whether coordination of benefits applies"
    - name: "is_override"
      expr: is_override
      comment: "Whether verification was manually overridden"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code for rejection reason for root cause analysis"
    - name: "clearinghouse_name"
      expr: clearinghouse_name
      comment: "Clearinghouse used for verification for vendor performance tracking"
    - name: "service_date"
      expr: service_date
      comment: "Date of service for which eligibility was checked"
    - name: "verification_year"
      expr: YEAR(verification_timestamp)
      comment: "Year of verification for trend analysis"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_timestamp)
      comment: "Month of verification for volume tracking"
  measures:
    - name: "total_eligibility_check_count"
      expr: COUNT(DISTINCT eligibility_check_id)
      comment: "Total count of eligibility verification attempts"
    - name: "unique_patient_verified_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of unique patients with eligibility checks"
    - name: "verification_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN eligibility_check_id END) / NULLIF(COUNT(DISTINCT eligibility_check_id), 0), 2)
      comment: "Percentage of successful eligibility verifications - critical revenue cycle KPI"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'Rejected' THEN eligibility_check_id END) / NULLIF(COUNT(DISTINCT eligibility_check_id), 0), 2)
      comment: "Percentage of rejected eligibility checks for process improvement"
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_override = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(DISTINCT eligibility_check_id), 0), 2)
      comment: "Percentage of verifications requiring manual override - workflow efficiency metric"
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN prior_auth_required = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(DISTINCT eligibility_check_id), 0), 2)
      comment: "Percentage of checks requiring prior authorization for workflow planning"
    - name: "referral_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_required = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(DISTINCT eligibility_check_id), 0), 2)
      comment: "Percentage of checks requiring referral for access management"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount for patient cost estimation"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percent AS DOUBLE))
      comment: "Average coinsurance percentage for patient financial counseling"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount"
    - name: "avg_deductible_met"
      expr: AVG(CAST(individual_deductible_met_amount AS DOUBLE))
      comment: "Average deductible amount already met"
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(individual_out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum for financial risk assessment"
    - name: "avg_out_of_pocket_met"
      expr: AVG(CAST(individual_out_of_pocket_met AS DOUBLE))
      comment: "Average out-of-pocket amount already met"
    - name: "real_time_verification_count"
      expr: COUNT(DISTINCT CASE WHEN verification_type = 'Real-Time' THEN eligibility_check_id END)
      comment: "Count of real-time verifications for automation tracking"
    - name: "in_network_verification_count"
      expr: COUNT(DISTINCT CASE WHEN network_status = 'In-Network' THEN eligibility_check_id END)
      comment: "Count of in-network verifications for network adequacy"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_guarantor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial guarantor and patient account metrics: collections performance, payment plan effectiveness, and bad debt management"
  source: "`vibe_healthcare_v1`.`patient`.`guarantor`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of guarantor account (active, closed, collections)"
    - name: "guarantor_type"
      expr: guarantor_type
      comment: "Type of guarantor (self, spouse, parent, other)"
    - name: "relationship_to_patient"
      expr: relationship_to_patient
      comment: "Relationship of guarantor to patient"
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status for financial assessment"
    - name: "financial_assistance_status"
      expr: financial_assistance_status
      comment: "Status of financial assistance application"
    - name: "financial_assistance_type"
      expr: financial_assistance_type
      comment: "Type of financial assistance (charity care, discount, payment plan)"
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Whether guarantor is on a payment plan"
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Whether account is flagged as bad debt"
    - name: "collection_agency_flag"
      expr: collection_agency_flag
      comment: "Whether account has been sent to collections"
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Whether guarantor has declared bankruptcy"
    - name: "do_not_contact_flag"
      expr: do_not_contact_flag
      comment: "Whether guarantor requested no contact"
    - name: "estatement_consent_flag"
      expr: estatement_consent_flag
      comment: "Whether guarantor consented to electronic statements"
    - name: "sms_consent_flag"
      expr: sms_consent_flag
      comment: "Whether guarantor consented to SMS communications"
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Whether guarantor is deceased"
    - name: "since_year"
      expr: YEAR(since_date)
      comment: "Year guarantor relationship began"
  measures:
    - name: "total_guarantor_count"
      expr: COUNT(DISTINCT guarantor_id)
      comment: "Total count of guarantor accounts"
    - name: "unique_patient_with_guarantor_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of unique patients with guarantor records"
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding account balance across all guarantors - key AR metric"
    - name: "avg_account_balance"
      expr: AVG(CAST(account_balance AS DOUBLE))
      comment: "Average account balance per guarantor"
    - name: "total_annual_income"
      expr: SUM(CAST(annual_income AS DOUBLE))
      comment: "Total annual income across guarantor population"
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income for financial assistance eligibility assessment"
    - name: "avg_federal_poverty_level_pct"
      expr: AVG(CAST(federal_poverty_level_pct AS DOUBLE))
      comment: "Average federal poverty level percentage for charity care qualification"
    - name: "avg_responsibility_pct"
      expr: AVG(CAST(responsibility_pct AS DOUBLE))
      comment: "Average percentage of financial responsibility"
    - name: "payment_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN payment_plan_flag = TRUE THEN guarantor_id END) / NULLIF(COUNT(DISTINCT guarantor_id), 0), 2)
      comment: "Percentage of guarantors on payment plans - collections strategy metric"
    - name: "bad_debt_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN bad_debt_flag = TRUE THEN guarantor_id END) / NULLIF(COUNT(DISTINCT guarantor_id), 0), 2)
      comment: "Percentage of accounts flagged as bad debt - financial risk metric"
    - name: "collection_agency_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN collection_agency_flag = TRUE THEN guarantor_id END) / NULLIF(COUNT(DISTINCT guarantor_id), 0), 2)
      comment: "Percentage of accounts sent to collections - revenue cycle performance metric"
    - name: "bankruptcy_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN bankruptcy_flag = TRUE THEN guarantor_id END) / NULLIF(COUNT(DISTINCT guarantor_id), 0), 2)
      comment: "Percentage of guarantors with bankruptcy - write-off risk metric"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total amount of last payments received"
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average last payment amount for payment behavior analysis"
    - name: "avg_payment_plan_amount"
      expr: AVG(CAST(payment_plan_amount AS DOUBLE))
      comment: "Average payment plan installment amount"
    - name: "estatement_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN estatement_consent_flag = TRUE THEN guarantor_id END) / NULLIF(COUNT(DISTINCT guarantor_id), 0), 2)
      comment: "Percentage of guarantors using electronic statements - cost reduction metric"
$$;