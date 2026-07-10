-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_sdoh_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH referral throughput and closed-loop performance KPIs — measures how effectively identified social needs are routed to community resources and resolved."
  source: "`vibe_healthcare_v1`.`patient`.`sdoh_referral`"
  dimensions:
    - name: "referral_year_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month bucket of the referral creation date for trending referral volume over time."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "Social determinant domain (housing, food, transportation, etc.) the referral addresses."
    - name: "referral_status"
      expr: referral_status
      comment: "Current lifecycle status of the referral (sent, accepted, closed, declined)."
    - name: "referral_priority"
      expr: referral_priority
      comment: "Assigned priority/urgency of the referral for triage analysis."
    - name: "referral_platform"
      expr: referral_platform
      comment: "Closed-loop referral platform used to route the referral (e.g. Unite Us, Aunt Bertha)."
  measures:
    - name: "Total Referrals"
      expr: COUNT(1)
      comment: "Total count of SDOH referrals — baseline volume for social-needs routing."
    - name: "Closed Loop Referrals"
      expr: SUM(CASE WHEN closed_loop_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of referrals confirmed closed-loop; the core outcome of SDOH intervention programs."
    - name: "Closed Loop Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_loop_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals reaching closed-loop resolution — key equity/quality steering metric."
    - name: "Accepted Referrals"
      expr: SUM(CASE WHEN accepted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of referrals accepted by the receiving organization; measures community partner engagement."
    - name: "Declined Referrals"
      expr: SUM(CASE WHEN declined_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of declined referrals; flags network adequacy or eligibility gaps."
    - name: "Avg Referral Priority Score"
      expr: ROUND(AVG(CAST(priority_score AS DOUBLE)), 2)
      comment: "Average priority score across referrals; indicates acuity of the social-needs population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH screening coverage and positivity KPIs — measures how many patients are screened and the prevalence of unmet social needs."
  source: "`vibe_healthcare_v1`.`patient`.`sdoh_assessment`"
  dimensions:
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month bucket of the assessment date for trending screening volume."
    - name: "assessment_setting"
      expr: assessment_setting
      comment: "Care setting where the screening occurred (inpatient, ED, clinic)."
    - name: "overall_risk_level"
      expr: overall_risk_level
      comment: "Overall SDOH risk stratification level derived from the assessment."
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier bucket for population stratification."
  measures:
    - name: "Total Assessments"
      expr: COUNT(1)
      comment: "Total SDOH screenings completed — baseline screening throughput."
    - name: "Patients Screened"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients screened for social needs; core screening-coverage metric for value-based programs."
    - name: "Positive Housing Instability"
      expr: SUM(CASE WHEN housing_instability_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings positive for housing instability; drives housing intervention resourcing."
    - name: "Positive Food Insecurity"
      expr: SUM(CASE WHEN food_insecurity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings positive for food insecurity; drives food-support program resourcing."
    - name: "Any Positive Domain Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_program_enrolled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of screened patients enrolled into a care program post-assessment — screening-to-action conversion."
    - name: "Avg Priority Score"
      expr: ROUND(AVG(CAST(priority_score AS DOUBLE)), 2)
      comment: "Average assessment priority score; indicates acuity of screened population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program enrollment KPIs — measures enrollment volume, consent compliance, and disenrollment across chronic-care and value-based programs."
  source: "`vibe_healthcare_v1`.`patient`.`care_program_enrollment`"
  dimensions:
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month bucket of enrollment date for trending program growth."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment lifecycle status (active, disenrolled, pending)."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel that generated the enrollment (referral, auto-attribution)."
    - name: "value_based_contract_type"
      expr: value_based_contract_type
      comment: "Value-based contract type tied to the enrollment for VBC program analysis."
  measures:
    - name: "Total Enrollments"
      expr: COUNT(1)
      comment: "Total care-program enrollment records — baseline program participation volume."
    - name: "Enrolled Patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients enrolled in care programs; core panel-size metric."
    - name: "Consent Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments with documented consent — regulatory compliance steering metric."
    - name: "Disenrolled Count"
      expr: SUM(CASE WHEN enrollment_status = 'disenrolled' THEN 1 ELSE 0 END)
      comment: "Count of disenrollments; monitors program retention/churn."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance eligibility verification KPIs — measures verification success, prior-auth burden, and patient financial exposure at point of service."
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "service_year_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month bucket of service date for trending eligibility volume."
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the eligibility verification (verified, rejected, pending)."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs out-of-network status for benefit steering."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (commercial, Medicare, Medicaid) for payer-mix analysis."
  measures:
    - name: "Total Eligibility Checks"
      expr: COUNT(1)
      comment: "Total eligibility verification transactions — baseline revenue-cycle front-end volume."
    - name: "Verification Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of checks successfully verified — front-end revenue-cycle quality metric that predicts clean-claim rate."
    - name: "Prior Auth Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_auth_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of checks requiring prior authorization — quantifies administrative burden and denial risk."
    - name: "Avg Copay Amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average patient copay at point of service; informs patient financial-responsibility estimates."
    - name: "Avg Individual Deductible Remaining"
      expr: ROUND(AVG(CAST(individual_deductible_amount AS DOUBLE) - CAST(individual_deductible_met_amount AS DOUBLE)), 2)
      comment: "Average remaining individual deductible; drives point-of-service collection strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_financial_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity care / financial assistance KPIs — measures application throughput, approval rates, and community-benefit dollars provided."
  source: "`vibe_healthcare_v1`.`patient`.`financial_assistance`"
  dimensions:
    - name: "application_year_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month bucket of application date for trending assistance demand."
    - name: "application_status"
      expr: application_status
      comment: "Current application lifecycle status (approved, denied, pending)."
    - name: "program_type"
      expr: program_type
      comment: "Financial assistance program type for community-benefit categorization."
    - name: "community_benefit_category"
      expr: community_benefit_category
      comment: "IRS 990 Schedule H community-benefit category for regulatory reporting."
  measures:
    - name: "Total Applications"
      expr: COUNT(1)
      comment: "Total financial-assistance applications — baseline charity-care demand."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN application_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of applications approved — access-to-care and financial-policy steering metric."
    - name: "Total Approved Assistance"
      expr: ROUND(SUM(CAST(approved_assistance_amount AS DOUBLE)), 2)
      comment: "Total dollars of approved financial assistance — direct community-benefit spend."
    - name: "Total Write Off"
      expr: ROUND(SUM(CAST(write_off_amount AS DOUBLE)), 2)
      comment: "Total charity write-off amount; feeds community-benefit reporting and margin analysis."
    - name: "Avg Approved Discount Pct"
      expr: ROUND(AVG(CAST(approved_discount_percentage AS DOUBLE)), 2)
      comment: "Average approved discount percentage; monitors financial-policy consistency."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_communication_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient outreach effectiveness KPIs — measures delivery, engagement, and opt-out across patient communications and care-gap outreach."
  source: "`vibe_healthcare_v1`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_year_month"
      expr: DATE_TRUNC('MONTH', communication_date)
      comment: "Month bucket of communication date for trending outreach volume."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Delivery channel (SMS, email, phone, portal) for channel-effectiveness analysis."
    - name: "communication_type"
      expr: communication_type
      comment: "Communication purpose/type for campaign categorization."
    - name: "communication_direction"
      expr: communication_direction
      comment: "Inbound vs outbound direction of the communication."
  measures:
    - name: "Total Communications"
      expr: COUNT(1)
      comment: "Total patient communications sent/received — baseline outreach volume."
    - name: "Delivery Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of communications successfully delivered — measures contact-data quality and channel reliability."
    - name: "Open Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN opened_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of delivered communications opened — patient engagement steering metric."
    - name: "Response Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_response_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of communications generating a patient response — actionable engagement metric for outreach programs."
    - name: "Opt Out Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of communications resulting in opt-out — monitors outreach fatigue and consent risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_quality_measure_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality measure / care-gap performance KPIs — measures numerator compliance and gap closure central to HEDIS/MIPS value-based contracts."
  source: "`vibe_healthcare_v1`.`patient`.`quality_measure_evaluation`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the quality measure evaluation."
    - name: "gap_status"
      expr: gap_status
      comment: "Current care-gap status (open, closed, excluded)."
    - name: "data_source"
      expr: data_source
      comment: "Source of the evaluation data (claims, EHR, supplemental) for data-completeness analysis."
  measures:
    - name: "Total Evaluations"
      expr: COUNT(1)
      comment: "Total quality-measure evaluation records — baseline measure population."
    - name: "Denominator Eligible Count"
      expr: SUM(CASE WHEN denominator_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients eligible for the measure denominator; the population at risk for a gap."
    - name: "Numerator Compliant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN numerator_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent numerator-compliant — the core quality-measure performance rate driving VBC bonuses/penalties."
    - name: "Care Gap Closure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_gap_closed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of open care gaps closed — actionable population-health steering metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient registration quality KPIs — measures data completeness, eligibility verification, and duplicate/MPI-match performance at intake."
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "registration_year_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month bucket of registration date for trending intake volume."
    - name: "event_type"
      expr: event_type
      comment: "Registration event type (new, update, pre-registration)."
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class assigned at registration for payer-mix analysis."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which registration occurred (front desk, online, kiosk)."
  measures:
    - name: "Total Registrations"
      expr: COUNT(1)
      comment: "Total registration events — baseline patient-access volume."
    - name: "Avg Completeness Score"
      expr: ROUND(AVG(CAST(completeness_score AS DOUBLE)), 2)
      comment: "Average registration data-completeness score — front-end data-quality steering metric."
    - name: "Eligibility Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN eligibility_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of registrations with verified eligibility — predicts downstream denial risk."
    - name: "Duplicate Flag Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN duplicate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of registrations flagged as duplicate — measures MPI/identity data-integrity risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal engagement KPIs — measures activation, identity verification, and 2FA adoption central to digital-health strategy."
  source: "`vibe_healthcare_v1`.`patient`.`portal_account`"
  dimensions:
    - name: "activation_year_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month bucket of activation date for trending portal adoption."
    - name: "account_status"
      expr: account_status
      comment: "Current portal account status (active, deactivated, pending)."
    - name: "portal_platform"
      expr: portal_platform
      comment: "Portal platform used (MyChart, etc.) for vendor-mix analysis."
  measures:
    - name: "Total Portal Accounts"
      expr: COUNT(1)
      comment: "Total portal accounts — baseline digital-enrollment volume."
    - name: "Active Portal Patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with a portal account; core digital-adoption metric."
    - name: "Identity Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN identity_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of accounts with verified identity — security/compliance steering metric."
    - name: "Two Factor Adoption Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN two_factor_auth_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of accounts enrolled in 2FA — measures digital-security posture."
    - name: "Messaging Opt In Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN messaging_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent opted into secure messaging — drives digital-engagement outreach eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_population_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health risk-stratification KPIs — measures risk scores, chronic-condition burden, and care-gap load for panel management."
  source: "`vibe_healthcare_v1`.`patient`.`population_segment`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the population segment stratification."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk-tier bucket (high/medium/low) for panel stratification."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of population segment for cohort categorization."
    - name: "predicted_utilization_tier"
      expr: predicted_utilization_tier
      comment: "Predicted utilization tier for resource-planning analysis."
  measures:
    - name: "Total Segment Members"
      expr: COUNT(1)
      comment: "Total population-segment member records — baseline panel size."
    - name: "Avg HCC Risk Score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 2)
      comment: "Average HCC risk score across the panel — drives risk-adjusted revenue and care-management targeting."
    - name: "Avg Risk Score Percentile"
      expr: ROUND(AVG(CAST(risk_score_percentile AS DOUBLE)), 2)
      comment: "Average risk-score percentile; benchmarks panel acuity."
    - name: "Readmission Risk Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of members flagged high readmission risk — targets transitional-care resourcing."
    - name: "Care Management Enrollment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_management_enrollment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of at-risk members enrolled in care management — measures program penetration into high-risk cohorts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_sdoh_need_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH need closed-loop resolution KPIs — measures how identified social needs are resolved and time-to-closure for equity programs."
  source: "`vibe_healthcare_v1`.`patient`.`sdoh_need_closure`"
  dimensions:
    - name: "identified_year_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month bucket of need identification for trending social-need volume."
    - name: "need_category"
      expr: need_category
      comment: "Category of the social need (housing, food, utilities) for domain analysis."
    - name: "need_status"
      expr: need_status
      comment: "Current status of the identified need (open, resolved, closed)."
    - name: "need_severity"
      expr: need_severity
      comment: "Severity of the social need for acuity analysis."
  measures:
    - name: "Total Needs"
      expr: COUNT(1)
      comment: "Total identified social needs — baseline unmet-need volume."
    - name: "Closed Loop Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_loop_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of needs reaching closed-loop resolution — core equity/quality outcome metric."
    - name: "Need Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN need_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of needs confirmed met; measures true social-needs impact beyond referral."
    - name: "Avg Days To Closure"
      expr: ROUND(AVG(CAST(days_to_closure AS DOUBLE)), 2)
      comment: "Average days from identification to closure — operational efficiency of the social-care workflow."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_identity_merge_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MPI identity-merge integrity KPIs — measures merge confidence, patient-safety impact, and PHI-breach risk from record consolidation."
  source: "`vibe_healthcare_v1`.`patient`.`identity_merge_history`"
  dimensions:
    - name: "merge_year_month"
      expr: DATE_TRUNC('MONTH', merge_timestamp)
      comment: "Month bucket of merge event for trending merge volume."
    - name: "merge_event_type"
      expr: merge_event_type
      comment: "Type of merge event (merge, unmerge, overlay) for MPI-operations analysis."
    - name: "merge_status"
      expr: merge_status
      comment: "Current status of the merge event."
    - name: "duplicate_detection_method"
      expr: duplicate_detection_method
      comment: "Method used to detect the duplicate for algorithm-effectiveness analysis."
  measures:
    - name: "Total Merge Events"
      expr: COUNT(1)
      comment: "Total identity-merge events — baseline MPI-maintenance volume."
    - name: "Avg Merge Confidence Score"
      expr: ROUND(AVG(CAST(merge_confidence_score AS DOUBLE)), 2)
      comment: "Average merge confidence score — data-integrity quality metric for the MPI algorithm."
    - name: "Patient Safety Impact Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of merges flagged for patient-safety impact — critical HIM risk-management metric."
    - name: "PHI Disclosure Risk Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN phi_disclosure_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of merges with PHI-disclosure risk — HIPAA breach-exposure steering metric."
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