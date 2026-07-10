-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`compliance` COMMENT 'Enterprise regulatory compliance management for HIPAA, CMS Conditions of Participation, state health department regulations, Joint Commission standards, OSHA healthcare worker safety, and all mandatory reporting obligations. Owns compliance program definitions, regulatory requirement tracking, audit management, policy governance, and compliance training records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` (
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program',
    `budget_id` BIGINT COMMENT 'Link to the budget allocated for this compliance program',
    `employee_id` BIGINT COMMENT 'Employee responsible for the compliance program',
    `parent_compliance_program_id` BIGINT COMMENT 'Self-referential link to parent program',
    `accreditation_expiration_date` DATE COMMENT 'Date when accreditation expires',
    `accreditation_status` STRING COMMENT 'Current accreditation status',
    `audit_frequency` STRING COMMENT 'How often audits are conducted',
    `charter_document` STRING COMMENT 'Reference to the program charter document',
    `contact_email` STRING COMMENT 'Email address for program contact',
    `contact_phone` STRING COMMENT 'Phone number for program contact',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was created',
    `effective_date` DATE COMMENT 'Date when the program becomes effective',
    `expiration_date` DATE COMMENT 'Date when the program expires',
    `external_auditor_name` STRING COMMENT 'Name of external auditing organization',
    `governing_body` STRING COMMENT 'Regulatory or governing body overseeing the program',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit',
    `last_review_date` DATE COMMENT 'Date of the most recent program review',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates if the program is mandatory',
    `modified_by` STRING COMMENT 'User who last modified the record',
    `modified_timestamp` TIMESTAMP COMMENT 'When the record was last modified',
    `next_audit_date` DATE COMMENT 'Date of the next scheduled audit',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review',
    `notes` STRING COMMENT 'Additional notes about the program',
    `objectives` STRING COMMENT 'Program objectives and goals',
    `penalty_exposure_amount` DECIMAL(18,2) COMMENT 'Potential financial penalty exposure',
    `policy_count` BIGINT COMMENT 'Number of policies under this program',
    `program_code` STRING COMMENT 'Unique code for the program',
    `program_name` STRING COMMENT 'Name of the compliance program',
    `program_scope` STRING COMMENT 'Scope and coverage of the program',
    `program_status` STRING COMMENT 'Current status of the program',
    `program_type` STRING COMMENT 'Type or category of compliance program',
    `regulatory_framework` STRING COMMENT 'Regulatory framework governing the program',
    `reporting_frequency` STRING COMMENT 'How often reporting is required',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates if reporting is required',
    `review_frequency_months` STRING COMMENT 'Number of months between reviews',
    `risk_level` STRING COMMENT 'Risk level associated with the program',
    `ssot_reference` STRING COMMENT 'The ssot reference of the compliance compliance program record.',
    `compliance_program_status` STRING COMMENT 'The compliance program status value classifying the compliance compliance program record.',
    `training_frequency_months` STRING COMMENT 'Number of months between required training',
    `training_required_flag` BOOLEAN COMMENT 'Indicates if training is required',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance compliance program record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `website_url` STRING COMMENT 'URL for program information',
    `created_by` STRING COMMENT 'User who created the record',
    CONSTRAINT pk_compliance_program PRIMARY KEY(`compliance_program_id`)
) COMMENT 'Organizational compliance programs covering regulatory frameworks, policies, audits, and training requirements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation',
    `code_set_version_id` BIGINT COMMENT 'Link to applicable code set version',
    `compliance_program_id` BIGINT COMMENT 'Link to the parent compliance program',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the obligation',
    `employee_id` BIGINT COMMENT 'Employee responsible for the obligation',
    `parent_obligation_id` BIGINT COMMENT 'Self-referential link to parent obligation',
    `regulatory_change_id` BIGINT COMMENT 'Link to regulatory change that triggered the obligation',
    `regulatory_requirement_id` BIGINT COMMENT 'Link to the underlying regulatory requirement',
    `training_id` BIGINT COMMENT 'Link to required training',
    `assigned_department` STRING COMMENT 'Department assigned to fulfill the obligation',
    `assigned_role` STRING COMMENT 'Role assigned to fulfill the obligation',
    `attestation_frequency` STRING COMMENT 'How often attestation is required',
    `attestation_required` STRING COMMENT 'Indicates if attestation is required',
    `completion_date` DATE COMMENT 'Date when the obligation was completed',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of compliance achieved',
    `control_activity` STRING COMMENT 'Control activities required to meet the obligation',
    `corrective_action_required` STRING COMMENT 'Indicates if corrective action is required',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was created',
    `obligation_description` STRING COMMENT 'Detailed description of the obligation',
    `due_date` DATE COMMENT 'Date when the obligation is due',
    `effective_date` DATE COMMENT 'Date when the obligation becomes effective',
    `escalation_required` STRING COMMENT 'Indicates if escalation is required',
    `escalation_threshold_days` STRING COMMENT 'Number of days before escalation is triggered',
    `evidence_required` STRING COMMENT 'Indicates if evidence is required',
    `evidence_retention_years` STRING COMMENT 'Number of years evidence must be retained',
    `evidence_type` STRING COMMENT 'Type of evidence required',
    `expiration_date` DATE COMMENT 'Date when the obligation expires',
    `external_audit_scope` STRING COMMENT 'Indicates if the obligation is in scope for external audit',
    `finding_count` BIGINT COMMENT 'Number of findings related to this obligation',
    `is_active` BOOLEAN COMMENT 'Indicates if the obligation is currently active',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit',
    `last_audit_result` STRING COMMENT 'Result of the most recent audit',
    `modified_timestamp` TIMESTAMP COMMENT 'When the record was last modified',
    `obligation_name` STRING COMMENT 'Name of the obligation',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review',
    `notes` STRING COMMENT 'Additional notes about the obligation',
    `obligation_number` STRING COMMENT 'Unique number for the obligation',
    `obligation_status` STRING COMMENT 'Current status of the obligation',
    `obligation_type` STRING COMMENT 'Type or category of obligation',
    `policy_reference` STRING COMMENT 'Reference to related policy',
    `priority_level` STRING COMMENT 'Priority level of the obligation',
    `procedure_reference` STRING COMMENT 'Reference to related procedure',
    `recurrence_pattern` STRING COMMENT 'Pattern for recurring obligations',
    `regulatory_authority` STRING COMMENT 'Regulatory authority imposing the obligation',
    `regulatory_citation` STRING COMMENT 'Citation to the regulatory source',
    `risk_rating` STRING COMMENT 'Risk rating of the obligation',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Specific compliance obligations derived from regulatory requirements, policies, and program mandates';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` (
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy',
    `code_set_version_id` BIGINT COMMENT 'Link to applicable code set version',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the compliance compliance policy record.',
    `superseded_compliance_policy_id` BIGINT COMMENT 'Self-referential link to superseded policy',
    `approval_authority` STRING COMMENT 'Authority that approved the policy',
    `approval_date` DATE COMMENT 'Date when the policy was approved',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates if attestation is required',
    `author_contact_email` STRING COMMENT 'Email address of the policy author',
    `author_name` STRING COMMENT 'Name of the policy author',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of the policy',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was created',
    `distribution_list` STRING COMMENT 'List of recipients for the policy',
    `document_location_url` STRING COMMENT 'URL where the policy document is stored',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective',
    `enforcement_mechanism` STRING COMMENT 'How the policy is enforced',
    `expiration_date` DATE COMMENT 'Date when the policy expires',
    `keywords` STRING COMMENT 'Keywords for policy search and categorization',
    `last_review_date` DATE COMMENT 'Date of the most recent policy review',
    `modified_timestamp` TIMESTAMP COMMENT 'When the record was last modified',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review',
    `non_compliance_consequence` STRING COMMENT 'Consequences of non-compliance with the policy',
    `notes` STRING COMMENT 'The notes of the compliance compliance policy record.',
    `owner_department` STRING COMMENT 'Department that owns the policy',
    `owner_role` STRING COMMENT 'Role that owns the policy',
    `policy_category` STRING COMMENT 'Category of the policy',
    `policy_number` STRING COMMENT 'Unique number for the policy',
    `policy_status` STRING COMMENT 'Current status of the policy',
    `public_facing_flag` BOOLEAN COMMENT 'Indicates if the policy is public-facing',
    `purpose` STRING COMMENT 'Purpose and objectives of the policy',
    `regulatory_requirement_satisfied` STRING COMMENT 'Regulatory requirements satisfied by the policy',
    `related_procedure_references` STRING COMMENT 'References to related procedures',
    `related_standard_references` STRING COMMENT 'References to related standards',
    `retired_reason` STRING COMMENT 'Reason why the policy was retired',
    `retired_timestamp` TIMESTAMP COMMENT 'When the policy was retired',
    `review_cycle_months` STRING COMMENT 'Number of months between reviews',
    `scope_of_application` STRING COMMENT 'Scope and applicability of the policy',
    `compliance_policy_status` STRING COMMENT 'The compliance policy status value classifying the compliance compliance policy record.',
    `subcategory` STRING COMMENT 'Subcategory of the policy',
    `summary` STRING COMMENT 'Summary of the policy',
    `supersedes_policy_number` STRING COMMENT 'Policy number that this policy supersedes',
    `title` STRING COMMENT 'Title of the policy',
    `training_frequency_months` STRING COMMENT 'Number of months between required training',
    `training_required_flag` BOOLEAN COMMENT 'Indicates if training is required',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance compliance policy record.',
    `version_number` STRING COMMENT 'Version number of the policy',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_compliance_policy PRIMARY KEY(`compliance_policy_id`)
) COMMENT 'Organizational policies that define compliance requirements, procedures, and standards';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` (
    `policy_version_id` BIGINT COMMENT 'Unique identifier for the policy version',
    `employee_id` BIGINT COMMENT 'Employee who approved the policy version',
    `compliance_policy_id` BIGINT COMMENT 'Link to the parent compliance policy',
    `primary_policy_employee_id` BIGINT COMMENT 'Primary employee responsible for the policy version',
    `primary_superseded_version_policy_version_id` BIGINT COMMENT 'Link to the superseded policy version',
    `reviewer_employee_id` BIGINT COMMENT 'Employee who reviewed the policy version',
    `approval_date` DATE COMMENT 'Date when the version was approved',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates if attestation is required',
    `change_summary` STRING COMMENT 'Summary of changes in this version',
    `comment_log` STRING COMMENT 'Log of comments and feedback',
    `distribution_list` STRING COMMENT 'List of recipients for the policy version',
    `document_checksum` STRING COMMENT 'Checksum for document integrity verification',
    `document_url` STRING COMMENT 'URL where the policy version document is stored',
    `effective_date` DATE COMMENT 'Date when the version becomes effective',
    `expiration_date` DATE COMMENT 'Date when the version expires',
    `language_code` STRING COMMENT 'Language code for the policy version',
    `next_review_due_date` DATE COMMENT 'Date when the next review is due',
    `policy_type` STRING COMMENT 'Type or category of policy',
    `publication_date` DATE COMMENT 'Date when the version was published',
    `regulatory_citation` STRING COMMENT 'Citation to the regulatory source',
    `regulatory_driver` STRING COMMENT 'Regulatory driver for the policy version',
    `retirement_date` DATE COMMENT 'Date when the version was retired',
    `retirement_reason` STRING COMMENT 'Reason why the version was retired',
    `review_cycle_months` STRING COMMENT 'Number of months between reviews',
    `review_date` DATE COMMENT 'Date when the version was reviewed',
    `scope_description` STRING COMMENT 'Description of the version scope',
    `training_due_days` STRING COMMENT 'Number of days until training is due',
    `training_required_flag` BOOLEAN COMMENT 'Indicates if training is required',
    `version_created_timestamp` TIMESTAMP COMMENT 'When the version was created',
    `version_modified_timestamp` TIMESTAMP COMMENT 'When the version was last modified',
    `version_number` STRING COMMENT 'The version number of the compliance policy version record.',
    `version_status` STRING COMMENT 'Current status of the version',
    `version_title` STRING COMMENT 'Title of the policy version',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_policy_version PRIMARY KEY(`policy_version_id`)
) COMMENT 'Version history and change tracking for compliance policies';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit',
    `cost_center_id` BIGINT COMMENT 'Cost center being audited',
    `care_site_id` BIGINT COMMENT 'Care site where the audit is conducted',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the compliance audit record.',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referential link to follow-up audit',
    `interface_channel_id` BIGINT COMMENT 'Interface channel being audited',
    `payer_id` BIGINT COMMENT 'Payer being audited',
    `accreditation_decision` STRING COMMENT 'Accreditation decision resulting from the audit',
    `accreditation_expiration_date` DATE COMMENT 'Date when accreditation expires',
    `actual_completion_date` DATE COMMENT 'Actual date when the audit was completed',
    `actual_start_date` DATE COMMENT 'Actual date when the audit started',
    `audit_status` STRING COMMENT 'Current status of the audit',
    `audit_type` STRING COMMENT 'Type or category of audit',
    `auditing_body` STRING COMMENT 'Organization conducting the audit',
    `corrective_action_plan_due_date` DATE COMMENT 'Date when corrective action plan is due',
    `corrective_action_plan_required` STRING COMMENT 'Indicates if corrective action plan is required',
    `corrective_action_plan_submitted_date` DATE COMMENT 'Date when corrective action plan was submitted',
    `cost` DECIMAL(18,2) COMMENT 'Cost of the audit',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was created',
    `critical_findings_count` BIGINT COMMENT 'Number of critical findings',
    `department_audited` STRING COMMENT 'Department being audited',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the compliance audit record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the compliance audit record.',
    `external_auditor_organization` STRING COMMENT 'The external auditor organization of the compliance audit record.',
    `findings_count` BIGINT COMMENT 'Total number of findings',
    `follow_up_completion_date` DATE COMMENT 'Date when follow-up was completed',
    `follow_up_due_date` DATE COMMENT 'Date when follow-up is due',
    `follow_up_status` STRING COMMENT 'Status of follow-up activities',
    `frequency` STRING COMMENT 'Frequency of the audit',
    `is_unannounced` BOOLEAN COMMENT 'Indicates if the audit was unannounced',
    `last_modified_timestamp` TIMESTAMP COMMENT 'When the record was last modified',
    `lead_auditor_email` STRING COMMENT 'Email address of the lead auditor',
    `lead_auditor_name` STRING COMMENT 'Name of the lead auditor',
    `methodology` STRING COMMENT 'Audit methodology used',
    `modified_by_user` STRING COMMENT 'User who last modified the record',
    `monetary_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount of the compliance audit record.',
    `audit_name` STRING COMMENT 'Name of the audit',
    `notes` STRING COMMENT 'The notes of the compliance audit record.',
    `notification_date` DATE COMMENT 'Date when audit notification was sent',
    `overall_outcome` STRING COMMENT 'Overall outcome of the audit',
    `period_end_date` DATE COMMENT 'End date of the audit period',
    `period_start_date` DATE COMMENT 'Start date of the audit period',
    `regulatory_framework` STRING COMMENT 'Regulatory framework governing the audit',
    `report_document_path` STRING COMMENT 'Path to the audit report document',
    `report_issued_date` DATE COMMENT 'Date when the audit report was issued',
    `risk_level` STRING COMMENT 'Risk level associated with the audit',
    `sample_size` STRING COMMENT 'Sample size used in the audit',
    `scheduled_end_date` DATE COMMENT 'Scheduled end date of the audit',
    `scheduled_start_date` DATE COMMENT 'Scheduled start date of the audit',
    `scope` STRING COMMENT 'Scope and coverage of the audit',
    `team_size` STRING COMMENT 'Size of the audit team',
    `trigger` STRING COMMENT 'Trigger or reason for the audit',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance audit record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Compliance audits conducted by internal or external auditors to assess adherence to regulations and policies';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the specific facility, hospital, clinic, or care site where the finding was identified. Links to the facility product.',
    `audit_id` BIGINT COMMENT 'Reference to the parent compliance audit during which this finding was identified. Links to the compliance_audit product.',
    `compliance_policy_id` BIGINT COMMENT 'Reference to the organizational policy that was violated or requires update as a result of this finding. Links to the policy product. Null if no specific policy is implicated.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the compliance audit finding record.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Audit findings reference specific CPT codes when identifying billing compliance issues, upcoding, unbundling violations, or modifier misuse. Critical for revenue cycle compliance and OIG audit respons',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG validation audits identify specific DRG assignments that were incorrect or unsupported by documentation. Essential for inpatient reimbursement compliance and RAC audit defense.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Audit findings cite specific ICD codes when documenting clinical documentation deficiencies, DRG validation errors, or medical necessity issues. Essential for coding compliance audits and CAP tracking',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Audit findings frequently cite specific interface configuration issues, message validation failures, or data exchange vulnerabilities. Linking findings to the affected interface channel enables target',
    `parent_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `primary_previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the prior audit finding record if this is a recurrence. Links to another audit_finding record. Null if this is not a repeat finding.',
    `accreditation_impact_flag` BOOLEAN COMMENT 'Indicates whether the finding could affect the organizations accreditation status with Joint Commission, DNV, HFAP, or other accrediting bodies. True if accreditation is at risk; false otherwise.',
    `actual_resolution_date` DATE COMMENT 'The date on which the finding was actually resolved, corrective actions were completed, and the finding was closed. Null if still open or in remediation.',
    `affected_department` STRING COMMENT 'The department, unit, or service line where the finding was identified (e.g., Emergency Department, Pharmacy, Health Information Management, Infection Control). May reference multiple departments if the finding spans areas.',
    `auditor_name` STRING COMMENT 'The name of the auditor, surveyor, or inspector who identified and documented the finding. May be internal compliance staff or external regulatory surveyor.',
    `auditor_organization` STRING COMMENT 'The organization or agency the auditor represents (e.g., Joint Commission, CMS Regional Office, State Department of Health, Internal Audit Department).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required to address the finding. True for deficiencies and condition-level findings; false for observations and informational findings.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was first created in the system. Used for audit trail and data lineage.',
    `days_to_resolution` STRING COMMENT 'The number of calendar days between the identified date and the actual resolution date. Used for performance measurement and trend analysis of remediation effectiveness.',
    `dispute_reason` STRING COMMENT 'If the finding status is disputed, this field captures the organizations rationale for contesting the finding, including supporting evidence and regulatory interpretation arguments. Null if not disputed.',
    `dispute_submitted_date` DATE COMMENT 'The date on which a formal dispute or appeal of the finding was submitted to the regulatory authority. Null if not disputed.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the compliance audit finding record.',
    `evidence_location` STRING COMMENT 'The file path, document management system location, or reference to where supporting evidence and documentation for the finding is stored (e.g., audit work papers, photographs, medical records reviewed).',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the compliance audit finding record.',
    `financial_penalty_risk_flag` BOOLEAN COMMENT 'Indicates whether the finding carries risk of financial penalties, fines, or reimbursement recoupment from CMS, state agencies, or other payers. True if monetary sanctions are possible; false otherwise.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the deficiency, observation, or non-compliance issue identified. Includes what was observed, why it constitutes a finding, and the specific circumstances or evidence supporting the citation.',
    `finding_number` STRING COMMENT 'The externally-known unique identifier or tracking number assigned to this finding within the audit (e.g., F-2024-001, CMS-CoP-123). Used for audit documentation and regulatory correspondence.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open indicates newly identified; in remediation indicates corrective action plan is being executed; pending verification indicates awaiting auditor review; closed indicates resolved and accepted; disputed indicates organization contests the finding; deferred indicates resolution postponed.. Valid values are `open|in_remediation|pending_verification|closed|disputed|deferred`',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature. Deficiency indicates non-compliance requiring corrective action; observation is a noted concern without formal citation; opportunity for improvement is a recommendation; immediate jeopardy indicates serious threat to patient safety; condition-level deficiency is a systemic CMS compliance failure; best practice gap is advisory.. Valid values are `deficiency|observation|opportunity_for_improvement|immediate_jeopardy|condition_level_deficiency|best_practice_gap`',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit or validation survey is required to verify that corrective actions have been effectively implemented. True if follow-up is mandated; false otherwise.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'The scheduled date for the follow-up audit or validation survey to verify corrective action effectiveness. Null if no follow-up is required or not yet scheduled.',
    `identified_date` DATE COMMENT 'The date on which the finding was first identified during the audit or inspection. This is the principal business event timestamp for the finding.',
    `mandatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the finding triggers mandatory external reporting obligations to CMS, state health departments, Joint Commission, or other regulatory bodies. True if external reporting is required; false otherwise.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this audit finding record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'The notes of the compliance audit finding record.',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the finding has direct or potential impact on patient safety. True if patient harm occurred or could occur; false if the finding is administrative or process-related without direct patient safety implications.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat or recurrence of a previously identified and supposedly corrected issue. True if this is a repeat finding; false if this is the first occurrence.',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or governing body under which the cited standard falls (e.g., HIPAA for privacy violations, CMS CoP for hospital conditions, Joint Commission for accreditation standards, OSHA for workplace safety). [ENUM-REF-CANDIDATE: hipaa|cms_cop|joint_commission|osha|state_health_department|fda|dea|emtala|stark_law|anti_kickback|other — 11 candidates stripped; promote to reference product]',
    `regulatory_standard_cited` STRING COMMENT 'The specific regulatory standard, rule, or requirement that was violated or not met (e.g., 42 CFR 482.13, Joint Commission LD.04.03.11, OSHA 29 CFR 1910.1030). May include multiple citations separated by semicolons.',
    `reported_to_authority_date` DATE COMMENT 'The date on which the finding was reported to the applicable regulatory authority, if mandatory reporting was required. Null if not reported or not required.',
    `responsible_party_email` STRING COMMENT 'The email address of the responsible party for follow-up communication and status updates regarding the finding remediation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'The name of the individual, role, or department assigned ownership and accountability for remediating the finding and implementing corrective actions.',
    `root_cause_category` STRING COMMENT 'The primary root cause category identified through analysis of why the finding occurred. Used to drive systemic corrective actions and prevent recurrence. [ENUM-REF-CANDIDATE: policy_gap|training_deficiency|process_failure|resource_constraint|communication_breakdown|technology_issue|human_error|documentation_failure|other — 9 candidates stripped; promote to reference product]',
    `scope_of_impact` STRING COMMENT 'The breadth of the finding across the organization. Isolated indicates a single incident; pattern indicates multiple occurrences in one area; widespread indicates multiple areas affected; systemic indicates organization-wide process failure.. Valid values are `isolated|pattern|widespread|systemic`',
    `severity_level` STRING COMMENT 'The assessed severity or risk level of the finding. Critical indicates immediate threat to patient safety or major regulatory violation; high indicates significant compliance risk; medium indicates moderate risk; low indicates minor issue; informational indicates advisory note without compliance impact.. Valid values are `critical|high|medium|low|informational`',
    `audit_finding_status` STRING COMMENT 'The audit finding status value classifying the compliance audit finding record.',
    `tags_keywords` STRING COMMENT 'Comma-separated list of tags or keywords for categorization, search, and reporting (e.g., infection_control, medication_safety, documentation, privacy, emergency_preparedness). Supports analytics and trend identification.',
    `target_resolution_date` DATE COMMENT 'The date by which the finding must be resolved and corrective actions completed. May be mandated by regulatory authority or set internally based on risk assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance audit finding record.',
    `verification_method` STRING COMMENT 'The method used by the auditor to verify and validate the finding (e.g., document review, on-site inspection, staff interviews, medical record audit). May include multiple methods. [ENUM-REF-CANDIDATE: document_review|on_site_inspection|staff_interview|medical_record_audit|policy_review|observation|testing|other — 8 candidates stripped; promote to reference product]',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance audit finding record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings identified during compliance audits';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Reference to the primary audit finding or compliance violation that triggered this corrective action plan.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: CAPs often require capital expenditures or operational budget allocations for remediation (system upgrades, additional staffing, consultant fees). Links denormalized financial_impact_estimate to forma',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: CAPs frequently require capital investments for remediation (HVAC upgrades for infection control, IT system implementations for HIPAA compliance, facility modifications for life safety). Links CAP to ',
    `compliance_policy_id` BIGINT COMMENT 'Reference to the organizational policy that was updated, created, or reinforced as part of this corrective action plan.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: CAPs remediate specific procedure code compliance issues, tracking which CPT codes require documentation improvement, modifier education, or billing practice changes to prevent recurrence.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: CAPs address specific diagnosis code misuse patterns identified in audits, requiring remediation tied to particular ICD codes (e.g., sepsis coding education, specificity improvement for diabetes codes',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: CAPs often result from payer audits (claims audits, medical record reviews, contract compliance audits) or address payer-identified deficiencies. Tracking which payer triggered or is monitoring the CA',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_incident. Business justification: Corrective action plans can be created in response to HIPAA privacy incidents, not just audit findings. CAP should support multiple trigger types. This FK allows tracking CAPs created to remediate pri',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: CAPs may require appointment-level remediation including rebilling, documentation correction, or patient notification. Real remediation scope for billing and documentation findings.',
    `hipaa_security_risk_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_security_risk. Business justification: Corrective action plans can be created to mitigate HIPAA security risks identified during risk assessments. This FK allows tracking CAPs created to address security risks. N:1 relationship (many CAPs ',
    `superseded_corrective_action_plan_id` BIGINT COMMENT 'Self-referencing FK on corrective_action_plan (superseded_corrective_action_plan_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when all corrective actions were fully implemented and ready for verification.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, externally visible and used in regulatory submissions and audit correspondence.. Valid values are `^CAP-[0-9]{6,10}$`',
    `cap_status` STRING COMMENT 'Current lifecycle status of the corrective action plan in the regulatory response and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_progress|completed|verified|closed — 7 candidates stripped; promote to reference product]',
    `cap_type` STRING COMMENT 'Classification of the corrective action plan based on regulatory requirement and scope of response.. Valid values are `plan_of_correction|corrective_action_plan|preventive_action|immediate_action`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan was formally closed after successful verification and regulatory acceptance.',
    `closure_notes` STRING COMMENT 'Final notes documenting the closure of the corrective action plan, including lessons learned and recommendations for future compliance improvement.',
    `corrective_actions_defined` STRING COMMENT 'Detailed description of the specific corrective actions, process changes, policy updates, training programs, or system enhancements that will be implemented to address the deficiency.',
    `created_by_user` STRING COMMENT 'Username or identifier of the compliance officer or staff member who created the corrective action plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was first created in the compliance management system.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the corrective action plan requires escalation to executive leadership, board of directors, or external regulatory authority due to severity or complexity.',
    `external_consultant_engaged_flag` BOOLEAN COMMENT 'Indicates whether external consultants, subject matter experts, or legal counsel were engaged to support corrective action plan development or implementation.',
    `implementation_milestones` STRING COMMENT 'Key milestones, checkpoints, and deliverables defined in the corrective action plan implementation timeline.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the corrective action plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was last modified or updated.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which ongoing monitoring and auditing will be conducted to ensure sustained compliance after corrective action plan implementation.. Valid values are `daily|weekly|monthly|quarterly|annually|continuous`',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the compliance violation and corrective action plan directly impact patient safety or quality of care.',
    `priority_level` STRING COMMENT 'Priority classification of the corrective action plan based on severity of the violation, patient safety impact, and regulatory urgency.. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_measures` STRING COMMENT 'Specific measures, controls, monitoring mechanisms, or system changes implemented to prevent recurrence of the compliance violation.',
    `regulator_approval_date` DATE COMMENT 'Date when the regulatory body or accreditation agency formally approved the corrective action plan.',
    `regulator_feedback` STRING COMMENT 'Feedback, comments, or additional requirements provided by the regulatory body or accreditation agency in response to the submitted corrective action plan.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement, standard, or condition of participation that was violated and is being addressed by this CAP.',
    `responsible_owner_department` STRING COMMENT 'Department or organizational unit responsible for executing the corrective action plan.',
    `responsible_owner_email` STRING COMMENT 'Email contact for the individual responsible for the corrective action plan implementation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_owner_name` STRING COMMENT 'Name of the individual or role accountable for implementing and completing the corrective action plan.',
    `root_cause_analysis_summary` STRING COMMENT 'Summary of the root cause analysis conducted to identify the underlying factors that led to the compliance violation or audit finding.',
    `staff_affected_count` STRING COMMENT 'Number of staff members, departments, or organizational units affected by or involved in the corrective action plan implementation.',
    `submitted_to_regulator_date` DATE COMMENT 'Date when the corrective action plan was formally submitted to the regulatory body or accreditation agency.',
    `target_completion_date` DATE COMMENT 'Planned date by which all corrective actions must be fully implemented and verified, as committed to the regulatory body or accreditation agency.',
    `training_completion_target_date` DATE COMMENT 'Target date by which all required staff training must be completed as part of the corrective action plan.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training or education is required as part of the corrective action plan implementation.',
    `verification_date` DATE COMMENT 'Date when the corrective action plan was verified as complete and effective by internal compliance or external regulatory authority.',
    `verification_method` STRING COMMENT 'Method by which the effectiveness and completion of the corrective action plan will be verified by internal compliance or external regulatory surveyors. [ENUM-REF-CANDIDATE: document_review|on_site_inspection|staff_interview|medical_record_audit|policy_review|training_records_review|system_validation — 7 candidates stripped; promote to reference product]',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process documenting findings, evidence reviewed, and any remaining concerns or recommendations.',
    `verification_outcome` STRING COMMENT 'Result of the verification process indicating whether the corrective actions were found to be effective and sustainable.. Valid values are `verified_effective|verified_partial|not_verified|requires_additional_action`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance corrective action plan record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Corrective action plans developed to address audit findings and compliance gaps';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` (
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Unique identifier for the HIPAA privacy incident record. Primary key.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Privacy incidents often originate from or are discovered through message exchange logs (unauthorized access, improper disclosure via interface). Linking incidents to specific message logs provides evi',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_note. Business justification: Privacy breach investigations frequently identify specific clinical notes that were inappropriately accessed or disclosed. HIPAA incident response requires documenting which exact note records were in',
    `parent_hipaa_privacy_incident_id` BIGINT COMMENT 'Self-referencing FK on hipaa_privacy_incident (related_hipaa_privacy_incident_id)',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Privacy incidents involving payer data (eligibility file breaches, claims data exposure, remittance misdirection) must track which payers data was involved for breach notification, business associate',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Privacy incidents are often discovered through access log reviews; linking the specific log entries that triggered the incident investigation is standard practice for breach determination and OCR repo',
    `affected_individuals_count` BIGINT COMMENT 'The number of unique individuals whose PHI was potentially or actually compromised in the incident.',
    `breach_determination_date` DATE COMMENT 'The date when the formal breach determination was completed.',
    `breach_determination_outcome` STRING COMMENT 'The formal determination of whether the incident constitutes a breach under HIPAA Breach Notification Rule based on the four-factor risk assessment.. Valid values are `breach|not a breach|low probability of compromise|pending determination`',
    `closed_date` DATE COMMENT 'The date when the incident investigation and all required actions were completed and the case was formally closed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this incident record was first created in the system.',
    `disciplinary_action_taken_flag` BOOLEAN COMMENT 'Indicates whether disciplinary action was taken against any workforce member as a result of the incident.',
    `discovery_date` DATE COMMENT 'The date when the organization first became aware of the potential privacy incident or breach.',
    `incident_category` STRING COMMENT 'High-level categorization of the root cause or mechanism of the incident.. Valid values are `technical|human error|malicious|physical|administrative`',
    `incident_date` DATE COMMENT 'The date when the unauthorized access, use, or disclosure of Protected Health Information (PHI) occurred or is estimated to have occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the privacy incident including circumstances, individuals involved, and sequence of events.',
    `incident_number` STRING COMMENT 'Business-facing unique identifier or case number assigned to the privacy incident for tracking and reference purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the privacy incident investigation and resolution process. [ENUM-REF-CANDIDATE: reported|under investigation|breach determination pending|breach confirmed|not a breach|closed|remediation in progress — 7 candidates stripped; promote to reference product]',
    `incident_type` STRING COMMENT 'Classification of the nature of the privacy incident describing how the unauthorized use or disclosure occurred. [ENUM-REF-CANDIDATE: unauthorized access|improper disclosure|lost device|stolen device|misdirected communication|insider threat|hacking|ransomware|phishing — 9 candidates stripped; promote to reference product]',
    `individual_notification_date` DATE COMMENT 'The date when notification letters were sent to affected individuals (must be within 60 days of discovery).',
    `individual_notification_required_flag` BOOLEAN COMMENT 'Indicates whether notification to affected individuals is required under HIPAA Breach Notification Rule.',
    `investigation_summary` STRING COMMENT 'Detailed summary of the investigation findings including root cause analysis and contributing factors.',
    `law_enforcement_case_number` STRING COMMENT 'Case or reference number assigned by law enforcement if the incident was reported to police or other authorities.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement agencies were notified of the incident.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the incident and recommendations for organizational improvement.',
    `location_of_incident` STRING COMMENT 'Physical or system location where the privacy incident occurred (e.g., facility name, department, system name).',
    `media_notification_date` DATE COMMENT 'The date when media notification was issued for breaches affecting 500 or more individuals.',
    `media_notification_required_flag` BOOLEAN COMMENT 'Indicates whether media notification is required (for breaches affecting 500 or more individuals in a jurisdiction).',
    `mitigation_measures` STRING COMMENT 'Description of immediate mitigation measures taken to limit harm and prevent further unauthorized access or disclosure.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this incident record was last modified or updated.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether breach notification to affected individuals, HHS Office for Civil Rights (OCR), and/or media is required.',
    `ocr_case_number` STRING COMMENT 'The case or reference number assigned by HHS Office for Civil Rights upon receipt of the breach report.',
    `ocr_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether reporting to HHS Office for Civil Rights is required.',
    `ocr_reporting_status` STRING COMMENT 'Current status of the breach report submission to HHS Office for Civil Rights.. Valid values are `not required|pending|submitted|acknowledged|under investigation`',
    `ocr_submission_date` DATE COMMENT 'The date when the breach report was submitted to HHS Office for Civil Rights (within 60 days for 500+ individuals, or annually for fewer than 500).',
    `phi_involved_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information was involved in the incident.',
    `phi_type` STRING COMMENT 'Description of the type or category of PHI that was accessed, used, or disclosed (e.g., medical records, billing information, lab results, demographic data).',
    `phi_volume_records` STRING COMMENT 'The number of patient records or PHI records involved in the incident.',
    `policy_violation_flag` BOOLEAN COMMENT 'Indicates whether the incident involved a violation of organizational privacy policies or procedures.',
    `privacy_officer_assigned` STRING COMMENT 'Name of the privacy officer or compliance officer assigned to investigate and manage the incident.',
    `remediation_actions_taken` STRING COMMENT 'Description of corrective and remediation actions taken to address the incident and prevent recurrence.',
    `remediation_completion_date` DATE COMMENT 'The date when all remediation actions were completed.',
    `reported_by_department` STRING COMMENT 'Department or organizational unit of the individual who reported the incident.',
    `reported_by_name` STRING COMMENT 'Name of the individual who initially reported or discovered the privacy incident.',
    `reported_by_role` STRING COMMENT 'Job title or role of the individual who reported the incident.',
    `risk_assessment_completed_flag` BOOLEAN COMMENT 'Indicates whether the required four-factor risk assessment has been completed to determine breach status.',
    `risk_assessment_summary` STRING COMMENT 'Summary of the four-factor risk assessment findings including nature and extent of PHI, unauthorized person, actual acquisition or viewing, and extent of mitigation.',
    `root_cause` STRING COMMENT 'Identified root cause of the privacy incident based on investigation findings.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance hipaa privacy incident record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_hipaa_privacy_incident PRIMARY KEY(`hipaa_privacy_incident_id`)
) COMMENT 'HIPAA privacy incidents and breaches requiring investigation and reporting';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` (
    `hipaa_security_risk_id` BIGINT COMMENT 'Unique identifier for the HIPAA Security Rule risk analysis record. Primary key for the risk register.',
    `audit_finding_id` BIGINT COMMENT 'Reference to an internal or external audit finding that identified this risk, if applicable.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the specific IT asset, facility, or resource in the asset inventory that is exposed to this risk.',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: HIPAA security risk assessments must evaluate interface channels as potential threat vectors for ePHI exposure. Linking risks to specific channels enables risk-based interface security controls, vulne',
    `employee_id` BIGINT COMMENT 'Reference to the employee or role accountable for managing and monitoring this risk. Typically a department head, system owner, or security officer.',
    `prior_hipaa_security_risk_id` BIGINT COMMENT 'Self-referencing FK on hipaa_security_risk (prior_hipaa_security_risk_id)',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Reference to a security incident or breach event that triggered the identification of this risk, if applicable.',
    `tertiary_hipaa_identified_by_employee_id` BIGINT COMMENT 'Reference to the employee, auditor, or security analyst who identified and documented this risk.',
    `affected_ephi_system` STRING COMMENT 'Name or identifier of the information system, application, or asset that contains or processes ePHI and is subject to this risk. Examples include EHR system, billing system, patient portal, or backup storage.',
    `closed_timestamp` TIMESTAMP COMMENT 'System timestamp when this risk was formally closed or resolved, indicating it is no longer an active concern.',
    `control_effectiveness` STRING COMMENT 'Assessment of how well existing controls are functioning to mitigate the risk. Rated as effective, partially effective, ineffective, or not implemented.. Valid values are `effective|partially_effective|ineffective|not_implemented`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this risk record was first created in the risk management system.',
    `existing_controls` STRING COMMENT 'Description of current safeguards, policies, procedures, or technical controls already in place that reduce the likelihood or impact of this risk.',
    `identification_method` STRING COMMENT 'Method or source through which the risk was identified, such as vulnerability scan, penetration test, internal audit, external audit, incident investigation, or self-assessment.',
    `identified_date` DATE COMMENT 'Date when this risk was first identified and documented in the risk register.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the potential harm or damage if the risk is realized. Considers confidentiality, integrity, and availability impact on ePHI, as well as financial, reputational, and regulatory consequences.. Valid values are `very_low|low|medium|high|very_high`',
    `impact_score` STRING COMMENT 'Numeric score representing the magnitude of impact if the risk occurs, typically on a scale of 1-5 or 1-10, used for quantitative risk calculation.',
    `inherent_risk_level` STRING COMMENT 'Overall risk level before considering existing controls, calculated from likelihood and impact. Categorized as critical, high, medium, or low. Represents the raw exposure.. Valid values are `critical|high|medium|low`',
    `inherent_risk_score` STRING COMMENT 'Numeric inherent risk score, typically calculated as likelihood_score multiplied by impact_score, representing the risk exposure before mitigation.',
    `last_review_date` DATE COMMENT 'Date when this risk was last reviewed and reassessed by the risk owner or security team.',
    `likelihood_rating` STRING COMMENT 'Qualitative assessment of the probability that the threat will exploit the vulnerability. Rated as very low, low, medium, high, or very high based on threat frequency, vulnerability severity, and existing controls.. Valid values are `very_low|low|medium|high|very_high`',
    `likelihood_score` STRING COMMENT 'Numeric score representing the likelihood of occurrence, typically on a scale of 1-5 or 1-10, used for quantitative risk calculation.',
    `mitigation_actual_completion_date` DATE COMMENT 'Actual date when mitigation controls were fully implemented and verified as operational.',
    `mitigation_controls_implemented` STRING COMMENT 'List or description of new safeguards, policies, procedures, or technical controls that have been implemented to mitigate this risk.',
    `mitigation_plan` STRING COMMENT 'Detailed description of the action plan to reduce the risk, including specific controls to be implemented, responsible parties, and timelines.',
    `mitigation_start_date` DATE COMMENT 'Date when mitigation activities began or are scheduled to begin.',
    `mitigation_target_completion_date` DATE COMMENT 'Planned or target date by which mitigation controls should be fully implemented and operational.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this risk record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this risk to reassess likelihood, impact, control effectiveness, and treatment decisions. HIPAA requires annual risk analysis.',
    `notes` STRING COMMENT 'Additional comments, context, or documentation related to this risk, including historical decisions, stakeholder discussions, or special considerations.',
    `regulatory_citation` STRING COMMENT 'Specific HIPAA Security Rule section or other regulatory requirement that this risk relates to, such as §164.308(a)(3) for workforce security or §164.312(a)(1) for access control.',
    `residual_risk_level` STRING COMMENT 'Overall risk level after considering existing and planned mitigation controls. Categorized as critical, high, medium, or low. Represents the remaining exposure after treatment.. Valid values are `critical|high|medium|low`',
    `residual_risk_score` STRING COMMENT 'Numeric residual risk score after mitigation, calculated from adjusted likelihood and impact scores, representing the remaining risk exposure.',
    `risk_acceptance_date` DATE COMMENT 'Date when the risk acceptance decision was formally approved by management.',
    `risk_acceptance_justification` STRING COMMENT 'Business rationale and approval documentation for accepting a risk without further mitigation, including cost-benefit analysis and management sign-off.',
    `risk_assessment_cycle_code` STRING COMMENT 'Reference to the annual or periodic risk assessment cycle during which this risk was identified. Links to the broader compliance assessment program.',
    `risk_category` STRING COMMENT 'High-level classification of the risk aligned with HIPAA Security Rule safeguard categories: administrative, physical, technical, or organizational.. Valid values are `administrative|physical|technical|organizational`',
    `risk_number` STRING COMMENT 'Business-facing unique identifier for the risk, typically formatted as a human-readable code (e.g., RISK-2024-001) for tracking and reporting purposes.',
    `risk_owner_department` STRING COMMENT 'Department or business unit responsible for managing this risk, such as IT, Compliance, Clinical Operations, or Health Information Management (HIM).',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk: open (newly identified), in progress (mitigation underway), mitigated (controls implemented), accepted (risk tolerance decision made), or closed (risk no longer applicable).. Valid values are `open|in_progress|mitigated|accepted|closed`',
    `risk_subcategory` STRING COMMENT 'Detailed classification of the risk within the category, such as access control, encryption, workforce security, or facility access.',
    `risk_title` STRING COMMENT 'Short descriptive title of the identified risk, summarizing the threat or vulnerability in business terms.',
    `risk_treatment_decision` STRING COMMENT 'Strategic decision on how to address the risk: accept (tolerate the risk), mitigate (implement controls to reduce risk), transfer (shift risk via insurance or contract), or avoid (eliminate the activity causing the risk).. Valid values are `accept|mitigate|transfer|avoid`',
    `threat_description` STRING COMMENT 'Detailed description of the threat agent or event that could exploit the vulnerability and cause harm to ePHI (Electronic Protected Health Information). Examples include malware, unauthorized access, natural disaster, or insider threat.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance hipaa security risk record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `vulnerability_description` STRING COMMENT 'Detailed description of the weakness or gap in controls that could be exploited by the threat. Examples include unpatched systems, weak passwords, lack of encryption, or inadequate physical security.',
    CONSTRAINT pk_hipaa_security_risk PRIMARY KEY(`hipaa_security_risk_id`)
) COMMENT 'HIPAA security risks identified through risk assessments and security evaluations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the compliance training program. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training programs are delivered by specific departments and funded through their cost centers. Training costs (development, delivery, vendor fees) must be allocated for financial tracking, budget mana',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure coding training targets specific CPT codes with high error rates, compliance risk, or frequent NCCI edits, necessitating direct linkage for curriculum design and effectiveness tracking.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Compliance training modules focus on specific high-risk or frequently misused diagnosis codes (sepsis, MI, diabetes with complications), requiring direct code references for targeted coder education.',
    `prerequisite_training_id` BIGINT COMMENT 'Self-referencing FK on training (prerequisite_training_id)',
    `accreditation_body` STRING COMMENT 'Organization that has accredited or certified this training program. Examples: ANCC, AMA, AAFP. Null if not accredited.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or certification number assigned by the accrediting body. Used for external reporting and audit.',
    `approval_authority` STRING COMMENT 'Role or individual who approved this training program for deployment. Examples: Chief Compliance Officer, Chief Medical Officer, VP Human Resources.',
    `approval_date` DATE COMMENT 'Date when the training program was formally approved for use by the approval authority.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether the training includes a graded assessment that must be passed for completion. True if assessment is required, False if completion is based on participation only.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether the learner must sign an attestation statement acknowledging understanding and commitment to comply. Common for Code of Conduct and policy-based training.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate is issued upon successful completion of the training. True if certificate is generated, False otherwise.',
    `content_author` STRING COMMENT 'Name of the individual or team who developed the training content.',
    `content_location_url` STRING COMMENT 'URL or file path where the training content is hosted. Used by learning management systems to launch the training.',
    `content_owner` STRING COMMENT 'Department or role responsible for maintaining the training content and ensuring accuracy and regulatory alignment. Examples: Compliance Department, Infection Prevention, Human Resources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was first created in the system. Used for audit trail and data lineage.',
    `training_description` STRING COMMENT 'Detailed description of the training program content, scope, and purpose. Displayed to learners and used for catalog search.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Expected time in minutes required to complete the training program. Used for workforce planning and scheduling.',
    `effective_date` DATE COMMENT 'Date when this training program version became active and available for assignment. Used to track training content versioning.',
    `escalation_threshold_days` STRING COMMENT 'Number of days past the due date after which non-completion triggers an escalation to management. Used for compliance enforcement.',
    `expiration_date` DATE COMMENT 'Date when this training program version is no longer valid or available for new assignments. Null if the training has no planned end date.',
    `format` STRING COMMENT 'Delivery method for the training program. Determines how learners access and complete the training. [ENUM-REF-CANDIDATE: Online|In-Person|Blended|Simulation|On-the-Job|Self-Study|Webinar|Video — 8 candidates stripped; promote to reference product]',
    `frequency` STRING COMMENT 'How often the training must be completed to maintain compliance. Drives recurrence scheduling and assignment logic. [ENUM-REF-CANDIDATE: Annual|Biennial|One-Time|Upon Hire|Upon Role Change|Quarterly|As Needed — 7 candidates stripped; promote to reference product]',
    `frequency_months` STRING COMMENT 'Numeric representation of training recurrence interval in months. Used for automated scheduling. Examples: 12 for annual, 24 for biennial, null for one-time.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags used for training catalog search and discovery.',
    `last_review_date` DATE COMMENT 'Date when the training content was last reviewed and validated for accuracy and regulatory compliance.',
    `learning_objectives` STRING COMMENT 'Summary of the key learning outcomes and competencies the training is designed to achieve. Used for curriculum mapping and competency tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was last modified. Used for audit trail and change tracking.',
    `training_name` STRING COMMENT 'Full name of the compliance training program as displayed to learners and in catalogs.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review. Used to trigger review workflows and ensure training remains current.',
    `non_compliance_consequence` STRING COMMENT 'Description of the organizational consequence for failing to complete required training. Examples: Loss of system access, disciplinary action, termination.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to successfully complete the training, expressed as a percentage (0.00 to 100.00). Null if no assessment is required.',
    `policy_reference` STRING COMMENT 'Reference to the organizational policy or policies that this training supports. Links training to the governance framework.',
    `priority_level` STRING COMMENT 'Business priority assigned to this training program. Critical and High priority training may trigger escalation workflows for non-completion.. Valid values are `Critical|High|Medium|Low`',
    `regulatory_authority` STRING COMMENT 'The governing body or agency that mandates this training requirement. Examples: HHS Office for Civil Rights, OSHA, CMS, The Joint Commission, State Department of Health.',
    `regulatory_mandate` STRING COMMENT 'The specific regulation, statute, or accreditation standard that requires this training. Examples: HIPAA Privacy Rule 45 CFR 164.530(b), OSHA 29 CFR 1910.1030, Joint Commission HR.01.06.01.',
    `retired_reason` STRING COMMENT 'Explanation for why the training program was retired. Examples: Superseded by new version, Regulatory requirement removed, Content no longer relevant.',
    `retired_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program was retired and removed from active use. Null if the training is still active or suspended.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the training content must be reviewed for accuracy and regulatory alignment. Examples: 12, 24, 36.',
    `supersedes_training_number` STRING COMMENT 'Training program number that this version replaces. Used to track training evolution and ensure learners complete the most current version.',
    `target_audience` STRING COMMENT 'Description of the workforce population required to complete this training. May specify roles, departments, or all staff. Examples: All Staff, Clinical Staff, Physicians, Nurses, Environmental Services, IT Staff, Revenue Cycle Staff.',
    `target_department` STRING COMMENT 'Specific department or service line required to complete this training. Used for automated assignment rules.',
    `target_role` STRING COMMENT 'Specific job role or role category required to complete this training. Used for automated assignment rules.',
    `training_number` STRING COMMENT 'Business identifier for the training program, used for external reference and reporting. Typically follows format TRN-XXXXXX.. Valid values are `^TRN-[A-Z0-9]{6,12}$`',
    `training_status` STRING COMMENT 'Current lifecycle status of the training program. Active programs are available for assignment and completion.. Valid values are `Active|Inactive|Under Development|Under Review|Retired|Suspended`',
    `training_type` STRING COMMENT 'Category of compliance training program. Defines the subject matter and regulatory domain covered by the training. [ENUM-REF-CANDIDATE: HIPAA Privacy|HIPAA Security|Corporate Compliance|OSHA Bloodborne Pathogens|Fire Safety|Abuse and Neglect|Cultural Competency|Code of Conduct|Emergency Preparedness|Infection Control|Patient Rights|Workplace Violence Prevention|Hazardous Materials|Radiation Safety|Respiratory Protection|Other — 16 candidates stripped; promote to reference product]',
    `vendor_course_code` STRING COMMENT 'Unique identifier assigned by the external vendor for this training course. Used for integration and reporting with vendor learning management systems.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or content provider if the training is sourced from a third party. Null for internally developed training.',
    `version_number` STRING COMMENT 'Version identifier for the training content. Incremented when training materials are updated. Format: major.minor (e.g., 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance training record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Compliance training programs and courses required for staff';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who completed or was assigned the training. Links to the workforce domain employee master.',
    `reattempted_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (reattempted_training_completion_id)',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: CRITICAL FIX: training_completion.training_program_id currently points to compliance.program.program_id, but it should point to compliance.training.training_id. Training completion records should refe',
    `accreditation_body` STRING COMMENT 'Name of the organization that accredited or approved this training program. Examples include ACCME, ANCC, state boards, or internal compliance committees.',
    `assigned_date` DATE COMMENT 'Date when the training program was assigned to the employee. Marks the start of the compliance obligation period.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this training completion. Increments when an employee retakes a failed training.',
    `certificate_issued_date` DATE COMMENT 'Date when the training certificate was officially issued. May differ from completion date for trainings requiring manual review or approval.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion. Used for external verification and audit documentation.',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training program. Null if training is not yet completed.',
    `completion_number` STRING COMMENT 'Business identifier for this training completion event. May be used for certificate tracking and audit trails.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the training completion record. Tracks progression from assignment through completion or expiration. [ENUM-REF-CANDIDATE: assigned|in_progress|completed|overdue|waived|expired|not_started — 7 candidates stripped; promote to reference product]',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the training was marked complete in the Learning Management System (LMS). Used for audit trail and time-sensitive compliance verification.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Education (CE) or Continuing Medical Education (CME) credits awarded for this training completion. Used for professional licensure maintenance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the data platform. Part of the audit trail.',
    `credit_type` STRING COMMENT 'Type of continuing education credit awarded. CME (Continuing Medical Education) for physicians, CEU (Continuing Education Unit) for general staff, CNE (Continuing Nursing Education) for nurses, or contact hours.. Valid values are `cme|ceu|cne|contact_hours|not_applicable`',
    `due_date` DATE COMMENT 'Date by which the training must be completed to maintain compliance. Used for overdue tracking and escalation.',
    `employee_department` STRING COMMENT 'Department or organizational unit of the employee at the time of training completion. Captured for compliance reporting by department.',
    `employee_facility` STRING COMMENT 'Healthcare facility or location where the employee is assigned. Used for facility-level compliance reporting and Joint Commission readiness.',
    `employee_role` STRING COMMENT 'Job role or title of the employee at the time of training completion. Used for role-based compliance reporting and gap analysis.',
    `escalation_date` DATE COMMENT 'Date when the overdue training was escalated to management. Part of the compliance enforcement audit trail.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this overdue training has been escalated to management or compliance leadership. True if escalated, False otherwise.',
    `expiration_date` DATE COMMENT 'Date when this training completion expires and requires renewal. Null for one-time trainings that do not expire.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the training. Applicable for in-person and instructor-led sessions.',
    `last_reminder_sent_date` DATE COMMENT 'Date when the most recent reminder notification was sent to the employee. Used for escalation timing and communication tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified in the data platform. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this training completion. May include special circumstances, technical issues, or compliance officer annotations.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed or failed the training assessment. Not applicable for trainings without assessments.. Valid values are `pass|fail|not_applicable|pending`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training. Captured at completion time to preserve historical pass/fail criteria.',
    `regulatory_requirement_satisfied` STRING COMMENT 'Citation or reference to the specific regulatory requirement satisfied by this training completion. Examples include HIPAA Privacy Rule, OSHA Bloodborne Pathogens Standard, Joint Commission standards.',
    `reminder_sent_count` BIGINT COMMENT 'Number of reminder notifications sent to the employee for this training assignment. Used for tracking engagement and escalation.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved by the employee on the training assessment. Null if training does not include a scored assessment.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this training completion record in the source system. Used for data lineage and reconciliation.',
    `training_duration_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes the employee spent completing the training. Captured from Learning Management System (LMS) tracking data.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted. May be a facility name, room number, or online platform identifier.',
    `training_method` STRING COMMENT 'Method by which the training was delivered to the employee. Used for effectiveness analysis and compliance documentation.. Valid values are `online|in_person|blended|self_study|webinar|simulation`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance training completion record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `waiver_approval_date` DATE COMMENT 'Date when the training waiver was officially approved. Part of the compliance audit trail.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the training waiver. Required for audit trail when waiver is granted.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the training requirement was waived for this employee. True if waived, False otherwise.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving the training requirement. Required when waiver_flag is True. Subject to compliance review.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Individual employee completion records for compliance training';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` (
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Regulatory submissions with penalties or fees must post to specific GL accounts. Currently has penalty_currency_code but no GL account FK. Enables proper financial recording of regulatory penalties, s',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Regulatory submissions (CMS quality reporting, state claims data, HEDIS) must document which ICD/CPT/HCPCS code set versions were used for the reporting period, required for data validation and audit ',
    `employee_id` BIGINT COMMENT 'Unique identifier for the compliance employee within the compliance compliance regulatory submission record.',
    `compliance_program_id` BIGINT COMMENT 'Identifier of the enterprise compliance program under which this submission is managed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory submissions are prepared by specific departments. The cost of preparation, external consultants, and submission fees should be tracked against the responsible cost center for budget managem',
    `financial_entity_id` BIGINT COMMENT 'Identifier of the healthcare facility, hospital, clinic, or organizational unit that is filing the regulatory submission.',
    `obligation_id` BIGINT COMMENT 'Identifier linking this submission to the specific regulatory requirement or obligation it satisfies.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Many regulatory submissions are payer-specific: CMS cost reports, Medicare Advantage quality reporting (HEDIS/Stars), network adequacy filings, MLR reporting. Tracking which payer each submission rela',
    `primary_compliance_prepared_by_employee_id` BIGINT COMMENT 'Identifier of the employee or staff member who prepared the regulatory submission.',
    `primary_original_submission_compliance_regulatory_submission_id` BIGINT COMMENT 'Identifier of the original submission record if this is a resubmission or correction. Links to the prior submission that was rejected or withdrawn.',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: Many regulatory submissions to CMS, CDC, and state agencies are transmitted via public health reporting interfaces. Linking submissions to their transmission records enables tracking of submission sta',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory submissions may be triggered by new regulatory changes (e.g., new CMS reporting requirement). Each submission should optionally link to the regulatory change that triggered it. This allows ',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the compliance compliance regulatory submission record.',
    `research_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the research regulatory submission within the compliance compliance regulatory submission record.',
    `acceptance_date` DATE COMMENT 'Date on which the receiving agency formally accepted the submission as complete and compliant.',
    `acknowledgment_date` DATE COMMENT 'Date on which the receiving agency acknowledged receipt of the submission.',
    `acknowledgment_number` STRING COMMENT 'Confirmation or tracking number provided by the receiving agency upon acknowledgment of the submission.',
    `acknowledgment_received_flag` BOOLEAN COMMENT 'Indicates whether the receiving agency has acknowledged receipt of the submission. True = acknowledgment received, False = no acknowledgment received.',
    `agency_name` STRING COMMENT 'The agency name of the compliance compliance regulatory submission record.',
    `approval_date` DATE COMMENT 'Date on which the submission was internally approved for filing with the regulatory agency.',
    `attestation_date` DATE COMMENT 'Date on which the authorized officer attested to the accuracy and completeness of the submission.',
    `attestation_officer_name` STRING COMMENT 'Name of the authorized officer (e.g., Chief Executive Officer, Chief Compliance Officer, Chief Medical Officer) who attested to the submission.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether the submission requires a formal attestation or certification by an authorized officer. True = attestation required, False = no attestation required.',
    `audit_date` DATE COMMENT 'Date on which the external audit or validation of the submission was conducted.',
    `audit_result` STRING COMMENT 'Outcome of the external audit or validation. PASSED = submission validated as accurate, FAILED = submission found to be inaccurate or non-compliant, CONDITIONAL = passed with conditions or corrective actions required, PENDING = audit in progress, NOT_AUDITED = no audit conducted.. Valid values are `PASSED|FAILED|CONDITIONAL|PENDING|NOT_AUDITED`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions must be completed and documented in response to audit findings or agency feedback.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required as a result of audit findings or agency feedback. True = corrective action required, False = no corrective action required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory submission record was first created in the system.',
    `document_location_url` STRING COMMENT 'File path, URL, or document management system reference where the submitted regulatory report or supporting documentation is stored.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the submission must be filed to remain compliant.',
    `external_audit_flag` BOOLEAN COMMENT 'Indicates whether this submission is subject to external audit or validation by the regulatory agency or third-party auditor. True = subject to external audit, False = not subject to external audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the compliance compliance regulatory submission record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory submission record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or internal notes related to the regulatory submission, including special circumstances, challenges, or follow-up actions.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by the regulatory agency for late, incomplete, or non-compliant submission, in US dollars.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD for US dollars).. Valid values are `^[A-Z]{3}$`',
    `receiving_agency` STRING COMMENT 'Name of the government agency, accrediting body, or regulatory authority receiving the submission (e.g., CMS, State Department of Health, OSHA, OCR, Joint Commission, CDC).',
    `receiving_agency_code` STRING COMMENT 'Standardized code or abbreviation for the receiving regulatory agency (e.g., CMS, OCR, OSHA, TJC, CDC).',
    `reference_number` STRING COMMENT 'The reference number of the compliance compliance regulatory submission record.',
    `rejection_date` DATE COMMENT 'Date on which the receiving agency rejected the submission due to errors, incompleteness, or non-compliance.',
    `rejection_reason` STRING COMMENT 'Explanation or code provided by the receiving agency describing why the submission was rejected.',
    `reporting_period_end_date` DATE COMMENT 'End date of the time period covered by the regulatory submission.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the time period covered by the regulatory submission (e.g., calendar quarter, fiscal year, annual period).',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the compliance compliance regulatory submission record.',
    `resubmission_required_flag` BOOLEAN COMMENT 'Indicates whether the submission must be corrected and resubmitted. True = resubmission required, False = no resubmission required.',
    `risk_level` STRING COMMENT 'Assessment of the compliance risk associated with this submission, including potential penalties for non-compliance or late filing.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `submission_date` DATE COMMENT 'Date on which the regulatory submission was filed or transmitted to the receiving agency.',
    `submission_domain` STRING COMMENT 'Domain discriminator: COMPLIANCE or RESEARCH',
    `submission_format` STRING COMMENT 'Data format or file type of the regulatory submission. XML = Extensible Markup Language, JSON = JavaScript Object Notation, CSV = comma-separated values, PDF = Portable Document Format, HL7_V2 = Health Level Seven Version 2 message, FHIR = Fast Healthcare Interoperability Resources. [ENUM-REF-CANDIDATE: XML|JSON|CSV|PDF|HL7_V2|FHIR|PAPER|OTHER — 8 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Method or channel used to transmit the regulatory submission. ELECTRONIC_PORTAL = web-based agency portal, EMAIL = email transmission, FAX = facsimile, MAIL = postal mail, API = application programming interface, HL7_INTERFACE = Health Level Seven (HL7) electronic interface, SFTP = secure file transfer protocol. [ENUM-REF-CANDIDATE: ELECTRONIC_PORTAL|EMAIL|FAX|MAIL|API|HL7_INTERFACE|SFTP|OTHER — 8 candidates stripped; promote to reference product]',
    `submission_number` STRING COMMENT 'Business identifier or tracking number assigned to the regulatory submission, often used for external reference and correspondence with regulatory agencies.',
    `submission_priority` STRING COMMENT 'Priority level assigned to the regulatory submission based on urgency, risk, or regulatory importance. CRITICAL = immediate action required, HIGH = high importance, MEDIUM = standard priority, LOW = routine submission.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `submission_scope` STRING COMMENT 'The submission scope of the compliance compliance regulatory submission record.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission. DRAFT = being prepared, PENDING_REVIEW = awaiting internal approval, SUBMITTED = sent to regulatory agency, ACKNOWLEDGED = receipt confirmed by agency, ACCEPTED = approved by agency, REJECTED = not accepted by agency, RESUBMITTED = corrected and resubmitted after rejection, WITHDRAWN = submission cancelled. [ENUM-REF-CANDIDATE: DRAFT|PENDING_REVIEW|SUBMITTED|ACKNOWLEDGED|ACCEPTED|REJECTED|RESUBMITTED|WITHDRAWN — 8 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the regulatory submission was transmitted to the receiving agency, including time zone.',
    `submission_type` STRING COMMENT 'Category of regulatory submission. CMS_IQR = Centers for Medicare and Medicaid Services (CMS) Inpatient Quality Reporting, CMS_OQR = CMS Outpatient Quality Reporting, CMS_IPFQR = CMS Inpatient Psychiatric Facility Quality Reporting, STATE_LICENSURE = State health department facility licensure reports, OSHA_300 = Occupational Safety and Health Administration (OSHA) Log of Work-Related Injuries and Illnesses, OSHA_300A = OSHA Annual Summary, OCR_BREACH = Office for Civil Rights (OCR) breach notification under HIPAA, OIG_SELF_DISCLOSURE = Office of Inspector General (OIG) self-disclosure of potential fraud or abuse, JOINT_COMMISSION_PPR = Joint Commission Periodic Performance Review, CDC_NHSN_HAI = Centers for Disease Control and Prevention (CDC) National Healthcare Safety Network (NHSN) Healthcare-Associated Infection (HAI) reporting. [ENUM-REF-CANDIDATE: CMS_IQR|CMS_OQR|CMS_IPFQR|STATE_LICENSURE|OSHA_300|OSHA_300A|OCR_BREACH|OIG_SELF_DISCLOSURE|JOINT_COMMISSION_PPR|CDC_NHSN_HAI|OTHER — 11 candidates stripped; promote to reference product]',
    `submitting_entity_npi` STRING COMMENT 'Ten-digit National Provider Identifier (NPI) of the submitting healthcare organization, as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance compliance regulatory submission record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_compliance_regulatory_submission PRIMARY KEY(`compliance_regulatory_submission_id`)
) COMMENT 'SSOT resolved: defer to research.research_regulatory_submission as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` (
    `exclusion_screening_id` BIGINT COMMENT 'Unique identifier for the exclusion screening record.',
    `compliance_program_id` BIGINT COMMENT 'Reference to the compliance program under which this screening was performed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Screening programs are operated by compliance departments with associated costs (vendor fees, staff time). These costs must be allocated to the responsible cost center for budget tracking, vendor spen',
    `employee_id` BIGINT COMMENT 'Reference to the individual being screened (employee, contractor, or medical staff member).',
    `prior_exclusion_screening_id` BIGINT COMMENT 'Self-referencing FK on exclusion_screening (prior_exclusion_screening_id)',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Exclusion screening validates NPIs against the national registry to ensure screened providers are correctly identified (name, address, taxonomy) before checking OIG/SAM exclusion databases for complia',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Healthcare organizations must screen payers and health plans for OIG/SAM exclusions to ensure they are not contracting with excluded entities. This is a regulatory requirement for federal program part',
    `audit_trail` STRING COMMENT 'Comprehensive audit trail documenting all actions, reviews, and decisions related to this screening record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exclusion screening record was first created in the system.',
    `exclusion_authority` STRING COMMENT 'Government agency or authority that imposed the exclusion (e.g., OIG, GSA, State Medicaid).',
    `exclusion_date` DATE COMMENT 'Date when the exclusion was imposed by the regulatory authority.',
    `exclusion_type` STRING COMMENT 'Type or category of exclusion found (e.g., mandatory, permissive, conviction-related, license revocation).',
    `exclusion_waiver_state` STRING COMMENT 'Two-letter state code where a waiver from the exclusion may apply, if applicable.. Valid values are `^[A-Z]{2}$`',
    `match_confidence_level` STRING COMMENT 'Confidence level of the match found during screening (high, medium, or low) based on data quality and matching criteria.. Valid values are `high|medium|low`',
    `match_details` STRING COMMENT 'Detailed information about the exclusion match found, including name matched, identifier matched, and exclusion reason.',
    `match_found_flag` BOOLEAN COMMENT 'Boolean indicator of whether a match was found on any exclusion list during screening.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the exclusion screening record was last modified or updated.',
    `next_screening_date` DATE COMMENT 'Scheduled date for the next exclusion screening check for this individual or entity.',
    `notification_sent_date` DATE COMMENT 'Date when notification about the screening result was sent to relevant stakeholders.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether notification was sent to relevant stakeholders about the screening result.',
    `reinstatement_date` DATE COMMENT 'Date when the excluded individual or entity is eligible for reinstatement to federal healthcare programs.',
    `resolution_action` STRING COMMENT 'Action taken in response to the screening result (e.g., employment terminated, contract cancelled, credentialing denied, further investigation required).',
    `resolution_date` DATE COMMENT 'Date when the screening result was resolved and final action was taken.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, investigation findings, and rationale for action taken.',
    `resolution_status` STRING COMMENT 'Current status of the resolution process for the screening result (pending review, cleared, confirmed exclusion, action taken, or escalated).. Valid values are `pending_review|cleared|confirmed_exclusion|action_taken|escalated`',
    `risk_level` STRING COMMENT 'Risk level assigned to this screening result based on entity type, role, and match findings.. Valid values are `critical|high|medium|low`',
    `screened_business_name` STRING COMMENT 'Legal business name of the vendor or organization being screened.',
    `screened_date_of_birth` DATE COMMENT 'Date of birth of the individual being screened, used for identity verification and matching.',
    `screened_entity_type` STRING COMMENT 'Type of entity being screened for exclusion status (employee, contractor, vendor, medical staff, volunteer, or board member).. Valid values are `employee|contractor|vendor|medical_staff|volunteer|board_member`',
    `screened_first_name` STRING COMMENT 'First name of the individual being screened for exclusion status.',
    `screened_last_name` STRING COMMENT 'Last name of the individual being screened for exclusion status.',
    `screened_middle_name` STRING COMMENT 'Middle name or initial of the individual being screened.',
    `screened_ssn` STRING COMMENT 'Social Security Number of the individual being screened, used for matching against exclusion lists.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `screened_state` STRING COMMENT 'Two-letter state code where the screened individual or business is located or licensed.. Valid values are `^[A-Z]{2}$`',
    `screening_date` DATE COMMENT 'Date when the exclusion screening check was performed.',
    `screening_frequency_months` STRING COMMENT 'Number of months between required exclusion screening checks for this entity type.',
    `screening_method` STRING COMMENT 'Method used to perform the exclusion screening (automated system, manual search, or third-party vendor service).. Valid values are `automated|manual|vendor_service`',
    `screening_result` STRING COMMENT 'Outcome of the exclusion screening check indicating whether the entity is clear, a match was found, result is inconclusive, or an error occurred.. Valid values are `clear|match_found|inconclusive|error`',
    `screening_source` STRING COMMENT 'Source database used for the exclusion screening check (OIG LEIE, SAM.gov, state Medicaid exclusion list, or combined search).. Valid values are `oig_leie|sam_gov|state_medicaid|combined`',
    `screening_transaction_number` STRING COMMENT 'Unique transaction identifier from the screening vendor or system for audit trail purposes.',
    `screening_vendor_name` STRING COMMENT 'Name of the third-party vendor or service used to perform the exclusion screening, if applicable.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance exclusion screening record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_exclusion_screening PRIMARY KEY(`exclusion_screening_id`)
) COMMENT 'Screening of employees and providers against federal and state exclusion lists';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` (
    `conflict_of_interest_id` BIGINT COMMENT 'Unique identifier for the conflict of interest disclosure record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location where the disclosing individual is primarily assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee, medical staff member, board member, or contractor submitting the disclosure.',
    `prior_conflict_of_interest_id` BIGINT COMMENT 'Self-referencing FK on conflict_of_interest (prior_conflict_of_interest_id)',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer or committee member who reviewed the disclosure.',
    `approval_authority` STRING COMMENT 'The role or body that has authority to approve or reject the disclosure: compliance officer, ethics committee, chief compliance officer, board of directors, or department head.. Valid values are `compliance_officer|ethics_committee|chief_compliance_officer|board_of_directors|department_head`',
    `approval_date` DATE COMMENT 'Date when the disclosure was formally approved by the designated authority.',
    `attestation_date` DATE COMMENT 'Date when the disclosing individual signed the attestation affirming the disclosure.',
    `attestation_statement` STRING COMMENT 'Text of the attestation statement signed by the disclosing individual affirming the accuracy and completeness of the disclosure.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing key events, decisions, and communications throughout the disclosure lifecycle for audit and compliance tracking purposes.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the disclosure record: restricted (highest sensitivity), confidential (business-sensitive), or internal (standard operational data).. Valid values are `restricted|confidential|internal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the conflict of interest disclosure record was first created in the system.',
    `department_name` STRING COMMENT 'Name of the department or division where the disclosing individual works or is affiliated.',
    `disclosed_entity_name` STRING COMMENT 'Name of the external organization, vendor, research sponsor, or individual with whom the conflict of interest relationship exists.',
    `disclosed_entity_type` STRING COMMENT 'Classification of the disclosed entity: vendor, supplier, competitor, research sponsor, pharmaceutical company, device manufacturer, consulting firm, healthcare provider, or other. [ENUM-REF-CANDIDATE: vendor|supplier|competitor|research_sponsor|pharmaceutical_company|device_manufacturer|consulting_firm|healthcare_provider|other — 9 candidates stripped; promote to reference product]',
    `disclosing_individual_role` STRING COMMENT 'Role or affiliation of the individual submitting the disclosure: employee, medical staff, board member, contractor, volunteer, or vendor representative.. Valid values are `employee|medical_staff|board_member|contractor|volunteer|vendor_representative`',
    `disclosure_date` DATE COMMENT 'Date when the conflict of interest disclosure was submitted by the individual.',
    `disclosure_number` STRING COMMENT 'Externally-known unique business identifier for the conflict of interest disclosure.. Valid values are `^COI-[0-9]{8}$`',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the conflict of interest disclosure: submitted, under review by compliance, approved without conditions, approved with mitigation plan, rejected, or withdrawn by disclosing individual.. Valid values are `submitted|under_review|approved|approved_with_mitigation|rejected|withdrawn`',
    `disclosure_type` STRING COMMENT 'Type of disclosure submission: initial disclosure, annual recertification, material change update, or ad-hoc disclosure.. Valid values are `initial|annual_recertification|material_change|ad_hoc`',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the financial interest or relationship in US dollars.',
    `expiration_date` DATE COMMENT 'Date when the disclosed relationship or financial interest is expected to end or when the disclosure record expires and requires renewal.',
    `last_recertification_date` DATE COMMENT 'Date of the most recent annual recertification submission for this conflict of interest.',
    `mitigation_effective_date` DATE COMMENT 'Date when the mitigation plan became effective and enforceable.',
    `mitigation_plan` STRING COMMENT 'Detailed description of the mitigation actions, controls, or restrictions put in place to manage the conflict of interest, such as recusal from decisions, disclosure to stakeholders, or divestiture.',
    `mitigation_required_flag` BOOLEAN COMMENT 'Indicates whether a mitigation plan is required to manage the conflict of interest (True) or not (False).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the conflict of interest disclosure record was last modified or updated.',
    `recertification_due_date` DATE COMMENT 'Date by which the individual must submit an annual recertification or update of the conflict of interest disclosure.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement or compliance program element that mandates this disclosure, such as Stark Law, Anti-Kickback Statute, or OIG guidance.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the compliance authority for rejecting the disclosure or determining that the conflict cannot be adequately mitigated.',
    `relationship_description` STRING COMMENT 'Detailed narrative description of the nature of the conflict of interest relationship, including roles, responsibilities, and interactions.',
    `relationship_type` STRING COMMENT 'Category of the conflict of interest relationship being disclosed: financial interest, outside employment, family relationship with vendor or employee, vendor relationship, research sponsorship, or consulting arrangement.. Valid values are `financial_interest|outside_employment|family_relationship|vendor_relationship|research_sponsorship|consulting_arrangement`',
    `review_completion_date` DATE COMMENT 'Date when the compliance review of the disclosure was completed and a determination was made.',
    `review_start_date` DATE COMMENT 'Date when the compliance review of the disclosure began.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to supporting documentation provided with the disclosure, such as contracts, financial statements, or correspondence.',
    `value_range` STRING COMMENT 'Categorical range of the estimated value: under $5,000, $5,000 to $25,000, $25,000 to $100,000, over $100,000, or not applicable for non-financial relationships.. Valid values are `under_5000|5000_to_25000|25000_to_100000|over_100000|not_applicable`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance conflict of interest record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_conflict_of_interest PRIMARY KEY(`conflict_of_interest_id`)
) COMMENT 'Conflict of interest disclosures and management';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` (
    `hotline_report_id` BIGINT COMMENT 'Unique identifier for the compliance hotline report. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the alleged incident occurred or is relevant.',
    `original_hotline_report_id` BIGINT COMMENT 'Self-referencing FK on hotline_report (original_hotline_report_id)',
    `employee_id` BIGINT COMMENT 'Employee identifier of the reporter if they are an internal employee. Null if external reporter or anonymous.',
    `tertiary_hotline_employee_id` BIGINT COMMENT 'Employee identifier of the compliance officer or investigator assigned to review and investigate this report.',
    `allegation_category` STRING COMMENT 'Primary category of the compliance concern or ethics violation alleged: billing fraud, privacy violation, workplace safety, abuse/neglect, conflict of interest, retaliation, or code of conduct violation. [ENUM-REF-CANDIDATE: billing_fraud|privacy_violation|workplace_safety|abuse_neglect|conflict_of_interest|retaliation|code_of_conduct|discrimination|harassment|data_breach|regulatory_violation|quality_of_care|environmental_safety — promote to reference product]. Valid values are `billing_fraud|privacy_violation|workplace_safety|abuse_neglect|conflict_of_interest|retaliation`',
    `allegation_description` STRING COMMENT 'Detailed narrative description of the compliance concern, potential violation, or ethics issue as reported by the submitter.',
    `allegation_subcategory` STRING COMMENT 'More specific classification of the allegation within the primary category, providing additional detail on the nature of the concern.',
    `assigned_investigator_name` STRING COMMENT 'Name of the compliance officer or investigator assigned to this case.',
    `case_notes` STRING COMMENT 'Internal notes and documentation maintained by the compliance team throughout the investigation lifecycle.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and confidentiality requirements for this hotline report and investigation materials.. Valid values are `highly_confidential|confidential|internal|restricted`',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when all required corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions taken or planned in response to substantiated compliance concerns.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required as a result of the investigation findings. True if action required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this hotline report record was first created in the compliance management system.',
    `department_implicated` STRING COMMENT 'Name or code of the department or unit where the alleged compliance concern occurred.',
    `disposition` STRING COMMENT 'Final determination of the investigation: substantiated (violation confirmed), unsubstantiated (no violation found), inconclusive (insufficient evidence), or pending (investigation ongoing).. Valid values are `substantiated|unsubstantiated|inconclusive|pending`',
    `disposition_notes` STRING COMMENT 'Detailed explanation of the investigation findings, rationale for the disposition, and any supporting evidence or context.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up communication with the reporter or additional investigation activities.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up with the reporter or further investigation is required. True if follow-up needed, False otherwise.',
    `incident_date` DATE COMMENT 'Date when the alleged incident or compliance violation occurred, as reported or estimated.',
    `incident_date_range_end` DATE COMMENT 'End date of the period during which the alleged incident occurred, if the incident spanned multiple dates.',
    `incident_date_range_start` DATE COMMENT 'Start date of the period during which the alleged incident occurred, if the incident spanned multiple dates.',
    `individual_implicated_name` STRING COMMENT 'Name of the individual(s) allegedly involved in the compliance concern, if identified in the report.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was completed and findings were documented.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation into the reported concern was initiated.',
    `investigation_status` STRING COMMENT 'Current status of the investigation into the reported compliance concern: new, assigned, in progress, pending additional information, completed, or closed.. Valid values are `new|assigned|in_progress|pending_info|completed|closed`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this hotline report record was last updated or modified.',
    `priority_level` STRING COMMENT 'Priority assigned to the investigation and resolution of this report: urgent, high, normal, or low.. Valid values are `urgent|high|normal|low`',
    `regulatory_authority_notified` STRING COMMENT 'Name of the external regulatory authority or governing body that was notified of the substantiated violation (e.g., CMS, OIG, OCR, state health department).',
    `regulatory_notification_date` DATE COMMENT 'Date when the external regulatory authority was formally notified of the substantiated violation.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the substantiated violation requires mandatory reporting to external regulatory authorities (CMS, OIG, state health department, etc.). True if external reporting required, False otherwise.',
    `report_channel` STRING COMMENT 'Method through which the compliance concern was reported: hotline, online portal, direct report to compliance officer, email, mail, or in-person.. Valid values are `hotline|online_portal|direct_report|email|mail|in_person`',
    `report_date` DATE COMMENT 'Date when the compliance concern or ethics report was submitted through the hotline or reporting system.',
    `report_number` STRING COMMENT 'Business identifier for the hotline report, formatted as HR- followed by 8 digits. Used for external reference and tracking.. Valid values are `^HR-[0-9]{8}$`',
    `report_timestamp` TIMESTAMP COMMENT 'Precise date and time when the report was received by the compliance system.',
    `reporter_anonymity_flag` BOOLEAN COMMENT 'Indicates whether the reporter chose to remain anonymous. True if anonymous, False if reporter provided identity.',
    `reporter_contact_email` STRING COMMENT 'Email address of the reporter for follow-up communication, if provided. Null if anonymous or not provided.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reporter_contact_phone` STRING COMMENT 'Phone number of the reporter for follow-up, if provided. Null if anonymous or not provided.',
    `reporter_name` STRING COMMENT 'Name of the individual who submitted the report, if not anonymous. Null if reporter chose anonymity.',
    `resolution_date` DATE COMMENT 'Date when the hotline report was formally closed and all required actions were completed.',
    `retaliation_concern_flag` BOOLEAN COMMENT 'Indicates whether the reporter expressed concern about potential retaliation for making the report. True if retaliation concern noted, False otherwise.',
    `severity_level` STRING COMMENT 'Initial assessment of the severity or potential impact of the alleged compliance concern: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance hotline report record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_hotline_report PRIMARY KEY(`hotline_report_id`)
) COMMENT 'Reports submitted through compliance hotline or reporting mechanisms';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Unique identifier for the compliance investigation record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Investigation can be triggered by audit_finding. When trigger_source=audit_finding, the investigation should have a structured FK to audit_finding. This is in addition to the hotline_report_id FK - ',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location where the alleged violation occurred, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Investigations consume departmental resources. Investigation costs (staff time, legal fees, consultant fees) must be tracked against the responsible departments cost center for budget management, cos',
    `hotline_report_id` BIGINT COMMENT 'Foreign key linking to compliance.hotline_report. Business justification: Investigation can be triggered by hotline_report. The trigger_reference_number (STRING) should be replaced with a structured FK hotline_report_id when trigger_source=hotline. This creates a clear au',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this investigation record. Used for audit trail and accountability.',
    `investigation_investigator_employee_id` BIGINT COMMENT 'Identifier of the primary compliance officer or investigator assigned to lead this investigation.',
    `parent_investigation_id` BIGINT COMMENT 'Self-referencing FK on investigation (related_investigation_id)',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Investigations into unauthorized PHI access require direct linkage to the access log entries being investigated for evidence chain, timeline reconstruction, and disciplinary action documentation.',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_incident. Business justification: Investigation can be triggered by HIPAA privacy incident. When trigger_source=privacy_incident, the investigation should have a structured FK to hipaa_privacy_incident. This completes the set of tri',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicator of whether the investigation findings triggered mandatory breach notification to patients, HHS OCR, or media under HIPAA Breach Notification Rule. True indicates notification obligation exists.',
    `close_date` DATE COMMENT 'Date on which the investigation was formally concluded and final determination documented. Null for open investigations.',
    `conclusion` STRING COMMENT 'Final determination of the investigation outcome. Violation confirmed indicates substantiated compliance breach. No violation indicates allegation not supported by evidence. Inconclusive indicates insufficient evidence to make determination. Pending review indicates investigation complete but awaiting final approval or legal review.. Valid values are `violation_confirmed|no_violation|inconclusive|pending_review`',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access to and disclosure of investigation records. Restricted indicates highest sensitivity requiring need-to-know access. Confidential indicates limited distribution. Internal indicates organization-wide access. Public indicates no restriction.. Valid values are `public|internal|confidential|restricted`',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicator of whether the investigation findings require formal corrective action plan. True indicates CAP must be developed, approved, and tracked to completion.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this investigation record was first created in the compliance management system. Used for audit trail and data lineage.',
    `department_involved` STRING COMMENT 'Primary department or business unit where the alleged violation occurred or that is the subject of the investigation.',
    `disciplinary_action_taken_flag` BOOLEAN COMMENT 'Indicator of whether employee disciplinary action was taken as a result of investigation findings, including counseling, suspension, termination, or other personnel action.',
    `external_referral_agency` STRING COMMENT 'Name of external regulatory, law enforcement, or oversight agency to which the investigation was referred, such as HHS OIG, DOJ, FBI, OCR, state attorney general, or state health department.',
    `external_referral_date` DATE COMMENT 'Date on which the investigation was formally referred to external authority. Null if no external referral made.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or calculated financial impact of the violation in US dollars, including overpayments, penalties, refunds, or potential liability exposure. Used for self-disclosure calculations and reserve estimation.',
    `findings_summary` STRING COMMENT 'Comprehensive narrative summary of the investigation findings, including evidence reviewed, interviews conducted, timeline of events, root cause analysis, and factual determinations. This field supports legal privilege and compliance program documentation.',
    `investigation_number` STRING COMMENT 'Business-facing unique investigation case number assigned at initiation, formatted as INV-YYYYNNNN for tracking and reference in compliance documentation and legal proceedings.. Valid values are `^INV-[0-9]{8}$`',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation. Initiated indicates case opened but not yet assigned. Active indicates investigation in progress. Suspended indicates temporarily paused pending additional information. Closed indicates investigation concluded. Escalated indicates elevated to senior leadership or legal counsel. Referred external indicates case transferred to external authority such as OIG, OCR, or law enforcement.. Valid values are `initiated|active|suspended|closed|escalated|referred_external`',
    `investigation_type` STRING COMMENT 'Classification of the investigation based on the nature of the alleged compliance violation. Privacy breach covers HIPAA violations and unauthorized PHI disclosure. Billing fraud includes upcoding, unbundling, and false claims. Workplace safety covers OSHA violations. Abuse/neglect includes patient harm and mistreatment. Anti-kickback covers illegal remuneration. Stark violation covers physician self-referral violations.. Valid values are `privacy_breach|billing_fraud|workplace_safety|abuse_neglect|anti_kickback|stark_violation`',
    `investigator_name` STRING COMMENT 'Full name of the primary investigator assigned to this case for business reporting and audit trail purposes.',
    `legal_privilege_asserted_flag` BOOLEAN COMMENT 'Indicator of whether attorney-client privilege or attorney work product privilege has been asserted over investigation materials. True indicates privileged status requiring special handling and access controls.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this investigation record. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for investigator notes, observations, and supplementary information not captured in structured fields. May include interview summaries, document references, and investigative leads.',
    `patient_count` STRING COMMENT 'Number of distinct patients affected by or involved in the alleged violation. Used to assess breach notification requirements under HIPAA and scope of potential harm.',
    `patient_involved_flag` BOOLEAN COMMENT 'Indicator of whether the investigation involves a specific patient or patient PHI. True indicates patient-specific investigation requiring additional privacy protections and breach notification assessment.',
    `priority_level` STRING COMMENT 'Urgency classification of the investigation based on severity of alleged violation, potential financial impact, patient safety risk, and regulatory exposure. Critical indicates immediate patient safety or significant regulatory risk. High indicates substantial compliance risk. Medium indicates moderate risk. Low indicates minor or technical violation.. Valid values are `critical|high|medium|low`',
    `recommended_actions` STRING COMMENT 'Detailed recommendations for corrective and preventive actions resulting from investigation findings, including policy revisions, training requirements, system controls, disciplinary actions, and process improvements.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory statute, rule, or standard that was violated, including citation reference such as HIPAA 45 CFR 164.502, False Claims Act 31 USC 3729, Stark Law 42 USC 1395nn, Anti-Kickback Statute 42 USC 1320a-7b, or OSHA standard number.',
    `risk_rating` STRING COMMENT 'Assessment of the potential organizational risk exposure associated with the alleged violation, considering financial, reputational, regulatory, and patient safety dimensions.. Valid values are `extreme|high|moderate|low|minimal`',
    `scope_description` STRING COMMENT 'Detailed narrative describing the boundaries and focus of the investigation, including specific allegations, time period under review, departments or individuals involved, and types of evidence to be examined.',
    `self_disclosure_date` DATE COMMENT 'Date on which voluntary self-disclosure was submitted to the applicable regulatory authority. Null if no disclosure required or not yet submitted.',
    `self_disclosure_required_flag` BOOLEAN COMMENT 'Indicator of whether the investigation findings require voluntary self-disclosure to regulatory authority such as OIG, CMS, or OCR under self-disclosure protocols. True indicates disclosure obligation exists.',
    `start_date` DATE COMMENT 'Date on which the formal investigation was officially opened and investigative activities commenced. Used to track timeliness of investigation response and compliance with regulatory reporting deadlines.',
    `target_due_date` DATE COMMENT 'Target completion date for the investigation based on regulatory timelines, internal SLA, or urgency classification. Used to monitor investigation timeliness and escalate overdue cases.',
    `trigger_source` STRING COMMENT 'Origin or channel through which the investigation was initiated. Hotline report indicates anonymous or named report through compliance hotline. Audit finding indicates discovery during internal or external audit. Self-disclosure indicates proactive identification by organization. External referral indicates notification from regulatory body, payer, or law enforcement. Patient complaint indicates grievance filed by patient or family. Employee report indicates direct report from staff member. Regulatory inquiry indicates investigation prompted by CMS, OCR, or state agency request. [ENUM-REF-CANDIDATE: hotline_report|audit_finding|self_disclosure|external_referral|patient_complaint|employee_report|regulatory_inquiry — 7 candidates stripped; promote to reference product]',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance investigation record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `violation_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the investigation substantiated a compliance violation. True indicates confirmed violation requiring corrective action and potential self-disclosure.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Compliance investigations of reported incidents and allegations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` (
    `stark_arrangement_id` BIGINT COMMENT 'Unique identifier for the Stark Law financial arrangement record. Primary key for the stark_arrangement product.',
    `clinician_id` BIGINT COMMENT 'Identifier for the physician party to the financial arrangement. Links to the provider master record.',
    `financial_entity_id` BIGINT COMMENT 'Identifier for the healthcare entity party to the financial arrangement. Links to the facility or organizational unit master record.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Stark law compliance requires validating physician NPI details, taxonomy codes, and practice locations against the national registry for arrangement documentation, disclosure, and annual attestation p',
    `renewed_stark_arrangement_id` BIGINT COMMENT 'Self-referencing FK on stark_arrangement (renewed_stark_arrangement_id)',
    `arrangement_number` STRING COMMENT 'Business-assigned unique identifier or reference number for the Stark arrangement, used for tracking and reporting purposes.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the Stark arrangement indicating whether it is in force, under compliance review, or has ended.. Valid values are `active|expired|under_review|pending_approval|terminated|suspended`',
    `arrangement_type` STRING COMMENT 'Classification of the financial arrangement between the physician and entity. Determines which Stark exception may apply. [ENUM-REF-CANDIDATE: employment|personal_services|fair_market_value_lease|equipment_lease|recruitment|indirect_compensation|space_rental|medical_director|call_coverage|academic_medical_center|other — 11 candidates stripped; promote to reference product]',
    `commercial_reasonableness_determination` STRING COMMENT 'Assessment of whether the arrangement is commercially reasonable and would make sense even in the absence of referrals between the parties.. Valid values are `reasonable|not_reasonable|under_review|not_assessed`',
    `commercial_reasonableness_rationale` STRING COMMENT 'Business justification and rationale supporting the commercial reasonableness determination.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Total annual or per-period compensation amount paid to the physician under the arrangement, in US dollars.',
    `compensation_frequency` STRING COMMENT 'Frequency at which compensation is paid to the physician under the arrangement.. Valid values are `annual|monthly|biweekly|weekly|per_service|one_time`',
    `compensation_structure` STRING COMMENT 'Method by which the physician is compensated under the arrangement. Critical for determining compliance with volume or value of referrals standards. [ENUM-REF-CANDIDATE: fixed_salary|hourly_rate|per_service|percentage_of_revenue|productivity_based|hybrid|other — 7 candidates stripped; promote to reference product]',
    `contract_document_location` STRING COMMENT 'File path, URL, or document management system reference to the executed contract or agreement governing the arrangement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the Stark arrangement record was first created in the compliance management system.',
    `designated_health_services_involved` STRING COMMENT 'List of designated health services (clinical lab, radiology, DME, etc.) to which the physician may refer under this arrangement, triggering Stark Law applicability.',
    `disclosure_date` DATE COMMENT 'Date on which the arrangement was disclosed to CMS under the Self-Referral Disclosure Protocol, if applicable.',
    `disclosure_reference_number` STRING COMMENT 'CMS-assigned reference number for the self-referral disclosure submission, if applicable.',
    `disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether the arrangement must be disclosed to CMS under the Self-Referral Disclosure Protocol due to potential non-compliance.',
    `effective_date` DATE COMMENT 'Date on which the Stark arrangement becomes legally binding and active.',
    `exception_criteria_met` STRING COMMENT 'Detailed documentation of how the arrangement satisfies all required elements of the claimed Stark exception.',
    `expiration_date` DATE COMMENT 'Date on which the Stark arrangement terminates or expires. Nullable for open-ended arrangements.',
    `fmv_compliant_flag` BOOLEAN COMMENT 'Indicates whether the compensation has been determined to be consistent with fair market value based on the valuation performed.',
    `fmv_determination_method` STRING COMMENT 'Methodology used to establish that the compensation is consistent with fair market value and not determined in a manner that takes into account the volume or value of referrals.. Valid values are `independent_valuation|survey_data|internal_analysis|comparable_arrangements|other`',
    `fmv_opinion_date` DATE COMMENT 'Date on which the FMV opinion or valuation was issued.',
    `fmv_opinion_source` STRING COMMENT 'Name of the independent valuation firm, consultant, or survey source that provided the FMV opinion or benchmark data.',
    `legal_approval_status` STRING COMMENT 'Outcome of the legal compliance review indicating whether the arrangement has been approved as Stark-compliant.. Valid values are `approved|conditional_approval|not_approved|pending_review`',
    `legal_review_date` DATE COMMENT 'Date on which the arrangement was last reviewed by legal counsel or compliance department for Stark Law compliance.',
    `legal_reviewer_name` STRING COMMENT 'Name of the attorney or compliance officer who conducted the Stark Law compliance review.',
    `modified_by` STRING COMMENT 'User ID or name of the compliance staff member who last modified the Stark arrangement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the Stark arrangement record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic compliance review of the Stark arrangement.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special considerations related to the Stark arrangement and its compliance status.',
    `referral_volume_tracking_required` BOOLEAN COMMENT 'Indicates whether ongoing monitoring of referral volume and value is required to ensure continued compliance with the exception.',
    `review_frequency_months` STRING COMMENT 'Number of months between required compliance reviews of the arrangement.',
    `risk_rating` STRING COMMENT 'Compliance risk assessment level for the arrangement based on structure, compensation method, and exception applicability.. Valid values are `low|medium|high|critical`',
    `stark_exception_applied` STRING COMMENT 'Specific Stark Law exception (by CFR citation or common name) that the arrangement relies upon for compliance, such as employment exception, personal services exception, or fair market value compensation exception.',
    `termination_date` DATE COMMENT 'Actual date on which the arrangement was terminated prior to the scheduled expiration date, if applicable.',
    `termination_reason` STRING COMMENT 'Business or compliance reason for early termination of the Stark arrangement.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance stark arrangement record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `created_by` STRING COMMENT 'User ID or name of the compliance staff member who created the Stark arrangement record.',
    CONSTRAINT pk_stark_arrangement PRIMARY KEY(`stark_arrangement_id`)
) COMMENT 'Physician financial arrangements subject to Stark Law review';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` (
    `osha_safety_program_id` BIGINT COMMENT 'Unique identifier for the OSHA safety program record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safety programs are owned by specific departments (typically EHS or Risk Management) and require budget allocation for implementation, training, and equipment. Cost center link enables budget tracking',
    `parent_osha_safety_program_id` BIGINT COMMENT 'Self-referencing FK on osha_safety_program (parent_osha_safety_program_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the employee designated as the program owner or coordinator responsible for program implementation and compliance.',
    `training_id` BIGINT COMMENT 'Identifier of the training course associated with this safety program, linking to the learning management system.',
    `approval_authority` STRING COMMENT 'The role or title of the individual or committee authorized to approve the safety program (e.g., Chief Medical Officer, Safety Committee, Board of Directors).',
    `approval_date` DATE COMMENT 'The date when the safety program was formally approved by the designated authority.',
    `attestation_frequency_months` STRING COMMENT 'The frequency in months at which attestation must be completed for this safety program. Null if attestation is one-time or not required.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether employees or managers must formally attest to compliance with this safety program (True) or not (False).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required to address deficiencies identified in the most recent audit (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this safety program record was first created in the system.',
    `document_location_url` STRING COMMENT 'The URL or file path where the official safety program document is stored and accessible to authorized personnel.',
    `effective_date` DATE COMMENT 'The date when the safety program became or will become operational and enforceable within the organization.',
    `enforcement_mechanism` STRING COMMENT 'Description of how compliance with this safety program is monitored and enforced (e.g., audits, inspections, incident investigations, self-assessments).',
    `expiration_date` DATE COMMENT 'The date when the safety program is scheduled to expire or be retired, if applicable. Null for ongoing programs.',
    `external_audit_scope_flag` BOOLEAN COMMENT 'Indicates whether this safety program is within the scope of external regulatory audits or inspections (True) or only subject to internal review (False).',
    `finding_count` STRING COMMENT 'The number of audit findings or deficiencies identified during the most recent audit of this safety program.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for search and categorization of the safety program (e.g., PPE, exposure, hazmat, ergonomics).',
    `last_audit_date` DATE COMMENT 'The most recent date when an internal or external audit was conducted to assess compliance with this safety program.',
    `last_audit_result` STRING COMMENT 'The outcome of the most recent audit of this safety program, indicating the level of compliance found.. Valid values are `compliant|non_compliant|partially_compliant|not_audited`',
    `last_review_date` DATE COMMENT 'The most recent date when the safety program was formally reviewed for compliance, effectiveness, and currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this safety program record was last modified in the system.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of the safety program to ensure ongoing compliance and relevance.',
    `non_compliance_consequence` STRING COMMENT 'Description of the consequences for non-compliance with this safety program, including disciplinary actions, corrective measures, or regulatory penalties.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the safety program that do not fit in other structured fields.',
    `osha_standard_citation` STRING COMMENT 'The specific OSHA regulatory citation (e.g., 29 CFR 1910.1030 for Bloodborne Pathogens) that mandates or guides this safety program.',
    `program_name` STRING COMMENT 'Official name of the OSHA safety program (e.g., Bloodborne Pathogens Exposure Control Plan, Hazard Communication Program, Respiratory Protection Program).',
    `program_number` STRING COMMENT 'Business identifier for the safety program, used for external reference and reporting to regulatory authorities.',
    `program_owner_department` STRING COMMENT 'The department responsible for maintaining and overseeing the safety program (e.g., Environmental Health and Safety, Infection Control, Facilities Management).',
    `program_purpose` STRING COMMENT 'Detailed statement of the business and regulatory purpose of the safety program, including the hazards or risks it addresses.',
    `program_scope` STRING COMMENT 'Description of the organizational scope and applicability of the safety program, including which facilities, departments, or employee groups are covered.',
    `program_status` STRING COMMENT 'Current lifecycle status of the safety program indicating whether it is operational, under revision, or retired.. Valid values are `active|under_review|suspended|retired|draft|pending_approval`',
    `program_summary` STRING COMMENT 'A brief summary of the safety programs purpose, key requirements, and objectives.',
    `program_type` STRING COMMENT 'Classification of the safety program based on OSHA-mandated or voluntary program categories.. Valid values are `bloodborne_pathogens|hazard_communication|respiratory_protection|ergonomics|workplace_violence|emergency_action`',
    `related_policy_references` STRING COMMENT 'Comma-separated list of related organizational policy numbers or identifiers that support or are supported by this safety program.',
    `related_procedure_references` STRING COMMENT 'Comma-separated list of related procedure identifiers or standard operating procedures (SOPs) that implement this safety program.',
    `retired_reason` STRING COMMENT 'Explanation of why the safety program was retired (e.g., regulatory change, program consolidation, no longer applicable).',
    `retired_timestamp` TIMESTAMP COMMENT 'The timestamp when this safety program was retired or deactivated. Null if the program is still active.',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which the safety program must be reviewed (e.g., 12 for annual review, 24 for biennial review).',
    `risk_rating` STRING COMMENT 'The assessed risk level associated with non-compliance or failure of this safety program, used for prioritization and resource allocation.. Valid values are `critical|high|medium|low`',
    `supersedes_program_number` STRING COMMENT 'The program number of the previous version of this safety program that this version replaces, if applicable.',
    `training_frequency_months` STRING COMMENT 'The frequency in months at which employees must complete training for this safety program (e.g., 12 for annual training). Null if training is one-time or not required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether employee training is required as part of this safety program (True) or not (False).',
    `version_number` STRING COMMENT 'The version identifier of the safety program document, used to track revisions and updates over time.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance osha safety program record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_osha_safety_program PRIMARY KEY(`osha_safety_program_id`)
) COMMENT 'OSHA workplace safety programs and compliance initiatives';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` (
    `osha_exposure_incident_id` BIGINT COMMENT 'Unique identifier for the occupational exposure incident record. Primary key for the OSHA exposure incident entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the exposure incident occurred. Required for multi-facility OSHA reporting and facility-level safety benchmarking.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who was the source of the exposure, if applicable. Required for source patient testing and post-exposure prophylaxis decision-making.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Exposure incidents involving post-exposure prophylaxis (PEP) or vaccines must document the specific NDC codes administered for workers compensation claims, OSHA recordkeeping, and pharmacy billing re',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: OSHA exposure incidents are tracked under specific OSHA safety programs (e.g., Bloodborne Pathogen Exposure Control Plan). Each incident should link to the safety program it falls under for aggregatio',
    `parent_osha_exposure_incident_id` BIGINT COMMENT 'Self-referencing FK on osha_exposure_incident (related_osha_exposure_incident_id)',
    `employee_id` BIGINT COMMENT 'Reference to the healthcare worker who experienced the occupational exposure incident.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Sharps injuries and exposure incidents often occur during specific surgical or invasive procedures. Root cause analysis and OSHA reporting require linking exposure incidents to the procedural context ',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Exposure incidents often occur during scheduled patient encounters providing context for root cause analysis, procedure identification, and prevention planning. Real incident investigation requirement',
    `tertiary_osha_employee_id` BIGINT COMMENT 'Reference to the employee health or safety officer responsible for investigating the exposure incident and completing required documentation.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Exposure incidents generate invoices for post-exposure prophylaxis, laboratory testing, medical treatment, and workers compensation costs. This link enables incident cost tracking, workers comp clai',
    `baseline_testing_completed_flag` BOOLEAN COMMENT 'Indicates whether baseline bloodborne pathogen testing was completed for the exposed employee immediately following the exposure. Required to establish pre-exposure status.',
    `corrective_actions_implemented` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar exposure incidents. May include process changes, equipment changes, or additional training.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exposure incident record was first created in the system. Audit trail for data governance and compliance verification.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the exposed employee was unable to work as a result of the exposure incident. Required for OSHA 300 log column entries.',
    `days_of_job_transfer_restriction` STRING COMMENT 'Number of calendar days the exposed employee was on restricted work activity or job transfer as a result of the exposure. Required for OSHA 300 log column entries.',
    `exposed_employee_department` STRING COMMENT 'Department or unit where the exposed employee was working at the time of the incident. Critical for departmental safety metrics and targeted training.',
    `exposed_employee_job_title` STRING COMMENT 'Job title or role of the exposed employee at the time of the incident. Used for risk analysis and prevention planning by occupational category.',
    `exposure_route` STRING COMMENT 'Route by which the exposure occurred. Percutaneous (needlestick, sharps injury) and mucous membrane exposures have different post-exposure prophylaxis protocols.. Valid values are `percutaneous|mucous_membrane|non_intact_skin|inhalation|ingestion|other`',
    `exposure_type` STRING COMMENT 'Primary category of occupational exposure. Bloodborne pathogen exposures are the most common in healthcare and trigger specific OSHA Bloodborne Pathogens Standard requirements.. Valid values are `bloodborne_pathogen|chemical|respiratory|radiation|biological_non_bloodborne|other`',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Indicates whether all required follow-up testing and medical evaluations have been completed for the exposed employee. Used to track compliance with post-exposure protocols.',
    `follow_up_testing_schedule` STRING COMMENT 'Scheduled follow-up testing timeline for the exposed employee (e.g., 6 weeks, 3 months, 6 months post-exposure). Protocol varies by exposure type and source patient status.',
    `incident_date` DATE COMMENT 'Date when the occupational exposure incident occurred. Used to determine OSHA recordability and reporting deadlines.',
    `incident_location` STRING COMMENT 'Specific location within the healthcare facility where the exposure occurred (e.g., Emergency Department Room 3, Operating Room 5, Patient Room 412). Used for environmental risk assessment.',
    `incident_number` STRING COMMENT 'Business identifier assigned to the exposure incident for tracking and reporting purposes. Used in OSHA 300 log and internal incident management systems.',
    `incident_resolution_date` DATE COMMENT 'Date when the exposure incident case was closed and all follow-up activities completed. Used for case closure tracking and outcome analysis.',
    `incident_status` STRING COMMENT 'Current status of the exposure incident case management. Tracks the incident through investigation, follow-up care, and final resolution.. Valid values are `open|under_investigation|follow_up_in_progress|closed|pending_review`',
    `incident_time` TIMESTAMP COMMENT 'Precise date and time when the exposure incident occurred. Used for shift analysis, staffing pattern review, and post-exposure prophylaxis timing calculations.',
    `investigation_notes` STRING COMMENT 'Detailed narrative of the incident investigation findings, including circumstances leading to the exposure, witness statements, and contributing factors. Used for root cause analysis and prevention planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the exposure incident record was last modified. Audit trail for tracking updates to incident details, status changes, and follow-up documentation.',
    `osha_recordable_determination_date` DATE COMMENT 'Date when the OSHA recordability determination was made. Must be within 7 calendar days of receiving information that a recordable injury or illness has occurred.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the exposure incident meets OSHA criteria for recordability on the OSHA 300 log. Recordability determination based on whether the incident resulted in medical treatment beyond first aid, days away from work, or job transfer/restriction.',
    `pep_initiated_flag` BOOLEAN COMMENT 'Indicates whether post-exposure prophylaxis treatment was initiated for the exposed employee. Required for OSHA compliance and employee health tracking.',
    `pep_start_timestamp` TIMESTAMP COMMENT 'Date and time when post-exposure prophylaxis was initiated. Timing is critical for PEP effectiveness, particularly for HIV exposure (ideally within 2 hours, no later than 72 hours).',
    `pep_type` STRING COMMENT 'Type of post-exposure prophylaxis administered (e.g., HIV PEP antiretroviral therapy, Hepatitis B immune globulin, Hepatitis B vaccination). Free text to accommodate multiple concurrent treatments.',
    `procedure_being_performed` STRING COMMENT 'Clinical procedure or task being performed when the exposure occurred. Used for procedural risk analysis and targeted training interventions.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the exposure incident was first reported to management or employee health. Used to track reporting timeliness and compliance with immediate reporting requirements.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis was conducted for the exposure incident. Required for serious incidents and used to drive systemic safety improvements.',
    `safety_engineered_device_flag` BOOLEAN COMMENT 'Indicates whether the device involved had safety-engineered sharps injury protection features. Critical for evaluating effectiveness of safety device adoption.',
    `sharps_device_brand` STRING COMMENT 'Manufacturer and brand name of the sharp device involved. Used for product safety evaluation and vendor performance tracking.',
    `sharps_device_type` STRING COMMENT 'Type of sharp device involved in the exposure (e.g., hollow-bore needle, suture needle, scalpel, lancet). Required for OSHA Sharps Injury Log and device evaluation.',
    `source_patient_hbv_status` STRING COMMENT 'Hepatitis B test result for the source patient. Protected health information. Determines need for Hepatitis B immune globulin and vaccination for exposed employee.. Valid values are `positive|negative|unknown|declined`',
    `source_patient_hcv_status` STRING COMMENT 'Hepatitis C test result for the source patient. Protected health information. Determines baseline and follow-up testing protocol for exposed employee.. Valid values are `positive|negative|unknown|declined`',
    `source_patient_hiv_status` STRING COMMENT 'HIV test result for the source patient. Protected health information. Critical for determining post-exposure prophylaxis regimen for the exposed employee.. Valid values are `positive|negative|unknown|declined`',
    `source_patient_known_flag` BOOLEAN COMMENT 'Indicates whether the source patient could be identified. Unknown source exposures require different post-exposure prophylaxis risk assessment.',
    `source_patient_tested_flag` BOOLEAN COMMENT 'Indicates whether the source patient was tested for bloodborne pathogens (HIV, Hepatitis B, Hepatitis C) following the exposure incident.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance osha exposure incident record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `workers_comp_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a workers compensation claim was filed for the exposure incident. Links occupational health incident to workers compensation case management.',
    `workers_comp_claim_number` STRING COMMENT 'Workers compensation claim number associated with the exposure incident, if a claim was filed. Used for cross-referencing with workers compensation system.',
    CONSTRAINT pk_osha_exposure_incident PRIMARY KEY(`osha_exposure_incident_id`)
) COMMENT 'OSHA-reportable exposure incidents and workplace injuries';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` (
    `cms_condition_status_id` BIGINT COMMENT 'Unique identifier for the CMS Condition of Participation or Condition for Coverage compliance status tracking record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: CMS Condition of Participation status records are assessed during CMS surveys/audits. Each cms_condition_status record should link to the audit/survey that assessed it (last_survey_date, last_survey_t',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or provider location to which this CMS condition compliance status applies.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the compliance cms condition status record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: CMS Conditions of Participation status directly affects Medicare/Medicaid payer relationships. Deemed status through accreditation impacts which payers will contract. Tracking payer context for CoP co',
    `prior_cms_condition_status_id` BIGINT COMMENT 'Self-referencing FK on cms_condition_status (prior_cms_condition_status_id)',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CMS condition compliance is typically owned by specific departments (Quality, Infection Control, etc.). Remediation costs must be tracked against the responsible cost center for budget management, cos',
    `certification_effective_date` DATE COMMENT 'The date on which the current CMS certification status for this provider type became effective.',
    `certification_expiration_date` DATE COMMENT 'The date on which the current CMS certification for this provider type expires if not renewed through recertification survey.',
    `certification_status` STRING COMMENT 'The overall CMS certification status of the facility for this provider type: certified (full compliance), provisional certification (initial certification period), conditional certification (deficiencies present but correctable), decertified, or termination pending.. Valid values are `certified|provisional_certification|conditional_certification|decertified|termination_pending`',
    `civil_monetary_penalty_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of civil monetary penalties imposed by CMS for deficiencies cited under this Condition of Participation.',
    `compliance_status` STRING COMMENT 'The current compliance status of the facility for this specific CMS Condition of Participation: compliant (no deficiencies), deficient (standard-level deficiency), condition-level deficiency (threatens health and safety), immediate jeopardy (serious harm or death likely), plan of correction pending, or plan of correction accepted.. Valid values are `compliant|deficient|condition_level_deficiency|immediate_jeopardy|plan_of_correction_pending|plan_of_correction_accepted`',
    `condition_category` STRING COMMENT 'The functional category or domain of the CMS Condition of Participation (e.g., patient rights, quality assurance, infection control, nursing services, medical staff, pharmaceutical services). [ENUM-REF-CANDIDATE: patient_rights|quality_assurance|infection_control|nursing_services|medical_staff|pharmaceutical_services|dietary_services|emergency_services|surgical_services|anesthesia_services|radiologic_services|laboratory_services|medical_record_services|physical_environment|life_safety|governance|administration — 17 candidates stripped; promote to reference product]',
    `condition_name` STRING COMMENT 'The full descriptive name of the CMS Condition of Participation or Condition for Coverage (e.g., Patient Rights, Infection Prevention and Control, Nursing Services).',
    `cop_citation` STRING COMMENT 'The official CMS regulatory citation for the Condition of Participation or Condition for Coverage (e.g., 42 CFR 482.13, 42 CFR 483.10) that this status record tracks.',
    `correction_completion_date` DATE COMMENT 'The date by which the facility must complete all corrective actions for deficiencies cited under this condition, as specified in the accepted Plan of Correction.',
    `correction_verified_date` DATE COMMENT 'The date on which CMS or the state survey agency verified that all corrective actions for this condition have been successfully implemented and deficiencies resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this CMS condition status tracking record was first created in the system.',
    `deficiency_tag_numbers` STRING COMMENT 'Comma-separated list of CMS deficiency tag numbers (e.g., K0001, K0021, A0115) cited under this Condition of Participation during the last survey.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the compliance cms condition status record.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether CMS or the state survey agency has imposed enforcement actions (remedies) on the facility related to deficiencies under this condition (True if enforcement actions are active, False otherwise).',
    `enforcement_action_type` STRING COMMENT 'The type of CMS enforcement remedy imposed for deficiencies under this condition (e.g., civil monetary penalty, denial of payment for new admissions, temporary management, termination of provider agreement). Multiple actions may be listed if applicable.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the compliance cms condition status record.',
    `internal_audit_frequency_months` STRING COMMENT 'The frequency in months at which the organization conducts internal compliance audits or self-assessments for this CMS Condition of Participation.',
    `last_internal_audit_date` DATE COMMENT 'The date of the most recent internal compliance audit or self-assessment conducted for this CMS Condition of Participation.',
    `last_internal_audit_result` STRING COMMENT 'The outcome of the most recent internal compliance audit for this condition: compliant, minor gaps identified, significant gaps identified, or non-compliant.. Valid values are `compliant|minor_gaps|significant_gaps|non_compliant`',
    `last_survey_date` DATE COMMENT 'The date of the most recent CMS certification survey or validation survey during which this Condition of Participation was evaluated.',
    `last_survey_outcome` STRING COMMENT 'The overall outcome of the last CMS survey for this condition: no deficiencies found, deficiencies cited (standard level), condition-level deficiencies cited, immediate jeopardy cited, or termination recommended.. Valid values are `no_deficiencies|deficiencies_cited|condition_level_cited|immediate_jeopardy_cited|termination_recommended`',
    `last_survey_type` STRING COMMENT 'The type of CMS survey during which this condition was last evaluated (e.g., initial certification, recertification, complaint investigation, validation, life safety code, revisit).. Valid values are `initial_certification|recertification|complaint|validation|life_safety_code|revisit`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this CMS condition status tracking record was last updated or modified.',
    `next_internal_audit_date` DATE COMMENT 'The scheduled date for the next internal compliance audit or self-assessment for this CMS Condition of Participation.',
    `next_survey_window_end` DATE COMMENT 'The latest date within the window when the next CMS certification or recertification survey for this condition must occur to maintain compliance with survey frequency requirements.',
    `next_survey_window_start` DATE COMMENT 'The earliest date within the window when the next CMS certification or recertification survey for this condition is expected to occur, based on regulatory survey cycles.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding the compliance status, survey findings, corrective actions, or other relevant information for this CMS Condition of Participation.',
    `open_deficiency_count` STRING COMMENT 'The current number of open (uncorrected) deficiencies cited under this Condition of Participation that require corrective action.',
    `plan_of_correction_acceptance_date` DATE COMMENT 'The date on which CMS or the state survey agency formally accepted the facilitys Plan of Correction.',
    `plan_of_correction_due_date` DATE COMMENT 'The deadline by which the facility must submit its Plan of Correction to CMS or the state survey agency for deficiencies cited under this condition.',
    `plan_of_correction_status` STRING COMMENT 'The current status of the Plan of Correction for deficiencies cited under this condition: not required, required, submitted, under review by CMS/state agency, accepted, rejected, implemented, or verified as corrected. [ENUM-REF-CANDIDATE: not_required|required|submitted|under_review|accepted|rejected|implemented|verified — 8 candidates stripped; promote to reference product]',
    `plan_of_correction_submission_date` DATE COMMENT 'The date on which the facility submitted its Plan of Correction to CMS or the state survey agency.',
    `provider_type` STRING COMMENT 'The certified provider type classification under CMS regulations (e.g., hospital, SNF, home health, hospice, ASC, critical access hospital) that determines which Conditions of Participation apply.. Valid values are `hospital|skilled_nursing_facility|home_health_agency|hospice|ambulatory_surgical_center|critical_access_hospital`',
    `responsible_department` STRING COMMENT 'The internal department or service line responsible for maintaining compliance with this CMS Condition of Participation (e.g., Nursing, Infection Prevention, Quality, Medical Staff Services).',
    `responsible_officer_name` STRING COMMENT 'The name of the executive or director responsible for oversight of compliance with this CMS Condition of Participation.',
    `responsible_officer_title` STRING COMMENT 'The job title of the executive or director responsible for oversight of compliance with this CMS Condition of Participation (e.g., Chief Nursing Officer, Director of Quality, Chief Medical Officer).',
    `risk_level` STRING COMMENT 'The organizations internal risk assessment level for non-compliance with this CMS Condition of Participation, based on likelihood and impact of deficiencies (low, moderate, high, critical).. Valid values are `low|moderate|high|critical`',
    `scope_and_severity_level` STRING COMMENT 'The CMS scope and severity matrix level assigned to the most serious deficiency under this condition (A through L, where A is isolated/no harm and L is widespread/immediate jeopardy). [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I|J|K|L — 12 candidates stripped; promote to reference product]',
    `state_survey_agency` STRING COMMENT 'The name of the state health department or survey agency responsible for conducting CMS certification surveys for this facility.',
    `cms_condition_status_status` STRING COMMENT 'The cms condition status status value classifying the compliance cms condition status record.',
    `surveyor_name` STRING COMMENT 'The name of the lead CMS or state survey agency surveyor who conducted the last survey evaluation of this condition.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance cms condition status record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance cms condition status record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_cms_condition_status PRIMARY KEY(`cms_condition_status_id`)
) COMMENT 'CMS Conditions of Participation compliance status tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` (
    `accreditation_status_id` BIGINT COMMENT 'Unique identifier for the accreditation status record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Accreditation status is determined by accreditation audits/surveys. Each accreditation_status record should link to the audit that determined the status (last_survey_date, survey_type exist). This cre',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or organizational unit that holds this accreditation. Links to the facility master record.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the compliance accreditation status record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Accreditation (Joint Commission, NCQA, URAC) is often contractually required by specific payers. Payers reference accreditation status for contracting decisions, deemed status recognition, and quality',
    `prior_accreditation_status_id` BIGINT COMMENT 'Self-referencing FK on accreditation_status (prior_accreditation_status_id)',
    `accreditation_award_date` DATE COMMENT 'Date on which the accreditation status was officially awarded or conferred by the accrediting body following survey completion and decision.',
    `accreditation_certificate_number` STRING COMMENT 'Unique certificate or accreditation number issued by the accrediting body to identify this specific accreditation award.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `accreditation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost in US dollars (USD) associated with obtaining and maintaining this accreditation, including survey fees, application fees, annual fees, and consulting costs.',
    `accreditation_cycle_years` STRING COMMENT 'Number of years in the accreditation cycle before re-survey is required. Typically 3 years for hospital accreditation, may vary by program type.',
    `accreditation_decision_date` DATE COMMENT 'Date on which the accrediting body made the formal accreditation decision following survey review and any appeals process.',
    `accreditation_level` STRING COMMENT 'Level or tier of accreditation awarded, if the accrediting body uses tiered accreditation (e.g., gold, silver, bronze for some programs; level I, II, III for trauma centers).',
    `accreditation_scope` STRING COMMENT 'Description of the scope of services, departments, or programs covered by this accreditation (e.g., acute care hospital services, emergency department, surgical services, laboratory services, radiology services).',
    `accreditation_status` STRING COMMENT 'Current accreditation status awarded by the accrediting body. Accredited indicates full compliance; accredited with follow-up indicates minor findings requiring follow-up; conditional indicates significant findings with conditions; preliminary denial indicates intent to deny; not accredited indicates denial or loss of accreditation; withdrawn indicates voluntary withdrawal.. Valid values are `accredited|accredited_with_follow_up|conditional|preliminary_denial|not_accredited|withdrawn`',
    `accrediting_body_code` STRING COMMENT 'Standardized code identifying the accrediting organization (e.g., TJC for The Joint Commission, DNV for DNV GL, HFAP for Healthcare Facilities Accreditation Program, CARF for Commission on Accreditation of Rehabilitation Facilities, CAP for College of American Pathologists, ACR for American College of Radiology, AAAHC for Accreditation Association for Ambulatory Health Care).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `accrediting_body_name` STRING COMMENT 'Full legal name of the accrediting organization (e.g., The Joint Commission, DNV GL Healthcare, Healthcare Facilities Accreditation Program).',
    `annual_maintenance_fee_amount` DECIMAL(18,2) COMMENT 'Annual fee in US dollars (USD) charged by the accrediting body to maintain active accreditation status between surveys.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the organization filed an appeal of the accreditation decision or survey findings. True if appeal was filed; false otherwise.',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal process if an appeal was filed. Upheld indicates original decision stands; overturned indicates decision reversed; modified indicates decision changed; pending indicates appeal in progress; not applicable if no appeal filed.. Valid values are `upheld|overturned|modified|pending|not_applicable`',
    `cms_certification_number` STRING COMMENT 'CMS-issued certification number (CCN) associated with this accreditation when deemed status applies. Used for Medicare and Medicaid billing and provider enrollment.. Valid values are `^[A-Z0-9]{6,10}$`',
    `contact_person_email` STRING COMMENT 'Email address of the primary organizational contact person for this accreditation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the primary organizational contact person responsible for managing this accreditation relationship and survey coordination.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary organizational contact person for this accreditation.',
    `contact_person_title` STRING COMMENT 'Job title or role of the primary organizational contact person for this accreditation (e.g., Director of Regulatory Compliance, Chief Quality Officer, Accreditation Coordinator).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation status record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical or immediate threat to health and safety findings identified during the last survey. Critical findings may result in conditional accreditation or denial.',
    `deemed_status_flag` BOOLEAN COMMENT 'Indicates whether this accreditation confers deemed status for Centers for Medicare and Medicaid Services (CMS) Conditions of Participation (CoP), allowing the facility to participate in Medicare and Medicaid programs without separate CMS certification. True if deemed status is granted; false otherwise.',
    `effective_date` DATE COMMENT 'Date from which the accreditation status becomes effective and the organization is considered accredited.',
    `exclusions` STRING COMMENT 'Description of any services, departments, or programs explicitly excluded from the scope of this accreditation.',
    `expiration_date` DATE COMMENT 'Date on which the current accreditation status expires and requires renewal or re-survey. Typically 3 years for hospital accreditation.',
    `follow_up_completion_date` DATE COMMENT 'Date on which the required follow-up activity (evidence submission, corrective action plan, or follow-up survey) was completed and accepted by the accrediting body.',
    `follow_up_due_date` DATE COMMENT 'Date by which the organization must submit evidence of standards compliance, corrective action plan, or complete a follow-up survey to maintain accreditation status.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether the accrediting body requires a follow-up survey, evidence of standards compliance (ESC), or corrective action plan submission to address findings. True if follow-up is required; false otherwise.',
    `last_survey_date` DATE COMMENT 'Date of the most recent accreditation survey conducted by the accrediting body that resulted in the current accreditation status.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation status record was last modified or updated in the system.',
    `next_survey_window_end_date` DATE COMMENT 'Latest date within the window by which the next accreditation survey must be completed to maintain continuous accreditation.',
    `next_survey_window_start_date` DATE COMMENT 'Earliest date within the window when the next accreditation survey may be scheduled or conducted.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or important information about this accreditation status not captured in structured fields.',
    `program_type` STRING COMMENT 'Type of accreditation program applicable to the facility (e.g., hospital accreditation, ambulatory care accreditation, laboratory accreditation, radiology accreditation, behavioral health, rehabilitation, home health). [ENUM-REF-CANDIDATE: hospital|ambulatory|laboratory|radiology|behavioral_health|rehabilitation|home_health|other — 8 candidates stripped; promote to reference product]',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this accreditation status is publicly disclosed on the accrediting bodys website or public database. True if publicly disclosed; false if confidential.',
    `quality_report_url` STRING COMMENT 'Web address (URL) where the public quality report or accreditation details can be accessed on the accrediting bodys website (e.g., The Joint Commission Quality Check).',
    `state_licensure_alignment_flag` BOOLEAN COMMENT 'Indicates whether this accreditation is recognized by the state health department for facility licensure purposes or whether it satisfies state licensure requirements. True if aligned; false otherwise.',
    `accreditation_status_status` STRING COMMENT 'The accreditation status status value classifying the compliance accreditation status record.',
    `survey_findings_count` STRING COMMENT 'Total number of findings, deficiencies, or requirements for improvement identified during the last accreditation survey.',
    `survey_type` STRING COMMENT 'Type of survey that resulted in this accreditation status. Initial for first-time accreditation; triennial for standard 3-year re-accreditation; mid-cycle for periodic review; unannounced for random unannounced surveys; for-cause for complaint-driven surveys; follow-up for post-finding validation.. Valid values are `initial|triennial|mid_cycle|unannounced|for_cause|follow_up`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance accreditation status record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance accreditation status record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_accreditation_status PRIMARY KEY(`accreditation_status_id`)
) COMMENT 'Accreditation status for various programs and services';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` (
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the Business Associate Agreement record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Identifier linking this BAA to the overarching compliance program under which it is managed.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Payers receiving PHI (eligibility files, claims data, remittance) are business associates under HIPAA requiring executed BAAs. Healthcare organizations must track which payer each BAA covers for regul',
    `renewed_business_associate_agreement_id` BIGINT COMMENT 'Self-referencing FK on business_associate_agreement (renewed_business_associate_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned to this BAA for tracking and reference purposes.',
    `audit_rights_granted_flag` BOOLEAN COMMENT 'Indicates whether the covered entity has the right to audit the business associates compliance with the BAA and HIPAA requirements.',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the business associate is required to notify the covered entity of any breach of unsecured PHI.',
    `breach_notification_timeframe_days` STRING COMMENT 'Number of days within which the business associate must notify the covered entity of a breach of unsecured PHI.',
    `business_associate_address` STRING COMMENT 'Full mailing address of the business associate organization, including street, city, state, and postal code.',
    `business_associate_agreement_status` STRING COMMENT 'Current lifecycle status of the BAA indicating whether it is in force, expired, terminated, or pending action.. Valid values are `active|expired|terminated|pending_renewal|draft|suspended`',
    `business_associate_contact_email` STRING COMMENT 'Email address of the primary contact person at the business associate organization for BAA-related matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `business_associate_contact_name` STRING COMMENT 'Name of the primary contact person at the business associate organization for BAA-related matters.',
    `business_associate_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the business associate organization for BAA-related matters.',
    `business_associate_signatory_name` STRING COMMENT 'Name of the individual who signed the BAA on behalf of the business associate.',
    `business_associate_signatory_title` STRING COMMENT 'Job title or role of the individual who signed the BAA on behalf of the business associate.',
    `business_associate_tax_number` STRING COMMENT 'Federal tax identification number (EIN) of the business associate for legal and financial tracking.',
    `covered_entity_signatory_name` STRING COMMENT 'Name of the individual who signed the BAA on behalf of the covered entity.',
    `covered_entity_signatory_title` STRING COMMENT 'Job title or role of the individual who signed the BAA on behalf of the covered entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this BAA record was first created in the system.',
    `document_location_url` STRING COMMENT 'URL or file path to the stored copy of the executed BAA document for reference and audit purposes.',
    `effective_date` DATE COMMENT 'Date on which the BAA becomes legally binding and enforceable.',
    `execution_date` DATE COMMENT 'Date on which the BAA was signed and executed by both the covered entity and the business associate.',
    `expiration_date` DATE COMMENT 'Date on which the BAA expires or terminates, if applicable. Null for agreements without a defined end date.',
    `indemnification_clause_included_flag` BOOLEAN COMMENT 'Indicates whether the BAA includes an indemnification clause protecting the covered entity from liability arising from the business associates actions.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount of liability or cyber insurance coverage the business associate must maintain.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the business associate is required to maintain liability or cyber insurance as a condition of the BAA.',
    `last_review_date` DATE COMMENT 'Date on which the BAA was last reviewed for compliance, accuracy, and currency.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this BAA record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this BAA record was last modified in the system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the BAA to ensure ongoing compliance and relevance.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the BAA, including special terms, amendments, or historical information.',
    `permitted_disclosures` STRING COMMENT 'Specific disclosures of PHI that the business associate is permitted to make under the terms of this BAA.',
    `permitted_uses` STRING COMMENT 'Specific uses of PHI that the business associate is permitted to perform under the terms of this BAA.',
    `phi_retention_period_years` STRING COMMENT 'Number of years the business associate is permitted or required to retain PHI after termination of services, if return or destruction is not feasible.',
    `phi_types_shared` STRING COMMENT 'Categories and types of PHI that will be disclosed to or accessed by the business associate under this agreement (e.g., demographic, clinical, billing).',
    `renewal_date` DATE COMMENT 'Date on which the BAA was renewed or is scheduled for renewal.',
    `return_or_destroy_phi_flag` BOOLEAN COMMENT 'Indicates whether the business associate is required to return or destroy all PHI upon termination of the agreement.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of the BAA.',
    `safeguards_required` STRING COMMENT 'Description of the administrative, physical, and technical safeguards the business associate must implement to protect PHI.',
    `services_provided` STRING COMMENT 'Detailed description of the services the business associate will provide that involve access to, use of, or disclosure of PHI.',
    `subcontractor_baa_chain` STRING COMMENT 'List or description of subcontractors with whom the business associate has executed downstream BAAs, maintaining the chain of HIPAA compliance.',
    `subcontractor_baa_required_flag` BOOLEAN COMMENT 'Indicates whether the business associate is required to obtain BAAs from any subcontractors who will have access to PHI.',
    `termination_date` DATE COMMENT 'Actual date on which the BAA was terminated, if applicable. Null if the agreement has not been terminated.',
    `termination_reason` STRING COMMENT 'Explanation or reason for the termination of the BAA, including breach, mutual agreement, or expiration.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance business associate agreement record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance business associate agreement record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_business_associate_agreement PRIMARY KEY(`business_associate_agreement_id`)
) COMMENT 'HIPAA Business Associate Agreements with third-party vendors';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` (
    `notice_of_privacy_practices_id` BIGINT COMMENT 'Unique identifier for the Notice of Privacy Practices record. Primary key for the NPP entity tracking both document versions and patient acknowledgments.',
    `care_site_id` BIGINT COMMENT 'Identifier for the healthcare facility where the NPP was provided to the patient. Important for multi-facility organizations.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Notice of Privacy Practices (NPP) is a specific HIPAA-required policy document. Each NPP version/distribution should link to the underlying privacy policy it implements. This allows tracking NPP distr',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who received and acknowledged (or refused) the NPP. Links to the patient master record.',
    `employee_id` BIGINT COMMENT 'Identifier for the employee or staff member who provided the NPP to the patient and obtained (or attempted to obtain) acknowledgment.',
    `superseded_notice_of_privacy_practices_id` BIGINT COMMENT 'Self-referencing FK on notice_of_privacy_practices (superseded_notice_of_privacy_practices_id)',
    `visit_id` BIGINT COMMENT 'Identifier for the clinical encounter or visit during which the NPP was provided to the patient. Null if provided outside of an encounter context.',
    `acknowledgment_date` DATE COMMENT 'Date when the patient acknowledged receipt of the NPP. Null if acknowledgment was refused or not obtained.',
    `acknowledgment_method` STRING COMMENT 'Specific method used to capture the patients acknowledgment (e.g., wet signature on paper, electronic signature pad, portal checkbox).. Valid values are `wet_signature|electronic_signature|verbal_documented|portal_click|kiosk|mobile_app`',
    `acknowledgment_status` STRING COMMENT 'Current status of the patients acknowledgment of receipt of the NPP. Tracks compliance with HIPAA requirement to make good faith effort to obtain acknowledgment.. Valid values are `acknowledged|refused|not_obtained|pending|emergency_exception`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the patient acknowledged receipt of the NPP, particularly important for electronic acknowledgments.',
    `acknowledgment_type` STRING COMMENT 'Type of acknowledgment received from the patient. HIPAA requires good faith effort to obtain written acknowledgment but allows documentation of refusal or inability to obtain.. Valid values are `signed_paper|electronic_signature|verbal|portal_acceptance|refused|not_obtained`',
    `audit_trail_notes` STRING COMMENT 'Additional notes or comments documenting special circumstances, follow-up actions, or compliance considerations related to this NPP record.',
    `available_on_website_flag` BOOLEAN COMMENT 'Indicates whether this NPP version is available on the organizations website. HIPAA requires covered entities with websites to post NPP prominently.',
    `department_name` STRING COMMENT 'Name of the department or service area where the NPP was provided (e.g., Emergency Department, Registration, Outpatient Clinic).',
    `device_type` STRING COMMENT 'Type of device used for electronic NPP acknowledgment (e.g., desktop, mobile, tablet, kiosk). Supports audit trail for electronic acknowledgments.',
    `distribution_date` DATE COMMENT 'Date when the NPP was provided or made available to the patient. Required for compliance documentation.',
    `distribution_method` STRING COMMENT 'Method by which the NPP was provided to the patient. HIPAA requires covered entities to provide NPP at first service delivery and make good faith effort to obtain acknowledgment. [ENUM-REF-CANDIDATE: paper|electronic|portal|email|mail|in_person|kiosk — 7 candidates stripped; promote to reference product]',
    `distribution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the NPP was distributed to the patient, particularly important for electronic and portal distributions.',
    `emergency_exception_flag` BOOLEAN COMMENT 'Indicates whether the NPP acknowledgment was not obtained due to emergency treatment circumstances. HIPAA allows exception for emergency situations.',
    `emergency_exception_reason` STRING COMMENT 'Description of the emergency circumstances that prevented obtaining NPP acknowledgment at the time of service.',
    `follow_up_completion_date` DATE COMMENT 'Date when follow-up was completed and NPP acknowledgment was obtained or final refusal documented.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up should be completed to obtain NPP acknowledgment if not obtained at initial service delivery.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up is required to obtain NPP acknowledgment (e.g., after emergency treatment, if patient was unable to acknowledge at initial visit).',
    `ip_address` STRING COMMENT 'IP address from which electronic or portal-based NPP acknowledgment was submitted. Used for audit trail and verification purposes.',
    `material_change_flag` BOOLEAN COMMENT 'Indicates whether this NPP version contains material changes to privacy practices. HIPAA requires prompt revision and redistribution if material changes occur.',
    `mrn` STRING COMMENT 'The patients Medical Record Number used to identify the individual across the healthcare organization. Required for tracking NPP acknowledgment compliance.',
    `npp_document_title` STRING COMMENT 'Official title of the NPP document (e.g., Notice of Privacy Practices for Protected Health Information).',
    `npp_document_url` STRING COMMENT 'Storage location or URL where the NPP document is maintained (e.g., document management system path, web portal URL).',
    `npp_effective_date` DATE COMMENT 'Date when this version of the NPP became effective and legally binding. Required to be printed on the notice per HIPAA regulations.',
    `npp_expiration_date` DATE COMMENT 'Date when this NPP version was superseded or retired. Null for the current active version.',
    `npp_language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the NPP document (e.g., ENG for English, SPA for Spanish). Organizations must provide NPP in languages spoken by patient populations.. Valid values are `^[A-Z]{3}$`',
    `npp_version_number` STRING COMMENT 'Version identifier for the NPP document (e.g., 1.0, 2.1, 3.0). Tracks revisions to the notice over time as regulations or organizational practices change.',
    `posted_in_facility_flag` BOOLEAN COMMENT 'Indicates whether this NPP version is posted prominently in the facility where patients can view it. HIPAA requires posting in clear and prominent location.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this NPP record was first created in the system. Part of the audit trail required for HIPAA compliance documentation.',
    `record_modified_by` STRING COMMENT 'Identifier or name of the user who last modified this NPP record. Required for audit trail and accountability.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this NPP record was last modified. Supports audit trail and compliance verification.',
    `refusal_documented_by` STRING COMMENT 'Name or identifier of the staff member who documented the patients refusal to acknowledge the NPP.',
    `refusal_reason` STRING COMMENT 'Documented reason why the patient refused to acknowledge receipt of the NPP. HIPAA requires documentation of good faith effort and reason for non-acknowledgment.',
    `revision_reason` STRING COMMENT 'Reason for creating a new version of the NPP (e.g., regulatory change, organizational policy update, new service offerings). Required when material changes are made.',
    `signature_image_url` STRING COMMENT 'Storage location or URL for the scanned or electronic signature image capturing the patients acknowledgment.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance notice of privacy practices record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `website_url` STRING COMMENT 'URL where the NPP is published on the organizations website for public access.',
    `witness_name` STRING COMMENT 'Name of witness present during NPP distribution and acknowledgment, if applicable (e.g., for verbal acknowledgments or special circumstances).',
    CONSTRAINT pk_notice_of_privacy_practices PRIMARY KEY(`notice_of_privacy_practices_id`)
) COMMENT 'Notice of Privacy Practices versions and patient acknowledgments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` (
    `phi_access_log_id` BIGINT COMMENT 'Unique identifier for each PHI access audit log entry. Primary key for compliance tracking of electronic Protected Health Information access events.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the access occurred. Supports facility-level compliance reporting and multi-site access pattern analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the workforce member or system user who accessed the PHI. Links to employee or system user master data for accountability tracking.',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: PHI access auditing must correlate with FHIR API access logs to create complete audit trails for patient data access via APIs. Required for HIPAA audit controls, patient access requests, and Cures Act',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose PHI was accessed. Links to patient master data for privacy investigations and minimum necessary access reviews.',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_note. Business justification: Access audit trails must track which specific clinical notes were viewed for inappropriate access monitoring and breach investigation. Healthcare organizations audit access logs against clinical note ',
    `parent_phi_access_log_id` BIGINT COMMENT 'Self-referencing FK on phi_access_log (related_phi_access_log_id)',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter or visit associated with the access event, if applicable. Links access to specific episodes of care for context validation.',
    `access_reason` STRING COMMENT 'Business reason or justification for accessing the PHI, either system-captured or user-provided. Used to validate legitimate treatment, payment, or healthcare operations purposes.',
    `access_reason_code` STRING COMMENT 'Standardized code representing the category of access reason. Enables systematic analysis of access patterns and compliance with minimum necessary standards. [ENUM-REF-CANDIDATE: treatment|payment|operations|research|legal|emergency|patient_request|quality_review|audit|other — 10 candidates stripped; promote to reference product]',
    `access_timestamp` TIMESTAMP COMMENT 'Date and time when the PHI access event occurred. Critical for audit trail reconstruction and compliance investigations per HIPAA Security Rule audit control requirements.',
    `access_type` STRING COMMENT 'Type of action performed on the PHI (view, print, export, modify, create, delete). Critical for assessing the nature and risk level of the access event.. Valid values are `view|print|export|modify|create|delete`',
    `audit_log_source` STRING COMMENT 'Source system or mechanism that generated this audit log entry (e.g., EHR native audit, SIEM correlation, access governance tool). Identifies the technical origin of the compliance record.',
    `breach_determination` STRING COMMENT 'Determination of whether the access event constitutes a breach of unsecured PHI requiring notification under the HIPAA Breach Notification Rule. Critical for regulatory reporting obligations.. Valid values are `not_applicable|not_a_breach|breach_low_risk|breach_reportable`',
    `breach_reported_date` DATE COMMENT 'Date when the breach was reported to affected individuals, HHS, or media, if applicable. Tracks compliance with breach notification timelines.',
    `break_glass_flag` BOOLEAN COMMENT 'The break glass flag of the compliance phi access log record.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action or workforce sanctions are required as a result of this access event. True if the review determined policy violations requiring remediation.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions or sanctions applied (e.g., counseling, retraining, access suspension, termination). Confidential workforce management information documenting compliance enforcement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit log record was created in the compliance data warehouse. Distinct from access_timestamp; represents when the compliance record was captured for reporting.',
    `data_classification` STRING COMMENT 'Classification level of the PHI accessed, indicating heightened sensitivity requiring additional protections under federal or state law (e.g., 42 CFR Part 2 substance abuse records, state mental health laws). [ENUM-REF-CANDIDATE: phi|sensitive_phi|substance_abuse|mental_health|hiv_aids|genetic|reproductive_health — 7 candidates stripped; promote to reference product]',
    `disclosure_tracking_required` BOOLEAN COMMENT 'Indicates whether this access event must be tracked as a disclosure for patient accounting of disclosures purposes under HIPAA. True for disclosures outside of treatment, payment, and operations.',
    `emergency_access_flag` BOOLEAN COMMENT 'Indicates whether this was an emergency or break-the-glass access event where normal access controls were overridden for patient safety reasons. True for emergency access requiring post-hoc review.',
    `flag_reason` STRING COMMENT 'Reason why the access was flagged for review (e.g., no patient relationship, VIP patient access, excessive access volume, after-hours access, break-the-glass override). Guides privacy officer investigation priorities.',
    `flagged_for_review` BOOLEAN COMMENT 'Indicates whether this access event was flagged by automated monitoring rules for privacy officer review. True if the access triggered compliance alerts based on access patterns, break-the-glass scenarios, or policy violations.',
    `ip_address` STRING COMMENT 'IP address of the device from which the PHI was accessed. Used for technical audit trail and security incident investigation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit log record was last modified, typically during privacy officer review or investigation updates. Supports audit trail integrity and compliance record lifecycle tracking.',
    `mrn` STRING COMMENT 'The patients Medical Record Number accessed during this event. Provides human-readable patient identifier for audit review and investigation workflows.',
    `patient_consent_on_file` BOOLEAN COMMENT 'Indicates whether valid patient consent or authorization was on file at the time of access, if required. Used to validate compliance with consent requirements for specific uses and disclosures.',
    `patient_relationship` STRING COMMENT 'Nature of the users relationship to the patient at the time of access. Used to assess appropriateness of access based on legitimate need-to-know and minimum necessary principles. [ENUM-REF-CANDIDATE: direct_care_provider|care_team_member|consulting_provider|administrative_staff|billing_staff|no_relationship|emergency_access — 7 candidates stripped; promote to reference product]',
    `record_type` STRING COMMENT 'Type of PHI record accessed. Categorizes the nature of protected health information viewed for compliance analysis and minimum necessary reviews. [ENUM-REF-CANDIDATE: clinical_note|lab_result|radiology_report|medication_order|diagnosis|procedure|demographic|insurance|billing|appointment|immunization|allergy|vital_sign|problem_list|care_plan|discharge_summary|operative_note|pathology_report|consent_form — promote to reference product]',
    `resource_accessed` STRING COMMENT 'The resource accessed of the compliance phi access log record.',
    `retention_period_years` STRING COMMENT 'Number of years this audit log entry must be retained per HIPAA Security Rule requirements and organizational policy. Typically 6 years from creation or last active date per §164.316(b)(2)(i).',
    `review_date` DATE COMMENT 'Date when the compliance review of this access event was completed. Used to track review timeliness and compliance program effectiveness.',
    `review_notes` STRING COMMENT 'Confidential notes documented by the privacy officer during the review of this access event. Contains investigation findings, user explanations, and compliance determinations.',
    `review_status` STRING COMMENT 'Current status of the compliance review for this access event. Tracks the lifecycle of privacy officer investigation from initial flag through resolution.. Valid values are `pending|in_review|approved|violation_confirmed|no_violation|escalated`',
    `reviewed_by` STRING COMMENT 'Name or identifier of the privacy officer or compliance staff member who reviewed this access event. Establishes accountability for compliance review activities.',
    `session_code` STRING COMMENT 'Unique identifier for the user session during which the access occurred. Enables correlation of multiple access events within a single login session.',
    `suspicious_flag` BOOLEAN COMMENT 'The suspicious flag of the compliance phi access log record.',
    `system_accessed` STRING COMMENT 'Name or identifier of the electronic health information system accessed (e.g., Epic EHR, Cerner Millennium, PACS, LIS). Identifies the source system containing the ePHI.',
    `system_module` STRING COMMENT 'Specific module or application within the system accessed (e.g., ClinDoc, Orders, Beaker, PowerChart). Provides granular detail on the type of PHI accessed.',
    `user_department` STRING COMMENT 'Department or organizational unit to which the accessing user belongs. Supports departmental compliance reporting and access pattern analysis.',
    `user_name` STRING COMMENT 'Full name of the user who accessed the PHI. Captured for human-readable audit reporting and privacy officer investigations.',
    `user_role` STRING COMMENT 'Job role or function of the user at the time of access (e.g., Physician, Nurse, Billing Specialist, Registration Clerk). Used to assess appropriateness of access based on role-based access control policies.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance phi access log record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `violation_type` STRING COMMENT 'Type of HIPAA violation identified during review, if applicable (e.g., unauthorized access, snooping, minimum necessary violation, breach of confidentiality). Used for workforce sanctions and corrective action tracking.',
    `workstation_code` STRING COMMENT 'Identifier of the physical or virtual workstation from which the access occurred. Supports technical security investigations and physical safeguard compliance.',
    CONSTRAINT pk_phi_access_log PRIMARY KEY(`phi_access_log_id`)
) COMMENT 'Audit logs of PHI access for compliance monitoring';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`attestation` (
    `attestation_id` BIGINT COMMENT 'Unique identifier for the compliance attestation record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location where the attesting individual is assigned. Used for facility-level compliance reporting and tracking.',
    `compliance_policy_id` BIGINT COMMENT 'Identifier of the specific policy or regulatory requirement being attested to. Links the attestation to the governing policy document.',
    `compliance_program_id` BIGINT COMMENT 'Identifier of the compliance program under which this attestation is required. Links the attestation to the governing compliance framework.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Attestations fulfill specific regulatory obligations. Each attestation should link to the obligation it satisfies (regulatory_requirement_reference exists as STRING but should be structured FK). This ',
    `employee_id` BIGINT COMMENT 'Identifier of the workforce member submitting the attestation. Links to the employee or medical staff member making the formal certification.',
    `reattested_attestation_id` BIGINT COMMENT 'Self-referencing FK on attestation (reattested_attestation_id)',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer or manager who reviewed and approved the attestation. Links to the employee responsible for verification.',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Attestation has training_completion_flag and training_completion_date, indicating it references a specific training completion event. When training is required for attestation, should link to the spec',
    `acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the attesting individual has acknowledged receipt and understanding of the policy or requirement. True if acknowledged, False otherwise.',
    `approval_authority` STRING COMMENT 'Name or title of the individual or role with authority to approve this attestation. Defines the governance hierarchy for compliance certifications.',
    `attestation_date` DATE COMMENT 'Date on which the attesting individual formally submitted or signed the attestation. Represents the principal business event timestamp for this transaction.',
    `attestation_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the attestation, used for reference in compliance documentation and audit trails.',
    `attestation_status` STRING COMMENT 'Current lifecycle state of the attestation. Tracks whether the certification is awaiting submission, has been completed, is past due, or has been rejected.. Valid values are `pending|completed|overdue|rejected|expired`',
    `attestation_type` STRING COMMENT 'Category of attestation being submitted. Defines the specific compliance requirement or policy being certified.. Valid values are `annual_compliance_certification|hipaa_workforce_training|code_of_conduct_acknowledgment|conflict_of_interest_recertification|cms_enrollment_attestation|policy_acknowledgment`',
    `attesting_individual_department` STRING COMMENT 'Department or organizational unit to which the attesting individual belongs. Used for compliance reporting and departmental attestation tracking.',
    `attesting_individual_email` STRING COMMENT 'Email address of the person submitting the attestation. Used for communication, reminders, and audit trail documentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `attesting_individual_name` STRING COMMENT 'Full name of the person submitting the attestation. Captured for audit trail and compliance documentation purposes.',
    `attesting_individual_title` STRING COMMENT 'Job title or role of the person submitting the attestation at the time of certification. Provides context for the authority and scope of the attestation.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes documenting changes, communications, or significant events related to this attestation. Provides detailed audit trail for compliance investigations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attestation record was first created in the system. Provides audit trail for record creation.',
    `device_identifier` STRING COMMENT 'Identifier of the device or workstation from which the attestation was submitted. Used for security tracking and access control verification.',
    `due_date` DATE COMMENT 'Deadline by which the attestation must be submitted to remain compliant. Used to track overdue attestations and trigger escalations.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the compliance attestation record.',
    `electronic_signature_reference` STRING COMMENT 'Reference identifier or token for the electronic signature applied to the attestation. Links to the digital signature system for non-repudiation and legal validity.',
    `expiration_date` DATE COMMENT 'Date on which this attestation expires and is no longer considered valid for compliance purposes. Triggers need for renewal or recertification.',
    `ip_address` STRING COMMENT 'IP address from which the attestation was submitted. Captured for security audit and fraud prevention purposes.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this attestation is mandatory for the individual based on their role and responsibilities. True if required, False if voluntary.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this attestation record. Provides accountability for record changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this attestation record was last modified. Tracks the most recent update to the record for audit purposes.',
    `next_recertification_due_date` DATE COMMENT 'Date by which the next recertification attestation must be submitted. Used to schedule and track recurring compliance certifications.',
    `notes` STRING COMMENT 'The notes of the compliance attestation record.',
    `notification_sent_date` DATE COMMENT 'Date on which the most recent notification or reminder was sent to the attesting individual. Used to track communication history.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification or reminder has been sent to the attesting individual regarding this attestation. True if notification sent, False otherwise.',
    `period_end_date` DATE COMMENT 'Ending date of the time period covered by this attestation. Defines when the compliance certification period concludes.',
    `period_start_date` DATE COMMENT 'Beginning date of the time period covered by this attestation. Defines the effective start of the compliance certification period.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertifications for this attestation type. Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether this attestation requires periodic recertification. True if recertification is required, False if it is a one-time attestation.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement, standard, or obligation that this attestation satisfies. Examples include HIPAA sections, CMS conditions, Joint Commission standards.',
    `rejection_reason` STRING COMMENT 'Explanation for why the attestation was rejected, if applicable. Captures the rationale for non-acceptance and required corrective actions.',
    `review_date` DATE COMMENT 'Date on which the attestation was reviewed and approved by the compliance officer or designated authority.',
    `scope` STRING COMMENT 'Description of the scope or coverage of the attestation. Defines what activities, locations, or responsibilities are covered by this certification.',
    `signature_timestamp` TIMESTAMP COMMENT 'Precise date and time when the electronic signature was applied to the attestation. Provides legal timestamp for compliance and audit purposes.',
    `statement` STRING COMMENT 'Full text of the attestation statement or certification language that the individual is affirming. Captures the exact wording of the compliance commitment.',
    `supporting_documentation_url` STRING COMMENT 'File path or URL to supporting documentation or evidence attached to the attestation. Links to certificates, training records, or other proof of compliance.',
    `training_completion_flag` BOOLEAN COMMENT 'Indicates whether required training associated with this attestation has been completed. True if training is complete, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance attestation record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance attestation record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_attestation PRIMARY KEY(`attestation_id`)
) COMMENT 'Employee and provider attestations for compliance requirements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Reference to the primary compliance program affected by this regulatory change.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer responsible for managing the organizational response to this regulatory change.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual financial cost incurred by the organization for implementing this regulatory change.',
    `affected_compliance_programs` STRING COMMENT 'Comma-separated list or description of all compliance programs impacted by this regulatory change.',
    `affected_facilities` STRING COMMENT 'List or description of healthcare facilities affected by this regulatory change.',
    `affected_systems` STRING COMMENT 'Information systems and applications that require modification to comply with this regulatory change (e.g., EHR, billing system, reporting tools).',
    `assigned_department` STRING COMMENT 'The primary department responsible for implementing the regulatory change.',
    `change_description` STRING COMMENT 'Detailed description of the regulatory change, including what is being modified, added, or removed.',
    `change_number` STRING COMMENT 'Business identifier for the regulatory change, typically assigned by the compliance office or derived from the regulatory bodys reference number.',
    `change_title` STRING COMMENT 'The official title or name of the regulatory change as published by the regulatory body.',
    `change_type` STRING COMMENT 'The nature of the regulatory change being tracked.. Valid values are `new rule|amended rule|guidance update|standard revision|enforcement policy change|interpretive guidance`',
    `comment_period_end_date` DATE COMMENT 'The deadline by which public comments must be submitted to the regulatory body.',
    `comment_period_start_date` DATE COMMENT 'The date when the public comment period opens for proposed regulatory changes.',
    `comment_submission_date` DATE COMMENT 'The date when organizational comments were submitted to the regulatory body.',
    `comment_submitted_flag` BOOLEAN COMMENT 'Indicates whether the organization submitted comments during the public comment period.',
    `comment_summary` STRING COMMENT 'Summary of the comments submitted by the organization during the comment period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory change record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the official regulatory change document or Federal Register notice.',
    `effective_date` DATE COMMENT 'The date when the regulatory change becomes effective and enforceable.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated financial cost to the organization for implementing this regulatory change, including system modifications, training, and process changes.',
    `external_consultation_required_flag` BOOLEAN COMMENT 'Indicates whether external legal or compliance consultation was or will be required for this regulatory change.',
    `impact_assessment_completion_date` DATE COMMENT 'The date when the impact assessment was completed.',
    `impact_assessment_status` STRING COMMENT 'Current status of the organizational impact assessment for this regulatory change.. Valid values are `not started|in progress|completed|approved|deferred`',
    `impact_summary` STRING COMMENT 'Summary of the organizational impact including affected departments, systems, processes, and estimated effort.',
    `implementation_completion_date` DATE COMMENT 'The date when all implementation activities were completed and verified.',
    `implementation_deadline` DATE COMMENT 'The date by which the organization must have fully implemented the regulatory change to achieve compliance.',
    `implementation_start_date` DATE COMMENT 'The date when implementation activities began.',
    `implementation_status` STRING COMMENT 'Current status of the organizations implementation of the regulatory change. [ENUM-REF-CANDIDATE: identified|under review|planning|in progress|implemented|verified|closed — 7 candidates stripped; promote to reference product]',
    `internal_documentation_url` STRING COMMENT 'URL or file path to internal organizational documentation related to this regulatory change (impact assessments, implementation plans, meeting notes).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory change record was last modified.',
    `monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing monitoring is required after implementation to ensure sustained compliance.',
    `next_review_date` DATE COMMENT 'The date when this regulatory change record should be reviewed for updates or changes in regulatory guidance.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to this regulatory change.',
    `penalty_exposure_amount` DECIMAL(18,2) COMMENT 'Estimated financial penalty exposure if the organization fails to comply with this regulatory change.',
    `policy_updates_required_flag` BOOLEAN COMMENT 'Indicates whether organizational policies must be updated to comply with this regulatory change.',
    `publication_date` DATE COMMENT 'The date the regulatory change was officially published or announced by the regulatory body.',
    `regulatory_body` STRING COMMENT 'The governing body or agency issuing the regulatory change (e.g., CMS, OCR, Joint Commission, OSHA, State Department of Health, FDA).',
    `regulatory_citation` STRING COMMENT 'The official citation or reference number for the regulatory change (e.g., Federal Register citation, CFR section, Joint Commission standard number).',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or program under which this change falls (e.g., HIPAA, CMS Conditions of Participation, Joint Commission Standards, OSHA Healthcare Worker Safety).',
    `response_actions_required` STRING COMMENT 'Description of the specific actions the organization must take to comply with the regulatory change (e.g., policy updates, system changes, training, reporting modifications).',
    `risk_level` STRING COMMENT 'The risk level associated with non-compliance or delayed implementation of this regulatory change.. Valid values are `critical|high|medium|low`',
    `superseded_regulation` STRING COMMENT 'Reference to the previous regulation or standard that this change supersedes or replaces.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training is required to implement this regulatory change.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance regulatory change record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Tracking of regulatory changes and their impact on compliance programs';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` (
    `monitoring_activity_id` BIGINT COMMENT 'Unique identifier for the compliance monitoring activity record. Primary key for the monitoring activity entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the monitoring activity is being conducted or that is the subject of the review.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Monitoring activities verify policy compliance. The policy_reference (STRING) field should be replaced with a structured FK policy_id. This allows tracking which policies are being monitored and aggre',
    `compliance_program_id` BIGINT COMMENT 'Reference to the overarching compliance program under which this monitoring activity is conducted.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure code monitoring targets specific CPT codes for compliance review based on utilization outliers, NCCI edit violations, or high-risk procedure categories identified in compliance risk assessme',
    `follow_up_monitoring_activity_id` BIGINT COMMENT 'Self-referencing FK on monitoring_activity (follow_up_monitoring_activity_id)',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Compliance monitoring activities (DRG validation, coding audits, medical necessity reviews) sample specific diagnosis codes for review based on risk profiles, payer focus areas, or OIG work plans.',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Compliance monitoring activities routinely audit interface channels for message integrity, timeliness, error rates, and adherence to data exchange policies. Linking monitoring to specific channels ena',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is leading or responsible for conducting the monitoring activity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Monitoring activities consume departmental resources. Monitoring costs (staff time, audit tools, sampling) should be tracked against the responsible cost centers budget for cost allocation, program e',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Monitoring activities verify compliance with specific regulatory obligations. Each monitoring activity should link to the obligation being monitored. This allows tracking obligation compliance through',
    `activity_name` STRING COMMENT 'Descriptive name or title of the monitoring activity that clearly identifies the focus and scope of the review.',
    `activity_number` STRING COMMENT 'Business-facing unique identifier or tracking number assigned to the monitoring activity for reference and reporting purposes.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the monitoring activity indicating its progress through the monitoring workflow.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `activity_type` STRING COMMENT 'Classification of the monitoring activity by its primary focus area. Supports categorization and trend analysis of compliance monitoring efforts. [ENUM-REF-CANDIDATE: medical_record_review|hipaa_access_audit|billing_compliance_spot_check|coding_accuracy_review|policy_adherence_observation|department_self_assessment|claims_audit|documentation_review|privacy_monitoring|security_monitoring|quality_review|operational_audit — promote to reference product]',
    `actual_completion_date` DATE COMMENT 'The actual date when the monitoring activity was completed. Used to track schedule adherence and cycle time metrics.',
    `actual_start_date` DATE COMMENT 'The actual date when the monitoring activity execution began. Used to track schedule adherence and performance metrics.',
    `compliance_rate_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage representing the proportion of reviewed items that were found to be compliant with the applicable standard or requirement. Key performance indicator for compliance effectiveness.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and access restrictions for the monitoring activity and its findings.. Valid values are `public|internal|confidential|restricted`',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required to address the issues identified during the monitoring activity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this monitoring activity record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_issues_count` STRING COMMENT 'The number of issues identified that are classified as critical or high-severity, requiring immediate attention and remediation.',
    `department_monitored` STRING COMMENT 'The name of the department, unit, or functional area that is the subject of the monitoring activity.',
    `external_auditor_involvement_flag` BOOLEAN COMMENT 'Indicates whether external auditors or consultants participated in or reviewed the monitoring activity.',
    `external_auditor_organization` STRING COMMENT 'Name of the external auditing firm or consulting organization involved in the monitoring activity, if applicable.',
    `findings_summary` STRING COMMENT 'High-level summary of the key findings, observations, and results from the monitoring activity. Provides executive-level overview of compliance status.',
    `follow_up_action_description` STRING COMMENT 'Detailed description of the follow-up actions, corrective measures, or remediation steps required or recommended based on the monitoring findings.',
    `follow_up_due_date` DATE COMMENT 'The target date by which follow-up actions or corrective measures should be completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up monitoring or verification activities are required based on the findings of this monitoring activity.',
    `issues_identified_count` STRING COMMENT 'The total number of compliance issues, deficiencies, or non-conformances identified during the monitoring activity.',
    `lead_monitor_name` STRING COMMENT 'Full name of the employee leading the monitoring activity. Provides quick reference without requiring a join to the employee table.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this monitoring activity record was last updated or modified. Supports audit trail and change tracking.',
    `monitoring_methodology` STRING COMMENT 'Description of the approach, techniques, and procedures used to conduct the monitoring activity (e.g., random sampling, targeted review, automated scanning, observation).',
    `monitoring_period_end_date` DATE COMMENT 'The ending date of the time period being reviewed or monitored for compliance. Defines the temporal scope of the monitoring activity.',
    `monitoring_period_start_date` DATE COMMENT 'The beginning date of the time period being reviewed or monitored for compliance. Defines the temporal scope of the monitoring activity.',
    `monitoring_team_size` STRING COMMENT 'The number of individuals involved in conducting the monitoring activity. Used for resource planning and workload analysis.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about the monitoring activity that do not fit into structured fields.',
    `population_size` STRING COMMENT 'The total number of records, transactions, or cases in the population from which the sample was drawn.',
    `process_monitored` STRING COMMENT 'Description of the specific business process, workflow, or operational activity being monitored for compliance (e.g., patient registration, order entry, billing submission).',
    `regulatory_citation` STRING COMMENT 'Specific citation or reference to the regulatory requirement, standard section, or rule being monitored (e.g., 45 CFR 164.308, Joint Commission Standard LD.04.03.11).',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or standard being monitored for compliance (e.g., HIPAA, CMS Conditions of Participation, Joint Commission standards, OSHA requirements).',
    `report_document_path` STRING COMMENT 'File system path or URL to the detailed monitoring activity report document for reference and audit trail purposes.',
    `report_issued_date` DATE COMMENT 'The date when the formal monitoring activity report was issued or published to stakeholders.',
    `risk_level` STRING COMMENT 'Assessment of the overall risk level associated with the findings from the monitoring activity, considering potential impact on patient safety, regulatory compliance, and financial exposure.. Valid values are `low|moderate|high|critical`',
    `sample_size` STRING COMMENT 'The number of records, transactions, or cases reviewed as part of the monitoring activity. Used to assess statistical validity and coverage.',
    `scheduled_completion_date` DATE COMMENT 'The planned date by which the monitoring activity is expected to be completed.',
    `scheduled_start_date` DATE COMMENT 'The planned date when the monitoring activity is scheduled to begin execution.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance monitoring activity record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_monitoring_activity PRIMARY KEY(`monitoring_activity_id`)
) COMMENT 'Ongoing compliance monitoring activities and reviews';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` (
    `program_policy_assignment_id` BIGINT COMMENT 'Unique identifier for this program-policy assignment record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the organizational policy assigned to this compliance program',
    `compliance_program_id` BIGINT COMMENT 'Foreign key to compliance_program. Identifies which compliance program this policy is assigned to.',
    `assigned_by` STRING COMMENT 'Name or role of the individual or committee that assigned this policy to this compliance program (e.g., Chief Compliance Officer, Compliance Committee).',
    `assignment_date` DATE COMMENT 'Date when this policy was formally assigned to this compliance program. Tracks the governance decision date.',
    `assignment_status` STRING COMMENT 'Current status of this program-policy assignment. Active assignments are in effect; suspended assignments are temporarily inactive; retired assignments are no longer in effect; under_review assignments are being evaluated for continued relevance.',
    `audit_frequency` STRING COMMENT 'Frequency at which compliance with this policy must be audited specifically under this compliance program. May differ from the programs general audit_frequency or the policys review cycle, as different programs may impose different audit requirements on the same policy.',
    `effective_date` DATE COMMENT 'Date when this policy became governed under this specific compliance program. May differ from the policys own effective_date if the policy was added to an existing program later.',
    `expiration_date` DATE COMMENT 'Date when this program-policy assignment expires or requires renewal. Nullable for permanent assignments.',
    `last_audit_date` DATE COMMENT 'Date when compliance with this policy was last audited specifically in the context of this compliance program. Tracks program-specific audit history, as the same policy may be audited at different times under different programs.',
    `last_review_date` DATE COMMENT 'Date when this program-policy assignment was last reviewed for continued relevance and accuracy.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this policy is mandatory (true) or optional (false) specifically within the context of this compliance program. A policy may be mandatory under one program but optional under another.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit of this policy under this specific compliance program. Calculated based on the program-specific audit_frequency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this program-policy assignment.',
    `program_scope_applicability` STRING COMMENT 'Description of how this policy applies within the scope of this specific compliance program. Captures program-specific applicability rules, exceptions, or scope limitations that may not apply when the same policy is governed under a different program.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance program policy assignment record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_program_policy_assignment PRIMARY KEY(`program_policy_assignment_id`)
) COMMENT 'Assignment of policies to compliance programs';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` (
    `policy_regulatory_impact_id` BIGINT COMMENT 'Unique identifier for this policy regulatory impact record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the organizational policy that was created, updated, or retired in response to the regulatory change.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer responsible for managing this specific policy response to this regulatory change. May differ from the overall regulatory change owner if different officers manage different policy impacts.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to the regulatory change that triggered the policy action.',
    `change_summary` STRING COMMENT 'Summary of the specific changes made to this policy in response to this regulatory change. Describes what was added, modified, or removed from the policy to achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy regulatory impact record was created in the system.',
    `effective_date` DATE COMMENT 'The date when the policy change or new policy becomes effective in response to the regulatory change. This is the date when the policy update driven by this regulatory change takes effect.',
    `impact_assessment_date` DATE COMMENT 'The date when the impact assessment for this regulatory change on this specific policy was completed.',
    `impact_assessment_status` STRING COMMENT 'Current status of the impact assessment for this specific regulatory change on this specific policy. Tracks the workflow state of evaluating how the regulatory change affects this policy.',
    `implementation_date` DATE COMMENT 'The date when the policy changes required by this regulatory change were fully implemented and operationalized across the organization.',
    `policy_version_created` STRING COMMENT 'The version number of the policy that was created or updated as a result of this regulatory change. Links the regulatory change to the specific policy version it triggered.',
    `response_type` STRING COMMENT 'The type of policy action taken in response to this regulatory change. Indicates whether a new policy was created, an existing policy was updated, a policy was retired, or no policy action was required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy regulatory impact record was last updated.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance policy regulatory impact record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_policy_regulatory_impact PRIMARY KEY(`policy_regulatory_impact_id`)
) COMMENT 'Mapping of policies to regulatory requirements they satisfy';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` (
    `policy_payer_applicability_id` BIGINT COMMENT 'Unique identifier for this policy-payer applicability record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the organizational policy that applies to this payer relationship.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to the insurance payer to whom this policy applies.',
    `attestation_required` BOOLEAN COMMENT 'Indicates whether the payer is required to formally attest to compliance with this policy as part of the contractual relationship. True for policies with regulatory or contractual attestation requirements.',
    `compliance_status` STRING COMMENT 'Current compliance status of the payer with respect to this policy. Compliant indicates the payer meets all policy requirements; non_compliant indicates violations or gaps; pending_review indicates assessment in progress; waived indicates formal exception granted; not_applicable indicates policy does not apply to this payer relationship.',
    `distribution_date` DATE COMMENT 'Date on which this policy was distributed or communicated to the payer. Tracks when the payer was notified of policy requirements.',
    `effective_date` DATE COMMENT 'Date on which this policy became applicable to this payer relationship. May differ from the policys overall effective date if the payer contract was established after policy adoption.',
    `last_compliance_review_date` DATE COMMENT 'Date on which compliance with this policy was most recently assessed for this payer relationship. Used for audit tracking and review cycle management.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this payer against this policy. Calculated based on policy review cycle and payer contract terms.',
    `notes` STRING COMMENT 'Free-text notes documenting payer-specific considerations, exceptions, or implementation details for this policy applicability. Used for operational context and audit trail.',
    `payer_acknowledgment_date` DATE COMMENT 'Date on which the payer formally acknowledged receipt and acceptance of this policy as part of the contractual relationship. Required for contract compliance and audit trail.',
    `payer_specific_version` STRING COMMENT 'Version identifier for the payer-specific adaptation or addendum to the base policy. Some payers require customized policy language or additional requirements beyond the base organizational policy.',
    `termination_date` DATE COMMENT 'Date on which this policy ceased to apply to this payer relationship. Nullable for ongoing applicability. Used when payer contracts end or policies are superseded.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance policy payer applicability record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `waiver_approval_authority` STRING COMMENT 'Individual, role, or committee that approved the waiver for this payer-policy combination. Nullable if no waiver granted.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a formal waiver or exception has been granted exempting this payer from this policy requirement. True indicates waiver in effect.',
    `waiver_justification` STRING COMMENT 'Business or regulatory justification for granting a waiver exempting this payer from this policy. Nullable if no waiver granted. Required for audit and governance documentation.',
    CONSTRAINT pk_policy_payer_applicability PRIMARY KEY(`policy_payer_applicability_id`)
) COMMENT 'Payer-specific policy applicability and requirements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Primary key for regulatory_requirement',
    `parent_regulatory_requirement_id` BIGINT COMMENT 'Self-referencing FK on regulatory_requirement (parent_regulatory_requirement_id)',
    `regulatory_superseded_by_requirement_id` BIGINT COMMENT 'Identifier of the regulatory requirement that supersedes this requirement, if applicable. Null if not superseded.',
    `applicability_scope` STRING COMMENT 'Description of which organizational units, facilities, or business processes this requirement applies to (e.g., all hospitals, outpatient clinics only, laboratories, covered entities).',
    `audit_frequency` STRING COMMENT 'Frequency at which audits or assessments must be conducted for this requirement, if audits are required.',
    `audit_required` BOOLEAN COMMENT 'Indicates whether periodic audits or assessments are required to verify compliance with this requirement (True) or not (False).',
    `compliance_frequency` STRING COMMENT 'Frequency at which compliance with this requirement must be demonstrated or assessed (e.g., continuous, annual, quarterly, monthly, event-driven, one-time).',
    `control_framework` STRING COMMENT 'Name of the internal control framework or compliance program that governs this requirement (e.g., HIPAA Compliance Program, Patient Safety Program, Infection Control Program).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was first created in the system.',
    `documentation_retention_years` STRING COMMENT 'Number of years that documentation demonstrating compliance with this requirement must be retained.',
    `effective_date` DATE COMMENT 'Date when the regulatory requirement became or will become enforceable.',
    `expiration_date` DATE COMMENT 'Date when the regulatory requirement is no longer enforceable or was superseded. Null for requirements that remain active indefinitely.',
    `implementation_guidance` STRING COMMENT 'Guidance notes or instructions for implementing this requirement within the organization.',
    `jurisdiction` STRING COMMENT 'Geographic or governmental scope of the requirement: federal, state, local, or international.',
    `jurisdiction_detail` STRING COMMENT 'Specific jurisdiction detail (e.g., state name, country code) when the requirement applies to a specific geographic area.',
    `last_reviewed_date` DATE COMMENT 'Date when this regulatory requirement record was last reviewed for accuracy and currency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this regulatory requirement record.',
    `penalty_amount_max` DECIMAL(18,2) COMMENT 'Maximum monetary penalty amount for noncompliance, if applicable. Null if no monetary penalty or penalty is not quantified.',
    `penalty_amount_min` DECIMAL(18,2) COMMENT 'Minimum monetary penalty amount for noncompliance, if applicable. Null if no monetary penalty or penalty is not quantified.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amounts (e.g., USD, EUR, GBP).',
    `penalty_for_noncompliance` STRING COMMENT 'Description of penalties, fines, sanctions, or enforcement actions that may result from noncompliance with this requirement.',
    `policy_reference` STRING COMMENT 'Reference to the internal policy or procedure document that implements this regulatory requirement.',
    `regulation_citation` STRING COMMENT 'Full legal citation or reference to the regulation section (e.g., 45 CFR 164.308(a)(1)(i), 42 CFR 482.13, 29 CFR 1910.1030).',
    `regulation_name` STRING COMMENT 'Name of the parent regulation, standard, or framework to which this requirement belongs (e.g., HIPAA Privacy Rule, CMS Conditions of Participation, Joint Commission National Patient Safety Goals).',
    `regulatory_body` STRING COMMENT 'Name of the governing body or agency that issued the requirement (e.g., HHS Office for Civil Rights, CMS, Joint Commission, OSHA, State Health Department).',
    `related_requirements` STRING COMMENT 'Comma-separated list of related requirement codes or identifiers that are connected to or dependent on this requirement.',
    `reporting_frequency` STRING COMMENT 'Frequency at which reports must be submitted to the regulatory body, if reporting is required.',
    `reporting_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates formal reporting to a regulatory body (True) or not (False).',
    `requirement_category` STRING COMMENT 'High-level classification of the regulatory requirement by domain (e.g., privacy, security, safety, quality, operational, financial, reporting).',
    `requirement_code` STRING COMMENT 'Externally-known unique code or identifier for the regulatory requirement (e.g., HIPAA-164.308, CMS-CoP-482.13, OSHA-1910.1030).',
    `requirement_description` STRING COMMENT 'Detailed description of the regulatory requirement, including scope, obligations, and compliance expectations.',
    `requirement_title` STRING COMMENT 'Human-readable title or name of the regulatory requirement.',
    `requirement_type` STRING COMMENT 'Classification of the requirement by enforcement level: mandatory (must comply), conditional (applies under certain conditions), recommended (best practice), or voluntary (optional).',
    `responsible_role` STRING COMMENT 'Job title or role responsible for ensuring compliance with this requirement (e.g., Chief Compliance Officer, Privacy Officer, Infection Control Director).',
    `risk_level` STRING COMMENT 'Organizational risk level associated with noncompliance with this requirement (critical, high, medium, low).',
    `source_document_url` STRING COMMENT 'URL or hyperlink to the official source document or regulatory text for this requirement.',
    `regulatory_requirement_status` STRING COMMENT 'Current lifecycle status of the regulatory requirement.',
    `training_frequency` STRING COMMENT 'Frequency at which staff training must be completed for this requirement, if training is required.',
    `training_required` BOOLEAN COMMENT 'Indicates whether staff training is required to comply with this requirement (True) or not (False).',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last modified this regulatory requirement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was last modified.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the compliance regulatory requirement record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this regulatory requirement record.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master list of regulatory requirements applicable to the organization';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_parent_compliance_program_id` FOREIGN KEY (`parent_compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_parent_obligation_id` FOREIGN KEY (`parent_obligation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_superseded_compliance_policy_id` FOREIGN KEY (`superseded_compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_superseded_version_policy_version_id` FOREIGN KEY (`primary_superseded_version_policy_version_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`policy_version`(`policy_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_parent_audit_finding_id` FOREIGN KEY (`parent_audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_primary_previous_finding_audit_finding_id` FOREIGN KEY (`primary_previous_finding_audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_hipaa_security_risk_id` FOREIGN KEY (`hipaa_security_risk_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`(`hipaa_security_risk_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_superseded_corrective_action_plan_id` FOREIGN KEY (`superseded_corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_parent_hipaa_privacy_incident_id` FOREIGN KEY (`parent_hipaa_privacy_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_prior_hipaa_security_risk_id` FOREIGN KEY (`prior_hipaa_security_risk_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`(`hipaa_security_risk_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_prerequisite_training_id` FOREIGN KEY (`prerequisite_training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_reattempted_training_completion_id` FOREIGN KEY (`reattempted_training_completion_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_primary_original_submission_compliance_regulatory_submission_id` FOREIGN KEY (`primary_original_submission_compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_prior_exclusion_screening_id` FOREIGN KEY (`prior_exclusion_screening_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_prior_conflict_of_interest_id` FOREIGN KEY (`prior_conflict_of_interest_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_original_hotline_report_id` FOREIGN KEY (`original_hotline_report_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_parent_investigation_id` FOREIGN KEY (`parent_investigation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_renewed_stark_arrangement_id` FOREIGN KEY (`renewed_stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_parent_osha_safety_program_id` FOREIGN KEY (`parent_osha_safety_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_parent_osha_exposure_incident_id` FOREIGN KEY (`parent_osha_exposure_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_prior_cms_condition_status_id` FOREIGN KEY (`prior_cms_condition_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_prior_accreditation_status_id` FOREIGN KEY (`prior_accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ADD CONSTRAINT `fk_compliance_business_associate_agreement_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ADD CONSTRAINT `fk_compliance_business_associate_agreement_renewed_business_associate_agreement_id` FOREIGN KEY (`renewed_business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_superseded_notice_of_privacy_practices_id` FOREIGN KEY (`superseded_notice_of_privacy_practices_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_parent_phi_access_log_id` FOREIGN KEY (`parent_phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reattested_attestation_id` FOREIGN KEY (`reattested_attestation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_follow_up_monitoring_activity_id` FOREIGN KEY (`follow_up_monitoring_activity_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ADD CONSTRAINT `fk_compliance_program_policy_assignment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ADD CONSTRAINT `fk_compliance_program_policy_assignment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ADD CONSTRAINT `fk_compliance_policy_regulatory_impact_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ADD CONSTRAINT `fk_compliance_policy_regulatory_impact_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ADD CONSTRAINT `fk_compliance_policy_payer_applicability_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_parent_regulatory_requirement_id` FOREIGN KEY (`parent_regulatory_requirement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_superseded_by_requirement_id` FOREIGN KEY (`regulatory_superseded_by_requirement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`compliance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`compliance` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_entity_type' = 'program');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot_note' = 'Retain both with distinct scope tags');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot_primary' = 'quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot_pair' = 'compliance.compliance_program');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` SET TAGS ('pii_duplicate_of' = 'quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `budget_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `parent_compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Parent Compliance Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `parent_compliance_program_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `audit_frequency` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `charter_document` SET TAGS ('pii_business_glossary_term' = 'Charter Document');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `charter_document` SET TAGS ('pii_classification' = 'document');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'contact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'contact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `effective_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `governing_body` SET TAGS ('pii_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `governing_body` SET TAGS ('pii_classification' = 'organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_audit_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_audit_result` SET TAGS ('pii_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_audit_result` SET TAGS ('pii_classification' = 'result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `modified_by` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `next_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `next_audit_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `next_review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `notes` SET TAGS ('pii_classification' = 'notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `objectives` SET TAGS ('pii_business_glossary_term' = 'Objectives');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `objectives` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Exposure Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('pii_classification' = 'financial');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `policy_count` SET TAGS ('pii_business_glossary_term' = 'Policy Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `policy_count` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_code` SET TAGS ('pii_classification' = 'code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_scope` SET TAGS ('pii_business_glossary_term' = 'Program Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_scope` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `program_type` SET TAGS ('pii_classification' = 'type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_classification' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `risk_level` SET TAGS ('pii_classification' = 'risk');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `training_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `training_frequency_months` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `training_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `website_url` SET TAGS ('pii_classification' = 'url');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ALTER COLUMN `created_by` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` SET TAGS ('pii_entity_type' = 'obligation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Parent Obligation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `training_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `assigned_department` SET TAGS ('pii_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `assigned_department` SET TAGS ('pii_classification' = 'department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `assigned_role` SET TAGS ('pii_business_glossary_term' = 'Assigned Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `assigned_role` SET TAGS ('pii_classification' = 'role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `attestation_frequency` SET TAGS ('pii_business_glossary_term' = 'Attestation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `attestation_frequency` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `attestation_required` SET TAGS ('pii_business_glossary_term' = 'Attestation Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `attestation_required` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_percentage` SET TAGS ('pii_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_percentage` SET TAGS ('pii_classification' = 'percentage');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `control_activity` SET TAGS ('pii_business_glossary_term' = 'Control Activity');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `control_activity` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('pii_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_required` SET TAGS ('pii_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_required` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_classification' = 'threshold');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_required` SET TAGS ('pii_business_glossary_term' = 'Evidence Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_required` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_retention_years` SET TAGS ('pii_business_glossary_term' = 'Evidence Retention Years');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_retention_years` SET TAGS ('pii_classification' = 'retention');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_type` SET TAGS ('pii_business_glossary_term' = 'Evidence Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_type` SET TAGS ('pii_classification' = 'type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `external_audit_scope` SET TAGS ('pii_business_glossary_term' = 'External Audit Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `external_audit_scope` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `finding_count` SET TAGS ('pii_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `finding_count` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `is_active` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `last_audit_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('pii_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('pii_classification' = 'result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('pii_classification' = 'notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('pii_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('pii_classification' = 'code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_classification' = 'type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `policy_reference` SET TAGS ('pii_business_glossary_term' = 'Policy Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `policy_reference` SET TAGS ('pii_classification' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('pii_classification' = 'priority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_business_glossary_term' = 'Procedure Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_classification' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_classification' = 'pattern');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_classification' = 'authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_classification' = 'citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'risk');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` SET TAGS ('pii_entity_type' = 'policy');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `superseded_compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Compliance Policy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `superseded_compliance_policy_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `approval_authority` SET TAGS ('pii_classification' = 'authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `approval_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_business_glossary_term' = 'Author Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_classification' = 'contact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `author_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_classification' = 'confidentiality');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `distribution_list` SET TAGS ('pii_classification' = 'distribution');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `document_location_url` SET TAGS ('pii_business_glossary_term' = 'Document Location URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `document_location_url` SET TAGS ('pii_classification' = 'url');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('pii_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('pii_classification' = 'mechanism');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `keywords` SET TAGS ('pii_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `keywords` SET TAGS ('pii_classification' = 'keywords');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `last_review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `next_review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `non_compliance_consequence` SET TAGS ('pii_business_glossary_term' = 'Non Compliance Consequence');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `non_compliance_consequence` SET TAGS ('pii_classification' = 'consequence');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `owner_department` SET TAGS ('pii_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `owner_department` SET TAGS ('pii_classification' = 'department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `owner_role` SET TAGS ('pii_classification' = 'role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_category` SET TAGS ('pii_classification' = 'category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_classification' = 'code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `public_facing_flag` SET TAGS ('pii_business_glossary_term' = 'Public Facing Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `public_facing_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `purpose` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `regulatory_requirement_satisfied` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Satisfied');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `regulatory_requirement_satisfied` SET TAGS ('pii_classification' = 'requirement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_business_glossary_term' = 'Related Procedure References');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_classification' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_standard_references` SET TAGS ('pii_business_glossary_term' = 'Related Standard References');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `related_standard_references` SET TAGS ('pii_classification' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `retired_reason` SET TAGS ('pii_business_glossary_term' = 'Retired Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `retired_reason` SET TAGS ('pii_classification' = 'reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `retired_timestamp` SET TAGS ('pii_business_glossary_term' = 'Retired Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `retired_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `scope_of_application` SET TAGS ('pii_business_glossary_term' = 'Scope Of Application');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `scope_of_application` SET TAGS ('pii_classification' = 'scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `subcategory` SET TAGS ('pii_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `subcategory` SET TAGS ('pii_classification' = 'category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `summary` SET TAGS ('pii_business_glossary_term' = 'Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `summary` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `supersedes_policy_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `supersedes_policy_number` SET TAGS ('pii_classification' = 'code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `title` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `training_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `training_frequency_months` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `training_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ALTER COLUMN `version_number` SET TAGS ('pii_classification' = 'version');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` SET TAGS ('pii_entity_type' = 'version');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `policy_version_id` SET TAGS ('pii_business_glossary_term' = 'Policy Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `policy_version_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_business_glossary_term' = 'Primary Policy Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_superseded_version_policy_version_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Version Policy Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `primary_superseded_version_policy_version_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `approval_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `change_summary` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `comment_log` SET TAGS ('pii_business_glossary_term' = 'Comment Log');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `comment_log` SET TAGS ('pii_classification' = 'notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `distribution_list` SET TAGS ('pii_classification' = 'distribution');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `document_checksum` SET TAGS ('pii_business_glossary_term' = 'Document Checksum');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `document_checksum` SET TAGS ('pii_classification' = 'checksum');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `document_url` SET TAGS ('pii_classification' = 'url');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `effective_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `language_code` SET TAGS ('pii_classification' = 'language');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `policy_type` SET TAGS ('pii_classification' = 'type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `publication_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_classification' = 'citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_classification' = 'driver');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `retirement_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `retirement_reason` SET TAGS ('pii_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `retirement_reason` SET TAGS ('pii_classification' = 'reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `review_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `scope_description` SET TAGS ('pii_classification' = 'description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `training_due_days` SET TAGS ('pii_business_glossary_term' = 'Training Due Days');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `training_due_days` SET TAGS ('pii_classification' = 'threshold');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `training_required_flag` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Version Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_created_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Version Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_modified_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('pii_classification' = 'version');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_status` SET TAGS ('pii_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_title` SET TAGS ('pii_business_glossary_term' = 'Version Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ALTER COLUMN `version_title` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` SET TAGS ('pii_entity_type' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Audited Cost Center Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `care_site_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Audit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `payer_id` SET TAGS ('pii_classification' = 'identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_classification' = 'decision');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('pii_classification' = 'type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_business_glossary_term' = 'Auditing Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_classification' = 'organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_submitted_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('pii_business_glossary_term' = 'Cost');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('pii_classification' = 'financial');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `department_audited` SET TAGS ('pii_business_glossary_term' = 'Department Audited');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `department_audited` SET TAGS ('pii_classification' = 'department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `external_auditor_organization` SET TAGS ('pii_business_glossary_term' = 'External Auditor Organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `external_auditor_organization` SET TAGS ('pii_classification' = 'organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `findings_count` SET TAGS ('pii_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `findings_count` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_completion_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_completion_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'Follow Up Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_status` SET TAGS ('pii_classification' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('pii_classification' = 'frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `is_unannounced` SET TAGS ('pii_business_glossary_term' = 'Is Unannounced');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `is_unannounced` SET TAGS ('pii_classification' = 'flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_classification' = 'contact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('pii_classification' = 'methodology');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `modified_by_user` SET TAGS ('pii_classification' = 'audit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `monetary_penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Monetary Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `monetary_penalty_amount` SET TAGS ('pii_classification' = 'financial');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_business_glossary_term' = 'Audit Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_classification' = 'name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `notification_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `overall_outcome` SET TAGS ('pii_business_glossary_term' = 'Overall Outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `overall_outcome` SET TAGS ('pii_classification' = 'outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_classification' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `report_document_path` SET TAGS ('pii_business_glossary_term' = 'Report Document Path');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `report_document_path` SET TAGS ('pii_classification' = 'path');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('pii_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('pii_classification' = 'risk');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `sample_size` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_classification' = 'date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `scope` SET TAGS ('pii_classification' = 'scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `team_size` SET TAGS ('pii_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `team_size` SET TAGS ('pii_classification' = 'count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `trigger` SET TAGS ('pii_business_glossary_term' = 'Trigger');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ALTER COLUMN `trigger` SET TAGS ('pii_classification' = 'trigger');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` SET TAGS ('pii_entity_type' = 'finding');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Affected Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Related Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `parent_audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Related Audit Finding Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `parent_audit_finding_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `primary_previous_finding_audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `accreditation_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Accreditation Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_department` SET TAGS ('pii_business_glossary_term' = 'Affected Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_organization` SET TAGS ('pii_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `days_to_resolution` SET TAGS ('pii_business_glossary_term' = 'Days to Resolution');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `dispute_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `evidence_location` SET TAGS ('pii_business_glossary_term' = 'Evidence Location');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_penalty_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Penalty Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('pii_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_value_regex' = 'open|in_remediation|pending_verification|closed|disputed|deferred');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'deficiency|observation|opportunity_for_improvement|immediate_jeopardy|condition_level_deficiency|best_practice_gap');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('pii_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_standard_cited` SET TAGS ('pii_business_glossary_term' = 'Regulatory Standard Cited');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_authority_date` SET TAGS ('pii_business_glossary_term' = 'Reported to Authority Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `scope_of_impact` SET TAGS ('pii_business_glossary_term' = 'Scope of Impact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `scope_of_impact` SET TAGS ('pii_value_regex' = 'isolated|pattern|widespread|systemic');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `tags_keywords` SET TAGS ('pii_business_glossary_term' = 'Tags and Keywords');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `target_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_entity_type' = 'action_plan');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Related Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Incident Hipaa Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `hipaa_security_risk_id` SET TAGS ('pii_business_glossary_term' = 'Security Risk Hipaa Security Risk Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `superseded_corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Corrective Action Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `superseded_corrective_action_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('pii_value_regex' = '^CAP-[0-9]{6,10}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_type` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_type` SET TAGS ('pii_value_regex' = 'plan_of_correction|corrective_action_plan|preventive_action|immediate_action');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `closure_notes` SET TAGS ('pii_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_actions_defined` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions Defined');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `external_consultant_engaged_flag` SET TAGS ('pii_business_glossary_term' = 'External Consultant Engaged Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `implementation_milestones` SET TAGS ('pii_business_glossary_term' = 'Implementation Milestones');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annually|continuous');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('pii_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulator_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulator Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulator_feedback` SET TAGS ('pii_business_glossary_term' = 'Regulator Feedback');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner Email Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_classification' = 'PII');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_pattern' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis_summary` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis (RCA) Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `staff_affected_count` SET TAGS ('pii_business_glossary_term' = 'Staff Affected Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `submitted_to_regulator_date` SET TAGS ('pii_business_glossary_term' = 'Submitted to Regulator Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_completion_target_date` SET TAGS ('pii_business_glossary_term' = 'Training Completion Target Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_outcome` SET TAGS ('pii_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_outcome` SET TAGS ('pii_value_regex' = 'verified_effective|verified_partial|not_verified|requires_additional_action');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` SET TAGS ('pii_entity_type' = 'incident');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'HIPAA Privacy Incident ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `note_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `parent_hipaa_privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Related Hipaa Privacy Incident Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `parent_hipaa_privacy_incident_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `affected_individuals_count` SET TAGS ('pii_business_glossary_term' = 'Affected Individuals Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_date` SET TAGS ('pii_business_glossary_term' = 'Breach Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_outcome` SET TAGS ('pii_business_glossary_term' = 'Breach Determination Outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_outcome` SET TAGS ('pii_value_regex' = 'breach|not a breach|low probability of compromise|pending determination');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `disciplinary_action_taken_flag` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Taken Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `discovery_date` SET TAGS ('pii_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_category` SET TAGS ('pii_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_category` SET TAGS ('pii_value_regex' = 'technical|human error|malicious|physical|administrative');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `individual_notification_date` SET TAGS ('pii_business_glossary_term' = 'Individual Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `individual_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Individual Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `investigation_summary` SET TAGS ('pii_business_glossary_term' = 'Investigation Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('pii_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('pii_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `location_of_incident` SET TAGS ('pii_business_glossary_term' = 'Location of Incident');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `media_notification_date` SET TAGS ('pii_business_glossary_term' = 'Media Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `media_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Media Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_case_number` SET TAGS ('pii_business_glossary_term' = 'Office for Civil Rights (OCR) Case Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Office for Civil Rights (OCR) Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_business_glossary_term' = 'Office for Civil Rights (OCR) Reporting Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_value_regex' = 'not required|pending|submitted|acknowledged|under investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_submission_date` SET TAGS ('pii_business_glossary_term' = 'Office for Civil Rights (OCR) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_involved_flag` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Involved Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_type` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_volume_records` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Volume Records');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `policy_violation_flag` SET TAGS ('pii_business_glossary_term' = 'Policy Violation Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `privacy_officer_assigned` SET TAGS ('pii_business_glossary_term' = 'Privacy Officer Assigned');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `privacy_officer_assigned` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `remediation_actions_taken` SET TAGS ('pii_business_glossary_term' = 'Remediation Actions Taken');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_department` SET TAGS ('pii_business_glossary_term' = 'Reported By Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_business_glossary_term' = 'Reported By Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_role` SET TAGS ('pii_business_glossary_term' = 'Reported By Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `risk_assessment_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `risk_assessment_summary` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` SET TAGS ('pii_entity_type' = 'risk');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `hipaa_security_risk_id` SET TAGS ('pii_business_glossary_term' = 'HIPAA Security Risk Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Related Audit Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Affected Asset Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `prior_hipaa_security_risk_id` SET TAGS ('pii_business_glossary_term' = 'Prior Hipaa Security Risk Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `prior_hipaa_security_risk_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Related Incident Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `tertiary_hipaa_identified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Identified By Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `tertiary_hipaa_identified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `tertiary_hipaa_identified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `affected_ephi_system` SET TAGS ('pii_business_glossary_term' = 'Affected Electronic Protected Health Information (ePHI) System');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `control_effectiveness` SET TAGS ('pii_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `control_effectiveness` SET TAGS ('pii_value_regex' = 'effective|partially_effective|ineffective|not_implemented');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_business_glossary_term' = 'Existing Controls');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `existing_controls` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `identification_method` SET TAGS ('pii_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `impact_score` SET TAGS ('pii_business_glossary_term' = 'Impact Score');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `inherent_risk_level` SET TAGS ('pii_business_glossary_term' = 'Inherent Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `inherent_risk_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `inherent_risk_score` SET TAGS ('pii_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `likelihood_score` SET TAGS ('pii_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `mitigation_actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `mitigation_controls_implemented` SET TAGS ('pii_business_glossary_term' = 'Mitigation Controls Implemented');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `mitigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `mitigation_target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation Target Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `residual_risk_score` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Risk Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_acceptance_justification` SET TAGS ('pii_business_glossary_term' = 'Risk Acceptance Justification');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_assessment_cycle_code` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Cycle Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'administrative|physical|technical|organizational');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_number` SET TAGS ('pii_business_glossary_term' = 'Risk Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_owner_department` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_status` SET TAGS ('pii_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_status` SET TAGS ('pii_value_regex' = 'open|in_progress|mitigated|accepted|closed');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_subcategory` SET TAGS ('pii_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_title` SET TAGS ('pii_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_business_glossary_term' = 'Risk Treatment Decision');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_value_regex' = 'accept|mitigate|transfer|avoid');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `risk_treatment_decision` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `threat_description` SET TAGS ('pii_business_glossary_term' = 'Threat Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ALTER COLUMN `vulnerability_description` SET TAGS ('pii_business_glossary_term' = 'Vulnerability Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` SET TAGS ('pii_entity_type' = 'training');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Program ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `prerequisite_training_id` SET TAGS ('pii_business_glossary_term' = 'Prerequisite Training Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `prerequisite_training_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Training Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `assessment_required_flag` SET TAGS ('pii_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `certificate_issued_flag` SET TAGS ('pii_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `content_author` SET TAGS ('pii_business_glossary_term' = 'Content Author');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `content_location_url` SET TAGS ('pii_business_glossary_term' = 'Content Location URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `content_owner` SET TAGS ('pii_business_glossary_term' = 'Content Owner');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_description` SET TAGS ('pii_business_glossary_term' = 'Training Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Training Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Escalation Threshold in Days');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Training Format');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Training Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `frequency_months` SET TAGS ('pii_business_glossary_term' = 'Frequency in Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `keywords` SET TAGS ('pii_business_glossary_term' = 'Training Keywords');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `learning_objectives` SET TAGS ('pii_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_business_glossary_term' = 'Training Program Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `non_compliance_consequence` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `passing_score_threshold` SET TAGS ('pii_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `policy_reference` SET TAGS ('pii_business_glossary_term' = 'Policy Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Training Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `regulatory_mandate` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `retired_reason` SET TAGS ('pii_business_glossary_term' = 'Training Retired Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `retired_timestamp` SET TAGS ('pii_business_glossary_term' = 'Training Retired Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `supersedes_training_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Training Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `target_department` SET TAGS ('pii_business_glossary_term' = 'Target Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `target_role` SET TAGS ('pii_business_glossary_term' = 'Target Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_number` SET TAGS ('pii_business_glossary_term' = 'Training Program Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_number` SET TAGS ('pii_value_regex' = '^TRN-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('pii_business_glossary_term' = 'Training Program Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Under Development|Under Review|Retired|Suspended');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `training_type` SET TAGS ('pii_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_course_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Course ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Training Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Training Version Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` SET TAGS ('pii_entity_type' = 'completion');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `reattempted_training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Reattempted Training Completion Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `reattempted_training_completion_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Training Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Training Assigned Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `attempt_number` SET TAGS ('pii_business_glossary_term' = 'Training Attempt Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `certificate_issued_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('pii_business_glossary_term' = 'Training Completion Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_status` SET TAGS ('pii_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_business_glossary_term' = 'Continuing Education (CE) Credits');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `credit_type` SET TAGS ('pii_business_glossary_term' = 'Continuing Education Credit Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `credit_type` SET TAGS ('pii_value_regex' = 'cme|ceu|cne|contact_hours|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Training Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_department` SET TAGS ('pii_business_glossary_term' = 'Employee Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_facility` SET TAGS ('pii_business_glossary_term' = 'Employee Facility');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_role` SET TAGS ('pii_business_glossary_term' = 'Employee Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Training Escalation Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Training Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('pii_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_business_glossary_term' = 'Training Pass or Fail Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_value_regex' = 'pass|fail|not_applicable|pending');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('pii_business_glossary_term' = 'Training Passing Score Threshold');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `regulatory_requirement_satisfied` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Satisfied');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `reminder_sent_count` SET TAGS ('pii_business_glossary_term' = 'Training Reminder Sent Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `score_achieved` SET TAGS ('pii_business_glossary_term' = 'Training Score Achieved');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_location` SET TAGS ('pii_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('pii_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('pii_value_regex' = 'online|in_person|blended|self_study|webinar|simulation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `waiver_approval_date` SET TAGS ('pii_business_glossary_term' = 'Training Waiver Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('pii_business_glossary_term' = 'Training Waiver Approved By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `waiver_flag` SET TAGS ('pii_business_glossary_term' = 'Training Waiver Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('pii_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_entity_type' = 'submission');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot_pair' = 'research.research_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot_reference' = 'research.research_regulatory_submission');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` SET TAGS ('pii_ssot_primary' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Submitting Entity Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `primary_compliance_prepared_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `primary_compliance_prepared_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `primary_compliance_prepared_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `primary_original_submission_compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Original Submission Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_business_glossary_term' = 'Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `acknowledgment_number` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `acknowledgment_received_flag` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_business_glossary_term' = 'Attestation Officer Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_officer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `audit_result` SET TAGS ('pii_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `audit_result` SET TAGS ('pii_value_regex' = 'PASSED|FAILED|CONDITIONAL|PENDING|NOT_AUDITED');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `document_location_url` SET TAGS ('pii_business_glossary_term' = 'Document Location Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `external_audit_flag` SET TAGS ('pii_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `penalty_currency_code` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `penalty_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `receiving_agency` SET TAGS ('pii_business_glossary_term' = 'Receiving Agency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `receiving_agency_code` SET TAGS ('pii_business_glossary_term' = 'Receiving Agency Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `resubmission_required_flag` SET TAGS ('pii_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_format` SET TAGS ('pii_business_glossary_term' = 'Submission Format');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_priority` SET TAGS ('pii_business_glossary_term' = 'Submission Priority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_priority` SET TAGS ('pii_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_business_glossary_term' = 'Submitting Entity National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ALTER COLUMN `submitting_entity_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` SET TAGS ('pii_entity_type' = 'screening');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_screening_id` SET TAGS ('pii_business_glossary_term' = 'Exclusion Screening ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Screened Individual ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `prior_exclusion_screening_id` SET TAGS ('pii_business_glossary_term' = 'Prior Exclusion Screening Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `prior_exclusion_screening_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_business_glossary_term' = 'Reference Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Screened Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_authority` SET TAGS ('pii_business_glossary_term' = 'Exclusion Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_date` SET TAGS ('pii_business_glossary_term' = 'Exclusion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('pii_business_glossary_term' = 'Exclusion Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_business_glossary_term' = 'Exclusion Waiver State');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `match_confidence_level` SET TAGS ('pii_business_glossary_term' = 'Match Confidence Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `match_confidence_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `match_details` SET TAGS ('pii_business_glossary_term' = 'Match Details');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `match_found_flag` SET TAGS ('pii_business_glossary_term' = 'Match Found Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `next_screening_date` SET TAGS ('pii_business_glossary_term' = 'Next Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'pending_review|cleared|confirmed_exclusion|action_taken|escalated');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_business_glossary_term' = 'Screened Business Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_business_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Screened Individual Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('pii_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('pii_value_regex' = 'employee|contractor|vendor|medical_staff|volunteer|board_member');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_business_glossary_term' = 'Screened Individual First Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_business_glossary_term' = 'Screened Individual Last Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_business_glossary_term' = 'Screened Individual Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_business_glossary_term' = 'Screened Entity State');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_date` SET TAGS ('pii_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Screening Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_business_glossary_term' = 'Screening Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_value_regex' = 'automated|manual|vendor_service');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_value_regex' = 'clear|match_found|inconclusive|error');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_business_glossary_term' = 'Screening Source');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_value_regex' = 'oig_leie|sam_gov|state_medicaid|combined');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Screening Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_business_glossary_term' = 'Screening Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` SET TAGS ('pii_entity_type' = 'disclosure');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('pii_business_glossary_term' = 'Conflict of Interest (COI) ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Disclosing Individual ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `prior_conflict_of_interest_id` SET TAGS ('pii_business_glossary_term' = 'Prior Conflict Of Interest Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `prior_conflict_of_interest_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `approval_authority` SET TAGS ('pii_value_regex' = 'compliance_officer|ethics_committee|chief_compliance_officer|board_of_directors|department_head');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_business_glossary_term' = 'Attestation Statement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `attestation_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_business_glossary_term' = 'Disclosed Entity Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosed_entity_type` SET TAGS ('pii_business_glossary_term' = 'Disclosed Entity Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosing_individual_role` SET TAGS ('pii_business_glossary_term' = 'Disclosing Individual Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosing_individual_role` SET TAGS ('pii_value_regex' = 'employee|medical_staff|board_member|contractor|volunteer|vendor_representative');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_number` SET TAGS ('pii_business_glossary_term' = 'Conflict of Interest (COI) Disclosure Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_number` SET TAGS ('pii_value_regex' = '^COI-[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_status` SET TAGS ('pii_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_status` SET TAGS ('pii_value_regex' = 'submitted|under_review|approved|approved_with_mitigation|rejected|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_type` SET TAGS ('pii_business_glossary_term' = 'Disclosure Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `disclosure_type` SET TAGS ('pii_value_regex' = 'initial|annual_recertification|material_change|ad_hoc');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `estimated_value_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `estimated_value_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `last_recertification_date` SET TAGS ('pii_business_glossary_term' = 'Last Recertification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_effective_date` SET TAGS ('pii_business_glossary_term' = 'Mitigation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `mitigation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Mitigation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `recertification_due_date` SET TAGS ('pii_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `rejection_reason` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `relationship_description` SET TAGS ('pii_business_glossary_term' = 'Relationship Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `relationship_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `relationship_type` SET TAGS ('pii_value_regex' = 'financial_interest|outside_employment|family_relationship|vendor_relationship|research_sponsorship|consulting_arrangement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `value_range` SET TAGS ('pii_business_glossary_term' = 'Value Range');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ALTER COLUMN `value_range` SET TAGS ('pii_value_regex' = 'under_5000|5000_to_25000|25000_to_100000|over_100000|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` SET TAGS ('pii_entity_type' = 'report');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `hotline_report_id` SET TAGS ('pii_business_glossary_term' = 'Hotline Report ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `original_hotline_report_id` SET TAGS ('pii_business_glossary_term' = 'Original Hotline Report Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `original_hotline_report_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reporter Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `tertiary_hotline_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `tertiary_hotline_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `tertiary_hotline_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `allegation_category` SET TAGS ('pii_business_glossary_term' = 'Allegation Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `allegation_category` SET TAGS ('pii_value_regex' = 'billing_fraud|privacy_violation|workplace_safety|abuse_neglect|conflict_of_interest|retaliation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `allegation_description` SET TAGS ('pii_business_glossary_term' = 'Allegation Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `allegation_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `allegation_subcategory` SET TAGS ('pii_business_glossary_term' = 'Allegation Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_business_glossary_term' = 'Assigned Investigator Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `case_notes` SET TAGS ('pii_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `case_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'highly_confidential|confidential|internal|restricted');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `department_implicated` SET TAGS ('pii_business_glossary_term' = 'Department Implicated');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `disposition` SET TAGS ('pii_value_regex' = 'substantiated|unsubstantiated|inconclusive|pending');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `disposition_notes` SET TAGS ('pii_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `disposition_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `incident_date_range_end` SET TAGS ('pii_business_glossary_term' = 'Incident Date Range End');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `incident_date_range_start` SET TAGS ('pii_business_glossary_term' = 'Incident Date Range Start');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_business_glossary_term' = 'Individual Implicated Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `individual_implicated_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `investigation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `investigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `investigation_status` SET TAGS ('pii_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `investigation_status` SET TAGS ('pii_value_regex' = 'new|assigned|in_progress|pending_info|completed|closed');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_notification_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_channel` SET TAGS ('pii_business_glossary_term' = 'Report Channel');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_channel` SET TAGS ('pii_value_regex' = 'hotline|online_portal|direct_report|email|mail|in_person');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_date` SET TAGS ('pii_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_number` SET TAGS ('pii_value_regex' = '^HR-[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `report_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_anonymity_flag` SET TAGS ('pii_business_glossary_term' = 'Reporter Anonymity Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_business_glossary_term' = 'Reporter Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Reporter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_business_glossary_term' = 'Reporter Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `reporter_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `retaliation_concern_flag` SET TAGS ('pii_business_glossary_term' = 'Retaliation Concern Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` SET TAGS ('pii_entity_type' = 'investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `hotline_report_id` SET TAGS ('pii_business_glossary_term' = 'Hotline Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_investigator_employee_id` SET TAGS ('pii_business_glossary_term' = 'Investigator Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_investigator_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_investigator_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `parent_investigation_id` SET TAGS ('pii_business_glossary_term' = 'Related Investigation Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `parent_investigation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Incident Hipaa Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `close_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `conclusion` SET TAGS ('pii_business_glossary_term' = 'Investigation Conclusion');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `conclusion` SET TAGS ('pii_value_regex' = 'violation_confirmed|no_violation|inconclusive|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `department_involved` SET TAGS ('pii_business_glossary_term' = 'Department Involved');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `disciplinary_action_taken_flag` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Taken Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `external_referral_agency` SET TAGS ('pii_business_glossary_term' = 'External Referral Agency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `external_referral_date` SET TAGS ('pii_business_glossary_term' = 'External Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('pii_business_glossary_term' = 'Investigation Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('pii_value_regex' = '^INV-[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('pii_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('pii_value_regex' = 'initiated|active|suspended|closed|escalated|referred_external');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('pii_business_glossary_term' = 'Investigation Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('pii_value_regex' = 'privacy_breach|billing_fraud|workplace_safety|abuse_neglect|anti_kickback|stark_violation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_business_glossary_term' = 'Investigator Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `legal_privilege_asserted_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Privilege Asserted Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `patient_count` SET TAGS ('pii_business_glossary_term' = 'Patient Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `patient_involved_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Involved Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `recommended_actions` SET TAGS ('pii_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'extreme|high|moderate|low|minimal');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Investigation Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `self_disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Self-Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `self_disclosure_required_flag` SET TAGS ('pii_business_glossary_term' = 'Self-Disclosure Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `target_due_date` SET TAGS ('pii_business_glossary_term' = 'Target Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `trigger_source` SET TAGS ('pii_business_glossary_term' = 'Trigger Source');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ALTER COLUMN `violation_confirmed_flag` SET TAGS ('pii_business_glossary_term' = 'Violation Confirmed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` SET TAGS ('pii_entity_type' = 'arrangement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Stark Arrangement ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Physician ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Entity ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_business_glossary_term' = 'Reference Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `renewed_stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Renewed Stark Arrangement Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `renewed_stark_arrangement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_value_regex' = 'active|expired|under_review|pending_approval|terminated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `commercial_reasonableness_determination` SET TAGS ('pii_business_glossary_term' = 'Commercial Reasonableness Determination');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `commercial_reasonableness_determination` SET TAGS ('pii_value_regex' = 'reasonable|not_reasonable|under_review|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `commercial_reasonableness_rationale` SET TAGS ('pii_business_glossary_term' = 'Commercial Reasonableness Rationale');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_amount` SET TAGS ('pii_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_frequency` SET TAGS ('pii_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_frequency` SET TAGS ('pii_value_regex' = 'annual|monthly|biweekly|weekly|per_service|one_time');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_frequency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_frequency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_structure` SET TAGS ('pii_business_glossary_term' = 'Compensation Structure');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_structure` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `compensation_structure` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `contract_document_location` SET TAGS ('pii_business_glossary_term' = 'Contract Document Location');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_business_glossary_term' = 'Designated Health Services (DHS) Involved');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `designated_health_services_involved` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `disclosure_reference_number` SET TAGS ('pii_business_glossary_term' = 'Disclosure Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `disclosure_required_flag` SET TAGS ('pii_business_glossary_term' = 'Disclosure Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `exception_criteria_met` SET TAGS ('pii_business_glossary_term' = 'Exception Criteria Met');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `fmv_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Fair Market Value (FMV) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `fmv_determination_method` SET TAGS ('pii_business_glossary_term' = 'Fair Market Value (FMV) Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `fmv_determination_method` SET TAGS ('pii_value_regex' = 'independent_valuation|survey_data|internal_analysis|comparable_arrangements|other');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `fmv_opinion_date` SET TAGS ('pii_business_glossary_term' = 'Fair Market Value (FMV) Opinion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `fmv_opinion_source` SET TAGS ('pii_business_glossary_term' = 'Fair Market Value (FMV) Opinion Source');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_approval_status` SET TAGS ('pii_business_glossary_term' = 'Legal Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_approval_status` SET TAGS ('pii_value_regex' = 'approved|conditional_approval|not_approved|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_review_date` SET TAGS ('pii_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `referral_volume_tracking_required` SET TAGS ('pii_business_glossary_term' = 'Referral Volume Tracking Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `stark_exception_applied` SET TAGS ('pii_business_glossary_term' = 'Stark Exception Applied');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` SET TAGS ('pii_entity_type' = 'program');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Safety Program ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `parent_osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Parent Osha Safety Program Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `parent_osha_safety_program_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Safety Program Owner Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Safety Program Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Safety Program Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `attestation_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Attestation Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `attestation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `document_location_url` SET TAGS ('pii_business_glossary_term' = 'Safety Program Document Location Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Safety Program Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `enforcement_mechanism` SET TAGS ('pii_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Safety Program Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `external_audit_scope_flag` SET TAGS ('pii_business_glossary_term' = 'External Audit Scope Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `finding_count` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `keywords` SET TAGS ('pii_business_glossary_term' = 'Safety Program Keywords');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `last_audit_result` SET TAGS ('pii_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `last_audit_result` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partially_compliant|not_audited');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Safety Program Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Safety Program Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `non_compliance_consequence` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Safety Program Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `osha_standard_citation` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Standard Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Safety Program Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_number` SET TAGS ('pii_business_glossary_term' = 'Safety Program Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_owner_department` SET TAGS ('pii_business_glossary_term' = 'Safety Program Owner Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_purpose` SET TAGS ('pii_business_glossary_term' = 'Safety Program Purpose');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_scope` SET TAGS ('pii_business_glossary_term' = 'Safety Program Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Safety Program Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_status` SET TAGS ('pii_value_regex' = 'active|under_review|suspended|retired|draft|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_summary` SET TAGS ('pii_business_glossary_term' = 'Safety Program Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Safety Program Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'bloodborne_pathogens|hazard_communication|respiratory_protection|ergonomics|workplace_violence|emergency_action');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_policy_references` SET TAGS ('pii_business_glossary_term' = 'Related Policy References');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_business_glossary_term' = 'Related Procedure References');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `related_procedure_references` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `retired_reason` SET TAGS ('pii_business_glossary_term' = 'Safety Program Retired Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `retired_timestamp` SET TAGS ('pii_business_glossary_term' = 'Safety Program Retired Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Safety Program Review Cycle Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Safety Program Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `supersedes_program_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Safety Program Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `training_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Training Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Safety Program Version Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` SET TAGS ('pii_subdomain' = 'risk_investigation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` SET TAGS ('pii_entity_type' = 'incident');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `osha_exposure_incident_id` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Exposure Incident Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Source Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `parent_osha_exposure_incident_id` SET TAGS ('pii_business_glossary_term' = 'Related Osha Exposure Incident Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `parent_osha_exposure_incident_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Exposed Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `tertiary_osha_employee_id` SET TAGS ('pii_business_glossary_term' = 'Investigating Officer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `tertiary_osha_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `tertiary_osha_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Testing Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `baseline_testing_completed_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `corrective_actions_implemented` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions Implemented');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('pii_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `days_of_job_transfer_restriction` SET TAGS ('pii_business_glossary_term' = 'Days of Job Transfer or Restriction');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposed_employee_department` SET TAGS ('pii_business_glossary_term' = 'Exposed Employee Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposed_employee_job_title` SET TAGS ('pii_business_glossary_term' = 'Exposed Employee Job Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposure_route` SET TAGS ('pii_business_glossary_term' = 'Exposure Route');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposure_route` SET TAGS ('pii_value_regex' = 'percutaneous|mucous_membrane|non_intact_skin|inhalation|ingestion|other');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposure_type` SET TAGS ('pii_business_glossary_term' = 'Exposure Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `exposure_type` SET TAGS ('pii_value_regex' = 'bloodborne_pathogen|chemical|respiratory|radiation|biological_non_bloodborne|other');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Testing Schedule');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `follow_up_testing_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_location` SET TAGS ('pii_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Incident Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_value_regex' = 'open|under_investigation|follow_up_in_progress|closed|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `incident_time` SET TAGS ('pii_business_glossary_term' = 'Incident Time');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `investigation_notes` SET TAGS ('pii_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `osha_recordable_determination_date` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `pep_initiated_flag` SET TAGS ('pii_business_glossary_term' = 'Post-Exposure Prophylaxis (PEP) Initiated Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `pep_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Post-Exposure Prophylaxis (PEP) Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `pep_type` SET TAGS ('pii_business_glossary_term' = 'Post-Exposure Prophylaxis (PEP) Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_business_glossary_term' = 'Procedure Being Performed');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `procedure_being_performed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `safety_engineered_device_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Engineered Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `sharps_device_brand` SET TAGS ('pii_business_glossary_term' = 'Sharps Device Brand');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `sharps_device_type` SET TAGS ('pii_business_glossary_term' = 'Sharps Device Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hbv_status` SET TAGS ('pii_business_glossary_term' = 'Source Patient Hepatitis B Virus (HBV) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hbv_status` SET TAGS ('pii_value_regex' = 'positive|negative|unknown|declined');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hbv_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hbv_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hcv_status` SET TAGS ('pii_business_glossary_term' = 'Source Patient Hepatitis C Virus (HCV) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hcv_status` SET TAGS ('pii_value_regex' = 'positive|negative|unknown|declined');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hcv_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hcv_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hiv_status` SET TAGS ('pii_business_glossary_term' = 'Source Patient Human Immunodeficiency Virus (HIV) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hiv_status` SET TAGS ('pii_value_regex' = 'positive|negative|unknown|declined');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hiv_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_hiv_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_known_flag` SET TAGS ('pii_business_glossary_term' = 'Source Patient Known Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `source_patient_tested_flag` SET TAGS ('pii_business_glossary_term' = 'Source Patient Tested Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `workers_comp_claim_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Workers Compensation Claim Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('pii_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` SET TAGS ('pii_entity_type' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Condition Status ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_business_glossary_term' = 'Prior Cms Condition Status Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `prior_cms_condition_status_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `certification_effective_date` SET TAGS ('pii_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `certification_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `certification_status` SET TAGS ('pii_value_regex' = 'certified|provisional_certification|conditional_certification|decertified|termination_pending');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `civil_monetary_penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Civil Monetary Penalty (CMP) Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|deficient|condition_level_deficiency|immediate_jeopardy|plan_of_correction_pending|plan_of_correction_accepted');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_business_glossary_term' = 'Condition Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `condition_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cop_citation` SET TAGS ('pii_business_glossary_term' = 'CoP (Condition of Participation) Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `correction_completion_date` SET TAGS ('pii_business_glossary_term' = 'Correction Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `correction_verified_date` SET TAGS ('pii_business_glossary_term' = 'Correction Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `deficiency_tag_numbers` SET TAGS ('pii_business_glossary_term' = 'Deficiency Tag Numbers');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `enforcement_action_flag` SET TAGS ('pii_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `enforcement_action_type` SET TAGS ('pii_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `internal_audit_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Internal Audit Frequency (Months)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_internal_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Internal Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_internal_audit_result` SET TAGS ('pii_business_glossary_term' = 'Last Internal Audit Result');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_internal_audit_result` SET TAGS ('pii_value_regex' = 'compliant|minor_gaps|significant_gaps|non_compliant');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_survey_date` SET TAGS ('pii_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_survey_outcome` SET TAGS ('pii_business_glossary_term' = 'Last Survey Outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_survey_outcome` SET TAGS ('pii_value_regex' = 'no_deficiencies|deficiencies_cited|condition_level_cited|immediate_jeopardy_cited|termination_recommended');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_survey_type` SET TAGS ('pii_business_glossary_term' = 'Last Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `last_survey_type` SET TAGS ('pii_value_regex' = 'initial_certification|recertification|complaint|validation|life_safety_code|revisit');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `next_internal_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Internal Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `next_survey_window_end` SET TAGS ('pii_business_glossary_term' = 'Next Survey Window End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `next_survey_window_start` SET TAGS ('pii_business_glossary_term' = 'Next Survey Window Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `open_deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Open Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `plan_of_correction_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `plan_of_correction_due_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `plan_of_correction_status` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `plan_of_correction_submission_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `provider_type` SET TAGS ('pii_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `provider_type` SET TAGS ('pii_value_regex' = 'hospital|skilled_nursing_facility|home_health_agency|hospice|ambulatory_surgical_center|critical_access_hospital');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `responsible_officer_title` SET TAGS ('pii_business_glossary_term' = 'Responsible Officer Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `scope_and_severity_level` SET TAGS ('pii_business_glossary_term' = 'Scope and Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_business_glossary_term' = 'State Survey Agency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `cms_condition_status_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_business_glossary_term' = 'Surveyor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ALTER COLUMN `surveyor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` SET TAGS ('pii_entity_type' = 'status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `prior_accreditation_status_id` SET TAGS ('pii_business_glossary_term' = 'Prior Accreditation Status Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `prior_accreditation_status_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_award_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Award Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Accreditation Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_cycle_years` SET TAGS ('pii_business_glossary_term' = 'Accreditation Cycle Years');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_decision_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_level` SET TAGS ('pii_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_scope` SET TAGS ('pii_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status` SET TAGS ('pii_value_regex' = 'accredited|accredited_with_follow_up|conditional|preliminary_denial|not_accredited|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `annual_maintenance_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Maintenance Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|overturned|modified|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_business_glossary_term' = 'Accreditation Contact Person Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_business_glossary_term' = 'Accreditation Contact Person Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_business_glossary_term' = 'Accreditation Contact Person Phone');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_title` SET TAGS ('pii_business_glossary_term' = 'Accreditation Contact Person Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `deemed_status_flag` SET TAGS ('pii_business_glossary_term' = 'Deemed Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `exclusions` SET TAGS ('pii_business_glossary_term' = 'Accreditation Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_completion_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `last_survey_date` SET TAGS ('pii_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `next_survey_window_end_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Window End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `next_survey_window_start_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Window Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `public_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `quality_report_url` SET TAGS ('pii_business_glossary_term' = 'Quality Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_business_glossary_term' = 'State Licensure Alignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `survey_findings_count` SET TAGS ('pii_business_glossary_term' = 'Survey Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'initial|triennial|mid_cycle|unannounced|for_cause|follow_up');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` SET TAGS ('pii_entity_type' = 'agreement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `renewed_business_associate_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Renewed Business Associate Agreement Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `renewed_business_associate_agreement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `audit_rights_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Rights Granted Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `breach_notification_timeframe_days` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Timeframe (Days)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_business_glossary_term' = 'Business Associate Mailing Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_agreement_status` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_agreement_status` SET TAGS ('pii_value_regex' = 'active|expired|terminated|pending_renewal|draft|suspended');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_business_glossary_term' = 'Business Associate Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_business_glossary_term' = 'Business Associate Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Business Associate Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Business Associate Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Business Associate Signatory Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_tax_number` SET TAGS ('pii_business_glossary_term' = 'Business Associate Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `business_associate_tax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Covered Entity Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `covered_entity_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Covered Entity Signatory Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `document_location_url` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Document Location Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Execution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `indemnification_clause_included_flag` SET TAGS ('pii_business_glossary_term' = 'Indemnification Clause Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `permitted_disclosures` SET TAGS ('pii_business_glossary_term' = 'Permitted Disclosures of Protected Health Information (PHI)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `permitted_uses` SET TAGS ('pii_business_glossary_term' = 'Permitted Uses of Protected Health Information (PHI)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `phi_retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Retention Period (Years)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `phi_types_shared` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Types Shared');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `phi_types_shared` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `phi_types_shared` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `return_or_destroy_phi_flag` SET TAGS ('pii_business_glossary_term' = 'Return or Destroy Protected Health Information (PHI) Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Review Frequency (Months)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `safeguards_required` SET TAGS ('pii_business_glossary_term' = 'Safeguards Required for Protected Health Information (PHI)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `services_provided` SET TAGS ('pii_business_glossary_term' = 'Services Provided Involving Protected Health Information (PHI)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `subcontractor_baa_chain` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Business Associate Agreement (BAA) Chain');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `subcontractor_baa_required_flag` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Business Associate Agreement (BAA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` SET TAGS ('pii_entity_type' = 'notice');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `notice_of_privacy_practices_id` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Provided By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `superseded_notice_of_privacy_practices_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Notice Of Privacy Practices Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `superseded_notice_of_privacy_practices_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_value_regex' = 'wet_signature|electronic_signature|verbal_documented|portal_click|kiosk|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'acknowledged|refused|not_obtained|pending|emergency_exception');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_type` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `acknowledgment_type` SET TAGS ('pii_value_regex' = 'signed_paper|electronic_signature|verbal|portal_acceptance|refused|not_obtained');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `available_on_website_flag` SET TAGS ('pii_business_glossary_term' = 'Available on Website Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `device_type` SET TAGS ('pii_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `distribution_date` SET TAGS ('pii_business_glossary_term' = 'Distribution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `distribution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `emergency_exception_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `emergency_exception_reason` SET TAGS ('pii_business_glossary_term' = 'Emergency Exception Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `follow_up_completion_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `material_change_flag` SET TAGS ('pii_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_document_title` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Document Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_document_url` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Document URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_effective_date` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_language_code` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Language Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_language_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `npp_version_number` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Version Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `posted_in_facility_flag` SET TAGS ('pii_business_glossary_term' = 'Posted in Facility Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `record_modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `record_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `refusal_documented_by` SET TAGS ('pii_business_glossary_term' = 'Refusal Documented By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `refusal_reason` SET TAGS ('pii_business_glossary_term' = 'Refusal Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `signature_image_url` SET TAGS ('pii_business_glossary_term' = 'Signature Image URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `signature_image_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` SET TAGS ('pii_entity_type' = 'log');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Access Log ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `note_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `parent_phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'Related Phi Access Log Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `parent_phi_access_log_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `access_reason` SET TAGS ('pii_business_glossary_term' = 'Access Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `access_reason_code` SET TAGS ('pii_business_glossary_term' = 'Access Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `access_timestamp` SET TAGS ('pii_business_glossary_term' = 'Access Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `access_type` SET TAGS ('pii_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `access_type` SET TAGS ('pii_value_regex' = 'view|print|export|modify|create|delete');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `audit_log_source` SET TAGS ('pii_business_glossary_term' = 'Audit Log Source');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `breach_determination` SET TAGS ('pii_business_glossary_term' = 'Breach Determination');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `breach_determination` SET TAGS ('pii_value_regex' = 'not_applicable|not_a_breach|breach_low_risk|breach_reportable');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `breach_determination` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `breach_reported_date` SET TAGS ('pii_business_glossary_term' = 'Breach Reported Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `breach_reported_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `data_classification` SET TAGS ('pii_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `disclosure_tracking_required` SET TAGS ('pii_business_glossary_term' = 'Disclosure Tracking Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `emergency_access_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `flag_reason` SET TAGS ('pii_business_glossary_term' = 'Flag Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `flagged_for_review` SET TAGS ('pii_business_glossary_term' = 'Flagged for Review');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `patient_consent_on_file` SET TAGS ('pii_business_glossary_term' = 'Patient Consent on File');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `patient_relationship` SET TAGS ('pii_business_glossary_term' = 'Patient Relationship');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `record_type` SET TAGS ('pii_business_glossary_term' = 'Record Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `review_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|in_review|approved|violation_confirmed|no_violation|escalated');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `session_code` SET TAGS ('pii_business_glossary_term' = 'Session ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `system_accessed` SET TAGS ('pii_business_glossary_term' = 'System Accessed');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `system_module` SET TAGS ('pii_business_glossary_term' = 'System Module');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_department` SET TAGS ('pii_business_glossary_term' = 'User Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_business_glossary_term' = 'User Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `user_role` SET TAGS ('pii_business_glossary_term' = 'User Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `violation_type` SET TAGS ('pii_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `violation_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ALTER COLUMN `workstation_code` SET TAGS ('pii_business_glossary_term' = 'Workstation ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` SET TAGS ('pii_subdomain' = 'workforce_attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` SET TAGS ('pii_entity_type' = 'attestation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_id` SET TAGS ('pii_business_glossary_term' = 'Attestation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `reattested_attestation_id` SET TAGS ('pii_business_glossary_term' = 'Reattested Attestation Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `reattested_attestation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `acknowledgment_flag` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_number` SET TAGS ('pii_business_glossary_term' = 'Attestation Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_status` SET TAGS ('pii_business_glossary_term' = 'Attestation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_status` SET TAGS ('pii_value_regex' = 'pending|completed|overdue|rejected|expired');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('pii_business_glossary_term' = 'Attestation Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('pii_value_regex' = 'annual_compliance_certification|hipaa_workforce_training|code_of_conduct_acknowledgment|conflict_of_interest_recertification|cms_enrollment_attestation|policy_acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_business_glossary_term' = 'Attesting Individual Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_department` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_business_glossary_term' = 'Attesting Individual Email Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_business_glossary_term' = 'Attesting Individual Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_business_glossary_term' = 'Attesting Individual Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `attesting_individual_title` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `electronic_signature_reference` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `next_recertification_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Recertification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `recertification_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `recertification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Attestation Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_business_glossary_term' = 'Attestation Statement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ALTER COLUMN `training_completion_flag` SET TAGS ('pii_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_entity_type' = 'change');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Compliance Officer ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Regulatory Change Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_programs` SET TAGS ('pii_business_glossary_term' = 'Affected Compliance Programs');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_facilities` SET TAGS ('pii_business_glossary_term' = 'Affected Facilities');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_systems` SET TAGS ('pii_business_glossary_term' = 'Affected Systems');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `assigned_department` SET TAGS ('pii_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_description` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_title` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('pii_value_regex' = 'new rule|amended rule|guidance update|standard revision|enforcement policy change|interpretive guidance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `comment_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Comment Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `comment_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Comment Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `comment_submission_date` SET TAGS ('pii_business_glossary_term' = 'Comment Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `comment_submitted_flag` SET TAGS ('pii_business_glossary_term' = 'Comment Submitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `comment_summary` SET TAGS ('pii_business_glossary_term' = 'Comment Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `external_consultation_required_flag` SET TAGS ('pii_business_glossary_term' = 'External Consultation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_completion_date` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('pii_value_regex' = 'not started|in progress|completed|approved|deferred');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_summary` SET TAGS ('pii_business_glossary_term' = 'Impact Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_start_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `internal_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Internal Documentation URL');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `monitoring_required_flag` SET TAGS ('pii_business_glossary_term' = 'Monitoring Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Exposure Amount');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `policy_updates_required_flag` SET TAGS ('pii_business_glossary_term' = 'Policy Updates Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `response_actions_required` SET TAGS ('pii_business_glossary_term' = 'Response Actions Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulation` SET TAGS ('pii_business_glossary_term' = 'Superseded Regulation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ALTER COLUMN `training_required_flag` SET TAGS ('pii_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` SET TAGS ('pii_subdomain' = 'audit_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` SET TAGS ('pii_entity_type' = 'activity');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_activity_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Activity Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `follow_up_monitoring_activity_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Monitoring Activity Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `follow_up_monitoring_activity_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Monitor Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Monitoring Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_business_glossary_term' = 'Monitoring Activity Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_number` SET TAGS ('pii_business_glossary_term' = 'Monitoring Activity Number');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_status` SET TAGS ('pii_business_glossary_term' = 'Monitoring Activity Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Monitoring Activity Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `compliance_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Compliance Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `critical_issues_count` SET TAGS ('pii_business_glossary_term' = 'Critical Issues Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `department_monitored` SET TAGS ('pii_business_glossary_term' = 'Department Monitored');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `external_auditor_involvement_flag` SET TAGS ('pii_business_glossary_term' = 'External Auditor Involvement Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `external_auditor_organization` SET TAGS ('pii_business_glossary_term' = 'External Auditor Organization');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `follow_up_action_description` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Action Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `issues_identified_count` SET TAGS ('pii_business_glossary_term' = 'Issues Identified Count');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Monitor Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `lead_monitor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_methodology` SET TAGS ('pii_business_glossary_term' = 'Monitoring Methodology');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `monitoring_team_size` SET TAGS ('pii_business_glossary_term' = 'Monitoring Team Size');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `population_size` SET TAGS ('pii_business_glossary_term' = 'Population Size');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `process_monitored` SET TAGS ('pii_business_glossary_term' = 'Process Monitored');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `report_document_path` SET TAGS ('pii_business_glossary_term' = 'Report Document Path');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `report_issued_date` SET TAGS ('pii_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `scheduled_completion_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_association_edges' = 'compliance.compliance_program,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_entity_type' = 'assignment');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `program_policy_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Program Policy Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Program Policy Assignment - Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `assigned_by` SET TAGS ('pii_business_glossary_term' = 'Assignment Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Program-Specific Audit Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Program-Specific Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Program-Specific Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `next_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Program-Specific Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`program_policy_assignment` ALTER COLUMN `program_scope_applicability` SET TAGS ('pii_business_glossary_term' = 'Program Scope Applicability');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_association_edges' = 'compliance.policy,compliance.regulatory_change');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_entity_type' = 'impact');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `policy_regulatory_impact_id` SET TAGS ('pii_business_glossary_term' = 'Policy Regulatory Impact ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Regulatory Impact - Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Policy Regulatory Impact - Regulatory Change Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Policy Change Summary');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Policy Response Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `impact_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `impact_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `implementation_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `policy_version_created` SET TAGS ('pii_business_glossary_term' = 'Policy Version Created');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `response_type` SET TAGS ('pii_business_glossary_term' = 'Policy Response Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_association_edges' = 'compliance.policy,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_entity_type' = 'applicability');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `policy_payer_applicability_id` SET TAGS ('pii_business_glossary_term' = 'Policy-Payer Applicability ID');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Payer Applicability - Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Policy Payer Applicability - Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `attestation_required` SET TAGS ('pii_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `distribution_date` SET TAGS ('pii_business_glossary_term' = 'Policy Distribution Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Applicability Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `last_compliance_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `next_compliance_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Applicability Notes');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `payer_acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Payer Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `payer_specific_version` SET TAGS ('pii_business_glossary_term' = 'Payer-Specific Policy Version');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Applicability Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `waiver_approval_authority` SET TAGS ('pii_business_glossary_term' = 'Waiver Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `waiver_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` SET TAGS ('pii_entity_type' = 'requirement');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parent_regulatory_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Parent Regulatory Requirement Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parent_regulatory_requirement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_superseded_by_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Requirement Id');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('pii_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `audit_required` SET TAGS ('pii_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_frequency` SET TAGS ('pii_business_glossary_term' = 'Compliance Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `control_framework` SET TAGS ('pii_business_glossary_term' = 'Control Framework');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `documentation_retention_years` SET TAGS ('pii_business_glossary_term' = 'Documentation Retention Years');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `implementation_guidance` SET TAGS ('pii_business_glossary_term' = 'Implementation Guidance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_detail` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Detail');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_amount_max` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount Max');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_amount_min` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount Min');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('pii_business_glossary_term' = 'Penalty For Noncompliance');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `policy_reference` SET TAGS ('pii_business_glossary_term' = 'Policy Reference');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_citation` SET TAGS ('pii_business_glossary_term' = 'Regulation Citation');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `related_requirements` SET TAGS ('pii_business_glossary_term' = 'Related Requirements');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_business_glossary_term' = 'Reporting Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_category` SET TAGS ('pii_business_glossary_term' = 'Requirement Category');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('pii_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_description` SET TAGS ('pii_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_title` SET TAGS ('pii_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('pii_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `responsible_role` SET TAGS ('pii_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `source_document_url` SET TAGS ('pii_business_glossary_term' = 'Source Document Url');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_frequency` SET TAGS ('pii_business_glossary_term' = 'Training Frequency');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_required` SET TAGS ('pii_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
