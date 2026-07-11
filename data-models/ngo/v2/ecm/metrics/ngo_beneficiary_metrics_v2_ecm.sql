-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core beneficiary registration metrics tracking population reach, vulnerability profiles, demographic composition, and data quality across the registrant master list. Used by program directors and field coordinators to assess coverage, targeting accuracy, and registration completeness."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the beneficiary (e.g. active, exited, pending verification) — primary filter for active caseload analysis."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability tier assigned to the registrant, used to segment high-need populations for targeting decisions."
    - name: "sex"
      expr: sex
      comment: "Reported sex of the registrant, used for gender-disaggregated reporting required by most donors."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "ISO country code of origin, enabling nationality-based population analysis and protection profiling."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication outcome for the registrant record — critical for data quality governance and accurate headcount reporting."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel or method used to register the beneficiary (e.g. mobile, paper, biometric), informing operational efficiency analysis."
    - name: "poc_category"
      expr: poc_category
      comment: "UNHCR person-of-concern category (refugee, IDP, stateless, etc.) for mandate-aligned population reporting."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration, used for trend analysis of intake volumes over time."
    - name: "has_disability"
      expr: has_disability
      comment: "Flag indicating whether the registrant has a reported disability — required for inclusion and protection targeting."
    - name: "is_unaccompanied_minor"
      expr: is_unaccompanied_minor
      comment: "Flag for unaccompanied and separated children (UASC), a high-priority protection caseload."
  measures:
    - name: "total_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total unique registered beneficiaries. The primary headcount KPI used in donor reports, program reviews, and coverage assessments."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across registrants. Tracks whether the program is reaching the most vulnerable populations over time."
    - name: "pct_with_disability_numerator"
      expr: COUNT(CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of registrants with a reported disability. Divide by total_registered_beneficiaries to compute inclusion rate for disability-disaggregated reporting."
    - name: "pct_female_numerator"
      expr: COUNT(CASE WHEN sex = 'Female' THEN registrant_id END)
      comment: "Count of female registrants. Divide by total_registered_beneficiaries to compute gender parity ratio — a standard donor and SPHERE indicator."
    - name: "pct_unaccompanied_minor_numerator"
      expr: COUNT(CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied and separated children. Divide by total_registered_beneficiaries to assess UASC caseload share — a critical child protection KPI."
    - name: "avg_registration_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records. Tracks data quality health — low scores trigger data cleaning campaigns and affect reporting credibility."
    - name: "duplicate_registrant_count"
      expr: COUNT(CASE WHEN deduplication_status = 'Duplicate' THEN registrant_id END)
      comment: "Count of registrants flagged as duplicates. High values indicate registration system integrity issues and inflate beneficiary headcounts reported to donors."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_given = TRUE THEN registrant_id END)
      comment: "Count of registrants with confirmed data consent. Divide by total_registered_beneficiaries to compute consent compliance rate — a legal and ethical obligation under GDPR and CHS."
    - name: "gbv_survivor_count"
      expr: COUNT(CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Count of registrants identified as GBV survivors. Drives resource allocation for GBV case management and psychosocial support services."
    - name: "pregnant_or_lactating_count"
      expr: COUNT(CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Count of pregnant or lactating women in the caseload. Critical for nutrition programming, health service planning, and MIYCN targeting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling metrics tracking composite scores, sectoral risk dimensions, and population-level vulnerability trends. Used by program managers and MEL teams to assess targeting accuracy, monitor vulnerability changes over time, and prioritize resource allocation."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Categorical vulnerability tier (e.g. extreme, high, medium, low) — primary segmentation for targeting and prioritization decisions."
    - name: "vulnerability_profile_status"
      expr: vulnerability_profile_status
      comment: "Current status of the vulnerability profile (active, superseded, archived) — filters to current profiles for accurate population snapshots."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase classification, used for food security and nutrition program targeting aligned to global standards."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement classification (IDP, refugee, returnee, host community) for population-disaggregated vulnerability analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of assessment, enabling geographic comparison of vulnerability levels across program geographies."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of vulnerability assessment, used to track changes in population vulnerability over time."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Indicates female-headed households — a standard vulnerability proxy used in targeting criteria."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk classification, used to prioritize case management and protection monitoring resources."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total vulnerability profiles assessed. Tracks assessment coverage relative to registered population — a program quality indicator."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across assessed beneficiaries. The primary indicator of population-level vulnerability — tracked over time to measure program impact on reducing vulnerability."
    - name: "max_composite_vulnerability_score"
      expr: MAX(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Maximum composite vulnerability score in the assessed population. Identifies the most extreme vulnerability cases requiring immediate intervention."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average mid-upper arm circumference (MUAC) in millimetres across assessed beneficiaries. A direct nutritional status indicator — values below 125mm indicate acute malnutrition requiring therapeutic feeding."
    - name: "gbv_exposure_count"
      expr: COUNT(CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries with GBV exposure flagged in their vulnerability profile. Drives GBV case management resource planning and protection monitoring."
    - name: "pss_need_count"
      expr: COUNT(CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries with identified psychosocial support needs. Used to plan PSS service capacity and staffing requirements."
    - name: "chronic_illness_count"
      expr: COUNT(CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries with chronic illness. Informs health service planning and medical supply procurement decisions."
    - name: "wash_access_gap_count"
      expr: COUNT(CASE WHEN wash_access_flag = FALSE THEN vulnerability_profile_id END)
      comment: "Count of beneficiaries without adequate WASH access. Directly informs WASH program targeting and infrastructure investment decisions."
    - name: "reassessment_overdue_count"
      expr: COUNT(CASE WHEN next_reassessment_date < CURRENT_DATE() AND vulnerability_profile_status = 'Active' THEN vulnerability_profile_id END)
      comment: "Count of active vulnerability profiles past their scheduled reassessment date. Tracks data currency risk — stale profiles lead to mis-targeting and donor compliance issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management performance metrics tracking caseload volume, case resolution rates, protection risk distribution, and service delivery quality. Used by protection officers, program managers, and country directors to monitor case management effectiveness and resource allocation."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current case status (open, closed, on hold, referred) — primary filter for active caseload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of case (GBV, child protection, legal aid, nutrition, etc.) — used to disaggregate caseload by service sector."
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in the case management workflow — identifies bottlenecks in case progression."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority classification — used to ensure high-priority cases receive timely attention and resource allocation."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned to the case — drives escalation and resource prioritization decisions."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Flag for GBV cases — required for GBV-specific reporting to donors and cluster coordination bodies."
    - name: "is_child_case"
      expr: is_child_case
      comment: "Flag for child protection cases — required for child protection cluster reporting and CPMS compliance."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened — used for intake trend analysis and caseload forecasting."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Final outcome classification for closed cases — measures case resolution quality and service effectiveness."
    - name: "service_modality"
      expr: service_modality
      comment: "Service delivery modality (in-person, remote, community-based) — informs operational model effectiveness analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total case records. The primary caseload volume KPI used in program reviews, donor reports, and staffing decisions."
    - name: "open_cases"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN case_record_id END)
      comment: "Count of currently open cases. Tracks active caseload burden — used to assess staff capacity and trigger recruitment decisions."
    - name: "closed_cases"
      expr: COUNT(CASE WHEN case_status = 'Closed' THEN case_record_id END)
      comment: "Count of closed cases. Used with total_cases to compute case closure rate — a key program throughput indicator."
    - name: "gbv_case_count"
      expr: COUNT(CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Count of GBV cases. A mandatory indicator for GBV sub-cluster reporting and donor accountability frameworks."
    - name: "child_protection_case_count"
      expr: COUNT(CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Count of child protection cases. Required for child protection cluster coordination and CPMS compliance reporting."
    - name: "case_plan_developed_count"
      expr: COUNT(CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Count of cases with a developed case plan. Divide by total_cases to compute case planning compliance rate — a quality standard indicator."
    - name: "legal_aid_required_count"
      expr: COUNT(CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring legal aid. Drives legal aid service capacity planning and partner referral volume forecasting."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement at case opening. Tracks nutritional status of the case management caseload — informs integrated nutrition-protection programming."
    - name: "supervisor_review_required_count"
      expr: COUNT(CASE WHEN supervisor_review_required = TRUE THEN case_record_id END)
      comment: "Count of cases flagged for supervisor review. High values indicate complex or high-risk caseloads requiring senior staff attention and quality assurance investment."
    - name: "referral_provided_count"
      expr: COUNT(CASE WHEN referral_date IS NOT NULL THEN case_record_id END)
      comment: "Count of cases where a referral was made. Divide by total_cases to compute referral rate — measures inter-agency coordination and service linkage effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian needs assessment metrics tracking sectoral vulnerability scores, assessment coverage, and population-level needs across communities. Used by program designers, MEL teams, and cluster coordinators to prioritize interventions and allocate resources based on evidence."
  source: "`vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment`"
  dimensions:
    - name: "beneficiary_needs_assessment_status"
      expr: beneficiary_needs_assessment_status
      comment: "Assessment status (draft, validated, submitted) — filters to validated assessments for reliable analysis."
    - name: "beneficiary_needs_assessment_type"
      expr: beneficiary_needs_assessment_type
      comment: "Type of needs assessment (initial, follow-up, rapid, comprehensive) — used to compare assessment depth and coverage."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned during assessment — primary segmentation for needs-based targeting."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of assessed household — disaggregates needs by population type for cluster reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country where assessment was conducted — enables geographic comparison of needs severity."
    - name: "beneficiary_needs_assessment_date_month"
      expr: DATE_TRUNC('MONTH', beneficiary_needs_assessment_date)
      comment: "Month of assessment — tracks assessment campaign progress and seasonal needs variation."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "GBV risk flag from assessment — used to identify communities requiring GBV prevention programming."
    - name: "referral_recommended"
      expr: referral_recommended
      comment: "Whether a referral was recommended during assessment — measures unmet service needs identified in the field."
    - name: "female_headed_household"
      expr: female_headed_household
      comment: "Female-headed household indicator — standard vulnerability proxy for targeting and gender-disaggregated reporting."
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT beneficiary_needs_assessment_id)
      comment: "Total needs assessments conducted. Tracks assessment campaign coverage — used to measure progress against assessment targets."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessed households. The headline needs severity indicator used in situation reports and donor briefings."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition needs score. Drives food security and nutrition program design decisions and CMAM caseload forecasting."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection needs score. Informs protection cluster resource allocation and case management capacity planning."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH needs score. Drives WASH infrastructure investment decisions and hygiene promotion program targeting."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter needs score. Informs shelter program targeting and NFI distribution planning."
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods needs score. Guides economic recovery and cash transfer program design."
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education needs score. Informs education in emergencies program targeting and school-in-a-box distribution."
    - name: "gbv_risk_count"
      expr: COUNT(CASE WHEN gbv_risk_flag = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments with GBV risk flagged. Drives GBV prevention program geographic targeting and community mobilization planning."
    - name: "referral_recommended_count"
      expr: COUNT(CASE WHEN referral_recommended = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments where referral was recommended. Measures unmet service demand identified through assessments — informs service gap analysis."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments with confirmed consent. Divide by total_assessments to compute consent compliance rate — a CHS and GDPR accountability indicator."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement in millimetres from assessments. A direct acute malnutrition screening indicator — values below 125mm trigger therapeutic feeding program enrollment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment metrics tracking beneficiary participation rates, completion rates, and service delivery modality effectiveness. Used by program managers and M&E teams to assess program reach, retention, and quality of service delivery."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, completed, dropped, transferred) — primary filter for active participant analysis."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality of service delivery (in-person, remote, community-based) — used to compare effectiveness and cost-efficiency across delivery channels."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for enrollment exit — identifies dropout drivers and informs retention strategy improvements."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — tracks intake trends and seasonal enrollment patterns."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral into the program — measures effectiveness of different referral pathways for program intake."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total program enrollments. The primary program reach indicator used in donor reports and program reviews."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN enrollment_id END)
      comment: "Count of currently active enrollments. Tracks live program participation — used for capacity planning and staff-to-beneficiary ratio management."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN enrollment_id END)
      comment: "Count of completed enrollments. Used with total_enrollments to compute program completion rate — a key program quality and effectiveness indicator."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across enrollments. Low attendance rates signal engagement problems, access barriers, or program design issues requiring management intervention."
    - name: "consent_for_component_count"
      expr: COUNT(CASE WHEN consent_for_component = TRUE THEN enrollment_id END)
      comment: "Count of enrollments with component-specific consent obtained. Divide by total_enrollments to compute component consent compliance rate — required for data protection accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking population composition, vulnerability distribution, food security status, and registration coverage. Used by field coordinators and program managers for household targeting, distribution planning, and population monitoring."
  source: "`vibe_ngo_v1`.`beneficiary`.`household`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current household registration status — primary filter for active household caseload analysis."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Household vulnerability category — used for needs-based targeting and prioritization of assistance."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Household displacement status (IDP, refugee, host community, returnee) — required for population-disaggregated reporting."
    - name: "food_security_status"
      expr: food_security_status
      comment: "Household food security classification — drives food assistance targeting and ration planning."
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Female-headed household indicator — standard vulnerability proxy and gender equity targeting criterion."
    - name: "current_country"
      expr: current_country
      comment: "Country where the household is currently located — enables geographic distribution analysis."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of household registration — tracks registration campaign progress over time."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter occupied by the household — informs shelter program targeting and NFI distribution planning."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total registered households. The primary household coverage KPI used in distribution planning and program reach reporting."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average household vulnerability score. Tracks whether assistance is reaching the most vulnerable households — a targeting quality indicator."
    - name: "gbv_risk_household_count"
      expr: COUNT(CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Count of households with GBV risk flag. Drives GBV prevention and response program geographic targeting."
    - name: "has_pregnant_lactating_count"
      expr: COUNT(CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Count of households with pregnant or lactating women. Critical for nutrition program targeting, antenatal care referrals, and MIYCN programming."
    - name: "has_unaccompanied_minor_count"
      expr: COUNT(CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Count of households containing unaccompanied or separated children. Drives child protection case management prioritization."
    - name: "female_headed_household_count"
      expr: COUNT(CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Count of female-headed households. Used to compute female-headed household targeting rate — a standard gender equity program indicator."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_protection_flag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection monitoring metrics tracking protection risk identification, escalation rates, and resolution effectiveness. Used by protection officers, country directors, and cluster coordinators to monitor protection incident trends and response quality."
  source: "`vibe_ngo_v1`.`beneficiary`.`protection_flag`"
  dimensions:
    - name: "protection_flag_type"
      expr: protection_flag_type
      comment: "Type of protection concern flagged (GBV, child protection, SGBV, trafficking, etc.) — primary disaggregation for protection monitoring."
    - name: "protection_flag_status"
      expr: protection_flag_status
      comment: "Current status of the protection flag (active, resolved, escalated, closed) — tracks response pipeline."
    - name: "severity"
      expr: severity
      comment: "Severity level of the protection concern — used to prioritize response resources and escalation decisions."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation was required — measures the proportion of high-severity protection cases requiring senior management attention."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the protection flag — governs data sharing and access control decisions."
    - name: "protection_flag_date_month"
      expr: DATE_TRUNC('MONTH', protection_flag_date)
      comment: "Month the protection concern was flagged — tracks protection incident trends over time."
    - name: "flagging_source"
      expr: flagging_source
      comment: "Source that identified the protection concern (community referral, staff observation, hotline, etc.) — informs community feedback mechanism effectiveness."
  measures:
    - name: "total_protection_flags"
      expr: COUNT(DISTINCT protection_flag_id)
      comment: "Total protection concerns flagged. The primary protection monitoring volume indicator used in cluster coordination and donor accountability reporting."
    - name: "active_protection_flags"
      expr: COUNT(CASE WHEN is_active = TRUE THEN protection_flag_id END)
      comment: "Count of currently active (unresolved) protection flags. Tracks the open protection caseload — high values signal capacity or response gaps."
    - name: "escalated_flag_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN protection_flag_id END)
      comment: "Count of protection flags requiring escalation. Divide by total_protection_flags to compute escalation rate — a protection severity indicator used in situation reports."
    - name: "resolved_flag_count"
      expr: COUNT(CASE WHEN protection_flag_status = 'Resolved' THEN protection_flag_id END)
      comment: "Count of resolved protection flags. Used with total_protection_flags to compute resolution rate — a key protection response effectiveness indicator."
    - name: "referral_made_count"
      expr: COUNT(CASE WHEN referral_made = TRUE THEN protection_flag_id END)
      comment: "Count of protection flags where a referral was made. Measures inter-agency coordination and service linkage for protection cases."
    - name: "legal_action_required_count"
      expr: COUNT(CASE WHEN legal_action_required = TRUE THEN protection_flag_id END)
      comment: "Count of protection flags requiring legal action. Drives legal aid service demand forecasting and justice sector partnership planning."
    - name: "pss_provided_count"
      expr: COUNT(CASE WHEN pss_provided = TRUE THEN protection_flag_id END)
      comment: "Count of protection flags where psychosocial support was provided. Divide by total_protection_flags to compute PSS response coverage rate."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway metrics tracking inter-agency referral volumes, completion rates, response timeliness, and outcome quality. Used by case managers, program coordinators, and cluster leads to assess service linkage effectiveness and identify referral pathway gaps."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current referral status (pending, accepted, completed, declined, cancelled) — primary filter for active referral pipeline management."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (internal, external, emergency, routine) — used to disaggregate referral volumes by urgency and pathway."
    - name: "referral_category"
      expr: referral_category
      comment: "Service category of the referral (health, legal, psychosocial, shelter, etc.) — identifies which service sectors have highest unmet demand."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome classification of completed referrals — measures referral pathway effectiveness and service quality."
    - name: "priority_level"
      expr: priority_level
      comment: "Referral priority level — used to monitor whether high-priority referrals are being processed within required timeframes."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "GBV case flag — required for GBV referral pathway monitoring and survivor-centred response quality assessment."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral — tracks referral volume trends and seasonal service demand patterns."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Service type provided by the receiving organization — identifies which service types are most in demand and where gaps exist."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals made. The primary inter-agency coordination volume indicator used in cluster reporting and partnership reviews."
    - name: "completed_referrals"
      expr: COUNT(CASE WHEN referral_status = 'Completed' THEN referral_id END)
      comment: "Count of completed referrals. Used with total_referrals to compute referral completion rate — a key service linkage effectiveness indicator."
    - name: "declined_referrals"
      expr: COUNT(CASE WHEN referral_status = 'Declined' THEN referral_id END)
      comment: "Count of declined referrals. High decline rates signal capacity constraints at receiving organizations or inappropriate referral targeting — triggers partnership review."
    - name: "gbv_referral_count"
      expr: COUNT(CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Count of GBV-related referrals. A mandatory GBV sub-cluster indicator measuring survivor access to multi-sectoral services."
    - name: "follow_up_completed_count"
      expr: COUNT(CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Count of referrals with completed follow-up. Divide by total_referrals to compute follow-up completion rate — measures case management quality and accountability to beneficiaries."
    - name: "feedback_received_count"
      expr: COUNT(CASE WHEN feedback_received_flag = TRUE THEN referral_id END)
      comment: "Count of referrals where beneficiary feedback was received. Divide by total_referrals to compute feedback collection rate — a CHS accountability and participation indicator."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data consent compliance metrics tracking consent coverage, GDPR applicability, biometric consent rates, and consent expiry management. Used by data protection officers, compliance teams, and program managers to ensure legal and ethical data handling obligations are met."
  source: "`vibe_ngo_v1`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, withdrawn, expired, pending) — primary filter for valid consent coverage analysis."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent granted (data collection, sharing, photography, biometric) — disaggregates consent coverage by data use category."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (verbal, written, digital) — used to assess consent quality and legal defensibility."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR applies to this consent record — filters to EU-regulated data subjects for GDPR compliance reporting."
    - name: "collection_country_code"
      expr: collection_country_code
      comment: "Country where data was collected — enables country-level consent compliance monitoring."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained — tracks consent collection campaign progress."
    - name: "is_proxy_consent"
      expr: is_proxy_consent
      comment: "Whether consent was given by a proxy (e.g. for children or incapacitated adults) — required for child protection and vulnerability-sensitive data governance."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records. Tracks consent documentation coverage across the beneficiary population — a legal and ethical compliance baseline."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Active' THEN consent_record_id END)
      comment: "Count of currently active consent records. Divide by total_consent_records to compute active consent rate — the primary data protection compliance KPI."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Withdrawn' THEN consent_record_id END)
      comment: "Count of withdrawn consent records. Tracks the volume of data subjects exercising their right to withdraw — triggers data deletion workflows."
    - name: "biometric_enrollment_permitted_count"
      expr: COUNT(CASE WHEN biometric_enrollment_permitted = TRUE THEN consent_record_id END)
      comment: "Count of consent records permitting biometric enrollment. Divide by total_consent_records to compute biometric consent rate — required before any biometric data collection."
    - name: "sharing_permitted_count"
      expr: COUNT(CASE WHEN sharing_permitted = TRUE THEN consent_record_id END)
      comment: "Count of consent records permitting data sharing. Divide by total_consent_records to compute data sharing consent rate — governs inter-agency data exchange decisions."
    - name: "gdpr_applicable_count"
      expr: COUNT(CASE WHEN gdpr_applicable = TRUE THEN consent_record_id END)
      comment: "Count of consent records subject to GDPR. Tracks the EU-regulated data subject population — used for GDPR compliance reporting and DPA obligations."
    - name: "expired_consent_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND consent_status = 'Active' THEN consent_record_id END)
      comment: "Count of consent records past their expiry date but still marked active. A critical data governance risk indicator — expired consents must be renewed or data deleted."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_exit_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary exit and program completion metrics tracking exit reasons, post-exit follow-up compliance, and data retention management. Used by program managers and M&E teams to assess program completion quality, understand dropout drivers, and ensure responsible data lifecycle management."
  source: "`vibe_ngo_v1`.`beneficiary`.`exit_record`"
  dimensions:
    - name: "exit_status"
      expr: exit_status
      comment: "Current exit record status — filters to confirmed exits for accurate program completion analysis."
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Categorical reason for exit (program completion, dropout, death, relocation, transfer) — primary disaggregation for understanding exit drivers."
    - name: "exit_assessment_outcome"
      expr: exit_assessment_outcome
      comment: "Outcome of the exit assessment — measures whether beneficiaries achieved program objectives at exit."
    - name: "data_retention_classification"
      expr: data_retention_classification
      comment: "Data retention classification for the exit record — governs data lifecycle management and deletion scheduling."
    - name: "exit_date_month"
      expr: DATE_TRUNC('MONTH', exit_date)
      comment: "Month of exit — tracks exit volume trends and identifies periods of high dropout."
    - name: "reactivation_eligible"
      expr: reactivation_eligible
      comment: "Whether the exited beneficiary is eligible for re-enrollment — used to manage re-registration pipelines."
    - name: "referral_provided"
      expr: referral_provided
      comment: "Whether a referral was provided at exit — measures responsible exit practice and continuity of care quality."
  measures:
    - name: "total_exits"
      expr: COUNT(DISTINCT exit_record_id)
      comment: "Total beneficiary exits. Tracks program attrition volume — used with enrollment data to compute retention rates and assess program sustainability."
    - name: "exit_assessment_conducted_count"
      expr: COUNT(CASE WHEN exit_assessment_conducted = TRUE THEN exit_record_id END)
      comment: "Count of exits with a conducted exit assessment. Divide by total_exits to compute exit assessment coverage rate — a program quality and accountability indicator."
    - name: "post_exit_followup_required_count"
      expr: COUNT(CASE WHEN post_exit_followup_required = TRUE THEN exit_record_id END)
      comment: "Count of exits requiring post-exit follow-up. Tracks the volume of beneficiaries needing continued monitoring after program exit — informs alumni tracking resource planning."
    - name: "referral_at_exit_count"
      expr: COUNT(CASE WHEN referral_provided = TRUE THEN exit_record_id END)
      comment: "Count of exits where a referral was provided. Divide by total_exits to compute responsible exit referral rate — a CHS standard 4 compliance indicator."
    - name: "death_verified_count"
      expr: COUNT(CASE WHEN death_certificate_verified = TRUE THEN exit_record_id END)
      comment: "Count of exits due to verified death. Tracks mortality within the beneficiary caseload — a critical humanitarian outcome indicator for protection and health programs."
    - name: "duplicate_merge_exit_count"
      expr: COUNT(CASE WHEN is_duplicate_merge = TRUE THEN exit_record_id END)
      comment: "Count of exits resulting from duplicate record merges. Tracks deduplication-driven record consolidation — high values indicate registration data quality issues."
$$;