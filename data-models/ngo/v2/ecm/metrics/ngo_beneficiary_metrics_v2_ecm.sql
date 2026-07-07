-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the registrant master — the primary person-of-concern record. Tracks registration pipeline health, vulnerability composition, deduplication quality, and protection caseload. Feeds executive dashboards, donor reports, and UNHCR/cluster 3W reporting. PII sensitivity: given_name, family_name, date_of_birth, nationality_code, country_of_origin_code are pii_beneficiary_protected and must be masked in non-prod per the masking-policy set in the README."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (e.g. Active, Pending, Deregistered). Primary filter for active caseload reporting."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g. New, Re-registration, Verification). Distinguishes first-time registrations from renewals."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel through which registration was captured (e.g. Mobile, Fixed Site, Remote). Informs field deployment decisions."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability tier assigned to the registrant (e.g. Extreme, High, Medium, Low). Core targeting dimension."
    - name: "sex"
      expr: sex
      comment: "Sex of the registrant. Required for gender-disaggregated reporting to donors and clusters."
    - name: "poc_category"
      expr: poc_category
      comment: "UNHCR person-of-concern category (e.g. Refugee, IDP, Asylum Seeker, Stateless). Drives eligibility and mandate reporting."
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO nationality code. Used for country-of-origin disaggregation in donor and cluster reports. pii_beneficiary_protected — mask in non-prod."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin ISO code. Key dimension for displacement flow analysis. pii_beneficiary_protected — mask in non-prod."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication resolution status (e.g. Unique, Duplicate, Pending). Tracks data quality of the registry."
    - name: "has_disability"
      expr: has_disability
      comment: "Boolean flag indicating the registrant has a reported disability. Required for disability-inclusive programming metrics."
    - name: "is_unaccompanied_minor"
      expr: is_unaccompanied_minor
      comment: "Boolean flag for unaccompanied and separated children (UASC). Critical child-protection targeting dimension."
    - name: "is_gbv_survivor"
      expr: is_gbv_survivor
      comment: "Boolean flag indicating GBV survivor status. Sensitive — pii_beneficiary_protected. Drives GBV case management targeting."
    - name: "registration_source_system"
      expr: registration_source_system
      comment: "Source system that originated the registration (e.g. UNHCR proGres, Kobo, CommCare). Used for data lineage and quality audits."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration. Enables trend analysis of registration intake over time."
    - name: "registration_date_year"
      expr: YEAR(registration_date)
      comment: "Year of registration. Supports annual caseload growth reporting."
  measures:
    - name: "total_registered_individuals"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total unique registered individuals. The primary caseload headcount KPI reported to donors, clusters, and leadership. Answers: how many people are we serving?"
    - name: "active_registrant_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN registrant_id END)
      comment: "Count of registrants with Active status. Drives resource allocation and capacity planning decisions."
    - name: "protection_flagged_count"
      expr: COUNT(DISTINCT CASE WHEN protection_flag = TRUE THEN registrant_id END)
      comment: "Number of registrants with an active protection flag. Signals protection caseload volume requiring immediate case management response."
    - name: "gbv_survivor_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Count of registered GBV survivors. Informs GBV program resourcing and donor reporting. pii_beneficiary_protected — aggregate only, never expose individual records in non-prod."
    - name: "unaccompanied_minor_count"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied and separated children. Critical child-protection KPI for UNICEF/cluster reporting and case management staffing."
    - name: "persons_with_disability_count"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of registrants with a reported disability. Required for disability-inclusive programming compliance and donor reporting."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across registrants. Tracks overall population vulnerability trend; a rising score signals deteriorating conditions requiring program scale-up."
    - name: "high_vulnerability_count"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_category IN ('Extreme', 'High') THEN registrant_id END)
      comment: "Count of registrants in Extreme or High vulnerability categories. Primary targeting metric for priority assistance allocation."
    - name: "duplicate_pending_count"
      expr: COUNT(DISTINCT CASE WHEN deduplication_status = 'Pending' THEN registrant_id END)
      comment: "Count of registrants with unresolved deduplication status. A high value indicates data quality risk and potential double-counting of beneficiaries in donor reports."
    - name: "avg_registration_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records. Low scores indicate data quality gaps that undermine targeting accuracy and donor audit readiness."
    - name: "pregnant_or_lactating_count"
      expr: COUNT(DISTINCT CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Count of pregnant or lactating women in the registry. Drives nutrition program targeting and maternal health service planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs covering registration pipeline, vulnerability composition, food security, and shelter conditions. The household is the primary unit of assistance in most humanitarian programs. Feeds 3W reporting, cluster dashboards, and program targeting. PII sensitivity: household-level location data (gps_latitude, gps_longitude) is pii_beneficiary_protected."
  source: "`vibe_ngo_v1`.`beneficiary`.`household`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current household registration status (e.g. Active, Deregistered, Pending). Primary filter for active caseload."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of household registration (e.g. New, Re-registration). Distinguishes intake from renewal."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household (e.g. IDP, Refugee, Host Community, Returnee). Core targeting and reporting dimension."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability tier of the household. Drives priority assistance targeting."
    - name: "food_security_status"
      expr: food_security_status
      comment: "Food security classification (e.g. IPC Phase 1-5). Critical for food assistance program targeting and cluster reporting."
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Boolean flag for female-headed households. Required for gender-disaggregated reporting and targeted programming."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter occupied (e.g. Tent, Makeshift, Permanent). Informs shelter program targeting."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Primary water source type. Informs WASH program targeting and Sphere standard compliance monitoring."
    - name: "current_country"
      expr: current_country
      comment: "Country where the household is currently located. Geographic dimension for country-level program reporting."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Admin level 1 (province/state) name. Geographic disaggregation for sub-national program management."
    - name: "admin2_name"
      expr: admin2_name
      comment: "Admin level 2 (district) name. Granular geographic targeting dimension."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of household registration. Enables intake trend analysis."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique registered households. Primary caseload unit for most humanitarian programs; reported to donors and clusters."
    - name: "active_household_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN household_id END)
      comment: "Count of households with Active registration status. Drives resource allocation and distribution planning."
    - name: "female_headed_household_count"
      expr: COUNT(DISTINCT CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Count of female-headed households. Required for gender-responsive programming and donor gender-marker reporting."
    - name: "gbv_risk_household_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Count of households with an active GBV risk flag. Informs protection case management resourcing and referral pathway activation."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average vulnerability score across households. Tracks population vulnerability trend; rising scores trigger program scale-up decisions."
    - name: "has_pregnant_lactating_count"
      expr: COUNT(DISTINCT CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Count of households with at least one pregnant or lactating woman. Drives nutrition program targeting and maternal health service planning."
    - name: "has_unaccompanied_minor_count"
      expr: COUNT(DISTINCT CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Count of households containing an unaccompanied or separated child. Critical child-protection KPI for UNICEF and cluster reporting."
    - name: "high_vulnerability_household_count"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_category IN ('Extreme', 'High') THEN household_id END)
      comment: "Count of households in Extreme or High vulnerability categories. Primary metric for priority assistance targeting decisions."
    - name: "ipc_phase4_5_household_count"
      expr: COUNT(DISTINCT CASE WHEN food_security_status IN ('IPC Phase 4', 'IPC Phase 5', 'Phase 4', 'Phase 5') THEN household_id END)
      comment: "Count of households in IPC Phase 4 (Emergency) or Phase 5 (Catastrophe) food security. Triggers emergency food assistance scale-up and donor escalation."
    - name: "deregistered_household_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Deregistered' THEN household_id END)
      comment: "Count of deregistered households. Tracks program exit volume; high rates may indicate displacement, graduation, or data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling KPIs tracking population vulnerability composition, score distributions, and protection risk levels. Used by program teams to target assistance, by MEL teams to track vulnerability trends over time, and by donors to verify targeting criteria. Feeds UNHCR vulnerability scoring frameworks and WFP VAM analysis. PII sensitivity: vulnerability profiles are pii_beneficiary_protected."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Categorical vulnerability tier (e.g. Extreme, High, Medium, Low). Primary targeting and reporting dimension."
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the vulnerability profile (e.g. Active, Superseded, Draft). Filters to current profiles."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned in the profile. Drives protection case management prioritization."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category (e.g. IDP, Refugee, Returnee). Disaggregates vulnerability by displacement type."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase recorded in the profile. Links vulnerability to food security severity."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Boolean flag for female-headed households. Required for gender-disaggregated vulnerability reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country code where the profile was assessed. Geographic dimension for country-level vulnerability analysis."
    - name: "assessment_tool"
      expr: assessment_tool
      comment: "Tool used for vulnerability assessment (e.g. UNHCR VAF, WFP CARI, Kobo). Tracks methodology consistency."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of vulnerability assessment. Enables trend analysis of vulnerability score changes over time."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the household. Informs livelihoods program targeting."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total vulnerability profiles assessed. Tracks assessment coverage across the registered population."
    - name: "active_profile_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'Active' THEN vulnerability_profile_id END)
      comment: "Count of currently active vulnerability profiles. Represents the population with a current, valid vulnerability assessment."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all profiles. The headline vulnerability trend metric; a rising average triggers program scale-up and donor escalation."
    - name: "extreme_vulnerability_count"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier = 'Extreme' THEN vulnerability_profile_id END)
      comment: "Count of profiles in the Extreme vulnerability tier. Drives immediate priority assistance targeting and emergency response activation."
    - name: "protection_high_risk_count"
      expr: COUNT(DISTINCT CASE WHEN protection_risk_level IN ('High', 'Critical') THEN vulnerability_profile_id END)
      comment: "Count of profiles with High or Critical protection risk. Informs protection officer caseload allocation and referral pathway activation."
    - name: "gbv_exposure_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with GBV exposure flag. Drives GBV program resourcing and survivor support service planning. pii_beneficiary_protected — aggregate only."
    - name: "chronic_illness_count"
      expr: COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with chronic illness. Informs health program targeting and medical supply planning."
    - name: "pss_need_count"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles indicating psychosocial support need. Drives PSS program staffing and session planning."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average mid-upper arm circumference in mm across profiles. Key nutrition screening metric; values below 125mm trigger acute malnutrition response."
    - name: "reassessment_overdue_count"
      expr: COUNT(DISTINCT CASE WHEN next_reassessment_date < CURRENT_DATE() AND profile_status = 'Active' THEN vulnerability_profile_id END)
      comment: "Count of active profiles where the reassessment date has passed. Tracks data currency risk; high values indicate stale targeting data that undermines program accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Needs assessment KPIs tracking sectoral vulnerability scores, assessment coverage, and data quality across the registered population. Used by program teams to prioritize sectoral interventions, by MEL teams to track assessment quality, and by cluster coordinators for 3W reporting. Feeds Kobo Toolbox and ODK aggregate analysis pipelines. PII sensitivity: assessment records are pii_beneficiary_protected."
  source: "`vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment conducted (e.g. Initial, Periodic, Emergency). Distinguishes intake from follow-up assessments."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Complete, Pending Validation, Rejected). Filters to validated assessments for reporting."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned by the assessment. Primary targeting dimension."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed individual/household. Disaggregates needs by displacement type."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assessment was conducted. Geographic dimension for country-level needs analysis."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Admin level 1 name. Sub-national geographic disaggregation for field program management."
    - name: "assessment_level"
      expr: assessment_level
      comment: "Level of assessment (e.g. Individual, Household, Community). Determines unit of analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect assessment data (e.g. Face-to-face, Remote, KoboCollect). Tracks methodology for quality assurance."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Boolean GBV risk flag from the assessment. Disaggregates needs by GBV risk status."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment. Enables trend analysis of assessment intake and sectoral score changes."
    - name: "referral_recommended"
      expr: referral_recommended
      comment: "Boolean flag indicating a referral was recommended. Tracks referral pipeline generation from assessments."
  measures:
    - name: "total_assessments_conducted"
      expr: COUNT(DISTINCT beneficiary_needs_assessment_id)
      comment: "Total needs assessments conducted. Tracks assessment coverage; compared against registered population to identify unassessed individuals."
    - name: "validated_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'Complete' THEN beneficiary_needs_assessment_id END)
      comment: "Count of fully validated assessments. Represents the usable data pool for targeting decisions; low rates indicate data quality bottlenecks."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average overall vulnerability score across all assessments. Headline population vulnerability metric for program steering and donor reporting."
    - name: "avg_food_security_score"
      expr: AVG(CAST(food_security_score AS DOUBLE))
      comment: "Average food security score. Tracks food security trend; declining scores trigger food assistance scale-up decisions."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection score. Tracks protection risk trend across the assessed population; informs protection program resourcing."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition score. Tracks acute malnutrition risk; declining scores trigger CMAM program activation."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH score. Tracks water, sanitation, and hygiene access; informs WASH program targeting and Sphere standard compliance."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter score. Tracks shelter adequacy; informs shelter program targeting and NFI distribution planning."
    - name: "referral_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments where a referral was recommended. Tracks referral pipeline volume; high rates signal service gap or protection concern requiring partner coordination."
    - name: "gbv_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments with GBV risk flag. Informs GBV program resourcing and referral pathway activation. pii_beneficiary_protected — aggregate only."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement in mm from assessments. Key acute malnutrition screening metric; values below 125mm trigger CMAM enrollment."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where informed consent was obtained. Compliance KPI for CHS Standard 1 and donor data protection requirements; rates below 100% require immediate investigation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management KPIs tracking caseload volume, case type composition, resolution rates, and protection risk. Used by case management supervisors to manage workload, by program managers to track service delivery quality, and by donors for protection program reporting. Aligns with Primero/CPIMS+ case management standards. PII sensitivity: case records are pii_beneficiary_protected; case_narrative is highly sensitive."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g. GBV, Child Protection, Legal Aid, PSS). Primary dimension for caseload composition analysis."
    - name: "case_status"
      expr: case_status
      comment: "Current case status (e.g. Open, Closed, On Hold, Referred). Tracks case pipeline and resolution."
    - name: "case_stage"
      expr: case_stage
      comment: "Stage in the case management cycle (e.g. Intake, Assessment, Planning, Follow-up, Closure). Tracks case progression."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority level (e.g. Emergency, High, Medium, Low). Drives case management workload prioritization."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned to the case. Informs escalation and resource allocation decisions."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Boolean flag for GBV cases. Disaggregates caseload by GBV status for specialized program reporting."
    - name: "is_child_case"
      expr: is_child_case
      comment: "Boolean flag for child protection cases. Required for UNICEF and child protection cluster reporting."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Classification of case outcome (e.g. Resolved, Referred, Deceased, Lost to Follow-up). Tracks case resolution quality."
    - name: "service_modality"
      expr: service_modality
      comment: "Modality of service delivery (e.g. In-person, Remote, Home Visit). Informs service delivery model decisions."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened. Enables trend analysis of case intake over time."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total case records. Primary caseload volume metric for case management program reporting."
    - name: "open_case_count"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN case_record_id END)
      comment: "Count of currently open cases. Tracks active caseload; drives case management staffing and supervision decisions."
    - name: "gbv_case_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Count of GBV cases. Core GBV program KPI for donor reporting and specialized service resourcing. pii_beneficiary_protected — aggregate only."
    - name: "child_protection_case_count"
      expr: COUNT(DISTINCT CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Count of child protection cases. Required for UNICEF, child protection cluster, and Primero reporting."
    - name: "case_plan_developed_count"
      expr: COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Count of cases with a developed case plan. Tracks case management quality; low rates indicate supervision gaps."
    - name: "safety_plan_in_place_count"
      expr: COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END)
      comment: "Count of cases with a safety plan in place. Critical protection quality metric; low rates for high-risk cases trigger immediate supervisory action."
    - name: "supervisor_review_required_count"
      expr: COUNT(DISTINCT CASE WHEN supervisor_review_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring supervisor review. Tracks supervision workload and escalation pipeline."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement in cm from case records. Tracks nutrition status of case management clients; low values trigger nutrition referrals."
    - name: "legal_aid_required_count"
      expr: COUNT(DISTINCT CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring legal aid. Informs legal aid program resourcing and partner referral planning."
    - name: "high_protection_risk_count"
      expr: COUNT(DISTINCT CASE WHEN protection_risk_level IN ('High', 'Critical', 'Extreme') THEN case_record_id END)
      comment: "Count of cases with High, Critical, or Extreme protection risk. Drives immediate case management escalation and resource prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway KPIs tracking referral volume, completion rates, response timeliness, and outcome quality. Used by case managers to monitor referral follow-through, by program managers to assess partner service delivery, and by protection coordinators to identify service gaps. Aligns with inter-agency referral pathway standards. PII sensitivity: referral records are pii_beneficiary_protected."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g. Internal, External, Emergency). Distinguishes within-organization from inter-agency referrals."
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g. Pending, Accepted, Declined, Completed). Tracks referral pipeline."
    - name: "referral_category"
      expr: referral_category
      comment: "Category of referral (e.g. Health, Legal, Shelter, PSS, GBV). Tracks service gap patterns by sector."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service the referral is directed to. Informs service mapping and gap analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral (e.g. Emergency, High, Routine). Drives response time expectations."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Boolean flag for GBV-related referrals. Disaggregates referral metrics by GBV status for specialized reporting."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the referral (e.g. Service Received, Declined by Client, Service Unavailable). Tracks referral effectiveness."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made. Enables trend analysis of referral volume and completion rates."
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Boolean flag indicating a protection concern associated with the referral. Tracks protection-sensitive referral volume."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals made. Primary referral pathway volume metric for program and partner coordination reporting."
    - name: "completed_referral_count"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'Completed' THEN referral_id END)
      comment: "Count of completed referrals. Tracks referral follow-through; low completion rates indicate service gaps or partner capacity issues."
    - name: "referral_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that reached completion. Key service delivery quality KPI; low rates trigger partner performance reviews and pathway redesign."
    - name: "declined_referral_count"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'Declined' THEN referral_id END)
      comment: "Count of declined referrals. High decline rates signal service unavailability or access barriers requiring program response."
    - name: "gbv_referral_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Count of GBV-related referrals. Core GBV program metric for survivor pathway monitoring and donor reporting. pii_beneficiary_protected — aggregate only."
    - name: "feedback_received_count"
      expr: COUNT(DISTINCT CASE WHEN feedback_received_flag = TRUE THEN referral_id END)
      comment: "Count of referrals where feedback was received from the client. Tracks accountability to affected populations (AAP) compliance."
    - name: "follow_up_completed_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Count of referrals with completed follow-up. Tracks case management quality; low rates indicate supervision gaps."
    - name: "emergency_referral_count"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'Emergency' THEN referral_id END)
      comment: "Count of emergency-priority referrals. Tracks urgent protection and medical referral volume; high rates signal acute crisis conditions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment KPIs tracking enrollment volume, completion rates, attendance, and exit patterns. Used by program managers to monitor program uptake and retention, by MEL teams to track participation rates, and by donors for program reach reporting. Feeds DHIS2 aggregate reporting and program logframe tracking."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g. Active, Completed, Dropped Out, Transferred). Tracks enrollment pipeline."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality of service delivery (e.g. In-person, Remote, Hybrid). Informs delivery model effectiveness analysis."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and voucher assistance transfer modality (e.g. Mobile Money, Hawala, Voucher). Tracks CVA delivery channel mix."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for enrollment exit (e.g. Graduated, Dropped Out, Relocated, Deceased). Tracks exit pattern composition."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the enrollment referral. Tracks enrollment intake channel effectiveness."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment. Enables trend analysis of program intake over time."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of enrollment completion. Tracks program graduation cohort timing."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total enrollment records. Primary program reach metric; reported to donors as direct beneficiary count."
    - name: "active_enrollment_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Active' THEN enrollment_id END)
      comment: "Count of currently active enrollments. Tracks live program participation; drives service delivery capacity planning."
    - name: "completed_enrollment_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN enrollment_id END)
      comment: "Count of completed enrollments. Tracks program graduation volume; key output metric for donor reporting."
    - name: "enrollment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that reached completion. Program quality KPI; low rates trigger dropout analysis and program design review."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across enrollments. Tracks program engagement quality; low rates indicate access barriers or program relevance issues."
    - name: "dropout_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Dropped Out' THEN enrollment_id END)
      comment: "Count of dropout enrollments. Tracks program attrition; high rates trigger root cause analysis and program adaptation."
    - name: "consent_for_component_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_for_component = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with informed consent recorded for the component. Compliance KPI for CHS and donor data protection requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_cva_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash and Voucher Assistance (CVA) transfer KPIs tracking transfer volume, value, delivery modality mix, and reconciliation status. Used by program managers to monitor CVA delivery performance, by finance teams for reconciliation, and by donors for CVA program reporting. Aligns with CaLP CVA standards and CALP reporting frameworks."
  source: "`vibe_ngo_v1`.`beneficiary`.`cva_transfer`"
  dimensions:
    - name: "cva_transfer_status"
      expr: cva_transfer_status
      comment: "Current status of the CVA transfer (e.g. Pending, Transferred, Failed, Reconciled). Tracks transfer pipeline."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Transfer modality (e.g. Cash, Voucher, In-Kind). Tracks CVA modality mix for program design decisions."
    - name: "delivery_mechanism"
      expr: delivery_mechanism
      comment: "Delivery mechanism (e.g. Mobile Money, Bank Transfer, Hawala, ATM). Informs FSP performance and access analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transfer (e.g. Reconciled, Pending, Discrepancy). Tracks financial accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer. Required for multi-currency CVA program financial reporting."
    - name: "transfer_date_month"
      expr: DATE_TRUNC('MONTH', transfer_date)
      comment: "Month of transfer. Enables trend analysis of CVA disbursement over time."
  measures:
    - name: "total_transfers"
      expr: COUNT(DISTINCT cva_transfer_id)
      comment: "Total CVA transfers initiated. Primary CVA program reach metric."
    - name: "successful_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN cva_transfer_status = 'Transferred' THEN cva_transfer_id END)
      comment: "Count of successfully completed transfers. Tracks CVA delivery success rate; low rates indicate FSP performance or access issues."
    - name: "total_transfer_amount"
      expr: SUM(CAST(transfer_amount AS DOUBLE))
      comment: "Total value of CVA transfers. Primary financial KPI for CVA program; reported to donors as total cash disbursed."
    - name: "avg_transfer_amount"
      expr: AVG(CAST(transfer_amount AS DOUBLE))
      comment: "Average transfer amount per transaction. Tracks transfer value against MEB benchmarks; deviations trigger program design review."
    - name: "failed_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN cva_transfer_status = 'Failed' THEN cva_transfer_id END)
      comment: "Count of failed transfers. High failure rates indicate FSP performance issues, access barriers, or data quality problems requiring immediate action."
    - name: "transfer_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cva_transfer_status = 'Transferred' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers successfully completed. Key CVA delivery performance KPI; rates below threshold trigger FSP review and contingency planning."
    - name: "unreconciled_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status = 'Pending' THEN cva_transfer_id END)
      comment: "Count of transfers pending reconciliation. Tracks financial accountability risk; high values trigger finance team escalation and donor audit risk."
    - name: "total_unreconciled_amount"
      expr: SUM(CASE WHEN reconciliation_status = 'Pending' THEN transfer_amount ELSE 0 END)
      comment: "Total value of unreconciled transfers. Financial accountability KPI; high values represent audit risk and potential donor compliance issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_protection_flag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection flag KPIs tracking protection concern volume, severity distribution, escalation rates, and resolution timeliness. Used by protection officers to manage caseloads, by program managers to assess protection risk trends, and by donors for protection program reporting. Aligns with UNHCR protection monitoring standards and CPIMS+ frameworks. PII sensitivity: protection flags are pii_beneficiary_protected — highest sensitivity tier."
  source: "`vibe_ngo_v1`.`beneficiary`.`protection_flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Type of protection flag (e.g. GBV, Child Protection, Trafficking, Detention). Primary dimension for protection concern categorization."
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the flag (e.g. Active, Resolved, Escalated, Closed). Tracks protection flag pipeline."
    - name: "flag_severity"
      expr: flag_severity
      comment: "Severity level of the protection flag (e.g. Critical, High, Medium, Low). Drives prioritization and escalation decisions."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the flag. Governs data access and sharing restrictions."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean flag indicating escalation is required. Tracks escalation pipeline volume."
    - name: "flagging_source"
      expr: flagging_source
      comment: "Source that generated the flag (e.g. Case Worker, Community Volunteer, Hotline). Tracks flag intake channel."
    - name: "flag_date_month"
      expr: DATE_TRUNC('MONTH', flag_date)
      comment: "Month the flag was raised. Enables trend analysis of protection concern incidence over time."
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating the flag is currently active. Filters to live protection concerns."
  measures:
    - name: "total_protection_flags"
      expr: COUNT(DISTINCT protection_flag_id)
      comment: "Total protection flags raised. Primary protection monitoring volume metric for program and donor reporting."
    - name: "active_protection_flag_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN protection_flag_id END)
      comment: "Count of currently active protection flags. Tracks live protection caseload; drives protection officer staffing decisions."
    - name: "critical_flag_count"
      expr: COUNT(DISTINCT CASE WHEN flag_severity IN ('Critical', 'High') THEN protection_flag_id END)
      comment: "Count of Critical or High severity protection flags. Drives immediate escalation and resource prioritization decisions."
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags requiring escalation. Tracks escalation pipeline; high rates signal systemic protection risk requiring senior management attention."
    - name: "referral_made_count"
      expr: COUNT(DISTINCT CASE WHEN referral_made = TRUE THEN protection_flag_id END)
      comment: "Count of flags where a referral was made. Tracks protection response activation rate."
    - name: "referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags that resulted in a referral. Tracks protection response quality; low rates for high-severity flags trigger supervisory review."
    - name: "pss_provided_count"
      expr: COUNT(DISTINCT CASE WHEN pss_provided = TRUE THEN protection_flag_id END)
      comment: "Count of flags where psychosocial support was provided. Tracks PSS service delivery against protection caseload."
    - name: "legal_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN legal_action_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags requiring legal action. Informs legal aid program resourcing and partner referral planning."
    - name: "resolved_flag_count"
      expr: COUNT(DISTINCT CASE WHEN flag_status = 'Resolved' THEN protection_flag_id END)
      comment: "Count of resolved protection flags. Tracks protection case resolution rate; low rates indicate case management capacity constraints."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_biometric_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biometric enrollment and deduplication KPIs tracking biometric capture quality, deduplication effectiveness, and consent compliance. Used by registration managers to monitor biometric program quality, by data protection officers for consent compliance, and by program managers to assess deduplication coverage. Aligns with UNHCR biometric data protection standards. PII sensitivity: biometric records are the highest sensitivity tier — pii_beneficiary_protected with phi classification; template_reference must never be exposed in non-prod."
  source: "`vibe_ngo_v1`.`beneficiary`.`biometric_record`"
  dimensions:
    - name: "biometric_modality"
      expr: biometric_modality
      comment: "Type of biometric captured (e.g. Fingerprint, Iris, Face). Tracks biometric modality mix."
    - name: "enrollment_purpose"
      expr: enrollment_purpose
      comment: "Purpose of biometric enrollment (e.g. Registration, Verification, Deduplication). Tracks use-case distribution."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status of the biometric record. Tracks verification pipeline."
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating the biometric record is currently active. Filters to live records."
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Boolean indicating biometric consent was obtained. Critical compliance dimension."
    - name: "deduplication_performed"
      expr: deduplication_performed
      comment: "Boolean indicating deduplication was performed. Tracks deduplication coverage."
    - name: "deduplication_match_found"
      expr: deduplication_match_found
      comment: "Boolean indicating a duplicate match was found. Tracks duplicate detection rate."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of biometric enrollment. Enables trend analysis of biometric capture volume."
  measures:
    - name: "total_biometric_enrollments"
      expr: COUNT(DISTINCT biometric_record_id)
      comment: "Total biometric records enrolled. Tracks biometric program coverage against registered population."
    - name: "active_biometric_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN biometric_record_id END)
      comment: "Count of active biometric records. Represents the live biometric-enabled population for verification-based assistance delivery."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric enrollments with consent obtained. Critical data protection compliance KPI; rates below 100% represent legal and donor audit risk."
    - name: "quality_threshold_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_threshold_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric captures meeting quality threshold. Tracks capture quality; low rates indicate device issues or operator training gaps."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average biometric capture quality score. Tracks overall biometric data quality; declining scores trigger device maintenance or operator retraining."
    - name: "deduplication_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deduplication_performed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric records that underwent deduplication. Tracks deduplication program coverage; low rates indicate data integrity risk."
    - name: "duplicate_detection_count"
      expr: COUNT(DISTINCT CASE WHEN deduplication_match_found = TRUE THEN biometric_record_id END)
      comment: "Count of biometric records where a duplicate match was found. Tracks duplicate detection volume; informs registry data quality and potential fraud risk."
    - name: "avg_deduplication_match_score"
      expr: AVG(CASE WHEN deduplication_match_found = TRUE THEN deduplication_match_score END)
      comment: "Average deduplication match score for records where a match was found. Tracks match confidence quality; low scores indicate ambiguous duplicates requiring manual review."
    - name: "encryption_applied_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric records with encryption applied. Data security compliance KPI; rates below 100% represent critical security and donor audit risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Registration event KPIs tracking registration throughput, data quality, deduplication performance, and consent compliance at the event level. Used by registration managers to monitor field registration operations, by data quality teams to track completeness, and by program managers for intake reporting. Aligns with UNHCR proGres v4 and Kobo/ODK registration workflows. PII sensitivity: registering_staff_name is pii_staff per VREQ-055 — mask in non-prod."
  source: "`vibe_ngo_v1`.`beneficiary`.`registration_event`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the registration event (e.g. Complete, Pending, Rejected). Tracks registration pipeline quality."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g. New, Re-registration, Verification Update). Distinguishes intake types."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel of registration (e.g. Mobile, Fixed Site, Remote). Informs field deployment and resource allocation."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system for the registration event (e.g. proGres, Kobo, CommCare). Tracks data lineage."
    - name: "registration_tool"
      expr: registration_tool
      comment: "Tool used for registration (e.g. KoboCollect, ODK, proGres). Tracks tool adoption and data quality by tool."
    - name: "biometric_captured"
      expr: biometric_captured
      comment: "Boolean indicating biometrics were captured during registration. Tracks biometric enrollment coverage."
    - name: "duplicate_found"
      expr: duplicate_found
      comment: "Boolean indicating a duplicate was detected during registration. Tracks deduplication outcomes."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean data quality flag (BOOLEAN per VREQ-054 type correction). Tracks records with data quality issues requiring review."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration event. Enables trend analysis of registration intake volume."
    - name: "household_registration"
      expr: household_registration
      comment: "Boolean indicating this was a household-level registration event. Distinguishes individual from household registrations."
  measures:
    - name: "total_registration_events"
      expr: COUNT(DISTINCT registration_event_id)
      comment: "Total registration events recorded. Tracks registration operation throughput; primary field operations KPI."
    - name: "completed_registration_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Complete' THEN registration_event_id END)
      comment: "Count of completed registration events. Tracks successful registration throughput against field targets."
    - name: "biometric_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biometric_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registration events with biometrics captured. Tracks biometric enrollment coverage; low rates indicate device availability or consent issues."
    - name: "deduplication_check_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deduplication_check_performed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations where a deduplication check was performed. Tracks deduplication protocol compliance; low rates indicate data integrity risk."
    - name: "duplicate_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_found = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN deduplication_check_performed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of deduplication checks that found a duplicate. Tracks registry data quality; high rates indicate systemic re-registration or fraud risk."
    - name: "data_quality_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registration events with a data quality flag (BOOLEAN per VREQ-054). Tracks data quality issues requiring remediation; high rates indicate field data collection problems."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registration events with consent obtained. CHS and donor compliance KPI; rates below 100% require immediate investigation."
    - name: "avg_registration_completeness_score"
      expr: AVG(CAST(registration_completeness_score AS DOUBLE))
      comment: "Average registration completeness score (DECIMAL per VREQ-054). Tracks data completeness quality; low scores indicate field data collection gaps undermining targeting accuracy."
    - name: "vulnerability_assessment_conducted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vulnerability_assessment_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registration events where a vulnerability assessment was conducted. Tracks targeting data coverage; low rates indicate assessment protocol gaps."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_exit_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program exit KPIs tracking exit volume, exit reason composition, post-exit follow-up compliance, and data retention management. Used by program managers to monitor program graduation and attrition, by MEL teams to track exit outcomes, and by data protection officers for data retention compliance. Feeds program closeout reporting and donor final reports."
  source: "`vibe_ngo_v1`.`beneficiary`.`exit_record`"
  dimensions:
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Category of exit reason (e.g. Graduated, Relocated, Deceased, Duplicate Merge, Voluntary Exit). Tracks exit composition for program quality analysis."
    - name: "exit_status"
      expr: exit_status
      comment: "Current status of the exit record (e.g. Confirmed, Pending, Reversed). Tracks exit pipeline."
    - name: "exit_consent_obtained"
      expr: exit_consent_obtained
      comment: "Boolean indicating exit consent was obtained. Tracks data protection compliance at exit."
    - name: "post_exit_followup_required"
      expr: post_exit_followup_required
      comment: "Boolean indicating post-exit follow-up is required. Tracks follow-up obligation pipeline."
    - name: "reactivation_eligible"
      expr: reactivation_eligible
      comment: "Boolean indicating the exited beneficiary is eligible for reactivation. Tracks potential re-enrollment pipeline."
    - name: "data_retention_classification"
      expr: data_retention_classification
      comment: "Data retention classification assigned at exit. Governs data lifecycle management and compliance."
    - name: "exit_date_month"
      expr: DATE_TRUNC('MONTH', exit_date)
      comment: "Month of exit. Enables trend analysis of program exit volume over time."
    - name: "is_duplicate_merge"
      expr: is_duplicate_merge
      comment: "Boolean indicating the exit was due to a duplicate merge. Tracks deduplication-driven exits separately from genuine program exits."
  measures:
    - name: "total_exits"
      expr: COUNT(DISTINCT exit_record_id)
      comment: "Total program exits recorded. Tracks program attrition and graduation volume; key metric for program lifecycle management."
    - name: "graduated_exit_count"
      expr: COUNT(DISTINCT CASE WHEN exit_reason_category = 'Graduated' THEN exit_record_id END)
      comment: "Count of exits due to graduation. Primary program success metric; tracks positive program completion against targets."
    - name: "exit_assessment_conducted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_assessment_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits where an exit assessment was conducted. Tracks program quality and data collection compliance at exit; low rates indicate process gaps."
    - name: "post_exit_followup_pending_count"
      expr: COUNT(DISTINCT CASE WHEN post_exit_followup_required = TRUE AND post_exit_followup_date IS NULL THEN exit_record_id END)
      comment: "Count of exits requiring post-exit follow-up where follow-up has not yet been scheduled. Tracks follow-up obligation compliance; high values indicate case management gaps."
    - name: "referral_provided_count"
      expr: COUNT(DISTINCT CASE WHEN referral_provided = TRUE THEN exit_record_id END)
      comment: "Count of exits where a referral was provided. Tracks continuity of care at exit; low rates for vulnerable populations trigger program quality review."
    - name: "referral_at_exit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits where a referral was provided. Tracks continuity of care quality; low rates indicate service gap or case management protocol issues."
    - name: "data_deletion_scheduled_count"
      expr: COUNT(DISTINCT CASE WHEN data_deletion_scheduled_date IS NOT NULL THEN exit_record_id END)
      comment: "Count of exit records with a data deletion date scheduled. Tracks data retention compliance; low rates indicate data protection policy gaps."
    - name: "duplicate_merge_exit_count"
      expr: COUNT(DISTINCT CASE WHEN is_duplicate_merge = TRUE THEN exit_record_id END)
      comment: "Count of exits due to duplicate merges. Tracks deduplication-driven registry cleanup volume; high rates indicate prior data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_community_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community-level intervention KPIs tracking reach, budget utilization, implementation progress, and community participation. Used by program managers to monitor community-level program delivery, by finance teams for budget tracking, and by cluster coordinators for 3W reporting. Feeds OCHA 3W/4W reporting and program logframe tracking."
  source: "`vibe_ngo_v1`.`beneficiary`.`community_intervention`"
  dimensions:
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status (e.g. Planned, Active, Completed, Suspended). Tracks intervention pipeline."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of community intervention (e.g. Distribution, Training, Awareness, Infrastructure). Tracks intervention mix."
    - name: "intervention_theme"
      expr: intervention_theme
      comment: "Thematic area of the intervention (e.g. Nutrition, WASH, Protection, Livelihoods). Sector-level reporting dimension."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector (e.g. Food Security, WASH, Protection). Required for cluster coordination reporting."
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Delivery modality (e.g. In-kind, Cash, Service). Tracks modality mix for program design decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of budget and expenditure figures. Required for multi-currency financial reporting."
    - name: "is_protection_mainstreamed"
      expr: is_protection_mainstreamed
      comment: "Boolean indicating protection mainstreaming in the intervention. Tracks protection mainstreaming compliance."
    - name: "three_w_reported_flag"
      expr: three_w_reported_flag
      comment: "Boolean indicating the intervention has been reported in 3W. Tracks OCHA reporting compliance."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the intervention started. Enables trend analysis of intervention launch timing."
  measures:
    - name: "total_community_interventions"
      expr: COUNT(DISTINCT community_intervention_id)
      comment: "Total community interventions recorded. Tracks program breadth across communities."
    - name: "active_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN implementation_status = 'Active' THEN community_intervention_id END)
      comment: "Count of currently active community interventions. Tracks live program delivery footprint."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across community interventions. Tracks financial resource allocation at community level."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across community interventions. Tracks financial burn rate against budget."
    - name: "avg_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Average budget utilization rate (actual expenditure as % of budget). Tracks financial execution efficiency; low rates indicate implementation delays, high rates indicate budget overrun risk."
    - name: "avg_community_participation_rate"
      expr: AVG(CAST(community_participation_rate AS DOUBLE))
      comment: "Average community participation rate across interventions. Tracks community engagement quality; low rates indicate program relevance or access issues."
    - name: "avg_beneficiary_feedback_score"
      expr: AVG(CAST(beneficiary_feedback_score AS DOUBLE))
      comment: "Average beneficiary feedback score. Tracks accountability to affected populations (AAP); low scores trigger program adaptation."
    - name: "protection_mainstreamed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_protection_mainstreamed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interventions with protection mainstreaming. Tracks protection mainstreaming compliance; required for many donor reporting frameworks."
    - name: "three_w_reporting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_w_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interventions reported in OCHA 3W. Tracks humanitarian coordination reporting compliance."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent across community interventions. Tracks cumulative financial execution for program financial management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_displacement_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Displacement tracking KPIs monitoring displacement patterns, cross-border movements, protracted displacement, and return intentions. Used by protection and durable solutions teams to track displacement trends, by UNHCR for mandate reporting, and by program managers for targeting displaced populations. Aligns with UNHCR displacement monitoring frameworks and IDMC standards. PII sensitivity: displacement records are pii_beneficiary_protected."
  source: "`vibe_ngo_v1`.`beneficiary`.`displacement_history`"
  dimensions:
    - name: "displacement_status"
      expr: displacement_status
      comment: "Current displacement status (e.g. Displaced, Returned, Locally Integrated, Resettled). Primary displacement classification dimension."
    - name: "poc_category"
      expr: poc_category
      comment: "UNHCR person-of-concern category. Disaggregates displacement by mandate category."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin ISO code. Tracks displacement source country for flow analysis."
    - name: "current_country_code"
      expr: current_country_code
      comment: "Current country of displacement. Tracks displacement destination for host country analysis."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Boolean indicating cross-border displacement. Distinguishes international refugees from IDPs."
    - name: "is_protracted"
      expr: is_protracted
      comment: "Boolean indicating protracted displacement (typically 5+ years). Tracks durable solutions caseload."
    - name: "return_intention"
      expr: return_intention
      comment: "Stated return intention (e.g. Return, Local Integration, Resettlement, Undecided). Informs durable solutions planning."
    - name: "displacement_trigger"
      expr: displacement_trigger
      comment: "Cause of displacement (e.g. Conflict, Natural Disaster, Persecution). Tracks displacement driver composition."
    - name: "displacement_date_year"
      expr: YEAR(displacement_date)
      comment: "Year of displacement. Enables cohort analysis of displacement duration and durable solutions progress."
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating this is the current active displacement record. Filters to current displacement status."
  measures:
    - name: "total_displacement_records"
      expr: COUNT(DISTINCT displacement_history_id)
      comment: "Total displacement history records. Tracks displacement monitoring coverage."
    - name: "active_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN displacement_history_id END)
      comment: "Count of currently active displacement records. Tracks live displaced population size; primary UNHCR mandate reporting metric."
    - name: "cross_border_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN is_cross_border = TRUE AND is_active = TRUE THEN displacement_history_id END)
      comment: "Count of active cross-border (refugee) displacement records. Tracks international refugee population for UNHCR mandate reporting."
    - name: "protracted_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN is_protracted = TRUE AND is_active = TRUE THEN displacement_history_id END)
      comment: "Count of protracted displacement cases. Tracks durable solutions caseload; high rates trigger durable solutions program investment."
    - name: "return_intention_return_count"
      expr: COUNT(DISTINCT CASE WHEN return_intention = 'Return' AND is_active = TRUE THEN displacement_history_id END)
      comment: "Count of displaced persons intending to return. Informs voluntary repatriation program planning and resource allocation."
    - name: "avg_current_latitude"
      expr: AVG(CAST(current_latitude AS DOUBLE))
      comment: "Average latitude of current displacement locations. Used for geographic centroid analysis of displacement patterns; informs field presence decisions."
    - name: "verified_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN displacement_verification_status = 'Verified' THEN displacement_history_id END)
      comment: "Count of verified displacement records. Tracks data quality of displacement registry; unverified records cannot be used for official reporting."
    - name: "verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN displacement_verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of displacement records that have been verified. Data quality KPI; low rates indicate verification backlog and reporting accuracy risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs tracking consent coverage, compliance with data protection standards, consent expiry, and withdrawal rates. Used by data protection officers to monitor GDPR and CHS compliance, by program managers to ensure consent protocols are followed, and by donors for data protection audit readiness. Critical for humanitarian data protection compliance. PII sensitivity: consent records reference pii_beneficiary_protected individuals."
  source: "`vibe_ngo_v1`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (e.g. Active, Withdrawn, Expired). Tracks consent pipeline."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g. Data Processing, Photography, Biometric, Sharing). Tracks consent scope."
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent collection (e.g. Written, Verbal, Digital). Tracks consent collection methodology."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Boolean indicating GDPR applies to this consent record. Filters to GDPR-regulated consent for compliance reporting."
    - name: "is_proxy_consent"
      expr: is_proxy_consent
      comment: "Boolean indicating proxy consent was used. Tracks proxy consent volume for child protection and incapacity cases."
    - name: "sharing_permitted"
      expr: sharing_permitted
      comment: "Boolean indicating data sharing is permitted. Tracks data sharing consent coverage for inter-agency coordination."
    - name: "photography_permitted"
      expr: photography_permitted
      comment: "Boolean indicating photography is permitted. Tracks photography consent for communications and donor reporting."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained. Enables trend analysis of consent collection volume."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records. Tracks consent management coverage across the registered population."
    - name: "active_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Active' THEN consent_record_id END)
      comment: "Count of currently active consent records. Represents the population with valid, current consent for data processing."
    - name: "informed_consent_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN informed_consent_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records where informed consent was verified. CHS Standard 1 compliance KPI; rates below 100% represent legal and donor audit risk."
    - name: "consent_withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN consent_record_id END)
      comment: "Count of consent withdrawals. Tracks consent withdrawal volume; high rates may indicate trust issues or program concerns requiring investigation."
    - name: "expired_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Expired' THEN consent_record_id END)
      comment: "Count of expired consent records. Tracks consent renewal backlog; expired consents cannot be used for data processing and represent compliance risk."
    - name: "biometric_enrollment_permitted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biometric_enrollment_permitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records permitting biometric enrollment. Tracks biometric consent coverage; required before any biometric capture."
    - name: "chs_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records meeting CHS compliance standards. Tracks Core Humanitarian Standard compliance; rates below threshold trigger immediate remediation."
    - name: "gdpr_applicable_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_applicable = TRUE THEN consent_record_id END)
      comment: "Count of consent records subject to GDPR. Tracks GDPR-regulated data processing volume for data protection officer oversight."
$$;