-- Schema for Domain: safeguarding | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`safeguarding` COMMENT 'Systems of record: Primero (case management for child protection), dedicated PSEA case tracking systems, HR disciplinary systems. Covers PSEA policies, incident investigation, survivor support, and community awareness.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` (
    `psea_policy_id` BIGINT COMMENT 'Primary key for the PSEA policy record.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member who approved this policy.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit that owns this policy.',
    `approval_date` DATE COMMENT 'Date the policy was approved.',
    `compliance_framework` STRING COMMENT 'Compliance framework reference (e.g., IASC, CHS, UN Protocol).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `document_url` STRING COMMENT 'URL to the policy document.',
    `effective_date` DATE COMMENT 'Date the policy becomes effective.',
    `expiry_date` DATE COMMENT 'Date the policy expires and requires renewal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `mandatory_training_flag` BOOLEAN COMMENT 'Whether training on this policy is mandatory.',
    `next_review_date` DATE COMMENT 'Scheduled date for next policy review.',
    `notes` STRING COMMENT 'Additional notes.',
    `policy_status` STRING COMMENT 'Current status (Draft, Active, Superseded, Archived).',
    `policy_title` STRING COMMENT 'Title of the PSEA policy document.',
    `policy_version` STRING COMMENT 'Version number of the policy.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory reviews.',
    `scope_description` STRING COMMENT 'Description of the policy scope and applicability.',
    `whistleblower_protection_flag` BOOLEAN COMMENT 'Whether the policy includes whistleblower protections.',
    `zero_tolerance_statement_flag` BOOLEAN COMMENT 'Whether the policy includes a zero-tolerance statement.',
    CONSTRAINT pk_psea_policy PRIMARY KEY(`psea_policy_id`)
) COMMENT 'Protection from Sexual Exploitation and Abuse policy record. Tracks organizational PSEA policies, versions, approval dates, and compliance status. Source systems: eTools, Primero, internal policy management. Systems-of-record: Internal policy management, IASC PSEA portal. Framework: UN Secretary-General Bulletin ST/SGB/2003/13 / IASC Six Core Principles / CHS Alliance standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` (
    `safeguarding_incident_id` BIGINT COMMENT 'Primary key.',
    `country_id` BIGINT COMMENT 'FK to the country where incident occurred.',
    `focal_point_id` BIGINT COMMENT 'FK to the assigned focal point.',
    `project_site_id` BIGINT COMMENT 'FK to the project site where incident occurred.',
    `psea_policy_id` BIGINT COMMENT 'FK to the governing PSEA policy.',
    `reporting_channel_id` BIGINT COMMENT 'FK to the channel through which the incident was reported.',
    `closure_date` DATE COMMENT 'Date the incident was closed.',
    `closure_reason` STRING COMMENT 'Reason for closure.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `safeguarding_incident_description` STRING COMMENT 'Narrative description of the incident. PII protected.',
    `donor_notification_date` DATE COMMENT 'Date donor was notified.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Whether donor notification is required.',
    `incident_category` STRING COMMENT 'Category classification of the incident.',
    `incident_date` DATE COMMENT 'Date the incident occurred.',
    `incident_number` STRING COMMENT 'Unique incident reference number.',
    `incident_status` STRING COMMENT 'Current status (Reported, Under Investigation, Closed, Referred).',
    `incident_type` STRING COMMENT 'Type of incident (SEA, Sexual Harassment, Child Abuse, Other Misconduct).',
    `involves_minor_flag` BOOLEAN COMMENT 'Whether the incident involves a minor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `lessons_learned` STRING COMMENT 'Lessons learned from the incident.',
    `location_description` STRING COMMENT 'Description of incident location.',
    `notes` STRING COMMENT 'Additional notes. PII protected.',
    `perpetrator_count` STRING COMMENT 'Number of alleged perpetrators.',
    `referred_to_authorities_flag` BOOLEAN COMMENT 'Whether the incident was referred to local authorities.',
    `reported_date` DATE COMMENT 'Date the incident was reported.',
    `severity_level` STRING COMMENT 'Severity level (Critical, High, Medium, Low).',
    `survivor_count` STRING COMMENT 'Number of survivors involved.',
    CONSTRAINT pk_safeguarding_incident PRIMARY KEY(`safeguarding_incident_id`)
) COMMENT 'SSOT for safeguarding incidents including PSEA (Protection from Sexual Exploitation and Abuse), sexual harassment, child protection violations, and abuse of power. Distinct from compliance.compliance_incident which covers regulatory/financial compliance breaches.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the lead investigator.',
    `psea_policy_id` BIGINT COMMENT 'FK to the governing PSEA policy.',
    `safeguarding_incident_id` BIGINT COMMENT 'FK to the safeguarding incident.',
    `actual_completion_date` DATE COMMENT 'Actual completion date.',
    `conclusion` STRING COMMENT 'Investigation conclusion (Substantiated, Unsubstantiated, Inconclusive).',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `evidence_collected_flag` BOOLEAN COMMENT 'Whether evidence was collected.',
    `external_referral_flag` BOOLEAN COMMENT 'Whether referred to external body.',
    `findings_summary` STRING COMMENT 'Summary of investigation findings. PII protected.',
    `initiation_date` DATE COMMENT 'Date investigation was initiated.',
    `investigation_number` STRING COMMENT 'Unique investigation reference.',
    `investigation_status` STRING COMMENT 'Current status (Initiated, In Progress, Completed, Closed).',
    `investigation_type` STRING COMMENT 'Type of investigation (Internal, External, Joint).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `recommendations` STRING COMMENT 'Recommendations from the investigation.',
    `report_url` STRING COMMENT 'URL to investigation report.',
    `target_completion_date` DATE COMMENT 'Target date for completion.',
    `witnesses_interviewed_count` STRING COMMENT 'Number of witnesses interviewed.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Formal investigation record linked to a safeguarding incident. Tracks investigation lifecycle, findings, and outcomes.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` (
    `investigation_action_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the assigned staff member.',
    `investigation_id` BIGINT COMMENT 'FK to the investigation.',
    `action_description` STRING COMMENT 'Description of the action.',
    `action_status` STRING COMMENT 'Status (Planned, In Progress, Completed, Cancelled).',
    `action_type` STRING COMMENT 'Type of action (Interview, Evidence Collection, Site Visit, Document Review).',
    `completed_date` DATE COMMENT 'Actual completion date.',
    `confidentiality_level` STRING COMMENT 'Confidentiality level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_summary` STRING COMMENT 'Summary of action outcome.',
    `scheduled_date` DATE COMMENT 'Scheduled date for the action.',
    CONSTRAINT pk_investigation_action PRIMARY KEY(`investigation_action_id`)
) COMMENT 'Individual actions taken during an investigation (interviews, evidence collection, site visits).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` (
    `survivor_record_id` BIGINT COMMENT 'Primary key.',
    `registrant_id` BIGINT COMMENT 'FK to the beneficiary registrant if applicable.',
    `safeguarding_incident_id` BIGINT COMMENT 'FK to the safeguarding incident.',
    `age_group` STRING COMMENT 'Age group (Child, Adolescent, Adult).',
    `consent_date` DATE COMMENT 'Date consent was obtained.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Whether informed consent was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `disability_flag` BOOLEAN COMMENT 'Whether the survivor has a disability.',
    `displacement_status` STRING COMMENT 'Displacement status of the survivor.',
    `is_minor_flag` BOOLEAN COMMENT 'Whether the survivor is a minor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Case notes. Highly sensitive.',
    `safety_plan_in_place_flag` BOOLEAN COMMENT 'Whether a safety plan is in place.',
    `sex` STRING COMMENT 'Sex of the survivor.',
    `support_status` STRING COMMENT 'Current support status (Active, Closed, Referred).',
    `survivor_code` STRING COMMENT 'De-identified code for the survivor.',
    CONSTRAINT pk_survivor_record PRIMARY KEY(`survivor_record_id`)
) COMMENT 'De-identified survivor record linked to a safeguarding incident. Contains only minimal demographic data needed for case management. All fields are pii_beneficiary_protected.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` (
    `survivor_support_plan_id` BIGINT COMMENT 'Primary key.',
    `focal_point_id` BIGINT COMMENT 'FK to the assigned focal point.',
    `survivor_record_id` BIGINT COMMENT 'FK to the survivor record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `last_review_date` DATE COMMENT 'Date of last review.',
    `next_review_date` DATE COMMENT 'Date of next scheduled review.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_summary` STRING COMMENT 'Summary of outcomes achieved.',
    `plan_end_date` DATE COMMENT 'Plan end date.',
    `plan_start_date` DATE COMMENT 'Plan start date.',
    `plan_status` STRING COMMENT 'Status (Draft, Active, Completed, Closed).',
    `priority_level` STRING COMMENT 'Priority level (Critical, High, Medium, Low).',
    `review_frequency` STRING COMMENT 'How often the plan is reviewed.',
    `safety_measures` STRING COMMENT 'Safety measures in place.',
    `services_required` STRING COMMENT 'List of services required (medical, psychosocial, legal, shelter).',
    CONSTRAINT pk_survivor_support_plan PRIMARY KEY(`survivor_support_plan_id`)
) COMMENT 'Support plan for a survivor including services, timeline, and responsible parties.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` (
    `support_service_referral_id` BIGINT COMMENT 'Primary key.',
    `partner_org_id` BIGINT COMMENT 'FK to the receiving partner organization.',
    `survivor_support_plan_id` BIGINT COMMENT 'FK to the support plan.',
    `acceptance_date` DATE COMMENT 'Date referral was accepted.',
    `completion_date` DATE COMMENT 'Date service was completed.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Whether survivor consent was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Whether follow-up is required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome` STRING COMMENT 'Outcome of the referral.',
    `referral_date` DATE COMMENT 'Date of referral.',
    `referral_status` STRING COMMENT 'Status (Pending, Accepted, In Progress, Completed, Declined).',
    `referral_type` STRING COMMENT 'Type of service (Medical, Legal, Psychosocial, Shelter, Livelihood).',
    `service_provider_name` STRING COMMENT 'Name of the service provider.',
    CONSTRAINT pk_support_service_referral PRIMARY KEY(`support_service_referral_id`)
) COMMENT 'Referral of a survivor to a support service (medical, legal, psychosocial, shelter).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` (
    `alleged_perpetrator_id` BIGINT COMMENT 'Primary key.',
    `safeguarding_incident_id` BIGINT COMMENT 'FK to the safeguarding incident.',
    `staff_member_id` BIGINT COMMENT 'FK to staff member if perpetrator is staff.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `investigation_outcome` STRING COMMENT 'Outcome of investigation for this perpetrator.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `perpetrator_category` STRING COMMENT 'Category (Staff, Partner Staff, Contractor, Volunteer, Other).',
    `perpetrator_code` STRING COMMENT 'De-identified code.',
    `position_title` STRING COMMENT 'Position/title of the alleged perpetrator.',
    `relationship_to_survivor` STRING COMMENT 'Relationship to the survivor.',
    `sex` STRING COMMENT 'Sex of the alleged perpetrator.',
    `suspension_date` DATE COMMENT 'Date of suspension.',
    `suspension_flag` BOOLEAN COMMENT 'Whether the person has been suspended.',
    CONSTRAINT pk_alleged_perpetrator PRIMARY KEY(`alleged_perpetrator_id`)
) COMMENT 'Record of an alleged perpetrator linked to a safeguarding incident. Sensitive personnel data.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` (
    `disciplinary_outcome_id` BIGINT COMMENT 'Primary key.',
    `alleged_perpetrator_id` BIGINT COMMENT 'FK to the alleged perpetrator.',
    `investigation_id` BIGINT COMMENT 'FK to the investigation.',
    `appeal_flag` BOOLEAN COMMENT 'Whether an appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of appeal if filed.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `decision_authority` STRING COMMENT 'Authority that made the decision.',
    `decision_date` DATE COMMENT 'Date the decision was made.',
    `implementation_date` DATE COMMENT 'Date the outcome was implemented.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `misconduct_disclosure_flag` BOOLEAN COMMENT 'Whether added to misconduct disclosure scheme.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_status` STRING COMMENT 'Status (Pending, Implemented, Appealed, Overturned).',
    `outcome_type` STRING COMMENT 'Type (Termination, Suspension, Written Warning, Training, No Action).',
    CONSTRAINT pk_disciplinary_outcome PRIMARY KEY(`disciplinary_outcome_id`)
) COMMENT 'Disciplinary outcome resulting from a substantiated safeguarding investigation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key.',
    `psea_policy_id` BIGINT COMMENT 'FK to the governing PSEA policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `curriculum_version` STRING COMMENT 'Version of the curriculum.',
    `delivery_modality` STRING COMMENT 'Delivery method (Online, In-Person, Blended).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours.',
    `is_mandatory_flag` BOOLEAN COMMENT 'Whether the training is mandatory.',
    `language_code` STRING COMMENT 'Primary language of delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum passing score percentage.',
    `program_code` STRING COMMENT 'Unique code for the training program.',
    `program_name` STRING COMMENT 'Name of the training program.',
    `program_status` STRING COMMENT 'Status (Active, Inactive, Under Development).',
    `recertification_months` STRING COMMENT 'Months before recertification is required.',
    `target_audience` STRING COMMENT 'Target audience (All Staff, Management, Field Staff, Partners).',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Safeguarding and PSEA training program definition including curriculum, target audience, and delivery modality.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` (
    `safeguarding_training_completion_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member who completed training.',
    `training_program_id` BIGINT COMMENT 'FK to the training program.',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer if applicable.',
    `certificate_number` STRING COMMENT 'Certificate reference number.',
    `completion_date` DATE COMMENT 'Date training was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `delivery_modality` STRING COMMENT 'How training was delivered.',
    `expiry_date` DATE COMMENT 'Date the certification expires.',
    `notes` STRING COMMENT 'Additional notes.',
    `passed_flag` BOOLEAN COMMENT 'Whether the participant passed.',
    `score_percent` DECIMAL(18,2) COMMENT 'Score achieved as percentage.',
    CONSTRAINT pk_safeguarding_training_completion PRIMARY KEY(`safeguarding_training_completion_id`)
) COMMENT 'SSOT for staff completion of mandatory safeguarding/PSEA training programmes required for employment and deployment clearance. Distinct from volunteer.volunteer_training_completion which tracks volunteer completion of safeguarding training.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` (
    `safeguarding_policy_acknowledgment_id` BIGINT COMMENT 'Primary key.',
    `psea_policy_id` BIGINT COMMENT 'FK to the PSEA policy.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member.',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer if applicable.',
    `acknowledgment_date` DATE COMMENT 'Date of acknowledgment.',
    `acknowledgment_method` STRING COMMENT 'Method (Digital Signature, Physical Signature, Email Confirmation).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `next_renewal_date` DATE COMMENT 'Date next renewal is due.',
    `notes` STRING COMMENT 'Additional notes.',
    `policy_version_acknowledged` STRING COMMENT 'Version of the policy acknowledged.',
    `renewal_required_flag` BOOLEAN COMMENT 'Whether renewal is required.',
    CONSTRAINT pk_safeguarding_policy_acknowledgment PRIMARY KEY(`safeguarding_policy_acknowledgment_id`)
) COMMENT 'SSOT for staff acknowledgment of safeguarding/PSEA policies as a condition of employment. Distinct from volunteer.volunteer_policy_acknowledgment which tracks volunteer policy acknowledgments.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member who conducted the assessment.',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention.',
    `project_site_id` BIGINT COMMENT 'FK to the project site.',
    `assessment_date` DATE COMMENT 'Date of assessment.',
    `assessment_status` STRING COMMENT 'Status (Draft, Completed, Approved).',
    `assessment_type` STRING COMMENT 'Type (Initial, Periodic, Triggered).',
    `child_safeguarding_risk_score` DOUBLE COMMENT 'Child safeguarding risk score.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `mitigation_measures` STRING COMMENT 'Description of mitigation measures.',
    `next_review_date` DATE COMMENT 'Date of next scheduled review.',
    `notes` STRING COMMENT 'Additional notes.',
    `overall_risk_level` STRING COMMENT 'Overall risk level (Critical, High, Medium, Low).',
    `residual_risk_level` STRING COMMENT 'Residual risk level after mitigation.',
    `sea_risk_score` DOUBLE COMMENT 'SEA-specific risk score.',
    `sh_risk_score` DOUBLE COMMENT 'Sexual harassment risk score.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Safeguarding risk assessment for a program, project site, or partner. Identifies SEA/SH risks and mitigation measures.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` (
    `reporting_channel_id` BIGINT COMMENT 'Primary key.',
    `country_id` BIGINT COMMENT 'FK to the country.',
    `accessibility_features` STRING COMMENT 'Accessibility features available.',
    `channel_name` STRING COMMENT 'Name of the reporting channel.',
    `channel_status` STRING COMMENT 'Status (Active, Inactive, Under Maintenance).',
    `channel_type` STRING COMMENT 'Type (Hotline, Email, In-Person, Web Form, Community Box, SMS).',
    `contact_details` STRING COMMENT 'Contact details for the channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `is_anonymous_flag` BOOLEAN COMMENT 'Whether anonymous reporting is supported.',
    `is_confidential_flag` BOOLEAN COMMENT 'Whether confidentiality is guaranteed.',
    `languages_supported` STRING COMMENT 'Languages supported by this channel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `operating_hours` STRING COMMENT 'Operating hours of the channel.',
    CONSTRAINT pk_reporting_channel PRIMARY KEY(`reporting_channel_id`)
) COMMENT 'Reporting channel/mechanism for safeguarding concerns (hotline, email, in-person, community-based).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` (
    `focal_point_id` BIGINT COMMENT 'Primary key.',
    `country_id` BIGINT COMMENT 'FK to the country.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member serving as focal point.',
    `contact_email` STRING COMMENT 'Contact email for the focal point.',
    `contact_phone` STRING COMMENT 'Contact phone for the focal point.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `designation_date` DATE COMMENT 'Date of designation.',
    `end_date` DATE COMMENT 'End date of assignment.',
    `focal_point_type` STRING COMMENT 'Type (Primary, Alternate, Regional).',
    `is_active_flag` BOOLEAN COMMENT 'Whether currently active.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `training_completed_flag` BOOLEAN COMMENT 'Whether required training is completed.',
    CONSTRAINT pk_focal_point PRIMARY KEY(`focal_point_id`)
) COMMENT 'Designated safeguarding/PSEA focal point responsible for a geographic area or organizational unit.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` (
    `psea_network_membership_id` BIGINT COMMENT 'Primary key.',
    `focal_point_id` BIGINT COMMENT 'FK to the designated focal point.',
    `partner_org_id` BIGINT COMMENT 'FK to the partner organization.',
    `psea_network_id` BIGINT COMMENT 'FK to the PSEA network.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `exit_date` DATE COMMENT 'Date the organization exited.',
    `join_date` DATE COMMENT 'Date the organization joined.',
    `membership_status` STRING COMMENT 'Membership status (Active, Inactive, Suspended).',
    `notes` STRING COMMENT 'Additional notes.',
    `role_in_network` STRING COMMENT 'Role in the network (Chair, Co-Chair, Member, Observer).',
    CONSTRAINT pk_psea_network_membership PRIMARY KEY(`psea_network_membership_id`)
) COMMENT 'Membership of an organization in a PSEA network (inter-agency coordination body).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` (
    `misconduct_disclosure_id` BIGINT COMMENT 'Primary key.',
    `partner_org_id` BIGINT COMMENT 'FK to the requesting organization.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `disclosure_status` STRING COMMENT 'Status (Pending, Completed, No Record Found, Disclosure Made).',
    `disclosure_type` STRING COMMENT 'Type (Request Sent, Request Received, Disclosure Made, Disclosure Received).',
    `hiring_decision_impact` STRING COMMENT 'Impact on hiring decision.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `misconduct_category` STRING COMMENT 'Category of misconduct if found.',
    `misconduct_found_flag` BOOLEAN COMMENT 'Whether misconduct was found in records.',
    `notes` STRING COMMENT 'Additional notes.',
    `request_date` DATE COMMENT 'Date the request was made.',
    `response_date` DATE COMMENT 'Date the response was provided.',
    CONSTRAINT pk_misconduct_disclosure PRIMARY KEY(`misconduct_disclosure_id`)
) COMMENT 'Misconduct Disclosure Scheme record - tracks disclosures made/received about staff misconduct history during recruitment.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the lead auditor.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit being audited.',
    `psea_policy_id` BIGINT COMMENT 'FK to the PSEA policy being audited.',
    `audit_number` STRING COMMENT 'Unique audit reference number.',
    `audit_status` STRING COMMENT 'Status (Planned, In Progress, Completed, Follow-Up).',
    `audit_type` STRING COMMENT 'Type (Internal, External, Donor-Required, CHS).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings.',
    `end_date` DATE COMMENT 'Audit end date.',
    `findings_count` STRING COMMENT 'Number of findings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `overall_rating` STRING COMMENT 'Overall audit rating (Satisfactory, Partially Satisfactory, Unsatisfactory).',
    `report_url` STRING COMMENT 'URL to the audit report.',
    `scope` STRING COMMENT 'Scope of the audit.',
    `start_date` DATE COMMENT 'Audit start date.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Safeguarding audit record - periodic review of safeguarding policies, procedures, and compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` (
    `audit_recommendation_id` BIGINT COMMENT 'Primary key.',
    `audit_id` BIGINT COMMENT 'FK to the audit.',
    `staff_member_id` BIGINT COMMENT 'FK to the responsible staff member.',
    `completion_date` DATE COMMENT 'Actual completion date.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `implementation_status` STRING COMMENT 'Status (Open, In Progress, Implemented, Closed, Overdue).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `management_response` STRING COMMENT 'Management response to the recommendation.',
    `notes` STRING COMMENT 'Additional notes.',
    `priority_level` STRING COMMENT 'Priority (Critical, High, Medium, Low).',
    `recommendation_number` STRING COMMENT 'Unique recommendation reference.',
    `recommendation_text` STRING COMMENT 'Text of the recommendation.',
    `target_date` DATE COMMENT 'Target implementation date.',
    `verification_method` STRING COMMENT 'How implementation will be verified.',
    CONSTRAINT pk_audit_recommendation PRIMARY KEY(`audit_recommendation_id`)
) COMMENT 'Recommendation from a safeguarding audit with tracking of implementation status.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` (
    `donor_safeguarding_requirement_id` BIGINT COMMENT 'Primary key.',
    `award_id` BIGINT COMMENT 'FK to the grant award.',
    `constituent_id` BIGINT COMMENT 'FK to the donor constituent.',
    `compliance_status` STRING COMMENT 'Compliance status (Compliant, Non-Compliant, In Progress, Not Applicable).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `due_date` DATE COMMENT 'Due date for compliance.',
    `incident_notification_hours` STRING COMMENT 'Hours within which incidents must be reported to donor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `last_reported_date` DATE COMMENT 'Date of last report.',
    `notes` STRING COMMENT 'Additional notes.',
    `reporting_frequency` STRING COMMENT 'How often reporting is required.',
    `requirement_description` STRING COMMENT 'Description of the requirement.',
    `requirement_type` STRING COMMENT 'Type of requirement (Policy, Training, Reporting, Vetting, Audit).',
    CONSTRAINT pk_donor_safeguarding_requirement PRIMARY KEY(`donor_safeguarding_requirement_id`)
) COMMENT 'Donor-specific safeguarding requirements and conditions that must be met for grant compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` (
    `partner_psea_assessment_id` BIGINT COMMENT 'Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to the assessor.',
    `partner_org_id` BIGINT COMMENT 'FK to the partner organization.',
    `psea_network_id` BIGINT COMMENT 'FK to the PSEA network if joint assessment.',
    `assessment_date` DATE COMMENT 'Date of assessment.',
    `assessment_type` STRING COMMENT 'Type (Self-Assessment, External, Joint, UN Harmonized).',
    `capacity_building_required_flag` BOOLEAN COMMENT 'Whether capacity building is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `overall_rating` STRING COMMENT 'Overall rating (Full Capacity, Medium Capacity, Low Capacity, No Capacity).',
    `overall_score` DOUBLE COMMENT 'Numeric overall score.',
    `policy_score` DOUBLE COMMENT 'Score for policy dimension.',
    `procedures_score` DOUBLE COMMENT 'Score for procedures dimension.',
    `recommendations` STRING COMMENT 'Recommendations from the assessment.',
    `reporting_score` DOUBLE COMMENT 'Score for reporting mechanisms.',
    `training_score` DOUBLE COMMENT 'Score for training dimension.',
    `valid_until_date` DATE COMMENT 'Date until which assessment is valid.',
    CONSTRAINT pk_partner_psea_assessment PRIMARY KEY(`partner_psea_assessment_id`)
) COMMENT 'PSEA capacity assessment of a partner organization. Evaluates partner safeguarding policies, procedures, and capacity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` (
    `community_awareness_session_id` BIGINT COMMENT 'Primary key.',
    `community_id` BIGINT COMMENT 'FK to the beneficiary community.',
    `staff_member_id` BIGINT COMMENT 'FK to the facilitating staff member.',
    `reporting_channel_id` BIGINT COMMENT 'FK to the reporting channel promoted.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `feedback_collected_flag` BOOLEAN COMMENT 'Whether feedback was collected.',
    `language_code` STRING COMMENT 'Language of delivery.',
    `location_description` STRING COMMENT 'Location description.',
    `notes` STRING COMMENT 'Additional notes.',
    `participants_female` STRING COMMENT 'Number of female participants.',
    `participants_male` STRING COMMENT 'Number of male participants.',
    `participants_total` STRING COMMENT 'Total number of participants.',
    `session_date` DATE COMMENT 'Date of the session.',
    `session_type` STRING COMMENT 'Type (Community Meeting, Focus Group, Door-to-Door, Radio, Drama).',
    `topic` STRING COMMENT 'Topic covered.',
    CONSTRAINT pk_community_awareness_session PRIMARY KEY(`community_awareness_session_id`)
) COMMENT 'Community awareness session on safeguarding, PSEA, and reporting mechanisms. Tracks outreach to beneficiary communities.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` (
    `psea_network_id` BIGINT COMMENT 'Primary key.',
    `partner_org_id` BIGINT COMMENT 'FK to the chairing organization.',
    `country_id` BIGINT COMMENT 'FK to the country where the network operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `establishment_date` DATE COMMENT 'Date the network was established.',
    `joint_action_plan_flag` BOOLEAN COMMENT 'Whether a joint action plan exists.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `meeting_frequency` STRING COMMENT 'How often the network meets.',
    `member_count` STRING COMMENT 'Number of member organizations.',
    `network_level` STRING COMMENT 'Level (Country, Regional, Global).',
    `network_name` STRING COMMENT 'Name of the PSEA network.',
    `network_status` STRING COMMENT 'Status (Active, Inactive, Forming).',
    `notes` STRING COMMENT 'Additional notes.',
    `terms_of_reference_url` STRING COMMENT 'URL to terms of reference.',
    CONSTRAINT pk_psea_network PRIMARY KEY(`psea_network_id`)
) COMMENT 'Inter-agency PSEA network/coordination body operating at country or regional level.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_reporting_channel_id` FOREIGN KEY (`reporting_channel_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`reporting_channel`(`reporting_channel_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_survivor_record_id` FOREIGN KEY (`survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_survivor_support_plan_id` FOREIGN KEY (`survivor_support_plan_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan`(`survivor_support_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_alleged_perpetrator_id` FOREIGN KEY (`alleged_perpetrator_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`(`alleged_perpetrator_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_psea_network_id` FOREIGN KEY (`psea_network_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_network`(`psea_network_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`audit`(`audit_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_psea_network_id` FOREIGN KEY (`psea_network_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_network`(`psea_network_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_reporting_channel_id` FOREIGN KEY (`reporting_channel_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`reporting_channel`(`reporting_channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_category' = 'policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('pii_column_comment_framework' = 'IASC PSEA + CHS');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approving Staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organization Unit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `mandatory_training_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Training');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_title` SET TAGS ('pii_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_version` SET TAGS ('pii_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `whistleblower_protection_flag` SET TAGS ('pii_business_glossary_term' = 'Whistleblower Protection');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `zero_tolerance_statement_flag` SET TAGS ('pii_business_glossary_term' = 'Zero Tolerance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_category' = 'incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_ssot' = 'safeguarding.safeguarding_incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_disambiguated_from' = 'compliance.compliance_incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_ssot_scope' = 'psea_protection');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_ssot_pair' = 'compliance.compliance_incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `focal_point_id` SET TAGS ('pii_business_glossary_term' = 'Focal Point');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporting_channel_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `closure_reason` SET TAGS ('pii_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `donor_notification_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `incident_category` SET TAGS ('pii_business_glossary_term' = 'Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `involves_minor_flag` SET TAGS ('pii_business_glossary_term' = 'Involves Minor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_description` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `perpetrator_count` SET TAGS ('pii_business_glossary_term' = 'Perpetrator Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `referred_to_authorities_flag` SET TAGS ('pii_business_glossary_term' = 'Referred to Authorities');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_count` SET TAGS ('pii_business_glossary_term' = 'Survivor Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_category' = 'investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Investigator');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `conclusion` SET TAGS ('pii_business_glossary_term' = 'Conclusion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `evidence_collected_flag` SET TAGS ('pii_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `external_referral_flag` SET TAGS ('pii_business_glossary_term' = 'External Referral');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `initiation_date` SET TAGS ('pii_business_glossary_term' = 'Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('pii_business_glossary_term' = 'Investigation Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `witnesses_interviewed_count` SET TAGS ('pii_business_glossary_term' = 'Witnesses Interviewed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('pii_category' = 'investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_id` SET TAGS ('pii_business_glossary_term' = 'Action ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `completed_date` SET TAGS ('pii_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_summary` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_summary` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_category' = 'survivor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_record_id` SET TAGS ('pii_business_glossary_term' = 'Survivor Record ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Registrant');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('pii_business_glossary_term' = 'Age Group');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('pii_business_glossary_term' = 'Disability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `displacement_status` SET TAGS ('pii_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `is_minor_flag` SET TAGS ('pii_business_glossary_term' = 'Is Minor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safety_plan_in_place_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Plan');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('pii_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_status` SET TAGS ('pii_business_glossary_term' = 'Support Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('pii_business_glossary_term' = 'Survivor Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_category' = 'survivor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_id` SET TAGS ('pii_business_glossary_term' = 'Support Plan ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `focal_point_id` SET TAGS ('pii_business_glossary_term' = 'Focal Point');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_record_id` SET TAGS ('pii_business_glossary_term' = 'Survivor Record');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `outcome_summary` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `outcome_summary` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safety_measures` SET TAGS ('pii_business_glossary_term' = 'Safety Measures');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safety_measures` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `services_required` SET TAGS ('pii_business_glossary_term' = 'Services Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_category' = 'survivor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `support_service_referral_id` SET TAGS ('pii_business_glossary_term' = 'Referral ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `survivor_support_plan_id` SET TAGS ('pii_business_glossary_term' = 'Support Plan');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `referral_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `referral_type` SET TAGS ('pii_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_name` SET TAGS ('pii_business_glossary_term' = 'Service Provider');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_category' = 'incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('pii_business_glossary_term' = 'Perpetrator ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `staff_member_id` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_outcome` SET TAGS ('pii_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `perpetrator_category` SET TAGS ('pii_business_glossary_term' = 'Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `perpetrator_code` SET TAGS ('pii_business_glossary_term' = 'Perpetrator Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `perpetrator_code` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `position_title` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `position_title` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `relationship_to_survivor` SET TAGS ('pii_business_glossary_term' = 'Relationship');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `sex` SET TAGS ('pii_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `sex` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `sex` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `suspension_date` SET TAGS ('pii_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `suspension_flag` SET TAGS ('pii_business_glossary_term' = 'Suspended');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_category' = 'incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_id` SET TAGS ('pii_business_glossary_term' = 'Outcome ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('pii_business_glossary_term' = 'Perpetrator');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `decision_authority` SET TAGS ('pii_business_glossary_term' = 'Decision Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `implementation_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `misconduct_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Misconduct Disclosure');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `outcome_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `outcome_type` SET TAGS ('pii_business_glossary_term' = 'Outcome Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('pii_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('pii_category' = 'training');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('pii_business_glossary_term' = 'Training Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `curriculum_version` SET TAGS ('pii_business_glossary_term' = 'Curriculum Version');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `delivery_modality` SET TAGS ('pii_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Duration');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `is_mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `passing_score_percent` SET TAGS ('pii_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `program_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `recertification_months` SET TAGS ('pii_business_glossary_term' = 'Recertification Period');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_category' = 'training');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_ssot' = 'safeguarding.safeguarding_training_completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_disambiguated_from' = 'volunteer.volunteer_training_completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_ssot_scope' = 'staff_training');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_ssot_pair' = 'volunteer.volunteer_training_completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `safeguarding_training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Completion ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('pii_business_glossary_term' = 'Training Program');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `delivery_modality` SET TAGS ('pii_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `passed_flag` SET TAGS ('pii_business_glossary_term' = 'Passed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `score_percent` SET TAGS ('pii_business_glossary_term' = 'Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_category' = 'policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_ssot' = 'safeguarding.safeguarding_policy_acknowledgment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_disambiguated_from' = 'volunteer.volunteer_policy_acknowledgment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_ssot_scope' = 'staff_acknowledgment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_ssot_pair' = 'volunteer.volunteer_policy_acknowledgment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_policy_acknowledgment_id` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_business_glossary_term' = 'Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `next_renewal_date` SET TAGS ('pii_business_glossary_term' = 'Next Renewal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `policy_version_acknowledged` SET TAGS ('pii_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('pii_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('pii_category' = 'prevention');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assessor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `child_safeguarding_risk_score` SET TAGS ('pii_business_glossary_term' = 'Child Safeguarding Risk');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_business_glossary_term' = 'Residual Risk');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `sea_risk_score` SET TAGS ('pii_business_glossary_term' = 'SEA Risk Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `sh_risk_score` SET TAGS ('pii_business_glossary_term' = 'SH Risk Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('pii_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('pii_category' = 'reporting');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_id` SET TAGS ('pii_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `accessibility_features` SET TAGS ('pii_business_glossary_term' = 'Accessibility');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_type` SET TAGS ('pii_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_details` SET TAGS ('pii_business_glossary_term' = 'Contact Details');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `is_anonymous_flag` SET TAGS ('pii_business_glossary_term' = 'Anonymous');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `is_confidential_flag` SET TAGS ('pii_business_glossary_term' = 'Confidential');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `languages_supported` SET TAGS ('pii_business_glossary_term' = 'Languages');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('pii_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('pii_category' = 'governance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_id` SET TAGS ('pii_business_glossary_term' = 'Focal Point ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `designation_date` SET TAGS ('pii_business_glossary_term' = 'Designation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `is_active_flag` SET TAGS ('pii_business_glossary_term' = 'Active');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `training_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Training Completed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('pii_category' = 'governance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_membership_id` SET TAGS ('pii_business_glossary_term' = 'Membership ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `focal_point_id` SET TAGS ('pii_business_glossary_term' = 'Focal Point');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Network');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `exit_date` SET TAGS ('pii_business_glossary_term' = 'Exit Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `join_date` SET TAGS ('pii_business_glossary_term' = 'Join Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `membership_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `role_in_network` SET TAGS ('pii_business_glossary_term' = 'Role');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_category' = 'governance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_sensitivity' = 'high');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_id` SET TAGS ('pii_business_glossary_term' = 'Disclosure ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Org');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `hiring_decision_impact` SET TAGS ('pii_business_glossary_term' = 'Hiring Impact');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_category` SET TAGS ('pii_business_glossary_term' = 'Misconduct Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_found_flag` SET TAGS ('pii_business_glossary_term' = 'Misconduct Found');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `notes` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('pii_category' = 'assurance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `findings_count` SET TAGS ('pii_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('pii_category' = 'assurance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_recommendation_id` SET TAGS ('pii_business_glossary_term' = 'Recommendation ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_response` SET TAGS ('pii_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `recommendation_number` SET TAGS ('pii_business_glossary_term' = 'Recommendation Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `recommendation_text` SET TAGS ('pii_business_glossary_term' = 'Recommendation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `target_date` SET TAGS ('pii_business_glossary_term' = 'Target Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('pii_category' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Requirement ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `incident_notification_hours` SET TAGS ('pii_business_glossary_term' = 'Notification Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `last_reported_date` SET TAGS ('pii_business_glossary_term' = 'Last Reported');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `requirement_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `requirement_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('pii_category' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assessor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `psea_network_id` SET TAGS ('pii_business_glossary_term' = 'PSEA Network');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `capacity_building_required_flag` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `policy_score` SET TAGS ('pii_business_glossary_term' = 'Policy Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `procedures_score` SET TAGS ('pii_business_glossary_term' = 'Procedures Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reporting_score` SET TAGS ('pii_business_glossary_term' = 'Reporting Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `training_score` SET TAGS ('pii_business_glossary_term' = 'Training Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `valid_until_date` SET TAGS ('pii_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('pii_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('pii_category' = 'prevention');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_id` SET TAGS ('pii_business_glossary_term' = 'Session ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_id` SET TAGS ('pii_business_glossary_term' = 'Community');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Facilitator');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `reporting_channel_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `feedback_collected_flag` SET TAGS ('pii_business_glossary_term' = 'Feedback Collected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_description` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_female` SET TAGS ('pii_business_glossary_term' = 'Female Participants');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_male` SET TAGS ('pii_business_glossary_term' = 'Male Participants');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_total` SET TAGS ('pii_business_glossary_term' = 'Total Participants');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `session_date` SET TAGS ('pii_business_glossary_term' = 'Session Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `session_type` SET TAGS ('pii_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `topic` SET TAGS ('pii_business_glossary_term' = 'Topic');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('pii_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('pii_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('pii_category' = 'governance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Chair Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `establishment_date` SET TAGS ('pii_business_glossary_term' = 'Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `joint_action_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Joint Action Plan');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `network_level` SET TAGS ('pii_business_glossary_term' = 'Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `network_name` SET TAGS ('pii_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `network_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `terms_of_reference_url` SET TAGS ('pii_business_glossary_term' = 'ToR URL');
