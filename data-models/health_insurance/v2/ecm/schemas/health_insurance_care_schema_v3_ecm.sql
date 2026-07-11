-- Schema for Domain: care | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 20:47:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`care` COMMENT 'Manages care management, disease management, and case management programs — chronic condition registries, care gaps, care plans, population health stratification, high-risk member outreach, and health risk assessments (HRA). Owns HCC/RAF-relevant clinical data, HEDIS measure tracking, CAHPS survey results, SNF/DME post-acute coordination, and care coordinator assignments. Source system: Casenet TruCare or Altruista. Distinct from utilization which owns UM/PA authorization workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for the care program.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Contracts specify which provider contracts cover each care program; needed for eligibility, reimbursement, and program performance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for program budgeting; finance allocates expenses to cost centers per care program for HEDIS reporting and cost analysis.',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Required for Care Program drug coverage design; the program’s eligibility and benefit rules depend on a specific formulary defining covered medications.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: CMS requires linking each care program to its owning provider group for program ownership reporting and reimbursement audits.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Allows program expense transactions to be posted to specific GL ledger accounts for financial reporting and cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Program Ownership accountability report linking program_owner to the responsible employee.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Regulatory and operational policies assign a specific provider as program manager, enabling accountability and performance tracking.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Program cost allocation to a specific risk pool is required for risk‑adjustment and financial reporting.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Required for Program Contract Management report linking each care program to its governing vendor contract for compliance and cost tracking.',
    `accreditation_body` STRING COMMENT 'Organization that provides accreditation for the program.',
    `accreditation_status` STRING COMMENT 'Current accreditation state of the program (e.g., NCQA, URAC).. Valid values are `accredited|pending|denied`',
    `program_category` STRING COMMENT 'More granular category within the program type (e.g., diabetes, CHF, COPD).',
    `clinical_protocol` STRING COMMENT 'Standardized clinical pathway or guideline applied within the program.',
    `program_code` STRING COMMENT 'Internal code used to reference the program in operational systems.',
    `contact_email` STRING COMMENT 'Primary email address for program inquiries.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for program inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created.',
    `data_source_system` STRING COMMENT 'Operational system that provides the master program data (e.g., Casenet TruCare).',
    `program_description` STRING COMMENT 'Detailed narrative describing the programs purpose, services, and scope.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine member eligibility for enrollment in the program.',
    `end_date` DATE COMMENT 'Date the program is retired or no longer offered (nullable for open‑ended).',
    `enrollment_cap` BIGINT COMMENT 'Maximum number of members allowed to enroll in the program.',
    `enrollment_current` BIGINT COMMENT 'Number of members currently enrolled.',
    `enrollment_end_date` DATE COMMENT 'Date when enrollment closes for the program.',
    `enrollment_start_date` DATE COMMENT 'Date when enrollment opens for the program.',
    `evidence_source` STRING COMMENT 'Reference to the clinical study or guideline that validates the program.',
    `hcc_included` STRING COMMENT 'Comma‑separated list of HCC codes that are counted toward the programs risk adjustment.',
    `hcc_version` STRING COMMENT 'Version of the HCC model used for the program (e.g., 2024).',
    `is_evidence_based` BOOLEAN COMMENT 'Indicates whether the program is supported by clinical evidence.',
    `last_review_date` DATE COMMENT 'Date the program was last reviewed for clinical relevance or compliance.',
    `line_of_business` STRING COMMENT 'Business line to which the program applies.. Valid values are `individual|group|medicare|medicaid|exchange|government`',
    `program_name` STRING COMMENT 'Human‑readable name of the care program.',
    `outcome_actual` STRING COMMENT 'Most recent observed value for the outcome measure.',
    `outcome_measure` STRING COMMENT 'Key performance indicator used to evaluate program effectiveness.',
    `outcome_target` STRING COMMENT 'Target value or threshold for the outcome measure.',
    `review_frequency` STRING COMMENT 'How often the program is scheduled for review.. Valid values are `annual|biennial|quarterly|monthly|semiannual`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations (e.g., 0.1234).',
    `start_date` DATE COMMENT 'Date the program becomes effective and available to members.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|suspended|retired|draft`',
    `target_population` STRING COMMENT 'Demographic or clinical segment the program is designed for.',
    `program_type` STRING COMMENT 'Broad classification of the program offering.. Valid values are `disease_management|case_management|maternity|behavioral_health|wellness|chronic_care`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Version identifier for the program definition.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master registry of all care management, disease management, and case management programs offered by the health plan — including chronic condition programs (diabetes, CHF, COPD, asthma), complex case management, maternity management, behavioral health programs, and population health initiatives. Tracks program type, eligibility criteria, clinical protocols, accreditation standards (NCQA/URAC), program status, and line-of-business applicability. Source: Casenet TruCare or Altruista program configuration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` (
    `care_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each care enrollment record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this enrollment.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for Employer‑Sponsored Program Enrollment reporting and ACA employer‑level enrollment compliance; employers need to see which members enrolled via their group.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Underwriting uses a members risk score at enrollment; linking provides audit trail for premium determination.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member enrolled in the care program.',
    `program_id` BIGINT COMMENT 'Identifier of the care, disease, or case management program to which the member is enrolled.',
    `acuity_level` STRING COMMENT 'Clinical acuity assigned to the member for this program.. Valid values are `low|moderate|high|critical`',
    `care_manager_assigned_date` DATE COMMENT 'Date the care manager was officially assigned to the member.',
    `consent_status` STRING COMMENT 'Members consent status for participation and data sharing within the program.. Valid values are `consented|declined|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `disenrollment_date` DATE COMMENT 'Actual date the member left the program.',
    `effective_end_date` DATE COMMENT 'Planned termination date of the enrollment (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the enrollment becomes effective.',
    `enrollment_number` STRING COMMENT 'Business identifier assigned to the enrollment, used in operational reporting and member communications.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request, indicating how the member entered the program.. Valid values are `outreach|referral|self_referral|claims_triggered|hra_triggered`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the enrollment.. Valid values are `active|inactive|completed|disenrolled|pending`',
    `enrollment_type` STRING COMMENT 'Category of care program (e.g., disease management).. Valid values are `disease_management|case_management|population_health|wellness`',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score associated with the member at enrollment.',
    `notes` STRING COMMENT 'Free‑form notes entered by care staff regarding the enrollment.',
    `program_tier` STRING COMMENT 'Level of service intensity offered by the program.. Valid values are `standard|enhanced|premium`',
    `reason` STRING COMMENT 'Business reason or clinical trigger for enrolling the member.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score used for prioritizing outreach (0‑100).',
    `status_reason` STRING COMMENT 'Explanation for the current enrollment status (e.g., member request, clinical criteria).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_care_enrollment PRIMARY KEY(`care_enrollment_id`)
) COMMENT 'Tracks member enrollment into specific care management, disease management, or case management programs — capturing enrollment date, disenrollment date, enrollment source (outreach, referral, self-referral, claims-triggered, HRA-triggered), consent status, program tier, enrollment status, and acuity level. Represents the active participation record linking a member to a care program. Coordinator assignment details are maintained on the care_coordinator product. Distinct from health plan enrollment (owned by the enrollment domain). Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'System-generated unique identifier for the care plan record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the plan.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Needed for Pharmacy Benefit Management integration; care plan references the pharmacy vendor responsible for medication fulfillment, used in cost and quality reporting.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member for whom the care plan is created.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Care plans must be overseen by a designated primary care provider to ensure care coordination and meet NCQA quality measures.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Plan belongs to a program; adding program_id FK establishes parent-child relationship and enables join to program attributes.',
    `barriers_to_care` STRING COMMENT 'Identified obstacles that may impede goal achievement (e.g., transportation, language).',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the care plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the care plan expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the care plan becomes effective for the member.',
    `high_risk_flag` BOOLEAN COMMENT 'Indicates whether the member meets high‑risk criteria for intensive management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the care plan, e.g., "Diabetes Management Plan".',
    `plan_number` STRING COMMENT 'External business identifier assigned to the care plan, used in member communications and reporting.',
    `plan_type` STRING COMMENT 'Category of the care plan indicating its primary focus area.. Valid values are `clinical|behavioral|sdoh|social|pharmacologic`',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to share health information for care planning.',
    `progress_notes` STRING COMMENT 'Free‑text notes documenting progress toward the goal.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score (e.g., HCC/RAF) used to prioritize care management resources.',
    `care_plan_status` STRING COMMENT 'Current lifecycle status of the care plan.. Valid values are `active|inactive|completed|abandoned|draft`',
    `version` STRING COMMENT 'Incremental version number tracking revisions to the care plan.',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Individualized care plan created for a member enrolled in a care or case management program — documenting clinical and behavioral goals (goal description, category, target value, target date, status: active/achieved/abandoned, progress notes), interventions, barriers to care, target dates, care coordinator assignments, plan status, and clinical/progress notes. Goals are modeled as embedded detail records within the care plan with independent status tracking, enabling multi-dimensional progress measurement across clinical, behavioral, and SDOH goal categories. Single source of truth for all care plan goal lifecycle management. Supports longitudinal tracking of member health outcomes. Aligns with NCQA care management standards and CMS chronic care management (CCM) requirements. Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` (
    `plan_goal_id` BIGINT COMMENT 'System-generated unique identifier for the care plan goal.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan to which this goal belongs.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the staff member responsible for overseeing the goal.',
    `actual_date` DATE COMMENT 'Date when the actual value was recorded.',
    `actual_value` DECIMAL(18,2) COMMENT 'Measured value achieved toward the goal.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the goal complies with clinical guidelines or regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal record was first created in the system.',
    `goal_category` STRING COMMENT 'Classification of the goal indicating its domain (e.g., clinical, behavioral, social determinant).. Valid values are `clinical|behavioral|social_determinant|pharmacologic|nutrition`',
    `goal_code` STRING COMMENT 'Business identifier or code assigned to the goal for reference and reporting.',
    `goal_name` STRING COMMENT 'Human‑readable name or title of the care plan goal.',
    `measurement_type` STRING COMMENT 'Source or method of the measurement (e.g., lab result, vital sign).. Valid values are `lab|vital|self_report|clinical_assessment`',
    `priority` STRING COMMENT 'Priority level assigned to the goal to guide care team focus.. Valid values are `high|medium|low`',
    `progress_notes` STRING COMMENT 'Free‑text notes documenting progress, barriers, or interventions related to the goal.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score associated with the goal (e.g., based on HCC/RAF models).',
    `plan_goal_status` STRING COMMENT 'Current lifecycle status of the goal.. Valid values are `active|achieved|abandoned|on_hold|cancelled`',
    `target_date` DATE COMMENT 'Date by which the goal is expected to be met.',
    `target_unit` STRING COMMENT 'Unit of measure for the target value.. Valid values are `mg/dL|mmol/L|%|mmHg|kg|steps`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target the member should achieve (e.g., HbA1c 7.0).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goal record.',
    CONSTRAINT pk_plan_goal PRIMARY KEY(`plan_goal_id`)
) COMMENT 'Individual clinical or behavioral goals defined within a member care plan — including goal description, goal category (clinical, behavioral, social determinants), target value, target date, goal status (active, achieved, abandoned), and progress notes. Each goal has its own lifecycle independent of the parent care plan, enabling granular tracking of member progress across multiple care dimensions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap` (
    `gap_id` BIGINT COMMENT 'Unique identifier for the care gap record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to address the gap.',
    `header_id` BIGINT COMMENT 'Identifier of the claim that contributed to closing the gap.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for HEDIS gap analysis reports that aggregate gaps by health plan, a regulatory reporting need.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Care gap prioritization incorporates the members risk score; FK ties gap records to the underlying risk score.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with the care gap.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network‑adequacy reports require linking each care gap to the provider network of the members primary provider to assess coverage gaps.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Closing care gaps may be assigned to specific vendors (e.g., labs); linking provides accountability and compliance reporting.',
    `actual_resolution_date` DATE COMMENT 'Date when the care gap was actually resolved.',
    `clinical_category` STRING COMMENT 'Clinical domain or condition associated with the gap (e.g., diabetes, cardiovascular).',
    `close_date` DATE COMMENT 'Date when the care gap was resolved or closed (nullable if still open).',
    `closure_method` STRING COMMENT 'Method by which the care gap was closed.. Valid values are `claim|supplemental|attestation|provider_update|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care gap record was created in the lakehouse.',
    `gap_description` STRING COMMENT 'Narrative description of the identified care gap.',
    `documentation_status` STRING COMMENT 'Status of required documentation for the care gap.. Valid values are `complete|pending|missing`',
    `hedis_measure_code` STRING COMMENT 'Standard HEDIS measure code linked to the care gap.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the gap is considered critical for member health.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Expected target value for the measure (e.g., HbA1c <7%).',
    `open_date` DATE COMMENT 'Date when the care gap was first identified.',
    `priority_level` STRING COMMENT 'Business-assigned priority for addressing the care gap.. Valid values are `high|medium|low`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score associated with the gap (e.g., based on HCC/RAF).',
    `gap_status` STRING COMMENT 'Current lifecycle status of the care gap.. Valid values are `open|closed|in_progress|resolved`',
    `target_date` DATE COMMENT 'Desired date by which the care gap should be closed.',
    `gap_type` STRING COMMENT 'Category of the care gap (e.g., preventive service, chronic condition management).. Valid values are `preventive|chronic|medication|screening|followup|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care gap record.',
    CONSTRAINT pk_gap PRIMARY KEY(`gap_id`)
) COMMENT 'Registry of identified care gaps for members — preventive services, chronic condition management measures, and HEDIS-aligned quality measures that have not been completed (e.g., HbA1c testing, mammography, colorectal cancer screening, medication adherence). Tracks gap type, HEDIS measure code, gap open date, gap close date, closure method (claim, supplemental data, attestation), and gap status. Core to HEDIS performance and Star Ratings improvement programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator` (
    `coordinator_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each care coordinator record.',
    `employee_id` BIGINT COMMENT 'Identifier of the coordinators direct supervisor (another care coordinator).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Some care coordinators are external vendor staff; linking tracks vendor‑provided coordination services for staffing and cost analysis.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Credentialing staff for care coordination requires linking each coordinator to their credential record for compliance reporting and audit of licensing/sanctions.',
    `assigned_lob` STRING COMMENT 'Business line for which the coordinator primarily provides services.. Valid values are `individual|group|employer|government`',
    `caseload_capacity` STRING COMMENT 'Maximum number of members the coordinator can actively manage.',
    `caseload_weight` DECIMAL(18,2) COMMENT 'Weighted factor reflecting case complexity for workload balancing.',
    `certification_codes` STRING COMMENT 'Comma‑separated list of professional certifications (e.g., CCM, ACM, CPH).',
    `current_caseload_count` STRING COMMENT 'Number of members currently assigned to the coordinator.',
    `email_address` STRING COMMENT 'Primary email address used for secure communications with the coordinator.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment state of the coordinator.. Valid values are `active|inactive|on_leave|terminated`',
    `first_name` STRING COMMENT 'Given name of the care coordinator.',
    `full_name` STRING COMMENT 'Legal full name of the care coordinator as used in member communications and credentialing.',
    `hire_date` DATE COMMENT 'Date the coordinator was hired by the organization.',
    `last_name` STRING COMMENT 'Family name of the care coordinator.',
    `last_training_date` DATE COMMENT 'Date of the most recent mandatory training completed by the coordinator.',
    `notes` STRING COMMENT 'Free‑form notes entered by supervisors or administrators about the coordinator.',
    `organization_unit` STRING COMMENT 'Department or unit within the health plan where the coordinator is assigned.',
    `phone_number` STRING COMMENT 'Primary telephone number for reaching the coordinator.. Valid values are `^+?[0-9]{1,3}[ -]?(?[0-9]{3})?[ -]?[0-9]{3}[ -]?[0-9]{4}$`',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the coordinator.. Valid values are `email|phone|portal`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the coordinator record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coordinator record.',
    `role_type` STRING COMMENT 'Functional role of the coordinator within the care management domain.. Valid values are `care_coordinator|case_manager|disease_management_nurse|health_coach`',
    `specialty_area` STRING COMMENT 'Clinical specialty or disease focus of the coordinator.. Valid values are `diabetes|cardiology|oncology|behavioral_health|pediatrics|geriatrics`',
    `coordinator_status` STRING COMMENT 'Current lifecycle status of the coordinator record.. Valid values are `active|inactive|suspended|retired`',
    `termination_date` DATE COMMENT 'Date the coordinators employment ended, if applicable.',
    `training_certifications` STRING COMMENT 'Comma‑separated list of completed training programs (e.g., HEDIS, STAR).',
    CONSTRAINT pk_coordinator PRIMARY KEY(`coordinator_id`)
) COMMENT 'Master record for care coordinators, case managers, disease management nurses, and health coaches — capturing demographics, credentials (RN, LCSW, CHW), certifications (CCM, ACM), caseload capacity, specialty focus areas, assigned LOB, active status, and supervisor hierarchy. Single source of truth for coordinator-to-member assignment history including assignment date, assignment type (primary, backup, specialist), assignment reason, caseload weight, assignment status, reassignment/handoff tracking, and continuity-of-care documentation. Enables caseload management, workload balancing, continuity-of-care reporting, and coordinator performance analytics. Source: Casenet TruCare or Altruista workforce configuration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` (
    `member_outreach_id` BIGINT COMMENT 'Unique identifier for each outreach activity record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the person or system that executed the outreach.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who was contacted.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Outreach activities are often outsourced to call‑center vendors; linking enables performance metrics and regulatory reporting of member contact.',
    `channel` STRING COMMENT 'Communication channel through which the outreach was performed.. Valid values are `phone|mail|sms|portal`',
    `compliance_consent_obtained` BOOLEAN COMMENT 'True when required consent for contacting the member was documented.',
    `consent_obtained_date` DATE COMMENT 'Date on which the member gave consent for outreach communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outreach record was first created in the lakehouse.',
    `follow_up_due_date` DATE COMMENT 'Target date for completing any required follow‑up.',
    `follow_up_required` BOOLEAN COMMENT 'True when additional contact or action is needed after the outreach.',
    `is_automated` BOOLEAN COMMENT 'True if the outreach was generated by an automated workflow; false if manual.',
    `language_preference` STRING COMMENT 'Preferred language of the member for outreach communications.. Valid values are `en|es|fr|other`',
    `outcome` STRING COMMENT 'Observed outcome of the outreach interaction.. Valid values are `reached|voicemail|refused|enrolled|no_answer|partial`',
    `outcome_timestamp` TIMESTAMP COMMENT 'Date and time when the outcome of the outreach was logged.',
    `outreach_duration_seconds` STRING COMMENT 'Length of the phone call or interaction measured in seconds.',
    `outreach_notes` STRING COMMENT 'Additional comments or details recorded about the outreach.',
    `outreach_timestamp` TIMESTAMP COMMENT 'Date and time when the outreach attempt occurred.',
    `purpose` STRING COMMENT 'Reason for contacting the member, such as enrolling in a program or closing a care gap.. Valid values are `program_enrollment|care_gap_closure|hra_completion|medication_adherence|wellness_education|other`',
    `member_outreach_status` STRING COMMENT 'Lifecycle state of the outreach activity record.. Valid values are `pending|completed|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the outreach record.',
    CONSTRAINT pk_member_outreach PRIMARY KEY(`member_outreach_id`)
) COMMENT 'Records of outreach activities conducted by care coordinators or automated systems to engage high-risk members in care management programs — including outreach date, outreach channel (phone, mail, SMS, portal), outreach purpose (program enrollment, care gap closure, HRA completion, medication adherence), outcome (reached, left voicemail, refused, enrolled), and follow-up requirements. Supports population health engagement tracking and HEDIS outreach documentation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hra` (
    `hra_id` BIGINT COMMENT 'Unique surrogate key for each health risk assessment record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Health risk assessments are conducted by third‑party vendors; linking supports audit of assessment source and compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or system that performed the assessment.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who completed the assessment.',
    `questionnaire_id` BIGINT COMMENT 'Identifier of the questionnaire definition used.',
    `answered_questions` STRING COMMENT 'Number of questions answered by the member.',
    `assessment_date` DATE COMMENT 'Date when the health risk assessment was performed.',
    `assessment_status` STRING COMMENT 'Current processing status of the assessment record.. Valid values are `completed|in_progress|cancelled|pending_review`',
    `assessment_type` STRING COMMENT 'Indicates whether the record is a Health Risk Assessment or a Social Determinants of Health screening.. Valid values are `HRA|SDOH`',
    `assessment_version` STRING COMMENT 'Version identifier of the assessment questionnaire used.',
    `community_resource_referrals` STRING COMMENT 'List of community resources referred to the member based on assessment findings.',
    `completion_channel` STRING COMMENT 'Channel through which the member completed the assessment.. Valid values are `portal|phone|mail|in_person`',
    `compliance_cms_required` BOOLEAN COMMENT 'Indicates if the assessment is required for CMS reporting.',
    `compliance_ncqa_required` BOOLEAN COMMENT 'Indicates if the assessment satisfies NCQA SDOH standards.',
    `identified_health_risks` STRING COMMENT 'Free‑text list of clinical health risks identified in the assessment.',
    `notes` STRING COMMENT 'Free‑form notes captured by the assessor.',
    `questionnaire_version` STRING COMMENT 'Version string of the questionnaire definition.',
    `recommended_programs` STRING COMMENT 'Care programs or interventions recommended for the member.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the data warehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score calculated from the assessment responses.',
    `risk_score_percentile` DECIMAL(18,2) COMMENT 'Members risk score percentile compared to the plan population.',
    `risk_tier` STRING COMMENT 'Risk tier derived from the risk score.. Valid values are `low|moderate|high|very_high`',
    `screening_tool` STRING COMMENT 'Name of the questionnaire or tool used for the assessment.. Valid values are `plan_specific|ahc_hrs|prapare|hunger_vital|custom`',
    `sdoh_education` BOOLEAN COMMENT 'Indicates if the member reported education-related barriers.',
    `sdoh_financial_strain` BOOLEAN COMMENT 'Indicates if the member reported financial strain.',
    `sdoh_food_insecurity` BOOLEAN COMMENT 'Indicates if the member reported food insecurity.',
    `sdoh_housing_instability` BOOLEAN COMMENT 'Indicates if the member reported housing instability.',
    `sdoh_social_isolation` BOOLEAN COMMENT 'Indicates if the member reported social isolation.',
    `sdoh_transportation` BOOLEAN COMMENT 'Indicates if the member reported transportation barriers.',
    `total_questions` STRING COMMENT 'Total number of questions in the questionnaire.',
    CONSTRAINT pk_hra PRIMARY KEY(`hra_id`)
) COMMENT 'Health Risk Assessment (HRA) and Social Determinants of Health (SDOH) screening records completed by members — capturing assessment date, assessment type (HRA, SDOH screening), assessment version, screening tool (plan-specific HRA, AHC HRSN, PRAPARE, Hunger Vital Sign), completion channel (portal, phone, mail), risk score, risk tier (low, moderate, high, very high), identified health risks, SDOH domain flags (food insecurity, housing instability, transportation, social isolation, financial strain, education), community resource referrals, recommended programs, and assessment status. Includes the versioned questionnaire catalog (question text, category, response type, scoring weight) and individual member responses with clinical flag triggers. Single source of truth for all member health risk and SDOH assessments. HRAs are a CMS-required data element for Medicare Advantage plans and drive care program enrollment and risk stratification. SDOH screenings support CMS health equity requirements and NCQA SDOH standards. Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` (
    `condition_registry_id` BIGINT COMMENT 'System-generated unique identifier for each condition registry record.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan linked to this condition, if any.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the condition applies.',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Underwriting cases reference member conditions; linking enables traceability of medical evidence used in risk classification.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the condition is currently active for the member.',
    `condition_category` STRING COMMENT 'Business classification of the condition (e.g., HCC‑mapped, HEDIS chronic, behavioral health).. Valid values are `HCC|HEDIS|Behavioral|Other`',
    `condition_code` STRING COMMENT 'Standard ICD-10 diagnosis code representing the clinical condition.. Valid values are `^[A-Z][0-9][0-9A-Z]{0,3}$`',
    `condition_description` STRING COMMENT 'Human‑readable description of the condition.',
    `confirmation_status` STRING COMMENT 'Current confirmation state of the condition record.. Valid values are `confirmed|pending|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was first created.',
    `data_quality_status` STRING COMMENT 'Current data quality assessment of the condition record.. Valid values are `valid|invalid|pending_review`',
    `effective_end_date` DATE COMMENT 'Date the condition ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date the condition became effective for care program eligibility.',
    `hcc_code` STRING COMMENT 'HCC code derived from the condition for risk adjustment scoring.',
    `identification_date` DATE COMMENT 'Date the condition was first identified for the member.',
    `identification_method` STRING COMMENT 'Method used to identify the condition for the member.. Valid values are `claims|ehr|provider_attestation|hra`',
    `is_chronic` BOOLEAN COMMENT 'Flag indicating whether the condition is considered chronic for HEDIS and risk adjustment.',
    `last_review_date` DATE COMMENT 'Date the condition record was last reviewed for accuracy.',
    `notes` STRING COMMENT 'Free‑text clinical notes or comments about the condition.',
    `onset_date` DATE COMMENT 'Date when the condition first manifested.',
    `population_segment` STRING COMMENT 'Segment of the member population based on the conditions risk level.. Valid values are `high_risk|medium_risk|low_risk`',
    `raf_score` DECIMAL(18,2) COMMENT 'Calculated RAF score associated with the condition.',
    `resolution_date` DATE COMMENT 'Date when the condition was resolved or considered inactive.',
    `risk_adjustment_flag` BOOLEAN COMMENT 'Indicates if the condition contributes to risk‑adjusted payments.',
    `severity` STRING COMMENT 'Clinical severity level of the condition.. Valid values are `mild|moderate|severe|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    CONSTRAINT pk_condition_registry PRIMARY KEY(`condition_registry_id`)
) COMMENT 'Chronic condition registry identifying members with specific diagnosed conditions — including ICD-10 condition code, condition category (HCC-mapped, HEDIS chronic condition, behavioral health), identification method (claims-based, EHR, provider attestation, HRA), identification date, confirmation status, and active/inactive flag. Serves as the authoritative clinical condition roster within the care domain for care program targeting, population health stratification, and HEDIS measure eligibility determination. References the risk domain for authoritative HCC/RAF scoring. Source: Casenet TruCare or Altruista clinical data.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure. [_canonical_skip_reason: REFERENCE_LOOKUP - catalog of HEDIS quality measures]',
    `compliance_regulatory_obligation_id` BIGINT COMMENT 'add column compliance_regulatory_obligation_id (BIGINT) with FK to compliance.compliance_regulatory_obligation.compliance_regulatory_obligation_id - HEDIS measures are regulatory quality requirements',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measure record was first created in the data lake.',
    `data_collection_methodology` STRING COMMENT 'Method used to collect data for the measure (administrative, hybrid, or survey).. Valid values are `administrative|hybrid|survey`',
    `denominator_definition` STRING COMMENT 'Exact definition of the denominator component of the measure.',
    `effective_date` DATE COMMENT 'Date when the measure became effective for reporting.',
    `eligible_population_criteria` STRING COMMENT 'Eligibility rules that define the member cohort for the measure.',
    `exclusion_criteria` STRING COMMENT 'Conditions or member attributes that exclude a member from the denominator.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measure record.',
    `measure_code` STRING COMMENT 'Official NCQA code that uniquely identifies the measure.',
    `measure_denominator_logic` STRING COMMENT 'Detailed logical expression or algorithm used to compute the denominator.',
    `measure_description` STRING COMMENT 'Full textual description of what the measure evaluates.',
    `measure_domain` STRING COMMENT 'High‑level domain of the measure (e.g., effectiveness of care, access/availability, utilization).. Valid values are `effectiveness_of_care|access_availability|utilization`',
    `measure_exclusion_logic` STRING COMMENT 'Detailed logical expression defining exclusions from the denominator.',
    `measure_last_reviewed_date` DATE COMMENT 'Date when the measure definition was last reviewed for accuracy.',
    `measure_last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `measure_name` STRING COMMENT 'Descriptive name of the HEDIS quality measure.',
    `measure_national_benchmark` DECIMAL(18,2) COMMENT 'National average performance for the measure (percentage).',
    `measure_notes` STRING COMMENT 'Free‑form notes or comments about the measure.',
    `measure_numerator_logic` STRING COMMENT 'Detailed logical expression or algorithm used to compute the numerator.',
    `measure_owner` STRING COMMENT 'Business unit or team responsible for the measure.',
    `measure_related_hcc` STRING COMMENT 'Comma‑separated list of Hierarchical Condition Category (HCC) codes relevant to the measure.',
    `measure_related_raf` STRING COMMENT 'Comma‑separated list of Risk Adjustment Factor (RAF) variables linked to the measure.',
    `measure_reporting_frequency` STRING COMMENT 'How often the measure is reported (annual, semi‑annual, quarterly).. Valid values are `annual|semiannual|quarterly`',
    `measure_scoring_method` STRING COMMENT 'Method used to calculate the final score (e.g., rate, percentage, binary).. Valid values are `rate|percentage|binary`',
    `measure_star_rating_impact` STRING COMMENT 'Explanation of how the measure influences Medicare Star Ratings.',
    `measure_state_benchmark` DECIMAL(18,2) COMMENT 'State‑level average performance for the measure (percentage).',
    `measure_status` STRING COMMENT 'Current lifecycle status of the measure.. Valid values are `active|retired|draft|pending`',
    `measure_target_value` DECIMAL(18,2) COMMENT 'Target performance value or threshold for the measure.',
    `measure_url` STRING COMMENT 'Link to the official documentation or specification for the measure.',
    `measurement_year` STRING COMMENT 'Calendar year for which the measure is defined.',
    `numerator_definition` STRING COMMENT 'Exact definition of the numerator component of the measure.',
    `retirement_date` DATE COMMENT 'Date when the measure was retired or superseded (null if still active).',
    `version_number` STRING COMMENT 'Version of the measure definition, incremented on each change.',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'Reference catalog of HEDIS (Healthcare Effectiveness Data and Information Set) quality measures maintained by NCQA — including measure ID, measure name, measure domain (effectiveness of care, access/availability, utilization), measurement year, eligible population criteria, numerator definition, denominator definition, exclusion criteria, and data collection methodology (administrative, hybrid, survey). Authoritative reference for HEDIS performance tracking and Star Ratings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'System-generated unique identifier for each HEDIS result record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `hedis_measure_id` BIGINT COMMENT 'Standard code for the HEDIS quality measure (e.g., HM-001).',
    `identity_id` BIGINT COMMENT 'Unique identifier for the member to whom the HEDIS result applies.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider associated with the source claim or service.',
    `audit_created` TIMESTAMP COMMENT 'Timestamp when the HEDIS result record was first created in the lakehouse.',
    `audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HEDIS result record.',
    `collection_method` STRING COMMENT 'Methodology used to collect the underlying data for the measure.. Valid values are `administrative|hybrid|survey`',
    `compliance_status` STRING COMMENT 'Overall compliance outcome for the member on this measure.. Valid values are `compliant|non_compliant|excluded`',
    `data_source` STRING COMMENT 'Origin of the data used to determine the HEDIS result.. Valid values are `claim|lab|supplemental|medical_record`',
    `denominator_criteria_met` BOOLEAN COMMENT 'Indicates whether the member satisfied the denominator condition (typically eligibility).',
    `eligibility_criteria` STRING COMMENT 'Logical definition of the member population eligible for the measure.',
    `exclusion_criteria` STRING COMMENT 'Specific criteria that triggered the members exclusion.',
    `exclusion_reason` STRING COMMENT 'Reason or code describing why the member was excluded.',
    `is_excluded` BOOLEAN COMMENT 'True if the member is excluded from the measure based on exclusion criteria.',
    `measure_category` STRING COMMENT 'Category grouping of the measure (e.g., preventive, chronic).. Valid values are `preventive|chronic|behavioral|screening`',
    `measure_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to the member for the measure (if applicable).',
    `measure_type` STRING COMMENT 'Classification of the measure as process, outcome, or structure.. Valid values are `process|outcome|structure`',
    `measure_version` STRING COMMENT 'Version or edition of the measure as published by NCQA.',
    `measurement_year` STRING COMMENT 'Calendar year for which the HEDIS measurement is reported.',
    `numerator_criteria_met` BOOLEAN COMMENT 'Indicates whether the member satisfied the numerator condition for the measure.',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the HEDIS result was calculated.',
    `source_record_reference` STRING COMMENT 'Identifier of the underlying source record (e.g., claim ID, lab result ID).',
    `source_record_type` STRING COMMENT 'Type of the source record that supplied data for the result.. Valid values are `claim|lab|medical_record`',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Single source of truth for HEDIS (Healthcare Effectiveness Data and Information Set) quality measure definitions and member-level compliance results. Contains the authoritative NCQA-published measure catalog (measure ID, name, domain: effectiveness of care/access/availability/utilization, measurement year, eligible population criteria, numerator/denominator definitions, exclusion criteria, data collection methodology: administrative/hybrid/survey) and member-level results indicating whether each member met numerator criteria for a given measurement year. Tracks data source (claim, lab, supplemental, medical record), compliance status (compliant, non-compliant, excluded), and hybrid audit trail. Aggregated to produce plan-level HEDIS rates submitted to NCQA for Star Ratings, accreditation, and quality bonus payments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each CAHPS survey record.',
    `member_enrollment_id` BIGINT COMMENT 'Identifier of the health plan the member was enrolled in during the survey.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member who completed the survey.',
    `vendor_id` BIGINT COMMENT 'System identifier for the survey vendor.',
    `administration_method` STRING COMMENT 'Method used to deliver the survey to members.. Valid values are `mail|phone|mixed|electronic`',
    `composite_score_flag` BOOLEAN COMMENT 'Indicates whether the overall score is a composite of domain scores.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first loaded into the warehouse.',
    `customer_service_score` DECIMAL(18,2) COMMENT 'Average score for the "Customer Service" domain.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the survey data (e.g., "Casenet TruCare").',
    `doctor_communication_score` DECIMAL(18,2) COMMENT 'Average score for the "Doctor Communication" domain.',
    `external_survey_code` STRING COMMENT 'External identifier used by the survey vendor or regulatory reporting (e.g., vendor‑assigned code).',
    `getting_care_quickly_score` DECIMAL(18,2) COMMENT 'Average score for the "Getting Care Quickly" domain.',
    `getting_needed_care_score` DECIMAL(18,2) COMMENT 'Average score for the "Getting Needed Care" domain.',
    `is_test_survey` BOOLEAN COMMENT 'Flag indicating whether the record represents a test or pilot survey.',
    `member_age` STRING COMMENT 'Age of the member at the time of survey administration.',
    `member_gender` STRING COMMENT 'Gender of the member.. Valid values are `male|female|other`',
    `member_state` STRING COMMENT 'Two‑letter state code of the members residence.',
    `member_zip` STRING COMMENT 'Five‑digit ZIP code of the members residence.',
    `notes` STRING COMMENT 'Free‑text field for any additional comments or observations about the survey.',
    `overall_satisfaction_score` DECIMAL(18,2) COMMENT 'Composite overall satisfaction rating derived from the survey.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the survey results are included in CMS Star Ratings reporting.',
    `response_deadline` DATE COMMENT 'Final date by which members could submit responses.',
    `response_rate` DECIMAL(18,2) COMMENT 'Percentage of sampled members who returned a completed survey.',
    `sample_size` STRING COMMENT 'Number of members selected for the survey sample.',
    `sampling_frame` STRING COMMENT 'Description of the member population from which the sample was drawn.',
    `star_rating_impact_score` DECIMAL(18,2) COMMENT 'Score representing the contribution of this survey to the plans Star Rating.',
    `survey_end_date` DATE COMMENT 'Date when the survey administration closed.',
    `survey_language` STRING COMMENT 'Language in which the survey was presented to the member.. Valid values are `english|spanish|other`',
    `survey_mode` STRING COMMENT 'Indicates whether the survey was self‑administered or conducted by an interviewer.. Valid values are `self_administered|interviewer_administered`',
    `survey_name` STRING COMMENT 'Human‑readable name of the CAHPS survey (e.g., "2023 Health Plan CAHPS").',
    `survey_start_date` DATE COMMENT 'Date when the survey administration began.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `pending|in_progress|completed|closed`',
    `survey_type` STRING COMMENT 'Classification of the CAHPS survey variant.. Valid values are `health_plan|medicare|pcmh`',
    `survey_version` STRING COMMENT 'Version identifier for the survey instrument.',
    `survey_year` STRING COMMENT 'Calendar year the survey was administered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'CAHPS (Consumer Assessment of Healthcare Providers and Systems) survey administration and response records — capturing survey type (Health Plan CAHPS, Medicare CAHPS, PCMH CAHPS), survey year, administration method (mail, phone, mixed), member sampling frame, survey vendor, response status, overall satisfaction score, and individual member responses by question with composite score contribution flags. CAHPS results feed directly into CMS Star Ratings and NCQA accreditation. Enables drill-down analysis of member experience drivers across CAHPS domains (getting needed care, getting care quickly, doctor communication, customer service). Source: Survey vendor data.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`population_segment` (
    `population_segment_id` BIGINT COMMENT 'System-generated unique identifier for the population segment.',
    `employee_id` BIGINT COMMENT 'Identifier of the care coordinator or team responsible for the segment.',
    `health_plan_id` BIGINT COMMENT 'add column plan_health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - population segments are defined within health plan contexts',
    `audit_created_by` STRING COMMENT 'User or process that initially created the segment record.',
    `audit_updated_by` STRING COMMENT 'User or process that performed the most recent update to the segment record.',
    `average_pmpm_cost` DECIMAL(18,2) COMMENT 'Average per‑member‑per‑month cost for members in the segment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created in the lakehouse.',
    `effective_from` DATE COMMENT 'Date on which the segment becomes effective for member assignment.',
    `effective_until` DATE COMMENT 'Date on which the segment expires or is superseded (null for open‑ended).',
    `inclusion_criteria_description` STRING COMMENT 'Narrative description of the clinical and demographic rules that define segment membership.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this segment is the default fallback for uncategorized members.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the segment calculation engine.',
    `last_run_user` STRING COMMENT 'User or service account that triggered the most recent segment refresh.',
    `pmpm_cost_band` STRING COMMENT 'Cost band indicating expected average PMPM expense for the segment.. Valid values are `low|medium|high`',
    `population_count` BIGINT COMMENT 'Number of members currently assigned to the segment.',
    `recommended_care_program` STRING COMMENT 'Name or code of the care management program recommended for members in this segment.',
    `risk_tier` STRING COMMENT 'Risk tier classification for the segment used to prioritize care management outreach.. Valid values are `low|rising|high|catastrophic`',
    `segment_code` STRING COMMENT 'Business identifier code for the segment, often used in external systems and analytics.',
    `segment_description` STRING COMMENT 'Extended description providing context and business purpose of the segment.',
    `segment_name` STRING COMMENT 'Human‑readable name of the segment used for reporting and UI display.',
    `segment_owner_role` STRING COMMENT 'Role of the owner (e.g., care_coordinator, population_health_manager).',
    `segment_type` STRING COMMENT 'Methodology used to create the segment (e.g., predictive risk model, HCC‑based, claims‑based, or custom).. Valid values are `predictive_risk|hcc_based|claims_based|custom`',
    `population_segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|draft|retired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment record.',
    `version_number` STRING COMMENT 'Version of the segment definition; increments when criteria change.',
    CONSTRAINT pk_population_segment PRIMARY KEY(`population_segment_id`)
) COMMENT 'Population health stratification segments defining risk tiers and care management targeting criteria — including segment name, stratification model (predictive risk model, HCC-based, claims-based), risk tier (low, rising risk, high, catastrophic), inclusion criteria, recommended care program, PMPM cost band, and effective date. Used to assign members to appropriate care management interventions and prioritize outreach resources. Source: Casenet TruCare or Altruista population health module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` (
    `member_risk_tier_id` BIGINT COMMENT 'System‑generated unique identifier for each risk‑tier record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to which the tier assignment applies.',
    `pool_id` BIGINT COMMENT 'add column risk_pool_id (BIGINT) with FK to risk.pool.pool_id - member risk tiers feed into risk pool stratification',
    `assignment_date` DATE COMMENT 'Date the tier was assigned to the member.',
    `assignment_method` STRING COMMENT 'Method used to assign the tier to a member.. Valid values are `automated_model|manual_override|clinical_review`',
    `chronic_condition_flag` BOOLEAN COMMENT 'True if the member has at least one chronic condition flagged.',
    `claims_count_last_year` STRING COMMENT 'Number of claims submitted by the member in the prior 12 months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created.',
    `demographic_group` STRING COMMENT 'Broad demographic segment of the member.. Valid values are `adult|senior|child|young_adult|teen`',
    `effective_from` DATE COMMENT 'Date when the tier definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the tier definition expires (null for open‑ended).',
    `hcc_score` DECIMAL(18,2) COMMENT 'Hierarchical Condition Category score used for RAF calculations.',
    `inclusion_criteria` STRING COMMENT 'Business rules that determine member eligibility for this tier.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this row represents the members current active tier.',
    `model_type` STRING COMMENT 'Type of model used to generate the tier assignment.. Valid values are `predictive|hcc_based|claims_based`',
    `next_reassessment_date` DATE COMMENT 'Planned date for the next risk‑tier reassessment.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes.',
    `pmpm_cost_band` STRING COMMENT 'Per‑Member‑Per‑Month cost band associated with the tier.. Valid values are `low|medium|high`',
    `recommended_care_program` STRING COMMENT 'Name or code of the care program recommended for members in this tier.',
    `risk_factor_weight` DECIMAL(18,2) COMMENT 'Weight applied to the risk factor in the predictive model.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score associated with the tier (higher indicates greater risk).',
    `risk_score_source` STRING COMMENT 'Origin of the risk score used for the assignment.. Valid values are `model|clinical_review|manual`',
    `segment_description` STRING COMMENT 'Detailed description of the segment criteria.',
    `segment_name` STRING COMMENT 'Name of the population segment definition linked to this tier.',
    `member_risk_tier_status` STRING COMMENT 'Current lifecycle status of the tier definition.. Valid values are `active|inactive|retired`',
    `tier_band` STRING COMMENT 'Broad risk band classification.. Valid values are `low|rising|high|catastrophic`',
    `tier_code` STRING COMMENT 'Business identifier/code used to reference the tier in downstream systems.',
    `tier_name` STRING COMMENT 'Human‑readable name of the risk tier (e.g., "High Risk").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `version_number` STRING COMMENT 'Version of the tier definition for change tracking.',
    CONSTRAINT pk_member_risk_tier PRIMARY KEY(`member_risk_tier_id`)
) COMMENT 'Member-level risk tier assignment and population health stratification — containing population segment definitions (segment name, stratification model: predictive risk model/HCC-based/claims-based, risk tier bands: low/rising risk/high/catastrophic, inclusion criteria, recommended care program, PMPM cost band, effective date) and member-specific tier assignments (risk score, assignment date, assignment method: automated model/manual override/clinical review, next reassessment date). Single source of truth for both population segment configuration and member-level risk tier history. Tracks risk tier changes over time to support longitudinal population health management and care program targeting. Distinct from CMS RAF scores (owned by the risk domain) — this covers all LOBs and internal stratification models. Source: Casenet TruCare or Altruista population health module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` (
    `snf_stay_id` BIGINT COMMENT 'Primary key uniquely identifying the SNF stay record.',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan associated with the SNF stay.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: SNF stays are reimbursed under specific provider contracts; linking enables claim adjudication and cost tracking per contract.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the SNF stay.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Linking SNF stays to the facility master record supports quality reporting, cost analysis, and CMS SNF performance metrics.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member/patient associated with the SNF stay.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior authorization that approved the SNF stay.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Skilled‑nursing facility stays are billed through contracted networks; linking enables utilization and cost tracking per network.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: SNF stay costs are allocated to a risk pool for actuarial and reporting purposes.',
    `admission_diagnosis_code` STRING COMMENT 'ICD‑10 code representing the primary diagnosis at SNF admission.',
    `admission_diagnosis_description` STRING COMMENT 'Full textual description of the admission diagnosis.',
    `admission_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the member was admitted to the SNF.',
    `care_gap_flag` BOOLEAN COMMENT 'Indicates whether a documented care gap exists for the member during the stay.',
    `concurrent_review_schedule_date` DATE COMMENT 'Planned date for the concurrent utilization review of the stay.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|JPY|... — promote to reference product]',
    `discharge_destination` STRING COMMENT 'Destination where the member was discharged (e.g., home, rehab, hospital).',
    `discharge_planning_status` STRING COMMENT 'Current status of discharge planning activities.. Valid values are `pending|completed|not_required`',
    `discharge_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the member was discharged from the SNF.',
    `drg_code` STRING COMMENT 'DRG code assigned to the SNF stay for reimbursement purposes.',
    `hcc_score` DECIMAL(18,2) COMMENT 'Risk adjustment score derived from members clinical conditions.',
    `is_eligible_for_medicare` BOOLEAN COMMENT 'Indicates whether the member is eligible for Medicare during the stay.',
    `is_eligible_for_medicare_advantage` BOOLEAN COMMENT 'Indicates whether the member is eligible for Medicare Advantage during the stay.',
    `length_of_stay_days` STRING COMMENT 'Calculated total number of days the member stayed in the SNF.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after adjustments.',
    `notes` STRING COMMENT 'Free‑text clinical notes captured by care managers during the stay.',
    `patient_condition_at_admission` STRING COMMENT 'Narrative description of the patient’s clinical condition at admission.',
    `readmission_reason` STRING COMMENT 'Reason documented for any readmission within 30 days.',
    `readmission_risk_flag` BOOLEAN COMMENT 'Flag indicating whether the member is at high risk of readmission.',
    `readmission_within_30_days` BOOLEAN COMMENT 'Flag indicating if the member was readmitted within 30 days of discharge.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the SNF stay record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SNF stay record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied for risk‑adjusted payment calculations.',
    `snf_facility_npi` STRING COMMENT 'NPI of the SNF facility providing post‑acute care.',
    `snf_type` STRING COMMENT 'Classification of the SNF facility type.. Valid values are `skilled_nursing|rehab|long_term_care`',
    `snf_stay_status` STRING COMMENT 'Current lifecycle status of the SNF stay.. Valid values are `admitted|active|discharged|cancelled|transferred`',
    `stay_number` STRING COMMENT 'External business identifier for the SNF stay used in reporting and claims.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Total monetary adjustments (discounts, contractual allowances) applied to the gross charge.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount billed for the SNF stay before adjustments.',
    `transition_of_care_plan` STRING COMMENT 'Narrative description of the transition‑of‑care plan for the member after discharge.',
    CONSTRAINT pk_snf_stay PRIMARY KEY(`snf_stay_id`)
) COMMENT 'Skilled Nursing Facility (SNF) post-acute stay records managed by the care management team — capturing admission date, discharge date, SNF facility NPI, admission diagnosis, care coordinator assigned, concurrent review schedule, discharge planning status, readmission risk flag, and transition-of-care plan. Care management owns SNF coordination distinct from utilization management which owns the PA authorization. Supports CMS SNF quality reporting and readmission reduction programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` (
    `dme_coordination_id` BIGINT COMMENT 'System-generated unique identifier for the DME coordination record.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: DME coordination services are governed by contracts with suppliers; the FK supports payment, compliance, and utilization reporting.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the DME.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the DME.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Associating DME coordination with the ordering provider enables compliance tracking and accurate billing under Medicare rules.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the coordination meets all applicable CMS/HIPAA compliance requirements.',
    `coordination_reason` STRING COMMENT 'Clinical or functional reason for DME coordination (e.g., chronic respiratory condition).',
    `coordination_status` STRING COMMENT 'Current lifecycle status of the DME coordination process.. Valid values are `pending|ordered|delivered|in_use|completed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DME coordination record was first created.',
    `delivery_date` DATE COMMENT 'Date the DME was delivered to the member.',
    `dme_model` STRING COMMENT 'Manufacturer model name or number of the DME.',
    `dme_serial_number` STRING COMMENT 'Serial number of the DME unit for traceability.',
    `dme_type` STRING COMMENT 'Category of DME being coordinated.. Valid values are `wheelchair|cpap|oxygen|infusion_pump|other`',
    `effective_end_date` DATE COMMENT 'Date when the DME coordination ends or is no longer covered (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the DME coordination becomes effective for coverage.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow‑up assessment after DME delivery.',
    `follow_up_notes` STRING COMMENT 'Free‑text notes from the follow‑up visit.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the coordination_status last changed.',
    `notes` STRING COMMENT 'Additional free‑form information related to the DME coordination.',
    `order_date` DATE COMMENT 'Date the DME was ordered.',
    `prior_authorization_number` STRING COMMENT 'Reference number for the prior authorization request.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for the DME.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.. Valid values are `not_required|pending|approved|denied`',
    `supplier_npi` STRING COMMENT 'NPI of the DME supplier or vendor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DME coordination record.',
    `urgency_level` STRING COMMENT 'Priority assigned to the DME coordination based on clinical need.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_dme_coordination PRIMARY KEY(`dme_coordination_id`)
) COMMENT 'Durable Medical Equipment (DME) coordination records managed by care management for high-risk members — capturing DME type (wheelchair, CPAP, oxygen, infusion pump), ordering provider NPI, DME supplier NPI, order date, delivery date, coordination status, care coordinator assigned, and follow-up schedule. Supports post-acute care transitions and chronic condition management where DME is a critical care component. Distinct from DME claims (owned by the claim domain).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`barrier` (
    `barrier_id` BIGINT COMMENT 'Unique surrogate key for each documented barrier to care.',
    `employee_id` BIGINT COMMENT 'Identifier of the care manager who recorded or is responsible for the barrier.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member experiencing the barrier.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Barrier mitigation can be performed by external vendors; linking supports cost allocation and effectiveness reporting.',
    `care_manager_assigned_date` DATE COMMENT 'Date the care manager was assigned to the member for this barrier.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the barrier record was first created.',
    `barrier_description` STRING COMMENT 'Free-text description of the specific barrier identified.',
    `documentation_source` STRING COMMENT 'Reference to the source document or note ID where the barrier was originally recorded.',
    `expected_resolution_date` DATE COMMENT 'Target date by which the barrier is expected to be resolved.',
    `follow_up_date` DATE COMMENT 'Scheduled date for a follow‑up check on barrier status.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up action is scheduled after the initial intervention.',
    `geographic_location` STRING COMMENT 'Five‑digit ZIP code of the members residence (used for geographic analysis).. Valid values are `^d{5}(-d{4})?$`',
    `hcc_impact` BOOLEAN COMMENT 'True if the barrier is expected to affect Hierarchical Condition Category scoring.',
    `identification_source` STRING COMMENT 'Origin of the barrier information (e.g., Health Risk Assessment, care coordinator assessment).. Valid values are `hra|care_coordinator|member_self_report|provider|claims_data`',
    `identification_timestamp` TIMESTAMP COMMENT 'Date and time when the barrier was first recorded.',
    `impact_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the barriers impact on member health outcomes.',
    `intervention_applied` STRING COMMENT 'Narrative of the action taken to address the barrier.',
    `intervention_type` STRING COMMENT 'Standardized category of the intervention applied.. Valid values are `referral|transport_service|financial_assistance|education|language_service|telehealth`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the barrier is deemed critical for immediate action.',
    `notes` STRING COMMENT 'Supplemental free-text notes captured by care staff.',
    `resolution_date` DATE COMMENT 'Date when the barrier was resolved or closed.',
    `resolution_notes` STRING COMMENT 'Detailed notes describing how the barrier was resolved or why it remains open.',
    `resolution_outcome` STRING COMMENT 'Final outcome classification after the barrier handling process.. Valid values are `resolved|mitigated|unresolved|partial`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor indicating how the barrier influences the members risk adjustment score.',
    `severity_level` STRING COMMENT 'Assessed severity of the barriers impact on care.. Valid values are `low|moderate|high|critical`',
    `barrier_status` STRING COMMENT 'Current lifecycle status of the barrier record.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `barrier_type` STRING COMMENT 'Category of the barrier affecting care access.. Valid values are `transportation|cost|language|health_literacy|social_determinant|medication_adherence`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the barrier record.',
    CONSTRAINT pk_barrier PRIMARY KEY(`barrier_id`)
) COMMENT 'Documented barriers to care identified during care management interactions — including barrier type (transportation, cost, language, health literacy, SDOH, medication adherence, provider access), identification date, identification source (HRA, coordinator assessment, member self-report), resolution status, resolution date, and intervention applied. Enables SDOH-driven care management and supports CMS health equity reporting requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`transition` (
    `transition_id` BIGINT COMMENT 'System-generated unique identifier for each care transition record.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Care transitions (e.g., hospital to SNF) are covered by contracts that define coverage rules; needed for transition planning and financial accountability.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to manage the transition.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Transitions may involve equipment supplied by vendors; linking records the equipment vendor for discharge planning and readmission risk analysis.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Transitions of care require identifying the destination facility for readmission risk assessment and discharge planning compliance.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Enables plan‑level readmission and transition risk metrics used in quality and compliance reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member undergoing the care transition.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Transitions between care settings must reference the provider network to coordinate discharge planning and readmission risk assessment.',
    `care_gap_flag` BOOLEAN COMMENT 'Indicates whether the transition addresses a documented care gap.',
    `compliance_consent_obtained` BOOLEAN COMMENT 'True when the member has provided consent for data sharing required for transition reporting.',
    `concurrent_review_schedule_date` DATE COMMENT 'Planned date for the next concurrent utilization review while in SNF.',
    `consent_obtained_date` DATE COMMENT 'Date the required consent was captured.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transition record was first created in the system.',
    `discharge_planning_status` STRING COMMENT 'Current status of discharge planning activities.. Valid values are `not_started|in_progress|completed`',
    `dme_coordination_status` STRING COMMENT 'Current status of DME coordination and installation.. Valid values are `pending|ordered|delivered|installed|completed`',
    `dme_delivery_date` DATE COMMENT 'Date the DME was delivered to the member.',
    `dme_equipment_type` STRING COMMENT 'Category of DME ordered for the member during transition.. Valid values are `wheelchair|oxygen|hospital_bed|monitor|other`',
    `dme_order_date` DATE COMMENT 'Date the DME order was placed.',
    `dme_ordering_supplier_npi` STRING COMMENT 'NPI of the supplier providing the DME.',
    `duration_days` STRING COMMENT 'Number of days between from_setting departure and to_setting arrival.',
    `follow_up_schedule_date` DATE COMMENT 'Planned date for post‑transition follow‑up with the member.',
    `from_setting` STRING COMMENT 'Care setting from which the member is moving (e.g., hospital, skilled nursing facility).. Valid values are `hospital|snf|home|ed|outpatient`',
    `hcc_risk_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor derived from HCCs relevant to the transition.',
    `is_critical_transition` BOOLEAN COMMENT 'True if the transition is flagged as clinically critical (e.g., high‑risk patient).',
    `notes` STRING COMMENT 'Additional free‑form comments captured by care staff.',
    `number` STRING COMMENT 'Human‑readable business identifier assigned to the transition for tracking and reporting.',
    `outcome` STRING COMMENT 'Result of the transition event for the member.. Valid values are `successful|readmitted|complication|deceased`',
    `readmission_risk_assessment_date` DATE COMMENT 'Date the readmission risk score was calculated.',
    `readmission_risk_flag` BOOLEAN COMMENT 'True when the readmission risk score exceeds the configured threshold.',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Predictive score (0‑100) indicating likelihood of readmission within 30 days.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Overall risk adjustment factor applied for payment modeling.',
    `snf_admission_date` DATE COMMENT 'Date the member was admitted to the skilled nursing facility.',
    `snf_admission_diagnosis_code` STRING COMMENT 'ICD‑10 code representing the primary diagnosis at SNF admission.',
    `snf_discharge_date` DATE COMMENT 'Date the member was discharged from the skilled nursing facility.',
    `snf_facility_npi` STRING COMMENT 'National Provider Identifier of the SNF receiving the member.',
    `transition_status` STRING COMMENT 'Current processing state of the transition record.. Valid values are `pending|in_progress|completed|cancelled|failed`',
    `timestamp` TIMESTAMP COMMENT 'Exact date‑time when the transition occurred.',
    `to_setting` STRING COMMENT 'Care setting to which the member is transferred.. Valid values are `hospital|snf|home|ed|outpatient`',
    `toc_plan_completed` BOOLEAN COMMENT 'Indicates whether the Transition of Care (TOC) plan was fully completed.',
    `transition_type` STRING COMMENT 'Type of transition event (e.g., discharge, transfer).. Valid values are `discharge|transfer|admission|return`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transition record.',
    CONSTRAINT pk_transition PRIMARY KEY(`transition_id`)
) COMMENT 'Single source of truth for care transitions and all post-acute coordination — tracking member movements between care settings (hospital to home, hospital to SNF, SNF to home, ED to outpatient) and associated post-acute service management. Includes SNF stay records (admission/discharge dates, facility NPI, admission diagnosis, concurrent review schedule, discharge planning status, readmission risk flag) and DME coordination (equipment type, ordering/supplier NPI, order/delivery dates, coordination status, follow-up schedule). Captures transition date, from/to settings, transition type, care coordinator assigned, TOC plan completion status, readmission risk score, and transition outcome. Supports CMS Transitions of Care (TOC) HEDIS measure, SNF quality reporting, readmission reduction programs, and chronic condition DME management. Distinct from utilization management PA authorizations (owned by utilization domain) and DME claims (owned by claim domain). Source: Casenet TruCare or Altruista.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` (
    `star_rating_result_id` BIGINT COMMENT 'Unique surrogate key for each star rating result record.',
    `provider_contract_id` BIGINT COMMENT 'External contract or plan identifier (H/S-number) associated with the star rating.',
    `hedis_measure_id` BIGINT COMMENT 'Unique CMS identifier for the specific quality measure (e.g., "M001").',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the star rating result record was first loaded into the lakehouse.',
    `cutpoint_1_star` DECIMAL(18,2) COMMENT 'Performance threshold required to achieve a 1‑star rating for the measure.',
    `cutpoint_2_star` DECIMAL(18,2) COMMENT 'Performance threshold required to achieve a 2‑star rating for the measure.',
    `cutpoint_3_star` DECIMAL(18,2) COMMENT 'Performance threshold required to achieve a 3‑star rating for the measure.',
    `cutpoint_4_star` DECIMAL(18,2) COMMENT 'Performance threshold required to achieve a 4‑star rating for the measure.',
    `cutpoint_5_star` DECIMAL(18,2) COMMENT 'Performance threshold required to achieve a 5‑star rating for the measure.',
    `data_source` STRING COMMENT 'Origin of the rating data – either CMS‑published or internally derived.. Valid values are `cms|internal`',
    `domain_star_score` STRING COMMENT 'Aggregated star score for the domain (Part C or Part D).',
    `improvement_measure_flag` BOOLEAN COMMENT 'True if the measure is designated as an improvement measure for the rating period.',
    `measure_name` STRING COMMENT 'Full descriptive name of the CMS quality measure.',
    `measure_weight` DECIMAL(18,2) COMMENT 'Weight (percentage) of the measure in the calculation of the overall star rating.',
    `measurement_year` STRING COMMENT 'Calendar year in which the star rating measurement was performed.',
    `notes` STRING COMMENT 'Additional comments or observations about the rating result.',
    `overall_star_rating` STRING COMMENT 'Final overall star rating (1‑5) for the contract/plan.',
    `plan_type` STRING COMMENT 'Classification of the health plan for which the rating is calculated.. Valid values are `medicare_advantage|part_d|dual_eligible`',
    `quality_bonus_eligible` BOOLEAN COMMENT 'Indicates whether the plan qualifies for the CMS Quality Bonus Payment.',
    `rating_name` STRING COMMENT 'Human‑readable label for the star rating result (e.g., "2023 Medicare Advantage Star Rating").',
    `rating_status` STRING COMMENT 'Current lifecycle status of the rating result.. Valid values are `final|provisional|draft|retracted`',
    `star_domain` STRING COMMENT 'Domain of the star rating (Part C, Part D, or overall).. Valid values are `part_c|part_d|overall`',
    `star_score` STRING COMMENT 'Star score (1‑5) awarded for the specific measure.',
    `trend_direction` STRING COMMENT 'Direction of change compared to the prior year (up, down, or stable).. Valid values are `up|down|stable`',
    `trend_star_score` STRING COMMENT 'Star score achieved in the trend comparison year.',
    `trend_year` STRING COMMENT 'Prior year used for year‑over‑year star rating trend analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the star rating result record.',
    CONSTRAINT pk_star_rating_result PRIMARY KEY(`star_rating_result_id`)
) COMMENT 'CMS Star Ratings measure definitions and plan-level/contract-level results for Medicare Advantage and Part D plans. Contains the CMS-published measure catalog (measure ID, name, Star domain, data source, cut points for each star level 1-5, measure weight) and actual plan results including contract ID (H/S-number), measurement year, individual measure star scores, domain star scores, summary/Part C/Part D star ratings, quality bonus payment (QBP) eligibility, improvement measures, and year-over-year trends. Single source of truth for Star Ratings measure definitions and plan-level performance. Supports executive reporting, quality improvement prioritization, CMS audit readiness, and QBP revenue forecasting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` (
    `sdoh_assessment_id` BIGINT COMMENT 'Unique identifier for the SDOH assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who performed the assessment.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member being assessed.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: SDOH referrals often go to community‑resource vendors; linking enables outcome tracking and vendor performance measurement.',
    `assessment_date` DATE COMMENT 'Date when the SDOH assessment was conducted.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score summarizing assessment risk (if applicable).',
    `assessment_version` STRING COMMENT 'Version number of the assessment instrument used.',
    `confidentiality_consent_flag` BOOLEAN COMMENT 'Members consent for sharing SDOH data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was created.',
    `follow_up_due_date` DATE COMMENT 'Date by which follow-up should be completed.',
    `follow_up_status` STRING COMMENT 'Current status of follow-up actions.. Valid values are `pending|completed|not_needed`',
    `notes` STRING COMMENT 'Free-text notes captured during assessment.',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether a referral to community resources was made.',
    `referral_resource` STRING COMMENT 'Name or code of the community resource referred.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk adjustment calculations (e.g., HCC).',
    `risk_level` STRING COMMENT 'Risk level determined from the assessment.. Valid values are `low|moderate|high`',
    `screening_tool` STRING COMMENT 'Standardized tool used to conduct the assessment.. Valid values are `AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN`',
    `sdoh_domain` STRING COMMENT 'Domain of social determinant assessed.. Valid values are `food_insecurity|housing_instability|transportation|social_isolation|financial_strain|education`',
    `sdoh_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `active|inactive|archived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_sdoh_assessment PRIMARY KEY(`sdoh_assessment_id`)
) COMMENT 'Social Determinants of Health (SDOH) assessment records capturing non-clinical factors affecting member health outcomes — including assessment date, SDOH domain (food insecurity, housing instability, transportation, social isolation, financial strain, education), screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign), risk level, referral to community resource made flag, and follow-up status. Supports CMS health equity requirements, NCQA SDOH standards, and targeted care management interventions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`team` (
    `team_id` BIGINT COMMENT 'Unique system-generated identifier for the care team.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Care teams operate under specific provider contracts that dictate service scope and payment; linking supports team‑level cost and quality reporting.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the primary care coordinator leading the team.',
    `parent_team_id` BIGINT COMMENT 'Self-referencing FK on team (parent_team_id)',
    `program_id` BIGINT COMMENT 'Identifier of the care program to which the team is linked.',
    `audit_created_by` STRING COMMENT 'System user identifier that created the record.',
    `audit_updated_by` STRING COMMENT 'System user identifier that performed the most recent update.',
    `behavioral_health_provider_count` STRING COMMENT 'Count of behavioral health clinicians (psychologists, counselors) on the team.',
    `team_code` STRING COMMENT 'Business code used to reference the care team in external systems.',
    `communication_preference` STRING COMMENT 'Preferred method for the team to receive communications.. Valid values are `email|phone|portal|mail|sms`',
    `community_health_worker_count` STRING COMMENT 'Count of community health workers on the team.',
    `consent_obtained_date` DATE COMMENT 'Date on which privacy consent was obtained.',
    `contact_email` STRING COMMENT 'Email address used for team communications.',
    `contact_method` STRING COMMENT 'Primary way the team is contacted for operational matters.. Valid values are `email|phone|portal`',
    `contact_phone` STRING COMMENT 'Phone number used for team communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care team record was first created.',
    `data_quality_status` STRING COMMENT 'Assessment of the data quality for this record.. Valid values are `good|questionable|bad`',
    `effective_end_date` DATE COMMENT 'Date when the care team was deactivated or retired.',
    `effective_start_date` DATE COMMENT 'Date when the care team became operational.',
    `hcc_included` BOOLEAN COMMENT 'True if HCCs are included in the team’s risk profile.',
    `hcc_version` STRING COMMENT 'Version of the HCC model applied to the team’s risk calculations.',
    `is_multidisciplinary` BOOLEAN COMMENT 'True if the team includes multiple professional disciplines.',
    `is_primary_care_team` BOOLEAN COMMENT 'True if this team is the members primary care team.',
    `last_review_date` DATE COMMENT 'Date when the record’s data quality was last reviewed.',
    `lead_coordinator_end_date` DATE COMMENT 'Date the lead coordinators assignment ended, if applicable.',
    `lead_coordinator_start_date` DATE COMMENT 'Date the lead coordinator began their assignment.',
    `member_count` STRING COMMENT 'Count of members currently assigned to this care team.',
    `team_name` STRING COMMENT 'Human‑readable name of the care team.',
    `notes` STRING COMMENT 'Free‑form notes about the care team.',
    `pharmacist_count` STRING COMMENT 'Count of pharmacists participating in the care team.',
    `privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the team has documented privacy consent for handling PHI.',
    `provider_count` STRING COMMENT 'Total number of provider‑type members (PCP, specialists, etc.) on the team.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used in risk adjustment calculations for the team.',
    `social_worker_count` STRING COMMENT 'Count of social workers on the team.',
    `specialist_count` STRING COMMENT 'Count of specialist clinicians on the team.',
    `team_status` STRING COMMENT 'Current lifecycle status of the care team.. Valid values are `active|inactive|pending|closed`',
    `status_reason` STRING COMMENT 'Narrative explanation for the current status of the team.',
    `team_type` STRING COMMENT 'Classification of the team based on its functional focus.. Valid values are `clinical|non_clinical|behavioral|pharmacy|social`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care team record.',
    `version_number` STRING COMMENT 'Version number for optimistic concurrency control.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Multi-disciplinary care team composition for members enrolled in care management programs — documenting team members by role (PCP, specialist, behavioral health provider, pharmacist, social worker, community health worker), their NPI or staff ID, team role start/end dates, lead coordinator designation, and communication preferences. Supports NCQA care management standards requiring documented care team composition, CMS chronic care management (CCM) billing requirements, and care coordination across clinical and non-clinical team members. Enables care team roster reporting, role gap identification, and team-based care analytics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` (
    `coordinator_assignment_id` BIGINT COMMENT 'Primary key for coordinator_assignment',
    `coordinator_id` BIGINT COMMENT 'Auto-generated FK linking siloed coordinator_assignment to coordinator',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving care coordination.',
    `subscriber_id` BIGINT COMMENT 'add column member_subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - coordinator assignments must specify which member is being assigned',
    `um_case_id` BIGINT COMMENT 'Identifier of the specific care case or enrollment to which the coordinator is assigned.',
    `assignment_date` DATE COMMENT 'Date on which the coordinator assignment became effective.',
    `assignment_priority` STRING COMMENT 'Priority level indicating urgency of the assignment.. Valid values are `high|medium|low`',
    `assignment_reason` STRING COMMENT 'Business reason for creating the assignment (e.g., new diagnosis, care gap, member request).',
    `assignment_source` STRING COMMENT 'Origin of the assignment record (e.g., entered manually by staff, generated by system rules).. Valid values are `manual|system|automated`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|completed|terminated|pending`',
    `assignment_type` STRING COMMENT 'Role of the coordinator in this assignment.. Valid values are `primary|backup|specialist|consultant`',
    `caseload_weight` DECIMAL(18,2) COMMENT 'Relative workload weight assigned to the coordinator for this case (e.g., 1.00 = standard, >1.00 = higher complexity).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `effective_from` DATE COMMENT 'Start date of the assignments validity period.',
    `effective_until` DATE COMMENT 'End date of the assignments validity period; null if open-ended.',
    `notes` STRING COMMENT 'Free-text field for additional comments or contextual information about the assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    CONSTRAINT pk_coordinator_assignment PRIMARY KEY(`coordinator_assignment_id`)
) COMMENT 'Represents the operational assignment of a member identity to a care coordinator. Captures when the assignment started, its type (primary, backup, specialist), current status, reason for the assignment, and the weighted caseload factor.. Existence Justification: Members can be assigned to multiple care coordinators (primary, backup, specialist) and each care coordinator manages many members. The assignment is an operational entity that is created, updated, and deleted by care management staff and carries its own attributes such as assignment date, type, status, reason, and caseload weight.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` (
    `program_obligation_mapping_id` BIGINT COMMENT 'Primary key for the ProgramObligationMapping association',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation',
    `program_id` BIGINT COMMENT 'Foreign key linking to the care program',
    `compliance_status` STRING COMMENT 'Current compliance state of the program for this obligation',
    `effective_date` DATE COMMENT 'Date when the regulatory obligation becomes effective for the program',
    CONSTRAINT pk_program_obligation_mapping PRIMARY KEY(`program_obligation_mapping_id`)
) COMMENT 'This association product represents the mapping between care programs and regulatory obligations. It captures the effective date of the obligation for the program and the current compliance status, enabling the business to manage and report compliance per program.. Existence Justification: A care program may be subject to multiple regulatory obligations, and a single regulatory obligation can apply to many care programs. The business actively tracks which obligations each program must meet, including effective dates and compliance status, as a distinct operational activity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` (
    `program_accreditation_id` BIGINT COMMENT 'Primary key for the ProgramAccreditation association',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to the accreditation program',
    `program_id` BIGINT COMMENT 'Foreign key linking to the care program',
    `accreditation_status` STRING COMMENT 'Current status of the accreditation (e.g., accredited, provisional, denied) for this specific care program',
    `accreditation_type` STRING COMMENT 'Specifies the type of accreditation (e.g., health plan, provider) for this program pairing',
    CONSTRAINT pk_program_accreditation PRIMARY KEY(`program_accreditation_id`)
) COMMENT 'This association captures the accreditation assignments between care programs and accreditation programs. Each record links one care_program to one accreditation_program and stores attributes that are specific to that pairing, such as the accreditation type and status.. Existence Justification: A care program can be accredited by multiple accreditation programs (e.g., NCQA, URAC) and each accreditation program can apply to many care programs. The accreditation assignment is actively managed by the health plan, with status and type tracked for each program‑accreditation pairing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` (
    `measure_obligation_mapping_id` BIGINT COMMENT 'Primary key for the measure_obligation_mapping association',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to the HEDIS measure',
    `compliance_status` STRING COMMENT 'Compliance status of the measure for the given obligation',
    `reporting_year` STRING COMMENT 'Year the measure is reported for the specific obligation',
    CONSTRAINT pk_measure_obligation_mapping PRIMARY KEY(`measure_obligation_mapping_id`)
) COMMENT 'This association captures the operational link between HEDIS measures and regulatory obligations. Each record represents one measure required to satisfy one obligation, including the reporting year and compliance status specific to that pairing.. Existence Justification: A HEDIS quality measure can satisfy multiple regulatory obligations, and a single regulatory obligation often requires several HEDIS measures. The compliance team actively maintains a mapping between measures and obligations, tracking the reporting year and compliance status for each link.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` (
    `gap_obligation_id` BIGINT COMMENT 'Primary key for the gap_obligation association',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory_obligation record',
    `gap_id` BIGINT COMMENT 'Foreign key linking to the care_gap record',
    `compliance_status` STRING COMMENT 'Status of the care gaps compliance with the regulatory obligation for the reporting period',
    `reporting_period` DATE COMMENT 'The period for which the care gap is reported to the regulatory obligation',
    CONSTRAINT pk_gap_obligation PRIMARY KEY(`gap_obligation_id`)
) COMMENT 'This association captures the linkage between a care gap and a regulatory obligation. Each record represents a specific reporting instance, storing the reporting period and compliance status that are unique to the gap‑obligation pair.. Existence Justification: A care gap can be reported under multiple regulatory obligations (e.g., HEDIS, state reporting) and each regulatory obligation can apply to many care gaps across members. The compliance team creates and maintains records linking specific gaps to the obligations they satisfy, tracking reporting periods and compliance status for each link.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'Primary key for the program_enrollment association',
    `group_id` BIGINT COMMENT 'Foreign key linking to the employer group',
    `program_id` BIGINT COMMENT 'Foreign key linking to the care program',
    `effective_end_date` DATE COMMENT 'Date the program enrollment ends for the employer group',
    `effective_start_date` DATE COMMENT 'Date the program enrollment becomes effective for the employer group',
    `enrollment_cap` BIGINT COMMENT 'Maximum number of members the employer group may enroll in the program',
    `participation_rate` DECIMAL(18,2) COMMENT 'Target participation rate (percentage) for the employer group in the program',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'Represents the contractual enrollment of an employer group in a specific care program. Each record captures the period the program is offered, enrollment capacity, and participation rate for that employer‑program pair.. Existence Justification: Employer groups can sponsor multiple care programs and each care program can be offered to many employer groups. The insurer manages a contract for each employer‑program pairing that includes effective dates, enrollment caps, and participation rates. This relationship is actively created, updated, and deleted by business users as part of contract administration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` (
    `questionnaire_id` BIGINT COMMENT 'Primary key for questionnaire',
    `cahps_survey_id` BIGINT COMMENT 'Identifier of the survey that the questionnaire belongs to.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_questionnaire_id` BIGINT COMMENT 'Self-referencing FK on questionnaire (parent_questionnaire_id)',
    `question_set_id` BIGINT COMMENT 'Identifier of the question set that groups related questions.',
    `questionnaire_author_employee_id` BIGINT COMMENT 'Identifier of the user who owns or manages the questionnaire.',
    `approval_by` STRING COMMENT 'Name of the individual who approved the questionnaire.',
    `approval_comments` STRING COMMENT 'Comments or notes provided during the approval process.',
    `approval_date` DATE COMMENT 'Date when the questionnaire was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the questionnaire.',
    `questionnaire_code` STRING COMMENT 'Standardized code identifying the questionnaire type and version.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the questionnaire record was first created.',
    `questionnaire_description` STRING COMMENT 'Detailed description of the questionnaire’s purpose and content.',
    `effective_date` DATE COMMENT 'Date when the questionnaire becomes active and usable.',
    `expiration_date` DATE COMMENT 'Date when the questionnaire is no longer valid or is retired.',
    `is_active` BOOLEAN COMMENT 'Flag indicating if the questionnaire is currently active.',
    `is_assessment` BOOLEAN COMMENT 'Flag indicating if the questionnaire is an assessment type.',
    `is_current` BOOLEAN COMMENT 'Flag indicating if the questionnaire is the most recent version.',
    `is_customizable` BOOLEAN COMMENT 'Flag indicating if the questionnaire can be customized by users.',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this questionnaire is the default for its type.',
    `is_form` BOOLEAN COMMENT 'Flag indicating if the questionnaire is a form type.',
    `is_legacy` BOOLEAN COMMENT 'Flag indicating if the questionnaire is from a legacy system.',
    `is_obsolete` BOOLEAN COMMENT 'Flag indicating if the questionnaire is obsolete and should not be used.',
    `is_predefined` BOOLEAN COMMENT 'Flag indicating if the questionnaire was predefined by the system.',
    `is_public` BOOLEAN COMMENT 'Flag indicating if the questionnaire is publicly available.',
    `is_questionnaire` BOOLEAN COMMENT 'Flag indicating if the questionnaire is a general questionnaire type.',
    `is_retired` BOOLEAN COMMENT 'Flag indicating if the questionnaire has been retired.',
    `is_survey` BOOLEAN COMMENT 'Flag indicating if the questionnaire is a survey type.',
    `is_template` BOOLEAN COMMENT 'Flag indicating if the questionnaire is a reusable template.',
    `language` STRING COMMENT 'Primary language code of the questionnaire content.',
    `locale` STRING COMMENT 'Locale code indicating regional formatting for the questionnaire.',
    `questionnaire_name` STRING COMMENT 'Human‑readable name of the questionnaire.',
    `question_count` STRING COMMENT 'Total number of questions contained in the questionnaire.',
    `source_record_reference` STRING COMMENT 'Identifier of the source system record that maps to this questionnaire.',
    `source_record_timestamp` TIMESTAMP COMMENT 'Timestamp of the source system record creation or update.',
    `source_system_code` STRING COMMENT 'Identifier of the source system instance or module.',
    `questionnaire_status` STRING COMMENT 'Current lifecycle state of the questionnaire.',
    `questionnaire_type` STRING COMMENT 'Category of the questionnaire (e.g., Health Risk Assessment, Chronic Condition Registry).',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the questionnaire record.',
    `version` STRING COMMENT 'Semantic version of the questionnaire (e.g., 1.0, 2.1).',
    `respondent_employee_id` BIGINT COMMENT '',
    CONSTRAINT pk_questionnaire PRIMARY KEY(`questionnaire_id`)
) COMMENT 'Master reference table for questionnaire. Referenced by questionnaire_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`care`.`question_set` (
    `question_set_id` BIGINT COMMENT 'Primary key for question_set',
    `program_id` BIGINT COMMENT 'Identifier of the care management program that primarily owns or utilizes this question set (e.g., disease management, case management, wellness program).',
    `parent_question_set_id` BIGINT COMMENT 'Self-referencing FK on question_set (parent_question_set_id)',
    `question_superseded_by_set_id` BIGINT COMMENT 'Identifier of the newer question set that replaces this one upon retirement, enabling migration tracking and historical continuity.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - question sets require tracking of creator/owner',
    `superseded_by_set_id` BIGINT COMMENT '',
    `administration_mode` STRING COMMENT 'Primary mode by which the question set is administered to members, such as telephonic outreach, in-person visit, digital/online portal, mail, or a combination of methods.',
    `approval_date` DATE COMMENT 'Date when the current version of the question set was formally approved for use in care management programs by the clinical governance committee.',
    `branching_logic_flag` BOOLEAN COMMENT 'Indicates whether the question set uses conditional branching logic where subsequent questions depend on prior answers, affecting the actual number of questions presented.',
    `question_set_category` STRING COMMENT 'Clinical or programmatic category that groups the question set by subject area, such as behavioral health, chronic condition management, wellness, functional status, social determinants of health (SDOH), or member satisfaction.',
    `clinical_domain` STRING COMMENT 'Specific clinical domain or condition area addressed by the question set, such as diabetes management, cardiovascular risk, mental health, substance use, or fall risk.',
    `question_set_code` STRING COMMENT 'Unique business code or mnemonic used to reference the question set in operational systems and reporting (e.g., HRA-2024, PHQ9, CAHPS-ADULT).',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit member consent must be obtained before administering this question set, based on regulatory or organizational policy requirements.',
    `question_set_description` STRING COMMENT 'Detailed narrative description of the question sets purpose, target population, and intended use within care management or population health programs.',
    `effective_end_date` DATE COMMENT 'Date after which the question set is no longer valid for new administrations. Null indicates the set is open-ended and currently active.',
    `effective_start_date` DATE COMMENT 'Date from which the question set becomes valid and available for administration to members in care programs.',
    `estimated_completion_minutes` STRING COMMENT 'Estimated time in minutes required for a member to complete the full question set, used for scheduling and member communication purposes.',
    `external_reference_code` STRING COMMENT 'External identifier or catalog number from the source system or industry standard library used to cross-reference this question set with external systems.',
    `frequency_requirement` STRING COMMENT 'Required or recommended frequency at which this question set should be administered to eligible members for ongoing monitoring and compliance.',
    `hcc_raf_relevance_flag` BOOLEAN COMMENT 'Indicates whether responses to this question set may contribute to HCC coding or RAF score adjustments for risk-adjusted payment models.',
    `hedis_measure_alignment` STRING COMMENT 'Specific HEDIS quality measures that this question set supports or aligns with for performance measurement and reporting purposes.',
    `hipaa_sensitivity_level` STRING COMMENT 'Classification of the sensitivity of information collected by this question set under HIPAA regulations, particularly for behavioral health, substance use, or HIV-related content.',
    `instrument_source` STRING COMMENT 'Originating organization or publication source of the validated instrument (e.g., Pfizer - PHQ-9, SAMHSA, CMS), or Internal for proprietary question sets.',
    `is_required_for_enrollment` BOOLEAN COMMENT 'Indicates whether completion of this question set is mandatory for member enrollment or continued participation in a specific care management program.',
    `is_validated_instrument` BOOLEAN COMMENT 'Indicates whether the question set is a clinically validated and peer-reviewed assessment instrument (e.g., PHQ-9, GAD-7, AUDIT-C) versus an internally developed questionnaire.',
    `language_code` STRING COMMENT 'Primary language in which the question set is authored, using ISO 639-1 language codes with optional country qualifier (e.g., en, es, zh-CN).',
    `last_review_date` DATE COMMENT 'Date when the question set was last reviewed for clinical accuracy, regulatory compliance, and continued relevance to care programs.',
    `maximum_score` DECIMAL(18,2) COMMENT 'Highest possible aggregate score achievable on this question set, establishing the upper bound for scoring interpretation and risk stratification.',
    `minimum_score` DECIMAL(18,2) COMMENT 'Lowest possible aggregate score achievable on this question set, establishing the baseline for scoring interpretation.',
    `question_set_name` STRING COMMENT 'Human-readable name or title of the question set, used to identify the assessment instrument in care management workflows (e.g., Annual HRA 2024, PHQ-9 Depression Screening).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the question set to ensure ongoing alignment with clinical guidelines and regulatory requirements.',
    `owner_department` STRING COMMENT 'Business department or clinical team responsible for maintaining, reviewing, and approving updates to this question set.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this question set record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this question set record was last modified in the data platform.',
    `regulatory_program` STRING COMMENT 'Regulatory or quality program that mandates or recommends use of this question set, such as HEDIS, CMS Star Ratings, CAHPS, or state Medicaid requirements.',
    `retirement_date` DATE COMMENT 'Date when the question set was retired from active use, after which no new administrations should be initiated.',
    `risk_stratification_flag` BOOLEAN COMMENT 'Indicates whether the question set results are used for population health risk stratification to identify high-risk members for targeted interventions.',
    `scoring_methodology` STRING COMMENT 'Description of the scoring algorithm or methodology used to calculate results from member responses, including any validated clinical scoring scales (e.g., Likert, weighted sum, threshold-based).',
    `set_type` STRING COMMENT 'Classification of the question set by its functional purpose within care management programs, such as Health Risk Assessment (HRA), clinical screening, member survey, functional assessment, or intake questionnaire.',
    `source_system_code` STRING COMMENT 'Code identifying the operational source system where this question set is maintained (e.g., Casenet TruCare, Altruista, custom care management platform).',
    `question_set_status` STRING COMMENT 'Current lifecycle status of the question set indicating whether it is available for use in care management workflows.',
    `target_population` STRING COMMENT 'Description of the intended member population for this question set, such as Medicare beneficiaries, high-risk chronic condition members, pediatric members, or dual-eligible populations.',
    `total_question_count` STRING COMMENT 'Total number of questions contained within this question set, used for administration planning and completion tracking.',
    `version_number` STRING COMMENT 'Version identifier for the question set, enabling tracking of revisions over time as clinical guidelines or regulatory requirements change.',
    CONSTRAINT pk_question_set PRIMARY KEY(`question_set_id`)
) COMMENT 'Master reference table for question_set. Referenced by question_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`questionnaire`(`questionnaire_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ADD CONSTRAINT `fk_care_star_rating_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`team`(`team_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ADD CONSTRAINT `fk_care_program_obligation_mapping_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ADD CONSTRAINT `fk_care_program_accreditation_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ADD CONSTRAINT `fk_care_measure_obligation_mapping_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ADD CONSTRAINT `fk_care_gap_obligation_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`gap`(`gap_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ADD CONSTRAINT `fk_care_program_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_cahps_survey_id` FOREIGN KEY (`cahps_survey_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_parent_questionnaire_id` FOREIGN KEY (`parent_questionnaire_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`questionnaire`(`questionnaire_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_question_set_id` FOREIGN KEY (`question_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_parent_question_set_id` FOREIGN KEY (`parent_question_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_question_superseded_by_set_id` FOREIGN KEY (`question_superseded_by_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ADD CONSTRAINT `fk_care_question_set_superseded_by_set_id` FOREIGN KEY (`superseded_by_set_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`question_set`(`question_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`care` SET TAGS ('dbx_domain' = 'care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|denied');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Care Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `clinical_protocol` SET TAGS ('dbx_business_glossary_term' = 'Clinical Protocol');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Care Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_current` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'Included HCC Codes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `is_evidence_based` SET TAGS ('dbx_business_glossary_term' = 'Evidence‑Based Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'individual|group|medicare|medicaid|exchange|government');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_actual` SET TAGS ('dbx_business_glossary_term' = 'Outcome Actual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `outcome_target` SET TAGS ('dbx_business_glossary_term' = 'Outcome Target');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|monthly|semiannual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Care Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|maternity|behavioral_health|wellness|chronic_care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Manager ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Acuity Level (ACUITY_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLLMENT_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLLMENT_SOURCE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'outreach|referral|self_referral|claims_triggered|hra_triggered');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLLMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|disenrolled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLLMENT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'disease_management|case_management|population_health|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier (PROGRAM_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `barriers_to_care` SET TAGS ('dbx_business_glossary_term' = 'Barriers to Care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Name (PLAN_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Number (PLAN_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|sdoh|social|pharmacologic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `care_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|abandoned|draft');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Care Plan Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Measurement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'clinical|behavioral|social_determinant|pharmacologic|nutrition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_business_glossary_term' = 'Goal Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `goal_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'lab|vital|self_report|clinical_assessment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `plan_goal_status` SET TAGS ('dbx_value_regex' = 'active|achieved|abandoned|on_hold|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'mg/dL|mmol/L|%|mmHg|kg|steps');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Identifier (CGID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Claim Identifier (RCID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Resolution Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date (ARD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category (CCAT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Close Date (GCD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_business_glossary_term' = 'Gap Closure Method (GCM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_value_regex' = 'claim|supplemental|attestation|provider_update|none');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Description (CGD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status (DOCS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'complete|pending|missing');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `hedis_measure_code` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Code (HEDIS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (CRIT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value (MTV)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Open Date (GOD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIO)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Status (CGS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|resolved');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date (TRD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Type (CGT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'preventive|chronic|medication|screening|followup|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (CCID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier (SID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_business_glossary_term' = 'Assigned Line of Business (ALOB)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `assigned_lob` SET TAGS ('dbx_value_regex' = 'individual|group|employer|government');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_capacity` SET TAGS ('dbx_business_glossary_term' = 'Caseload Capacity (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight (CW)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `certification_codes` SET TAGS ('dbx_business_glossary_term' = 'Certification Codes (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `current_caseload_count` SET TAGS ('dbx_business_glossary_term' = 'Current Caseload Count (CCC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Email Address (CCEA)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (ES)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator First Name (CCFN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Full Name (CCFN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Last Name (CCLN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date (LTD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Notes (CN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit (OU)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Phone Number (CCPN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{3})?[ -]?[0-9]{3}[ -]?[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Role Type (CRT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'care_coordinator|case_manager|disease_management_nurse|health_coach');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area (SA)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `specialty_area` SET TAGS ('dbx_value_regex' = 'diabetes|cardiology|oncology|behavioral_health|pediatrics|geriatrics');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `coordinator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ALTER COLUMN `training_certifications` SET TAGS ('dbx_business_glossary_term' = 'Training Certifications (TC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `member_outreach_id` SET TAGS ('dbx_business_glossary_term' = 'Member Outreach ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Outreach Agent ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outreach Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Outreach Channel');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|mail|sms|portal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `compliance_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Outreach Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outreach Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'reached|voicemail|refused|enrolled|no_answer|partial');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outcome Recorded Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Outreach Duration (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_notes` SET TAGS ('dbx_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outreach Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Outreach Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'program_enrollment|care_gap_closure|hra_completion|medication_adherence|wellness_education|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `member_outreach_status` SET TAGS ('dbx_business_glossary_term' = 'Outreach Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `member_outreach_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `hra_id` SET TAGS ('dbx_business_glossary_term' = 'Health Risk Assessment ID (HRA_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `answered_questions` SET TAGS ('dbx_business_glossary_term' = 'Answered Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type (HRA or SDOH Screening)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'HRA|SDOH');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `community_resource_referrals` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Referrals');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('dbx_business_glossary_term' = 'Completion Channel');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `completion_channel` SET TAGS ('dbx_value_regex' = 'portal|phone|mail|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_cms_required` SET TAGS ('dbx_business_glossary_term' = 'CMS Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `compliance_ncqa_required` SET TAGS ('dbx_business_glossary_term' = 'NCQA Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Health Risks');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `identified_health_risks` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `questionnaire_version` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `recommended_programs` SET TAGS ('dbx_business_glossary_term' = 'Recommended Programs');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Percentile');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_score_percentile` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (Low, Moderate, High, Very High)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'plan_specific|ahc_hrs|prapare|hunger_vital|custom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_business_glossary_term' = 'Education Barrier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_education` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_business_glossary_term' = 'Financial Strain Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_financial_strain` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_business_glossary_term' = 'Food Insecurity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_business_glossary_term' = 'Housing Instability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_housing_instability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_business_glossary_term' = 'Social Isolation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_social_isolation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_business_glossary_term' = 'Transportation Barrier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `sdoh_transportation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ALTER COLUMN `total_questions` SET TAGS ('dbx_business_glossary_term' = 'Total Questions');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` SET TAGS ('dbx_subdomain' = 'population_risk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_category` SET TAGS ('dbx_value_regex' = 'HCC|HEDIS|Behavioral|Other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code (ICD-10)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9][0-9A-Z]{0,3}$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `hcc_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `identification_method` SET TAGS ('dbx_value_regex' = 'claims|ehr|provider_attestation|hra');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `is_chronic` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `population_segment` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `raf_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Condition Severity');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_denominator_logic` SET TAGS ('dbx_business_glossary_term' = 'Denominator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_domain` SET TAGS ('dbx_value_regex' = 'effectiveness_of_care|access_availability|utilization');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_exclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_national_benchmark` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_numerator_logic` SET TAGS ('dbx_business_glossary_term' = 'Numerator Logic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_hcc` SET TAGS ('dbx_business_glossary_term' = 'Related HCC Codes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_related_raf` SET TAGS ('dbx_business_glossary_term' = 'Related RAF Variables');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measure Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Measure Scoring Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_scoring_method` SET TAGS ('dbx_value_regex' = 'rate|percentage|binary');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_star_rating_impact` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_business_glossary_term' = 'State Benchmark');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_state_benchmark` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_target_value` SET TAGS ('dbx_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measure_url` SET TAGS ('dbx_business_glossary_term' = 'Measure URL');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Result Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|excluded');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'claim|lab|supplemental|medical_record');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `denominator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Denominator Criteria Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'preventive|chronic|behavioral|screening');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_score` SET TAGS ('dbx_business_glossary_term' = 'Measure Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'process|outcome|structure');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `numerator_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Numerator Criteria Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Determination Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `source_record_type` SET TAGS ('dbx_business_glossary_term' = 'Source Record Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ALTER COLUMN `source_record_type` SET TAGS ('dbx_value_regex' = 'claim|lab|medical_record');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `cahps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'CAHPS Survey ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `administration_method` SET TAGS ('dbx_business_glossary_term' = 'Administration Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `administration_method` SET TAGS ('dbx_value_regex' = 'mail|phone|mixed|electronic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `composite_score_flag` SET TAGS ('dbx_business_glossary_term' = 'Composite Score Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `customer_service_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `doctor_communication_score` SET TAGS ('dbx_business_glossary_term' = 'Doctor Communication Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `external_survey_code` SET TAGS ('dbx_business_glossary_term' = 'External Survey Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_care_quickly_score` SET TAGS ('dbx_business_glossary_term' = 'Getting Care Quickly Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_care_quickly_score` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_needed_care_score` SET TAGS ('dbx_business_glossary_term' = 'Getting Needed Care Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `getting_needed_care_score` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `is_test_survey` SET TAGS ('dbx_business_glossary_term' = 'Test Survey Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_business_glossary_term' = 'Member Age');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_age` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_value_regex' = 'male|female|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_business_glossary_term' = 'Member ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `member_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `overall_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `response_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `response_rate` SET TAGS ('dbx_business_glossary_term' = 'Response Rate (Percent)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `sampling_frame` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frame Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `star_rating_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `star_rating_impact_score` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = 'english|spanish|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_mode` SET TAGS ('dbx_business_glossary_term' = 'Survey Mode');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_mode` SET TAGS ('dbx_value_regex' = 'self_administered|interviewer_administered');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (Health Plan CAHPS, Medicare CAHPS, PCMH CAHPS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'health_plan|medicare|pcmh');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `survey_year` SET TAGS ('dbx_business_glossary_term' = 'Survey Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` SET TAGS ('dbx_subdomain' = 'population_risk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Population Segment ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `average_pmpm_cost` SET TAGS ('dbx_business_glossary_term' = 'Average PMPM Cost');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `inclusion_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Segment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `last_run_user` SET TAGS ('dbx_business_glossary_term' = 'Last Run User');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `recommended_care_program` SET TAGS ('dbx_business_glossary_term' = 'Recommended Care Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|rising|high|catastrophic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'predictive_risk|hcc_based|claims_based|custom');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `population_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` SET TAGS ('dbx_subdomain' = 'population_risk');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'automated_model|manual_override|clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `claims_count_last_year` SET TAGS ('dbx_business_glossary_term' = 'Claims Count Last Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_business_glossary_term' = 'Demographic Group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `demographic_group` SET TAGS ('dbx_value_regex' = 'adult|senior|child|young_adult|teen');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'HCC Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Stratification Model Type (Predictive, HCC‑Based, Claims‑Based)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'predictive|hcc_based|claims_based');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_business_glossary_term' = 'PMPM Cost Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `pmpm_cost_band` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `recommended_care_program` SET TAGS ('dbx_business_glossary_term' = 'Recommended Care Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_factor_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'model|clinical_review|manual');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Population Segment Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `member_risk_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Band');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_band` SET TAGS ('dbx_value_regex' = 'low|rising|high|catastrophic');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` SET TAGS ('dbx_subdomain' = 'clinical_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_stay_id` SET TAGS ('dbx_business_glossary_term' = 'Skilled Nursing Facility Stay Identifier (SNF Stay ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier (Care Plan ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier (Care Coordinator ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Authorization Identifier (Authorization ID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Diagnosis Code (ICD‑10 Diagnosis Code at Admission)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Admission Diagnosis Description (Full Description of Admission Diagnosis)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `admission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Admission Timestamp (Date and Time of SNF Admission)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Flag (Indicator of Unaddressed Care Gap)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_gap_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `care_gap_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `concurrent_review_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Schedule Date (Planned Date for Concurrent Review)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217 Currency Code)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination (Location Patient Discharged To)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_planning_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Planning Status (Status of Discharge Planning Process)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_planning_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Timestamp (Date and Time of SNF Discharge)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group Code (DRG Code)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `drg_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `drg_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Score (HCC Score)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare` SET TAGS ('dbx_business_glossary_term' = 'Medicare Eligibility Flag (Eligibility for Medicare)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare_advantage` SET TAGS ('dbx_business_glossary_term' = 'Medicare Advantage Eligibility Flag (Eligibility for Medicare Advantage)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare_advantage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `is_eligible_for_medicare_advantage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (Total Days of SNF Stay)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (Net Charge After Adjustments)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `net_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes (Free‑Text Clinical Notes for the Stay)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('dbx_business_glossary_term' = 'Patient Condition at Admission (Clinical Condition Description)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `patient_condition_at_admission` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_reason` SET TAGS ('dbx_business_glossary_term' = 'Readmission Reason (Reason for Readmission)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Flag (Indicator of High Readmission Risk)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Within 30 Days Flag (Indicator of Readmission Within 30 Days)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (Timestamp When Record Was Created)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (Timestamp When Record Was Last Updated)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (Factor Used for Risk Adjustment Calculations)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('dbx_business_glossary_term' = 'Skilled Nursing Facility National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_facility_npi` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_type` SET TAGS ('dbx_business_glossary_term' = 'SNF Type (Classification of SNF Facility Type)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_type` SET TAGS ('dbx_value_regex' = 'skilled_nursing|rehab|long_term_care');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_stay_status` SET TAGS ('dbx_business_glossary_term' = 'SNF Stay Status (Current Lifecycle Status of the Stay)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `snf_stay_status` SET TAGS ('dbx_value_regex' = 'admitted|active|discharged|cancelled|transferred');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `stay_number` SET TAGS ('dbx_business_glossary_term' = 'Skilled Nursing Facility Stay Number (SNF Stay Number)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount (Adjustments Applied to Gross Charge)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount (Gross Charge for SNF Stay)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `transition_of_care_plan` SET TAGS ('dbx_business_glossary_term' = 'Transition of Care Plan (Narrative Plan for Post‑Discharge Care)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `transition_of_care_plan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ALTER COLUMN `transition_of_care_plan` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` SET TAGS ('dbx_subdomain' = 'clinical_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_coordination_id` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment Coordination ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordination_reason` SET TAGS ('dbx_business_glossary_term' = 'DME Coordination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordination_status` SET TAGS ('dbx_business_glossary_term' = 'DME Coordination Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `coordination_status` SET TAGS ('dbx_value_regex' = 'pending|ordered|delivered|in_use|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'DME Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_model` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment Model');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment Serial Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_type` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `dme_type` SET TAGS ('dbx_value_regex' = 'wheelchair|cpap|oxygen|infusion_pump|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'DME Follow‑Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'DME Follow‑Up Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'DME Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('dbx_business_glossary_term' = 'DME Supplier National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `supplier_npi` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_id` SET TAGS ('dbx_business_glossary_term' = 'Care Barrier Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Care Manager Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `care_manager_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Care Manager Assigned Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_description` SET TAGS ('dbx_business_glossary_term' = 'Barrier Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `documentation_source` SET TAGS ('dbx_business_glossary_term' = 'Documentation Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Member ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `geographic_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `hcc_impact` SET TAGS ('dbx_business_glossary_term' = 'HCC Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `identification_source` SET TAGS ('dbx_business_glossary_term' = 'Barrier Identification Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `identification_source` SET TAGS ('dbx_value_regex' = 'hra|care_coordinator|member_self_report|provider|claims_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `identification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Barrier Identification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Barrier Impact Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `intervention_applied` SET TAGS ('dbx_business_glossary_term' = 'Intervention Applied');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'referral|transport_service|financial_assistance|education|language_service|telehealth');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Barrier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Barrier Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Barrier Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Barrier Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'resolved|mitigated|unresolved|partial');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Barrier Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_status` SET TAGS ('dbx_business_glossary_term' = 'Barrier Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_type` SET TAGS ('dbx_business_glossary_term' = 'Barrier Type (BT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `barrier_type` SET TAGS ('dbx_value_regex' = 'transportation|cost|language|health_literacy|social_determinant|medication_adherence');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` SET TAGS ('dbx_subdomain' = 'clinical_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_id` SET TAGS ('dbx_business_glossary_term' = 'Care Transition ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `care_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `compliance_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Compliance Consent Obtained');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `concurrent_review_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Schedule Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `discharge_planning_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Planning Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `discharge_planning_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_coordination_status` SET TAGS ('dbx_business_glossary_term' = 'DME Coordination Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_coordination_status` SET TAGS ('dbx_value_regex' = 'pending|ordered|delivered|installed|completed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'DME Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_equipment_type` SET TAGS ('dbx_value_regex' = 'wheelchair|oxygen|hospital_bed|monitor|other');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_order_date` SET TAGS ('dbx_business_glossary_term' = 'DME Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('dbx_business_glossary_term' = 'DME Supplier NPI');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `dme_ordering_supplier_npi` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Transition Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `follow_up_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Schedule Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `from_setting` SET TAGS ('dbx_business_glossary_term' = 'From Care Setting (FROM_SETTING)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `from_setting` SET TAGS ('dbx_value_regex' = 'hospital|snf|home|ed|outpatient');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `from_setting` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `hcc_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Risk Factor (HCC_RF)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `is_critical_transition` SET TAGS ('dbx_business_glossary_term' = 'Critical Transition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transition Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Transition Number (TRANS_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Transition Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|readmitted|complication|deceased');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `readmission_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score (RRS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_date` SET TAGS ('dbx_business_glossary_term' = 'SNF Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'SNF Admission Diagnosis (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_admission_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'SNF Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('dbx_business_glossary_term' = 'Skilled Nursing Facility NPI');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `snf_facility_npi` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_status` SET TAGS ('dbx_business_glossary_term' = 'Transition Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `to_setting` SET TAGS ('dbx_business_glossary_term' = 'To Care Setting (TO_SETTING)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `to_setting` SET TAGS ('dbx_value_regex' = 'hospital|snf|home|ed|outpatient');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `to_setting` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `toc_plan_completed` SET TAGS ('dbx_business_glossary_term' = 'Transition of Care Plan Completed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'Transition Type (TRANS_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'discharge|transfer|admission|return');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_rating_result_id` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Result ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (H/S-number)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_1_star` SET TAGS ('dbx_business_glossary_term' = '1‑Star Cutpoint');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_2_star` SET TAGS ('dbx_business_glossary_term' = '2‑Star Cutpoint');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_3_star` SET TAGS ('dbx_business_glossary_term' = '3‑Star Cutpoint');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_4_star` SET TAGS ('dbx_business_glossary_term' = '4‑Star Cutpoint');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `cutpoint_5_star` SET TAGS ('dbx_business_glossary_term' = '5‑Star Cutpoint');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'cms|internal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `domain_star_score` SET TAGS ('dbx_business_glossary_term' = 'Domain Star Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `improvement_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Improvement Measure Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measure_weight` SET TAGS ('dbx_business_glossary_term' = 'Measure Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `overall_star_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `overall_star_rating` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'medicare_advantage|part_d|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `quality_bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Bonus Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('dbx_business_glossary_term' = 'Rating Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'final|provisional|draft|retracted');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `rating_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_domain` SET TAGS ('dbx_business_glossary_term' = 'Star Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_domain` SET TAGS ('dbx_value_regex' = 'part_c|part_d|overall');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `star_score` SET TAGS ('dbx_business_glossary_term' = 'Star Score (Measure)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'up|down|stable');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_star_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Star Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `trend_year` SET TAGS ('dbx_business_glossary_term' = 'Trend Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'SDOH Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `confidentiality_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_needed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `referral_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Made Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `referral_resource` SET TAGS ('dbx_business_glossary_term' = 'Referral Resource');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool Used');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_value_regex' = 'food_insecurity|housing_instability|transportation|social_isolation|financial_strain|education');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `sdoh_assessment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Identifier (CTID)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Care Coordinator Identifier (LCCI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Team Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Care Program Identifier (ACPI)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Created Record (UCR)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Last Updated Record (ULUR)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Behavioral Health Providers (NBHP)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `behavioral_health_provider_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Code (CTC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel for Team (PCCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|sms');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Community Health Workers (NCHW)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `community_health_worker_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Date Privacy Consent Obtained (DPCO)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Email Address (TCEA)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method for Team (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Phone Number (TCPN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status of Team Record (DQST)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Effective End Date (CTEED)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Effective Start Date (CTESD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_included` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating Inclusion of HCCs (FIHCC)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `hcc_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Version (HCCV)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `is_multidisciplinary` SET TAGS ('dbx_business_glossary_term' = 'Indicator if Team is Multidisciplinary (IMD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `is_primary_care_team` SET TAGS ('dbx_business_glossary_term' = 'Indicator if Team is Primary Care Team (IPCT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Last Data Quality Review (DLR)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `lead_coordinator_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Coordinator Assignment End Date (LCAED)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `lead_coordinator_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Coordinator Assignment Start Date (LCASD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Members Assigned to Team (NMAT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Name (CTN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes Regarding Team (ANRT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `pharmacist_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Pharmacists (NP)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag for Team Data (PCFTD)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Providers in Team (NPT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor for Team (RAFT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `social_worker_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Social Workers (NSW)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Specialist Providers (NSP)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Lifecycle Status (CTLS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Current Team Status (RTS)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Type (CTT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_value_regex' = 'clinical|non_clinical|behavioral|pharmacy|social');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RLUT)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Team Record Version Number (TVN)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` SET TAGS ('dbx_association_edges' = 'member.identity,care.care_coordinator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'coordinator_assignment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to coordinator');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Care Case Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'manual|system|automated');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type (Primary/Backup/Specialist/Consultant)');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|backup|specialist|consultant');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `caseload_weight` SET TAGS ('dbx_business_glossary_term' = 'Caseload Weight');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` SET TAGS ('dbx_association_edges' = 'care.care_program,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ALTER COLUMN `program_obligation_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Programobligationmapping - Program Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Programobligationmapping - Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Programobligationmapping - Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` SET TAGS ('dbx_association_edges' = 'care.care_program,compliance.accreditation_program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ALTER COLUMN `program_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Programaccreditation - Program Accreditation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Programaccreditation - Accreditation Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Programaccreditation - Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` SET TAGS ('dbx_association_edges' = 'care.hedis_measure,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `measure_obligation_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Obligation Mapping - Measure Obligation Mapping Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Obligation Mapping - Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Obligation Mapping - Hedis Measure Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ALTER COLUMN `reporting_year` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` SET TAGS ('dbx_association_edges' = 'care.care_gap,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `gap_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Obligation - Gap Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Obligation - Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `gap_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Obligation - Care Gap Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` SET TAGS ('dbx_association_edges' = 'care.care_program,employer.employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Program Enrollment Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ALTER COLUMN `participation_rate` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `cahps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `parent_questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Questionnaire Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `parent_questionnaire_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `question_set_id` SET TAGS ('dbx_business_glossary_term' = 'Question Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_author_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_author_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_author_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_by` SET TAGS ('dbx_business_glossary_term' = 'Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_code` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_description` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_assessment` SET TAGS ('dbx_business_glossary_term' = 'Is Assessment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_customizable` SET TAGS ('dbx_business_glossary_term' = 'Is Customizable');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_form` SET TAGS ('dbx_business_glossary_term' = 'Is Form');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_legacy` SET TAGS ('dbx_business_glossary_term' = 'Is Legacy');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Is Obsolete');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_predefined` SET TAGS ('dbx_business_glossary_term' = 'Is Predefined');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_questionnaire` SET TAGS ('dbx_business_glossary_term' = 'Is Questionnaire');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_retired` SET TAGS ('dbx_business_glossary_term' = 'Is Retired');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_survey` SET TAGS ('dbx_business_glossary_term' = 'Is Survey');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_record_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source Record Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `questionnaire_type` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ALTER COLUMN `respondent_employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_id` SET TAGS ('dbx_business_glossary_term' = 'Question Set Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `parent_question_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Question Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `parent_question_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_superseded_by_set_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Set Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `administration_mode` SET TAGS ('dbx_business_glossary_term' = 'Administration Mode');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `branching_logic_flag` SET TAGS ('dbx_business_glossary_term' = 'Branching Logic Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_business_glossary_term' = 'Clinical Domain');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Id');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Frequency Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hcc_raf_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Hcc Raf Relevance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hedis_measure_alignment` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Alignment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `hipaa_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Sensitivity Level');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `instrument_source` SET TAGS ('dbx_business_glossary_term' = 'Instrument Source');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `is_required_for_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Is Required For Enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `is_validated_instrument` SET TAGS ('dbx_business_glossary_term' = 'Is Validated Instrument');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `maximum_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `minimum_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Score');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `risk_stratification_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Stratification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `scoring_methodology` SET TAGS ('dbx_business_glossary_term' = 'Scoring Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `set_type` SET TAGS ('dbx_business_glossary_term' = 'Set Type');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `question_set_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `total_question_count` SET TAGS ('dbx_business_glossary_term' = 'Total Question Count');
ALTER TABLE `vibe_health_insurance_v1`.`care`.`question_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
