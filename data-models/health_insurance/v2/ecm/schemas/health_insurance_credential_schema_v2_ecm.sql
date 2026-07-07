-- Schema for Domain: credential | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`credential` COMMENT 'Manages the provider credentialing and re-credentialing lifecycle — primary source verification (PSV), NCQA credentialing standards, committee decisions, sanctions screening (OIG/SAM), DEA and state license validation, malpractice history, hospital privileges verification, and credentialing event history. Distinct from provider identity (owned by provider domain); credential owns the qualification and approval workflow that gates network participation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`application` (
    `application_id` BIGINT COMMENT 'Primary key for application',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation for credentialing application processing is required for monthly cost‑center expense reporting.',
    `delegated_entity_id` BIGINT COMMENT 'Identifier of the external entity that delegated the credentialing submission.',
    `employee_id` BIGINT COMMENT 'Identifier of the credentialing specialist responsible for managing this application.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for Provider Application for Plan Network Enrollment; the application must specify which health plan the provider seeks to join.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider (e.g., NPI) to whom the credentialing application belongs.',
    `application_date` DATE COMMENT 'Date the credentialing application was originally submitted.',
    `application_number` STRING COMMENT 'External reference number assigned to the credentialing application, used for tracking and communication with providers.',
    `application_status` STRING COMMENT 'Current workflow state of the credentialing application.. Valid values are `received|in_review|psv_in_progress|committee_ready|decided|closed`',
    `application_type` STRING COMMENT 'Indicates whether the submission is an initial credentialing, a re‑credentialing, or a reinstatement request.. Valid values are `initial|recredential|reinstatement|reinstatement`',
    `committee_decision` STRING COMMENT 'Outcome of the credentialing committee review.. Valid values are `approved|denied|pending|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was first created in the system.',
    `credentialing_cycle_year` STRING COMMENT 'Calendar year of the credentialing cycle for reporting purposes.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_license_number` STRING COMMENT 'Drug Enforcement Administration license number for controlled substance prescribing.',
    `decision_date` DATE COMMENT 'Date the committee rendered its decision.',
    `disposition` STRING COMMENT 'Final disposition of the application after committee decision.. Valid values are `approved|denied|withdrawn|expired|cancelled`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date the credentialing approval expires and a new application is required.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hospital_privileges_verified` BOOLEAN COMMENT 'True when hospital privileges have been confirmed as part of the credentialing.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_delegated` BOOLEAN COMMENT 'True if the application was submitted by a delegated entity on behalf of the provider.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether the application has been marked as urgent.',
    `last_psv_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the primary source verification data.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the providers state medical license.',
    `malpractice_history_flag` BOOLEAN COMMENT 'Indicates whether the provider has a disclosed malpractice history.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncqa_cycle` STRING COMMENT 'NCQA cycle identifier applicable to this credentialing application.',
    `notes` STRING COMMENT 'Free‑form notes captured by the specialist during processing.',
    `npdb_query_date` DATE COMMENT 'Date the National Practitioner Data Bank was queried for this provider.',
    `primary_psv_status` STRING COMMENT 'Status of the primary source verification process.. Valid values are `pending|in_progress|completed|failed`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `requires_additional_documents` BOOLEAN COMMENT 'True if the provider must submit supplemental documentation.',
    `sanction_screening_status` STRING COMMENT 'Result of OIG/SAM sanctions screening for the provider.. Valid values are `clear|flagged|pending|under_review`',
    `state_license_number` STRING COMMENT 'State medical license number for the provider.',
    `submission_channel` STRING COMMENT 'Method by which the application was received (paper, web portal, CVO, or delegated entity).. Valid values are `paper|portal|cvo|delegated`',
    `target_completion_date` DATE COMMENT 'Planned date by which the credentialing process should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the application record.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Core master record for a provider credentialing or re-credentialing application submitted to the health plan. Captures the full lifecycle of the credentialing request — application date, application type (initial, re-credential, reinstatement), submission channel (paper, portal, CVO, delegated entity), current workflow status (received, in-review, PSV-in-progress, committee-ready, decided, closed), assigned credentialing specialist, NCQA credentialing cycle, target completion date, expiration date, and overall disposition. This is the central orchestrating entity — all downstream verification activities (PSV), sanctions screenings, NPDB queries, committee reviews, attestations, and outreach communications link back to this application. Sourced from CAQH ProView, Cactus, ProviderSource, or direct submission.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`record` (
    `record_id` BIGINT COMMENT 'Unique surrogate key for the credential record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for audit trail of which credentialing staff created/maintained each credential record; essential for compliance reporting (NCQA, state licensing).',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider to whom this credential applies.',
    `created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credential record was first created in the system.',
    `credential_entity_code` STRING COMMENT 'Code identifying the health plan or delegated organization that issued the credential.',
    `credential_expiration_reason` STRING COMMENT 'Reason why the credential was terminated or expired.. Valid values are `end_of_term|revoked|suspended|voluntary|other`',
    `credential_revocation_date` DATE COMMENT 'Date on which the credential was revoked, if applicable.',
    `credential_source_system` STRING COMMENT 'Name of the source system that supplied the credential data.',
    `credential_status` STRING COMMENT 'Current lifecycle status of the credential.. Valid values are `active|expired|suspended|revoked|terminated|pending`',
    `credential_suspension_end` DATE COMMENT 'End date of the suspension period for the credential.',
    `credential_suspension_start` DATE COMMENT 'Start date of any suspension period for the credential.',
    `credential_tier` STRING COMMENT 'Tier level assigned to the credential based on provider qualifications.. Valid values are `tier1|tier2|tier3|tier4`',
    `credential_type` STRING COMMENT 'Classification of the credential (e.g., primary, secondary, delegated, direct).. Valid values are `primary|secondary|delegated|direct`',
    `credential_version` STRING COMMENT 'Version number of the credential record for change tracking.',
    `credentialing_committee_decision_date` DATE COMMENT 'Date the credentialing committee rendered its decision.',
    `credentialing_committee_outcome` STRING COMMENT 'Outcome of the credentialing committee review.. Valid values are `approved|denied|conditional`',
    `credentialing_review_notes` STRING COMMENT 'Free‑text notes from the credentialing review process.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_license_number` STRING COMMENT 'Drug Enforcement Administration registration number for controlled substance prescribing.',
    `delegated_credential_flag` BOOLEAN COMMENT 'True if credentialing was performed by a delegated entity rather than the health plan directly.',
    `effective_date` DATE COMMENT 'Date when the credential becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the credential expires.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hospital_privileges_flag` BOOLEAN COMMENT 'Indicates whether the provider holds active hospital privileges.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the providers state medical license.',
    `malpractice_claims_count` STRING COMMENT 'Number of malpractice claims filed against the provider.',
    `malpractice_history_flag` BOOLEAN COMMENT 'True if the provider has any recorded malpractice claims.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncqa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the credential meets NCQA credentialing requirements.',
    `next_recredentialing_due` DATE COMMENT 'Scheduled date by which the next re‑credentialing must be completed.',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `recredentialing_date` DATE COMMENT 'Date of the most recent successful re‑credentialing cycle.',
    `sanctions_screened_flag` BOOLEAN COMMENT 'True if the provider has been screened against OIG and SAM sanctions lists.',
    `state_license_number` STRING COMMENT 'State medical license identifier for the provider.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credential record.',
    `version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    CONSTRAINT pk_record PRIMARY KEY(`record_id`)
) COMMENT 'Authoritative master record of a providers current credentialing status with the health plan. Represents the approved, active credential that gates network participation — distinct from the application workflow that produced it. Stores credentialing effective date, expiration date, credential tier (if applicable), delegated vs. direct credentialing flag, NCQA compliance status, credentialing entity (health plan or delegated entity), last re-credentialing completion date, next re-credentialing due date, and overall standing (active, expired, suspended, revoked, voluntarily terminated). One record per provider per credentialing entity. This is the SSOT for is this provider credentialed and eligible for network participation? — consumed by the provider and network domains to determine participation status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` (
    `psv_verification_id` BIGINT COMMENT 'Unique surrogate key for each PSV verification record.',
    `employee_id` BIGINT COMMENT 'Internal identifier of the person or system that performed the verification.',
    `provider_id` BIGINT COMMENT 'Internal identifier of the provider to whom this credential element belongs.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Primary source verifications support a credential record; provider_id redundant.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: PSV verification is often performed by third‑party vendors; linking enables audit of vendor‑performed verifications.',
    `board_certification` STRING COMMENT 'Identifier for the board certification (e.g., ABMS certificate number).',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credential_element_identifier` STRING COMMENT 'The unique identifier assigned by the issuing authority for the credential element.',
    `credential_element_type` STRING COMMENT 'Discriminator indicating the kind of credential element being verified.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_schedule` STRING COMMENT 'Schedule (I‑V) associated with a DEA registration.',
    `effective_date` DATE COMMENT 'Date on which the credential element became effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `element_category` STRING COMMENT 'High‑level grouping of the credential element for reporting and analytics.',
    `element_status` STRING COMMENT 'Current lifecycle status of the credential element.. Valid values are `active|inactive|expired|revoked|pending|suspended`',
    `expiration_date` DATE COMMENT 'Date on which the credential element expires or is no longer valid.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hospital_privilege_scope` STRING COMMENT 'Description of clinical privileges granted at a hospital (e.g., admitting, surgical).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issuing_authority` STRING COMMENT 'Name of the organization that issued or granted the credential element.',
    `license_number` STRING COMMENT 'License number assigned by the state licensing board.',
    `malpractice_insurance_limit` DECIMAL(18,2) COMMENT 'Maximum coverage amount per occurrence or aggregate, as applicable.',
    `malpractice_insurance_type` STRING COMMENT 'Policy type: occurrence or claims‑made.. Valid values are `occurrence|claims_made`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PSV verification record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PSV verification record.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `training_program` STRING COMMENT 'Name of residency, fellowship, or other graduate medical education program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verification_date` DATE COMMENT 'Date on which the verification was completed.',
    `verification_method` STRING COMMENT 'Method used to perform the primary source verification.. Valid values are `electronic|mail|phone|in_person|fax`',
    `verification_notes` STRING COMMENT 'Free‑text comments captured during verification (e.g., discrepancies, follow‑up actions).',
    `verification_result` STRING COMMENT 'Outcome of the verification attempt.. Valid values are `verified|unable_to_verify|discrepancy|pending`',
    `work_history_details` STRING COMMENT 'Narrative description of recent work positions, gaps, and explanations.',
    `work_history_years` STRING COMMENT 'Number of years of professional work experience in the last five years.',
    CONSTRAINT pk_psv_verification PRIMARY KEY(`psv_verification_id`)
) COMMENT 'Unified master record for each credential element held by a provider and its primary source verification (PSV). This is the SOLE authoritative product (SSOT) for ALL verifiable credential element types — no other product in this domain stores credential element data. Supported element types include: state professional licenses (MD, DO, NP, PA, RN, LCSW), DEA controlled substance registrations (with schedules II-V), specialty board certifications (ABMS, AOA, ABPS with MOC status), professional liability (malpractice) insurance (occurrence/claims-made, per-occurrence and aggregate limits, tail coverage), hospital clinical privileges (admitting, surgical, procedural, courtesy), graduate medical education and training (medical school, residency, fellowship, ECFMG for IMGs), and professional work history (5-year history with gap explanations per NCQA). Each record stores: element type discriminator, issuing/granting authority, element-specific attributes (number, schedules, limits, scope, restrictions), effective and expiration dates, current status, PSV source contacted (FSMB, AMA, ABMS, NPDB, OIG, DEA Diversion Control, state boards, facilities, carriers, ECFMG), verification method, verification date, verification result (verified, unable to verify, discrepancy), and verifier identity. One record per credential element per provider per application cycle. Core to NCQA CR 1-4 compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` (
    `sanction_screening_id` BIGINT COMMENT 'Primary key for sanction_screening',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the most recent review.',
    `provider_id` BIGINT COMMENT 'Foreign key to the provider entity being screened.',
    `record_id` BIGINT COMMENT 'Foreign key to the credential record to which this screening pertains.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Sanction screening services are outsourced; vendor linkage required for compliance reporting and cost allocation.',
    `compliance_requirement` STRING COMMENT 'Regulatory rule that mandates the screening (e.g., CMS Conditions of Participation).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening record was first created in the lakehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `databases_queried` STRING COMMENT 'Comma‑separated list of external sanction/exclusion databases queried during the screening.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `impact_on_credential_status` STRING COMMENT 'Effect of the sanction on the providers credentialing status within the network.. Valid values are `hold|suspend|revoke|none`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the screening result was last reviewed by a credentialing committee.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the screening record.. Valid values are `active|inactive|archived`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source` STRING COMMENT 'Originating operational system that supplied the screening data (e.g., Provider Management System).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific regulation or guidance (e.g., 42 CFR Part 482).',
    `resolution_status` STRING COMMENT 'Current status of the screening resolution workflow.. Valid values are `hold|cleared|escalated|closed`',
    `result_detail` STRING COMMENT 'Free‑text description of the match or reason for pending review, including identifiers of the finding.',
    `sanction_effective_date` DATE COMMENT 'Date when the sanction or exclusion became effective.',
    `sanction_end_date` DATE COMMENT 'Date when the sanction or exclusion expires or is lifted, if known.',
    `sanction_type` STRING COMMENT 'Category of confirmed adverse action identified by the screening.. Valid values are `exclusion|sanction|disciplinary|license_revocation`',
    `sanctioning_authority` STRING COMMENT 'Entity that issued the sanction or exclusion (e.g., OIG, CMS, State Health Department).',
    `screening_event_type` STRING COMMENT 'Classifies the screening as an initial credentialing check, a scheduled routine check, or a triggered ad‑hoc check.. Valid values are `initial|routine|triggered`',
    `screening_initiated_by` STRING COMMENT 'User ID or system name that triggered the screening.',
    `screening_notes` STRING COMMENT 'Additional comments or observations captured by the reviewer.',
    `screening_result` STRING COMMENT 'Outcome of the screening: no issues, a potential match, or pending manual review.. Valid values are `clear|match_found|pending_review`',
    `screening_timestamp` TIMESTAMP COMMENT 'Date‑time when the screening was performed.',
    `severity_level` STRING COMMENT 'Risk severity assigned to the sanction based on impact and regulatory guidance.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the screening record.',
    CONSTRAINT pk_sanction_screening PRIMARY KEY(`sanction_screening_id`)
) COMMENT 'Consolidated record for the full sanctions and exclusions lifecycle — both screening events and confirmed adverse findings. Captures each screening event (date, type — initial/monthly routine/triggered, databases queried including OIG LEIE, SAM.gov, state Medicaid exclusion lists, NPDB, screening result — clear/match found/pending review, resolution status) and each confirmed sanction, exclusion, or disciplinary action (sanction type, sanctioning authority, effective/end dates, severity, impact on credentialing status). Record type discriminator distinguishes screening events from confirmed sanctions. Monthly OIG/SAM screening is a CMS Conditions of Participation requirement. Confirmed sanctions drive automatic credentialing holds and committee escalation. Links to application for initial/re-credentialing screenings; routine monthly screenings may exist independently.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` (
    `npdb_query_id` BIGINT COMMENT 'System-generated unique identifier for each NPDB query record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who initiated the NPDB query.',
    `provider_id` BIGINT COMMENT 'Internal system identifier of the provider being queried.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: NPDB queries are tied to a credential record; provider_id duplicated.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: NPDB queries may be executed by external data‑vendor platforms; linking supports audit trails and spend tracking.',
    `confidentiality_level` STRING COMMENT 'Data classification for the record as defined by enterprise policy.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPDB query record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcqia_compliance_flag` BOOLEAN COMMENT 'Indicates whether the query satisfies HCQIA mandatory credentialing requirements.',
    `internal_review_disposition` STRING COMMENT 'Health plans internal decision after reviewing NPDB reports.. Valid values are `reviewed|flagged|no_action`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_continuous_enrollment` BOOLEAN COMMENT 'True if the provider is enrolled in continuous NPDB monitoring.',
    `last_report_date` DATE COMMENT 'Date of the most recent adverse action report returned.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Optional free‑text comments or observations about the query.',
    `npdb_assigned_query_number` STRING COMMENT 'Identifier assigned by NPDB for the submitted query.',
    `npdb_query_status` STRING COMMENT 'Current processing status of the NPDB query.. Valid values are `pending|completed|error|partial`',
    `number_of_reports` STRING COMMENT 'Total count of individual adverse action reports returned by NPDB for this query.',
    `provider_npi` STRING COMMENT '10‑digit NPI of the provider, used for external identification.. Valid values are `^d{10}$`',
    `query_type` STRING COMMENT 'Type of credentialing query: initial, re‑credentialing, or continuous monitoring.. Valid values are `initial|recredentialing|continuous`',
    `query_version` STRING COMMENT 'Version string of the NPDB query schema used for this submission.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `report_processing_time_seconds` STRING COMMENT 'Elapsed time in seconds between query submission and receipt of the final report.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the NPDB returned the query response.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date‑time when the NPDB query was submitted to the NPDB system.',
    `total_malpractice_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount of malpractice payments reported across all returned reports.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this NPDB query record.',
    CONSTRAINT pk_npdb_query PRIMARY KEY(`npdb_query_id`)
) COMMENT 'Transactional record of each National Practitioner Data Bank (NPDB) query and the individual adverse action or malpractice payment reports returned. Header-detail structure: header captures query submission (query type — initial/re-credentialing/continuous, submission date, NPDB-assigned query ID, queried provider, response date, number of reports returned); detail captures each report returned (NPDB report ID, report type — malpractice payment/clinical privileges action/DEA action/exclusion-debarment/judgment-conviction, reporting entity, subject of report, incident date, payment amount for malpractice, action taken, action date, and the health plans internal review disposition — reviewed/flagged for committee/no action required). NPDB querying is mandatory under HCQIA for initial credentialing and re-credentialing. Continuous Query enrollment status tracked here. Each query with its nested reports is a complete transactional record.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` (
    `committee_review_id` BIGINT COMMENT 'Primary key for committee_review',
    `committee_id` BIGINT COMMENT 'Reference to the master record of the credentialing committee.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Committee review pertains to a specific credential record; linking enables traceability and removes need for duplicate provider info.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks the employee who records the credentialing committee decision; needed for committee minutes and regulatory audit.',
    `agenda_items` STRING COMMENT 'List of agenda items discussed during the committee meeting.',
    `appeal_rights_notification_date` DATE COMMENT 'Date the provider was notified of appeal rights following a denial.',
    `chair_name` STRING COMMENT 'Legal full name of the committee chair.',
    `chair_npi` STRING COMMENT 'National Provider Identifier of the committee chair.',
    `committee_review_status` STRING COMMENT 'Current lifecycle status of the committee review.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `compliance_flag_dea_valid` BOOLEAN COMMENT 'True if the providers DEA registration is valid.',
    `compliance_flag_malpractice_history` BOOLEAN COMMENT 'True if the provider has a documented malpractice history.',
    `compliance_flag_oig_sanction` BOOLEAN COMMENT 'True if the provider is flagged on the OIG sanctions list.',
    `compliance_flag_state_license_valid` BOOLEAN COMMENT 'True if the provider holds a current state medical license.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the committee review record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_conditions` STRING COMMENT 'Specific conditions or restrictions attached to an approved decision.',
    `decision_effective_date` DATE COMMENT 'Date when the committee decision becomes effective.',
    `decision_expiration_date` DATE COMMENT 'Date when the decision expires or must be re-evaluated (nullable).',
    `decision_rationale` STRING COMMENT 'Narrative explanation supporting the committees decision.',
    `decision_type` STRING COMMENT 'Outcome of the committee decision for a provider.. Valid values are `approved|approved_with_conditions|deferred|denied|revoked|suspended`',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating why a providers credentialing was denied.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `meeting_timestamp` TIMESTAMP COMMENT 'Date and time when the committee meeting took place.',
    `notes` STRING COMMENT 'Free-text field for any supplemental information about the committee review.',
    `quorum_indicator` BOOLEAN COMMENT 'True if the meeting met quorum requirements; otherwise False.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_number` STRING COMMENT 'External business identifier assigned to the committee review session (e.g., CR-2023-0001).',
    `review_type` STRING COMMENT 'Category of the committee session: credentialing, quality, or peer review.. Valid values are `credentialing|quality|peer_review`',
    `total_providers_reviewed` STRING COMMENT 'Count of distinct providers whose credentials were reviewed in this session.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the committee review record.',
    `voting_record` STRING COMMENT 'Summary of how the committee voted (e.g., unanimous, majority, split).',
    CONSTRAINT pk_committee_review PRIMARY KEY(`committee_review_id`)
) COMMENT 'Master record of a credentialing committee or peer review committee session and the formal credentialing decisions rendered. Captures committee meeting details (date, committee type — credentialing/quality/peer review, quorum indicator, agenda items, committee chair attestation) and the per-provider decisions produced (decision type — approved/approved with conditions/deferred/denied/revoked/suspended, decision effective date, decision expiration date, conditions or restrictions imposed, denial reason codes, appeal rights notification date, voting record, decision rationale). This is the authoritative record that triggers network participation status changes and is the SSOT for credentialing decisions — no separate decision product exists. NCQA requires documented committee review for all credentialing decisions. One committee session record with embedded per-provider decision outcomes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` (
    `recredential_cycle_id` BIGINT COMMENT 'Primary key for recredential_cycle',
    `employee_id` BIGINT COMMENT 'Identifier of the internal staff member responsible for managing the cycle.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider whose credential is being re‑credentialed.',
    `record_id` BIGINT COMMENT 'Identifier of the credential record associated with the provider.',
    `application_received_date` DATE COMMENT 'Date the provider submitted the recredentialing application.',
    `compliance_requirements` STRING COMMENT 'List of specific compliance items (e.g., DEA license, state license) required for this cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recredentialing cycle record was first created.',
    `cycle_completion_date` DATE COMMENT 'Date the recredentialing cycle was marked completed.',
    `cycle_due_date` DATE COMMENT 'Date by which the recredentialing must be completed (typically 36 months from start).',
    `cycle_priority` STRING COMMENT 'Priority level assigned to the cycle for scheduling and escalation.. Valid values are `low|medium|high`',
    `cycle_start_date` DATE COMMENT 'Date the recredentialing cycle officially begins.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the recredentialing cycle.. Valid values are `scheduled|in_progress|completed|overdue|waived`',
    `cycle_type` STRING COMMENT 'Classification of the cycle (full, partial, or renewal).. Valid values are `full|partial|renewal`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_date` DATE COMMENT 'Date the escalation was triggered.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the cycle has been escalated due to approaching due date or non‑response.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes captured by staff during the cycle.',
    `outreach_attempt_count` STRING COMMENT 'Number of outreach attempts made to the provider during the cycle.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the governing regulation or standard that mandates the recredentialing (e.g., NCQA 2023).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recredentialing cycle record.',
    CONSTRAINT pk_recredential_cycle PRIMARY KEY(`recredential_cycle_id`)
) COMMENT 'Master record managing the re-credentialing cycle schedule for each credentialed provider. Captures cycle start date, cycle due date (NCQA mandates re-credentialing every 36 months), cycle status (scheduled, in-progress, completed, overdue, waived), outreach attempts and dates, application received date, and cycle completion date. Drives automated workflow triggers for re-credentialing initiation, provider outreach, and escalation when providers approach expiration. Distinct from the credentialing application — this is the scheduling and tracking wrapper.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` (
    `delegated_entity_id` BIGINT COMMENT 'Primary key for delegated_entity',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Regulatory requirement to track which external vendor provides delegated credentialing services for each entity.',
    `audit_notes` STRING COMMENT 'Free‑form observations, findings, and recommendations from the latest audit.',
    `audit_result` STRING COMMENT 'Outcome of the most recent audit (e.g., compliant, non‑compliant, conditional).. Valid values are `compliant|non_compliant|conditional`',
    `audit_schedule` STRING COMMENT 'Planned frequency for oversight audits of the delegated credentialing entity.. Valid values are `annual|semiannual|quarterly|monthly`',
    `compliance_requirements` STRING COMMENT 'Regulatory and accreditation requirements that the delegate must satisfy (e.g., OIG, SAM, HIPAA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delegated entity record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delegated_entity_status` STRING COMMENT 'Current lifecycle status of the delegation relationship.. Valid values are `active|suspended|terminated|pending`',
    `delegation_agreement_number` STRING COMMENT 'External contract number assigned to the delegation agreement between the health plan and the delegate organization.',
    `delegation_scope` STRING COMMENT 'Specific scope of authority granted to the delegate organization.. Valid values are `full_credentialing|recredentialing|primary_source_verification`',
    `delegation_type` STRING COMMENT 'Category of delegation: full credentialing, re‑credentialing only, or primary source verification only.. Valid values are `full|recredentialing|psv`',
    `effective_date` DATE COMMENT 'Date when the delegation agreement becomes legally binding.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit performed on the delegate.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncqa_accreditation_status` STRING COMMENT 'Current accreditation status of the delegate organization according to NCQA standards.. Valid values are `accredited|not_accredited|pending`',
    `npi` STRING COMMENT 'Unique 10‑digit identifier for the delegated organization as assigned by the National Plan and Provider Enumeration System.. Valid values are `^d{10}$`',
    `organization_name` STRING COMMENT 'Legal name of the organization to which credentialing authority is delegated.',
    `oversight_audit_frequency_months` STRING COMMENT 'Number of months between scheduled oversight audits of the delegate.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source` STRING COMMENT 'Name of the source system that supplied the delegated entity data (e.g., ProviderSource, Cactus).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference code linking the delegation to a specific regulatory mandate or guidance.. Valid values are `^[A-Z]{2,5}-d{3,6}$`',
    `termination_date` DATE COMMENT 'Date on which the delegation agreement ends or is terminated (null if open‑ended).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delegated entity record.',
    CONSTRAINT pk_delegated_entity PRIMARY KEY(`delegated_entity_id`)
) COMMENT 'Master record for an organization (hospital system, medical group, IPA, CVO) to which the health plan has delegated credentialing authority under a formal delegation agreement. Captures delegate organization name, NPI, delegation agreement effective date, delegation scope (full credentialing, re-credentialing, primary source verification), NCQA accreditation status of the delegate, oversight audit schedule, last audit date, audit result, and delegation status (active, suspended, terminated). NCQA requires health plans to oversee and audit delegated credentialing entities.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` (
    `delegation_audit_id` BIGINT COMMENT 'System-generated unique identifier for the delegation audit record.',
    `delegated_entity_id` BIGINT COMMENT 'Identifier of the delegated credentialing entity being audited.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the individual or entity that performed the audit.',
    `audit_date` DATE COMMENT 'Date on which the audit was performed (principal business event).',
    `audit_disposition` STRING COMMENT 'Final outcome of the audit: passed, passed with conditions, or failed.. Valid values are `passed|passed_with_conditions|failed`',
    `audit_notes` STRING COMMENT 'Additional observations, comments, or contextual information captured by the auditor.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit, often used in reports and communications.',
    `audit_period_end` DATE COMMENT 'End date of the audit coverage period.',
    `audit_period_start` DATE COMMENT 'Start date of the audit coverage period.',
    `audit_scope` STRING COMMENT 'Narrative description of the functional and geographic scope covered by the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit record.. Valid values are `pending|in_progress|completed|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit based on purpose: initial, annual, or for‑cause.. Valid values are `initial|annual|for_cause`',
    `audit_year` STRING COMMENT 'Calendar year in which the audit took place.',
    `auditor_name` STRING COMMENT 'Full legal name of the auditor.',
    `compliance_findings` STRING COMMENT 'Free‑text summary of findings mapped to NCQA standard elements.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the delegated entity must complete required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions were mandated as a result of the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first inserted into the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delegation_entity_name` STRING COMMENT 'Legal name of the delegated credentialing organization.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `files_reviewed_count` STRING COMMENT 'Total count of credentialing files examined during the audit.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `overall_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage (0‑100) representing overall compliance across all NCQA elements.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the governing standard or regulation (e.g., NCQA CR 5).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_delegation_audit PRIMARY KEY(`delegation_audit_id`)
) COMMENT 'Transactional record of an oversight audit conducted on a delegated credentialing entity. Captures audit date, audit type (initial, annual, for-cause), audit scope, auditor identity, number of files reviewed, compliance findings by NCQA standard element, overall compliance rate, corrective action required indicator, corrective action plan due date, and audit disposition (passed, passed with conditions, failed). Required by NCQA CR 5 to ensure delegated entities meet health plan credentialing standards. Each audit is a distinct transactional record.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` (
    `cvo_relationship_id` BIGINT COMMENT 'System-generated unique identifier for the CVO relationship record.',
    `delegated_entity_id` BIGINT COMMENT 'Identifier of the Credentials Verification Organization (CVO) engaged.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan that contracts with the CVO.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the record.',
    `compliance_flag` STRING COMMENT 'Indicates whether the CVO relationship meets current regulatory compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `contact_address` STRING COMMENT 'Mailing address for the CVO contact.',
    `contact_email` STRING COMMENT 'Email address of the primary CVO contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Primary contact person name for the CVO relationship.',
    `contact_phone` STRING COMMENT 'Phone number of the primary CVO contact.',
    `contract_number` STRING COMMENT 'External contract reference number assigned by the health plan.',
    `contract_type` STRING COMMENT 'Scope of services provided by the CVO under the contract.. Valid values are `psv_only|full_file_preparation|ongoing_monitoring`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CVO relationship record was first created.',
    `cvo_relationship_status` STRING COMMENT 'Current lifecycle status of the CVO relationship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the CVO relationship becomes binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the CVO relationship ends or is scheduled to terminate (null if open-ended).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount payable to the CVO for contracted services.',
    `fee_currency` STRING COMMENT 'Currency code for the contract fee (e.g., USD).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exclusive` BOOLEAN COMMENT 'True if the CVO is the exclusive provider of credentialing services for the health plan.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or performance review.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncqa_certification_expiration` DATE COMMENT 'Expiration date of the CVOs NCQA certification.',
    `ncqa_certified` BOOLEAN COMMENT 'Indicates whether the CVO holds a current NCQA certification.',
    `notes` STRING COMMENT 'Free-text field for additional comments or special conditions.',
    `payment_terms` STRING COMMENT 'Standard payment terms for the contract.. Valid values are `net_30|net_45|net_60|upon_receipt`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the governing regulatory body or standard (e.g., CMS, NCQA) applicable to the contract.',
    `relationship_type` STRING COMMENT 'Classification of the CVO relationship (e.g., primary vendor, secondary backup).. Valid values are `primary|secondary|backup`',
    `termination_reason` STRING COMMENT 'Reason provided for contract termination, if applicable.',
    `turnaround_time_sla_days` STRING COMMENT 'Maximum number of calendar days the CVO must complete primary source verification per service level agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CVO relationship record.',
    CONSTRAINT pk_cvo_relationship PRIMARY KEY(`cvo_relationship_id`)
) COMMENT 'Master record representing the relationship between the health plan and a Credentials Verification Organization (CVO) engaged to perform PSV and credentialing file preparation services. Captures CVO organization name, NCQA CVO certification status and expiration, contracted services scope (PSV only, full file preparation, ongoing monitoring), contract effective date, contract expiration date, turnaround time SLAs, and relationship status. Distinct from delegated credentialing entities — CVOs perform verification services but the health plan retains the credentialing decision authority.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` (
    `expedited_credential_id` BIGINT COMMENT 'Primary key for expedited_credential',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captures the credentialing employee approving expedited requests; critical for urgent care provider onboarding and audit of fast‑track decisions.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider for whom expedited credentialing is requested.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Expedited credential requests are for a credential record; provider_id redundant.',
    `approval_committee` STRING COMMENT 'Name of the credentialing committee or board that approved the provisional request.',
    `attestation_received` BOOLEAN COMMENT 'Flag indicating whether the required attestation documentation has been received.',
    `attestation_received_date` DATE COMMENT 'Date the attestation was received.',
    `clinical_urgency_justification` STRING COMMENT 'Narrative explanation of the clinical urgency driving the provisional credential request.',
    `committee_decision_date` DATE COMMENT 'Date the approval committee rendered its decision.',
    `conditions_of_participation` STRING COMMENT 'Specific conditions or limitations imposed on the provider during the provisional period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the expedited credentialing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the currency of the provisional fee.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_license_number` STRING COMMENT 'Drug Enforcement Administration license number for controlled substance prescribing.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expedited_credential_status` STRING COMMENT 'Current lifecycle status of the expedited credentialing request.. Valid values are `pending|approved|denied|expired|converted`',
    `expedited_reason_code` STRING COMMENT 'Standard code indicating the reason for expedited processing.. Valid values are `emergency|disaster|specialist_needed|other`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_credentialing_outcome` STRING COMMENT 'Result of the full credentialing process after the provisional period.. Valid values are `approved|denied|pending|withdrawn`',
    `hospital_privileges_verified` BOOLEAN COMMENT 'Flag indicating verification of hospital privileges for the provider.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the providers DEA or state license.',
    `malpractice_claims_count` STRING COMMENT 'Number of malpractice claims recorded against the provider.',
    `malpractice_history_flag` BOOLEAN COMMENT 'Indicates whether the provider has a known malpractice history.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the expedited request.',
    `outcome_date` DATE COMMENT 'Date the final credentialing outcome was determined.',
    `provider_npi` STRING COMMENT 'Standard 10‑digit identifier for the provider.',
    `provisional_duration_days` STRING COMMENT 'Calculated length of the provisional period in days.',
    `provisional_end_date` DATE COMMENT 'Last day of the provisional participation period.',
    `provisional_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for granting provisional credentialing, if applicable.',
    `provisional_start_date` DATE COMMENT 'First day the provider is allowed to deliver services under provisional status.',
    `psv_verification_date` DATE COMMENT 'Date primary source verification was performed.',
    `psv_verification_flag` BOOLEAN COMMENT 'Indicates whether primary source verification of credentials has been completed.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_number` STRING COMMENT 'Business identifier assigned to the expedited credentialing request.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the expedited credentialing request was submitted.',
    `requesting_entity_reference` BIGINT COMMENT 'Internal identifier of the requesting entity.',
    `requesting_entity_type` STRING COMMENT 'Category of the entity that initiated the expedited request (e.g., hospital, medical group).. Valid values are `hospital|medical_group|health_plan|other`',
    `sanction_screening_flag` BOOLEAN COMMENT 'Indicates whether OIG/SAM sanction screening has been performed.',
    `sanction_screening_result` STRING COMMENT 'Outcome of the sanction screening process.. Valid values are `clear|flagged|pending`',
    `state_license_number` STRING COMMENT 'State medical license number for the provider.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the expedited credentialing record.',
    `urgency_level` STRING COMMENT 'Priority level assigned to the request based on clinical need.. Valid values are `high|medium|low`',
    CONSTRAINT pk_expedited_credential PRIMARY KEY(`expedited_credential_id`)
) COMMENT 'Transactional record for expedited or provisional credentialing requests where a provider needs temporary network participation authorization before the full credentialing process is complete. Captures request date, requesting entity (hospital, medical group, health plan), clinical urgency justification, provisional start date, provisional end date (typically 120 days), conditions of provisional participation, attestation received indicator, and final credentialing outcome. NCQA permits provisional credentialing under specific conditions. Tracks the provisional period and ensures timely conversion to full credential.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` (
    `contract_link_id` BIGINT COMMENT '',
    `record_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT '',
    `link_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `link_type_code` STRING COMMENT '',
    `status_code` STRING COMMENT '',
    CONSTRAINT pk_contract_link PRIMARY KEY(`contract_link_id`)
) COMMENT 'Represents the assignment of a vendor contract to a provider credential record. Each row captures the contract role (primary, supplemental, etc.) and the period during which the contract covers the credential.. Existence Justification: A credential record represents a providers credentialing status with a health plan. Multiple vendor contracts can cover the same credential record (e.g., primary and supplemental credentialing services), and each vendor contract can cover many credential records across providers. The business actively creates, updates, and deletes these links and tracks role, effective and expiration dates for each coverage.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` (
    `obligation_mapping_id` BIGINT COMMENT '',
    `record_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `delegated_entity_id` BIGINT COMMENT '',
    `credential_document_id` BIGINT COMMENT '',
    `mapping_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `evidence_received_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_obligation_mapping PRIMARY KEY(`obligation_mapping_id`)
) COMMENT 'This association product represents the mapping between a credential record and a regulatory obligation. It captures the effective and expiration dates that define when a specific credential satisfies a particular regulatory requirement.. Existence Justification: A credential record can satisfy multiple regulatory obligations (e.g., NCQA, HIPAA) and a single regulatory obligation must be satisfied by many credential records across providers. The business actively tracks each credential‑obligation pairing with effective and expiration dates, making the relationship a true many‑to‑many operational entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`finding` (
    `finding_id` BIGINT COMMENT '',
    `record_id` BIGINT COMMENT '',
    `finding_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    CONSTRAINT pk_finding PRIMARY KEY(`finding_id`)
) COMMENT 'Represents the operational link between a providers credential record and an audit finding. Each row records that a particular finding applies to a specific credential and captures attributes that belong only to this relationship.. Existence Justification: During audit engagements, auditors associate each audit finding with the specific provider credential records that are impacted. A single finding can affect multiple credential records, and a single credential record can be the subject of multiple findings over time. The link is actively created, updated, and tracked as part of the audit remediation process.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee` (
    `committee_id` BIGINT COMMENT 'Primary key for committee',
    `committee_type_id` BIGINT COMMENT 'Identifier for the committee type, referencing the Committee Type reference table.',
    `credential_document_id` BIGINT COMMENT 'Identifier of the approval document in the document management system.',
    `parent_committee_id` BIGINT COMMENT 'Self-referencing FK on committee (parent_committee_id)',
    `approval_by` STRING COMMENT 'Identifier of the user who approved the committee.',
    `approval_comments` STRING COMMENT 'Comments or notes provided during the approval process.',
    `approval_date` DATE COMMENT 'Date when the committee received formal approval.',
    `approval_document_checksum` STRING COMMENT 'Checksum value for integrity verification of the approval document.',
    `approval_document_created_at` TIMESTAMP COMMENT 'Timestamp when the approval document was created.',
    `approval_document_format` STRING COMMENT 'File format of the approval document (e.g., PDF, DOCX).',
    `approval_document_size` BIGINT COMMENT 'Size of the approval document in bytes.',
    `approval_document_type` STRING COMMENT 'Type of the approval document (e.g., PDF, DOCX).',
    `approval_document_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval document.',
    `approval_document_url` STRING COMMENT 'URL to the approval document stored in the document management system.',
    `approval_document_version` STRING COMMENT 'Version number of the approval document.',
    `approval_status` STRING COMMENT 'Status of the approval process (Pending, Approved, Rejected).',
    `committee_status` STRING COMMENT 'Current lifecycle status of the committee (Active, Inactive, Pending).',
    `committee_type` STRING COMMENT 'Category of the committee (e.g., Credentialing, Compliance, Quality).',
    `contact_address` STRING COMMENT 'Physical address of the committee contact person.',
    `contact_email` STRING COMMENT 'Primary email address for committee communication.',
    `contact_name` STRING COMMENT 'Full name of the primary contact person for the committee.',
    `contact_phone` STRING COMMENT 'Primary phone number for committee contact.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the committee record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `committee_description` STRING COMMENT 'Detailed description of the committees purpose and scope.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the committee was dissolved or ceased operations, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_approved` BOOLEAN COMMENT 'Flag indicating whether the committee has been formally approved.',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this committee is the default for certain processes.',
    `location` STRING COMMENT 'Geographic location or office where the committee is based.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `committee_name` STRING COMMENT 'Human-readable name of the committee.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `start_date` DATE COMMENT 'Date when the committee became operational.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the committee record.',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the committee record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'Identifier of the user who created the committee record.',
    CONSTRAINT pk_committee PRIMARY KEY(`committee_id`)
) COMMENT 'Master reference table for committee. Referenced by committee_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` (
    `decision_document_id` BIGINT COMMENT 'Primary key for decision_document',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who approved the decision.',
    `decision_document_author_employee_id` BIGINT COMMENT 'Identifier of the staff member who authored the decision.',
    `parent_decision_document_id` BIGINT COMMENT 'Self-referencing FK on decision_document (parent_decision_document_id)',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the decision document record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_approval_date` DATE COMMENT 'Date the decision was approved.',
    `decision_approval_time` TIMESTAMP COMMENT 'Exact timestamp when the decision was approved.',
    `decision_approver_name` STRING COMMENT 'Full name of the staff member who approved the decision.',
    `decision_approver_role` STRING COMMENT 'Role or title of the staff member who approved the decision.',
    `decision_author_name` STRING COMMENT 'Full name of the staff member who authored the decision.',
    `decision_author_role` STRING COMMENT 'Role or title of the staff member who authored the decision.',
    `decision_date` DATE COMMENT 'Date the decision was made.',
    `decision_outcome` STRING COMMENT 'Result of the decision (Approved, Denied, Conditional).',
    `decision_reason` STRING COMMENT 'Narrative explanation of why the decision was made.',
    `decision_time` TIMESTAMP COMMENT 'Exact timestamp when the decision was made.',
    `document_number` STRING COMMENT 'Externally visible number assigned to the decision document.',
    `document_status` STRING COMMENT 'Current lifecycle state of the document (Draft, Pending Review, Approved, Rejected, Archived).',
    `document_title` STRING COMMENT 'Human-readable title of the decision document.',
    `document_type` STRING COMMENT 'Category of the document (e.g., Credentialing Decision, Recredentialing Decision, Sanction Decision).',
    `effective_date` DATE COMMENT 'Date when the decision becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the decision expires or is no longer valid.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: DocumentReference)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `format` STRING COMMENT 'File format of the decision document (PDF, DOCX, HTML).',
    `hash` STRING COMMENT 'Cryptographic hash of the decision document for integrity verification.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language` STRING COMMENT 'Language in which the decision document is written.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `revision` STRING COMMENT 'Revision number of the decision document.',
    `size_bytes` BIGINT COMMENT 'Size of the decision document in bytes.',
    `source_system_code` STRING COMMENT 'Identifier of the source system record.',
    `source_system_description` STRING COMMENT 'Description of the source system record.',
    `source_system_owner` STRING COMMENT 'Name of the owner of the source system.',
    `source_system_owner_address` STRING COMMENT 'Physical address of the source system owner.',
    `source_system_owner_code` STRING COMMENT 'Identifier of the source system owner.',
    `source_system_owner_email` STRING COMMENT 'Email address of the source system owner.',
    `source_system_owner_name` STRING COMMENT 'Full name of the source system owner.',
    `source_system_owner_phone` STRING COMMENT 'Phone number of the source system owner.',
    `source_system_status` STRING COMMENT 'Current status of the source system record.',
    `source_system_timestamp` TIMESTAMP COMMENT 'Timestamp of the source system record.',
    `source_system_version` STRING COMMENT 'Version of the source system record.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the decision document record was last updated.',
    `updated_by` STRING COMMENT 'User who last updated the decision document record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `url` STRING COMMENT 'Web location where the decision document can be accessed.',
    `version` STRING COMMENT 'Version number of the decision document.',
    `created_by` STRING COMMENT 'User who created the decision document record.',
    CONSTRAINT pk_decision_document PRIMARY KEY(`decision_document_id`)
) COMMENT 'Master reference table for decision_document. Referenced by decision_document_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` (
    `committee_type_id` BIGINT COMMENT 'Primary key for committee_type',
    `parent_committee_type_id` BIGINT COMMENT 'Self-referencing FK on committee_type (parent_committee_type_id)',
    `allows_virtual_participation` BOOLEAN COMMENT 'Indicates whether members of this committee type are permitted to participate and vote remotely via teleconference or video, per organizational bylaws and applicable state regulations.',
    `authority_level` STRING COMMENT 'Indicates the decision-making authority of this committee type — whether it renders final credentialing decisions, makes recommendations to a higher body, serves in an advisory capacity, or operates under delegated authority from the governing board.',
    `committee_type_category` STRING COMMENT 'High-level functional category grouping committee types for reporting and governance purposes. Distinguishes credentialing decision-making committees from peer review, quality oversight, advisory, and appeals bodies.',
    `committee_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the committee type, used as a business-facing natural key in credentialing workflows and system integrations (e.g., CRED_COMM, PEER_REV, MED_ADV).',
    `committee_type_status` STRING COMMENT 'Current lifecycle status of this committee type reference record. Active types are available for assignment to credentialing workflows; inactive or deprecated types are retained for historical reference but cannot be assigned to new committees.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `committee_type_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and responsibilities of this committee type within the credentialing and provider oversight lifecycle.',
    `display_order` STRING COMMENT 'Numeric sort order controlling the presentation sequence of committee types in user interfaces, dropdown lists, and reports. Lower values appear first.',
    `effective_end_date` DATE COMMENT 'Date after which this committee type is no longer valid for new assignments. Null indicates the committee type is currently open-ended and in effect. Used for reference data lifecycle management.',
    `effective_start_date` DATE COMMENT 'Date from which this committee type became effective and available for use in credentialing governance structures. Supports temporal validity tracking for reference data management.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `meeting_frequency` STRING COMMENT 'Standard frequency at which this committee type convenes to review credentialing files and render decisions. NCQA requires timely processing, so meeting cadence directly impacts credentialing cycle time.',
    `minimum_quorum_count` STRING COMMENT 'The minimum number of voting members required to be present for the committee to conduct official business and render binding credentialing decisions, per organizational bylaws and NCQA standards.',
    `committee_type_name` STRING COMMENT 'Human-readable display name for the committee type (e.g., Credentials Committee, Peer Review Committee, Medical Advisory Committee, Quality Improvement Committee).',
    `ncqa_required` BOOLEAN COMMENT 'Indicates whether this committee type is explicitly required by NCQA credentialing accreditation standards. Used to distinguish mandatory committee structures from optional or organization-specific governance bodies.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_basis` STRING COMMENT 'Citation or reference to the specific regulatory requirement, accreditation standard, or organizational bylaw that mandates or authorizes this committee type (e.g., NCQA CR 1 Element A, 42 CFR 438.214, state-specific credentialing statute).',
    `requires_physician_chair` BOOLEAN COMMENT 'Indicates whether this committee type requires a licensed physician (MD/DO) to serve as chairperson, as mandated by NCQA credentialing standards and many state regulations for credentialing decision-making bodies.',
    `review_scope` STRING COMMENT 'Defines the scope of credentialing activities this committee type is authorized to review — initial credentialing, recredentialing, both, sanctions/disciplinary actions, or appeals of adverse decisions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `voting_method` STRING COMMENT 'The voting methodology used by this committee type to reach credentialing decisions — simple majority, supermajority (two-thirds), unanimous, or consensus-based.',
    CONSTRAINT pk_committee_type PRIMARY KEY(`committee_type_id`)
) COMMENT 'Master reference table for committee_type. Referenced by committee_type_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` (
    `credential_lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings often mandate credential status changes; linking events to the originating audit finding supports audit‑driven remediation reporting.',
    `credential_document_id` BIGINT COMMENT 'Identifier of any supporting document attached to the event.',
    `employee_id` BIGINT COMMENT 'Identifier of the actor (staff or system) that performed the action.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider associated with the credential.',
    `record_id` BIGINT COMMENT 'Identifier of the credential record this event pertains to.',
    `contract_lifecycle_event2_id` BIGINT COMMENT 'SSOT reference to canonical lifecycle_event in contract.contract_lifecycle_event',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the detailed audit trail for this event.',
    `audit_user_role` STRING COMMENT 'Role of the audit user (e.g., auditor, manager, admin).. Valid values are `auditor|manager|admin`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the event satisfies compliance requirements (e.g., NCQA).',
    `confidentiality_level` STRING COMMENT 'Data confidentiality classification for this event record.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_code` STRING COMMENT 'Code representing the committee decision outcome, if applicable.',
    `decision_date` DATE COMMENT 'Date when the committee decision was rendered.',
    `document_timestamp` TIMESTAMP COMMENT 'Timestamp of the attached document creation.',
    `document_type` STRING COMMENT 'Type of supporting document (e.g., PDF, image, text, XML).. Valid values are `pdf|image|text|xml`',
    `effective_date` DATE COMMENT 'Date when the new status becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the escalation occurred.',
    `event_category` STRING COMMENT 'High-level category of the event (e.g., application, verification, decision, activation, suspension, termination, recredentialing). [ENUM-REF-CANDIDATE: application|verification|decision|activation|suspension|termination|recredentialing — promote to reference product]',
    `event_notes` STRING COMMENT 'Free-text notes describing the event details.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred.',
    `event_type` STRING COMMENT 'Type of lifecycle event (e.g., application_received, psv_initiated, psv_completed, committee_scheduled, decision_rendered, credential_activated, credential_suspended, credential_terminated, recredentialing_triggered). [ENUM-REF-CANDIDATE: application_received|psv_initiated|psv_completed|committee_scheduled|decision_rendered|credential_activated|credential_suspended|credential_terminated|recredentialing_triggered — promote to reference product]',
    `expiration_date` DATE COMMENT 'Date when the credential status is set to expire, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating if the event is considered critical for audit or operational purposes.',
    `is_escalated` BOOLEAN COMMENT 'Flag indicating if the event was escalated to higher authority.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the event was entered manually (True) or generated automatically (False).',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_status` STRING COMMENT 'Credential status after this event. [ENUM-REF-CANDIDATE: pending|in_progress|approved|rejected|suspended|terminated|active — promote to reference product]',
    `prior_status` STRING COMMENT 'Credential status before this event. [ENUM-REF-CANDIDATE: pending|in_progress|approved|rejected|suspended|terminated|active — promote to reference product]',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source` STRING COMMENT 'Origin of the record (e.g., system feed, manual entry, import).. Valid values are `system_feed|manual_entry|import`',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the regulatory rule or guideline applicable to the event.',
    `resolution_status` STRING COMMENT 'Final resolution status of the event.. Valid values are `resolved|closed|pending|reopened`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the event was resolved or closed.',
    `risk_score` STRING COMMENT 'Risk score assigned to the event based on compliance and sanction considerations.',
    `risk_score_reason` STRING COMMENT 'Explanation for the assigned risk score.',
    `triggering_actor` STRING COMMENT 'Entity that triggered the event (e.g., system, staff, committee, external).. Valid values are `system|staff|committee|external`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    CONSTRAINT pk_credential_lifecycle_event PRIMARY KEY(`credential_lifecycle_event_id`)
) COMMENT 'Transactional event log capturing all significant status changes and lifecycle events in the credentialing workflow for a provider application or credential record. Captures event type (application received, PSV initiated, PSV completed, committee scheduled, decision rendered, credential activated, credential suspended, credential terminated, re-credentialing triggered), event timestamp, prior status, new status, triggering actor (system, staff, committee), and event notes. Provides the full audit trail of the credentialing lifecycle required for NCQA and regulatory audit readiness.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` (
    `credential_document_id` BIGINT COMMENT 'Primary key for credential_document',
    `appeal_document2_id` BIGINT COMMENT 'SSOT link to appeal.document owner',
    `parent_credential_document_id` BIGINT COMMENT 'Self-referencing FK on credential_document (parent_credential_document_id)',
    `provider_id` BIGINT COMMENT 'Unique identifier for the provider associated with this credential document.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the credential document record was created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credential_credentialing_event_date` DATE COMMENT 'Date of the credentialing event (initial, renewal, etc.).',
    `credential_credentialing_event_notes` STRING COMMENT 'Notes related to the credentialing event.',
    `credential_credentialing_event_status` STRING COMMENT 'Current status of the credentialing event.',
    `credential_credentialing_event_type` STRING COMMENT 'Type of credentialing event.',
    `credential_document_status` STRING COMMENT 'Current status of the credential document record.',
    `credential_document_type` STRING COMMENT 'Classification of the document (e.g., License, Certification).',
    `credential_expiration_date` DATE COMMENT 'Date when the credential will expire.',
    `credential_issue_date` DATE COMMENT 'Date when the credential was originally issued.',
    `credential_issuing_authority` STRING COMMENT 'Name of the organization that issued the credential.',
    `credential_issuing_authority_address` STRING COMMENT 'Street address of the issuing authority.',
    `credential_issuing_authority_city` STRING COMMENT 'City where the issuing authority is located.',
    `credential_issuing_authority_code` STRING COMMENT 'Standard code for the issuing authority (e.g., state license board code).',
    `credential_issuing_authority_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the issuing authority.',
    `credential_issuing_authority_email` STRING COMMENT 'Primary email address of the issuing authority.',
    `credential_issuing_authority_phone` STRING COMMENT 'Primary phone number of the issuing authority.',
    `credential_issuing_authority_state` STRING COMMENT 'ISO 3166-2 state/province code of the issuing authority.',
    `credential_issuing_authority_zip` STRING COMMENT 'Postal ZIP code of the issuing authority.',
    `credential_number` STRING COMMENT 'Unique professional license or certification number issued to the provider.',
    `credential_status` STRING COMMENT 'Current status of the providers credential.',
    `credential_status_reason` STRING COMMENT 'Explanation for the current credential status.',
    `credential_type` STRING COMMENT 'Professional designation or qualification type (e.g., MD, RN, PhD).',
    `credential_verification_date` DATE COMMENT 'Date when the credential verification was completed.',
    `credential_verification_method` STRING COMMENT 'Method used to verify the credential (e.g., PSV, NCQA, State License Check).',
    `credential_verification_notes` STRING COMMENT 'Additional notes or comments from the verification process.',
    `credential_verification_status` STRING COMMENT 'Result of the credential verification process.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `credential_document_description` STRING COMMENT 'Detailed description of the credential document contents.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `format` STRING COMMENT 'File format of the credential document.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language` STRING COMMENT 'Human-readable language of the document.',
    `language_code` STRING COMMENT 'ISO 639-1 code for the document language.',
    `language_description` STRING COMMENT 'Full description of the document language.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `page_count` STRING COMMENT 'Number of pages in the document.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `size_bytes` BIGINT COMMENT 'Size of the document in bytes.',
    `status_reason` STRING COMMENT 'Reason for the current document status.',
    `title` STRING COMMENT 'Title or name of the credential document.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the credential document record was last updated.',
    `updated_by` BIGINT COMMENT 'Identifier of the user who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `url` STRING COMMENT 'URL or path to the stored credential document.',
    `version` STRING COMMENT 'Version number of the credential document record.',
    `created_by` BIGINT COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_credential_document PRIMARY KEY(`credential_document_id`)
) COMMENT 'Master reference table for credential_document. Referenced by related_document_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` (
    `credential_outreach_id` BIGINT COMMENT 'Primary key for outreach',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or system process that originated the outreach.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider to whom the outreach was sent.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Outreach communications relate to a credential record; provider_id duplicated.',
    `attachment_flag` BOOLEAN COMMENT 'True if the outreach included attached files or forms; otherwise false.',
    `contact_detail` STRING COMMENT 'Specific address, email, or phone number used to deliver the outreach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outreach record was first created in the lakehouse.',
    `credential_outreach_status` STRING COMMENT 'Current processing state of the outreach (e.g., pending, sent, acknowledged, completed, closed, cancelled).. Valid values are `pending|sent|acknowledged|completed|closed|cancelled`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_type_requested` STRING COMMENT 'Category of documentation the provider was asked to supply.. Valid values are `license|board_cert|malpractice|privilege|other`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `items_requested` STRING COMMENT 'Free‑text list of documents, data elements, or actions requested from the provider.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional comments, observations, or instructions related to the outreach.',
    `outcome` STRING COMMENT 'Result of the outreach after the response window closed.. Valid values are `responded|no_response|partial_response|declined|completed`',
    `outreach_method` STRING COMMENT 'Channel used to deliver the outreach (mail, email, phone call, provider portal, or fax).. Valid values are `mail|email|phone|portal|fax`',
    `outreach_timestamp` TIMESTAMP COMMENT 'Exact date‑time the outreach communication was transmitted to the provider.',
    `outreach_type` STRING COMMENT 'Classification of the outreach purpose, such as initial request, follow‑up, final notice, expiration warning, or reminder.. Valid values are `initial_request|follow_up|final_notice|expiration_warning|reminder`',
    `priority` STRING COMMENT 'Business‑defined priority level for the outreach, used for routing and escalation.. Valid values are `high|medium|low`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reference` STRING COMMENT 'Human‑readable reference code assigned to the outreach event for tracking and reporting.',
    `response_due_date` DATE COMMENT 'Calendar date by which the provider is expected to respond to the outreach.',
    `response_method` STRING COMMENT 'Channel the provider used to submit their response.. Valid values are `email|phone|portal|mail|fax`',
    `response_notes` STRING COMMENT 'Additional information supplied by the provider in their response.',
    `response_received_date` DATE COMMENT 'Date the providers response was recorded in the system.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the provider responded within the SLA target (true) or not (false).',
    `sla_target_days` STRING COMMENT 'Number of calendar days defined as the service‑level agreement for provider response.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the outreach record.',
    CONSTRAINT pk_credential_outreach PRIMARY KEY(`credential_outreach_id`)
) COMMENT 'Transactional record of each outreach communication sent to a provider during the credentialing or re-credentialing process to request missing information, incomplete documents, or application updates. Captures outreach date, outreach method (mail, email, phone, portal), outreach type (initial request, follow-up, final notice, expiration warning), items requested, response due date, response received date, and outreach outcome. Tracks the full communication trail required for NCQA file completeness standards and supports SLA monitoring for credentialing turnaround time.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` (
    `credential_attestation2_id` BIGINT COMMENT 'Primary key for attestation',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who reviewed and acted on the attestation.',
    `compliance_attestation_id` BIGINT COMMENT 'SSOT reference to canonical attestation master compliance.compliance_attestation',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider who submitted the attestation.',
    `record_id` BIGINT COMMENT 'Identifier of the credentialing record to which this attestation is attached.',
    `application_accuracy` BOOLEAN COMMENT 'Provider attests that all information provided in the credentialing application is true and accurate.',
    `attestation_number` STRING COMMENT 'Human‑readable reference number assigned to the attestation submission.',
    `attestation_status` STRING COMMENT 'Current processing state of the attestation within the credentialing workflow.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the provider signed and submitted the attestation.',
    `attestation_type` STRING COMMENT 'Indicates whether the attestation is for an initial application, a re‑credentialing cycle, or an annual renewal.. Valid values are `initial|recredentialing|annual`',
    `competence_current` BOOLEAN COMMENT 'Provider confirms they are currently competent to perform the services covered by the credential.',
    `compliance_requirement` STRING COMMENT 'Regulatory or accreditation rule that mandates the attestation (e.g., NCQA, CMS).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the attestation record was first created in the lakehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disclosure_text` STRING COMMENT 'Any additional disclosures or comments supplied by the provider with the attestation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date after which the attestation is no longer valid and must be renewed.',
    `felony_conviction` BOOLEAN COMMENT 'Provider attests they have no felony convictions that would affect credential eligibility.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `impairment_absence` BOOLEAN COMMENT 'Provider attests they have no physical or mental impairment that would affect care delivery.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `malpractice_history_accuracy` BOOLEAN COMMENT 'Provider confirms that all disclosed malpractice history is complete and accurate.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes captured by staff during processing of the attestation.',
    `privileges_loss` BOOLEAN COMMENT 'Provider confirms they have not lost any hospital or health‑system privileges.',
    `provider_signature_indicator` BOOLEAN COMMENT 'True when the provider has electronically signed the attestation; false otherwise.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source` STRING COMMENT 'Name of the source system that generated the attestation record (e.g., ProviderSource).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation, guideline, or standard governing the attestation.',
    `review_outcome` STRING COMMENT 'Result of the attestation review: approved, rejected, or requires additional information.. Valid values are `approved|rejected|needs_more_info`',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the attestation review decision was recorded.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the attestation record.',
    CONSTRAINT pk_credential_attestation2 PRIMARY KEY(`credential_attestation2_id`)
) COMMENT 'Transactional record of a providers signed attestation submitted as part of the credentialing or re-credentialing application. Captures attestation date, attestation type (initial application, re-credentialing, annual attestation), attestation questions answered (current competence, absence of impairment, no loss of privileges, no felony convictions, malpractice history accuracy, application accuracy), provider signature indicator, and any disclosures made. NCQA requires provider attestation within 180 days of credentialing decision. Each attestation submission is a distinct record. [SSOT Master for attestation concept across domains]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` (
    `credential_appeal_id` BIGINT COMMENT 'Unique identifier for the credentialing appeal record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory compliance reporting requires each credential appeal to reference the specific regulatory obligation that triggered the appeal, enabling obligation‑specific tracking.',
    `decision_document_id` BIGINT COMMENT 'Reference to the formal decision document stored in the document management system.',
    `provider_id` BIGINT COMMENT 'National Provider Identifier of the provider submitting the appeal.',
    `record_id` BIGINT COMMENT 'Identifier of the credential record that is the subject of the appeal.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the employee who adjudicates each credentialing appeal; required for appeal outcome reporting and OIG compliance.',
    `appeal_number` STRING COMMENT 'External reference number assigned to the appeal for tracking.',
    `appeal_status` STRING COMMENT 'Current processing status of the appeal.. Valid values are `submitted|under_review|hearing_scheduled|decision_made|closed`',
    `appeal_type` STRING COMMENT 'Category of the appeal based on procedural pathway.. Valid values are `informal|formal|external`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for any monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_date` DATE COMMENT 'Date the appeal decision was rendered.',
    `decision_outcome` STRING COMMENT 'Result of the appeal after hearing.. Valid values are `upheld|overturned|modified|dismissed`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_date` DATE COMMENT 'Date the appeal was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the appeal was escalated to a higher authority.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the provider for processing the appeal, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `ground` STRING COMMENT 'Reason(s) provided by the provider for contesting the credentialing decision.',
    `hearing_date` DATE COMMENT 'Scheduled date for the appeal hearing, if applicable.',
    `hearing_panel_members` STRING COMMENT 'List of individuals (names or IDs) comprising the hearing panel.',
    `hearing_panel_type` STRING COMMENT 'Indicates whether the hearing panel is internal to the organization or external.. Valid values are `internal|external`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Internal notes regarding the appeal processing.',
    `notification_sent_date` DATE COMMENT 'Date the decision notification was sent to the provider.',
    `original_decision_date` DATE COMMENT 'Date of the original credentialing decision that is being appealed.',
    `original_decision_type` STRING COMMENT 'Type of the original adverse credentialing decision.. Valid values are `denial|revocation|suspension`',
    `outcome_reason` STRING COMMENT 'Explanation for the decision outcome.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the appeal record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appeal record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or statute governing the appeal (e.g., HCQIA, state DOI).',
    `resolution_action` STRING COMMENT 'Action taken as a result of the appeal (e.g., credential reinstated, conditions added).',
    `review_deadline` DATE COMMENT 'Date by which the appeal must be reviewed per regulatory timelines.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the provider submitted the appeal.',
    `supporting_documentation` STRING COMMENT 'Reference to files or descriptions of documents submitted with the appeal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_credential_appeal PRIMARY KEY(`credential_appeal_id`)
) COMMENT 'Transactional record for a providers formal appeal of an adverse credentialing decision (denial, revocation, suspension). Captures appeal submission date, appeal type (informal reconsideration, formal hearing, external review), grounds for appeal, supporting documentation submitted, hearing date, hearing panel composition, appeal decision (upheld, overturned, modified), appeal decision date, and notification sent date. Distinct from the member/claim appeal domain — this is provider-side credentialing due process. Required by HCQIA fair hearing rights and state DOI regulations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` (
    `credential_attestation_id` BIGINT COMMENT 'Primary key for credential_attestation',
    `compliance_attestation_id` BIGINT COMMENT 'FK to compliance.compliance_attestation - links provider-specific attestation to SSOT owner',
    CONSTRAINT pk_credential_attestation PRIMARY KEY(`credential_attestation_id`)
) COMMENT 'Provider-specific attestation subtype';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ADD CONSTRAINT `fk_credential_psv_verification_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ADD CONSTRAINT `fk_credential_sanction_screening_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ADD CONSTRAINT `fk_credential_npdb_query_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ADD CONSTRAINT `fk_credential_committee_review_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee`(`committee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ADD CONSTRAINT `fk_credential_committee_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ADD CONSTRAINT `fk_credential_recredential_cycle_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ADD CONSTRAINT `fk_credential_delegation_audit_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ADD CONSTRAINT `fk_credential_cvo_relationship_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ADD CONSTRAINT `fk_credential_expedited_credential_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` ADD CONSTRAINT `fk_credential_contract_link_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` ADD CONSTRAINT `fk_credential_obligation_mapping_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` ADD CONSTRAINT `fk_credential_obligation_mapping_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` ADD CONSTRAINT `fk_credential_obligation_mapping_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` ADD CONSTRAINT `fk_credential_finding_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_committee_type_id` FOREIGN KEY (`committee_type_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee_type`(`committee_type_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_parent_committee_id` FOREIGN KEY (`parent_committee_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee`(`committee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ADD CONSTRAINT `fk_credential_decision_document_parent_decision_document_id` FOREIGN KEY (`parent_decision_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`decision_document`(`decision_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ADD CONSTRAINT `fk_credential_committee_type_parent_committee_type_id` FOREIGN KEY (`parent_committee_type_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee_type`(`committee_type_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ADD CONSTRAINT `fk_credential_credential_document_parent_credential_document_id` FOREIGN KEY (`parent_credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ADD CONSTRAINT `fk_credential_credential_outreach_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ADD CONSTRAINT `fk_credential_credential_attestation2_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_decision_document_id` FOREIGN KEY (`decision_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`decision_document`(`decision_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`credential` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`credential` SET TAGS ('pii_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_id` SET TAGS ('pii_business_glossary_term' = 'Application Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Specialist ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_status` SET TAGS ('pii_value_regex' = 'received|in_review|psv_in_progress|committee_ready|decided|closed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_type` SET TAGS ('pii_business_glossary_term' = 'Application Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_type` SET TAGS ('pii_value_regex' = 'initial|recredential|reinstatement|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `committee_decision` SET TAGS ('pii_business_glossary_term' = 'Committee Decision');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `committee_decision` SET TAGS ('pii_value_regex' = 'approved|denied|pending|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `credentialing_cycle_year` SET TAGS ('pii_business_glossary_term' = 'Credentialing Cycle Year');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('pii_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Application Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `disposition` SET TAGS ('pii_value_regex' = 'approved|denied|withdrawn|expired|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `hospital_privileges_verified` SET TAGS ('pii_business_glossary_term' = 'Hospital Privileges Verified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `is_delegated` SET TAGS ('pii_business_glossary_term' = 'Delegated Application Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `is_urgent` SET TAGS ('pii_business_glossary_term' = 'Urgent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `last_psv_update_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last PSV Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `malpractice_history_flag` SET TAGS ('pii_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `malpractice_history_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `malpractice_history_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `ncqa_cycle` SET TAGS ('pii_business_glossary_term' = 'NCQA Credentialing Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `npdb_query_date` SET TAGS ('pii_business_glossary_term' = 'NPDB Query Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `primary_psv_status` SET TAGS ('pii_business_glossary_term' = 'Primary PSV Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `primary_psv_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `requires_additional_documents` SET TAGS ('pii_business_glossary_term' = 'Additional Documents Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `sanction_screening_status` SET TAGS ('pii_business_glossary_term' = 'Sanction Screening Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `sanction_screening_status` SET TAGS ('pii_value_regex' = 'clear|flagged|pending|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('pii_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `submission_channel` SET TAGS ('pii_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `submission_channel` SET TAGS ('pii_value_regex' = 'paper|portal|cvo|delegated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_entity_code` SET TAGS ('pii_business_glossary_term' = 'Credentialing Entity Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_expiration_reason` SET TAGS ('pii_business_glossary_term' = 'Credential Expiration Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_expiration_reason` SET TAGS ('pii_value_regex' = 'end_of_term|revoked|suspended|voluntary|other');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_revocation_date` SET TAGS ('pii_business_glossary_term' = 'Credential Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_source_system` SET TAGS ('pii_business_glossary_term' = 'Credential Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_status` SET TAGS ('pii_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_status` SET TAGS ('pii_value_regex' = 'active|expired|suspended|revoked|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_suspension_end` SET TAGS ('pii_business_glossary_term' = 'Credential Suspension End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_suspension_start` SET TAGS ('pii_business_glossary_term' = 'Credential Suspension Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_tier` SET TAGS ('pii_business_glossary_term' = 'Credential Tier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_type` SET TAGS ('pii_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_type` SET TAGS ('pii_value_regex' = 'primary|secondary|delegated|direct');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_version` SET TAGS ('pii_business_glossary_term' = 'Credential Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_committee_decision_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Committee Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_committee_outcome` SET TAGS ('pii_business_glossary_term' = 'Credentialing Committee Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_committee_outcome` SET TAGS ('pii_value_regex' = 'approved|denied|conditional');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_review_notes` SET TAGS ('pii_business_glossary_term' = 'Credentialing Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('pii_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `delegated_credential_flag` SET TAGS ('pii_business_glossary_term' = 'Delegated Credential Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `hospital_privileges_flag` SET TAGS ('pii_business_glossary_term' = 'Hospital Privileges Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `malpractice_claims_count` SET TAGS ('pii_business_glossary_term' = 'Malpractice Claims Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `malpractice_history_flag` SET TAGS ('pii_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `ncqa_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'NCQA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `next_recredentialing_due` SET TAGS ('pii_business_glossary_term' = 'Next Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `recredentialing_date` SET TAGS ('pii_business_glossary_term' = 'Last Recredentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `sanctions_screened_flag` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screened Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('pii_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `psv_verification_id` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification (PSV) Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verifier Identifier (User or System ID)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `board_certification` SET TAGS ('pii_business_glossary_term' = 'Board Certification Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `credential_element_identifier` SET TAGS ('pii_business_glossary_term' = 'Credential Element Identifier (License Number, DEA Number, Certification Number, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `credential_element_type` SET TAGS ('pii_business_glossary_term' = 'Credential Element Type (e.g., State License, DEA Registration, Board Certification, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `dea_schedule` SET TAGS ('pii_business_glossary_term' = 'DEA Controlled Substance Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date of Credential Element');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `element_category` SET TAGS ('pii_business_glossary_term' = 'Credential Element Category (License, Registration, Certification, Insurance, Privilege, Education, Work History)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `element_status` SET TAGS ('pii_business_glossary_term' = 'Credential Element Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `element_status` SET TAGS ('pii_value_regex' = 'active|inactive|expired|revoked|pending|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date of Credential Element');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `hospital_privilege_scope` SET TAGS ('pii_business_glossary_term' = 'Hospital Privilege Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority (State Board, DEA, ABMS, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `malpractice_insurance_limit` SET TAGS ('pii_business_glossary_term' = 'Malpractice Insurance Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `malpractice_insurance_type` SET TAGS ('pii_business_glossary_term' = 'Malpractice Insurance Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `malpractice_insurance_type` SET TAGS ('pii_value_regex' = 'occurrence|claims_made');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `training_program` SET TAGS ('pii_business_glossary_term' = 'Graduate Medical Education Training Program');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'electronic|mail|phone|in_person|fax');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_result` SET TAGS ('pii_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_result` SET TAGS ('pii_value_regex' = 'verified|unable_to_verify|discrepancy|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `work_history_details` SET TAGS ('pii_business_glossary_term' = 'Work History Details');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `work_history_years` SET TAGS ('pii_business_glossary_term' = 'Work History Years (Past 5 Years)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_subdomain' = 'screening_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanction Screening Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Review User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `compliance_requirement` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `databases_queried` SET TAGS ('pii_business_glossary_term' = 'Databases Queried');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `impact_on_credential_status` SET TAGS ('pii_business_glossary_term' = 'Impact on Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `impact_on_credential_status` SET TAGS ('pii_value_regex' = 'hold|suspend|revoke|none');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `overall_status` SET TAGS ('pii_business_glossary_term' = 'Overall Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `overall_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_source` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'hold|cleared|escalated|closed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `result_detail` SET TAGS ('pii_business_glossary_term' = 'Result Detail');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_effective_date` SET TAGS ('pii_business_glossary_term' = 'Sanction Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_end_date` SET TAGS ('pii_business_glossary_term' = 'Sanction End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_type` SET TAGS ('pii_business_glossary_term' = 'Sanction Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_type` SET TAGS ('pii_value_regex' = 'exclusion|sanction|disciplinary|license_revocation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanctioning_authority` SET TAGS ('pii_business_glossary_term' = 'Sanctioning Authority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_event_type` SET TAGS ('pii_business_glossary_term' = 'Screening Event Type (Initial, Routine, Triggered)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_event_type` SET TAGS ('pii_value_regex' = 'initial|routine|triggered');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_initiated_by` SET TAGS ('pii_business_glossary_term' = 'Screening Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_notes` SET TAGS ('pii_business_glossary_term' = 'Screening Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_value_regex' = 'clear|match_found|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('pii_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_subdomain' = 'screening_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_query_id` SET TAGS ('pii_business_glossary_term' = 'NPDB Query ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `hcqia_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'HCQIA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `internal_review_disposition` SET TAGS ('pii_business_glossary_term' = 'Internal Review Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `internal_review_disposition` SET TAGS ('pii_value_regex' = 'reviewed|flagged|no_action');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `is_continuous_enrollment` SET TAGS ('pii_business_glossary_term' = 'Continuous Enrollment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `last_report_date` SET TAGS ('pii_business_glossary_term' = 'Last Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_assigned_query_number` SET TAGS ('pii_business_glossary_term' = 'NPDB Assigned Query Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_assigned_query_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_query_status` SET TAGS ('pii_business_glossary_term' = 'NPDB Query Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_query_status` SET TAGS ('pii_value_regex' = 'pending|completed|error|partial');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `number_of_reports` SET TAGS ('pii_business_glossary_term' = 'Number of Reports Returned');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `query_type` SET TAGS ('pii_business_glossary_term' = 'NPDB Query Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `query_type` SET TAGS ('pii_value_regex' = 'initial|recredentialing|continuous');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `query_version` SET TAGS ('pii_business_glossary_term' = 'NPDB Query Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `report_processing_time_seconds` SET TAGS ('pii_business_glossary_term' = 'Report Processing Time (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'NPDB Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Query Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `total_malpractice_amount` SET TAGS ('pii_business_glossary_term' = 'Total Malpractice Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_subdomain' = 'committee_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_review_id` SET TAGS ('pii_business_glossary_term' = 'Committee Review Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `agenda_items` SET TAGS ('pii_business_glossary_term' = 'Agenda Items');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `appeal_rights_notification_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('pii_business_glossary_term' = 'Committee Chair Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('pii_business_glossary_term' = 'Committee Chair NPI');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_review_status` SET TAGS ('pii_business_glossary_term' = 'Committee Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_review_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_dea_valid` SET TAGS ('pii_business_glossary_term' = 'DEA Validity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_malpractice_history` SET TAGS ('pii_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_oig_sanction` SET TAGS ('pii_business_glossary_term' = 'OIG Sanction Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_state_license_valid` SET TAGS ('pii_business_glossary_term' = 'State License Validity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_conditions` SET TAGS ('pii_business_glossary_term' = 'Decision Conditions');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_effective_date` SET TAGS ('pii_business_glossary_term' = 'Decision Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Decision Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_type` SET TAGS ('pii_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_type` SET TAGS ('pii_value_regex' = 'approved|approved_with_conditions|deferred|denied|revoked|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `meeting_timestamp` SET TAGS ('pii_business_glossary_term' = 'Committee Meeting Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `quorum_indicator` SET TAGS ('pii_business_glossary_term' = 'Quorum Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Committee Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Committee Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'credentialing|quality|peer_review');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `total_providers_reviewed` SET TAGS ('pii_business_glossary_term' = 'Total Providers Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `voting_record` SET TAGS ('pii_business_glossary_term' = 'Voting Record');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `recredential_cycle_id` SET TAGS ('pii_business_glossary_term' = 'Recredential Cycle Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Officer ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `application_received_date` SET TAGS ('pii_business_glossary_term' = 'Application Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_completion_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_due_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_priority` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Priority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_priority` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_status` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|overdue|waived');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_type` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_type` SET TAGS ('pii_value_regex' = 'full|partial|renewal');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `last_outreach_date` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Cycle Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `outreach_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_subdomain' = 'delegation_management');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_result` SET TAGS ('pii_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_result` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|conditional');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_schedule` SET TAGS ('pii_business_glossary_term' = 'Audit Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_schedule` SET TAGS ('pii_value_regex' = 'annual|semiannual|quarterly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegated_entity_status` SET TAGS ('pii_business_glossary_term' = 'Delegation Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegated_entity_status` SET TAGS ('pii_value_regex' = 'active|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_agreement_number` SET TAGS ('pii_business_glossary_term' = 'Delegation Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_agreement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_scope` SET TAGS ('pii_business_glossary_term' = 'Delegation Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_scope` SET TAGS ('pii_value_regex' = 'full_credentialing|recredentialing|primary_source_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_type` SET TAGS ('pii_business_glossary_term' = 'Delegation Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_type` SET TAGS ('pii_value_regex' = 'full|recredentialing|psv');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'NCQA Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('pii_value_regex' = 'accredited|not_accredited|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `organization_name` SET TAGS ('pii_business_glossary_term' = 'Delegate Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `oversight_audit_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Oversight Audit Frequency (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_source` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_value_regex' = '^[A-Z]{2,5}-d{3,6}$');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_subdomain' = 'delegation_management');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegation_audit_id` SET TAGS ('pii_business_glossary_term' = 'Delegation Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date (AUD_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_disposition` SET TAGS ('pii_business_glossary_term' = 'Audit Disposition (AUD_DISP)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_disposition` SET TAGS ('pii_value_regex' = 'passed|passed_with_conditions|failed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes (AUD_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number (AUD_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_period_end` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date (AUD_PERIOD_END)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_period_start` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date (AUD_PERIOD_START)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope (AUD_SCOPE)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status (AUD_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type (AUD_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'initial|annual|for_cause');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_year` SET TAGS ('pii_business_glossary_term' = 'Audit Year (AUD_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Full Name (AUD_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `compliance_findings` SET TAGS ('pii_business_glossary_term' = 'Compliance Findings (COMPL_FIND)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date (CA_DUE)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag (CA_REQUIRED)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (REC_CREATED)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegation_entity_name` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Name (DELEG_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `files_reviewed_count` SET TAGS ('pii_business_glossary_term' = 'Number of Files Reviewed (FILES_REVIEWED)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `overall_compliance_rate` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Rate (COMPL_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_subdomain' = 'delegation_management');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `cvo_relationship_id` SET TAGS ('pii_business_glossary_term' = 'CVO Relationship ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'CVO ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `compliance_flag` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('pii_business_glossary_term' = 'Contact Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'psv_only|full_file_preparation|ongoing_monitoring');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `cvo_relationship_status` SET TAGS ('pii_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `cvo_relationship_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Contract Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fee_currency` SET TAGS ('pii_business_glossary_term' = 'Contract Fee Currency');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `is_exclusive` SET TAGS ('pii_business_glossary_term' = 'Exclusive Relationship Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `ncqa_certification_expiration` SET TAGS ('pii_business_glossary_term' = 'NCQA Certification Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `ncqa_certified` SET TAGS ('pii_business_glossary_term' = 'NCQA Certified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = 'net_30|net_45|net_60|upon_receipt');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `relationship_type` SET TAGS ('pii_value_regex' = 'primary|secondary|backup');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `turnaround_time_sla_days` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time SLA (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_credential_id` SET TAGS ('pii_business_glossary_term' = 'Expedited Credential Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `approval_committee` SET TAGS ('pii_business_glossary_term' = 'Approval Committee');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `attestation_received` SET TAGS ('pii_business_glossary_term' = 'Attestation Received Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `attestation_received_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `clinical_urgency_justification` SET TAGS ('pii_business_glossary_term' = 'Clinical Urgency Justification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `committee_decision_date` SET TAGS ('pii_business_glossary_term' = 'Committee Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `conditions_of_participation` SET TAGS ('pii_business_glossary_term' = 'Conditions of Provisional Participation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('pii_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_credential_status` SET TAGS ('pii_business_glossary_term' = 'Expedited Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_credential_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|expired|converted');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_reason_code` SET TAGS ('pii_business_glossary_term' = 'Expedited Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_reason_code` SET TAGS ('pii_value_regex' = 'emergency|disaster|specialist_needed|other');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `final_credentialing_outcome` SET TAGS ('pii_business_glossary_term' = 'Final Credentialing Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `final_credentialing_outcome` SET TAGS ('pii_value_regex' = 'approved|denied|pending|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `hospital_privileges_verified` SET TAGS ('pii_business_glossary_term' = 'Hospital Privileges Verified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `malpractice_claims_count` SET TAGS ('pii_business_glossary_term' = 'Malpractice Claims Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `malpractice_history_flag` SET TAGS ('pii_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `outcome_date` SET TAGS ('pii_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_duration_days` SET TAGS ('pii_business_glossary_term' = 'Provisional Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_end_date` SET TAGS ('pii_business_glossary_term' = 'Provisional End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Provisional Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_fee_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_start_date` SET TAGS ('pii_business_glossary_term' = 'Provisional Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `psv_verification_date` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `psv_verification_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `requesting_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Requesting Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `requesting_entity_type` SET TAGS ('pii_business_glossary_term' = 'Requesting Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `requesting_entity_type` SET TAGS ('pii_value_regex' = 'hospital|medical_group|health_plan|other');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `sanction_screening_flag` SET TAGS ('pii_business_glossary_term' = 'Sanction Screening Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `sanction_screening_result` SET TAGS ('pii_business_glossary_term' = 'Sanction Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `sanction_screening_result` SET TAGS ('pii_value_regex' = 'clear|flagged|pending');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('pii_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `urgency_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_subdomain' = 'obligation_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_association_edges' = 'credential.credential_record,vendor.vendor_contract');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_subdomain' = 'obligation_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_association_edges' = 'credential.credential_record,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_subdomain' = 'obligation_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_association_edges' = 'credential.credential_record,compliance.audit_finding');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_subdomain' = 'committee_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_type_id` SET TAGS ('pii_business_glossary_term' = 'Committee Type Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `credential_document_id` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `parent_committee_id` SET TAGS ('pii_business_glossary_term' = 'Parent Committee Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `parent_committee_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_by` SET TAGS ('pii_business_glossary_term' = 'Committee Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_by` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_comments` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_checksum` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_created_at` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_format` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_size` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Size');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_type` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_updated_at` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_url` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Url');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_version` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_status` SET TAGS ('pii_business_glossary_term' = 'Committee Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_type` SET TAGS ('pii_business_glossary_term' = 'Committee Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('pii_business_glossary_term' = 'Committee Contact Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Committee Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Committee Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Committee Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Committee Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_description` SET TAGS ('pii_business_glossary_term' = 'Committee Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Committee End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_approved` SET TAGS ('pii_business_glossary_term' = 'Committee Is Approved');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Committee Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Committee Location');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_business_glossary_term' = 'Committee Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Committee Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Committee Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Committee Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_by` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Committee Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_by` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_subdomain' = 'committee_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_document_id` SET TAGS ('pii_business_glossary_term' = 'Decision Document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Decision Approver Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_document_author_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_document_author_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_document_author_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `parent_decision_document_id` SET TAGS ('pii_business_glossary_term' = 'Parent Decision Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `parent_decision_document_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Decision Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approval_date` SET TAGS ('pii_business_glossary_term' = 'Decision Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approval_time` SET TAGS ('pii_business_glossary_term' = 'Decision Approval Time');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('pii_business_glossary_term' = 'Decision Approver Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_role` SET TAGS ('pii_business_glossary_term' = 'Decision Approver Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('pii_business_glossary_term' = 'Decision Author Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_role` SET TAGS ('pii_business_glossary_term' = 'Decision Author Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_outcome` SET TAGS ('pii_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_reason` SET TAGS ('pii_business_glossary_term' = 'Decision Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_time` SET TAGS ('pii_business_glossary_term' = 'Decision Time');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_status` SET TAGS ('pii_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Decision Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `hash` SET TAGS ('pii_business_glossary_term' = 'Decision Document Hash');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Decision Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `revision` SET TAGS ('pii_business_glossary_term' = 'Decision Document Revision');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `size_bytes` SET TAGS ('pii_business_glossary_term' = 'Decision Document Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_description` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_code` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Owner Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_status` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_version` SET TAGS ('pii_business_glossary_term' = 'Decision Document Source System Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Decision Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Decision Document Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'Decision Document Url');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Decision Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Decision Document Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_subdomain' = 'committee_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_id` SET TAGS ('pii_business_glossary_term' = 'Committee Type Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `parent_committee_type_id` SET TAGS ('pii_business_glossary_term' = 'Parent Committee Type Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `parent_committee_type_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `allows_virtual_participation` SET TAGS ('pii_business_glossary_term' = 'Allows Virtual Participation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `authority_level` SET TAGS ('pii_business_glossary_term' = 'Authority Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_category` SET TAGS ('pii_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `display_order` SET TAGS ('pii_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `minimum_quorum_count` SET TAGS ('pii_business_glossary_term' = 'Minimum Quorum Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `ncqa_required` SET TAGS ('pii_business_glossary_term' = 'Ncqa Required');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `requires_physician_chair` SET TAGS ('pii_business_glossary_term' = 'Requires Physician Chair');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `review_scope` SET TAGS ('pii_business_glossary_term' = 'Review Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `voting_method` SET TAGS ('pii_business_glossary_term' = 'Voting Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_subdomain' = 'obligation_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_source_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_canonical' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_master' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_ref' = 'member.member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('pii_ssot_concept' = 'member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `credential_lifecycle_event_id` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `credential_document_id` SET TAGS ('pii_business_glossary_term' = 'Related Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Actor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `contract_lifecycle_event2_id` SET TAGS ('pii_business_glossary_term' = 'Ssot Lifecycle Event Ref Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `contract_lifecycle_event2_id` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_user_role` SET TAGS ('pii_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_user_role` SET TAGS ('pii_value_regex' = 'auditor|manager|admin');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `decision_code` SET TAGS ('pii_business_glossary_term' = 'Decision Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `decision_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `document_timestamp` SET TAGS ('pii_business_glossary_term' = 'Document Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `document_type` SET TAGS ('pii_value_regex' = 'pdf|image|text|xml');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('pii_business_glossary_term' = 'Event Category');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('pii_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_escalated` SET TAGS ('pii_business_glossary_term' = 'Is Escalated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_manual` SET TAGS ('pii_business_glossary_term' = 'Is Manual');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('pii_business_glossary_term' = 'Prior Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_source` SET TAGS ('pii_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_source` SET TAGS ('pii_value_regex' = 'system_feed|manual_entry|import');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'resolved|closed|pending|reopened');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `risk_score_reason` SET TAGS ('pii_business_glossary_term' = 'Risk Score Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `triggering_actor` SET TAGS ('pii_business_glossary_term' = 'Triggering Actor');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `triggering_actor` SET TAGS ('pii_value_regex' = 'system|staff|committee|external');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_subdomain' = 'attestation_records');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot_source_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot_master' = 'document');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot_canonical' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('pii_ssot_concept' = 'credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_id` SET TAGS ('pii_business_glossary_term' = 'Credential Document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `parent_credential_document_id` SET TAGS ('pii_business_glossary_term' = 'Parent Credential Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `parent_credential_document_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Credential Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_date` SET TAGS ('pii_business_glossary_term' = 'Credential Credentialing Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_notes` SET TAGS ('pii_business_glossary_term' = 'Credential Credentialing Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_status` SET TAGS ('pii_business_glossary_term' = 'Credential Credentialing Event Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_type` SET TAGS ('pii_business_glossary_term' = 'Credential Credentialing Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_status` SET TAGS ('pii_business_glossary_term' = 'Credential Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_type` SET TAGS ('pii_business_glossary_term' = 'Credential Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Credential Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issue_date` SET TAGS ('pii_business_glossary_term' = 'Credential Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_city` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority City');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_code` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_country` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Country');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_state` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority State');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_zip` SET TAGS ('pii_business_glossary_term' = 'Credential Issuing Authority Zip');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_zip` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_number` SET TAGS ('pii_business_glossary_term' = 'Credential Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_status` SET TAGS ('pii_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_status_reason` SET TAGS ('pii_business_glossary_term' = 'Credential Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_type` SET TAGS ('pii_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_date` SET TAGS ('pii_business_glossary_term' = 'Credential Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_method` SET TAGS ('pii_business_glossary_term' = 'Credential Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_notes` SET TAGS ('pii_business_glossary_term' = 'Credential Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_status` SET TAGS ('pii_business_glossary_term' = 'Credential Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_description` SET TAGS ('pii_business_glossary_term' = 'Credential Document Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Credential Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Credential Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Credential Document Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language_description` SET TAGS ('pii_business_glossary_term' = 'Credential Document Language Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Credential Document Page Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `size_bytes` SET TAGS ('pii_business_glossary_term' = 'Credential Document Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Credential Document Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Credential Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Credential Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Credential Document Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'Credential Document Url');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Credential Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Credential Document Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_subdomain' = 'attestation_records');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `credential_outreach_id` SET TAGS ('pii_business_glossary_term' = 'Outreach Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `attachment_flag` SET TAGS ('pii_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `contact_detail` SET TAGS ('pii_business_glossary_term' = 'Contact Detail');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `credential_outreach_status` SET TAGS ('pii_business_glossary_term' = 'Outreach Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `credential_outreach_status` SET TAGS ('pii_value_regex' = 'pending|sent|acknowledged|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `document_type_requested` SET TAGS ('pii_business_glossary_term' = 'Document Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `document_type_requested` SET TAGS ('pii_value_regex' = 'license|board_cert|malpractice|privilege|other');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `items_requested` SET TAGS ('pii_business_glossary_term' = 'Items Requested');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outreach Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'responded|no_response|partial_response|declined|completed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_method` SET TAGS ('pii_business_glossary_term' = 'Outreach Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_method` SET TAGS ('pii_value_regex' = 'mail|email|phone|portal|fax');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('pii_business_glossary_term' = 'Outreach Sent Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_type` SET TAGS ('pii_business_glossary_term' = 'Outreach Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_type` SET TAGS ('pii_value_regex' = 'initial_request|follow_up|final_notice|expiration_warning|reminder');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Outreach Priority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `reference` SET TAGS ('pii_business_glossary_term' = 'Outreach Reference Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_method` SET TAGS ('pii_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_method` SET TAGS ('pii_value_regex' = 'email|phone|portal|mail|fax');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_notes` SET TAGS ('pii_business_glossary_term' = 'Response Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_received_date` SET TAGS ('pii_business_glossary_term' = 'Response Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `sla_target_days` SET TAGS ('pii_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_subdomain' = 'attestation_records');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_source_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_duplicate_of' = 'compliance.compliance_attestation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_alias_of' = 'compliance.compliance_attestation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_canonical' = 'compliance.compliance_attestation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_ssot_concept' = 'credential_attestation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` SET TAGS ('pii_rename_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `credential_attestation2_id` SET TAGS ('pii_business_glossary_term' = 'Attestation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `compliance_attestation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Compliance Attestation Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `compliance_attestation_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `application_accuracy` SET TAGS ('pii_business_glossary_term' = 'Application Accuracy Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_number` SET TAGS ('pii_business_glossary_term' = 'Attestation Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_status` SET TAGS ('pii_business_glossary_term' = 'Attestation Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_type` SET TAGS ('pii_business_glossary_term' = 'Attestation Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `attestation_type` SET TAGS ('pii_value_regex' = 'initial|recredentialing|annual');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `competence_current` SET TAGS ('pii_business_glossary_term' = 'Current Competence Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `compliance_requirement` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `disclosure_text` SET TAGS ('pii_business_glossary_term' = 'Provider Disclosure Text');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `felony_conviction` SET TAGS ('pii_business_glossary_term' = 'Felony Conviction Disclosure');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `impairment_absence` SET TAGS ('pii_business_glossary_term' = 'Absence of Impairment Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `malpractice_history_accuracy` SET TAGS ('pii_business_glossary_term' = 'Malpractice History Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Attestation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `privileges_loss` SET TAGS ('pii_business_glossary_term' = 'Loss of Privileges Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `provider_signature_indicator` SET TAGS ('pii_business_glossary_term' = 'Provider Signature Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_source` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `review_outcome` SET TAGS ('pii_business_glossary_term' = 'Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `review_outcome` SET TAGS ('pii_value_regex' = 'approved|rejected|needs_more_info');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_subdomain' = 'attestation_records');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `credential_appeal_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_document_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Number (External Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'submitted|under_review|hearing_scheduled|decision_made|closed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_type` SET TAGS ('pii_business_glossary_term' = 'Appeal Type (Informal Reconsideration, Formal Hearing, External Review)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_type` SET TAGS ('pii_value_regex' = 'informal|formal|external');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_outcome` SET TAGS ('pii_value_regex' = 'upheld|overturned|modified|dismissed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Appeal Fee Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fee_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `ground` SET TAGS ('pii_business_glossary_term' = 'Grounds for Appeal');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_date` SET TAGS ('pii_business_glossary_term' = 'Hearing Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_panel_members` SET TAGS ('pii_business_glossary_term' = 'Hearing Panel Members');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_panel_type` SET TAGS ('pii_business_glossary_term' = 'Hearing Panel Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_panel_type` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `original_decision_date` SET TAGS ('pii_business_glossary_term' = 'Original Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `original_decision_type` SET TAGS ('pii_business_glossary_term' = 'Original Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `original_decision_type` SET TAGS ('pii_value_regex' = 'denial|revocation|suspension');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `outcome_reason` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Appeal Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `review_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Review Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Appeal Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `supporting_documentation` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('pii_subdomain' = 'attestation_records');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `credential_attestation_id` SET TAGS ('pii_business_glossary_term' = 'credential_attestation Identifier');
