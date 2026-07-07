-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core beneficiary registration metrics tracking population reach, vulnerability profile, and data quality across all registrants. Used by program directors and M&E leads to assess coverage, deduplication integrity, and protection caseload."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the beneficiary (e.g., active, deregistered, pending verification)."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., individual, household head, group) for segmenting population reach."
    - name: "sex"
      expr: sex
      comment: "Sex of the registrant, used for gender-disaggregated reporting required by most donors."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability tier assigned to the registrant (e.g., high, medium, low) for targeting analysis."
    - name: "poc_category"
      expr: poc_category
      comment: "Person of concern category (e.g., refugee, IDP, returnee, stateless) for population segmentation."
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO nationality code of the registrant for geographic and demographic disaggregation."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication resolution status indicating whether the registrant record is unique, a duplicate, or pending review."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel through which registration was conducted (e.g., in-person, mobile, remote) for operational analysis."
    - name: "registration_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of registration for trend analysis of beneficiary intake over time."
    - name: "has_disability"
      expr: has_disability
      comment: "Flag indicating whether the registrant has a reported disability, for inclusion and targeting compliance."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether informed consent was obtained at registration, critical for data protection compliance."
  measures:
    - name: "total_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total number of unique registered beneficiaries. Primary reach indicator used in donor reporting and program coverage assessments."
    - name: "active_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN registrant_id END)
      comment: "Number of beneficiaries with active registration status. Drives resource allocation and service planning decisions."
    - name: "female_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN sex = 'female' THEN registrant_id END)
      comment: "Count of female registrants. Required for gender-disaggregated donor reporting and equity monitoring."
    - name: "beneficiaries_with_disability"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of registrants with a reported disability. Used to monitor inclusion targets and allocate specialized services."
    - name: "high_vulnerability_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_category = 'high' THEN registrant_id END)
      comment: "Count of beneficiaries classified as high vulnerability. Drives prioritization of scarce resources and protection interventions."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all registrants. Tracks overall population vulnerability trend over time."
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records. Monitors data quality and registration process effectiveness."
    - name: "gbv_survivor_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Number of registered GBV survivors. Critical for protection programming, specialized service allocation, and donor compliance."
    - name: "unaccompanied_minor_count"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied minors in the registry. Triggers child protection protocols and specialized case management."
    - name: "consent_obtained_count"
      expr: COUNT(DISTINCT CASE WHEN consent_given = TRUE THEN registrant_id END)
      comment: "Number of registrants with confirmed informed consent. Monitors compliance with data protection obligations (GDPR, CHS)."
    - name: "duplicate_registrant_count"
      expr: COUNT(DISTINCT CASE WHEN deduplication_status = 'duplicate' THEN registrant_id END)
      comment: "Count of records identified as duplicates. Measures deduplication effectiveness and prevents double-counting in beneficiary reach figures."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average mid-upper arm circumference (MUAC) in centimetres across registrants. Key nutrition screening indicator for acute malnutrition programming."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management performance metrics tracking caseload volume, case types, resolution rates, and protection risk across all open and closed cases. Used by protection and case management teams to monitor service delivery quality and workload."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., open, closed, on hold, referred) for caseload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g., protection, GBV, nutrition, legal aid) for service-line analysis."
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in the case management workflow (e.g., intake, assessment, intervention, closure)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the case (e.g., urgent, high, medium, low) for workload triage."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Assessed protection risk level for the case, used to escalate high-risk cases to senior staff."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Final outcome classification upon case closure (e.g., resolved, referred, withdrawn) for quality assessment."
    - name: "service_modality"
      expr: service_modality
      comment: "Modality through which services were delivered (e.g., in-person, remote, community-based)."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Flag indicating whether the case involves gender-based violence, for GBV-specific reporting and resource allocation."
    - name: "is_child_case"
      expr: is_child_case
      comment: "Flag indicating whether the case involves a child, triggering child protection protocols."
    - name: "open_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the case was opened, for intake trend analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect case data (e.g., KoBoToolbox, CommCare, paper) for data quality monitoring."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total number of unique cases. Primary caseload volume indicator for staffing and resource planning."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'open' THEN case_record_id END)
      comment: "Number of currently open cases. Drives real-time workload management and staff allocation decisions."
    - name: "closed_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'closed' THEN case_record_id END)
      comment: "Number of closed cases. Used to measure case resolution throughput and team productivity."
    - name: "gbv_cases"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Total GBV cases. Critical indicator for GBV program scale, donor reporting, and specialist resource allocation."
    - name: "child_cases"
      expr: COUNT(DISTINCT CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Total child protection cases. Triggers child safeguarding protocols and informs child-focused program investment."
    - name: "high_priority_cases"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'high' OR priority_level = 'urgent' THEN case_record_id END)
      comment: "Count of high or urgent priority cases. Monitors critical caseload requiring immediate intervention."
    - name: "cases_with_safety_plan"
      expr: COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END)
      comment: "Number of cases where a safety plan has been developed. Measures protection response quality for high-risk individuals."
    - name: "cases_requiring_supervisor_review"
      expr: COUNT(DISTINCT CASE WHEN supervisor_review_required = TRUE THEN case_record_id END)
      comment: "Cases flagged for supervisor review. Monitors quality assurance workload and escalation volume."
    - name: "cases_with_case_plan"
      expr: COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Number of cases with a documented case plan. Measures adherence to case management standards and service quality."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement (cm) across cases. Nutrition screening indicator for cases with nutritional components."
    - name: "idp_cases"
      expr: COUNT(DISTINCT CASE WHEN is_idp_case = TRUE THEN case_record_id END)
      comment: "Count of cases involving internally displaced persons. Informs displacement-specific programming and resource targeting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_cva_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash and voucher assistance (CVA) transfer metrics tracking disbursement volumes, transfer values, delivery mechanisms, and reconciliation status. Used by program finance and CVA teams to monitor transfer efficiency, financial accountability, and beneficiary reach."
  source: "`vibe_ngo_v1`.`beneficiary`.`cva_transfer`"
  dimensions:
    - name: "cva_transfer_status"
      expr: cva_transfer_status
      comment: "Current status of the transfer (e.g., pending, disbursed, failed, cancelled) for pipeline monitoring."
    - name: "delivery_mechanism"
      expr: delivery_mechanism
      comment: "Mechanism used to deliver the transfer (e.g., mobile money, bank transfer, e-voucher, cash-in-hand) for modality analysis."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Modality of the CVA transfer (e.g., cash, voucher, in-kind equivalent) for program design decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer for multi-currency financial reporting and exchange rate analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Financial reconciliation status of the transfer (e.g., reconciled, pending, disputed) for audit and accountability."
    - name: "transfer_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month of transfer disbursement for trend analysis of CVA spending over time."
  measures:
    - name: "total_transfers"
      expr: COUNT(DISTINCT cva_transfer_id)
      comment: "Total number of CVA transfer transactions. Primary volume indicator for CVA program scale and operational throughput."
    - name: "total_transfer_amount"
      expr: SUM(CAST(transfer_amount AS DOUBLE))
      comment: "Total value of all CVA transfers disbursed. Primary financial KPI for CVA program expenditure and donor accountability."
    - name: "avg_transfer_amount"
      expr: AVG(CAST(transfer_amount AS DOUBLE))
      comment: "Average transfer value per transaction. Benchmarks transfer adequacy against minimum expenditure baskets (MEB) and program design targets."
    - name: "disbursed_transfer_amount"
      expr: SUM(CASE WHEN cva_transfer_status = 'disbursed' THEN CAST(transfer_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of successfully disbursed transfers. Measures actual financial delivery against planned disbursement for accountability reporting."
    - name: "failed_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN cva_transfer_status = 'failed' THEN cva_transfer_id END)
      comment: "Number of failed transfer transactions. Monitors delivery failure rate to trigger corrective action and protect beneficiary entitlements."
    - name: "unreconciled_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status = 'pending' OR reconciliation_status = 'unreconciled' THEN cva_transfer_id END)
      comment: "Count of transfers pending financial reconciliation. Tracks financial accountability risk and audit exposure."
    - name: "unique_beneficiaries_reached_cva"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries who received at least one CVA transfer. Core reach metric for CVA program coverage reporting."
    - name: "unique_households_reached_cva"
      expr: COUNT(DISTINCT household_id)
      comment: "Number of unique households that received CVA transfers. Household-level reach indicator for food security and livelihoods programming."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment metrics tracking beneficiary participation, completion rates, attendance, and exit patterns across program components. Used by program managers to monitor enrollment pipeline, dropout risk, and service delivery effectiveness."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g., enrolled, completed, dropped out, transferred) for pipeline management."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for program exit (e.g., completed, voluntary withdrawal, relocated, deceased) for attrition analysis."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality of service delivery (e.g., in-person, remote, community-based) for operational efficiency analysis."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "CVA transfer modality associated with the enrollment for integrated cash-plus program analysis."
    - name: "consent_for_component"
      expr: consent_for_component
      comment: "Whether consent was obtained for this specific program component, for compliance monitoring."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for intake trend analysis and program ramp-up monitoring."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total number of enrollment records. Primary program participation volume indicator for donor reporting and target tracking."
    - name: "unique_enrolled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries enrolled across all components. Unduplicated reach figure for program coverage reporting."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_id END)
      comment: "Number of enrollments that reached successful completion. Measures program completion rate and service delivery effectiveness."
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'enrolled' OR enrollment_status = 'active' THEN enrollment_id END)
      comment: "Current active enrollment count. Drives real-time capacity planning and resource allocation for ongoing program delivery."
    - name: "dropout_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'dropped_out' OR enrollment_status = 'withdrawn' THEN enrollment_id END)
      comment: "Number of beneficiaries who dropped out or withdrew. Monitors attrition risk and triggers retention interventions."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across all enrollments. Measures beneficiary engagement and service uptake quality."
    - name: "consent_compliant_enrollments"
      expr: COUNT(DISTINCT CASE WHEN consent_for_component = TRUE THEN enrollment_id END)
      comment: "Enrollments with confirmed component-level consent. Monitors data protection and ethical compliance across program activities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Needs assessment metrics tracking vulnerability scores, sectoral needs, and assessment coverage across the beneficiary population. Used by program design teams and M&E leads to prioritize interventions, allocate resources, and demonstrate evidence-based targeting."
  source: "`vibe_ngo_v1`.`beneficiary`.`needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment conducted (e.g., household, individual, community) for methodology disaggregation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., completed, pending validation, rejected) for quality pipeline monitoring."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned based on assessment results for targeting and prioritization."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed household (e.g., IDP, refugee, host community) for context-specific analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assessment was conducted for geographic disaggregation and multi-country program management."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Administrative level 1 area (e.g., region, province) for sub-national targeting analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trend analysis of needs profiling over time."
    - name: "female_headed_household"
      expr: female_headed_household
      comment: "Whether the assessed household is female-headed, for gender-sensitive targeting and equity monitoring."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect assessment data for data quality and methodology monitoring."
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT needs_assessment_id)
      comment: "Total number of needs assessments conducted. Measures assessment coverage and evidence base for program targeting."
    - name: "unique_assessed_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries assessed. Tracks assessment coverage against registered population for targeting completeness."
    - name: "unique_assessed_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Number of unique households assessed. Household-level coverage indicator for food security and livelihoods programming."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessments. Tracks population-level vulnerability trend to inform program scale and design."
    - name: "avg_food_security_score"
      expr: AVG(CAST(food_security_score AS DOUBLE))
      comment: "Average food security score. Primary indicator for food assistance program targeting and IPC phase classification."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection needs score. Drives protection program prioritization and resource allocation decisions."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition needs score. Informs nutrition program targeting and CMAM caseload projections."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH (water, sanitation, hygiene) needs score. Guides WASH infrastructure investment and hygiene promotion targeting."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter adequacy score. Informs shelter and NFI program targeting and seasonal response planning."
    - name: "gbv_risk_flagged_assessments"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN needs_assessment_id END)
      comment: "Number of assessments flagging GBV risk. Triggers referral to GBV services and informs protection program scale."
    - name: "referral_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN needs_assessment_id END)
      comment: "Assessments where a referral was recommended. Measures referral pipeline volume and cross-sector coordination demand."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement (mm) from assessments. Acute malnutrition screening indicator for nutrition program targeting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling metrics tracking composite vulnerability scores, protection risks, and multi-dimensional deprivation indicators across the beneficiary population over time. Used by program strategists and protection leads to monitor vulnerability trends and prioritize high-risk cohorts."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier classification (e.g., critical, high, medium, low) for targeting and prioritization."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the vulnerability profile (e.g., active, superseded, archived) for data currency monitoring."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category (e.g., IDP, refugee, returnee, host community) for context-specific vulnerability analysis."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase classification for food assistance targeting and emergency response triggers."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vulnerability profile for geographic disaggregation and multi-country comparison."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Assessed protection risk level for the individual or household for protection program prioritization."
    - name: "nutritional_status"
      expr: nutritional_status
      comment: "Nutritional status classification (e.g., SAM, MAM, normal) for nutrition program targeting."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of vulnerability assessment for longitudinal trend analysis."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Whether the household is female-headed, for gender-sensitive vulnerability analysis and targeting."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total number of vulnerability profiles. Measures assessment coverage and profiling completeness across the beneficiary population."
    - name: "unique_profiled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries with a vulnerability profile. Tracks profiling coverage against registered population."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all active profiles. Primary population-level vulnerability indicator for strategic program design."
    - name: "critical_vulnerability_count"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier = 'critical' THEN vulnerability_profile_id END)
      comment: "Number of beneficiaries in the critical vulnerability tier. Drives emergency response prioritization and resource surge decisions."
    - name: "gbv_exposure_flagged_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles flagging GBV exposure. Informs GBV program scale, specialist staffing, and referral pathway investment."
    - name: "pss_need_flagged_count"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles flagging psychosocial support (PSS) need. Drives PSS program capacity planning and mental health resource allocation."
    - name: "chronic_illness_count"
      expr: COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries with chronic illness. Informs health program targeting and medical supply planning."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC (mm) from vulnerability profiles. Nutrition status indicator for acute malnutrition program targeting."
    - name: "wash_access_gap_count"
      expr: COUNT(DISTINCT CASE WHEN wash_access_flag = FALSE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries without adequate WASH access. Quantifies WASH service gap for infrastructure investment decisions."
    - name: "unaccompanied_minor_profile_count"
      expr: COUNT(DISTINCT CASE WHEN unaccompanied_minor_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of unaccompanied minor profiles. Triggers child protection case management and specialized care allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway metrics tracking referral volumes, outcomes, response timeliness, and inter-agency coordination effectiveness. Used by protection coordinators and program managers to monitor referral quality, pathway gaps, and beneficiary follow-through."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., pending, accepted, completed, declined) for pipeline monitoring."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g., internal, external, emergency) for pathway analysis."
    - name: "category"
      expr: category
      comment: "Sector or service category of the referral (e.g., health, legal, shelter, GBV) for cross-sector coordination analysis."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the referral (e.g., service received, not reached, declined) for quality assessment."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral (e.g., urgent, high, routine) for response time monitoring."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Whether the referral is related to a GBV case, for GBV pathway monitoring and survivor support tracking."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service provided by the receiving organization for service mapping and gap analysis."
    - name: "referral_month"
      expr: DATE_TRUNC('month', referral_date)
      comment: "Month the referral was initiated for trend analysis of referral volumes over time."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the referral for data protection compliance monitoring."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of referrals initiated. Primary volume indicator for inter-agency coordination and referral pathway utilization."
    - name: "completed_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'completed' THEN referral_id END)
      comment: "Number of referrals successfully completed. Measures referral pathway effectiveness and service delivery follow-through."
    - name: "declined_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'declined' THEN referral_id END)
      comment: "Number of referrals declined by receiving organizations. Identifies pathway gaps and inter-agency coordination failures."
    - name: "gbv_referrals"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Total GBV-related referrals. Critical indicator for GBV survivor support pathway coverage and specialist service demand."
    - name: "follow_up_completed_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Referrals with confirmed follow-up completed. Measures case management quality and beneficiary continuity of care."
    - name: "feedback_received_count"
      expr: COUNT(DISTINCT CASE WHEN feedback_received_flag = TRUE THEN referral_id END)
      comment: "Referrals where beneficiary feedback was received. Monitors accountability to affected populations (AAP) compliance."
    - name: "unique_referred_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries who received at least one referral. Measures referral pathway reach across the caseload."
    - name: "protection_concern_referrals"
      expr: COUNT(DISTINCT CASE WHEN protection_concern_flag = TRUE THEN referral_id END)
      comment: "Referrals flagged with a protection concern. Monitors protection caseload requiring specialized response and escalation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management metrics tracking consent coverage, compliance with data protection frameworks (GDPR, CHS), consent expiry, and withdrawal rates. Used by data protection officers and compliance teams to ensure ethical data use and regulatory adherence."
  source: "`vibe_ngo_v1`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, withdrawn, expired) for compliance monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent granted (e.g., data processing, photography, biometric, sharing) for scope analysis."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g., verbal, written, digital) for process compliance monitoring."
    - name: "collection_country_code"
      expr: collection_country_code
      comment: "Country where consent was collected for jurisdiction-specific regulatory compliance (e.g., GDPR applicability)."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR applies to this consent record, for EU data protection compliance tracking."
    - name: "is_proxy_consent"
      expr: is_proxy_consent
      comment: "Whether consent was given by a proxy (e.g., for children or incapacitated individuals) for safeguarding compliance."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month consent was obtained for trend analysis of consent collection over time."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total number of consent records. Baseline measure for consent coverage assessment across the beneficiary population."
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Number of currently active consent records. Measures the proportion of beneficiaries with valid, current consent for data processing."
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'withdrawn' THEN consent_record_id END)
      comment: "Number of consent withdrawals. Monitors beneficiary trust and triggers data deletion/restriction obligations under GDPR and CHS."
    - name: "gdpr_applicable_consents"
      expr: COUNT(DISTINCT CASE WHEN gdpr_applicable = TRUE THEN consent_record_id END)
      comment: "Count of consent records subject to GDPR. Quantifies EU regulatory compliance exposure and data governance obligations."
    - name: "informed_consent_verified_count"
      expr: COUNT(DISTINCT CASE WHEN informed_consent_verified = TRUE THEN consent_record_id END)
      comment: "Consents with verified informed consent process. Measures ethical compliance quality and CHS standard adherence."
    - name: "photography_permitted_count"
      expr: COUNT(DISTINCT CASE WHEN photography_permitted = TRUE THEN consent_record_id END)
      comment: "Beneficiaries who have consented to photography. Governs communications and visibility activities to prevent unauthorized use of beneficiary images."
    - name: "biometric_enrollment_permitted_count"
      expr: COUNT(DISTINCT CASE WHEN biometric_enrollment_permitted = TRUE THEN consent_record_id END)
      comment: "Count of consents permitting biometric enrollment. Governs biometric data collection scope and deduplication system eligibility."
    - name: "proxy_consent_count"
      expr: COUNT(DISTINCT CASE WHEN is_proxy_consent = TRUE THEN consent_record_id END)
      comment: "Number of proxy consent records. Monitors safeguarding compliance for vulnerable individuals unable to self-consent."
    - name: "chs_compliant_consents"
      expr: COUNT(DISTINCT CASE WHEN chs_compliance_flag = TRUE THEN consent_record_id END)
      comment: "Consents flagged as compliant with Core Humanitarian Standard (CHS). Measures organizational accountability and humanitarian compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary entitlement metrics tracking entitlement coverage, quantities, transfer modalities, and vulnerability-based adjustments. Used by program and supply chain teams to ensure equitable distribution, monitor entitlement fulfilment, and manage commodity planning."
  source: "`vibe_ngo_v1`.`beneficiary`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (e.g., active, suspended, completed, cancelled) for fulfilment monitoring."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Modality of the entitlement transfer (e.g., cash, voucher, in-kind) for program design and modality mix analysis."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "CVA-specific transfer modality for cash and voucher program analysis."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of entitlement distribution (e.g., monthly, quarterly, one-time) for supply planning."
    - name: "special_dietary_requirement"
      expr: special_dietary_requirement
      comment: "Special dietary requirements associated with the entitlement for nutrition-sensitive programming."
    - name: "entitlement_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the entitlement period begins for pipeline and distribution planning."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total number of entitlement records. Measures entitlement coverage and program commitment volume."
    - name: "active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'active' THEN entitlement_id END)
      comment: "Number of currently active entitlements. Drives supply chain planning and distribution scheduling for ongoing program delivery."
    - name: "total_entitlement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of commodities or transfer units entitled across all beneficiaries. Primary supply planning and procurement demand signal."
    - name: "avg_entitlement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average entitlement quantity per beneficiary. Benchmarks ration adequacy against program standards and minimum expenditure baskets."
    - name: "total_vulnerability_adjustment"
      expr: SUM(CAST(vulnerability_based_adjustment AS DOUBLE))
      comment: "Total vulnerability-based adjustment applied across entitlements. Measures the scale of targeted top-up support for the most vulnerable beneficiaries."
    - name: "unique_entitled_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique beneficiaries with at least one entitlement. Core coverage metric for entitlement programme reach reporting."
$$;