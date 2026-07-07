-- Schema for Domain: care | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`care` COMMENT 'Manages care management, disease management, and case management programs — chronic condition registries, care gaps, care plans, population health stratification, high-risk member outreach, and health risk assessments (HRA). Owns HCC/RAF-relevant clinical data, HEDIS measure tracking, CAHPS survey results, SNF/DME post-acute coordination, and care coordinator assignments. Source system: Casenet TruCare or Altruista. Distinct from utilization which owns UM/PA authorization workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the care program.',
    `provider_contract_id` BIGINT COMMENT 'FK to the provider contract governing this program.',
    `cost_center_id` BIGINT COMMENT 'FK to the finance cost center funding this program.',
    `formulary_id` BIGINT COMMENT 'FK to the pharmacy formulary associated with this program.',
    `group_practice_id` BIGINT COMMENT 'FK to the provider group practice delivering this program.',
    `ledger_id` BIGINT COMMENT 'FK to the finance ledger for program accounting.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee who owns this program.',
    `provider_id` BIGINT COMMENT 'FK to the primary provider associated with this program.',
    `pool_id` BIGINT COMMENT 'FK to the risk pool associated with this program.',
    `vendor_contract_id` BIGINT COMMENT 'FK to the vendor contract for outsourced program services.',
    `accreditation_body` STRING COMMENT 'Name of the accrediting organization (e.g., NCQA, URAC).',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the program.',
    `program_category` STRING COMMENT 'Category of the care program (e.g., Disease Management, Wellness).',
    `clinical_protocol` STRING COMMENT 'Clinical protocol or guideline followed by the program.',
    `program_code` STRING COMMENT 'Unique business code for the program.',
    `contact_email` STRING COMMENT 'Primary contact email for the program.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_source_system` STRING COMMENT 'Source system that originated this record.',
    `program_description` STRING COMMENT 'Detailed description of the program.',
    `eligibility_criteria` STRING COMMENT 'Criteria members must meet to enroll in the program.',
    `end_date` DATE COMMENT 'Date the program ends or was terminated.',
    `enrollment_cap` BIGINT COMMENT 'Maximum number of members allowed in the program.',
    `enrollment_current` BIGINT COMMENT 'Current number of members enrolled in the program.',
    `enrollment_end_date` DATE COMMENT 'Last date members can enroll in the program.',
    `enrollment_start_date` DATE COMMENT 'First date members can enroll in the program.',
    `evidence_source` STRING COMMENT 'Source of clinical evidence supporting the program.',
    `hcc_included` STRING COMMENT 'HCC codes included in the program scope.',
    `hcc_version` STRING COMMENT 'Version of the HCC model used.',
    `is_evidence_based` BOOLEAN COMMENT 'Whether the program is based on clinical evidence.',
    `last_review_date` DATE COMMENT 'Date the program was last reviewed.',
    `line_of_business` STRING COMMENT 'Line of business the program serves (e.g., Medicare, Medicaid, Commercial).',
    `program_name` STRING COMMENT 'Name of the care program.',
    `outcome_actual` STRING COMMENT 'Actual outcome achieved by the program.',
    `outcome_measure` STRING COMMENT 'Metric used to measure program outcomes.',
    `outcome_target` STRING COMMENT 'Target outcome value for the program.',
    `program_status` STRING COMMENT 'Current status of the program (Active, Inactive, Pending).',
    `program_type` STRING COMMENT 'Type classification of the program.',
    `review_frequency` STRING COMMENT 'How often the program is reviewed.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor applied to program financials.',
    `start_date` DATE COMMENT 'Date the program started.',
    `target_population` STRING COMMENT 'Description of the target population for the program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `version_number` STRING COMMENT 'Version number of the program definition.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Care management program definition including clinical protocols, eligibility criteria, and outcome measures.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` (
    `plan_goal_id` BIGINT COMMENT 'Unique identifier for the plan goal.',
    `care_plan_id` BIGINT COMMENT 'FK to the care plan.',
    `coordinator_id` BIGINT COMMENT 'FK to the coordinator responsible for the goal.',
    `actual_date` DATE COMMENT 'Date the goal was actually achieved.',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual measured value for the goal.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the goal meets compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `goal_category` STRING COMMENT 'Category of the goal (clinical, behavioral, etc.).',
    `goal_code` STRING COMMENT 'Standardized code for the goal.',
    `goal_name` STRING COMMENT 'Name of the goal.',
    `measurement_type` STRING COMMENT 'Type of measurement used to track the goal.',
    `plan_goal_status` STRING COMMENT 'Current status of the goal.',
    `priority` STRING COMMENT 'Priority level of the goal.',
    `progress_notes` STRING COMMENT 'Notes on goal progress.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score associated with the goal.',
    `target_date` DATE COMMENT 'Target date for goal achievement.',
    `target_unit` STRING COMMENT 'Unit of measurement for the target value.',
    `target_value` DECIMAL(18,2) COMMENT 'Target value for the goal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_plan_goal PRIMARY KEY(`plan_goal_id`)
) COMMENT 'Goals defined within a care plan with targets, measurements, and progress tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap` (
    `gap_id` BIGINT COMMENT 'Unique identifier for the care gap.',
    `coordinator_id` BIGINT COMMENT 'FK to the assigned care coordinator.',
    `header_id` BIGINT COMMENT 'FK to the claim that closed the gap.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `hedis_measure_id` BIGINT COMMENT 'add column hedis_measure_id (BIGINT) with FK to care.hedis_measure.hedis_measure_id - gaps tie to specific quality measures',
    `member_risk_score_id` BIGINT COMMENT 'FK to the member risk score.',
    `subscriber_id` BIGINT COMMENT 'FK to the member/subscriber.',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor resolving the gap.',
    `actual_resolution_date` DATE COMMENT 'Date the gap was actually resolved.',
    `clinical_category` STRING COMMENT 'Clinical category of the gap.',
    `close_date` DATE COMMENT 'Date the gap was closed.',
    `closure_method` STRING COMMENT 'Method used to close the gap.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `gap_description` STRING COMMENT 'Description of the care gap.',
    `documentation_status` STRING COMMENT 'Status of supporting documentation.',
    `gap_status` STRING COMMENT 'Current status of the gap.',
    `gap_type` STRING COMMENT 'Type of care gap.',
    `is_critical` BOOLEAN COMMENT 'Whether the gap is critical.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Target value for the measure.',
    `open_date` DATE COMMENT 'Date the gap was opened.',
    `priority_level` STRING COMMENT 'Priority level of the gap.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score associated with the gap.',
    `target_date` DATE COMMENT 'Target date for gap closure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_gap PRIMARY KEY(`gap_id`)
) COMMENT 'Care gap identified for a member based on HEDIS or other quality measures.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator` (
    `coordinator_id` BIGINT COMMENT 'Unique identifier for the care coordinator.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee record.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor if coordinator is external.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `team_id` BIGINT COMMENT 'add column team_id (BIGINT) with FK to care.team.team_id - coordinators belong to a team',
    `assigned_lob` STRING COMMENT 'Line of business assigned to the coordinator.',
    `caseload_capacity` STRING COMMENT 'Maximum caseload capacity.',
    `caseload_weight` DECIMAL(18,2) COMMENT 'Weighted caseload factor.',
    `certification_codes` STRING COMMENT 'Professional certification codes held.',
    `coordinator_status` STRING COMMENT 'Current status of the coordinator.',
    `current_caseload_count` STRING COMMENT 'Current number of cases assigned.',
    `email_address` STRING COMMENT 'Email address of the coordinator.',
    `employment_status` STRING COMMENT 'Employment status (active, on leave, etc.).',
    `first_name` STRING COMMENT 'First name of the coordinator.',
    `full_name` STRING COMMENT 'Full name of the coordinator.',
    `hire_date` DATE COMMENT 'Date the coordinator was hired.',
    `last_name` STRING COMMENT 'Last name of the coordinator.',
    `last_training_date` DATE COMMENT 'Date of last completed training.',
    `notes` STRING COMMENT 'Free-text notes.',
    `organization_unit` STRING COMMENT 'Organizational unit the coordinator belongs to.',
    `phone_number` STRING COMMENT 'Phone number of the coordinator.',
    `primary_contact_method` STRING COMMENT 'Preferred contact method.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `role_type` STRING COMMENT 'Type of coordinator role.',
    `specialty_area` STRING COMMENT 'Clinical specialty area.',
    `termination_date` DATE COMMENT 'Date the coordinator was terminated.',
    `training_certifications` STRING COMMENT 'Training certifications held.',
    CONSTRAINT pk_coordinator PRIMARY KEY(`coordinator_id`)
) COMMENT 'Care coordinator or care manager responsible for managing member care plans and outreach.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` (
    `member_outreach_id` BIGINT COMMENT 'Unique identifier for the outreach record.',
    `employee_id` BIGINT COMMENT 'FK to the employee performing outreach.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor performing outreach.',
    `channel` STRING COMMENT 'Communication channel used.',
    `compliance_consent_obtained` BOOLEAN COMMENT 'Whether consent was obtained.',
    `consent_obtained_date` DATE COMMENT 'Date consent was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `follow_up_due_date` DATE COMMENT 'Date follow-up is due.',
    `follow_up_required` BOOLEAN COMMENT 'Whether follow-up is required.',
    `is_automated` BOOLEAN COMMENT 'Whether the outreach was automated.',
    `language_preference` STRING COMMENT 'Member language preference.',
    `member_outreach_status` STRING COMMENT 'Current status of the outreach.',
    `outcome` STRING COMMENT 'Outcome of the outreach attempt.',
    `outcome_timestamp` TIMESTAMP COMMENT 'Timestamp of the outcome.',
    `outreach_duration_seconds` STRING COMMENT 'Duration of the outreach in seconds.',
    `outreach_notes` STRING COMMENT 'Notes about the outreach.',
    `outreach_timestamp` TIMESTAMP COMMENT 'Timestamp of the outreach attempt.',
    `purpose` STRING COMMENT 'Purpose of the outreach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_member_outreach PRIMARY KEY(`member_outreach_id`)
) COMMENT 'Outreach attempts to members for care coordination, engagement, and follow-up.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hra` (
    `hra_id` BIGINT COMMENT 'Unique identifier for the HRA.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor administering the assessment.',
    `condition_registry_id` BIGINT COMMENT 'add column condition_registry_id (BIGINT) with FK to care.condition_registry.condition_registry_id - HRA findings populate condition registry',
    `employee_id` BIGINT COMMENT 'FK to the employee administering the HRA.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `questionnaire_id` BIGINT COMMENT 'FK to the questionnaire used.',
    `answered_questions` STRING COMMENT 'Number of questions answered.',
    `assessment_date` DATE COMMENT 'Date the assessment was completed.',
    `assessment_status` STRING COMMENT 'Status of the assessment.',
    `assessment_type` STRING COMMENT 'Type of assessment.',
    `assessment_version` STRING COMMENT 'Version of the assessment tool.',
    `community_resource_referrals` STRING COMMENT 'Community resources referred to.',
    `completion_channel` STRING COMMENT 'Channel used to complete the HRA.',
    `compliance_cms_required` BOOLEAN COMMENT 'Whether CMS requires this assessment.',
    `compliance_ncqa_required` BOOLEAN COMMENT 'Whether NCQA requires this assessment.',
    `identified_health_risks` STRING COMMENT 'Health risks identified.',
    `notes` STRING COMMENT 'Free-text notes.',
    `questionnaire_version` STRING COMMENT 'Version of the questionnaire.',
    `recommended_programs` STRING COMMENT 'Programs recommended based on assessment.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score.',
    `risk_score_percentile` DECIMAL(18,2) COMMENT 'Percentile ranking of risk score.',
    `risk_tier` STRING COMMENT 'Risk tier assignment.',
    `screening_tool` STRING COMMENT 'Screening tool used.',
    `sdoh_education` BOOLEAN COMMENT 'Education-related SDOH flag.',
    `sdoh_financial_strain` BOOLEAN COMMENT 'Financial strain SDOH flag.',
    `sdoh_food_insecurity` BOOLEAN COMMENT 'Food insecurity SDOH flag.',
    `sdoh_housing_instability` BOOLEAN COMMENT 'Housing instability SDOH flag.',
    `sdoh_social_isolation` BOOLEAN COMMENT 'Social isolation SDOH flag.',
    `sdoh_transportation` BOOLEAN COMMENT 'Transportation SDOH flag.',
    `total_questions` STRING COMMENT 'Total number of questions in the assessment.',
    CONSTRAINT pk_hra PRIMARY KEY(`hra_id`)
) COMMENT 'Health Risk Assessment capturing member health status, SDOH factors, and risk stratification.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` (
    `condition_registry_id` BIGINT COMMENT 'Unique identifier for the condition registry entry.',
    `care_plan_id` BIGINT COMMENT 'FK to the associated care plan.',
    `hcc_mapping_id` BIGINT COMMENT 'add column hcc_mapping_id (BIGINT) with FK to risk.hcc_mapping.hcc_mapping_id - conditions map to HCCs for risk adjustment',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `active_flag` BOOLEAN COMMENT 'Whether the condition is currently active.',
    `condition_category` STRING COMMENT 'Category of the condition.',
    `condition_code` STRING COMMENT 'ICD-10 or other condition code.',
    `condition_description` STRING COMMENT 'Description of the condition.',
    `confirmation_status` STRING COMMENT 'Confirmation status of the condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_quality_status` STRING COMMENT 'Data quality status of the record.',
    `effective_end_date` DATE COMMENT 'End date of the condition.',
    `effective_start_date` DATE COMMENT 'Start date of the condition.',
    `evidence_source_code` STRING COMMENT '',
    `fhir_condition_resource_code` BIGINT COMMENT '',
    `hcc_code` STRING COMMENT 'HCC code mapped from the condition.',
    `identification_date` DATE COMMENT 'Date the condition was identified.',
    `identification_method` STRING COMMENT 'Method used to identify the condition.',
    `is_chronic` BOOLEAN COMMENT 'Whether the condition is chronic.',
    `last_review_date` DATE COMMENT 'Date the condition was last reviewed.',
    `last_updated_date` DATE COMMENT '',
    `notes` STRING COMMENT 'Free-text notes.',
    `onset_date` DATE COMMENT 'Date of condition onset.',
    `population_segment` STRING COMMENT 'Population segment the member belongs to.',
    `raf_score` DECIMAL(18,2) COMMENT 'Risk adjustment factor score.',
    `registry_status_code` STRING COMMENT '',
    `registry_type_code` STRING COMMENT '',
    `resolution_date` DATE COMMENT 'Date the condition was resolved.',
    `risk_adjustment_flag` BOOLEAN COMMENT 'Whether the condition is used for risk adjustment.',
    `severity` STRING COMMENT 'Severity of the condition.',
    `severity_code` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `fhir_condition_resource_id` STRING COMMENT '',
    CONSTRAINT pk_condition_registry PRIMARY KEY(`condition_registry_id`)
) COMMENT 'Registry of member conditions for disease management and risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure.',
    `compliance_regulatory_obligation_id` BIGINT COMMENT 'HEDIS measures must link to regulatory obligations',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key to compliance.compliance_regulatory_obligation.regulatory_obligation_id',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_collection_methodology` STRING COMMENT 'Methodology for data collection.',
    `denominator_definition` STRING COMMENT 'Definition of the denominator.',
    `effective_date` DATE COMMENT 'Date the measure becomes effective.',
    `eligible_population_criteria` STRING COMMENT 'Criteria for eligible population.',
    `exclusion_criteria` STRING COMMENT 'Exclusion criteria for the measure.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `measure_code` STRING COMMENT 'HEDIS measure code.',
    `measure_denominator_logic` STRING COMMENT 'Logic for denominator calculation.',
    `measure_description` STRING COMMENT 'Description of the measure.',
    `measure_domain` STRING COMMENT 'Domain of the measure.',
    `measure_exclusion_logic` STRING COMMENT 'Logic for exclusions.',
    `measure_last_reviewed_date` DATE COMMENT 'Date the measure was last reviewed.',
    `measure_last_updated_by` STRING COMMENT 'User who last updated the measure.',
    `measure_name` STRING COMMENT 'Name of the HEDIS measure.',
    `measure_national_benchmark` DECIMAL(18,2) COMMENT 'National benchmark value.',
    `measure_notes` STRING COMMENT 'Notes about the measure.',
    `measure_numerator_logic` STRING COMMENT 'Logic for numerator calculation.',
    `measure_owner` STRING COMMENT 'Owner of the measure.',
    `measure_related_hcc` STRING COMMENT 'Related HCC codes.',
    `measure_related_raf` STRING COMMENT 'Related RAF information.',
    `measure_reporting_frequency` STRING COMMENT 'How often the measure is reported.',
    `measure_scoring_method` STRING COMMENT 'Method used to score the measure.',
    `measure_star_rating_impact` STRING COMMENT 'Impact on star ratings.',
    `measure_state_benchmark` DECIMAL(18,2) COMMENT 'State-level benchmark value.',
    `measure_status` STRING COMMENT 'Current status of the measure.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Target value for the measure.',
    `measure_url` STRING COMMENT 'URL reference for the measure.',
    `measurement_year` STRING COMMENT 'Year of measurement.',
    `numerator_definition` STRING COMMENT 'Definition of the numerator.',
    `retirement_date` DATE COMMENT 'Date the measure is retired.',
    `version_number` STRING COMMENT 'Version number of the measure.',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'HEDIS quality measure definitions including scoring methodology and benchmarks.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'Unique identifier for the HEDIS result.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `hedis_measure_id` BIGINT COMMENT 'FK to the HEDIS measure.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `collection_method` STRING COMMENT 'Data collection method.',
    `compliance_status` STRING COMMENT 'Compliance status for the measure.',
    `data_source` STRING COMMENT 'Source of the data.',
    `denominator_criteria_met` BOOLEAN COMMENT 'Whether denominator criteria were met.',
    `denominator_flag` BOOLEAN COMMENT '',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria applied.',
    `exclusion_criteria` STRING COMMENT 'Exclusion criteria applied.',
    `exclusion_flag` BOOLEAN COMMENT '',
    `exclusion_reason` STRING COMMENT 'Reason for exclusion.',
    `hybrid_chase_status_code` STRING COMMENT '',
    `is_excluded` BOOLEAN COMMENT 'Whether the member is excluded.',
    `measure_category` STRING COMMENT 'Category of the measure.',
    `measure_score` DECIMAL(18,2) COMMENT 'Score for the measure.',
    `measure_type` STRING COMMENT 'Type of measure.',
    `measure_version` STRING COMMENT 'Version of the measure.',
    `measure_year` STRING COMMENT '',
    `measurement_year` STRING COMMENT 'Year of measurement.',
    `numerator_criteria_met` BOOLEAN COMMENT 'Whether numerator criteria were met.',
    `numerator_flag` BOOLEAN COMMENT '',
    `result_timestamp` TIMESTAMP COMMENT 'Timestamp of the result.',
    `source_record_reference` STRING COMMENT 'Reference to the source record.',
    `source_record_type` STRING COMMENT 'Type of source record.',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'HEDIS measure results for individual members including compliance status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - CAHPS results are reported per plan',
    `member_enrollment2_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `administration_method` STRING COMMENT '',
    `composite_score_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_service_score` DECIMAL(18,2) COMMENT '',
    `data_source_system` STRING COMMENT '',
    `doctor_communication_score` DECIMAL(18,2) COMMENT '',
    `external_survey_code` STRING COMMENT '',
    `getting_care_quickly_score` DECIMAL(18,2) COMMENT '',
    `getting_needed_care_score` DECIMAL(18,2) COMMENT '',
    `is_test_survey` BOOLEAN COMMENT '',
    `member_age` STRING COMMENT '',
    `member_gender` STRING COMMENT '',
    `member_state` STRING COMMENT '',
    `member_zip` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `overall_satisfaction_score` DECIMAL(18,2) COMMENT '',
    `regulatory_reporting_flag` BOOLEAN COMMENT '',
    `response_deadline` DATE COMMENT '',
    `response_rate` DECIMAL(18,2) COMMENT '',
    `sample_size` STRING COMMENT '',
    `sampling_frame` STRING COMMENT '',
    `star_rating_impact_score` DECIMAL(18,2) COMMENT '',
    `survey_end_date` DATE COMMENT '',
    `survey_language` STRING COMMENT '',
    `survey_mode` STRING COMMENT '',
    `survey_name` STRING COMMENT '',
    `survey_start_date` DATE COMMENT '',
    `survey_status` STRING COMMENT '',
    `survey_type` STRING COMMENT '',
    `survey_version` STRING COMMENT '',
    `survey_year` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'CAHPS survey results measuring member satisfaction and experience.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`population_segment` (
    `population_segment_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - population segments must scope to a plan or LOB to be actionable (currently isolated)',
    `member_risk_tier_id` BIGINT COMMENT 'add column member_risk_tier_id (BIGINT) with FK to care.member_risk_tier.member_risk_tier_id - population segments roll up risk tiers',
    `pool_id` BIGINT COMMENT 'add column risk_pool_id (BIGINT) with FK to risk.pool.pool_id - population segments stratify members within a risk pool',
    `score_run_id` BIGINT COMMENT 'add column score_run_id (BIGINT) with FK to risk.score_run.score_run_id - population segmentation derives from a risk score run',
    `employee_id` BIGINT COMMENT '',
    `audit_created_by` STRING COMMENT '',
    `audit_updated_by` STRING COMMENT '',
    `average_pmpm_cost` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `inclusion_criteria_description` STRING COMMENT '',
    `is_default` BOOLEAN COMMENT '',
    `last_refreshed_date` DATE COMMENT '',
    `last_run_timestamp` TIMESTAMP COMMENT '',
    `last_run_user` STRING COMMENT '',
    `pmpm_cost_band` STRING COMMENT '',
    `population_count` BIGINT COMMENT '',
    `population_segment_status` STRING COMMENT '',
    `recommended_care_program` STRING COMMENT '',
    `refresh_frequency_code` STRING COMMENT '',
    `risk_tier` STRING COMMENT '',
    `segment_code` STRING COMMENT '',
    `segment_criteria_text` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
    `segment_name` STRING COMMENT '',
    `segment_owner_role` STRING COMMENT '',
    `segment_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_population_segment PRIMARY KEY(`population_segment_id`)
) COMMENT 'Population segmentation for risk stratification and program targeting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` (
    `member_risk_tier_id` BIGINT COMMENT '',
    `identity_id` BIGINT COMMENT '',
    `member_risk_score_id` BIGINT COMMENT 'add column member_risk_score_id (BIGINT) with FK to risk.member_risk_score.member_risk_score_id - risk tiers derive from underlying risk scores',
    `assignment_date` DATE COMMENT '',
    `assignment_method` STRING COMMENT '',
    `chronic_condition_flag` BOOLEAN COMMENT '',
    `claims_count_last_year` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `demographic_group` STRING COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `hcc_score` DECIMAL(18,2) COMMENT '',
    `inclusion_criteria` STRING COMMENT '',
    `is_current` BOOLEAN COMMENT '',
    `member_risk_tier_status` STRING COMMENT '',
    `model_type` STRING COMMENT '',
    `next_reassessment_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `pmpm_cost_band` STRING COMMENT '',
    `recommended_care_program` STRING COMMENT '',
    `risk_factor_weight` DECIMAL(18,2) COMMENT '',
    `risk_score` DECIMAL(18,2) COMMENT '',
    `risk_score_source` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
    `segment_name` STRING COMMENT '',
    `tier_band` STRING COMMENT '',
    `tier_code` STRING COMMENT '',
    `tier_name` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_member_risk_tier PRIMARY KEY(`member_risk_tier_id`)
) COMMENT 'Member risk tier assignment for care management stratification.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` (
    `snf_stay_id` BIGINT COMMENT '',
    `care_plan_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT '',
    `facility_id` BIGINT COMMENT '',
    `inpatient_admission_id` BIGINT COMMENT 'add column inpatient_admission_id (BIGINT) with FK to utilization.inpatient_admission.inpatient_admission_id - SNF stays follow inpatient discharges',
    `identity_id` BIGINT COMMENT '',
    `pa_request_id` BIGINT COMMENT '',
    `provider_network_id` BIGINT COMMENT '',
    `admission_diagnosis_code` STRING COMMENT '',
    `admission_diagnosis_description` STRING COMMENT '',
    `admission_timestamp` TIMESTAMP COMMENT '',
    `care_gap_flag` BOOLEAN COMMENT '',
    `concurrent_review_schedule_date` DATE COMMENT '',
    `currency_code` STRING COMMENT '',
    `discharge_destination` STRING COMMENT '',
    `discharge_planning_status` STRING COMMENT '',
    `discharge_timestamp` TIMESTAMP COMMENT '',
    `drg_code` STRING COMMENT '',
    `hcc_score` DECIMAL(18,2) COMMENT '',
    `is_eligible_for_medicare` BOOLEAN COMMENT '',
    `is_eligible_for_medicare_advantage` BOOLEAN COMMENT '',
    `length_of_stay_days` STRING COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `patient_condition_at_admission` STRING COMMENT '',
    `readmission_reason` STRING COMMENT '',
    `readmission_risk_flag` BOOLEAN COMMENT '',
    `readmission_within_30_days` BOOLEAN COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT '',
    `record_audit_updated` TIMESTAMP COMMENT '',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT '',
    `snf_facility_npi` STRING COMMENT '',
    `snf_stay_status` STRING COMMENT '',
    `snf_type` STRING COMMENT '',
    `stay_number` STRING COMMENT '',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT '',
    `total_charge_amount` DECIMAL(18,2) COMMENT '',
    `transition_of_care_plan` STRING COMMENT '',
    CONSTRAINT pk_snf_stay PRIMARY KEY(`snf_stay_id`)
) COMMENT 'Skilled nursing facility stay tracking for transition of care management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` (
    `dme_coordination_id` BIGINT COMMENT '',
    `auth_service_line_id` BIGINT COMMENT 'add column auth_service_line_id (BIGINT) with FK to utilization.auth_service_line.auth_service_line_id - DME requires authorization',
    `provider_contract_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT '',
    `identity_id` BIGINT COMMENT '',
    `provider_id` BIGINT COMMENT '',
    `compliance_flag` BOOLEAN COMMENT '',
    `coordination_reason` STRING COMMENT '',
    `coordination_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `delivery_date` DATE COMMENT '',
    `dme_model` STRING COMMENT '',
    `dme_serial_number` STRING COMMENT '',
    `dme_type` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `follow_up_date` DATE COMMENT '',
    `follow_up_notes` STRING COMMENT '',
    `last_status_change_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `order_date` DATE COMMENT '',
    `prior_authorization_number` STRING COMMENT '',
    `prior_authorization_required` BOOLEAN COMMENT '',
    `prior_authorization_status` STRING COMMENT '',
    `supplier_npi` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `urgency_level` STRING COMMENT '',
    CONSTRAINT pk_dme_coordination PRIMARY KEY(`dme_coordination_id`)
) COMMENT 'Durable medical equipment coordination for member care.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`barrier` (
    `barrier_id` BIGINT COMMENT '',
    `care_plan_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `barrier_status` STRING COMMENT '',
    `barrier_type` STRING COMMENT '',
    `care_manager_assigned_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `barrier_description` STRING COMMENT '',
    `documentation_source` STRING COMMENT '',
    `expected_resolution_date` DATE COMMENT '',
    `follow_up_date` DATE COMMENT '',
    `follow_up_required` BOOLEAN COMMENT '',
    `geographic_location` STRING COMMENT '',
    `hcc_impact` BOOLEAN COMMENT '',
    `identification_source` STRING COMMENT '',
    `identification_timestamp` TIMESTAMP COMMENT '',
    `impact_score` DECIMAL(18,2) COMMENT '',
    `intervention_applied` STRING COMMENT '',
    `intervention_type` STRING COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `resolution_date` DATE COMMENT '',
    `resolution_notes` STRING COMMENT '',
    `resolution_outcome` STRING COMMENT '',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT '',
    `severity_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_barrier PRIMARY KEY(`barrier_id`)
) COMMENT 'Barriers to care identified for members including SDOH and access issues.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`transition` (
    `transition_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `facility_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT '',
    `inpatient_admission_id` BIGINT COMMENT 'add column inpatient_admission_id (BIGINT) with FK to utilization.inpatient_admission.inpatient_admission_id - transitions of care follow inpatient admissions',
    `identity_id` BIGINT COMMENT '',
    `provider_network_id` BIGINT COMMENT '',
    `care_gap_flag` BOOLEAN COMMENT '',
    `compliance_consent_obtained` BOOLEAN COMMENT '',
    `concurrent_review_schedule_date` DATE COMMENT '',
    `consent_obtained_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discharge_planning_status` STRING COMMENT '',
    `dme_coordination_status` STRING COMMENT '',
    `dme_delivery_date` DATE COMMENT '',
    `dme_equipment_type` STRING COMMENT '',
    `dme_order_date` DATE COMMENT '',
    `dme_ordering_supplier_npi` STRING COMMENT '',
    `duration_days` STRING COMMENT '',
    `follow_up_schedule_date` DATE COMMENT '',
    `from_setting` STRING COMMENT '',
    `hcc_risk_factor` DECIMAL(18,2) COMMENT '',
    `is_critical_transition` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `outcome` STRING COMMENT '',
    `readmission_risk_assessment_date` DATE COMMENT '',
    `readmission_risk_flag` BOOLEAN COMMENT '',
    `readmission_risk_score` DECIMAL(18,2) COMMENT '',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT '',
    `snf_admission_date` DATE COMMENT '',
    `snf_admission_diagnosis_code` STRING COMMENT '',
    `snf_discharge_date` DATE COMMENT '',
    `snf_facility_npi` STRING COMMENT '',
    `to_setting` STRING COMMENT '',
    `toc_plan_completed` BOOLEAN COMMENT '',
    `transition_number` STRING COMMENT '',
    `transition_status` STRING COMMENT '',
    `transition_timestamp` TIMESTAMP COMMENT '',
    `transition_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_transition PRIMARY KEY(`transition_id`)
) COMMENT 'Transition of care events between care settings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` (
    `star_rating_result_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT '',
    `hedis_measure_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cutpoint_1_star` DECIMAL(18,2) COMMENT '',
    `cutpoint_2_star` DECIMAL(18,2) COMMENT '',
    `cutpoint_3_star` DECIMAL(18,2) COMMENT '',
    `cutpoint_4_star` DECIMAL(18,2) COMMENT '',
    `cutpoint_5_star` DECIMAL(18,2) COMMENT '',
    `data_source` STRING COMMENT '',
    `domain_star_score` STRING COMMENT '',
    `improvement_measure_flag` BOOLEAN COMMENT '',
    `measure_name` STRING COMMENT '',
    `measure_weight` DECIMAL(18,2) COMMENT '',
    `measurement_year` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `overall_star_rating` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `quality_bonus_eligible` BOOLEAN COMMENT '',
    `rating_name` STRING COMMENT '',
    `rating_status` STRING COMMENT '',
    `star_domain` STRING COMMENT '',
    `star_score` STRING COMMENT '',
    `trend_direction` STRING COMMENT '',
    `trend_star_score` STRING COMMENT '',
    `trend_year` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_star_rating_result PRIMARY KEY(`star_rating_result_id`)
) COMMENT 'CMS Star Rating results by measure and contract.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` (
    `sdoh_assessment_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `identity_id` BIGINT COMMENT '',
    `question_set_id` BIGINT COMMENT 'add column question_set_id (BIGINT) with FK to care.question_set.question_set_id - SDOH assessments use a question set',
    `vendor_id` BIGINT COMMENT '',
    `assessment_date` DATE COMMENT '',
    `assessment_score` DECIMAL(18,2) COMMENT '',
    `assessment_version` STRING COMMENT '',
    `confidentiality_consent_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `follow_up_due_date` DATE COMMENT '',
    `follow_up_status` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `referral_made_flag` BOOLEAN COMMENT '',
    `referral_resource` STRING COMMENT '',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT '',
    `risk_level` STRING COMMENT '',
    `screening_tool` STRING COMMENT '',
    `sdoh_assessment_status` STRING COMMENT '',
    `sdoh_domain` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_sdoh_assessment PRIMARY KEY(`sdoh_assessment_id`)
) COMMENT 'Social Determinants of Health assessment for members.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`team` (
    `team_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - care teams sit within an org unit',
    `parent_team_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT '',
    `active_caseload_count` BIGINT COMMENT '',
    `audit_created_by` STRING COMMENT '',
    `audit_updated_by` STRING COMMENT '',
    `behavioral_health_provider_count` STRING COMMENT '',
    `team_code` STRING COMMENT '',
    `communication_preference` STRING COMMENT '',
    `community_health_worker_count` STRING COMMENT '',
    `consent_obtained_date` DATE COMMENT '',
    `contact_email` STRING COMMENT '',
    `contact_method` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_quality_status` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `hcc_included` BOOLEAN COMMENT '',
    `hcc_version` STRING COMMENT '',
    `is_multidisciplinary` BOOLEAN COMMENT '',
    `is_primary_care_team` BOOLEAN COMMENT '',
    `last_review_date` DATE COMMENT '',
    `lead_coordinator_end_date` DATE COMMENT '',
    `lead_coordinator_start_date` DATE COMMENT '',
    `member_capacity` BIGINT COMMENT '',
    `member_count` STRING COMMENT '',
    `team_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `pharmacist_count` STRING COMMENT '',
    `privacy_consent_flag` BOOLEAN COMMENT '',
    `provider_count` STRING COMMENT '',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT '',
    `social_worker_count` STRING COMMENT '',
    `specialist_count` STRING COMMENT '',
    `specialty_focus_code` STRING COMMENT '',
    `status_reason` STRING COMMENT '',
    `team_status` STRING COMMENT '',
    `team_type` STRING COMMENT '',
    `type_code` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `version_number` STRING COMMENT '',
    `team_type_code` STRING COMMENT '',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Care team composition and management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` (
    `coordinator_assignment_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT '',
    `care_plan_id` BIGINT COMMENT '',
    `member_id` BIGINT COMMENT '',
    `assignment_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `assignment_start_date` DATE COMMENT '',
    `assignment_end_date` DATE COMMENT '',
    `primary_assignment_flag` BOOLEAN COMMENT '',
    `caseload_weight` DECIMAL(18,2) COMMENT '',
    `escalation_path_text` STRING COMMENT '',
    CONSTRAINT pk_coordinator_assignment PRIMARY KEY(`coordinator_assignment_id`)
) COMMENT 'Assignment of coordinators to members with effective dating and role context.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` (
    `program_obligation_mapping_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `accreditation_program_id` BIGINT COMMENT '',
    `mapping_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `mapping_effective_date` STRING COMMENT '',
    `satisfaction_status_code` STRING COMMENT '',
    `evidence_url` STRING COMMENT '',
    `last_validated_date` STRING COMMENT '',
    CONSTRAINT pk_program_obligation_mapping PRIMARY KEY(`program_obligation_mapping_id`)
) COMMENT 'Mapping between care programs and regulatory obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` (
    `program_accreditation_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `accreditation_survey_id` BIGINT COMMENT '',
    `accreditation_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `accreditation_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    `accrediting_body_code` STRING COMMENT '',
    `score_value` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_program_accreditation PRIMARY KEY(`program_accreditation_id`)
) COMMENT 'Accreditation status of care programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` (
    `measure_obligation_mapping_id` BIGINT COMMENT '',
    `hedis_measure_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `accreditation_program_id` BIGINT COMMENT '',
    `mapping_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `mapping_effective_date` STRING COMMENT '',
    `target_threshold` STRING COMMENT '',
    `current_performance` STRING COMMENT '',
    `gap_to_target` STRING COMMENT '',
    CONSTRAINT pk_measure_obligation_mapping PRIMARY KEY(`measure_obligation_mapping_id`)
) COMMENT 'Mapping between HEDIS measures and regulatory obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` (
    `gap_obligation_id` BIGINT COMMENT '',
    `gap_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `hedis_measure_id` BIGINT COMMENT '',
    `obligation_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `target_close_date` DATE COMMENT '',
    `escalation_level_code` STRING COMMENT '',
    `regulatory_deadline` DATE COMMENT '',
    CONSTRAINT pk_gap_obligation PRIMARY KEY(`gap_obligation_id`)
) COMMENT 'Mapping between care gaps and regulatory obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT '',
    `coordinator_id` BIGINT COMMENT 'add column care_coordinator_id (BIGINT) with FK to care.coordinator.coordinator_id - enrollment assigns a coordinator',
    `group_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT 'add column subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - program enrollment is at the member level',
    `consent_flag` BOOLEAN COMMENT '',
    `consent_obtained_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `engagement_level` STRING COMMENT '',
    `engagement_level_code` STRING COMMENT '',
    `enrollment_cap` BIGINT COMMENT '',
    `enrollment_end_date` DATE COMMENT '',
    `enrollment_start_date` DATE COMMENT '',
    `enrollment_status` STRING COMMENT '',
    `enrollment_status_code` STRING COMMENT '',
    `enrollment_type` STRING COMMENT '',
    `graduation_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `opt_out_reason` STRING COMMENT '',
    `opt_out_reason_code` STRING COMMENT '',
    `outreach_attempts` STRING COMMENT '',
    `outreach_attempts_count` STRING COMMENT '',
    `participation_rate` DECIMAL(18,2) COMMENT '',
    `renewal_date` DATE COMMENT '',
    `status_code` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'Group-level enrollment into care programs with capacity and participation tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` (
    `questionnaire_id` BIGINT COMMENT '',
    `cahps_survey_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `question_set_id` BIGINT COMMENT '',
    `superseded_by_questionnaire_id` BIGINT COMMENT '',
    `hra_id` BIGINT COMMENT 'add column hra_id (BIGINT) with FK to care.hra.hra_id - HRA instruments use questionnaires',
    `approval_by` STRING COMMENT '',
    `approval_comments` STRING COMMENT '',
    `approval_date` DATE COMMENT '',
    `approval_status` STRING COMMENT '',
    `questionnaire_code` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `questionnaire_description` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_assessment` BOOLEAN COMMENT '',
    `is_current` BOOLEAN COMMENT '',
    `is_customizable` BOOLEAN COMMENT '',
    `is_default` BOOLEAN COMMENT '',
    `is_form` BOOLEAN COMMENT '',
    `is_legacy` BOOLEAN COMMENT '',
    `is_obsolete` BOOLEAN COMMENT '',
    `is_predefined` BOOLEAN COMMENT '',
    `is_public` BOOLEAN COMMENT '',
    `is_questionnaire` BOOLEAN COMMENT '',
    `is_retired` BOOLEAN COMMENT '',
    `is_survey` BOOLEAN COMMENT '',
    `is_template` BOOLEAN COMMENT '',
    `language` STRING COMMENT '',
    `locale` STRING COMMENT '',
    `questionnaire_name` STRING COMMENT '',
    `question_count` STRING COMMENT '',
    `questionnaire_status` STRING COMMENT '',
    `questionnaire_type` STRING COMMENT '',
    `source_record_reference` STRING COMMENT '',
    `source_record_timestamp` TIMESTAMP COMMENT '',
    `source_system_code` STRING COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    `version` STRING COMMENT '',
    CONSTRAINT pk_questionnaire PRIMARY KEY(`questionnaire_id`)
) COMMENT 'Questionnaire definitions used for HRAs, surveys, and assessments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`question_set` (
    `question_set_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `parent_question_set_id` BIGINT COMMENT '',
    `question_superseded_by_set_id` BIGINT COMMENT '',
    `administration_mode` STRING COMMENT '',
    `approval_date` DATE COMMENT '',
    `branching_logic_flag` BOOLEAN COMMENT '',
    `question_set_category` STRING COMMENT '',
    `clinical_domain` STRING COMMENT '',
    `question_set_code` STRING COMMENT '',
    `consent_required_flag` BOOLEAN COMMENT '',
    `question_set_description` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `estimated_completion_minutes` STRING COMMENT '',
    `external_reference_code` STRING COMMENT '',
    `frequency_requirement` STRING COMMENT '',
    `hcc_raf_relevance_flag` BOOLEAN COMMENT '',
    `hedis_measure_alignment` STRING COMMENT '',
    `hipaa_sensitivity_level` STRING COMMENT '',
    `instrument_source` STRING COMMENT '',
    `is_required_for_enrollment` BOOLEAN COMMENT '',
    `is_validated_instrument` BOOLEAN COMMENT '',
    `language_code` STRING COMMENT '',
    `last_review_date` DATE COMMENT '',
    `maximum_score` DECIMAL(18,2) COMMENT '',
    `minimum_score` DECIMAL(18,2) COMMENT '',
    `question_set_name` STRING COMMENT '',
    `next_review_date` DATE COMMENT '',
    `owner_department` STRING COMMENT '',
    `question_set_status` STRING COMMENT '',
    `record_created_timestamp` TIMESTAMP COMMENT '',
    `record_updated_timestamp` TIMESTAMP COMMENT '',
    `regulatory_program` STRING COMMENT '',
    `retirement_date` DATE COMMENT '',
    `risk_stratification_flag` BOOLEAN COMMENT '',
    `scoring_methodology` STRING COMMENT '',
    `set_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `target_population` STRING COMMENT '',
    `total_question_count` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_question_set PRIMARY KEY(`question_set_id`)
) COMMENT 'Grouping of questions within a questionnaire with scoring and validation rules.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` (
    `care_enrollment2_id` BIGINT COMMENT 'Unique identifier for the care enrollment record.',
    `coordinator_id` BIGINT COMMENT 'FK to the assigned care coordinator.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `member_risk_score_id` BIGINT COMMENT 'FK to the member risk score at time of enrollment.',
    `subscriber_id` BIGINT COMMENT 'FK to the member/subscriber enrolled.',
    `program_id` BIGINT COMMENT 'FK to the care program.',
    `member_enrollment_id` BIGINT COMMENT 'Link to member health-plan enrollment SSOT',
    `acuity_level` STRING COMMENT 'Acuity level of the member at enrollment.',
    `care_manager_assigned_date` DATE COMMENT 'Date a care manager was assigned.',
    `consent_status` STRING COMMENT 'Member consent status for program participation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `disenrollment_date` DATE COMMENT 'Date the member was disenrolled from the program.',
    `effective_end_date` DATE COMMENT 'End date of the enrollment period.',
    `effective_start_date` DATE COMMENT 'Start date of the enrollment period.',
    `enrollment_number` STRING COMMENT 'Business enrollment number.',
    `enrollment_source` STRING COMMENT 'Source of the enrollment (e.g., referral, auto-enroll).',
    `enrollment_status` STRING COMMENT 'Current enrollment status.',
    `enrollment_type` STRING COMMENT 'Type of enrollment (voluntary, mandatory).',
    `hcc_score` DECIMAL(18,2) COMMENT 'HCC risk score at time of enrollment.',
    `notes` STRING COMMENT 'Free-text notes about the enrollment.',
    `program_tier` STRING COMMENT 'Tier level within the program.',
    `reason` STRING COMMENT 'Reason for enrollment or disenrollment.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score at enrollment.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_care_enrollment2 PRIMARY KEY(`care_enrollment2_id`)
) COMMENT 'Care MANAGEMENT program enrollment (distinct from member.enrollment health plan enrollment). Care MANAGEMENT program enrollment. Distinct from member.member_enrollment which represents HEALTH PLAN enrollment. [P207 skipped: target-product-missing:care.care_enrollment renamed to care.enrollment per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'Unique identifier for the care plan.',
    `coordinator_id` BIGINT COMMENT 'FK to the assigned care coordinator.',
    `vendor_id` BIGINT COMMENT 'FK to the pharmacy vendor.',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `plan_care_subscriber_id` BIGINT COMMENT 'FK to the subscriber.',
    `provider_id` BIGINT COMMENT 'FK to the primary provider.',
    `program_id` BIGINT COMMENT 'FK to the care program.',
    `barriers_to_care` STRING COMMENT 'Identified barriers to care for the member.',
    `care_plan_status` STRING COMMENT 'Current status of the care plan.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the care plan was created.',
    `effective_end_date` DATE COMMENT 'End date of the care plan.',
    `effective_start_date` DATE COMMENT 'Start date of the care plan.',
    `high_risk_flag` BOOLEAN COMMENT 'Indicates if the member is high risk.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `plan_name` STRING COMMENT 'Name of the care plan.',
    `plan_number` STRING COMMENT 'Business plan number.',
    `plan_type` STRING COMMENT 'Type of care plan.',
    `privacy_consent_flag` BOOLEAN COMMENT 'Whether privacy consent was obtained.',
    `progress_notes` STRING COMMENT 'Progress notes for the care plan.',
    `risk_score` DECIMAL(18,2) COMMENT 'Member risk score at plan creation.',
    `version` STRING COMMENT 'Version number of the care plan.',
    `fhir_care_plan_resource_id` STRING COMMENT '',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Individualized care plan for a member including goals, barriers, and provider assignments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` (
    `care_enrollment_id` BIGINT COMMENT 'Primary key for care_enrollment',
    `member_enrollment_id` BIGINT COMMENT '',
    CONSTRAINT pk_care_enrollment PRIMARY KEY(`care_enrollment_id`)
) COMMENT 'Care MANAGEMENT program enrollment';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`team`(`team_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`questionnaire`(`questionnaire_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ADD CONSTRAINT `fk_care_population_segment_member_risk_tier_id` FOREIGN KEY (`member_risk_tier_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`member_risk_tier`(`member_risk_tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ADD CONSTRAINT `fk_care_barrier_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ADD CONSTRAINT `fk_care_star_rating_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_question_set_id` FOREIGN KEY (`question_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`team`(`team_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ADD CONSTRAINT `fk_care_program_obligation_mapping_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ADD CONSTRAINT `fk_care_program_accreditation_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ADD CONSTRAINT `fk_care_measure_obligation_mapping_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ADD CONSTRAINT `fk_care_gap_obligation_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`gap`(`gap_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ADD CONSTRAINT `fk_care_gap_obligation_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ADD CONSTRAINT `fk_care_program_enrollment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ADD CONSTRAINT `fk_care_program_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_cahps_survey_id` FOREIGN KEY (`cahps_survey_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_question_set_id` FOREIGN KEY (`question_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_superseded_by_questionnaire_id` FOREIGN KEY (`superseded_by_questionnaire_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`questionnaire`(`questionnaire_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_hra_id` FOREIGN KEY (`hra_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hra`(`hra_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_parent_question_set_id` FOREIGN KEY (`parent_question_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_question_superseded_by_set_id` FOREIGN KEY (`question_superseded_by_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('pii_domain' = 'care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('pii_fhir_resource' = 'PlanDefinition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `group_practice_id` SET TAGS ('pii_business_glossary_term' = 'Group Practice ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_category` SET TAGS ('pii_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `clinical_protocol` SET TAGS ('pii_business_glossary_term' = 'Clinical Protocol');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_description` SET TAGS ('pii_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_cap` SET TAGS ('pii_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_current` SET TAGS ('pii_business_glossary_term' = 'Current Enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `evidence_source` SET TAGS ('pii_business_glossary_term' = 'Evidence Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('pii_business_glossary_term' = 'HCC Included');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('pii_business_glossary_term' = 'HCC Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `is_evidence_based` SET TAGS ('pii_business_glossary_term' = 'Is Evidence Based');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_actual` SET TAGS ('pii_business_glossary_term' = 'Outcome Actual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_measure` SET TAGS ('pii_business_glossary_term' = 'Outcome Measure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_target` SET TAGS ('pii_business_glossary_term' = 'Outcome Target');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('pii_fhir_resource' = 'Goal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_id` SET TAGS ('pii_business_glossary_term' = 'Plan Goal ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_date` SET TAGS ('pii_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_value` SET TAGS ('pii_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('pii_business_glossary_term' = 'Goal Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('pii_business_glossary_term' = 'Goal Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('pii_business_glossary_term' = 'Goal Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('pii_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('pii_business_glossary_term' = 'Plan Goal Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `progress_notes` SET TAGS ('pii_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('pii_business_glossary_term' = 'Target Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('pii_fhir_resource' = 'DetectedIssue');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_id` SET TAGS ('pii_business_glossary_term' = 'Gap ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Care Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Resolution Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `clinical_category` SET TAGS ('pii_business_glossary_term' = 'Clinical Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `close_date` SET TAGS ('pii_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('pii_business_glossary_term' = 'Closure Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_description` SET TAGS ('pii_business_glossary_term' = 'Gap Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('pii_business_glossary_term' = 'Documentation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('pii_business_glossary_term' = 'Gap Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('pii_business_glossary_term' = 'Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `measure_target_value` SET TAGS ('pii_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `open_date` SET TAGS ('pii_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'External Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('pii_business_glossary_term' = 'Assigned LOB');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('pii_business_glossary_term' = 'Caseload Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_weight` SET TAGS ('pii_business_glossary_term' = 'Caseload Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `certification_codes` SET TAGS ('pii_business_glossary_term' = 'Certification Codes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('pii_business_glossary_term' = 'Coordinator Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `current_caseload_count` SET TAGS ('pii_business_glossary_term' = 'Current Caseload Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('pii_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_training_date` SET TAGS ('pii_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `organization_unit` SET TAGS ('pii_business_glossary_term' = 'Organization Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('pii_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('pii_business_glossary_term' = 'Specialty Area');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `training_certifications` SET TAGS ('pii_business_glossary_term' = 'Training Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('pii_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `member_outreach_id` SET TAGS ('pii_business_glossary_term' = 'Member Outreach ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Outreach Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `compliance_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Compliance Consent Obtained');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `is_automated` SET TAGS ('pii_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `member_outreach_status` SET TAGS ('pii_business_glossary_term' = 'Member Outreach Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outcome_timestamp` SET TAGS ('pii_business_glossary_term' = 'Outcome Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Outreach Duration Seconds');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_notes` SET TAGS ('pii_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('pii_business_glossary_term' = 'Outreach Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('pii_fhir_resource' = 'QuestionnaireResponse');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `hra_id` SET TAGS ('pii_business_glossary_term' = 'HRA ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `condition_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `condition_registry_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `questionnaire_id` SET TAGS ('pii_business_glossary_term' = 'Questionnaire ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `answered_questions` SET TAGS ('pii_business_glossary_term' = 'Answered Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_version` SET TAGS ('pii_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `community_resource_referrals` SET TAGS ('pii_business_glossary_term' = 'Community Resource Referrals');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('pii_business_glossary_term' = 'Completion Channel');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_cms_required` SET TAGS ('pii_business_glossary_term' = 'CMS Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_ncqa_required` SET TAGS ('pii_business_glossary_term' = 'NCQA Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('pii_business_glossary_term' = 'Identified Health Risks');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `questionnaire_version` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `recommended_programs` SET TAGS ('pii_business_glossary_term' = 'Recommended Programs');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('pii_business_glossary_term' = 'Risk Score Percentile');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('pii_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('pii_business_glossary_term' = 'SDOH Education');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('pii_business_glossary_term' = 'SDOH Financial Strain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('pii_business_glossary_term' = 'SDOH Food Insecurity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('pii_business_glossary_term' = 'SDOH Housing Instability');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('pii_business_glossary_term' = 'SDOH Social Isolation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('pii_business_glossary_term' = 'SDOH Transportation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `total_questions` SET TAGS ('pii_business_glossary_term' = 'Total Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('pii_fhir_resource' = 'Condition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('pii_business_glossary_term' = 'Condition Registry ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('pii_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('pii_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('pii_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('pii_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_condition_resource_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_condition_resource_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('pii_business_glossary_term' = 'HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('pii_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_date` SET TAGS ('pii_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('pii_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `is_chronic` SET TAGS ('pii_business_glossary_term' = 'Is Chronic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `onset_date` SET TAGS ('pii_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('pii_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `raf_score` SET TAGS ('pii_business_glossary_term' = 'RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_condition_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('pii_fhir_resource' = 'Measure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `compliance_regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('pii_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('pii_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('pii_business_glossary_term' = 'Measure Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_denominator_logic` SET TAGS ('pii_business_glossary_term' = 'Measure Denominator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_description` SET TAGS ('pii_business_glossary_term' = 'Measure Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('pii_business_glossary_term' = 'Measure Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_exclusion_logic` SET TAGS ('pii_business_glossary_term' = 'Measure Exclusion Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Measure Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Measure Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_national_benchmark` SET TAGS ('pii_business_glossary_term' = 'National Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_notes` SET TAGS ('pii_business_glossary_term' = 'Measure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_numerator_logic` SET TAGS ('pii_business_glossary_term' = 'Measure Numerator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('pii_business_glossary_term' = 'Measure Owner');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('pii_business_glossary_term' = 'Related HCC');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_raf` SET TAGS ('pii_business_glossary_term' = 'Related RAF');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('pii_business_glossary_term' = 'Scoring Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('pii_business_glossary_term' = 'Star Rating Impact');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('pii_business_glossary_term' = 'State Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('pii_business_glossary_term' = 'Measure Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_url` SET TAGS ('pii_business_glossary_term' = 'Measure URL');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('pii_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('pii_fhir_resource' = 'MeasureReport');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Result ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_created` SET TAGS ('pii_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_updated` SET TAGS ('pii_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `denominator_criteria_met` SET TAGS ('pii_business_glossary_term' = 'Denominator Criteria Met');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `is_excluded` SET TAGS ('pii_business_glossary_term' = 'Is Excluded');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('pii_business_glossary_term' = 'Measure Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_score` SET TAGS ('pii_business_glossary_term' = 'Measure Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('pii_business_glossary_term' = 'Measure Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('pii_business_glossary_term' = 'Measure Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `numerator_criteria_met` SET TAGS ('pii_business_glossary_term' = 'Numerator Criteria Met');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `result_timestamp` SET TAGS ('pii_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `source_record_type` SET TAGS ('pii_business_glossary_term' = 'Source Record Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('pii_fhir_resource' = 'QuestionnaireResponse');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `cahps_survey_id` SET TAGS ('pii_business_glossary_term' = 'Cahps Survey Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_enrollment2_id` SET TAGS ('pii_business_glossary_term' = 'Member Enrollment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `administration_method` SET TAGS ('pii_business_glossary_term' = 'Administration Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `composite_score_flag` SET TAGS ('pii_business_glossary_term' = 'Composite Score Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `customer_service_score` SET TAGS ('pii_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `doctor_communication_score` SET TAGS ('pii_business_glossary_term' = 'Doctor Communication Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `external_survey_code` SET TAGS ('pii_business_glossary_term' = 'External Survey Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_care_quickly_score` SET TAGS ('pii_business_glossary_term' = 'Getting Care Quickly Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_needed_care_score` SET TAGS ('pii_business_glossary_term' = 'Getting Needed Care Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `is_test_survey` SET TAGS ('pii_business_glossary_term' = 'Is Test Survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('pii_business_glossary_term' = 'Member Age');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('pii_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_business_glossary_term' = 'Member Zip');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `overall_satisfaction_score` SET TAGS ('pii_business_glossary_term' = 'Overall Satisfaction Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `response_deadline` SET TAGS ('pii_business_glossary_term' = 'Response Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `response_rate` SET TAGS ('pii_business_glossary_term' = 'Response Rate');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `sampling_frame` SET TAGS ('pii_business_glossary_term' = 'Sampling Frame');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `star_rating_impact_score` SET TAGS ('pii_business_glossary_term' = 'Star Rating Impact Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_end_date` SET TAGS ('pii_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('pii_business_glossary_term' = 'Survey Language');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_mode` SET TAGS ('pii_business_glossary_term' = 'Survey Mode');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('pii_business_glossary_term' = 'Survey Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_start_date` SET TAGS ('pii_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_version` SET TAGS ('pii_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_year` SET TAGS ('pii_business_glossary_term' = 'Survey Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('pii_fhir_resource' = 'Group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_segment_id` SET TAGS ('pii_business_glossary_term' = 'Population Segment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `audit_updated_by` SET TAGS ('pii_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `average_pmpm_cost` SET TAGS ('pii_business_glossary_term' = 'Average Pmpm Cost');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `inclusion_criteria_description` SET TAGS ('pii_business_glossary_term' = 'Inclusion Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `last_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `last_run_user` SET TAGS ('pii_business_glossary_term' = 'Last Run User');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `pmpm_cost_band` SET TAGS ('pii_business_glossary_term' = 'Pmpm Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_count` SET TAGS ('pii_business_glossary_term' = 'Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_segment_status` SET TAGS ('pii_business_glossary_term' = 'Population Segment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `recommended_care_program` SET TAGS ('pii_business_glossary_term' = 'Recommended Care Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_code` SET TAGS ('pii_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_description` SET TAGS ('pii_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('pii_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_owner_role` SET TAGS ('pii_business_glossary_term' = 'Segment Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('pii_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('pii_fhir_resource' = 'RiskAssessment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Tier Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('pii_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `claims_count_last_year` SET TAGS ('pii_business_glossary_term' = 'Claims Count Last Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('pii_business_glossary_term' = 'Demographic Group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'Hcc Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `inclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('pii_business_glossary_term' = 'Member Risk Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('pii_business_glossary_term' = 'Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `next_reassessment_date` SET TAGS ('pii_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('pii_business_glossary_term' = 'Pmpm Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `recommended_care_program` SET TAGS ('pii_business_glossary_term' = 'Recommended Care Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_factor_weight` SET TAGS ('pii_business_glossary_term' = 'Risk Factor Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('pii_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_description` SET TAGS ('pii_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('pii_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('pii_business_glossary_term' = 'Tier Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('pii_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('pii_fhir_resource' = 'Encounter');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_stay_id` SET TAGS ('pii_business_glossary_term' = 'Snf Stay Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Pa Request Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Admission Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('pii_business_glossary_term' = 'Admission Diagnosis Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Admission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_gap_flag` SET TAGS ('pii_business_glossary_term' = 'Care Gap Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `concurrent_review_schedule_date` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review Schedule Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_destination` SET TAGS ('pii_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_planning_status` SET TAGS ('pii_business_glossary_term' = 'Discharge Planning Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_timestamp` SET TAGS ('pii_business_glossary_term' = 'Discharge Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Drg Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'Hcc Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Medicare');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare_advantage` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Medicare Advantage');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `length_of_stay_days` SET TAGS ('pii_business_glossary_term' = 'Length Of Stay Days');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('pii_business_glossary_term' = 'Patient Condition At Admission');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_reason` SET TAGS ('pii_business_glossary_term' = 'Readmission Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_within_30_days` SET TAGS ('pii_business_glossary_term' = 'Readmission Within 30 Days');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_business_glossary_term' = 'Snf Facility Npi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_stay_status` SET TAGS ('pii_business_glossary_term' = 'Snf Stay Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_type` SET TAGS ('pii_business_glossary_term' = 'Snf Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `stay_number` SET TAGS ('pii_business_glossary_term' = 'Stay Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `transition_of_care_plan` SET TAGS ('pii_business_glossary_term' = 'Transition Of Care Plan');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('pii_fhir_resource' = 'DeviceRequest');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_coordination_id` SET TAGS ('pii_business_glossary_term' = 'Dme Coordination Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordination_reason` SET TAGS ('pii_business_glossary_term' = 'Coordination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordination_status` SET TAGS ('pii_business_glossary_term' = 'Coordination Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `delivery_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_model` SET TAGS ('pii_business_glossary_term' = 'Dme Model');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_serial_number` SET TAGS ('pii_business_glossary_term' = 'Dme Serial Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_type` SET TAGS ('pii_business_glossary_term' = 'Dme Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `follow_up_notes` SET TAGS ('pii_business_glossary_term' = 'Follow Up Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('pii_business_glossary_term' = 'Supplier Npi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('pii_fhir_resource' = 'DetectedIssue');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_id` SET TAGS ('pii_business_glossary_term' = 'Barrier Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Mitigation Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_status` SET TAGS ('pii_business_glossary_term' = 'Barrier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_type` SET TAGS ('pii_business_glossary_term' = 'Barrier Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('pii_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_description` SET TAGS ('pii_business_glossary_term' = 'Barrier Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `documentation_source` SET TAGS ('pii_business_glossary_term' = 'Documentation Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `expected_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('pii_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `hcc_impact` SET TAGS ('pii_business_glossary_term' = 'Hcc Impact');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `hcc_impact` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `hcc_impact` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `identification_source` SET TAGS ('pii_business_glossary_term' = 'Identification Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `identification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Identification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `impact_score` SET TAGS ('pii_business_glossary_term' = 'Impact Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `intervention_applied` SET TAGS ('pii_business_glossary_term' = 'Intervention Applied');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `intervention_type` SET TAGS ('pii_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('pii_fhir_resource' = 'Encounter');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_id` SET TAGS ('pii_business_glossary_term' = 'Transition Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `care_gap_flag` SET TAGS ('pii_business_glossary_term' = 'Care Gap Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `compliance_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Compliance Consent Obtained');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `concurrent_review_schedule_date` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review Schedule Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `discharge_planning_status` SET TAGS ('pii_business_glossary_term' = 'Discharge Planning Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_coordination_status` SET TAGS ('pii_business_glossary_term' = 'Dme Coordination Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Dme Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_equipment_type` SET TAGS ('pii_business_glossary_term' = 'Dme Equipment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_order_date` SET TAGS ('pii_business_glossary_term' = 'Dme Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('pii_business_glossary_term' = 'Dme Ordering Supplier Npi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `duration_days` SET TAGS ('pii_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `follow_up_schedule_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Schedule Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `from_setting` SET TAGS ('pii_business_glossary_term' = 'From Setting');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `hcc_risk_factor` SET TAGS ('pii_business_glossary_term' = 'Hcc Risk Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `hcc_risk_factor` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `hcc_risk_factor` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `is_critical_transition` SET TAGS ('pii_business_glossary_term' = 'Is Critical Transition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_score` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_date` SET TAGS ('pii_business_glossary_term' = 'Snf Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Snf Admission Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_discharge_date` SET TAGS ('pii_business_glossary_term' = 'Snf Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_business_glossary_term' = 'Snf Facility Npi');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `to_setting` SET TAGS ('pii_business_glossary_term' = 'To Setting');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `toc_plan_completed` SET TAGS ('pii_business_glossary_term' = 'Toc Plan Completed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_number` SET TAGS ('pii_business_glossary_term' = 'Transition Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_status` SET TAGS ('pii_business_glossary_term' = 'Transition Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_type` SET TAGS ('pii_business_glossary_term' = 'Transition Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('pii_fhir_resource' = 'MeasureReport');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_rating_result_id` SET TAGS ('pii_business_glossary_term' = 'Star Rating Result Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'Hedis Measure Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_1_star` SET TAGS ('pii_business_glossary_term' = 'Cutpoint 1 Star');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_2_star` SET TAGS ('pii_business_glossary_term' = 'Cutpoint 2 Star');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_3_star` SET TAGS ('pii_business_glossary_term' = 'Cutpoint 3 Star');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_4_star` SET TAGS ('pii_business_glossary_term' = 'Cutpoint 4 Star');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_5_star` SET TAGS ('pii_business_glossary_term' = 'Cutpoint 5 Star');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `domain_star_score` SET TAGS ('pii_business_glossary_term' = 'Domain Star Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `improvement_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Improvement Measure Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('pii_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_weight` SET TAGS ('pii_business_glossary_term' = 'Measure Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `overall_star_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `quality_bonus_eligible` SET TAGS ('pii_business_glossary_term' = 'Quality Bonus Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('pii_business_glossary_term' = 'Rating Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_status` SET TAGS ('pii_business_glossary_term' = 'Rating Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_domain` SET TAGS ('pii_business_glossary_term' = 'Star Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_score` SET TAGS ('pii_business_glossary_term' = 'Star Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_direction` SET TAGS ('pii_business_glossary_term' = 'Trend Direction');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_star_score` SET TAGS ('pii_business_glossary_term' = 'Trend Star Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_year` SET TAGS ('pii_business_glossary_term' = 'Trend Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('pii_fhir_resource' = 'Observation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Assessment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Resource Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_version` SET TAGS ('pii_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `confidentiality_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'Follow Up Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `referral_made_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Made Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `referral_resource` SET TAGS ('pii_business_glossary_term' = 'Referral Resource');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('pii_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Sdoh Assessment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_business_glossary_term' = 'Sdoh Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_id` SET TAGS ('pii_business_glossary_term' = 'Team Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('pii_business_glossary_term' = 'Parent Team Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Lead Coordinator Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `audit_updated_by` SET TAGS ('pii_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('pii_business_glossary_term' = 'Behavioral Health Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_code` SET TAGS ('pii_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `communication_preference` SET TAGS ('pii_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('pii_business_glossary_term' = 'Community Health Worker Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `consent_obtained_date` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_method` SET TAGS ('pii_business_glossary_term' = 'Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `data_quality_status` SET TAGS ('pii_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_included` SET TAGS ('pii_business_glossary_term' = 'Hcc Included');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_included` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_included` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_version` SET TAGS ('pii_business_glossary_term' = 'Hcc Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_version` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_version` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `is_multidisciplinary` SET TAGS ('pii_business_glossary_term' = 'Is Multidisciplinary');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `is_primary_care_team` SET TAGS ('pii_business_glossary_term' = 'Is Primary Care Team');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `lead_coordinator_end_date` SET TAGS ('pii_business_glossary_term' = 'Lead Coordinator End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `lead_coordinator_start_date` SET TAGS ('pii_business_glossary_term' = 'Lead Coordinator Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `member_capacity` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `member_capacity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('pii_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `pharmacist_count` SET TAGS ('pii_business_glossary_term' = 'Pharmacist Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `privacy_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `provider_count` SET TAGS ('pii_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `social_worker_count` SET TAGS ('pii_business_glossary_term' = 'Social Worker Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `specialist_count` SET TAGS ('pii_business_glossary_term' = 'Specialist Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_status` SET TAGS ('pii_business_glossary_term' = 'Team Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_type` SET TAGS ('pii_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('pii_subdomain' = 'care_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('pii_association_edges' = 'member.identity,care.care_coordinator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('pii_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('pii_association_edges' = 'care.care_program,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('pii_association_edges' = 'care.care_program,compliance.accreditation_program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('pii_association_edges' = 'care.hedis_measure,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('pii_association_edges' = 'care.care_gap,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('pii_association_edges' = 'care.care_program,employer.employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Program Enrollment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `enrollment_cap` SET TAGS ('pii_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `participation_rate` SET TAGS ('pii_business_glossary_term' = 'Participation Rate');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('pii_fhir_resource' = 'Questionnaire');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_id` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `cahps_survey_id` SET TAGS ('pii_business_glossary_term' = 'Survey Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `question_set_id` SET TAGS ('pii_business_glossary_term' = 'Question Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `superseded_by_questionnaire_id` SET TAGS ('pii_business_glossary_term' = 'Parent Questionnaire Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_by` SET TAGS ('pii_business_glossary_term' = 'Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_comments` SET TAGS ('pii_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_code` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_description` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_assessment` SET TAGS ('pii_business_glossary_term' = 'Is Assessment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_customizable` SET TAGS ('pii_business_glossary_term' = 'Is Customizable');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_form` SET TAGS ('pii_business_glossary_term' = 'Is Form');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_legacy` SET TAGS ('pii_business_glossary_term' = 'Is Legacy');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_obsolete` SET TAGS ('pii_business_glossary_term' = 'Is Obsolete');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_predefined` SET TAGS ('pii_business_glossary_term' = 'Is Predefined');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_public` SET TAGS ('pii_business_glossary_term' = 'Is Public');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_questionnaire` SET TAGS ('pii_business_glossary_term' = 'Is Questionnaire');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_retired` SET TAGS ('pii_business_glossary_term' = 'Is Retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_survey` SET TAGS ('pii_business_glossary_term' = 'Is Survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_template` SET TAGS ('pii_business_glossary_term' = 'Is Template');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `language` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `language` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `locale` SET TAGS ('pii_business_glossary_term' = 'Locale');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `question_count` SET TAGS ('pii_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_type` SET TAGS ('pii_business_glossary_term' = 'Questionnaire Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_record_timestamp` SET TAGS ('pii_business_glossary_term' = 'Source Record Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('pii_subdomain' = 'risk_stratification');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('pii_fhir_resource' = 'Questionnaire');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_id` SET TAGS ('pii_business_glossary_term' = 'Question Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `parent_question_set_id` SET TAGS ('pii_business_glossary_term' = 'Parent Question Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_superseded_by_set_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `administration_mode` SET TAGS ('pii_business_glossary_term' = 'Administration Mode');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `branching_logic_flag` SET TAGS ('pii_business_glossary_term' = 'Branching Logic Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_category` SET TAGS ('pii_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_business_glossary_term' = 'Clinical Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('pii_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `frequency_requirement` SET TAGS ('pii_business_glossary_term' = 'Frequency Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hcc_raf_relevance_flag` SET TAGS ('pii_business_glossary_term' = 'Hcc Raf Relevance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hcc_raf_relevance_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hcc_raf_relevance_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hedis_measure_alignment` SET TAGS ('pii_business_glossary_term' = 'Hedis Measure Alignment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hipaa_sensitivity_level` SET TAGS ('pii_business_glossary_term' = 'Hipaa Sensitivity Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `instrument_source` SET TAGS ('pii_business_glossary_term' = 'Instrument Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `is_required_for_enrollment` SET TAGS ('pii_business_glossary_term' = 'Is Required For Enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `is_validated_instrument` SET TAGS ('pii_business_glossary_term' = 'Is Validated Instrument');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `language_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `language_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `maximum_score` SET TAGS ('pii_business_glossary_term' = 'Maximum Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `minimum_score` SET TAGS ('pii_business_glossary_term' = 'Minimum Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `owner_department` SET TAGS ('pii_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `regulatory_program` SET TAGS ('pii_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `risk_stratification_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Stratification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `scoring_methodology` SET TAGS ('pii_business_glossary_term' = 'Scoring Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `set_type` SET TAGS ('pii_business_glossary_term' = 'Set Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `target_population` SET TAGS ('pii_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `total_question_count` SET TAGS ('pii_business_glossary_term' = 'Total Question Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_fhir_resource' = 'EpisodeOfCare');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_ssot_ref' = 'member.member_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_ssot_concept' = 'member_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_vreq_skip_P207' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` SET TAGS ('pii_needs_population_batch' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `care_enrollment2_id` SET TAGS ('pii_business_glossary_term' = 'Care Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('pii_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `disenrollment_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `enrollment_number` SET TAGS ('pii_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'HCC Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `hcc_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `hcc_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `program_tier` SET TAGS ('pii_business_glossary_term' = 'Program Tier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_fhir_resource' = 'CarePlan');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('pii_skip_batch_processed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Care Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_care_subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Care Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `barriers_to_care` SET TAGS ('pii_business_glossary_term' = 'Barriers to Care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('pii_business_glossary_term' = 'Care Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `high_risk_flag` SET TAGS ('pii_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `progress_notes` SET TAGS ('pii_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `fhir_care_plan_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `care_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'care_enrollment Identifier');
