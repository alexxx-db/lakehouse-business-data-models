-- Schema for Domain: safeguarding | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-03 06:20:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`safeguarding` COMMENT 'Systems of record: Primero (case management for child protection), dedicated PSEA case tracking systems, HR disciplinary systems. Covers PSEA policies, incident investigation, survivor support, and community awareness.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` (
    `psea_policy_id` BIGINT COMMENT 'Primary key for the PSEA policy record.',
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

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`incident` (
    `incident_id` BIGINT COMMENT 'Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Donor agreements (USAID, DFID, UN) mandate incident notification within 24-72 hours tied to the specific award. Compliance officers must identify which donor to notify and which awards reporting obli',
    `country_id` BIGINT COMMENT 'FK to the country where incident occurred.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country offices are the accountable entity for safeguarding incident management, donor notifications, and regulatory reporting. NGO accountability frameworks require country office directors to own in',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: PSEA/safeguarding incident reporting requires linking incidents to the emergency context in which they occurred. Donor notifications, IASC PSEA compliance reports, and cluster coordination updates all',
    `focal_point_id` BIGINT COMMENT 'FK to the assigned focal point.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: NGO donor notification process: when an incident triggers donor_notification_required_flag, staff must identify which donor fund is implicated to fulfill contractual notification obligations. This FK ',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Safeguarding incidents must be attributed to the intervention in which they occurred for CHS compliance, donor incident reporting, and intervention-level safeguarding performance monitoring. This is a',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Safeguarding incidents frequently involve implementing partner organizations. Donor reporting, PSEA investigations, and accountability frameworks require identifying which partner org is implicated. T',
    `project_site_id` BIGINT COMMENT 'FK to the project site where incident occurred.',
    `psea_policy_id` BIGINT COMMENT 'FK to the governing PSEA policy.',
    `reporting_channel_id` BIGINT COMMENT 'FK to the channel through which the incident was reported.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Safeguarding incidents frequently occur during partner-implemented subawards. The subaward governs partner flow-down obligations and reporting duties. Linking incident to subaward enables partner acco',
    `team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Safeguarding incidents are often associated with specific field teams whose members are involved as witnesses, alleged perpetrators, or first responders. Linking enables team-level incident pattern an',
    `incident_category` STRING COMMENT 'Category classification of the incident.',
    `closure_date` DATE COMMENT 'Date the incident was closed.',
    `closure_reason` STRING COMMENT 'Reason for closure.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `donor_notification_date` DATE COMMENT 'Date donor was notified.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Whether donor notification is required.',
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
    `safeguarding_incident_description` STRING COMMENT 'Narrative description of the incident. PII protected.',
    `severity_level` STRING COMMENT 'Severity level (Critical, High, Medium, Low).',
    `survivor_count` STRING COMMENT 'Number of survivors involved.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'SSOT for safeguarding incidents including PSEA (Protection from Sexual Exploitation and Abuse), sexual harassment, child protection violations, and abuse of power. Distinct from compliance.compliance_incident which covers regulatory/financial compliance breaches.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Donor notification of safeguarding investigations is a distinct compliance obligation from incident notification under most major donor frameworks. Linking investigation directly to award enables inve',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: When a safeguarding investigation involves a registered beneficiary, investigators must access the full case record for context (prior incidents, service history, vulnerability profile). This link sup',
    `incident_id` BIGINT COMMENT 'FK to the safeguarding incident.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Safeguarding investigations frequently target implementing partner organizations. Donor-mandated investigation reports must identify the partner org under investigation. This link enables partner acco',
    `psea_policy_id` BIGINT COMMENT 'FK to the governing PSEA policy.',
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
    `incident_id` BIGINT COMMENT 'FK to the safeguarding incident.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Survivor records must capture the project site where the survivor was being served or where the incident occurred. Site-level safeguarding reviews, referral pathway planning, and geographic clustering',
    `registrant_id` BIGINT COMMENT 'FK to the beneficiary registrant if applicable.',
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
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: A survivor support plan in NGO operations is coordinated with the broader case management system. Linking to case_record enables case workers to access the full service history alongside the safeguard',
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

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGO safeguarding risk assessments are scoped to specific program components (e.g., cash transfer vs. protection components carry distinct SEA risk profiles). Component-level risk assessment is require',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country offices commission, review, and approve safeguarding risk assessments as part of their operational accountability. Country directors sign off on risk mitigation plans. This link enables countr',
    `focal_point_id` BIGINT COMMENT 'Foreign key linking to safeguarding.focal_point. Business justification: A safeguarding risk assessment is typically conducted or overseen by the designated PSEA/safeguarding focal point responsible for the geographic area or organizational unit being assessed. Linking ris',
    `project_site_id` BIGINT COMMENT 'FK to the project site.',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: A safeguarding risk assessment is conducted under the governance of a specific PSEA policy. Linking risk_assessment to psea_policy establishes which policy framework governed the assessment, enabling ',
    `team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Safeguarding risk assessments are scoped to specific field teams to evaluate deployment-level SEA and child safeguarding risks. Team composition, operating context, and beneficiary contact patterns de',
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
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Reporting channels are established, funded, and managed by country offices. Country offices are accountable for ensuring accessible complaint mechanisms per PSEA policy. This link enables country-offi',
    `focal_point_id` BIGINT COMMENT 'Foreign key linking to safeguarding.focal_point. Business justification: Each reporting channel (hotline, email, community-based mechanism) is managed and overseen by a designated safeguarding focal point. Linking reporting_channel to focal_point establishes operational ow',
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
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Safeguarding focal points are designated by and report to a specific country office. Country office management tracks focal point coverage, training compliance, and workload. This link is required for',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_reporting_channel_id` FOREIGN KEY (`reporting_channel_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`reporting_channel`(`reporting_channel_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_survivor_record_id` FOREIGN KEY (`survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('dbx_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'PSEA Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `whistleblower_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Protection');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `zero_tolerance_statement_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Tolerance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `reporting_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `donor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `involves_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Involves Minor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `location_description` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `perpetrator_count` SET TAGS ('dbx_business_glossary_term' = 'Perpetrator Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `referred_to_authorities_flag` SET TAGS ('dbx_business_glossary_term' = 'Referred to Authorities');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ALTER COLUMN `survivor_count` SET TAGS ('dbx_business_glossary_term' = 'Survivor Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'PSEA Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `conclusion` SET TAGS ('dbx_business_glossary_term' = 'Conclusion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `evidence_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `external_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'External Referral');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `witnesses_interviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Witnesses Interviewed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Action ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('dbx_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Record ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `disability_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `is_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Minor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safety_plan_in_place_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `sex` SET TAGS ('dbx_pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_status` SET TAGS ('dbx_business_glossary_term' = 'Support Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('dbx_business_glossary_term' = 'Survivor Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('dbx_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Support Plan ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Record');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `notes` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safety_measures` SET TAGS ('dbx_business_glossary_term' = 'Safety Measures');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safety_measures` SET TAGS ('dbx_sensitivity' = 'pii_beneficiary_protected');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `services_required` SET TAGS ('dbx_business_glossary_term' = 'Services Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `child_safeguarding_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Child Safeguarding Risk');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `overall_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `sea_risk_score` SET TAGS ('dbx_business_glossary_term' = 'SEA Risk Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `sh_risk_score` SET TAGS ('dbx_business_glossary_term' = 'SH Risk Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_details` SET TAGS ('dbx_business_glossary_term' = 'Contact Details');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `is_anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `is_confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `languages_supported` SET TAGS ('dbx_business_glossary_term' = 'Languages');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `designation_date` SET TAGS ('dbx_business_glossary_term' = 'Designation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed');
