-- Schema for Domain: care | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`care` COMMENT 'Manages care management, disease management, and case management programs — chronic condition registries, care gaps, care plans, population health stratification, high-risk member outreach, and health risk assessments (HRA). Owns HCC/RAF-relevant clinical data, HEDIS measure tracking, CAHPS survey results, SNF/DME post-acute coordination, and care coordinator assignments. Source system: Casenet TruCare or Altruista. Distinct from utilization which owns UM/PA authorization workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the care program.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Disease management and wellness programs are frequently administered at specific facilities (e.g., hospital-based cardiac rehab, oncology center programs). Linking program to facility supports network',
    `formulary_id` BIGINT COMMENT 'FK to the pharmacy formulary associated with this program.',
    `group_practice_id` BIGINT COMMENT 'FK to the provider group practice delivering this program.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Care management programs (disease management, wellness, care coordination) are scoped to specific health plans — enrollment eligibility, funding, and regulatory reporting (CMS, NCQA) are all plan-spec',
    `provider_id` BIGINT COMMENT 'FK to the primary provider associated with this program.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Care management programs (disease management, complex case) operate within specific provider networks. Network-scoped program enrollment, adequacy reporting, and member eligibility validation all requ',
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
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: Care plan goals are frequently condition-specific (e.g., reduce HbA1c below 7.0 for diabetes, achieve blood pressure target for hypertension). Linking plan_goal.condition_registry_id -> care.condi',
    `coordinator_id` BIGINT COMMENT 'FK to the coordinator responsible for the goal.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Care plan goals (e.g., reduce HbA1c, lower ED utilization) are set against a baseline member risk score. Linking plan_goal to the member_risk_score that informed goal-setting enables goal-outcome vs. ',
    `care_plan_id` BIGINT COMMENT 'FK to the care plan.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Complex case management care plans assign individual clinical goals to specific providers (e.g., cardiologist owns the BP reduction goal, endocrinologist owns the A1C goal). Provider-level goal accoun',
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
    `target_date` DATE COMMENT 'Target date for goal achievement.',
    `target_unit` STRING COMMENT 'Unit of measurement for the target value.',
    `target_value` DECIMAL(18,2) COMMENT 'Target value for the goal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_plan_goal PRIMARY KEY(`plan_goal_id`)
) COMMENT 'Goals defined within a care plan with targets, measurements, and progress tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap` (
    `gap_id` BIGINT COMMENT 'Unique identifier for the care gap.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.case. Business justification: When a claim denial creates or perpetuates a HEDIS care gap, the gap record must reference the active appeal case. Care gap managers track which open gaps are under appeal to avoid duplicate outreach ',
    `coordinator_id` BIGINT COMMENT 'FK to the assigned care coordinator.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: HEDIS gap closure workflows require identifying the attributed provider responsible for closing each care gap. Provider outreach campaigns and gap closure reporting are driven by this attribution. Rol',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: A care gap is often driven by a specific chronic condition in the members condition registry (e.g., a gap in HbA1c testing for a member with diabetes). Linking gap.condition_registry_id -> care.condi',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Care gaps are frequently HCC-specific (e.g., unvalidated diabetes HCC). Linking gap directly to hcc_mapping supports risk-gap closure workflows where resolving a care gap validates an HCC code for RAP',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `hedis_measure_id` BIGINT COMMENT 'add column hedis_measure_id (BIGINT) with FK to care.hedis_measure.hedis_measure_id - gaps tie to specific quality measures',
    `member_risk_score_id` BIGINT COMMENT 'FK to the member risk score.',
    `subscriber_id` BIGINT COMMENT 'FK to the member/subscriber.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: HEDIS gaps in care are measured per member per plan year. Gap closure reporting and Star Ratings compliance require linking each gap to the plan election that defines the measurement year, denominator',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Care gaps identified for a member are typically addressed through an active care plan. Linking gap.care_plan_id -> care.care_plan.care_plan_id enables tracking of which care plan is responsible for cl',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Care gaps must reference the active policy to validate that gap-closing services are covered benefits. Policy-level gap reporting is required for HEDIS measure compliance — gap closure is only credite',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hra` (
    `hra_id` BIGINT COMMENT 'Unique identifier for the HRA.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: CMS Stars and HEDIS compliance require tracking which provider administered the HRA for quality attribution and outreach reporting. Role-prefix administering_ distinguishes this from the member iden',
    `condition_registry_id` BIGINT COMMENT 'add column condition_registry_id (BIGINT) with FK to care.condition_registry.condition_registry_id - HRA findings populate condition registry',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.coordinator. Business justification: Health Risk Assessments are administered by care coordinators. Adding coordinator_id to hra tracks which coordinator conducted the assessment, enabling caseload analysis, quality audits, and coordinat',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CMS mandates plan-level HRA tracking for Medicare Advantage Stars ratings. HRA completion rates are reported per health plan for HEDIS and regulatory compliance. Every HRA must be attributable to the ',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: HRA completion triggers or informs a formal member risk score record. Linking HRA to the resulting member_risk_score supports NCQA/CMS compliance reporting on HRA-to-risk-stratification workflows. ris',
    `member_risk_tier_id` BIGINT COMMENT 'Foreign key linking to care.member_risk_tier. Business justification: The hra table has a risk_tier STRING field that stores the risk tier assignment as free text. An HRA produces a formal risk stratification outcome that should reference the member_risk_tier record. No',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: HRAs are administered within a specific plan year tied to a plan election. Population health and NCQA compliance reporting require linking HRA completion rates and risk scores to the plan election yea',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: An HRA is a key clinical input that directly informs and is associated with a members care plan. Linking hra.care_plan_id -> care.care_plan.care_plan_id enables direct navigation from assessment to c',
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
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: CMS HCC risk adjustment audits require provider attribution for each documented condition. Knowing which provider diagnosed/confirmed a condition is mandatory for RAF validation and RADV audit defense',
    `hcc_mapping_id` BIGINT COMMENT 'add column hcc_mapping_id (BIGINT) with FK to risk.hcc_mapping.hcc_mapping_id - conditions map to HCCs for risk adjustment',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Condition registries are maintained at the health plan level for population health management, HEDIS measure denominator identification, and CMS risk adjustment submissions. Plan-level condition regis',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `care_plan_id` BIGINT COMMENT 'FK to the associated care plan.',
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
    CONSTRAINT pk_condition_registry PRIMARY KEY(`condition_registry_id`)
) COMMENT 'Registry of member conditions for disease management and risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure.',
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
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: HEDIS results cite specific claims as numerator/denominator evidence. The existing source_record_reference (text) and source_record_type are denormalized; a proper FK to claim.header enables structure',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `hedis_measure_id` BIGINT COMMENT 'FK to the HEDIS measure.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: CMS Star Ratings integrate HEDIS quality measures with risk adjustment scores. Linking hedis_result to member_risk_score enables integrated quality-risk reporting required for Star Rating submissions ',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: HEDIS denominator eligibility is determined by the members active plan election for the measurement year. CMS and NCQA compliance reporting require linking HEDIS results to the plan election to valid',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: HEDIS performance reporting is routinely stratified by provider network for regulatory submissions and network performance management. Plans must identify which network a HEDIS result is attributed to',
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
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'HEDIS measure results for individual members including compliance status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` (
    `member_risk_tier_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Risk tier assignments are plan-specific — a members tier determines care management interventions and PMPM cost bands under a specific health plan. Used in Stars ratings, risk adjustment reporting, a',
    `identity_id` BIGINT COMMENT '',
    `member_risk_score_id` BIGINT COMMENT 'add column member_risk_score_id (BIGINT) with FK to risk.member_risk_score.member_risk_score_id - risk tiers derive from underlying risk scores',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: The member_risk_tier table has a recommended_care_program STRING field that stores a program reference as free text. Normalizing this to a proper FK (program_id -> care.program.program_id) enforces re',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'Unique identifier for the care plan.',
    `coordinator_id` BIGINT COMMENT 'FK to the assigned care coordinator.',
    `dependent_id` BIGINT COMMENT 'Foreign key linking to member.dependent. Business justification: Dependents (pediatric CHIP/Medicaid enrollees, disabled dependents) require their own care plans managed separately from the subscriber. Care coordinators create dependent-specific care plans for chro',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Care plan activation and closure must align with eligibility spans — a care plan cannot remain active when a member loses eligibility. Care management operations and NCQA accreditation audits require ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: A care plan is always administered under a specific health plan — covered services, cost-sharing, and network access for care management goals are plan-determined. Required for care management reporti',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Care plans are created and stratified based on a members formal risk score. Linking to the specific member_risk_score record that triggered plan creation supports care management audit trails, plan e',
    `member_risk_tier_id` BIGINT COMMENT 'Foreign key linking to care.member_risk_tier. Business justification: Care plans in health insurance are created based on a members risk stratification tier — high-risk members receive intensive care plans, moderate-risk members receive standard plans. Linking care_pla',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `plan_care_subscriber_id` BIGINT COMMENT 'FK to the subscriber.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Care plans are authorized under a specific insurance policy — the policy defines covered benefits, cost-sharing, and authorization limits governing care plan interventions. Utilization management and ',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: Care plan execution requires verifying the primary providers current network participation status (panel open/closed, credentialing, tier designation). Role-prefix primary_ used because care_plan a',
    `provider_id` BIGINT COMMENT 'FK to the primary provider.',
    `program_id` BIGINT COMMENT 'FK to the care program.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Care plans are executed within a specific provider network context. Network determines which providers can be engaged, drives referral authorization rules, and is required for network-stratified care ',
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
    `version` STRING COMMENT 'Version number of the care plan.',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Individualized care plan for a member including goals, barriers, and provider assignments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` (
    `coordinator_program_assignment_id` BIGINT COMMENT 'Primary key for the coordinator_program_assignment association',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking this assignment record to the care coordinator being assigned.',
    `program_id` BIGINT COMMENT 'Foreign key linking this assignment record to the care management program the coordinator is assigned to.',
    `assignment_date` DATE COMMENT 'The date on which the coordinator was formally assigned to the program. Sourced directly from the detection phase relationship data.',
    `assignment_status` STRING COMMENT 'Current operational status of this coordinator-program assignment. Sourced directly from the detection phase relationship data.',
    `caseload_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the coordinators total caseload capacity allocated to this specific program assignment. Belongs to the relationship, not to the coordinator or program alone. Sourced directly from the detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'The date on which this coordinator-program assignment ends or was terminated. A null value indicates the assignment is currently active. Sourced directly from the detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'The date from which this coordinator-program assignment is operationally effective. Enables historical tracking of staffing changes. Sourced directly from the detection phase relationship data.',
    `primary_program_flag` BOOLEAN COMMENT 'Indicates whether this program is the coordinators primary program assignment. A coordinator may be assigned to multiple programs but only one can be flagged as primary. Sourced directly from the detection phase relationship data.',
    CONSTRAINT pk_coordinator_program_assignment PRIMARY KEY(`coordinator_program_assignment_id`)
) COMMENT 'This association product represents the formal staffing Assignment between a care coordinator and a care management program. It captures the operational record of which coordinators are assigned to which programs, including effective dates, caseload allocation, and assignment status. Each record links one coordinator to one program and carries attributes that exist only in the context of this specific staffing relationship — they cannot reside on either the coordinator or the program alone.. Existence Justification: In health insurance care management, coordinators are formally staffed across multiple programs (e.g., a coordinator with a chronic disease specialty may be assigned to both a Diabetes Management program and a Hypertension program simultaneously), and each program requires multiple coordinators to handle its full caseload. This is an operational staffing relationship — the business actively creates, updates, and terminates these assignments, tracking effective dates, caseload allocation percentages, and primary program designations per coordinator. The relationship is a recognized business concept called a Program Assignment or Coordinator Assignment that care management operations teams manage daily.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_member_risk_tier_id` FOREIGN KEY (`member_risk_tier_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`member_risk_tier`(`member_risk_tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_member_risk_tier_id` FOREIGN KEY (`member_risk_tier_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`member_risk_tier`(`member_risk_tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ADD CONSTRAINT `fk_care_coordinator_program_assignment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ADD CONSTRAINT `fk_care_coordinator_program_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_domain' = 'care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `clinical_protocol` SET TAGS ('dbx_business_glossary_term' = 'Clinical Protocol');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_current` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'HCC Included');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'HCC Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `is_evidence_based` SET TAGS ('dbx_business_glossary_term' = 'Is Evidence Based');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_actual` SET TAGS ('dbx_business_glossary_term' = 'Outcome Actual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_target` SET TAGS ('dbx_business_glossary_term' = 'Outcome Target');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_subdomain' = 'member_planning');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Goal ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_business_glossary_term' = 'Goal Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Goal Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Gap ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Care Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_business_glossary_term' = 'Closure Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Gap Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_business_glossary_term' = 'Assigned LOB');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_business_glossary_term' = 'Caseload Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `certification_codes` SET TAGS ('dbx_business_glossary_term' = 'Certification Codes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `current_caseload_count` SET TAGS ('dbx_business_glossary_term' = 'Current Caseload Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `training_certifications` SET TAGS ('dbx_business_glossary_term' = 'Training Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('dbx_subdomain' = 'member_planning');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `hra_id` SET TAGS ('dbx_business_glossary_term' = 'HRA ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `answered_questions` SET TAGS ('dbx_business_glossary_term' = 'Answered Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `community_resource_referrals` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Referrals');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('dbx_business_glossary_term' = 'Completion Channel');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_cms_required` SET TAGS ('dbx_business_glossary_term' = 'CMS Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_ncqa_required` SET TAGS ('dbx_business_glossary_term' = 'NCQA Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Health Risks');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `questionnaire_version` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `recommended_programs` SET TAGS ('dbx_business_glossary_term' = 'Recommended Programs');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_business_glossary_term' = 'SDOH Education');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_business_glossary_term' = 'SDOH Financial Strain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_business_glossary_term' = 'SDOH Food Insecurity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_business_glossary_term' = 'SDOH Housing Instability');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_business_glossary_term' = 'SDOH Social Isolation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_business_glossary_term' = 'SDOH Transportation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `total_questions` SET TAGS ('dbx_business_glossary_term' = 'Total Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_subdomain' = 'member_planning');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosing Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_condition_resource_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `fhir_condition_resource_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_pii_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `is_chronic` SET TAGS ('dbx_business_glossary_term' = 'Is Chronic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `raf_score` SET TAGS ('dbx_business_glossary_term' = 'RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_denominator_logic` SET TAGS ('dbx_business_glossary_term' = 'Measure Denominator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_business_glossary_term' = 'Measure Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_exclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Measure Exclusion Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Measure Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Measure Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_national_benchmark` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_numerator_logic` SET TAGS ('dbx_business_glossary_term' = 'Measure Numerator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('dbx_business_glossary_term' = 'Related HCC');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_raf` SET TAGS ('dbx_business_glossary_term' = 'Related RAF');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Scoring Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_business_glossary_term' = 'State Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_url` SET TAGS ('dbx_business_glossary_term' = 'Measure URL');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Result ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_created` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `denominator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Denominator Criteria Met');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_score` SET TAGS ('dbx_business_glossary_term' = 'Measure Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'Measure Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `numerator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Numerator Criteria Met');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_subdomain' = 'member_planning');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `claims_count_last_year` SET TAGS ('dbx_business_glossary_term' = 'Claims Count Last Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_business_glossary_term' = 'Demographic Group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hcc Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_business_glossary_term' = 'Pmpm Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_factor_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_business_glossary_term' = 'Tier Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_subdomain' = 'member_planning');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Care Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_care_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Care Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `barriers_to_care` SET TAGS ('dbx_business_glossary_term' = 'Barriers to Care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` SET TAGS ('dbx_association_edges' = 'care.coordinator,care.program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `coordinator_program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Program Assignment - Coordinator Program Assignment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Program Assignment - Coordinator Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Program Assignment - Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `caseload_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Caseload Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_program_assignment` ALTER COLUMN `primary_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Program Flag');
