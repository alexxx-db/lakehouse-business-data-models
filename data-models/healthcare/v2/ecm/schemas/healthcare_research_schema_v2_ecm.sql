-- Schema for Domain: research | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`research` COMMENT 'Clinical research and medical research operations. Owns clinical trial protocols, IRB (Institutional Review Board) approvals, study enrollment, investigational drug/device tracking, informed consent, adverse event reporting, research billing compliance, research data governance, de-identified data access for population health studies, and translational research. Supports academic medical centers under FDA 21 CFR Part 11.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`irb_submission` (
    `irb_submission_id` BIGINT COMMENT 'Unique identifier for IRB submission',
    `audit_id` BIGINT COMMENT 'Associated compliance audit',
    `care_site_id` BIGINT COMMENT 'Care site where study is conducted',
    `consent_policy_id` BIGINT COMMENT 'Consent policy governing the study',
    `icd_code_id` BIGINT COMMENT 'Primary condition ICD code',
    `employee_id` BIGINT COMMENT 'Primary IRB reviewer employee',
    `protocol_amendment_id` BIGINT COMMENT 'Associated protocol amendment',
    `research_study_id` BIGINT COMMENT 'Associated research study',
    `tertiary_irb_reviewed_by_user_employee_id` BIGINT COMMENT 'Tertiary IRB reviewer employee',
    `acknowledgment_date` DATE COMMENT 'Date IRB acknowledged submission',
    `action_due_date` DATE COMMENT 'Date by which action is required',
    `action_required_description` STRING COMMENT 'Description of required action',
    `action_required_flag` BOOLEAN COMMENT 'Indicates if action is required',
    `agency_response_letter` STRING COMMENT 'Agency response letter reference',
    `approval_date` DATE COMMENT 'IRB approval date',
    `approval_expiration_date` DATE COMMENT 'IRB approval expiration date',
    `conditions_of_approval` STRING COMMENT 'Conditions of IRB approval',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `determination_outcome` STRING COMMENT 'IRB determination outcome',
    `ectd_sequence_number` STRING COMMENT 'Electronic Common Technical Document sequence number',
    `federal_agency_name` STRING COMMENT 'The federal agency name of the research irb submission record.',
    `fwa_number` STRING COMMENT 'Federalwide Assurance number',
    `ide_number` STRING COMMENT 'Investigational Device Exemption number',
    `ind_number` STRING COMMENT 'Investigational New Drug number',
    `informed_consent_version` STRING COMMENT 'The informed consent version of the research irb submission record.',
    `irb_board_name` STRING COMMENT 'The irb board name of the research irb submission record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `nct_number` STRING COMMENT 'ClinicalTrials.gov NCT number',
    `protocol_version` STRING COMMENT 'The protocol version of the research irb submission record.',
    `review_meeting_date` DATE COMMENT 'IRB review meeting date',
    `review_type` STRING COMMENT 'Type of IRB review (full board, expedited, exempt)',
    `reviewing_body_type` STRING COMMENT 'Type of reviewing body',
    `risk_level` STRING COMMENT 'Risk level determination',
    `sponsor_organization` STRING COMMENT 'Sponsor organization name',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the research irb submission record.',
    `submission_method` STRING COMMENT 'Submission method (electronic, paper)',
    `submission_notes` STRING COMMENT 'The submission notes of the research irb submission record.',
    `submission_number` STRING COMMENT 'The submission number of the research irb submission record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the research irb submission record.',
    `submission_type` STRING COMMENT 'Submission type (initial, continuing review, amendment)',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research irb submission record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vulnerable_population_flag` BOOLEAN COMMENT 'Indicates if vulnerable population is involved',
    `vulnerable_population_type` STRING COMMENT 'Type of vulnerable population',
    CONSTRAINT pk_irb_submission PRIMARY KEY(`irb_submission_id`)
) COMMENT 'IRB submission and approval tracking for research protocols';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_site` (
    `study_site_id` BIGINT COMMENT 'Unique identifier for study site',
    `accreditation_status_id` BIGINT COMMENT 'Site accreditation status',
    `audit_id` BIGINT COMMENT 'Associated audit',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research study site record.',
    `clinician_id` BIGINT COMMENT 'Principal investigator clinician',
    `cms_condition_status_id` BIGINT COMMENT 'CMS condition of participation status',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `inventory_location_id` BIGINT COMMENT 'Inventory location for study supplies',
    `research_study_id` BIGINT COMMENT 'Research study',
    `employee_id` BIGINT COMMENT 'Site coordinator employee',
    `activation_date` DATE COMMENT 'Site activation date',
    `actual_enrollment_count` STRING COMMENT 'The actual enrollment count of the research study site record.',
    `adverse_event_count` STRING COMMENT 'The adverse event count of the research study site record.',
    `closure_date` DATE COMMENT 'Site closure date',
    `corrective_action_plan_due_date` DATE COMMENT 'Timestamp capturing the corrective action plan due date associated with the research study site record.',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates if corrective action plan is required',
    `corrective_action_plan_status` STRING COMMENT 'The corrective action plan status value classifying the research study site record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cro_organization_name` STRING COMMENT 'The cro organization name of the research study site record.',
    `data_query_count` STRING COMMENT 'The data query count of the research study site record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study site record.',
    `enrollment_rate_per_month` DECIMAL(18,2) COMMENT 'The enrollment rate per month of the research study site record.',
    `informed_consent_compliance_status` STRING COMMENT 'The informed consent compliance status value classifying the research study site record.',
    `investigational_product_accountability_status` STRING COMMENT 'The investigational product accountability status value classifying the research study site record.',
    `irb_approval_date` DATE COMMENT 'Timestamp capturing the irb approval date associated with the research study site record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research study site record.',
    `irb_expiration_date` DATE COMMENT 'Timestamp capturing the irb expiration date associated with the research study site record.',
    `irb_of_record_name` STRING COMMENT 'The irb of record name of the research study site record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study site record.',
    `last_monitoring_visit_date` DATE COMMENT 'Timestamp capturing the last monitoring visit date associated with the research study site record.',
    `last_monitoring_visit_type` STRING COMMENT 'The last monitoring visit type value classifying the research study site record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the research study site record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `next_monitoring_visit_scheduled_date` DATE COMMENT 'Timestamp capturing the next monitoring visit scheduled date associated with the research study site record.',
    `open_data_query_count` STRING COMMENT 'The open data query count of the research study site record.',
    `planned_enrollment_capacity` STRING COMMENT 'The planned enrollment capacity of the research study site record.',
    `protocol_deviation_count` STRING COMMENT 'The protocol deviation count of the research study site record.',
    `record_notes` STRING COMMENT 'The record notes of the research study site record.',
    `regulatory_binder_status` STRING COMMENT 'The regulatory binder status value classifying the research study site record.',
    `screen_failure_count` STRING COMMENT 'The screen failure count of the research study site record.',
    `serious_adverse_event_count` STRING COMMENT 'The serious adverse event count of the research study site record.',
    `serious_protocol_deviation_count` STRING COMMENT 'The serious protocol deviation count of the research study site record.',
    `site_name` STRING COMMENT 'The site name of the research study site record.',
    `site_notes` STRING COMMENT 'The site notes of the research study site record.',
    `site_number` STRING COMMENT 'The site number of the research study site record.',
    `site_performance_score` DECIMAL(18,2) COMMENT 'The site performance score of the research study site record.',
    `site_risk_rating` STRING COMMENT 'The site risk rating of the research study site record.',
    `site_status` STRING COMMENT 'The site status value classifying the research study site record.',
    `source_document_verification_status` STRING COMMENT 'The source document verification status value classifying the research study site record.',
    `sponsor_organization_name` STRING COMMENT 'The sponsor organization name of the research study site record.',
    `study_site_status` STRING COMMENT 'The study site status value classifying the research study site record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research study site record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_study_site PRIMARY KEY(`study_site_id`)
) COMMENT 'Research study site activation, enrollment, and performance tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` (
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research subject enrollment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research subject enrollment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the research subject enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the research subject enrollment record.',
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the research subject enrollment record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the primary research study within the research subject enrollment record.',
    `study_arm_id` BIGINT COMMENT 'Unique identifier for the study arm within the research subject enrollment record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research subject enrollment record.',
    `subject_research_study_id` BIGINT COMMENT 'Unique identifier for the subject research study within the research subject enrollment record.',
    `adverse_event_flag` BOOLEAN COMMENT 'The adverse event flag of the research subject enrollment record.',
    `completion_date` DATE COMMENT 'Timestamp capturing the completion date associated with the research subject enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research subject enrollment record.',
    `data_lock_flag` BOOLEAN COMMENT 'The data lock flag of the research subject enrollment record.',
    `data_lock_timestamp` TIMESTAMP COMMENT 'The data lock timestamp of the research subject enrollment record.',
    `data_monitoring_committee_review_flag` BOOLEAN COMMENT 'The data monitoring committee review flag of the research subject enrollment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research subject enrollment record.',
    `eligibility_confirmed_flag` BOOLEAN COMMENT 'The eligibility confirmed flag of the research subject enrollment record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the research subject enrollment record.',
    `enrollment_notes` STRING COMMENT 'The enrollment notes of the research subject enrollment record.',
    `enrollment_source` STRING COMMENT 'The enrollment source of the research subject enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the research subject enrollment record.',
    `informed_consent_date` DATE COMMENT 'Timestamp capturing the informed consent date associated with the research subject enrollment record.',
    `informed_consent_version` STRING COMMENT 'The informed consent version of the research subject enrollment record.',
    `investigational_product_dispensed_flag` BOOLEAN COMMENT 'The investigational product dispensed flag of the research subject enrollment record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research subject enrollment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research subject enrollment record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `protocol_deviation_flag` BOOLEAN COMMENT 'The protocol deviation flag of the research subject enrollment record.',
    `randomization_date` DATE COMMENT 'Timestamp capturing the randomization date associated with the research subject enrollment record.',
    `record_notes` STRING COMMENT 'The record notes of the research subject enrollment record.',
    `screening_date` DATE COMMENT 'Timestamp capturing the screening date associated with the research subject enrollment record.',
    `serious_adverse_event_flag` BOOLEAN COMMENT 'The serious adverse event flag of the research subject enrollment record.',
    `subject_enrollment_status` STRING COMMENT 'The subject enrollment status value classifying the research subject enrollment record.',
    `stratification_factors` STRING COMMENT 'The stratification factors of the research subject enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research subject enrollment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research subject enrollment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `withdrawal_date` DATE COMMENT 'Timestamp capturing the withdrawal date associated with the research subject enrollment record.',
    `withdrawal_reason` STRING COMMENT 'The withdrawal reason of the research subject enrollment record.',
    CONSTRAINT pk_subject_enrollment PRIMARY KEY(`subject_enrollment_id`)
) COMMENT 'Operational record of a research subjects enrollment into a specific study, capturing the full enrollment lifecycle. Includes subject study ID (distinct from MRN), screening date, enrollment date, randomization date, randomization arm/cohort assignment, stratification factors, enrollment status (screened, enrolled, active, completed, withdrawn, lost to follow-up), withdrawal reason, and completion date. Links to the patient domain via MRN without duplicating patient master data. Core transactional entity for study enrollment tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`informed_consent` (
    `informed_consent_id` BIGINT COMMENT 'Unique identifier for the informed consent within the research informed consent record.',
    `capacity_assessment_id` BIGINT COMMENT 'Unique identifier for the capacity assessment within the research informed consent record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research informed consent record.',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the research informed consent record.',
    `consent_template_id` BIGINT COMMENT 'Foreign key linking to research.consent_template. Business justification: Each informed_consent record is created from a specific IRB-approved consent_template (ICF). One template governs many consent instances. informed_consent currently references consent.form_template (e',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the consenting clinician within the research informed consent record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the research informed consent record.',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the research informed consent record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the informed employee within the research informed consent record.',
    `informed_last_modified_by_user_employee_id` BIGINT COMMENT 'Unique identifier for the informed last modified by user employee within the research informed consent record.',
    `note_id` BIGINT COMMENT 'Unique identifier for the note within the research informed consent record.',
    `primary_informed_employee_id` BIGINT COMMENT 'Unique identifier for the primary informed employee within the research informed consent record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research informed consent record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research informed consent record.',
    `capacity_assessment_performed` BOOLEAN COMMENT 'The capacity assessment performed of the research informed consent record.',
    `capacity_assessment_result` STRING COMMENT 'The capacity assessment result of the research informed consent record.',
    `consent_comprehension_assessed` BOOLEAN COMMENT 'The consent comprehension assessed of the research informed consent record.',
    `consent_copy_provided_date` DATE COMMENT 'Timestamp capturing the consent copy provided date associated with the research informed consent record.',
    `consent_copy_provided_flag` BOOLEAN COMMENT 'The consent copy provided flag of the research informed consent record.',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the research informed consent record.',
    `consent_discussion_duration_minutes` STRING COMMENT 'The consent discussion duration minutes of the research informed consent record.',
    `consent_document_location` STRING COMMENT 'The consent document location of the research informed consent record.',
    `consent_method` STRING COMMENT 'The consent method of the research informed consent record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the research informed consent record.',
    `consent_time` TIMESTAMP COMMENT 'Timestamp capturing the consent time associated with the research informed consent record.',
    `consent_type` STRING COMMENT 'The consent type value classifying the research informed consent record.',
    `consent_version_number` STRING COMMENT 'The consent version number of the research informed consent record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research informed consent record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research informed consent record.',
    `electronic_signature_reference` STRING COMMENT 'The electronic signature reference of the research informed consent record.',
    `hipaa_authorization_date` DATE COMMENT 'Timestamp capturing the hipaa authorization date associated with the research informed consent record.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'The hipaa authorization included of the research informed consent record.',
    `interpreter_name` STRING COMMENT 'The interpreter name of the research informed consent record.',
    `interpreter_used_flag` BOOLEAN COMMENT 'The interpreter used flag of the research informed consent record.',
    `irb_approval_date` DATE COMMENT 'Timestamp capturing the irb approval date associated with the research informed consent record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research informed consent record.',
    `irb_expiration_date` DATE COMMENT 'Timestamp capturing the irb expiration date associated with the research informed consent record.',
    `language_code` STRING COMMENT 'The language code value classifying the research informed consent record.',
    `lar_consent_indicator` BOOLEAN COMMENT 'The lar consent indicator of the research informed consent record.',
    `lar_name` STRING COMMENT 'The lar name of the research informed consent record.',
    `lar_relationship` STRING COMMENT 'The lar relationship of the research informed consent record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research informed consent record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `re_consent_date` DATE COMMENT 'Timestamp capturing the re consent date associated with the research informed consent record.',
    `record_notes` STRING COMMENT 'The record notes of the research informed consent record.',
    `informed_consent_status` STRING COMMENT 'The informed consent status value classifying the research informed consent record.',
    `subject_questions_addressed_flag` BOOLEAN COMMENT 'The subject questions addressed flag of the research informed consent record.',
    `subject_signature_date` DATE COMMENT 'Timestamp capturing the subject signature date associated with the research informed consent record.',
    `subject_signature_indicator` BOOLEAN COMMENT 'The subject signature indicator of the research informed consent record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research informed consent record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `withdrawal_date` DATE COMMENT 'Timestamp capturing the withdrawal date associated with the research informed consent record.',
    `withdrawal_reason` STRING COMMENT 'The withdrawal reason of the research informed consent record.',
    `witness_name` STRING COMMENT 'The witness name of the research informed consent record.',
    `witness_required_flag` BOOLEAN COMMENT 'The witness required flag of the research informed consent record.',
    CONSTRAINT pk_informed_consent PRIMARY KEY(`informed_consent_id`)
) COMMENT 'Records the informed consent process for each research subject and manages IRB-approved consent form templates/versions. Subject-level consent: captures consent form version, consent date, re-consent date, consent type (initial, re-consent, assent, LAR consent), consenting staff, witness, signature indicator, capacity assessment, and language. Template/version management: captures template version number, IRB approval date, expiration date, language versions, form type (full ICF, short form, assent, HIPAA authorization), required elements checklist, and template status (draft, approved, superseded). Supports FDA 21 CFR Part 50, ICH E6(R2), and ensures subjects are consented on the current IRB-approved version. SSOT for consent documentation, template version control, and consent compliance within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` (
    `protocol_amendment_id` BIGINT COMMENT 'Unique identifier for the protocol amendment within the research protocol amendment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the author employee within the research protocol amendment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research protocol amendment record.',
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change within the research protocol amendment record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research protocol amendment record.',
    `superseded_by_protocol_amendment_id` BIGINT COMMENT 'Unique identifier for the superseded by protocol amendment within the research protocol amendment record.',
    `amendment_date` DATE COMMENT 'Timestamp capturing the amendment date associated with the research protocol amendment record.',
    `amendment_description` STRING COMMENT 'The amendment description of the research protocol amendment record.',
    `amendment_document_url` STRING COMMENT 'The amendment document url of the research protocol amendment record.',
    `amendment_number` STRING COMMENT 'The amendment number of the research protocol amendment record.',
    `amendment_status` STRING COMMENT 'The amendment status value classifying the research protocol amendment record.',
    `amendment_title` STRING COMMENT 'The amendment title of the research protocol amendment record.',
    `amendment_type` STRING COMMENT 'The amendment type value classifying the research protocol amendment record.',
    `amendment_version` STRING COMMENT 'The amendment version of the research protocol amendment record.',
    `comments` STRING COMMENT 'The comments of the research protocol amendment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research protocol amendment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research protocol amendment record.',
    `fda_acknowledgment_date` DATE COMMENT 'Timestamp capturing the fda acknowledgment date associated with the research protocol amendment record.',
    `fda_submission_date` DATE COMMENT 'Timestamp capturing the fda submission date associated with the research protocol amendment record.',
    `fda_submission_reference` STRING COMMENT 'The fda submission reference of the research protocol amendment record.',
    `impact_assessment_efficacy` STRING COMMENT 'The impact assessment efficacy of the research protocol amendment record.',
    `impact_assessment_enrollment` STRING COMMENT 'The impact assessment enrollment of the research protocol amendment record.',
    `impact_assessment_operational` STRING COMMENT 'The impact assessment operational of the research protocol amendment record.',
    `impact_assessment_safety` STRING COMMENT 'The impact assessment safety of the research protocol amendment record.',
    `implementation_date` DATE COMMENT 'Timestamp capturing the implementation date associated with the research protocol amendment record.',
    `informed_consent_update_required_flag` BOOLEAN COMMENT 'The informed consent update required flag of the research protocol amendment record.',
    `irb_approval_date` DATE COMMENT 'Timestamp capturing the irb approval date associated with the research protocol amendment record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research protocol amendment record.',
    `irb_submission_date` DATE COMMENT 'Timestamp capturing the irb submission date associated with the research protocol amendment record.',
    `irb_submission_reference` STRING COMMENT 'The irb submission reference of the research protocol amendment record.',
    `last_modified_by` STRING COMMENT 'The last modified by of the research protocol amendment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research protocol amendment record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `protocol_sections_modified` STRING COMMENT 'The protocol sections modified of the research protocol amendment record.',
    `reason_for_amendment` STRING COMMENT 'The reason for amendment of the research protocol amendment record.',
    `reconsent_required_flag` BOOLEAN COMMENT 'The reconsent required flag of the research protocol amendment record.',
    `record_notes` STRING COMMENT 'The record notes of the research protocol amendment record.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'The regulatory reporting required flag of the research protocol amendment record.',
    `site_implementation_required_flag` BOOLEAN COMMENT 'The site implementation required flag of the research protocol amendment record.',
    `sponsor_approval_authority` STRING COMMENT 'The sponsor approval authority of the research protocol amendment record.',
    `sponsor_approval_date` DATE COMMENT 'Timestamp capturing the sponsor approval date associated with the research protocol amendment record.',
    `protocol_amendment_status` STRING COMMENT 'The protocol amendment status value classifying the research protocol amendment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research protocol amendment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `created_by` STRING COMMENT 'The created by of the research protocol amendment record.',
    CONSTRAINT pk_protocol_amendment PRIMARY KEY(`protocol_amendment_id`)
) COMMENT 'Tracks all amendments to an approved research protocol, including the amendment number, amendment date, description of changes, reason for amendment, impact assessment (safety, efficacy, enrollment), IRB submission reference, FDA submission reference (IND amendment), sponsor approval date, and implementation date at each site. Maintains the full version history of the study protocol to support regulatory inspections and audit readiness under FDA 21 CFR Part 11.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_visit` (
    `study_visit_id` BIGINT COMMENT 'Unique identifier for the study visit within the research study visit record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research study visit record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the research study visit record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the research study visit record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the research study visit record.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for the message log within the research study visit record.',
    `observation_id` BIGINT COMMENT 'Unique identifier for the observation within the research study visit record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the primary cpt code within the research study visit record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary employee within the research study visit record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research study visit record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the research study visit record.',
    `study_arm_id` BIGINT COMMENT 'Unique identifier for the study arm within the research study visit record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research study visit record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research study visit record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the research study visit record.',
    `actual_date` DATE COMMENT 'Timestamp capturing the actual date associated with the research study visit record.',
    `adverse_event_reported_flag` BOOLEAN COMMENT 'The adverse event reported flag of the research study visit record.',
    `assessments_completed_count` STRING COMMENT 'The assessments completed count of the research study visit record.',
    `assessments_missed_count` STRING COMMENT 'The assessments missed count of the research study visit record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the research study visit record.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'The compliance percentage of the research study visit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research study visit record.',
    `data_entry_complete_flag` BOOLEAN COMMENT 'The data entry complete flag of the research study visit record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study visit record.',
    `informed_consent_reaffirmed_flag` BOOLEAN COMMENT 'The informed consent reaffirmed flag of the research study visit record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study visit record.',
    `missed_visit_reason` STRING COMMENT 'The missed visit reason of the research study visit record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `protocol_deviation_description` STRING COMMENT 'The protocol deviation description of the research study visit record.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'The protocol deviation flag of the research study visit record.',
    `query_open_count` STRING COMMENT 'The query open count of the research study visit record.',
    `record_notes` STRING COMMENT 'The record notes of the research study visit record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the research study visit record.',
    `serious_adverse_event_flag` BOOLEAN COMMENT 'The serious adverse event flag of the research study visit record.',
    `source_data_verified_flag` BOOLEAN COMMENT 'The source data verified flag of the research study visit record.',
    `study_visit_status` STRING COMMENT 'The study visit status value classifying the research study visit record.',
    `study_drug_dispensed_flag` BOOLEAN COMMENT 'The study drug dispensed flag of the research study visit record.',
    `study_drug_returned_flag` BOOLEAN COMMENT 'The study drug returned flag of the research study visit record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research study visit record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `visit_duration_minutes` STRING COMMENT 'The visit duration minutes of the research study visit record.',
    `visit_location` STRING COMMENT 'The visit location of the research study visit record.',
    `visit_locked_flag` BOOLEAN COMMENT 'The visit locked flag of the research study visit record.',
    `visit_locked_timestamp` TIMESTAMP COMMENT 'The visit locked timestamp of the research study visit record.',
    `visit_name` STRING COMMENT 'The visit name of the research study visit record.',
    `visit_notes` STRING COMMENT 'The visit notes of the research study visit record.',
    `visit_number` STRING COMMENT 'The visit number of the research study visit record.',
    `visit_status` STRING COMMENT 'The visit status value classifying the research study visit record.',
    `visit_type` STRING COMMENT 'The visit type value classifying the research study visit record.',
    `visit_window_end_date` DATE COMMENT 'Timestamp capturing the visit window end date associated with the research study visit record.',
    `visit_window_start_date` DATE COMMENT 'Timestamp capturing the visit window start date associated with the research study visit record.',
    `visit_window_status` STRING COMMENT 'The visit window status value classifying the research study visit record.',
    CONSTRAINT pk_study_visit PRIMARY KEY(`study_visit_id`)
) COMMENT 'Represents a scheduled or unscheduled study visit for an enrolled research subject, as defined by the protocol schedule of assessments. Captures visit name, visit number, visit window (planned, early, late), actual visit date, visit type (screening, baseline, treatment, follow-up, end of study, unscheduled), visit status (scheduled, completed, missed, cancelled), visit location, and coordinator assigned. Drives protocol compliance tracking and subject retention management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`adverse_event` (
    `adverse_event_id` BIGINT COMMENT 'Unique identifier for the adverse event within the research adverse event record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research adverse event record.',
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the diagnosis within the research adverse event record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the icd code within the research adverse event record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the research adverse event record.',
    `public_health_report_id` BIGINT COMMENT 'Unique identifier for the public health report within the research adverse event record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the reporting clinician within the research adverse event record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research adverse event record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the snomed concept within the research adverse event record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research adverse event record.',
    `study_visit_id` BIGINT COMMENT 'Unique identifier for the study visit within the research adverse event record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research adverse event record.',
    `action_taken` STRING COMMENT 'The action taken of the research adverse event record.',
    `ae_term` STRING COMMENT 'The ae term of the research adverse event record.',
    `capa_completion_date` DATE COMMENT 'Timestamp capturing the capa completion date associated with the research adverse event record.',
    `capa_description` STRING COMMENT 'The capa description of the research adverse event record.',
    `causality_assessment` STRING COMMENT 'The causality assessment of the research adverse event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research adverse event record.',
    `deviation_category` STRING COMMENT 'The deviation category of the research adverse event record.',
    `deviation_description` STRING COMMENT 'The deviation description of the research adverse event record.',
    `deviation_severity` STRING COMMENT 'The deviation severity of the research adverse event record.',
    `discovery_date` DATE COMMENT 'Timestamp capturing the discovery date associated with the research adverse event record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research adverse event record.',
    `event_status` STRING COMMENT 'The event status value classifying the research adverse event record.',
    `event_type` STRING COMMENT 'The event type value classifying the research adverse event record.',
    `expectedness` STRING COMMENT 'The expectedness of the research adverse event record.',
    `expedited_report_date` DATE COMMENT 'Timestamp capturing the expedited report date associated with the research adverse event record.',
    `expedited_reporting_flag` BOOLEAN COMMENT 'The expedited reporting flag of the research adverse event record.',
    `follow_up_date` DATE COMMENT 'Timestamp capturing the follow up date associated with the research adverse event record.',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the research adverse event record.',
    `impact_on_data_integrity` STRING COMMENT 'The impact on data integrity of the research adverse event record.',
    `impact_on_subject_safety` STRING COMMENT 'The impact on subject safety of the research adverse event record.',
    `irb_report_date` DATE COMMENT 'Timestamp capturing the irb report date associated with the research adverse event record.',
    `irb_reportable_flag` BOOLEAN COMMENT 'The irb reportable flag of the research adverse event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research adverse event record.',
    `meddra_code` STRING COMMENT 'The meddra code value classifying the research adverse event record.',
    `meddra_version` STRING COMMENT 'The meddra version of the research adverse event record.',
    `medwatch_report_number` STRING COMMENT 'The medwatch report number of the research adverse event record.',
    `modified_by` STRING COMMENT 'The modified by of the research adverse event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the research adverse event record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research adverse event record.',
    `narrative` STRING COMMENT 'The narrative of the research adverse event record.',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the research adverse event record.',
    `outcome` STRING COMMENT 'The outcome of the research adverse event record.',
    `record_notes` STRING COMMENT 'The record notes of the research adverse event record.',
    `report_date` DATE COMMENT 'Timestamp capturing the report date associated with the research adverse event record.',
    `reporter_role` STRING COMMENT 'The reporter role of the research adverse event record.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the research adverse event record.',
    `root_cause` STRING COMMENT 'The root cause of the research adverse event record.',
    `seriousness_criteria` STRING COMMENT 'The seriousness criteria of the research adverse event record.',
    `seriousness_flag` BOOLEAN COMMENT 'The seriousness flag of the research adverse event record.',
    `severity_grade` STRING COMMENT 'The severity grade of the research adverse event record.',
    `sponsor_report_date` DATE COMMENT 'Timestamp capturing the sponsor report date associated with the research adverse event record.',
    `sponsor_reportable_flag` BOOLEAN COMMENT 'The sponsor reportable flag of the research adverse event record.',
    `adverse_event_status` STRING COMMENT 'The adverse event status value classifying the research adverse event record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_extra` STRING COMMENT 'Added by VIBE mutation to ensure non‑empty diff',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `created_by` STRING COMMENT 'The created by of the research adverse event record.',
    CONSTRAINT pk_adverse_event PRIMARY KEY(`adverse_event_id`)
) COMMENT 'Captures all safety events and quality events reported during a clinical trial or research study. Safety events: adverse events (AEs) and serious adverse events (SAEs) with AE term (MedDRA coded), onset/resolution dates, severity grade (CTCAE 1–5), seriousness criteria, causality assessment, action taken, outcome, and expedited reporting flag. Quality events: protocol deviations and violations with deviation description, category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), discovery date, root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports FDA MedWatch, IND safety reporting (21 CFR 312.32), GCP compliance, quality management under ICH E6(R2), and regulatory inspection readiness. SSOT for all study safety events and quality events (including protocol deviations) within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`investigational_product` (
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational product within the research investigational product record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research investigational product record.',
    `exclusion_screening_id` BIGINT COMMENT 'Unique identifier for the exclusion screening within the research investigational product record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the research investigational product record.',
    `osha_safety_program_id` BIGINT COMMENT 'Unique identifier for the osha safety program within the research investigational product record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research investigational product record.',
    `accountability_required_flag` BOOLEAN COMMENT 'The accountability required flag of the research investigational product record.',
    `adverse_event_reporting_required_flag` BOOLEAN COMMENT 'The adverse event reporting required flag of the research investigational product record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the research investigational product record.',
    `blinding_status` STRING COMMENT 'The blinding status value classifying the research investigational product record.',
    `brand_name` STRING COMMENT 'The brand name of the research investigational product record.',
    `comparator_indicator` BOOLEAN COMMENT 'The comparator indicator of the research investigational product record.',
    `controlled_substance_schedule` STRING COMMENT 'The controlled substance schedule of the research investigational product record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research investigational product record.',
    `data_governance_classification` STRING COMMENT 'The data governance classification of the research investigational product record.',
    `discontinuation_date` DATE COMMENT 'Timestamp capturing the discontinuation date associated with the research investigational product record.',
    `dosage_form` STRING COMMENT 'The dosage form of the research investigational product record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research investigational product record.',
    `expiration_management_required_flag` BOOLEAN COMMENT 'The expiration management required flag of the research investigational product record.',
    `formulation` STRING COMMENT 'The formulation of the research investigational product record.',
    `generic_name` STRING COMMENT 'The generic name of the research investigational product record.',
    `hazardous_material_flag` BOOLEAN COMMENT 'The hazardous material flag of the research investigational product record.',
    `ind_ide_number` STRING COMMENT 'The ind ide number of the research investigational product record.',
    `indication` STRING COMMENT 'The indication of the research investigational product record.',
    `informed_consent_required_flag` BOOLEAN COMMENT 'The informed consent required flag of the research investigational product record.',
    `irb_approval_required_flag` BOOLEAN COMMENT 'The irb approval required flag of the research investigational product record.',
    `labeling_requirements` STRING COMMENT 'The labeling requirements of the research investigational product record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research investigational product record.',
    `lot_tracking_required_flag` BOOLEAN COMMENT 'The lot tracking required flag of the research investigational product record.',
    `manufacturer_address` STRING COMMENT 'The manufacturer address of the research investigational product record.',
    `manufacturer_name` STRING COMMENT 'The manufacturer name of the research investigational product record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research investigational product record.',
    `notes` STRING COMMENT 'The notes of the research investigational product record.',
    `packaging_description` STRING COMMENT 'The packaging description of the research investigational product record.',
    `phase` STRING COMMENT 'The phase of the research investigational product record.',
    `placebo_indicator` BOOLEAN COMMENT 'The placebo indicator of the research investigational product record.',
    `product_type` STRING COMMENT 'The product type value classifying the research investigational product record.',
    `protocol_number` STRING COMMENT 'The protocol number of the research investigational product record.',
    `record_notes` STRING COMMENT 'The record notes of the research investigational product record.',
    `regulatory_status` STRING COMMENT 'The regulatory status value classifying the research investigational product record.',
    `research_billing_code` STRING COMMENT 'The research billing code value classifying the research investigational product record.',
    `return_destruction_procedure` STRING COMMENT 'The return destruction procedure of the research investigational product record.',
    `route_of_administration` STRING COMMENT 'The route of administration of the research investigational product record.',
    `shelf_life_months` STRING COMMENT 'The shelf life months of the research investigational product record.',
    `special_handling_instructions` STRING COMMENT 'The special handling instructions of the research investigational product record.',
    `sponsor_name` STRING COMMENT 'The sponsor name of the research investigational product record.',
    `investigational_product_status` STRING COMMENT 'The investigational product status value classifying the research investigational product record.',
    `storage_requirements` STRING COMMENT 'The storage requirements of the research investigational product record.',
    `strength` STRING COMMENT 'The strength of the research investigational product record.',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'The temperature monitoring required flag of the research investigational product record.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area of the research investigational product record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research investigational product record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_extra` STRING COMMENT 'Added by VIBE mutation to ensure non‑empty diff',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_investigational_product PRIMARY KEY(`investigational_product_id`)
) COMMENT 'Master record for investigational drugs, biologics, or devices used in clinical trials. Captures IND/IDE number, NDC or device identifier, product name (generic and brand), formulation, dosage form, strength, manufacturer, lot number tracking flag, storage requirements, temperature monitoring requirements, expiration date management flag, blinding status (open-label, single-blind, double-blind), and comparator/placebo indicator. Supports FDA 21 CFR Part 312 (drugs) and 21 CFR Part 812 (devices) accountability requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` (
    `ip_dispensation_id` BIGINT COMMENT 'Unique identifier for the ip dispensation within the research ip dispensation record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research ip dispensation record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the dispensing clinician within the research ip dispensation record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the research ip dispensation record.',
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location within the research ip dispensation record.',
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational product within the research ip dispensation record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research ip dispensation record.',
    `study_arm_id` BIGINT COMMENT 'Unique identifier for the study arm within the research ip dispensation record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research ip dispensation record.',
    `study_visit_id` BIGINT COMMENT 'Foreign key linking to research.study_visit. Business justification: Investigational product dispensation occurs during a specific research study_visit. ip_dispensation currently only has visit_id -> encounter.visit (clinical encounter, cross-domain) but lacks a link t',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research ip dispensation record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the research ip dispensation record.',
    `accountability_status` STRING COMMENT 'The accountability status value classifying the research ip dispensation record.',
    `administration_instructions` STRING COMMENT 'The administration instructions of the research ip dispensation record.',
    `blinding_status` STRING COMMENT 'The blinding status value classifying the research ip dispensation record.',
    `chain_of_custody_signature` STRING COMMENT 'The chain of custody signature of the research ip dispensation record.',
    `compliance_status` STRING COMMENT 'The compliance status value classifying the research ip dispensation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research ip dispensation record.',
    `discrepancy_notes` STRING COMMENT 'The discrepancy notes of the research ip dispensation record.',
    `dispensation_date` DATE COMMENT 'Timestamp capturing the dispensation date associated with the research ip dispensation record.',
    `dispensation_notes` STRING COMMENT 'The dispensation notes of the research ip dispensation record.',
    `dispensation_timestamp` TIMESTAMP COMMENT 'The dispensation timestamp of the research ip dispensation record.',
    `dispensed_by_role` STRING COMMENT 'The dispensed by role of the research ip dispensation record.',
    `dose_level` STRING COMMENT 'The dose level of the research ip dispensation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research ip dispensation record.',
    `expected_return_date` DATE COMMENT 'Timestamp capturing the expected return date associated with the research ip dispensation record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research ip dispensation record.',
    `informed_consent_date` DATE COMMENT 'Timestamp capturing the informed consent date associated with the research ip dispensation record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research ip dispensation record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the research ip dispensation record.',
    `kit_number` STRING COMMENT 'The kit number of the research ip dispensation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research ip dispensation record.',
    `lot_number` STRING COMMENT 'The lot number of the research ip dispensation record.',
    `missed_doses` STRING COMMENT 'The missed doses of the research ip dispensation record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the research ip dispensation record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research ip dispensation record.',
    `protocol_number` STRING COMMENT 'The protocol number of the research ip dispensation record.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'The quantity dispensed of the research ip dispensation record.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'The quantity returned of the research ip dispensation record.',
    `quantity_unit` STRING COMMENT 'The quantity unit of the research ip dispensation record.',
    `randomization_number` STRING COMMENT 'The randomization number of the research ip dispensation record.',
    `record_notes` STRING COMMENT 'The record notes of the research ip dispensation record.',
    `return_date` DATE COMMENT 'Timestamp capturing the return date associated with the research ip dispensation record.',
    `sponsor_name` STRING COMMENT 'The sponsor name of the research ip dispensation record.',
    `ip_dispensation_status` STRING COMMENT 'The ip dispensation status value classifying the research ip dispensation record.',
    `storage_instructions` STRING COMMENT 'The storage instructions of the research ip dispensation record.',
    `subject_number` STRING COMMENT 'The subject number of the research ip dispensation record.',
    `subject_signature_timestamp` TIMESTAMP COMMENT 'The subject signature timestamp of the research ip dispensation record.',
    `temperature_at_dispensation` DECIMAL(18,2) COMMENT 'The temperature at dispensation of the research ip dispensation record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_extra` STRING COMMENT 'Added by VIBE mutation to ensure non‑empty diff',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_ip_dispensation PRIMARY KEY(`ip_dispensation_id`)
) COMMENT 'Transactional record of investigational product (IP) dispensation to an enrolled research subject at a study visit. Captures dispensation date, lot number, quantity dispensed, dose level, kit number, subject compliance (returned units, missed doses), pharmacist or coordinator dispensing, and chain-of-custody signature. Supports IP accountability logs required under FDA 21 CFR Part 312.62 and ICH E6(R2) Section 8.3. Enables drug accountability reconciliation at study close-out.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`biospecimen` (
    `biospecimen_id` BIGINT COMMENT 'Unique identifier for the biospecimen within the research biospecimen record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research biospecimen record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the collector clinician within the research biospecimen record.',
    `genetic_testing_consent_id` BIGINT COMMENT 'Unique identifier for the genetic testing consent within the research biospecimen record.',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Unique identifier for the hipaa privacy incident within the research biospecimen record.',
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location within the research biospecimen record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the research biospecimen record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the research biospecimen record.',
    `osha_exposure_incident_id` BIGINT COMMENT 'Unique identifier for the osha exposure incident within the research biospecimen record.',
    `parent_biospecimen_id` BIGINT COMMENT 'Unique identifier for the parent biospecimen within the research biospecimen record.',
    `procedure_event_id` BIGINT COMMENT 'Unique identifier for the procedure event within the research biospecimen record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research biospecimen record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the research biospecimen record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the specimen type snomed concept within the research biospecimen record.',
    `study_visit_id` BIGINT COMMENT 'Foreign key linking to research.study_visit. Business justification: Biospecimens are collected during a specific research study_visit per protocol schedule. biospecimen has visit_id -> encounter.visit (cross-domain clinical encounter) but no link to the research study',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research biospecimen record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the research biospecimen record.',
    `aliquot_number` STRING COMMENT 'The aliquot number of the research biospecimen record.',
    `anatomical_site` STRING COMMENT 'The anatomical site of the research biospecimen record.',
    `barcode` STRING COMMENT 'The barcode of the research biospecimen record.',
    `box_position` STRING COMMENT 'The box position of the research biospecimen record.',
    `chain_of_custody_log` STRING COMMENT 'The chain of custody log of the research biospecimen record.',
    `collection_date` DATE COMMENT 'Timestamp capturing the collection date associated with the research biospecimen record.',
    `collection_method` STRING COMMENT 'The collection method of the research biospecimen record.',
    `collection_time` TIMESTAMP COMMENT 'Timestamp capturing the collection time associated with the research biospecimen record.',
    `collection_volume` DECIMAL(18,2) COMMENT 'The collection volume of the research biospecimen record.',
    `collection_volume_unit` STRING COMMENT 'The collection volume unit of the research biospecimen record.',
    `comments` STRING COMMENT 'The comments of the research biospecimen record.',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the research biospecimen record.',
    `consent_for_future_use` BOOLEAN COMMENT 'The consent for future use of the research biospecimen record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research biospecimen record.',
    `deidentification_status` STRING COMMENT 'The deidentification status value classifying the research biospecimen record.',
    `disposition` STRING COMMENT 'The disposition of the research biospecimen record.',
    `disposition_date` DATE COMMENT 'Timestamp capturing the disposition date associated with the research biospecimen record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research biospecimen record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research biospecimen record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research biospecimen record.',
    `processing_date` DATE COMMENT 'Timestamp capturing the processing date associated with the research biospecimen record.',
    `processing_method` STRING COMMENT 'The processing method of the research biospecimen record.',
    `processing_time` TIMESTAMP COMMENT 'Timestamp capturing the processing time associated with the research biospecimen record.',
    `protocol_deviation_description` STRING COMMENT 'The protocol deviation description of the research biospecimen record.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'The protocol deviation flag of the research biospecimen record.',
    `quality_notes` STRING COMMENT 'The quality notes of the research biospecimen record.',
    `rack_position` STRING COMMENT 'The rack position of the research biospecimen record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the research biospecimen record.',
    `record_notes` STRING COMMENT 'The record notes of the research biospecimen record.',
    `shipment_date` DATE COMMENT 'Timestamp capturing the shipment date associated with the research biospecimen record.',
    `shipment_tracking_number` STRING COMMENT 'The shipment tracking number of the research biospecimen record.',
    `shipped_to_facility` STRING COMMENT 'The shipped to facility of the research biospecimen record.',
    `specimen_quality` STRING COMMENT 'The specimen quality of the research biospecimen record.',
    `specimen_status` STRING COMMENT 'The specimen status value classifying the research biospecimen record.',
    `specimen_subtype` STRING COMMENT 'The specimen subtype of the research biospecimen record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the research biospecimen record.',
    `biospecimen_status` STRING COMMENT 'The biospecimen status value classifying the research biospecimen record.',
    `storage_container_type` STRING COMMENT 'The storage container type value classifying the research biospecimen record.',
    `storage_temperature` DECIMAL(18,2) COMMENT 'The storage temperature of the research biospecimen record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research biospecimen record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_biospecimen PRIMARY KEY(`biospecimen_id`)
) COMMENT 'Tracks biological specimens collected from research subjects as part of study protocols, including blood, tissue, urine, saliva, and other biosamples. Captures specimen type, collection date and time, collection site (anatomical), collection method, volume/quantity, processing method, storage location (biobank, freezer, rack, box, position), chain-of-custody, de-identification status, consent for future use, specimen disposition (analyzed, stored, destroyed, shipped), and shipping/transfer records. Supports biobanking operations, translational research specimen management, and specimen lifecycle tracking from collection through final disposition.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` (
    `data_safety_monitoring_id` BIGINT COMMENT 'Unique identifier for the data safety monitoring within the research data safety monitoring record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the research data safety monitoring record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research data safety monitoring record.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the compliance regulatory submission within the research data safety monitoring record.',
    `dsmb_committee_id` BIGINT COMMENT 'Unique identifier for the dsmb committee within the research data safety monitoring record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary data employee within the research data safety monitoring record.',
    `research_document_id` BIGINT COMMENT 'Unique identifier for the research document within the research data safety monitoring record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research data safety monitoring record.',
    `adverse_events_reviewed` STRING COMMENT 'The adverse events reviewed of the research data safety monitoring record.',
    `charter_version` STRING COMMENT 'The charter version of the research data safety monitoring record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the research data safety monitoring record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research data safety monitoring record.',
    `data_lock_date` DATE COMMENT 'Timestamp capturing the data lock date associated with the research data safety monitoring record.',
    `dsmb_recommendation` STRING COMMENT 'The dsmb recommendation of the research data safety monitoring record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research data safety monitoring record.',
    `fda_notification_date` DATE COMMENT 'Timestamp capturing the fda notification date associated with the research data safety monitoring record.',
    `fda_notification_required` BOOLEAN COMMENT 'The fda notification required of the research data safety monitoring record.',
    `implementation_action_taken` STRING COMMENT 'The implementation action taken of the research data safety monitoring record.',
    `implementation_date` DATE COMMENT 'Timestamp capturing the implementation date associated with the research data safety monitoring record.',
    `interim_analysis_trigger` STRING COMMENT 'The interim analysis trigger of the research data safety monitoring record.',
    `irb_notification_date` DATE COMMENT 'Timestamp capturing the irb notification date associated with the research data safety monitoring record.',
    `irb_notification_required` BOOLEAN COMMENT 'The irb notification required of the research data safety monitoring record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research data safety monitoring record.',
    `meeting_date` DATE COMMENT 'Timestamp capturing the meeting date associated with the research data safety monitoring record.',
    `meeting_number` STRING COMMENT 'The meeting number of the research data safety monitoring record.',
    `meeting_type` STRING COMMENT 'The meeting type value classifying the research data safety monitoring record.',
    `monitoring_status` STRING COMMENT 'The monitoring status value classifying the research data safety monitoring record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research data safety monitoring record.',
    `next_review_scheduled_date` DATE COMMENT 'Timestamp capturing the next review scheduled date associated with the research data safety monitoring record.',
    `notes` STRING COMMENT 'The notes of the research data safety monitoring record.',
    `protocol_modification_required` BOOLEAN COMMENT 'The protocol modification required of the research data safety monitoring record.',
    `recommendation_rationale` STRING COMMENT 'The recommendation rationale of the research data safety monitoring record.',
    `record_notes` STRING COMMENT 'The record notes of the research data safety monitoring record.',
    `record_status` STRING COMMENT 'The record status value classifying the research data safety monitoring record.',
    `safety_stopping_rule_evaluated` BOOLEAN COMMENT 'The safety stopping rule evaluated of the research data safety monitoring record.',
    `serious_adverse_events_reviewed` STRING COMMENT 'The serious adverse events reviewed of the research data safety monitoring record.',
    `sponsor_response` STRING COMMENT 'The sponsor response of the research data safety monitoring record.',
    `sponsor_response_date` DATE COMMENT 'Timestamp capturing the sponsor response date associated with the research data safety monitoring record.',
    `sponsor_response_rationale` STRING COMMENT 'The sponsor response rationale of the research data safety monitoring record.',
    `statistical_report_document_code` STRING COMMENT 'The statistical report document code value classifying the research data safety monitoring record.',
    `data_safety_monitoring_status` STRING COMMENT 'The data safety monitoring status value classifying the research data safety monitoring record.',
    `stopping_rule_threshold_met` BOOLEAN COMMENT 'The stopping rule threshold met of the research data safety monitoring record.',
    `subjects_completed_at_review` STRING COMMENT 'The subjects completed at review of the research data safety monitoring record.',
    `subjects_enrolled_at_review` STRING COMMENT 'The subjects enrolled at review of the research data safety monitoring record.',
    `unblinding_event_occurred` BOOLEAN COMMENT 'The unblinding event occurred of the research data safety monitoring record.',
    `unblinding_justification` STRING COMMENT 'The unblinding justification of the research data safety monitoring record.',
    `unblinding_scope` STRING COMMENT 'The unblinding scope of the research data safety monitoring record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_data_safety_monitoring PRIMARY KEY(`data_safety_monitoring_id`)
) COMMENT 'Records Data Safety Monitoring Board (DSMB) or Data Monitoring Committee (DMC) activities for a clinical trial, including meeting dates, interim analysis triggers, safety stopping rules, unblinding events, committee recommendations (continue, modify, suspend, terminate), sponsor responses, and implementation actions. Captures the formal oversight record required for Phase II–IV trials and FDA-regulated studies. Supports trial integrity and subject safety oversight.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`billing_event` (
    `billing_event_id` BIGINT COMMENT 'Unique identifier for the billing event within the research billing event record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the research billing event record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research billing event record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the research billing event record.',
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim within the research billing event record.',
    `coverage_analysis_id` BIGINT COMMENT 'Unique identifier for the coverage analysis within the research billing event record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the diagnosis icd code within the research billing event record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the research billing event record.',
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line within the research billing event record.',
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry within the research billing event record.',
    `lab_charge_id` BIGINT COMMENT 'Unique identifier for the lab charge within the research billing event record.',
    `line_id` BIGINT COMMENT 'Unique identifier for the line within the research billing event record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the research billing event record.',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the research billing event record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the research billing event record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the performing clinician within the research billing event record.',
    `procedure_event_id` BIGINT COMMENT 'Unique identifier for the procedure event within the research billing event record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research billing event record.',
    `stark_arrangement_id` BIGINT COMMENT 'Unique identifier for the stark arrangement within the research billing event record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research billing event record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the research billing event record.',
    `analysis_date` DATE COMMENT 'Timestamp capturing the analysis date associated with the research billing event record.',
    `analyst_name` STRING COMMENT 'The analyst name of the research billing event record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the research billing event record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the research billing event record.',
    `approver_name` STRING COMMENT 'The approver name of the research billing event record.',
    `audit_trail` STRING COMMENT 'The audit trail of the research billing event record.',
    `billing_date` DATE COMMENT 'Timestamp capturing the billing date associated with the research billing event record.',
    `billing_status` STRING COMMENT 'The billing status value classifying the research billing event record.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The charge amount of the research billing event record.',
    `clinical_trial_policy_number` STRING COMMENT 'The clinical trial policy number of the research billing event record.',
    `cms_ncd_reference` STRING COMMENT 'The cms ncd reference of the research billing event record.',
    `compliance_flag` BOOLEAN COMMENT 'The compliance flag of the research billing event record.',
    `compliance_notes` STRING COMMENT 'The compliance notes of the research billing event record.',
    `coverage_determination` STRING COMMENT 'The coverage determination of the research billing event record.',
    `cpt_code` STRING COMMENT 'The cpt code value classifying the research billing event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research billing event record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the research billing event record.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'The data quality score of the research billing event record.',
    `department_code` STRING COMMENT 'The department code value classifying the research billing event record.',
    `determination_rationale` STRING COMMENT 'The determination rationale of the research billing event record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research billing event record.',
    `event_number` STRING COMMENT 'The event number of the research billing event record.',
    `grant_number` STRING COMMENT 'The grant number of the research billing event record.',
    `hcpcs_code` STRING COMMENT 'The hcpcs code value classifying the research billing event record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research billing event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research billing event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the research billing event record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research billing event record.',
    `payer_specific_determination` STRING COMMENT 'The payer specific determination of the research billing event record.',
    `payer_type` STRING COMMENT 'The payer type value classifying the research billing event record.',
    `principal_investigator_npi` STRING COMMENT 'The principal investigator npi of the research billing event record.',
    `procedure_description` STRING COMMENT 'The procedure description of the research billing event record.',
    `protocol_phase` STRING COMMENT 'The protocol phase of the research billing event record.',
    `protocol_version` STRING COMMENT 'The protocol version of the research billing event record.',
    `record_notes` STRING COMMENT 'The record notes of the research billing event record.',
    `revenue_code` STRING COMMENT 'The revenue code value classifying the research billing event record.',
    `service_date` DATE COMMENT 'Timestamp capturing the service date associated with the research billing event record.',
    `service_timestamp` TIMESTAMP COMMENT 'The service timestamp of the research billing event record.',
    `sponsor_name` STRING COMMENT 'The sponsor name of the research billing event record.',
    `standard_of_care_flag` BOOLEAN COMMENT 'The standard of care flag of the research billing event record.',
    `billing_event_status` STRING COMMENT 'The billing event status value classifying the research billing event record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_billing_event PRIMARY KEY(`billing_event_id`)
) COMMENT 'Captures research billing compliance determinations, coverage analysis documents, and individual charge-level events for clinical trial services. Coverage analysis layer: records the formal determination of which protocol services are standard of care (insurance-billable) versus research-specific (sponsor/grant-billable), including protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, and approval status. Charge event layer: captures service date, CPT/HCPCS code, charge amount, coverage determination (sponsor-billable, Medicare-billable, institutional cost), clinical trial policy number, and CMS NCD reference. Supports research billing compliance under CMS NCD 310.1 and OIG guidance to prevent false claims. SSOT for research billing compliance and coverage analysis within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` (
    `grant_expenditure_id` BIGINT COMMENT 'Unique identifier for the grant expenditure within the research grant expenditure record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the research grant expenditure record.',
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital project within the research grant expenditure record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research grant expenditure record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the research grant expenditure record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts within the research grant expenditure record.',
    `grant_id` BIGINT COMMENT 'Unique identifier for the grant within the research grant expenditure record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary grant employee within the research grant expenditure record.',
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order within the research grant expenditure record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research grant expenditure record.',
    `study_budget_id` BIGINT COMMENT 'Foreign key linking to research.study_budget. Business justification: Grant expenditures are charged against and reconcile to an approved study_budget. grant_expenditure has grant_id and research_study_id but no link to the specific study_budget it draws down. study_bud',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the research grant expenditure record.',
    `accounting_period` STRING COMMENT 'The accounting period of the research grant expenditure record.',
    `allocable_flag` BOOLEAN COMMENT 'The allocable flag of the research grant expenditure record.',
    `allowable_flag` BOOLEAN COMMENT 'The allowable flag of the research grant expenditure record.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the research grant expenditure record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the research grant expenditure record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the research grant expenditure record.',
    `approved_by` STRING COMMENT 'The approved by of the research grant expenditure record.',
    `audit_flag` BOOLEAN COMMENT 'The audit flag of the research grant expenditure record.',
    `audit_notes` STRING COMMENT 'The audit notes of the research grant expenditure record.',
    `award_number` STRING COMMENT 'The award number of the research grant expenditure record.',
    `budget_period` STRING COMMENT 'The budget period of the research grant expenditure record.',
    `cost_center` STRING COMMENT 'The cost center of the research grant expenditure record.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The cost share amount of the research grant expenditure record.',
    `cost_share_flag` BOOLEAN COMMENT 'The cost share flag of the research grant expenditure record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research grant expenditure record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the research grant expenditure record.',
    `grant_expenditure_description` STRING COMMENT 'The grant expenditure description of the research grant expenditure record.',
    `direct_cost_flag` BOOLEAN COMMENT 'The direct cost flag of the research grant expenditure record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research grant expenditure record.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'The effort percentage of the research grant expenditure record.',
    `expense_category` STRING COMMENT 'The expense category of the research grant expenditure record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the research grant expenditure record.',
    `fund_code` STRING COMMENT 'The fund code value classifying the research grant expenditure record.',
    `general_ledger_account` STRING COMMENT 'The general ledger account of the research grant expenditure record.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The indirect cost rate of the research grant expenditure record.',
    `invoice_number` STRING COMMENT 'The invoice number of the research grant expenditure record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research grant expenditure record.',
    `modified_by` STRING COMMENT 'The modified by of the research grant expenditure record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the research grant expenditure record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research grant expenditure record.',
    `program_code` STRING COMMENT 'The program code value classifying the research grant expenditure record.',
    `reasonable_flag` BOOLEAN COMMENT 'The reasonable flag of the research grant expenditure record.',
    `record_notes` STRING COMMENT 'The record notes of the research grant expenditure record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the research grant expenditure record.',
    `sponsor_code` STRING COMMENT 'The sponsor code value classifying the research grant expenditure record.',
    `grant_expenditure_status` STRING COMMENT 'The grant expenditure status value classifying the research grant expenditure record.',
    `transaction_date` DATE COMMENT 'Timestamp capturing the transaction date associated with the research grant expenditure record.',
    `transaction_number` STRING COMMENT 'The transaction number of the research grant expenditure record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_grant_expenditure PRIMARY KEY(`grant_expenditure_id`)
) COMMENT 'Transactional record of expenditures charged against a research grant or contract, including personnel costs (salary, fringe), supplies, equipment, subcontract costs, travel, and indirect costs. Captures transaction date, expense category, amount, budget period, cost center, effort percentage, and sponsor-required cost classification. Supports grant financial management, budget-to-actual reporting, and compliance with 2 CFR Part 200 (Uniform Guidance) cost principles. Enables NIH Just-In-Time and progress report financial sections.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` (
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the study sponsor within the research study sponsor record.',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the research study sponsor record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research study sponsor record.',
    `agreement_effective_date` DATE COMMENT 'Timestamp capturing the agreement effective date associated with the research study sponsor record.',
    `agreement_expiration_date` DATE COMMENT 'Timestamp capturing the agreement expiration date associated with the research study sponsor record.',
    `budget_approval_date` DATE COMMENT 'Timestamp capturing the budget approval date associated with the research study sponsor record.',
    `budget_currency_code` STRING COMMENT 'The budget currency code value classifying the research study sponsor record.',
    `budget_version` STRING COMMENT 'The budget version of the research study sponsor record.',
    `created_by_user` STRING COMMENT 'The created by user of the research study sponsor record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research study sponsor record.',
    `cro_relationship_type` STRING COMMENT 'The cro relationship type value classifying the research study sponsor record.',
    `duns_number` STRING COMMENT 'The duns number of the research study sponsor record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study sponsor record.',
    `financial_disclosure_required_flag` BOOLEAN COMMENT 'The financial disclosure required flag of the research study sponsor record.',
    `invoicing_contact_email` STRING COMMENT 'The invoicing contact email of the research study sponsor record.',
    `invoicing_contact_name` STRING COMMENT 'The invoicing contact name of the research study sponsor record.',
    `last_modified_by_user` STRING COMMENT 'The last modified by user of the research study sponsor record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study sponsor record.',
    `master_agreement_reference` STRING COMMENT 'The master agreement reference of the research study sponsor record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research study sponsor record.',
    `nda_bla_holder_flag` BOOLEAN COMMENT 'The nda bla holder flag of the research study sponsor record.',
    `negotiated_cost_flag` BOOLEAN COMMENT 'The negotiated cost flag of the research study sponsor record.',
    `overhead_indirect_cost_rate` DECIMAL(18,2) COMMENT 'The overhead indirect cost rate of the research study sponsor record.',
    `payment_milestone_terms` STRING COMMENT 'The payment milestone terms of the research study sponsor record.',
    `payment_schedule_frequency` STRING COMMENT 'The payment schedule frequency of the research study sponsor record.',
    `per_procedure_reimbursement_rate` DECIMAL(18,2) COMMENT 'The per procedure reimbursement rate of the research study sponsor record.',
    `per_visit_reimbursement_rate` DECIMAL(18,2) COMMENT 'The per visit reimbursement rate of the research study sponsor record.',
    `primary_contact_email` STRING COMMENT 'The primary contact email of the research study sponsor record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the research study sponsor record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the research study sponsor record.',
    `record_notes` STRING COMMENT 'The record notes of the research study sponsor record.',
    `screen_failure_allowance_amount` DECIMAL(18,2) COMMENT 'The screen failure allowance amount of the research study sponsor record.',
    `sponsor_address_line1` STRING COMMENT 'The sponsor address line1 of the research study sponsor record.',
    `sponsor_address_line2` STRING COMMENT 'The sponsor address line2 of the research study sponsor record.',
    `sponsor_city` STRING COMMENT 'The sponsor city of the research study sponsor record.',
    `sponsor_country_code` STRING COMMENT 'The sponsor country code value classifying the research study sponsor record.',
    `sponsor_name` STRING COMMENT 'The sponsor name of the research study sponsor record.',
    `sponsor_notes` STRING COMMENT 'The sponsor notes of the research study sponsor record.',
    `sponsor_postal_code` STRING COMMENT 'The sponsor postal code value classifying the research study sponsor record.',
    `sponsor_state_province` STRING COMMENT 'The sponsor state province of the research study sponsor record.',
    `sponsor_status` STRING COMMENT 'The sponsor status value classifying the research study sponsor record.',
    `sponsor_type` STRING COMMENT 'The sponsor type value classifying the research study sponsor record.',
    `startup_cost_amount` DECIMAL(18,2) COMMENT 'The startup cost amount of the research study sponsor record.',
    `study_sponsor_status` STRING COMMENT 'The study sponsor status value classifying the research study sponsor record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the research study sponsor record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_study_sponsor PRIMARY KEY(`study_sponsor_id`)
) COMMENT 'Master record for entities sponsoring clinical research studies, including negotiated study budgets and financial terms. Sponsor level: captures sponsor name, type (pharma, biotech, device, government, foundation), NDA/BLA holder status, CRO relationship, contact information, agreement reference, and financial disclosure requirements. Budget level: captures per-visit and per-procedure reimbursement rates, startup costs, overhead/indirect costs, screen failure allowances, payment milestones, budget version, negotiated vs institutional costs, budget approval date, and payment schedule terms. Distinct from grant — sponsors may fund studies without formal grant mechanisms (e.g., industry-sponsored CTAs). Supports research finance, sponsor invoicing, and study budget management. SSOT for sponsor identity and study budget terms within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` (
    `coverage_analysis_id` BIGINT COMMENT 'Unique identifier for the coverage analysis within the research coverage analysis record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the analyst employee within the research coverage analysis record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research coverage analysis record.',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the research coverage analysis record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the research coverage analysis record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research coverage analysis record.',
    `superseded_by_coverage_analysis_id` BIGINT COMMENT 'Unique identifier for the superseded by coverage analysis within the research coverage analysis record.',
    `analysis_date` DATE COMMENT 'Timestamp capturing the analysis date associated with the research coverage analysis record.',
    `analysis_status` STRING COMMENT 'The analysis status value classifying the research coverage analysis record.',
    `coverage_determination` STRING COMMENT 'The coverage determination of the research coverage analysis record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research coverage analysis record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research coverage analysis record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research coverage analysis record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research coverage analysis record.',
    `notes` STRING COMMENT 'The notes of the research coverage analysis record.',
    `protocol_number` STRING COMMENT 'The protocol number of the research coverage analysis record.',
    `record_notes` STRING COMMENT 'The record notes of the research coverage analysis record.',
    `service_type` STRING COMMENT 'The service type value classifying the research coverage analysis record.',
    `sponsor_coverage_flag` BOOLEAN COMMENT 'The sponsor coverage flag of the research coverage analysis record.',
    `coverage_analysis_status` STRING COMMENT 'The coverage analysis status value classifying the research coverage analysis record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_coverage_analysis PRIMARY KEY(`coverage_analysis_id`)
) COMMENT 'Formal coverage analysis (CA) document record that determines which services in a clinical trial protocol are standard of care (billable to insurance) versus research-specific (billable to sponsor/grant). Captures protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, approval status, and effective date. Required for research billing compliance programs under CMS NCD 310.1. Distinct from research_billing_event which captures individual charge-level determinations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` (
    `monitoring_visit_id` BIGINT COMMENT 'Unique identifier for the monitoring visit within the research monitoring visit record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research monitoring visit record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the monitor employee within the research monitoring visit record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research monitoring visit record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research monitoring visit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research monitoring visit record.',
    `critical_findings_count` STRING COMMENT 'The critical findings count of the research monitoring visit record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research monitoring visit record.',
    `findings_count` STRING COMMENT 'The findings count of the research monitoring visit record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research monitoring visit record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research monitoring visit record.',
    `notes` STRING COMMENT 'The notes of the research monitoring visit record.',
    `record_notes` STRING COMMENT 'The record notes of the research monitoring visit record.',
    `report_date` DATE COMMENT 'Timestamp capturing the report date associated with the research monitoring visit record.',
    `monitoring_visit_status` STRING COMMENT 'The monitoring visit status value classifying the research monitoring visit record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `visit_date` DATE COMMENT 'Timestamp capturing the visit date associated with the research monitoring visit record.',
    `visit_status` STRING COMMENT 'The visit status value classifying the research monitoring visit record.',
    `visit_type` STRING COMMENT 'The visit type value classifying the research monitoring visit record.',
    CONSTRAINT pk_monitoring_visit PRIMARY KEY(`monitoring_visit_id`)
) COMMENT 'Records clinical trial monitoring visits conducted by sponsor representatives, CROs, or internal monitors at study sites. Captures visit type (initiation, routine, close-out, for-cause), visit date, monitor name, site visited, findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, and visit report completion date. Supports ICH E6(R2) GCP monitoring requirements and sponsor oversight obligations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` (
    `protocol_deviation_id` BIGINT COMMENT 'Unique identifier for the protocol deviation within the research protocol deviation record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research protocol deviation record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the reporter employee within the research protocol deviation record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research protocol deviation record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research protocol deviation record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the research protocol deviation record.',
    `corrective_action` STRING COMMENT 'The corrective action of the research protocol deviation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research protocol deviation record.',
    `protocol_deviation_description` STRING COMMENT 'The protocol deviation description of the research protocol deviation record.',
    `deviation_date` DATE COMMENT 'Timestamp capturing the deviation date associated with the research protocol deviation record.',
    `deviation_severity` STRING COMMENT 'The deviation severity of the research protocol deviation record.',
    `deviation_type` STRING COMMENT 'The deviation type value classifying the research protocol deviation record.',
    `discovery_date` DATE COMMENT 'Timestamp capturing the discovery date associated with the research protocol deviation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research protocol deviation record.',
    `irb_reportable_flag` BOOLEAN COMMENT 'The irb reportable flag of the research protocol deviation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research protocol deviation record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research protocol deviation record.',
    `record_notes` STRING COMMENT 'The record notes of the research protocol deviation record.',
    `severity` STRING COMMENT 'The severity of the research protocol deviation record.',
    `protocol_deviation_status` STRING COMMENT 'The protocol deviation status value classifying the research protocol deviation record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_protocol_deviation PRIMARY KEY(`protocol_deviation_id`)
) COMMENT 'Documents protocol deviations and violations identified during a clinical trial, including the deviation description, deviation date, discovery date, deviation category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports GCP compliance, regulatory inspection readiness, and quality management under ICH E6(R2).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` (
    `deidentified_dataset_id` BIGINT COMMENT 'Unique identifier for the deidentified dataset within the research deidentified dataset record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research deidentified dataset record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the created by employee within the research deidentified dataset record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research deidentified dataset record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research deidentified dataset record.',
    `dataset_name` STRING COMMENT 'The dataset name of the research deidentified dataset record.',
    `deidentification_method` STRING COMMENT 'The deidentification method of the research deidentified dataset record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research deidentified dataset record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research deidentified dataset record.',
    `hipaa_safe_harbor_flag` BOOLEAN COMMENT 'The hipaa safe harbor flag of the research deidentified dataset record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research deidentified dataset record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research deidentified dataset record.',
    `record_count` STRING COMMENT 'The record count of the research deidentified dataset record.',
    `record_notes` STRING COMMENT 'The record notes of the research deidentified dataset record.',
    `deidentified_dataset_status` STRING COMMENT 'The deidentified dataset status value classifying the research deidentified dataset record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `creation_date` DATE COMMENT 'Timestamp capturing the creation date associated with the research deidentified dataset record.',
    CONSTRAINT pk_deidentified_dataset PRIMARY KEY(`deidentified_dataset_id`)
) COMMENT 'Master record for de-identified research datasets, access request management, and data governance. Dataset level: captures dataset name, source systems, de-identification method (Safe Harbor, Expert Determination per HIPAA 45 CFR 164.514(b)), de-identification date, data steward, approved use cases, data sharing agreement reference, IRB waiver reference, data elements, date range, and access tier (internal, limited dataset, fully de-identified). Access request level: tracks requestor name/institution, intended use, IRB approval reference, DUA status, request submission date, review date, approval/denial decision, access dates, expiration, and data destruction certification. Supports research data governance, HIPAA compliance, de-identified data access management, and NIH data sharing policy enforcement. SSOT for research data governance and de-identified data access within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_access_request` (
    `data_access_request_id` BIGINT COMMENT 'Unique identifier for the data access request within the research data access request record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee within the research data access request record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research data access request record.',
    `data_requestor_employee_id` BIGINT COMMENT 'Unique identifier for the data requestor employee within the research data access request record.',
    `data_use_agreement_id` BIGINT COMMENT 'Unique identifier for the data use agreement within the research data access request record.',
    `deidentified_dataset_id` BIGINT COMMENT 'Unique identifier for the deidentified dataset within the research data access request record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research data access request record.',
    `access_end_date` DATE COMMENT 'Timestamp capturing the access end date associated with the research data access request record.',
    `access_start_date` DATE COMMENT 'Timestamp capturing the access start date associated with the research data access request record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the research data access request record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research data access request record.',
    `data_scope_description` STRING COMMENT 'The data scope description of the research data access request record.',
    `data_type_requested` STRING COMMENT 'The data type requested of the research data access request record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research data access request record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research data access request record.',
    `irb_approval_required_flag` BOOLEAN COMMENT 'The irb approval required flag of the research data access request record.',
    `justification` STRING COMMENT 'The justification of the research data access request record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research data access request record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research data access request record.',
    `record_notes` STRING COMMENT 'The record notes of the research data access request record.',
    `request_date` DATE COMMENT 'Timestamp capturing the request date associated with the research data access request record.',
    `request_number` STRING COMMENT 'The request number of the research data access request record.',
    `request_purpose` STRING COMMENT 'The request purpose of the research data access request record.',
    `request_status` STRING COMMENT 'The request status value classifying the research data access request record.',
    `data_access_request_status` STRING COMMENT 'The data access request status value classifying the research data access request record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_data_access_request PRIMARY KEY(`data_access_request_id`)
) COMMENT 'Tracks requests by researchers, analysts, or external collaborators to access de-identified or limited research datasets. Captures requestor name and institution, requested dataset, intended use, IRB approval reference, data use agreement (DUA) status, request submission date, review date, approval/denial decision, access granted date, access expiration date, and data destruction certification requirement. Supports research data governance, HIPAA compliance, and NIH data sharing policy enforcement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_budget` (
    `study_budget_id` BIGINT COMMENT 'Unique identifier for the study budget within the research study budget record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research study budget record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the research study budget record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research study budget record.',
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the study sponsor within the research study budget record.',
    `superseded_by_study_budget_id` BIGINT COMMENT 'Unique identifier for the superseded by study budget within the research study budget record.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The approved amount of the research study budget record.',
    `budget_approval_date` DATE COMMENT 'Timestamp capturing the budget approval date associated with the research study budget record.',
    `budget_status` STRING COMMENT 'The budget status value classifying the research study budget record.',
    `budget_version` STRING COMMENT 'The budget version of the research study budget record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research study budget record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the research study budget record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study budget record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the research study budget record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study budget record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research study budget record.',
    `overhead_rate` DECIMAL(18,2) COMMENT 'The overhead rate of the research study budget record.',
    `per_patient_amount` DECIMAL(18,2) COMMENT 'The per patient amount of the research study budget record.',
    `record_notes` STRING COMMENT 'The record notes of the research study budget record.',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the research study budget record.',
    `startup_cost_amount` DECIMAL(18,2) COMMENT 'The startup cost amount of the research study budget record.',
    `study_budget_status` STRING COMMENT 'The study budget status value classifying the research study budget record.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the research study budget record.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total budget amount of the research study budget record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_study_budget PRIMARY KEY(`study_budget_id`)
) COMMENT 'Captures the negotiated and approved budget for a sponsored clinical trial or research study, including per-visit reimbursement rates, per-procedure rates, startup costs, overhead/indirect costs, screen failure allowances, and payment milestones. Tracks budget version, sponsor-negotiated amounts versus institutional costs, budget approval date, and payment schedule terms. Distinct from grant_expenditure (actuals) — this is the prospective budget and rate card for the study. Supports research finance and sponsor invoicing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`consent_template` (
    `consent_template_id` BIGINT COMMENT 'Unique identifier for the consent template within the research consent template record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research consent template record.',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the research consent template record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research consent template record.',
    `superseded_by_consent_template_id` BIGINT COMMENT 'Unique identifier for the superseded by consent template within the research consent template record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the research consent template record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research consent template record.',
    `document_url` STRING COMMENT 'The document url of the research consent template record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research consent template record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research consent template record.',
    `irb_approval_date` DATE COMMENT 'Timestamp capturing the irb approval date associated with the research consent template record.',
    `irb_approval_number` STRING COMMENT 'The irb approval number of the research consent template record.',
    `language_code` STRING COMMENT 'The language code value classifying the research consent template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research consent template record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research consent template record.',
    `record_notes` STRING COMMENT 'The record notes of the research consent template record.',
    `consent_template_status` STRING COMMENT 'The consent template status value classifying the research consent template record.',
    `template_body` STRING COMMENT 'The template body of the research consent template record.',
    `template_name` STRING COMMENT 'The template name of the research consent template record.',
    `template_status` STRING COMMENT 'The template status value classifying the research consent template record.',
    `template_version` STRING COMMENT 'The template version of the research consent template record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_consent_template PRIMARY KEY(`consent_template_id`)
) COMMENT 'Reference master for IRB-approved informed consent form (ICF) templates associated with a study, capturing template version number, IRB approval date, expiration date, language version, consent form type (full ICF, short form, assent form, HIPAA authorization), required elements checklist, and template status (draft, IRB-approved, superseded). Distinct from informed_consent (the subject-level transactional record) — this is the document template/version master. Supports consent version control and ensures subjects are consented on the current IRB-approved version.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_arm` (
    `study_arm_id` BIGINT COMMENT 'Unique identifier for the study arm within the research study arm record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research study arm record.',
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational product within the research study arm record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research study arm record.',
    `actual_enrollment` STRING COMMENT 'The actual enrollment of the research study arm record.',
    `arm_description` STRING COMMENT 'The arm description of the research study arm record.',
    `arm_name` STRING COMMENT 'The arm name of the research study arm record.',
    `arm_number` STRING COMMENT 'The arm number of the research study arm record.',
    `arm_status` STRING COMMENT 'The arm status value classifying the research study arm record.',
    `arm_type` STRING COMMENT 'The arm type value classifying the research study arm record.',
    `comparator_flag` BOOLEAN COMMENT 'The comparator flag of the research study arm record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research study arm record.',
    `dose_level` STRING COMMENT 'The dose level of the research study arm record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study arm record.',
    `intervention_description` STRING COMMENT 'The intervention description of the research study arm record.',
    `intervention_type` STRING COMMENT 'The intervention type value classifying the research study arm record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study arm record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research study arm record.',
    `placebo_flag` BOOLEAN COMMENT 'The placebo flag of the research study arm record.',
    `randomization_ratio` DECIMAL(18,2) COMMENT 'The randomization ratio of the research study arm record.',
    `record_notes` STRING COMMENT 'The record notes of the research study arm record.',
    `study_arm_status` STRING COMMENT 'The study arm status value classifying the research study arm record.',
    `target_enrollment` STRING COMMENT 'The target enrollment of the research study arm record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_study_arm PRIMARY KEY(`study_arm_id`)
) COMMENT 'Defines the treatment arms, cohorts, or groups within a clinical trial protocol, including arm name, arm type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose level or intervention description, and arm status (open, closed, suspended). Supports randomization management, stratified enrollment tracking, and protocol-defined subgroup analyses. A study may have 2–10+ arms; this entity provides the reference structure for subject_enrollment arm assignments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` (
    `study_partner_agreement_id` BIGINT COMMENT 'Unique identifier for the study partner agreement within the research study partner agreement record.',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the research study partner agreement record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research study partner agreement record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research study partner agreement record.',
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the study sponsor within the research study partner agreement record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the research study partner agreement record.',
    `agreement_notes` STRING COMMENT 'The agreement notes of the research study partner agreement record.',
    `agreement_number` STRING COMMENT 'The agreement number of the research study partner agreement record.',
    `agreement_status` STRING COMMENT 'The agreement status value classifying the research study partner agreement record.',
    `agreement_type` STRING COMMENT 'The agreement type value classifying the research study partner agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research study partner agreement record.',
    `data_sharing_flag` BOOLEAN COMMENT 'The data sharing flag of the research study partner agreement record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research study partner agreement record.',
    `execution_date` DATE COMMENT 'Timestamp capturing the execution date associated with the research study partner agreement record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research study partner agreement record.',
    `indemnification_flag` BOOLEAN COMMENT 'The indemnification flag of the research study partner agreement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research study partner agreement record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research study partner agreement record.',
    `partner_name` STRING COMMENT 'The partner name of the research study partner agreement record.',
    `partner_organization_name` STRING COMMENT 'The partner organization name of the research study partner agreement record.',
    `record_notes` STRING COMMENT 'The record notes of the research study partner agreement record.',
    `study_partner_agreement_status` STRING COMMENT 'The study partner agreement status value classifying the research study partner agreement record.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the research study partner agreement record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_study_partner_agreement PRIMARY KEY(`study_partner_agreement_id`)
) COMMENT 'This association product represents the data sharing and interoperability agreement between a research study and an external trading partner. It captures the operational relationship when a trading partner (sponsor CRO, central lab, imaging core, data coordinating center) participates in a multi-site clinical trial. Each record links one research study to one trading partner with attributes that govern the data exchange, service level agreements, and operational status specific to that study-partner collaboration.. Existence Justification: Multi-site clinical trials operationally engage multiple external trading partners (sponsor CROs, central labs, imaging cores, data coordinating centers) for data exchange, lab services, and study coordination. Each research study has multiple trading partners serving different roles, and each trading partner supports multiple concurrent studies. The business actively manages these study-partner relationships with specific data sharing agreements, SLAs, message volume tracking, and role assignments per study-partner pair.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` (
    `grant_personnel_id` BIGINT COMMENT 'Unique identifier for the grant personnel within the research grant personnel record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research grant personnel record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the research grant personnel record.',
    `grant_id` BIGINT COMMENT 'Unique identifier for the grant within the research grant personnel record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research grant personnel record.',
    `appointment_end_date` DATE COMMENT 'Timestamp capturing the appointment end date associated with the research grant personnel record.',
    `appointment_start_date` DATE COMMENT 'Timestamp capturing the appointment start date associated with the research grant personnel record.',
    `certification_date` DATE COMMENT 'Timestamp capturing the certification date associated with the research grant personnel record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research grant personnel record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research grant personnel record.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'The effort percentage of the research grant personnel record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the research grant personnel record.',
    `fringe_amount` DECIMAL(18,2) COMMENT 'The fringe amount of the research grant personnel record.',
    `key_personnel_flag` BOOLEAN COMMENT 'The key personnel flag of the research grant personnel record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research grant personnel record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research grant personnel record.',
    `personnel_role` STRING COMMENT 'The personnel role of the research grant personnel record.',
    `personnel_status` STRING COMMENT 'The personnel status value classifying the research grant personnel record.',
    `record_notes` STRING COMMENT 'The record notes of the research grant personnel record.',
    `role` STRING COMMENT 'The role of the research grant personnel record.',
    `salary_amount` DECIMAL(18,2) COMMENT 'The salary amount of the research grant personnel record.',
    `salary_charged_amount` DECIMAL(18,2) COMMENT 'The salary charged amount of the research grant personnel record.',
    `grant_personnel_status` STRING COMMENT 'The grant personnel status value classifying the research grant personnel record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_grant_personnel PRIMARY KEY(`grant_personnel_id`)
) COMMENT 'This association product represents the personnel assignment relationship between employees and research grants. It captures effort allocation, salary distribution, and cost-share commitments required for federal effort reporting (SF-424, PHS 398), NIH/NSF grant administration, and OMB Uniform Guidance compliance. Each record links one employee to one grant with attributes that exist only in the context of this funding relationship, including role on the grant, effort percentage, appointment dates, and financial allocations.. Existence Justification: In healthcare research operations, employees (clinical staff, researchers, analysts) are routinely assigned to multiple concurrent grants with different effort allocations, roles, and salary distributions. Simultaneously, each grant funds multiple personnel including the PI, co-investigators, research coordinators, and support staff. Grant personnel assignments are actively managed operational records that research administrators create, update, and track for federal effort reporting, cost accounting, and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` (
    `investigational_product_training_id` BIGINT COMMENT 'Unique identifier for the investigational product training within the research investigational product training record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research investigational product training record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the investigational employee within the research investigational product training record.',
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational product within the research investigational product training record.',
    `investigational_research_study_id` BIGINT COMMENT 'Research study for which training was provided',
    `investigational_trainee_employee_id` BIGINT COMMENT 'Employee who received the investigational product training.',
    `investigational_trainer_employee_id` BIGINT COMMENT 'Employee who provided training',
    `research_study_id` BIGINT COMMENT 'Research study associated with this training requirement.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research investigational product training record.',
    `training_id` BIGINT COMMENT 'Unique identifier for the training within the research investigational product training record.',
    `accountability_certified` BOOLEAN COMMENT 'Whether trainee is certified for accountability procedures',
    `administration_competency_verified` BOOLEAN COMMENT 'The administration competency verified of the research investigational product training record.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the post-training competency assessment.',
    `attempt_number` STRING COMMENT 'Added to expand thin product research.investigational_product_training',
    `certificate_number` BIGINT COMMENT 'Added to expand thin product research.investigational_product_training',
    `certificate_reference` STRING COMMENT 'The certificate reference of the research investigational product training record.',
    `certification_authority` STRING COMMENT 'The certification authority of the research investigational product training record.',
    `certification_number` STRING COMMENT 'The certification number of the research investigational product training record.',
    `competency_assessment_passed` BOOLEAN COMMENT 'Whether trainee passed competency assessment',
    `competency_assessment_score` DECIMAL(18,2) COMMENT 'Score on competency assessment',
    `completion_date` DATE COMMENT 'Timestamp capturing the completion date associated with the research investigational product training record.',
    `completion_flag` BOOLEAN COMMENT 'The completion flag of the research investigational product training record.',
    `completion_status` STRING COMMENT 'The completion status value classifying the research investigational product training record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research investigational product training record.',
    `delegation_log_reference` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `dispensation_certified` BOOLEAN COMMENT 'Whether trainee is certified for dispensation',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research investigational product training record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research investigational product training record.',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the research investigational product training record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the research investigational product training record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the research investigational product training record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the research investigational product training record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the research investigational product training record.',
    `gcp_certified_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `handling_certification_date` DATE COMMENT 'Timestamp capturing the handling certification date associated with the research investigational product training record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research investigational product training record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research investigational product training record.',
    `pass_flag` BOOLEAN COMMENT 'Added to expand thin product research.investigational_product_training',
    `passing_score_required` DECIMAL(18,2) COMMENT 'Minimum passing score required',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the competency assessment.',
    `product_specific_training_status` STRING COMMENT 'The product specific training status value classifying the research investigational product training record.',
    `protocol_version` STRING COMMENT 'The protocol version of the research investigational product training record.',
    `recertification_due_date` DATE COMMENT 'Timestamp capturing the recertification due date associated with the research investigational product training record.',
    `record_notes` STRING COMMENT 'The record notes of the research investigational product training record.',
    `regulatory_requirement` STRING COMMENT 'Regulatory requirement mandating training (FDA, ICH-GCP, protocol)',
    `retraining_required_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `score` DECIMAL(18,2) COMMENT 'Added to expand thin product research.investigational_product_training',
    `investigational_product_training_status` STRING COMMENT 'The investigational product training status value classifying the research investigational product training record.',
    `storage_handling_certified` BOOLEAN COMMENT 'Indicates certification for storage and handling',
    `storage_handling_certified_flag` BOOLEAN COMMENT 'Indicates whether the trainee is certified for IP storage and handling.',
    `training_completion_percentage` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `training_date` DATE COMMENT 'Timestamp capturing the training date associated with the research investigational product training record.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Duration of training in hours',
    `training_duration_minutes` STRING COMMENT 'Duration of the training session in minutes.',
    `training_materials_version` STRING COMMENT 'Version of training materials used',
    `training_method` STRING COMMENT 'Method of training delivery (e.g., in-person, online, simulation).',
    `training_module_code` BIGINT COMMENT 'Added to expand thin product research.investigational_product_training',
    `training_notes` STRING COMMENT 'The training notes of the research investigational product training record.',
    `training_outcome` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `training_status` STRING COMMENT 'The training status value classifying the research investigational product training record.',
    `training_topic` STRING COMMENT 'The training topic of the research investigational product training record.',
    `training_type` STRING COMMENT 'The training type value classifying the research investigational product training record.',
    `training_version` STRING COMMENT 'The training version of the research investigational product training record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_investigational_product_training PRIMARY KEY(`investigational_product_training_id`)
) COMMENT 'This association product represents the training certification relationship between investigational products and compliance training programs. It captures product-specific training requirements, competency verification, and certification status for staff handling investigational products in clinical trials. Each record links one investigational product to one training program with attributes tracking certification dates, competency verification, training version compliance, and recertification schedules specific to that product-training combination.. Existence Justification: In clinical trial operations, investigational products require multiple types of training (handling hazardous materials, administering complex dosage forms, storage/temperature monitoring, controlled substance protocols), and each training program applies to multiple investigational products with similar characteristics. The business actively manages product-specific training certifications as operational records, tracking which staff are certified to handle which products, with certification dates, competency verification, and recertification schedules that exist only in the context of each product-training combination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`dua_document` (
    `dua_document_id` BIGINT COMMENT 'Unique identifier for the dua document within the research dua document record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research dua document record.',
    `data_use_agreement_id` BIGINT COMMENT 'Unique identifier for the data use agreement within the research dua document record.',
    `deidentified_dataset_id` BIGINT COMMENT 'Unique identifier for the deidentified dataset within the research dua document record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the requestor employee within the research dua document record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research dua document record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research dua document record.',
    `data_classification` STRING COMMENT 'The data classification of the research dua document record.',
    `data_description` STRING COMMENT 'The data description of the research dua document record.',
    `document_name` STRING COMMENT 'The document name of the research dua document record.',
    `document_status` STRING COMMENT 'The document status value classifying the research dua document record.',
    `document_type` STRING COMMENT 'The document type value classifying the research dua document record.',
    `document_url` STRING COMMENT 'The document url of the research dua document record.',
    `document_version` STRING COMMENT 'The document version of the research dua document record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research dua document record.',
    `execution_date` DATE COMMENT 'Timestamp capturing the execution date associated with the research dua document record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research dua document record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research dua document record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research dua document record.',
    `permitted_uses` STRING COMMENT 'The permitted uses of the research dua document record.',
    `recipient_organization` STRING COMMENT 'The recipient organization of the research dua document record.',
    `record_notes` STRING COMMENT 'The record notes of the research dua document record.',
    `dua_document_status` STRING COMMENT 'The dua document status value classifying the research dua document record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_dua_document PRIMARY KEY(`dua_document_id`)
) COMMENT 'Master reference table for dua_document. Referenced by dua_document_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` (
    `data_governance_committee_id` BIGINT COMMENT 'Unique identifier for the data governance committee within the research data governance committee record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research data governance committee record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the chair employee within the research data governance committee record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research data governance committee record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the research data governance committee record.',
    `charter_version` STRING COMMENT 'The charter version of the research data governance committee record.',
    `committee_name` STRING COMMENT 'The committee name of the research data governance committee record.',
    `committee_status` STRING COMMENT 'The committee status value classifying the research data governance committee record.',
    `committee_type` STRING COMMENT 'The committee type value classifying the research data governance committee record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research data governance committee record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research data governance committee record.',
    `established_date` DATE COMMENT 'Timestamp capturing the established date associated with the research data governance committee record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research data governance committee record.',
    `meeting_frequency` STRING COMMENT 'The meeting frequency of the research data governance committee record.',
    `member_count` STRING COMMENT 'The member count of the research data governance committee record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research data governance committee record.',
    `record_notes` STRING COMMENT 'The record notes of the research data governance committee record.',
    `scope_description` STRING COMMENT 'The scope description of the research data governance committee record.',
    `data_governance_committee_status` STRING COMMENT 'The data governance committee status value classifying the research data governance committee record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_data_governance_committee PRIMARY KEY(`data_governance_committee_id`)
) COMMENT 'Master reference table for data_governance_committee. Referenced by data_governance_committee_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` (
    `dsmb_committee_id` BIGINT COMMENT 'Unique identifier for the dsmb committee within the research dsmb committee record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research dsmb committee record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the chair employee within the research dsmb committee record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research dsmb committee record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the research dsmb committee record.',
    `charter_version` STRING COMMENT 'The charter version of the research dsmb committee record.',
    `committee_name` STRING COMMENT 'The committee name of the research dsmb committee record.',
    `committee_status` STRING COMMENT 'The committee status value classifying the research dsmb committee record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research dsmb committee record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research dsmb committee record.',
    `established_date` DATE COMMENT 'Timestamp capturing the established date associated with the research dsmb committee record.',
    `independent_statistician_name` STRING COMMENT 'The independent statistician name of the research dsmb committee record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research dsmb committee record.',
    `meeting_frequency` STRING COMMENT 'The meeting frequency of the research dsmb committee record.',
    `member_count` STRING COMMENT 'The member count of the research dsmb committee record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research dsmb committee record.',
    `record_notes` STRING COMMENT 'The record notes of the research dsmb committee record.',
    `dsmb_committee_status` STRING COMMENT 'The dsmb committee status value classifying the research dsmb committee record.',
    `stopping_rules_defined_flag` BOOLEAN COMMENT 'The stopping rules defined flag of the research dsmb committee record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_dsmb_committee PRIMARY KEY(`dsmb_committee_id`)
) COMMENT 'Master reference table for dsmb_committee. Referenced by dsmb_committee_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_document` (
    `research_document_id` BIGINT COMMENT 'Unique identifier for the research document within the research research document record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research research document record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the research author employee within the research research document record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research research document record.',
    `research_uploaded_by_employee_id` BIGINT COMMENT 'Unique identifier for the research uploaded by employee within the research research document record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the research research document record.',
    `superseded_by_research_document_id` BIGINT COMMENT 'Unique identifier for the superseded by research document within the research research document record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research research document record.',
    `document_name` STRING COMMENT 'The document name of the research research document record.',
    `document_status` STRING COMMENT 'The document status value classifying the research research document record.',
    `document_title` STRING COMMENT 'The document title of the research research document record.',
    `document_type` STRING COMMENT 'The document type value classifying the research research document record.',
    `document_url` STRING COMMENT 'The document url of the research research document record.',
    `document_version` STRING COMMENT 'The document version of the research research document record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research research document record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the research research document record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research research document record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research research document record.',
    `record_notes` STRING COMMENT 'The record notes of the research research document record.',
    `regulatory_binder_flag` BOOLEAN COMMENT 'The regulatory binder flag of the research research document record.',
    `research_document_status` STRING COMMENT 'The research document status value classifying the research research document record.',
    `upload_date` DATE COMMENT 'Timestamp capturing the upload date associated with the research research document record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_research_document PRIMARY KEY(`research_document_id`)
) COMMENT 'Master reference table for research_document. Referenced by meeting_minutes_document_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` (
    `research_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the research regulatory submission within the research research regulatory submission record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the research research regulatory submission record.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking this consumer table to the canonical SSOT table compliance.compliance_regulatory_submission',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the research research regulatory submission record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the submitter employee within the research research regulatory submission record.',
    `acknowledgment_date` DATE COMMENT 'Timestamp capturing the acknowledgment date associated with the research research regulatory submission record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research research regulatory submission record.',
    `determination_outcome` STRING COMMENT 'The determination outcome of the research research regulatory submission record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research research regulatory submission record.',
    `federal_agency_name` STRING COMMENT 'The federal agency name of the research research regulatory submission record.',
    `ide_number` STRING COMMENT 'The ide number of the research research regulatory submission record.',
    `ind_number` STRING COMMENT 'The ind number of the research research regulatory submission record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research research regulatory submission record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the research research regulatory submission record.',
    `record_notes` STRING COMMENT 'The record notes of the research research regulatory submission record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: compliance.compliance_regulatory_submission (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the research research regulatory submission record.',
    `research_regulatory_submission_status` STRING COMMENT 'The research regulatory submission status value classifying the research research regulatory submission record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the research research regulatory submission record.',
    `submission_notes` STRING COMMENT 'The submission notes of the research research regulatory submission record.',
    `submission_number` STRING COMMENT 'The submission number of the research research regulatory submission record.',
    `submission_scope` STRING COMMENT 'The submission scope of the research research regulatory submission record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the research research regulatory submission record.',
    `submission_type` STRING COMMENT 'The submission type value classifying the research research regulatory submission record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to ensure change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_research_regulatory_submission PRIMARY KEY(`research_regulatory_submission_id`)
) COMMENT 'Research-specific regulatory submissions (FDA IND/IDE, IRB). SSOT consumer extending compliance.compliance_regulatory_submission with research-specific attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_study` (
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study',
    `care_site_id` BIGINT COMMENT 'Primary care site conducting the study',
    `compliance_program_id` BIGINT COMMENT 'Associated compliance program',
    `cost_center_id` BIGINT COMMENT 'Financial cost center for study expenses',
    `exchange_standard_id` BIGINT COMMENT 'Data exchange standard used for study data',
    `osha_safety_program_id` BIGINT COMMENT 'OSHA safety program governing study operations',
    `payer_id` BIGINT COMMENT 'Primary payer for study billing',
    `icd_code_id` BIGINT COMMENT 'Primary diagnosis ICD code for study population',
    `cpt_code_id` BIGINT COMMENT 'Primary procedure CPT code for study interventions',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the principal investigator clinician within the research research study record.',
    `employee_id` BIGINT COMMENT 'Principal investigator employee',
    `specialty_id` BIGINT COMMENT 'Therapeutic specialty of the study',
    `vendor_id` BIGINT COMMENT 'Primary vendor or CRO for study operations',
    `radiology_study_id` BIGINT COMMENT 'SSOT cross-reference to canonical radiology.radiology_study',
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the study sponsor within the research research study record.',
    `actual_end_date` DATE COMMENT 'Timestamp capturing the actual end date associated with the research research study record.',
    `actual_enrollment` STRING COMMENT 'Actual number of subjects enrolled',
    `amendment_count` STRING COMMENT 'Number of protocol amendments',
    `blinding_type` STRING COMMENT 'Type of blinding (single, double, open-label)',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Indicates if study is 21 CFR Part 11 compliant',
    `completion_date` DATE COMMENT 'Study completion date',
    `control_type` STRING COMMENT 'Type of control (placebo, active, historical)',
    `coordinating_center` STRING COMMENT 'Name of coordinating center',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_monitoring_committee_flag` BOOLEAN COMMENT 'Indicates if DMC is established',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the research research study record.',
    `enrollment_end_date` DATE COMMENT 'Timestamp capturing the enrollment end date associated with the research research study record.',
    `enrollment_start_date` DATE COMMENT 'Timestamp capturing the enrollment start date associated with the research research study record.',
    `enrollment_target` STRING COMMENT 'The enrollment target of the research research study record.',
    `exclusion_criteria` STRING COMMENT 'Study exclusion criteria',
    `fda_regulated_device_flag` BOOLEAN COMMENT 'Indicates if study involves FDA-regulated device',
    `fda_regulated_drug_flag` BOOLEAN COMMENT 'Indicates if study involves FDA-regulated drug',
    `funding_source` STRING COMMENT 'Primary funding source',
    `ide_number` STRING COMMENT 'Investigational Device Exemption number',
    `inclusion_criteria` STRING COMMENT 'Study inclusion criteria',
    `ind_ide_number` STRING COMMENT 'The ind ide number of the research research study record.',
    `ind_number` STRING COMMENT 'Investigational New Drug application number',
    `irb_approval_date` DATE COMMENT 'Timestamp capturing the irb approval date associated with the research research study record.',
    `irb_expiration_date` DATE COMMENT 'IRB approval expiration date',
    `irb_protocol_number` STRING COMMENT 'The irb protocol number of the research research study record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `multi_site_flag` BOOLEAN COMMENT 'The multi site flag of the research research study record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `nct_identifier` STRING COMMENT 'ClinicalTrials.gov NCT identifier',
    `nct_number` STRING COMMENT 'The nct number of the research research study record.',
    `phase` STRING COMMENT 'Study phase (I, II, III, IV)',
    `planned_end_date` DATE COMMENT 'Timestamp capturing the planned end date associated with the research research study record.',
    `primary_completion_date` DATE COMMENT 'Timestamp capturing the primary completion date associated with the research research study record.',
    `primary_outcome_measure` STRING COMMENT 'The primary outcome measure of the research research study record.',
    `protocol_number` STRING COMMENT 'The protocol number of the research research study record.',
    `protocol_version` STRING COMMENT 'The protocol version of the research research study record.',
    `protocol_version_date` DATE COMMENT 'Timestamp capturing the protocol version date associated with the research research study record.',
    `randomization_flag` BOOLEAN COMMENT 'Indicates if study is randomized',
    `record_notes` STRING COMMENT 'The record notes of the research research study record.',
    `secondary_outcome_measures` STRING COMMENT 'The secondary outcome measures of the research research study record.',
    `short_title` STRING COMMENT 'Short study title',
    `sponsor_type` STRING COMMENT 'Sponsor type (industry, academic, government)',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: radiology.radiology_study (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the research research study record.',
    `start_date` DATE COMMENT 'Study start date',
    `research_study_status` STRING COMMENT 'The research study status value classifying the research research study record.',
    `study_description` STRING COMMENT 'The study description of the research research study record.',
    `study_phase` STRING COMMENT 'The study phase of the research research study record.',
    `study_scope` STRING COMMENT 'The study scope of the research research study record.',
    `study_status` STRING COMMENT 'Study status (recruiting, active, completed, terminated)',
    `study_title` STRING COMMENT 'The study title of the research research study record.',
    `study_type` STRING COMMENT 'Study type (interventional, observational)',
    `target_enrollment` STRING COMMENT 'Target enrollment count',
    `therapeutic_area` STRING COMMENT 'The therapeutic area of the research research study record.',
    `title` STRING COMMENT 'Full study title',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the research research study record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the research research study record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_research_study PRIMARY KEY(`research_study_id`)
) COMMENT 'SSOT resolved: defer to radiology.radiology_study as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`grant` (
    `grant_id` BIGINT COMMENT 'Surrogate primary key for grant',
    `grant_grant_id` BIGINT COMMENT 'Unique identifier for the grant grant within the research grant record.',
    `abstract` STRING COMMENT 'Narrative summary describing the scientific aims and scope of the funded project.',
    `account_code` STRING COMMENT 'Institutional fund or general ledger account code where grant expenditures are recorded.',
    `animal_subjects_flag` BOOLEAN COMMENT 'Indicates whether the funded research involves animal subjects requiring IACUC oversight.',
    `application_status` STRING COMMENT 'Status of the grant application within the sponsor review process.',
    `award_date` DATE COMMENT 'Date the Notice of Award was issued by the sponsor.',
    `budget_period_end_date` DATE COMMENT 'End date of the current annual budget period.',
    `budget_period_start_date` DATE COMMENT 'Start date of the current annual budget period.',
    `cfda_number` STRING COMMENT 'Catalog of Federal Domestic Assistance / Assistance Listing number identifying the federal program funding the grant.',
    `clinical_trial_flag` BOOLEAN COMMENT 'Indicates whether the grant funds a clinical trial subject to FDA / ClinicalTrials.gov requirements.',
    `closeout_date` DATE COMMENT 'Date the grant was administratively and financially closed out.',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the grant (IRB, financial, reporting).',
    `cost_share_required_amount` DECIMAL(18,2) COMMENT 'Committed institutional cost-sharing or matching amount required by the sponsor.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the award amounts.',
    `current_year_budget_amount` DECIMAL(18,2) COMMENT 'Funded budget amount for the current active budget period.',
    `department_name` STRING COMMENT 'Name of the academic or clinical department administering the grant.',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Portion of the award attributable to direct project costs.',
    `duns_uei_number` STRING COMMENT 'SAM.gov Unique Entity Identifier of the recipient institution for federal awards.',
    `financial_conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether a financial conflict of interest has been disclosed and requires management on this grant.',
    `funding_source_type` STRING COMMENT 'Category of the organization providing the grant funds.',
    `grant_number` STRING COMMENT 'Externally-known unique award number assigned by the funding agency (e.g., NIH award number). Serves as the business identifier of the grant.',
    `grant_status` STRING COMMENT 'Current state of the grant within its lifecycle.',
    `grant_type` STRING COMMENT 'Classification of the grant mechanism. [ENUM-REF-CANDIDATE: research_project|program_project|training|career_development|cooperative_agreement|contract|fellowship|subaward — promote to reference product]',
    `human_subjects_flag` BOOLEAN COMMENT 'Indicates whether the funded research involves human subjects requiring IRB oversight.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Portion of the award attributable to Facilities & Administrative (indirect) costs.',
    `indirect_cost_rate_pct` DECIMAL(18,2) COMMENT 'Negotiated Facilities & Administrative (F&A) indirect cost rate applied to the award.',
    `irb_protocol_number` STRING COMMENT 'Institutional Review Board protocol number linked to the human-subjects research funded by this grant.',
    `next_report_due_date` DATE COMMENT 'Due date of the next required progress or financial report to the sponsor.',
    `no_cost_extension_end_date` DATE COMMENT 'Revised end date if a no-cost extension has been approved on the award.',
    `prime_sponsor_name` STRING COMMENT 'Name of the originating prime sponsor when the award is a subaward passed through another institution.',
    `principal_investigator_name` STRING COMMENT 'Full name of the principal investigator responsible for the scientific and technical direction of the grant.',
    `project_end_date` DATE COMMENT 'Date on which the overall project period ends (nullable for open-ended awards).',
    `project_start_date` DATE COMMENT 'Date on which the overall project period begins and the award becomes binding.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grant record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the grant record was last modified.',
    `reporting_frequency` STRING COMMENT 'Required frequency of technical and financial progress reports to the sponsor.',
    `research_type` STRING COMMENT 'Category of research the grant supports.',
    `restricted_funds_flag` BOOLEAN COMMENT 'Indicates whether the grant funds are restricted to specific purposes by the sponsor.',
    `sponsor_name` STRING COMMENT 'Name of the funding sponsor or agency that awarded the grant (e.g., National Institutes of Health).',
    `sponsor_program_officer_name` STRING COMMENT 'Name of the sponsors assigned program or grants management officer.',
    `submission_date` DATE COMMENT 'Date the grant application was submitted to the sponsor.',
    `title` STRING COMMENT 'Official title of the funded research project or program.',
    `total_awarded_amount` DECIMAL(18,2) COMMENT 'Total dollar value awarded across the full project period, including direct and indirect costs.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Master reference table for grant. Referenced by grant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_subject_research_study_id` FOREIGN KEY (`subject_research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_consent_template_id` FOREIGN KEY (`consent_template_id`) REFERENCES `vibe_healthcare_v1`.`research`.`consent_template`(`consent_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_superseded_by_protocol_amendment_id` FOREIGN KEY (`superseded_by_protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_parent_biospecimen_id` FOREIGN KEY (`parent_biospecimen_id`) REFERENCES `vibe_healthcare_v1`.`research`.`biospecimen`(`biospecimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_dsmb_committee_id` FOREIGN KEY (`dsmb_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dsmb_committee`(`dsmb_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_coverage_analysis_id` FOREIGN KEY (`coverage_analysis_id`) REFERENCES `vibe_healthcare_v1`.`research`.`coverage_analysis`(`coverage_analysis_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_healthcare_v1`.`research`.`grant`(`grant_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_budget`(`study_budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ADD CONSTRAINT `fk_research_study_sponsor_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_superseded_by_coverage_analysis_id` FOREIGN KEY (`superseded_by_coverage_analysis_id`) REFERENCES `vibe_healthcare_v1`.`research`.`coverage_analysis`(`coverage_analysis_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_deidentified_dataset_id` FOREIGN KEY (`deidentified_dataset_id`) REFERENCES `vibe_healthcare_v1`.`research`.`deidentified_dataset`(`deidentified_dataset_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_superseded_by_study_budget_id` FOREIGN KEY (`superseded_by_study_budget_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_budget`(`study_budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_superseded_by_consent_template_id` FOREIGN KEY (`superseded_by_consent_template_id`) REFERENCES `vibe_healthcare_v1`.`research`.`consent_template`(`consent_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_healthcare_v1`.`research`.`grant`(`grant_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_research_study_id` FOREIGN KEY (`investigational_research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_deidentified_dataset_id` FOREIGN KEY (`deidentified_dataset_id`) REFERENCES `vibe_healthcare_v1`.`research`.`deidentified_dataset`(`deidentified_dataset_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_superseded_by_research_document_id` FOREIGN KEY (`superseded_by_research_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_sponsor`(`study_sponsor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`research` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`research` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_entity_type' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_submission_id` SET TAGS ('pii_business_glossary_term' = 'IRB Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_submission_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `audit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `consent_policy_id` SET TAGS ('pii_business_glossary_term' = 'Consent Policy');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `consent_policy_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Condition ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Primary IRB Reviewer');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Protocol Amendment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_amendment_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary IRB Reviewer');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_due_date` SET TAGS ('pii_business_glossary_term' = 'Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_required_description` SET TAGS ('pii_business_glossary_term' = 'Action Required Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Action Required');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `agency_response_letter` SET TAGS ('pii_business_glossary_term' = 'Agency Response Letter');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `approval_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `determination_outcome` SET TAGS ('pii_business_glossary_term' = 'Determination Outcome');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ectd_sequence_number` SET TAGS ('pii_business_glossary_term' = 'eCTD Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_business_glossary_term' = 'Federal Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `fwa_number` SET TAGS ('pii_business_glossary_term' = 'FWA Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ide_number` SET TAGS ('pii_business_glossary_term' = 'IDE Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ind_number` SET TAGS ('pii_business_glossary_term' = 'IND Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `informed_consent_version` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_business_glossary_term' = 'IRB Board Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `nct_number` SET TAGS ('pii_business_glossary_term' = 'NCT Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `reviewing_body_type` SET TAGS ('pii_business_glossary_term' = 'Reviewing Body Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_organization` SET TAGS ('pii_business_glossary_term' = 'Sponsor Organization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_flag` SET TAGS ('pii_business_glossary_term' = 'Vulnerable Population');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_type` SET TAGS ('pii_business_glossary_term' = 'Vulnerable Population Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('pii_entity_type' = 'site');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `study_site_id` SET TAGS ('pii_business_glossary_term' = 'Study Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `study_site_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `audit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Principal Investigator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_business_glossary_term' = 'CMS Condition Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `inventory_location_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `inventory_location_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Site Coordinator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `activation_date` SET TAGS ('pii_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `actual_enrollment_count` SET TAGS ('pii_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `adverse_event_count` SET TAGS ('pii_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Required');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_business_glossary_term' = 'CRO Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `data_query_count` SET TAGS ('pii_business_glossary_term' = 'Data Query Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `enrollment_rate_per_month` SET TAGS ('pii_business_glossary_term' = 'Enrollment Rate Per Month');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `informed_consent_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `investigational_product_accountability_status` SET TAGS ('pii_business_glossary_term' = 'Investigational Product Accountability Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_approval_date` SET TAGS ('pii_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_approval_number` SET TAGS ('pii_business_glossary_term' = 'IRB Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_business_glossary_term' = 'IRB Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_business_glossary_term' = 'IRB of Record Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('pii_business_glossary_term' = 'Last Monitoring Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_type` SET TAGS ('pii_business_glossary_term' = 'Last Monitoring Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `next_monitoring_visit_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Next Monitoring Visit Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `open_data_query_count` SET TAGS ('pii_business_glossary_term' = 'Open Data Query Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_business_glossary_term' = 'Planned Enrollment Capacity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `protocol_deviation_count` SET TAGS ('pii_business_glossary_term' = 'Protocol Deviation Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `regulatory_binder_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Binder Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `screen_failure_count` SET TAGS ('pii_business_glossary_term' = 'Screen Failure Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `serious_adverse_event_count` SET TAGS ('pii_business_glossary_term' = 'Serious Adverse Event Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `serious_protocol_deviation_count` SET TAGS ('pii_business_glossary_term' = 'Serious Protocol Deviation Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_notes` SET TAGS ('pii_business_glossary_term' = 'Site Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_number` SET TAGS ('pii_business_glossary_term' = 'Site Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_performance_score` SET TAGS ('pii_business_glossary_term' = 'Site Performance Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Site Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_status` SET TAGS ('pii_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `source_document_verification_status` SET TAGS ('pii_business_glossary_term' = 'Source Document Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_business_glossary_term' = 'Sponsor Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('pii_subdomain' = 'subject_participation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('pii_subdomain' = 'subject_participation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_template_id` SET TAGS ('pii_business_glossary_term' = 'Consent Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `primary_informed_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `primary_informed_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `electronic_signature_reference` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_signature_date` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_signature_indicator` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('pii_subdomain' = 'subject_participation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('pii_subdomain' = 'safety_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `study_visit_id` SET TAGS ('pii_business_glossary_term' = 'Study Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('pii_subdomain' = 'subject_participation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `study_visit_id` SET TAGS ('pii_business_glossary_term' = 'Study Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('pii_subdomain' = 'safety_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `study_budget_id` SET TAGS ('pii_business_glossary_term' = 'Study Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('pii_subdomain' = 'safety_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('pii_subdomain' = 'safety_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('pii_subdomain' = 'data_governance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('pii_subdomain' = 'data_governance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_requestor_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_requestor_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('pii_subdomain' = 'subject_participation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('pii_subdomain' = 'data_governance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('pii_association_edges' = 'research.research_study,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('pii_association_edges' = 'workforce.employee,research.grant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_charged_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_charged_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('pii_association_edges' = 'research.investigational_product,compliance.training');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_trainee_employee_id` SET TAGS ('pii_business_glossary_term' = 'Trainee');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_trainee_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_trainee_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_trainer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_trainer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `passing_score_threshold` SET TAGS ('pii_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `storage_handling_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Storage Handling Certified');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Training Duration');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_method` SET TAGS ('pii_business_glossary_term' = 'Training Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('pii_subdomain' = 'data_governance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('pii_subdomain' = 'data_governance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('pii_subdomain' = 'safety_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_statistician_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `research_uploaded_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `research_uploaded_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_canonical' = 'compliance.compliance_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_primary' = 'compliance.compliance_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_duplicate_of' = 'compliance.compliance_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('pii_duplicate_of' = 'compliance.compliance_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Cross-reference FK to canonical SSOT table compliance.compliance_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_ssot_cross_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_entity_type' = 'study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_scope' = 'research_protocol');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_differentiated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_study_context' = 'clinical_trial');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_note' = 'Distinct concepts; enforce naming clarity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_primary' = 'radiology.radiology_study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_duplicate_of' = 'radiology.radiology_study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_canonical' = 'radiology.radiology_study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_ssot_reference' = 'radiology.radiology_study');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `research_study_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'OSHA Safety Program');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Principal Investigator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Specialty');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `specialty_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `vendor_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `actual_enrollment` SET TAGS ('pii_business_glossary_term' = 'Actual Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `blinding_type` SET TAGS ('pii_business_glossary_term' = 'Blinding Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'CFR Part 11 Compliant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `control_type` SET TAGS ('pii_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_business_glossary_term' = 'Coordinating Center');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `data_monitoring_committee_flag` SET TAGS ('pii_business_glossary_term' = 'Data Monitoring Committee');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `fda_regulated_device_flag` SET TAGS ('pii_business_glossary_term' = 'FDA Regulated Device');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `fda_regulated_drug_flag` SET TAGS ('pii_business_glossary_term' = 'FDA Regulated Drug');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `ide_number` SET TAGS ('pii_business_glossary_term' = 'IDE Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `inclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `ind_number` SET TAGS ('pii_business_glossary_term' = 'IND Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_approval_date` SET TAGS ('pii_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_business_glossary_term' = 'IRB Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_protocol_number` SET TAGS ('pii_business_glossary_term' = 'IRB Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_business_glossary_term' = 'NCT Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `phase` SET TAGS ('pii_business_glossary_term' = 'Phase');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `primary_completion_date` SET TAGS ('pii_business_glossary_term' = 'Primary Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `primary_outcome_measure` SET TAGS ('pii_business_glossary_term' = 'Primary Outcome Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_number` SET TAGS ('pii_business_glossary_term' = 'Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_version_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Version Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `randomization_flag` SET TAGS ('pii_business_glossary_term' = 'Randomization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `secondary_outcome_measures` SET TAGS ('pii_business_glossary_term' = 'Secondary Outcome Measures');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `short_title` SET TAGS ('pii_business_glossary_term' = 'Short Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `sponsor_type` SET TAGS ('pii_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_description` SET TAGS ('pii_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_status` SET TAGS ('pii_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_type` SET TAGS ('pii_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `target_enrollment` SET TAGS ('pii_business_glossary_term' = 'Target Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` SET TAGS ('pii_subdomain' = 'financial_grants');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `grant_grant_id` SET TAGS ('pii_ssot_reference' = 'finance.grant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `cost_share_required_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `current_year_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `direct_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `indirect_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `prime_sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ALTER COLUMN `total_awarded_amount` SET TAGS ('pii_confidential' = 'true');
