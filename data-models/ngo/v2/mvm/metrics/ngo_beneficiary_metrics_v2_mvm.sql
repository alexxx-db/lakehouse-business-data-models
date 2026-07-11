-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for beneficiary registrant population — tracks registration quality, vulnerability distribution, deduplication health, and demographic composition to steer targeting and resource allocation decisions."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the beneficiary (e.g. active, deregistered, pending) — primary operational segmentation dimension."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration event (e.g. new, re-registration, update) — used to distinguish first-time vs. repeat registrations."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel or method used to register the beneficiary (e.g. field, digital, partner) — informs operational efficiency analysis."
    - name: "sex"
      expr: sex
      comment: "Reported sex of the registrant — essential for gender-disaggregated reporting required by most donors."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability tier assigned to the registrant — drives targeting and prioritisation decisions."
    - name: "poc_category"
      expr: poc_category
      comment: "Person of Concern category (e.g. refugee, IDP, stateless) — mandatory for UNHCR and donor disaggregation."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication resolution status — identifies whether the record is a confirmed unique, duplicate, or pending review."
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO nationality code of the registrant — used for country-of-origin disaggregation in donor reports."
    - name: "has_disability"
      expr: has_disability
      comment: "Boolean flag indicating whether the registrant has a reported disability — required for inclusion and protection reporting."
    - name: "is_gbv_survivor"
      expr: is_gbv_survivor
      comment: "Boolean flag indicating GBV survivor status — critical for protection programme targeting."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration — enables trend analysis of registration intake over time."
    - name: "registration_date_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year of registration — supports annual cohort and year-over-year comparison."
  measures:
    - name: "total_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total count of unique registered beneficiaries. Core population KPI used in all donor reports and programme sizing decisions."
    - name: "active_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN registrant_id END)
      comment: "Count of beneficiaries with active registration status. Drives current caseload sizing and resource allocation."
    - name: "duplicate_registrant_count"
      expr: COUNT(DISTINCT CASE WHEN deduplication_status = 'duplicate' THEN registrant_id END)
      comment: "Count of registrants flagged as duplicates. High values indicate data quality risk and potential over-reporting of beneficiary reach."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across registrants. Tracks whether the programme is reaching the most vulnerable populations over time."
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records. Low values signal data quality gaps that affect programme eligibility and reporting accuracy."
    - name: "gbv_survivor_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Count of registered GBV survivors. Mandatory KPI for protection programme reporting and resource allocation to GBV response services."
    - name: "beneficiaries_with_disability"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of registered beneficiaries with a reported disability. Required for inclusion mainstreaming and disability-disaggregated donor reporting."
    - name: "unaccompanied_minor_count"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied minors in the registrant population. High-priority protection caseload requiring dedicated case management resources."
    - name: "pregnant_or_lactating_count"
      expr: COUNT(DISTINCT CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Count of pregnant or lactating women in the registrant population. Drives nutrition programme targeting and maternal health service planning."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average mid-upper arm circumference (MUAC) in centimetres across registrants. Key nutrition screening indicator — values below threshold trigger emergency nutrition response."
    - name: "re_registration_events"
      expr: COUNT(DISTINCT CASE WHEN registration_type = 're-registration' THEN registrant_id END)
      comment: "Count of beneficiaries who have undergone re-registration. Indicates population churn and the need for periodic verification exercises."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for protection case management — tracks caseload volume, case stage progression, GBV and child protection caseloads, nutrition status, and service delivery quality."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g. open, closed, on hold) — primary operational segmentation for caseload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of protection case (e.g. GBV, child protection, legal aid) — drives service allocation and specialist staffing decisions."
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in the case management workflow — used to identify bottlenecks and measure throughput."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the case — high-priority cases require immediate resource allocation and supervisor review."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Assessed protection risk level — critical for triaging cases and escalating high-risk individuals."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Boolean flag indicating whether the case is a GBV case — mandatory disaggregation for protection cluster reporting."
    - name: "is_child_case"
      expr: is_child_case
      comment: "Boolean flag indicating whether the case involves a child — required for child protection programme reporting."
    - name: "service_modality"
      expr: service_modality
      comment: "Modality through which services are delivered (e.g. in-person, remote) — informs operational planning and access analysis."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Classification of the case outcome — used to measure programme effectiveness and case resolution quality."
    - name: "nutrition_status"
      expr: nutrition_status
      comment: "Nutrition status recorded at case level — tracks malnutrition prevalence within the protection caseload."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened — enables intake trend analysis and seasonal caseload planning."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the case was closed — used to measure case resolution throughput over time."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total number of protection cases. Core caseload KPI used in programme management and donor reporting."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'open' THEN case_record_id END)
      comment: "Count of currently open cases. Drives staffing and resource allocation decisions for case management teams."
    - name: "gbv_cases"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Count of GBV cases. Mandatory KPI for GBV sub-cluster reporting and specialist service planning."
    - name: "child_cases"
      expr: COUNT(DISTINCT CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Count of child protection cases. Required for child protection programme reporting and safeguarding compliance."
    - name: "cases_with_safety_plan"
      expr: COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END)
      comment: "Count of cases where a safety plan has been developed. Measures quality of protection response for high-risk individuals."
    - name: "cases_requiring_legal_aid"
      expr: COUNT(DISTINCT CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring legal aid. Informs legal services capacity planning and referral pathway management."
    - name: "cases_pending_supervisor_review"
      expr: COUNT(DISTINCT CASE WHEN supervisor_review_required = TRUE THEN case_record_id END)
      comment: "Count of cases flagged for supervisor review. High values indicate quality control bottlenecks or complex caseload spikes."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement (cm) across cases. Tracks nutrition status within the protection caseload — low averages trigger nutrition referral escalation."
    - name: "cases_with_case_plan"
      expr: COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Count of cases where a case plan has been developed. Measures adherence to case management standards and quality of service delivery."
    - name: "idp_cases"
      expr: COUNT(DISTINCT CASE WHEN is_idp_case = TRUE THEN case_record_id END)
      comment: "Count of cases involving internally displaced persons. Required for IDP-specific programme reporting and displacement response planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme enrollment KPIs — tracks beneficiary participation rates, completion, dropout, and service delivery modality across programme components to steer programme quality and reach decisions."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g. active, completed, dropped out) — primary segmentation for participation analysis."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality of service delivery for this enrollment (e.g. in-person, remote, hybrid) — informs operational planning."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for enrollment exit — identifies dropout drivers and informs programme retention strategies."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral that led to enrollment — measures effectiveness of referral pathways and intake channels."
    - name: "consent_for_component"
      expr: consent_for_component
      comment: "Boolean indicating whether consent was obtained for the specific programme component — compliance and ethics tracking."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — enables intake trend analysis and seasonal programme planning."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of enrollment completion — used to measure programme throughput and graduation rates over time."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total number of programme enrollments. Core reach KPI reported to donors and used for programme scale decisions."
    - name: "unique_enrolled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries enrolled across all programme components. Measures unduplicated reach — the primary beneficiary reach KPI."
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN enrollment_id END)
      comment: "Count of currently active enrollments. Drives current programme capacity and staffing decisions."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_id END)
      comment: "Count of completed enrollments. Measures programme completion throughput and graduation performance."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across enrollments. Low values signal engagement problems that may affect programme outcomes and donor compliance."
    - name: "sum_attendance_rate"
      expr: SUM(CAST(attendance_rate AS DOUBLE))
      comment: "Sum of attendance rates across enrollments — used as the numerator when computing weighted average attendance at aggregate levels."
    - name: "dropout_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'dropped_out' THEN enrollment_id END)
      comment: "Count of enrollments that ended in dropout. High values indicate programme retention issues requiring intervention."
    - name: "enrollments_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_for_component = TRUE THEN enrollment_id END)
      comment: "Count of enrollments where component-level consent was obtained. Measures ethical compliance and data protection adherence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs for humanitarian programme planning — tracks household vulnerability, displacement status, food security, protection risks, and demographic composition to drive targeting and resource allocation."
  source: "`vibe_ngo_v1`.`beneficiary`.`household`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the household — primary operational segmentation."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household (e.g. IDP, refugee, host community) — mandatory disaggregation for humanitarian reporting."
    - name: "food_security_status"
      expr: food_security_status
      comment: "Food security classification of the household — drives food assistance targeting and IPC phase analysis."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies — informs shelter programme targeting and NFI distribution planning."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Primary water source type — used for WASH programme targeting and access analysis."
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Boolean flag for female-headed households — required for gender-sensitive targeting and protection analysis."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Boolean flag indicating GBV risk at household level — drives protection referral and case management prioritisation."
    - name: "has_pregnant_lactating"
      expr: has_pregnant_lactating
      comment: "Boolean flag for households with pregnant or lactating women — drives nutrition programme targeting."
    - name: "current_country"
      expr: current_country
      comment: "Country where the household is currently located — geographic disaggregation for multi-country programme management."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of household registration — enables intake trend analysis."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total number of registered households. Core population KPI for household-based programme planning and donor reporting."
    - name: "female_headed_households"
      expr: COUNT(DISTINCT CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Count of female-headed households. Required for gender-sensitive programme targeting and protection analysis."
    - name: "households_with_gbv_risk"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Count of households flagged with GBV risk. Drives protection referral volumes and GBV response resource planning."
    - name: "households_with_pregnant_lactating"
      expr: COUNT(DISTINCT CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Count of households containing pregnant or lactating women. Drives maternal nutrition programme targeting."
    - name: "households_with_unaccompanied_minor"
      expr: COUNT(DISTINCT CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Count of households with unaccompanied minors. High-priority child protection caseload requiring immediate case management."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average household vulnerability score. Tracks whether programme targeting is reaching the most vulnerable households — key for donor accountability."
    - name: "avg_gps_latitude"
      expr: AVG(CAST(gps_latitude AS DOUBLE))
      comment: "Average GPS latitude of registered households — used as a geographic centroid proxy for spatial distribution analysis of the beneficiary population."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-sectoral needs assessment KPIs — tracks assessment coverage, sectoral vulnerability scores, and referral rates to inform programme design, resource allocation, and gap analysis across protection, nutrition, WASH, shelter, livelihoods, and education sectors."
  source: "`vibe_ngo_v1`.`beneficiary`.`needs_assessment`"
  dimensions:
    - name: "beneficiary_needs_assessment_status"
      expr: beneficiary_needs_assessment_status
      comment: "Status of the needs assessment (e.g. completed, pending validation, rejected) — tracks assessment pipeline quality."
    - name: "beneficiary_needs_assessment_type"
      expr: beneficiary_needs_assessment_type
      comment: "Type of needs assessment conducted — distinguishes initial, follow-up, and emergency assessments."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned based on assessment results — primary targeting dimension."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed individual or household — mandatory disaggregation for humanitarian reporting."
    - name: "female_headed_household"
      expr: female_headed_household
      comment: "Boolean flag for female-headed households in the assessment — required for gender-disaggregated analysis."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Boolean flag indicating GBV risk identified during assessment — drives protection referral decisions."
    - name: "referral_recommended"
      expr: referral_recommended
      comment: "Boolean flag indicating whether a referral was recommended — measures assessment-to-referral conversion."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect assessment data (e.g. KoBoToolbox, CommCare, paper) — informs data quality and operational efficiency analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', beneficiary_needs_assessment_date)
      comment: "Month of assessment — enables trend analysis of assessment coverage and sectoral score changes over time."
    - name: "country_code"
      expr: country_code
      comment: "Country code where the assessment was conducted — geographic disaggregation for multi-country programme management."
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT needs_assessment_id)
      comment: "Total number of needs assessments conducted. Core coverage KPI — measures programme reach into target populations."
    - name: "unique_assessed_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries assessed. Measures unduplicated assessment coverage — key for programme targeting accountability."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessments. Tracks population-level vulnerability trends — drives programme prioritisation and resource allocation."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition sector score. Low values indicate acute nutrition needs requiring emergency food and nutrition programme response."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection sector score. Tracks protection risk levels across the assessed population — drives protection programme investment decisions."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH sector score. Identifies water, sanitation, and hygiene gaps requiring targeted WASH programme investment."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter sector score. Tracks shelter adequacy across the assessed population — informs shelter and NFI programme planning."
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods sector score. Measures economic vulnerability — drives cash transfer and livelihoods programme targeting."
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education sector score. Identifies education access gaps — informs education programme design and school enrolment support."
    - name: "assessments_with_referral_recommended"
      expr: COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN needs_assessment_id END)
      comment: "Count of assessments where a referral was recommended. Measures the volume of multi-sector referral needs generated by assessments — drives referral pathway capacity planning."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement (mm) from assessments. Key acute malnutrition screening indicator — values below 125mm trigger emergency nutrition response protocols."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_protection_flag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection incident and risk KPIs — tracks active protection flags, escalation rates, follow-up compliance, and resolution performance to steer protection response quality and accountability."
  source: "`vibe_ngo_v1`.`beneficiary`.`protection_flag`"
  dimensions:
    - name: "protection_flag_type"
      expr: protection_flag_type
      comment: "Type of protection concern flagged (e.g. GBV, child abuse, trafficking) — primary segmentation for protection response planning."
    - name: "protection_flag_status"
      expr: protection_flag_status
      comment: "Current status of the protection flag (e.g. open, resolved, escalated) — tracks resolution pipeline."
    - name: "severity"
      expr: severity
      comment: "Severity level of the protection concern — drives prioritisation and escalation decisions."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the flag — governs data access and sharing protocols."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the protection concern is currently active — primary filter for operational caseload management."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean flag indicating whether escalation is required — identifies high-priority cases needing immediate management attention."
    - name: "legal_action_required"
      expr: legal_action_required
      comment: "Boolean flag indicating whether legal action is required — drives legal aid referral and justice sector engagement."
    - name: "protection_flag_date_month"
      expr: DATE_TRUNC('MONTH', protection_flag_date)
      comment: "Month the protection flag was raised — enables trend analysis of protection incident rates over time."
  measures:
    - name: "total_protection_flags"
      expr: COUNT(DISTINCT protection_flag_id)
      comment: "Total number of protection flags raised. Core protection incident volume KPI — used in protection cluster reporting and programme accountability."
    - name: "active_protection_flags"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN protection_flag_id END)
      comment: "Count of currently active protection flags. Drives current protection caseload management and staffing decisions."
    - name: "flags_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN protection_flag_id END)
      comment: "Count of protection flags requiring escalation. High values signal systemic protection risks requiring senior management and cluster-level response."
    - name: "flags_requiring_legal_action"
      expr: COUNT(DISTINCT CASE WHEN legal_action_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags requiring legal action. Drives legal aid referral volumes and justice sector partnership planning."
    - name: "flags_with_pss_provided"
      expr: COUNT(DISTINCT CASE WHEN pss_provided = TRUE THEN protection_flag_id END)
      comment: "Count of flags where psychosocial support was provided. Measures PSS service delivery coverage within the protection caseload."
    - name: "flags_with_referral_made"
      expr: COUNT(DISTINCT CASE WHEN referral_made = TRUE THEN protection_flag_id END)
      comment: "Count of flags where a referral was made to another service. Measures referral pathway activation rate — key for multi-sector response coordination."
    - name: "flags_with_follow_up_required"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags with outstanding follow-up required. High values indicate follow-up compliance gaps that risk beneficiary safety."
    - name: "unique_beneficiaries_with_protection_flags"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries with at least one protection flag. Measures the breadth of the protection-affected population — key for programme sizing."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway KPIs — tracks referral volumes, acceptance rates, completion rates, GBV referrals, and service delivery timeliness to steer inter-agency coordination and referral pathway quality."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g. pending, accepted, completed, declined) — primary operational segmentation."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g. internal, external, emergency) — informs referral pathway design and partner coordination."
    - name: "category"
      expr: category
      comment: "Service category of the referral (e.g. health, legal, shelter, GBV) — drives sector-specific referral pathway analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral — high-priority referrals require expedited processing and follow-up."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Boolean flag indicating whether the referral is for a GBV case — mandatory disaggregation for GBV referral pathway reporting."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Categorical outcome of the referral — measures referral pathway effectiveness and service delivery quality."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service provided by the receiving organisation — informs service gap analysis and partner capacity planning."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made — enables trend analysis of referral volumes and pathway performance over time."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of referrals made. Core inter-agency coordination KPI — measures the volume of beneficiaries connected to external services."
    - name: "gbv_referrals"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Count of referrals for GBV cases. Mandatory KPI for GBV referral pathway reporting and survivor support service planning."
    - name: "completed_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'completed' THEN referral_id END)
      comment: "Count of referrals that reached completion. Measures referral pathway effectiveness — low completion rates indicate service access barriers."
    - name: "declined_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'declined' THEN referral_id END)
      comment: "Count of declined referrals. High values indicate capacity constraints or eligibility mismatches in receiving organisations — drives partner coordination action."
    - name: "referrals_with_follow_up_completed"
      expr: COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Count of referrals where follow-up was completed. Measures case management quality and beneficiary safety monitoring compliance."
    - name: "referrals_with_feedback_received"
      expr: COUNT(DISTINCT CASE WHEN feedback_received_flag = TRUE THEN referral_id END)
      comment: "Count of referrals where beneficiary feedback was received. Measures accountability to affected populations (AAP) compliance."
    - name: "protection_concern_referrals"
      expr: COUNT(DISTINCT CASE WHEN protection_concern_flag = TRUE THEN referral_id END)
      comment: "Count of referrals involving a protection concern. Tracks the volume of protection-sensitive referrals requiring confidential handling and specialist follow-up."
    - name: "unique_referred_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries who received at least one referral. Measures unduplicated referral reach — key for multi-sector service coordination reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling KPIs — tracks composite vulnerability scores, protection risk levels, nutritional status, and special needs flags across the beneficiary population to drive targeting, programme design, and reassessment scheduling."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier classification (e.g. extreme, high, medium, low) — primary targeting dimension for programme prioritisation."
    - name: "vulnerability_profile_status"
      expr: vulnerability_profile_status
      comment: "Status of the vulnerability profile (e.g. active, superseded, archived) — tracks profile currency and reassessment compliance."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level from the vulnerability assessment — drives protection programme targeting and case management prioritisation."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase classification — mandatory for food security cluster reporting and emergency response triggers."
    - name: "nutritional_status"
      expr: nutritional_status
      comment: "Nutritional status classification from the vulnerability assessment — drives nutrition programme targeting."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category of the profiled individual or household — mandatory disaggregation for humanitarian reporting."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Boolean flag for female-headed households — required for gender-sensitive targeting."
    - name: "gbv_exposure_flag"
      expr: gbv_exposure_flag
      comment: "Boolean flag indicating GBV exposure — drives protection referral and specialist service targeting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of vulnerability assessment — enables trend analysis of vulnerability score changes over time."
    - name: "country_code"
      expr: country_code
      comment: "Country code where the vulnerability profile was assessed — geographic disaggregation for multi-country programme management."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total number of vulnerability profiles. Measures assessment coverage — core KPI for programme targeting accountability."
    - name: "unique_profiled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries with a vulnerability profile. Measures unduplicated profiling coverage — key for targeting completeness reporting."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all profiles. Tracks population-level vulnerability trends — drives programme prioritisation and resource allocation decisions."
    - name: "profiles_with_gbv_exposure"
      expr: COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with GBV exposure flagged. Measures the scale of GBV-affected population requiring protection services."
    - name: "profiles_with_pss_need"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with identified psychosocial support needs. Drives PSS programme capacity planning and staffing decisions."
    - name: "profiles_with_chronic_illness"
      expr: COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with chronic illness flagged. Informs health programme targeting and medical supply chain planning."
    - name: "profiles_with_wash_access_gap"
      expr: COUNT(DISTINCT CASE WHEN wash_access_flag = FALSE THEN vulnerability_profile_id END)
      comment: "Count of profiles where WASH access is flagged as inadequate. Drives WASH programme targeting and infrastructure investment decisions."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement (mm) from vulnerability profiles. Key acute malnutrition indicator — population-level trends trigger emergency nutrition response decisions."
    - name: "profiles_with_unaccompanied_minor"
      expr: COUNT(DISTINCT CASE WHEN unaccompanied_minor_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with unaccompanied minor flag. High-priority child protection caseload requiring immediate case management and family tracing services."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement and assistance delivery KPIs — tracks entitlement volumes, quantities, vulnerability-based adjustments, and coverage to steer supply chain planning, donor compliance, and equitable distribution decisions."
  source: "`vibe_ngo_v1`.`beneficiary`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (e.g. active, suspended, completed) — primary operational segmentation for assistance delivery management."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of entitlement delivery (e.g. monthly, quarterly, one-time) — informs supply chain scheduling and distribution planning."
    - name: "special_dietary_requirement"
      expr: special_dietary_requirement
      comment: "Special dietary requirement associated with the entitlement — drives specialised commodity procurement and distribution planning."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the entitlement started — enables cohort analysis of assistance delivery over time."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the entitlement ended — used to track entitlement expiry and renewal patterns."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total number of entitlements issued. Core assistance delivery KPI — measures the scale of direct beneficiary support commitments."
    - name: "unique_entitled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries with at least one entitlement. Measures unduplicated assistance reach — key for donor reporting on beneficiary coverage."
    - name: "active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'active' THEN entitlement_id END)
      comment: "Count of currently active entitlements. Drives current supply chain demand forecasting and distribution planning."
    - name: "total_entitlement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of commodities or assistance units entitled across all active and historical entitlements. Core supply chain planning KPI."
    - name: "avg_entitlement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average entitlement quantity per beneficiary. Tracks whether assistance rations are consistent with programme standards and donor commitments."
    - name: "total_vulnerability_based_adjustment"
      expr: SUM(CAST(vulnerability_based_adjustment AS DOUBLE))
      comment: "Total vulnerability-based adjustment applied across entitlements. Measures the scale of targeted top-up assistance provided to the most vulnerable — key for equity and targeting accountability."
    - name: "avg_vulnerability_based_adjustment"
      expr: AVG(CAST(vulnerability_based_adjustment AS DOUBLE))
      comment: "Average vulnerability-based adjustment per entitlement. Tracks whether targeting adjustments are being applied consistently and at appropriate levels."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Registration operations KPIs — tracks registration throughput, data quality, biometric capture rates, deduplication performance, and consent compliance to steer registration programme quality and operational efficiency."
  source: "`vibe_ngo_v1`.`beneficiary`.`registration_event`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the registration event (e.g. completed, pending, rejected) — primary operational segmentation."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration event (e.g. new, update, re-registration) — distinguishes first-time registrations from updates."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel or method used for registration (e.g. field, digital, partner) — informs operational efficiency and cost analysis."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system used for data collection (e.g. KoBoToolbox, CommCare, UNHCR proGres) — tracks data pipeline quality by system."
    - name: "biometric_captured"
      expr: biometric_captured
      comment: "Boolean flag indicating whether biometric data was captured — tracks biometric enrolment coverage."
    - name: "duplicate_found"
      expr: duplicate_found
      comment: "Boolean flag indicating whether a duplicate was found during registration — measures deduplication detection rate."
    - name: "household_registration"
      expr: household_registration
      comment: "Boolean flag indicating whether this was a household-level registration event — distinguishes individual from household registration approaches."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration event — enables registration throughput trend analysis."
  measures:
    - name: "total_registration_events"
      expr: COUNT(DISTINCT registration_event_id)
      comment: "Total number of registration events. Core operational throughput KPI — measures registration programme output and capacity utilisation."
    - name: "unique_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Count of unique beneficiaries registered across all events. Measures unduplicated registration reach — key for programme coverage reporting."
    - name: "biometric_capture_count"
      expr: COUNT(DISTINCT CASE WHEN biometric_captured = TRUE THEN registration_event_id END)
      comment: "Count of registration events with biometric data captured. Measures biometric enrolment coverage — high coverage reduces fraud and duplicate registration risk."
    - name: "duplicate_detections"
      expr: COUNT(DISTINCT CASE WHEN duplicate_found = TRUE THEN registration_event_id END)
      comment: "Count of registration events where a duplicate was detected. Measures deduplication system effectiveness — high values indicate data quality risks in the beneficiary registry."
    - name: "registrations_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_obtained = TRUE THEN registration_event_id END)
      comment: "Count of registration events where consent was obtained. Measures ethical compliance and data protection adherence — mandatory for GDPR and humanitarian data protection standards."
    - name: "avg_registration_completeness_score"
      expr: AVG(CAST(registration_completeness_score AS DOUBLE))
      comment: "Average data completeness score across registration events. Low values signal data quality gaps that affect programme eligibility determination and reporting accuracy."
    - name: "registrations_with_vulnerability_assessment"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_assessment_conducted = TRUE THEN registration_event_id END)
      comment: "Count of registration events where a vulnerability assessment was conducted at point of registration. Measures integrated registration quality — higher rates enable faster targeting decisions."
    - name: "registrations_requiring_referral"
      expr: COUNT(DISTINCT CASE WHEN referral_required = TRUE THEN registration_event_id END)
      comment: "Count of registration events where a referral was identified as required. Measures the volume of immediate referral needs generated at point of registration — drives referral pathway capacity planning."
$$;