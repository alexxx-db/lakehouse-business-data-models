-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for population health / value-based care program enrollment: enrollment volume, retention, consent compliance, and care-gap burden that leadership uses to steer care management investment."
  source: "`vibe_healthcare_v1`.`patient`.`care_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current lifecycle status of the enrollment (active, disenrolled, pending) for cohort segmentation."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel/source that generated the enrollment for attribution analysis."
    - name: "value_based_contract_type"
      expr: value_based_contract_type
      comment: "Value-based contract type driving the enrollment (e.g., ACO, MSSP) for contract-level performance."
    - name: "program_outcome"
      expr: program_outcome
      comment: "Recorded program outcome for effectiveness segmentation."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Enrollment month for trending enrollment volume over time."
  measures:
    - name: "Enrollment Count"
      expr: COUNT(1)
      comment: "Total number of care program enrollments — baseline volume driving care-management staffing."
    - name: "Active Enrollment Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments currently active — retention health for value-based programs."
    - name: "Consent Obtained Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments with consent obtained — compliance KPI for program governance."
    - name: "Disenrollment Count"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END)
      comment: "Count of disenrolled members — attrition signal that triggers retention intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue-cycle KPIs for real-time insurance eligibility verification: verification success, prior-auth burden, and patient cost-share exposure that front-office and RCM leaders monitor."
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the eligibility verification (verified, rejected, pending) for denial-prevention analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type checked (commercial, Medicare, Medicaid) for payer-mix segmentation."
    - name: "network_status"
      expr: network_status
      comment: "In/out-of-network status for network steerage analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used (electronic 270/271, phone, portal) for automation efficiency tracking."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Service month for trending eligibility activity."
  measures:
    - name: "Eligibility Check Count"
      expr: COUNT(1)
      comment: "Total eligibility checks performed — front-end revenue-cycle throughput."
    - name: "Verified Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of checks successfully verified — front-end denial-prevention KPI."
    - name: "Prior Auth Required Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_auth_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of services requiring prior authorization — administrative burden and scheduling-risk signal."
    - name: "Avg Copay Amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average patient copay exposure per checked service — patient financial-responsibility planning."
    - name: "Avg Individual Deductible Met"
      expr: ROUND(AVG(CAST(individual_deductible_met_amount AS DOUBLE)), 2)
      comment: "Average deductible met per patient — informs point-of-service collection strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_financial_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity-care and financial-assistance KPIs required for IRS 990 community-benefit reporting: application approval, discount generosity, and write-off exposure monitored by finance and compliance leadership."
  source: "`vibe_healthcare_v1`.`patient`.`financial_assistance`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the financial assistance application (approved, denied, pending) for pipeline management."
    - name: "program_type"
      expr: program_type
      comment: "Assistance program type (charity, sliding scale, Medicaid pending) for community-benefit categorization."
    - name: "community_benefit_category"
      expr: community_benefit_category
      comment: "Community benefit reporting category for IRS 990 Schedule H."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Application month for trending assistance demand."
  measures:
    - name: "Application Count"
      expr: COUNT(1)
      comment: "Total financial-assistance applications — demand indicator for charity-care programs."
    - name: "Approval Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of applications approved — access-to-care and process-fairness KPI."
    - name: "Total Approved Assistance Amount"
      expr: ROUND(SUM(CAST(approved_assistance_amount AS DOUBLE)), 2)
      comment: "Total dollars of assistance approved — direct community-benefit expenditure for 990 reporting."
    - name: "Total Write Off Amount"
      expr: ROUND(SUM(CAST(write_off_amount AS DOUBLE)), 2)
      comment: "Total charity write-offs — bad-debt vs charity classification and margin impact."
    - name: "Avg Approved Discount Pct"
      expr: ROUND(AVG(CAST(approved_discount_percentage AS DOUBLE)), 2)
      comment: "Average discount percentage granted — generosity level of assistance policy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_communication_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient outreach effectiveness KPIs: delivery success, opt-out attrition, and patient response engagement that population-health and marketing leaders use to steer outreach investment."
  source: "`vibe_healthcare_v1`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_channel"
      expr: communication_channel
      comment: "Outreach channel (SMS, email, phone, portal) for channel effectiveness comparison."
    - name: "communication_type"
      expr: communication_type
      comment: "Purpose of communication (care gap, appointment, billing) for campaign segmentation."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome (delivered, failed, bounced) for deliverability monitoring."
    - name: "communication_month"
      expr: DATE_TRUNC('MONTH', communication_date)
      comment: "Communication month for trending outreach volume."
  measures:
    - name: "Communication Count"
      expr: COUNT(1)
      comment: "Total patient communications sent — outreach throughput baseline."
    - name: "Distinct Patients Contacted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients reached — true outreach coverage without message double-counting."
    - name: "Delivery Success Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'Delivered' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of messages successfully delivered — deliverability KPI driving channel/data-quality action."
    - name: "Patient Response Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_response_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of communications eliciting a patient response — engagement effectiveness."
    - name: "Opt Out Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of contacts resulting in opt-out — outreach fatigue / compliance risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master patient index data-quality KPIs: duplicate/overlay rates and identity-match confidence that HIM leadership and patient-safety officers monitor to protect identity integrity."
  source: "`vibe_healthcare_v1`.`patient`.`mpi_record`"
  dimensions:
    - name: "identity_resolution_status"
      expr: identity_resolution_status
      comment: "Identity resolution status of the MPI record for data-quality segmentation."
    - name: "identity_confidence_tier"
      expr: identity_confidence_tier
      comment: "Confidence tier of the identity match for review prioritization."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class of the record for population segmentation."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', first_registration_date)
      comment: "First registration month for MPI growth trending."
  measures:
    - name: "MPI Record Count"
      expr: COUNT(1)
      comment: "Total master patient index records — size of the enterprise identity base."
    - name: "Duplicate Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records flagged duplicate — HIM data-quality KPI driving cleanup effort."
    - name: "Overlay Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overlay_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records flagged as overlays — critical patient-safety risk indicator."
    - name: "Avg Match Confidence Score"
      expr: ROUND(AVG(CAST(match_confidence_score AS DOUBLE)), 2)
      comment: "Average identity match confidence — overall MPI algorithm quality signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_population_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-stratification KPIs for value-based care: population risk burden and care-gap/utilization risk that population-health leaders use to target care-management resources."
  source: "`vibe_healthcare_v1`.`patient`.`population_segment`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Assigned risk tier (high/medium/low) for stratified care-management targeting."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of population segment for cohort analysis."
    - name: "payer_product_type"
      expr: payer_product_type
      comment: "Payer product type for value-based contract segmentation."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance measurement year for year-over-year risk comparison."
  measures:
    - name: "Segment Member Count"
      expr: COUNT(1)
      comment: "Total members in population segments — sizing of managed populations."
    - name: "Avg HCC Risk Score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 4)
      comment: "Average HCC risk score — risk-adjustment revenue and acuity indicator."
    - name: "Avg Risk Score"
      expr: ROUND(AVG(CAST(risk_score AS DOUBLE)), 4)
      comment: "Average predictive risk score — population acuity for resource planning."
    - name: "ED Utilization Risk Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ed_utilization_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged for high ED-utilization risk — target list for proactive intervention."
    - name: "Readmission Risk Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged at readmission risk — drives transitional-care resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_quality_measure_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS/quality care-gap KPIs: measure compliance and gap closure that quality leadership reports on VBC and STAR performance dashboards."
  source: "`vibe_healthcare_v1`.`patient`.`quality_measure_evaluation`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Care gap status (open, closed) for gap-closure workflow tracking."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for HEDIS/STAR reporting period segmentation."
    - name: "data_source"
      expr: data_source
      comment: "Data source of the evaluation (claims, EHR, supplemental) for quality-data governance."
  measures:
    - name: "Evaluation Count"
      expr: COUNT(1)
      comment: "Total quality measure evaluations — volume of gap assessments."
    - name: "Numerator Compliance Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN numerator_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent numerator-compliant — the core HEDIS/STAR quality-measure rate steering VBC bonuses."
    - name: "Gap Closure Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of care gaps closed — operational effectiveness of gap-closure programs."
    - name: "Outreach Attempt Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outreach_attempted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of open gaps with outreach attempted — care-management activity coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social determinants of health screening KPIs required for CMS/health-equity reporting: screening completion, positive-need identification, and referral follow-through monitored by population-health equity teams."
  source: "`vibe_healthcare_v1`.`patient`.`sdoh_assessment`"
  dimensions:
    - name: "overall_risk_level"
      expr: overall_risk_level
      comment: "Overall SDOH risk level for equity stratification."
    - name: "assessment_setting"
      expr: assessment_setting
      comment: "Setting where screening occurred (inpatient, ambulatory) for workflow analysis."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Disposition of SDOH referral for closed-loop-referral tracking."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Assessment month for screening-volume trending."
  measures:
    - name: "Assessment Count"
      expr: COUNT(1)
      comment: "Total SDOH assessments completed — screening throughput for CMS measure denominators."
    - name: "Food Insecurity Positive Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN food_insecurity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent screening positive for food insecurity — community-need signal for resource partnerships."
    - name: "Housing Instability Positive Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN housing_instability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent screening positive for housing instability — high-priority equity intervention driver."
    - name: "Referral Made Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments resulting in a referral — closed-loop follow-through KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient digital-engagement KPIs required for Meaningful Use/Promoting Interoperability: portal activation, identity verification, and 2FA security adoption tracked by digital-health and compliance leaders."
  source: "`vibe_healthcare_v1`.`patient`.`portal_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Portal account status (active, inactive, deactivated) for engagement segmentation."
    - name: "portal_platform"
      expr: portal_platform
      comment: "Portal platform for platform-adoption comparison."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Activation month for portal-adoption trending."
  measures:
    - name: "Portal Account Count"
      expr: COUNT(1)
      comment: "Total portal accounts — size of digitally engaged patient base."
    - name: "Active Account Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN account_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of active accounts — engagement retention KPI for PI reporting."
    - name: "Identity Verified Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN identity_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of accounts with verified identity — security/compliance assurance."
    - name: "Two Factor Adoption Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN two_factor_auth_enrolled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent enrolled in 2FA — cybersecurity posture for patient-facing systems."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient access / registration integrity KPIs: eligibility verification at registration, consent capture, and data completeness that patient-access leadership uses to reduce downstream denials."
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Registration event type (admit, pre-reg, update) for access-workflow segmentation."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient, outpatient, ED) for volume-mix analysis."
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class for payer-mix analysis at registration."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Registration month for volume trending."
  measures:
    - name: "Registration Event Count"
      expr: COUNT(1)
      comment: "Total registration events — patient-access throughput baseline."
    - name: "Eligibility Verified Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of registrations with verified eligibility — front-end denial-prevention KPI."
    - name: "Consent Obtained Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with consent captured at registration — compliance completeness."
    - name: "Avg Completeness Score"
      expr: ROUND(AVG(CAST(completeness_score AS DOUBLE)), 2)
      comment: "Average registration data-completeness score — data-quality KPI reducing downstream rework."
    - name: "Duplicate Registration Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged as duplicate registrations — MPI integrity and rework signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_guarantor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Self-pay / patient-financial-responsibility KPIs: outstanding account balances, bad-debt exposure, and payment-plan adoption monitored by patient financial services leadership."
  source: "`vibe_healthcare_v1`.`patient`.`guarantor`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Guarantor account status for AR segmentation."
    - name: "guarantor_type"
      expr: guarantor_type
      comment: "Guarantor type (self, parent, organization) for responsibility analysis."
    - name: "financial_assistance_status"
      expr: financial_assistance_status
      comment: "Financial-assistance status for charity vs self-pay segmentation."
  measures:
    - name: "Guarantor Count"
      expr: COUNT(1)
      comment: "Total guarantor accounts — size of the patient-responsibility book."
    - name: "Total Account Balance"
      expr: ROUND(SUM(CAST(account_balance AS DOUBLE)), 2)
      comment: "Total outstanding guarantor balance — self-pay AR exposure steering collections strategy."
    - name: "Avg Account Balance"
      expr: ROUND(AVG(CAST(account_balance AS DOUBLE)), 2)
      comment: "Average balance per guarantor — patient affordability and payment-plan sizing."
    - name: "Bad Debt Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bad_debt_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of accounts flagged bad-debt — write-off risk KPI."
    - name: "Payment Plan Adoption Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_plan_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of guarantors on payment plans — collection-friendliness and recovery-likelihood indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_communication_success`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness of patient communications across channels"
  source: "`vibe_healthcare_v1`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for communication (e.g., SMS, Email)"
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (e.g., reminder, alert)"
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total communication log entries"
    - name: "delivered_message_count"
      expr: SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Number of messages successfully delivered"
    - name: "consented_message_count"
      expr: SUM(CASE WHEN consent_obtained_flag THEN 1 ELSE 0 END)
      comment: "Number of messages sent where patient consent was obtained"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core patient population broken down by key demographic attributes"
  source: "`vibe_healthcare_v1`.`patient`.`demographics`"
  dimensions:
    - name: "gender_identity"
      expr: gender_identity
      comment: "Self‑identified gender of the patient"
    - name: "race_code"
      expr: race_code
      comment: "Race classification code"
    - name: "age_bucket"
      expr: FLOOR(DATEDIFF(current_date(), birth_date) / 365)
      comment: "Patient age in years, bucketed as integer years"
  measures:
    - name: "patient_count"
      expr: COUNT(1)
      comment: "Total number of patients in the demographics table"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_flag_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical flag monitoring for safety and quality"
  source: "`vibe_healthcare_v1`.`patient`.`flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Category of the flag (e.g., allergy, infection)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the flag"
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the flag (Active, Resolved)"
  measures:
    - name: "total_flags"
      expr: COUNT(1)
      comment: "Total number of clinical flags recorded"
    - name: "active_flag_count"
      expr: SUM(CASE WHEN flag_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of flags currently active"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_population_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk stratification metrics for population management"
  source: "`vibe_healthcare_v1`.`patient`.`population_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Logical segment classification (e.g., chronic, acute)"
  measures:
    - name: "total_patients"
      expr: COUNT(1)
      comment: "Total patients in the population segment table"
    - name: "high_risk_patient_count"
      expr: SUM(CASE WHEN hcc_risk_score > 20 THEN 1 ELSE 0 END)
      comment: "Count of patients with HCC risk score above 20 (high risk)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall risk score for the segment"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_expected_los`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length‑of‑stay planning KPI derived from registration events"
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the patient was admitted"
    - name: "admission_type"
      expr: admission_type
      comment: "Admission classification (e.g., emergency, elective)"
  measures:
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay (in days) across admissions"
    - name: "total_expected_los_days"
      expr: SUM(CAST(expected_los_days AS DOUBLE))
      comment: "Total expected length of stay (in days) for all admissions"
$$;