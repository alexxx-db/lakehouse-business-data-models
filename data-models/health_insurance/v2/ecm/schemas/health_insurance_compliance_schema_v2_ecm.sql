-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`compliance` COMMENT 'Manages regulatory compliance obligations — HIPAA privacy and security (OCR), ACA market conduct, CMS audit readiness, state DOI filings, NCQA/URAC accreditation, SOC reporting, fraud waste and abuse (FWA) monitoring, and PHI breach notification. Owns regulatory submission calendars, audit findings, corrective action plans (CAPs), compliance attestations, and MLR compliance tracking. Supports ERISA filings and state fair hearing coordination.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Link to the specific regulatory requirement that this submission satisfies.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: Certain regulatory submissions (e.g., network participation filings) are made per contract and must be tracked.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance professional responsible for the filing.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Regulatory Submission: submissions are filed on behalf of an employer group, needed for tracking filing status per group.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Regulatory submissions (e.g., CMS filing) are made for a particular health plan; linking enables tracking submission status per plan.',
    `acceptance_date` DATE COMMENT 'Date the regulator formally accepted the filing.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `confirmation_number` STRING COMMENT 'Identifier returned by the regulator confirming receipt of the filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `due_date` DATE COMMENT 'Deadline by which the regulatory filing must be completed.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fee_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the filing fee is expressed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Gross fee charged by the regulator for processing the submission.',
    `filing_period_end` DATE COMMENT 'End date of the reporting period covered by the submission.',
    `filing_period_start` DATE COMMENT 'Start date of the reporting period covered by the submission.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the filing is deemed critical for regulatory compliance (true) or routine (false).',
    `last_reminder_sent_date` DATE COMMENT 'Date the most recent reminder was sent to the responsible party.',
    `lead_time_days` STRING COMMENT 'Number of days between creation of the submission record and its due date.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Net fee after any adjustments, discounts, or credits.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Government or accrediting entity to which the submission is made.. Valid values are `CMS|STATE_DOI|NCQA|OCR|ERISA|DOL`',
    `regulatory_submission_status` STRING COMMENT 'Current lifecycle state of the regulatory filing.. Valid values are `scheduled|draft|submitted|accepted|rejected|cancelled`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why a filing was rejected by the regulator.',
    `reminder_schedule` STRING COMMENT 'Human‑readable description of the reminder cadence (e.g., "30/15/5 days before due").',
    `submission_date` DATE COMMENT 'Actual calendar date the filing was submitted to the regulator.',
    `submission_description` STRING COMMENT 'Free‑text notes describing the purpose or special considerations of the filing.',
    `submission_method` STRING COMMENT 'Technical or physical channel used to deliver the filing.. Valid values are `edi|portal|paper|email`',
    `submission_number` STRING COMMENT 'External reference number assigned to the filing by the organization.',
    `submission_type` STRING COMMENT 'Category of the regulatory filing (e.g., annual notice, rate filing).. Valid values are `annual_notice|rate_filing|financial_statement|accreditation|breach_notification|mlr_report`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the submission record.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record for each regulatory filing or submission — from scheduled deadline through actual filing. Captures submission type, regulatory body, due date, lead time days, reminder schedule, submission date, filing period, submission method (EDI, portal, paper), status (scheduled, draft, submitted, accepted, rejected), and confirmation identifiers. Covers CMS annual notices, state DOI rate filings, NAIC financial statements, NCQA accreditation submissions, OCR breach notifications, MLR rebate filings, ACA marketplace submissions, and ERISA filings (Form 5500, Summary Annual Report, Summary Plan Description, COBRA notices, QMCSO responses). Supports the annual regulatory calendar view used by compliance officers to manage deadlines across CMS, state DOIs, NCQA, OCR, ERISA, and DOL obligations. Links to the regulatory obligation it satisfies.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Unique identifier for the audit engagement record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audit engagements are performed to satisfy regulatory obligations; linking creates required hierarchy.',
    `audit_id` BIGINT COMMENT 'Identifier of the subsequent audit engagement if follow-up is required.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Audit Management: each audit engagement is performed for a specific employer group, required for audit scheduling and reporting.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Audits verify compliance of a specific health plan; auditors need to reference the plan being audited for ACA reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit engagements require a designated lead auditor employee; enables audit scheduling and accountability.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: External audit firms are vendors; linking audit engagements to the responsible vendor allows tracking audit scope, costs, and compliance obligations per vendor.',
    `audit_body` STRING COMMENT 'Organization or agency conducting the audit.. Valid values are `CMS|OCR|NCQA|URAC|State_DOI|Internal`',
    `audit_category` STRING COMMENT 'High-level category of the audit focus area.. Valid values are `financial|operational|clinical|IT|security`',
    `audit_cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred for the audit.',
    `audit_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost associated with conducting the audit.',
    `audit_currency` STRING COMMENT 'Currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `audit_document_reference` STRING COMMENT 'Identifier or path to the primary audit report document.',
    `audit_engagement_status` STRING COMMENT 'Current lifecycle status of the audit engagement.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_findings_reference` STRING COMMENT 'Identifier linking to the detailed findings dataset.',
    `audit_followup_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is scheduled.',
    `audit_location` STRING COMMENT 'Geographic location or business unit where the audit is primarily conducted.',
    `audit_methodology` STRING COMMENT 'Methodology or standards used to conduct the audit (e.g., COSO, ISO27001).',
    `audit_notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `audit_number` STRING COMMENT 'External reference number assigned to the audit by the auditing body.',
    `audit_period_end` DATE COMMENT 'End date of the audit coverage period.',
    `audit_period_start` DATE COMMENT 'Start date of the audit coverage period.',
    `audit_priority` STRING COMMENT 'Priority level assigned to the audit engagement.. Valid values are `high|medium|low`',
    `audit_report_release_date` DATE COMMENT 'Date when the final audit report was released to stakeholders.',
    `audit_scope` STRING COMMENT 'Narrative describing the functional and geographic scope of the audit.',
    `audit_type` STRING COMMENT 'Category of audit based on purpose and scope.. Valid values are `regulatory|financial|operational|internal|external`',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) applicable to the audit.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State_DOI`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit engagement record was first created in the system.',
    `critical_findings` STRING COMMENT 'Number of findings classified as critical severity.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `engagement_end_date` DATE COMMENT 'Date when the audit engagement concluded or was terminated.',
    `engagement_start_date` DATE COMMENT 'Date when the audit engagement officially began.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit engagement was last reviewed for status or changes.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minor_findings` STRING COMMENT 'Number of findings classified as minor severity.',
    `overall_outcome` STRING COMMENT 'Final result of the audit after all findings are addressed.. Valid values are `favorable|unfavorable|conditional|pending`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulation or statute cited for each finding.',
    `remediation_plan_due_date` DATE COMMENT 'Target date by which all remediation actions must be completed.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities for audit findings.. Valid values are `not_started|in_progress|completed|overdue`',
    `risk_rating` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `high|medium|low`',
    `significant_findings` STRING COMMENT 'Number of findings classified as significant severity.',
    `total_findings` STRING COMMENT 'Total number of findings identified during the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit engagement record.',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Master record for each formal audit or examination conducted by or against the health plan — CMS program audits (RADV, Part C/D), state DOI market conduct examinations, OCR HIPAA investigations, NCQA accreditation surveys, SOC 2 audits, internal compliance audits, and external financial audits. Captures audit type, auditing body, audit scope, audit period, lead auditor, engagement start/end dates, status, and overall audit outcome. Includes detailed finding tracking: finding type (condition, cause, effect), severity level (critical, significant, minor), regulatory citation, finding description, affected business area, root cause analysis, recommended remediation, and finding status through the lifecycle from identification through remediation and closure. Serves as the authoritative registry of all audit engagements and their findings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Audit findings belong to an audit engagement; linking provides parent relationship and enables traceability.',
    `header_id` BIGINT COMMENT 'Identifier of the claim linked to the finding, when relevant.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who recorded the finding.',
    `affected_business_area` STRING COMMENT 'Business function or area affected by the finding.. Valid values are `claims|billing|provider_network|member_services|care_management|pharmacy`',
    `audit_category` STRING COMMENT 'Regulatory or compliance domain to which the finding relates.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the audit finding.. Valid values are `open|in_progress|resolved|closed`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was formally closed after remediation.',
    `compliance_area` STRING COMMENT 'Specific compliance domain impacted by the finding.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the remediation work.. Valid values are `not_started|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative describing the nature of the finding.',
    `due_date` DATE COMMENT 'Date by which remediation actions must be completed.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effectiveness_assessment` STRING COMMENT 'Qualitative assessment of remediation effectiveness.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_score` STRING COMMENT 'Score (0‑100) measuring how effective the remediation was.',
    `evidence_document_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting evidence documents.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact associated with the finding.',
    `financial_impact_currency` STRING COMMENT 'Currency code for the financial impact amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `finding_number` STRING COMMENT 'Business identifier assigned to the finding for tracking and reference.',
    `finding_type` STRING COMMENT 'Classification of the finding as a condition, cause, or effect.. Valid values are `condition|cause|effect`',
    `identified_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was first identified during the audit.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'True if the finding is deemed critical based on severity and impact.',
    `is_repeat_finding` BOOLEAN COMMENT 'Indicates whether this finding has been observed previously.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the finding.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes added by auditors or reviewers.',
    `priority` STRING COMMENT 'Priority level assigned to the finding for remediation scheduling.. Valid values are `high|medium|low`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_citation` STRING COMMENT 'Specific regulation, statute, or standard cited for the finding.',
    `related_policy_number` STRING COMMENT 'Policy number associated with the finding, if applicable.',
    `related_system` STRING COMMENT 'Source system where the issue was detected.',
    `remediation_action` STRING COMMENT 'Recommended corrective action to address the finding.',
    `remediation_due_date` DATE COMMENT 'Date by which the remediation must be completed.',
    `resolution` STRING COMMENT 'Final resolution outcome for the finding.. Valid values are `remediated|waived|deferred|rejected`',
    `reviewed_by` BIGINT COMMENT 'Identifier of the person who performed the latest review.',
    `risk_score` STRING COMMENT 'Numeric risk score (0‑100) representing the findings risk level.',
    `risk_score_source` STRING COMMENT 'Origin of the risk score calculation.. Valid values are `internal|external|model`',
    `root_cause` STRING COMMENT 'Analysis of the underlying cause that led to the finding.',
    `severity_level` STRING COMMENT 'Severity rating indicating the potential impact of the finding.. Valid values are `critical|significant|minor`',
    `source` STRING COMMENT 'Origin of the finding: internal audit, external audit, or regulatory review.. Valid values are `internal_audit|external_audit|regulatory`',
    `tags` STRING COMMENT 'Comma‑separated tags for categorization and search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit finding record.',
    `version` STRING COMMENT 'Version number for the finding record to support change tracking.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record for each finding, deficiency, or observation identified during an audit engagement. Captures finding type (condition, cause, effect), severity level (critical, significant, minor), regulatory citation, finding description, affected business area, root cause analysis, and recommended remediation. Links to the parent audit engagement and drives the corrective action plan (CAP) process. Tracks finding status through the lifecycle from identification through remediation and closure.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the corrective action plan.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: A Corrective Action Plan is created in direct response to an audit finding. The existing STRING field finding_reference is a denormalized text reference that should be replaced by a proper FK. The a',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for executing the CAP.',
    `actual_completion_date` DATE COMMENT 'Date when the CAP was actually completed.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for the CAP.',
    `audit_comments` STRING COMMENT 'Free-text comments from auditors or reviewers regarding the CAP.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP was formally closed.',
    `compliance_category` STRING COMMENT 'High-level compliance domain of the issue.. Valid values are `privacy|security|financial|clinical|operational`',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline by which remediation must be completed.',
    `corrective_action_plan_status` STRING COMMENT 'Current lifecycle status of the CAP.. Valid values are `draft|submitted|in_progress|completed|closed|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP record was created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the corrective actions.',
    `evidence_document_path` STRING COMMENT 'File system or URL location of supporting evidence artifacts.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_external_audit` BOOLEAN COMMENT 'Indicates whether the finding originated from an external audit.',
    `is_fwa_monitoring` BOOLEAN COMMENT 'Indicates if the CAP is related to FWA monitoring.',
    `last_milestone_status` STRING COMMENT 'Status of the most recent milestone.. Valid values are `not_started|in_progress|completed|blocked`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `milestone_count` STRING COMMENT 'Total number of milestones defined for the CAP.',
    `notes` STRING COMMENT 'Additional free-text notes about the CAP.',
    `owner_role` STRING COMMENT 'Role of the owner within the organization.. Valid values are `compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager`',
    `plan_name` STRING COMMENT 'Descriptive name of the corrective action plan.',
    `plan_number` STRING COMMENT 'External reference number assigned to the CAP.',
    `plan_type` STRING COMMENT 'Category of the CAP based on source of finding.. Valid values are `audit|regulatory|operational|clinical|financial`',
    `priority` STRING COMMENT 'Priority level assigned to the CAP.. Valid values are `low|medium|high|critical`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Regulatory authority associated with the finding. [ENUM-REF-CANDIDATE: CMS|OCR|NAIC|State_DOI|NCQA|URAC|Joint_Commission — 7 candidates stripped; promote to reference product]',
    `remediation_strategy` STRING COMMENT 'Planned approach to address the root cause.',
    `risk_score` STRING COMMENT 'Numeric risk score assigned to the CAP based on severity and impact.',
    `root_cause` STRING COMMENT 'Narrative of the root cause analysis for the finding.',
    `severity` STRING COMMENT 'Severity of the underlying finding.. Valid values are `minor|moderate|major|severe`',
    `target_completion_date` DATE COMMENT 'Planned date by which the CAP should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CAP record.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Master record for each Corrective Action Plan (CAP) developed in response to audit findings, regulatory violations, or accreditation deficiencies. Captures the triggering finding or violation, CAP type, remediation strategy, responsible owner, target completion date, and implementation status. Includes granular milestone tracking with individual action items, assigned owners, planned/actual completion dates, milestone status, evidence artifacts, and reviewer sign-off for each milestone. Tracks the full CAP lifecycle from submission to regulatory body through milestone completion, validation, and closure. Critical for CMS audit readiness and NCQA accreditation maintenance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` (
    `cap_milestone_id` BIGINT COMMENT 'Unique identifier for the corrective action plan milestone record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier of the parent corrective action plan to which this milestone belongs.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for executing the milestone.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the person who reviews and signs off on milestone completion.',
    `actual_completion_date` DATE COMMENT 'Date the milestone was actually completed.',
    `actual_start_date` DATE COMMENT 'Date the milestone actually started.',
    `cap_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `not_started|in_progress|completed|blocked|deferred|cancelled`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Numeric progress indicator (0.00 – 100.00) representing how much of the milestone work is finished.',
    `compliance_category` STRING COMMENT 'Regulatory or compliance domain that the milestone addresses. [ENUM-REF-CANDIDATE: hipaa|aca|mlr|ncqa|urac|state_doi|fwa — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalated_flag` BOOLEAN COMMENT 'True if the milestone has been escalated due to delays or issues.',
    `evidence_documentation_url` STRING COMMENT 'Link to the artifact or document that provides evidence of milestone completion.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical for compliance or business impact.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `milestone_code` STRING COMMENT 'Business identifier or code assigned to the milestone for external reference.',
    `milestone_description` STRING COMMENT 'Detailed description of the work or outcome required for the milestone.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone within the corrective action plan.',
    `milestone_type` STRING COMMENT 'Category that classifies the nature of the milestone activity.. Valid values are `documentation|training|process_change|system_update|audit|review`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the milestone.',
    `planned_completion_date` DATE COMMENT 'Target date by which the milestone should be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the milestone to begin.',
    `priority` STRING COMMENT 'Priority level indicating the importance or urgency of the milestone.. Valid values are `low|medium|high|critical`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference identifier for the specific regulatory requirement, audit finding, or standard tied to the milestone.',
    `risk_level` STRING COMMENT 'Risk rating associated with the milestones impact on compliance or operations.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    CONSTRAINT pk_cap_milestone PRIMARY KEY(`cap_milestone_id`)
) COMMENT 'Transactional record tracking individual milestones and action items within a Corrective Action Plan (CAP). Captures milestone description, assigned owner, planned completion date, actual completion date, milestone status, evidence artifacts, and reviewer sign-off. Enables granular tracking of CAP progress and supports regulatory reporting on remediation timelines. Links to the parent CAP and provides the audit trail required by CMS, state DOIs, and NCQA for CAP validation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` (
    `breach_incident_id` BIGINT COMMENT 'Primary key for breach_incident',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: When a PHI breach involves a business associate, the specific BAA governing that relationship is critical for determining breach notification requirements, liability, and remediation obligations. brea',
    `breach_report_id` BIGINT COMMENT 'Identifier of the breach report filed with external regulator.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: PHI breach incidents are reported against the specific provider contract responsible for the data.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: A breach incident triggers a Corrective Action Plan to remediate the root cause and prevent recurrence. breach_incident currently has denormalized STRING fields corrective_action_plan and correctiv',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PHI breach response is managed by a specific employee; needed for incident response reporting.',
    `vendor_id` BIGINT COMMENT 'Identifier of the Business Associate involved, if any.',
    `affected_phi_categories` STRING COMMENT 'Comma-separated list of PHI categories impacted (e.g., demographic, clinical, claims).',
    `audit_findings` STRING COMMENT 'Summary of audit findings related to the breach.',
    `breach_cause_description` STRING COMMENT 'Narrative description of the cause of the breach.',
    `breach_discovery_date` DATE COMMENT 'Date the breach was discovered by the organization.',
    `breach_incident_number` STRING COMMENT 'External reference number assigned to the breach incident.',
    `breach_occurrence_date` DATE COMMENT 'Date the breach actually occurred (if known).',
    `breach_report_url` STRING COMMENT 'Link to the external breach report document.',
    `breach_resolution_date` DATE COMMENT 'Date the breach was fully resolved and closed.',
    `breach_source` STRING COMMENT 'Origin of the breach (internal staff, external actor, partner, unknown).. Valid values are `internal|external|partner|unknown`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach investigation.. Valid values are `open|investigating|closed|pending|resolved`',
    `breach_type` STRING COMMENT 'Category of the breach event.. Valid values are `unauthorized_access|theft|loss|improper_disposal|other`',
    `business_associate_involved` BOOLEAN COMMENT 'Indicates whether a Business Associate was involved in the breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach incident record was created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hhs_notification_date` DATE COMMENT 'Date HHS was notified of the breach.',
    `hhs_notified` BOOLEAN COMMENT 'Indicates if the U.S. Department of Health & Human Services was notified.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notification_content_version` STRING COMMENT 'Version identifier of the notification content used.',
    `notification_date` DATE COMMENT 'Date the notification was sent.',
    `notification_delivery_confirmation` BOOLEAN COMMENT 'Indicates whether delivery confirmation was received.',
    `notification_method` STRING COMMENT 'Delivery channel used for the notification.. Valid values are `mail|email|substitute_notice|phone|fax`',
    `notification_obligation` STRING COMMENT 'Regulatory notification obligations triggered by the breach.. Valid values are `individual|hhs|state|media|none`',
    `notification_recipient_count` STRING COMMENT 'Number of recipients who received the notification.',
    `notification_type` STRING COMMENT 'Type of notification sent.. Valid values are `individual|hhs|state|media`',
    `number_of_individuals_affected` STRING COMMENT 'Count of distinct individuals whose PHI was compromised.',
    `number_of_records_affected` STRING COMMENT 'Total number of PHI records impacted.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_date` DATE COMMENT 'Date the breach was filed with the regulator.',
    `regulatory_filing_status` STRING COMMENT 'Status of required regulatory filings related to the breach.. Valid values are `not_filed|filed|rejected|accepted`',
    `risk_assessment_method` STRING COMMENT 'Methodology used for risk assessment.. Valid values are `qualitative|quantitative|hybrid`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score resulting from breach risk assessment.',
    `state_notification_date` DATE COMMENT 'Date the state authority was notified.',
    `state_notified` BOOLEAN COMMENT 'Indicates if the relevant state authority was notified.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach incident record.',
    CONSTRAINT pk_breach_incident PRIMARY KEY(`breach_incident_id`)
) COMMENT 'Master record for each PHI (Protected Health Information) breach incident identified under HIPAA Breach Notification Rule (45 CFR §164.400–414). Captures breach discovery date, breach type (unauthorized access, theft, loss, improper disposal), affected PHI categories, number of individuals affected, breach cause, business associate involvement, risk assessment outcome, and notification obligations triggered. Includes full notification tracking: notification type (individual, HHS/OCR, media, state AG), notification method (mail, email, substitute notice), notification date, recipient count, content version, and delivery confirmation. Drives the 60-day OCR notification workflow and annual breach report to HHS. Critical for HIPAA compliance and OCR audit readiness.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` (
    `breach_notification_id` BIGINT COMMENT 'Unique surrogate key for breach notification record.',
    `breach_incident_id` BIGINT COMMENT 'Identifier of the associated PHI breach incident.',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier of the corrective action plan linked to this notification.',
    `member_communication_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory breach notifications are issued by a designated employee; links notification to responsible staff.',
    `affected_member_count` STRING COMMENT 'Number of members whose PHI was affected by the breach.',
    `affected_provider_count` STRING COMMENT 'Number of providers affected by the breach.',
    `breach_category` STRING COMMENT 'Category of the breach incident.. Valid values are `unauthorized_access|theft|loss|improper_disclosure|hacking|malware`',
    `breach_disclosure_date` DATE COMMENT 'Date the breach was disclosed internally.',
    `breach_discovery_date` DATE COMMENT 'Date the breach was discovered.',
    `breach_notification_status` STRING COMMENT 'Current lifecycle status of the notification record.. Valid values are `draft|sent|failed|cancelled|archived`',
    `compliance_status` STRING COMMENT 'Overall compliance status of the notification process.. Valid values are `compliant|non_compliant|pending_review`',
    `content_version` STRING COMMENT 'Version identifier of the notification content used.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach notification record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deadline_date` DATE COMMENT 'Regulatory deadline date by which notification must be sent (typically 60 days from breach discovery).',
    `deadline_met` BOOLEAN COMMENT 'Flag indicating if the notification was sent on or before the deadline.',
    `delivery_confirmation` BOOLEAN COMMENT 'Indicates whether delivery confirmation was received.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `media_outlet_name` STRING COMMENT 'Name of media outlet notified, if applicable.',
    `notification_content_hash` STRING COMMENT 'Hash of the notification content for audit purposes.',
    `notification_date` DATE COMMENT 'Date the notification was sent to the recipient.',
    `notification_method` STRING COMMENT 'Method used to deliver the breach notification.. Valid values are `mail|email|substitute_notice|fax|phone`',
    `notification_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the notification was sent.',
    `notification_type` STRING COMMENT 'Category of notification recipient.. Valid values are `individual|hhs|media|state_regulator`',
    `number_of_recipients` STRING COMMENT 'Count of individuals or entities who received the notification.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body_notified` STRING COMMENT 'Regulatory authority or entity that was notified.. Valid values are `hhs|ocr|state|media`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the breach (0-100).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach notification record.',
    CONSTRAINT pk_breach_notification PRIMARY KEY(`breach_notification_id`)
) COMMENT 'Transactional record for each breach notification sent to affected individuals, HHS/OCR, state regulators, or media outlets as required under HIPAA Breach Notification Rule. Captures notification type (individual, HHS, media), notification method (mail, email, substitute notice), notification date, number of recipients, notification content version, and delivery confirmation. Tracks compliance with the 60-day notification deadline and supports OCR investigation response. Links to the parent PHI breach incident.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` (
    `hipaa_privacy_request_id` BIGINT COMMENT 'System-generated unique identifier for the HIPAA privacy request record.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who submitted the privacy request.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each HIPAA privacy request is processed by a compliance employee; required for audit trails.',
    `appeal_deadline` DATE COMMENT 'Final date by which an appeal must be filed.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if applicable.. Valid values are `upheld|reversed|denied|withdrawn`',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy request record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the privacy request record.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason` STRING COMMENT 'Explanation provided when a request is denied or partially granted.',
    `disclosure_authorization_basis` STRING COMMENT 'Legal basis authorizing the PHI disclosure.. Valid values are `patient_authorization|legal_requirement|public_interest|court_order`',
    `disclosure_date` TIMESTAMP COMMENT 'Timestamp of the PHI disclosure, if one occurred.',
    `disclosure_logged` BOOLEAN COMMENT 'Indicates whether a PHI disclosure related to this request has been logged.',
    `disclosure_phicategories` STRING COMMENT 'Comma‑separated list of PHI categories disclosed (e.g., diagnosis, treatment, payment).',
    `disclosure_purpose` STRING COMMENT 'Business or legal purpose for which the PHI was disclosed.',
    `disclosure_recipient_type` STRING COMMENT 'Category of the entity receiving the disclosed PHI.. Valid values are `public_health|law_enforcement|research|legal|other`',
    `disposition` STRING COMMENT 'Outcome of the request (e.g., granted, denied, partially granted).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the member has appealed the request decision.',
    `is_confidential_communication` BOOLEAN COMMENT 'True when the member requests that communications be handled confidentially.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_channel` STRING COMMENT 'Medium of the request (digital, paper, or phone).. Valid values are `digital|paper|phone`',
    `request_description` STRING COMMENT 'Free‑text description provided by the member detailing the request.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the privacy request.',
    `request_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the privacy request was initially received.',
    `request_source` STRING COMMENT 'Channel through which the request was received (e.g., member portal, email, phone).. Valid values are `portal|email|phone|fax|mail`',
    `request_status` STRING COMMENT 'Current processing state of the privacy request.. Valid values are `pending|in_review|completed|denied|partially_granted|closed`',
    `request_type` STRING COMMENT 'Category of the privacy request as defined by HIPAA (e.g., access, amendment, accounting of disclosures, restriction, confidential communication).. Valid values are `access|amendment|accounting|restriction|confidential_communication`',
    `response_date` DATE COMMENT 'Date on which the organization completed its response to the request.',
    `response_due_date` DATE COMMENT 'Regulatory deadline by which a response must be provided (typically 30 days from receipt).',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_hipaa_privacy_request PRIMARY KEY(`hipaa_privacy_request_id`)
) COMMENT 'Transactional record for HIPAA privacy operations — member privacy rights requests and PHI disclosure tracking. Covers access requests (right to access PHI), amendment requests, accounting of disclosures, restriction requests, and confidential communication requests under 45 CFR §164.500. Captures request type, member identifier, request receipt date, response due date, response date, request disposition (granted, denied, partially granted), denial reason, and appeal status. Includes PHI disclosure logging: disclosure date, recipient organization, recipient type (public health authority, law enforcement, research, legal), purpose of disclosure, PHI categories disclosed, and disclosure authorization basis. Excludes treatment, payment, and healthcare operations disclosures per HIPAA exemptions. Tracks compliance with HIPAA response timelines and supports OCR audit documentation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` (
    `phi_disclosure_log_id` BIGINT COMMENT 'Unique surrogate identifier for each PHI disclosure event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Disclosure logs must record which employee performed the PHI disclosure for compliance reporting.',
    `hipaa_privacy_request_id` BIGINT COMMENT 'Unique identifier of the internal request or workflow that generated the disclosure.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose protected health information was disclosed.',
    `policy_document_id` BIGINT COMMENT 'External document identifier that substantiates the disclosure (e.g., subpoena number).',
    `authorization_basis` STRING COMMENT 'Legal justification permitting the disclosure, per HIPAA regulations.. Valid values are `patient_consent|court_order|public_health_authority|law_enforcement_request|research_approval|other`',
    `compliance_status` STRING COMMENT 'Result of the compliance teams assessment of the disclosure.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the disclosure log entry was initially inserted into the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disclosure_method` STRING COMMENT 'Means by which the protected health information was delivered to the recipient.. Valid values are `electronic|fax|mail|oral|other`',
    `disclosure_status` STRING COMMENT 'Lifecycle state of the disclosure event for audit tracking.. Valid values are `pending|completed|rejected|revoked`',
    `disclosure_timestamp` TIMESTAMP COMMENT 'Date and time when the PHI disclosure occurred, recorded in UTC.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_authorized` BOOLEAN COMMENT 'True if the disclosure complied with the documented authorization basis; otherwise false.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional contextual information captured by compliance staff.',
    `phi_category` STRING COMMENT 'Standard classification of the type(s) of protected health information disclosed.. Valid values are `demographics|diagnosis|treatment|payment|eligibility|utilization`',
    `purpose_of_disclosure` STRING COMMENT 'Narrative description of the reason for disclosing the PHI (e.g., public health reporting, law enforcement request).',
    `recipient_name` STRING COMMENT 'Legal name of the entity or person that received the protected health information.',
    `recipient_type` STRING COMMENT 'Category describing why the recipient is allowed to receive PHI.. Valid values are `public_health|law_enforcement|research|legal|other`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the disclosure log entry.',
    CONSTRAINT pk_phi_disclosure_log PRIMARY KEY(`phi_disclosure_log_id`)
) COMMENT 'Transactional record capturing each disclosure of PHI to external parties as required by HIPAA Accounting of Disclosures (45 CFR §164.528). Captures disclosure date, recipient organization, recipient type (public health authority, law enforcement, research, legal), purpose of disclosure, PHI categories disclosed, disclosure authorization basis, and member identifier. Supports member requests for accounting of disclosures and OCR audit readiness. Excludes treatment, payment, and healthcare operations disclosures per HIPAA exemptions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`baa` (
    `baa_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each Business Associate Agreement record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each BAA supports compliance with a regulatory obligation; linking enables obligation‑centric reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Business Associate Agreements are overseen by a compliance officer; linking provides accountability.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Required for HIPAA BAA management: each Business Associate Agreement must reference the vendor (business associate) it covers, enabling reporting of vendor‑specific compliance status.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the BAA by the health plan.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the BAA.. Valid values are `active|terminated|pending|draft|suspended`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed against the original BAA.',
    `audit_rights` STRING COMMENT 'Rights granted to the health plan to audit the associates compliance with the BAA.',
    `breach_notification_requirements` STRING COMMENT 'Procedures and timelines the associate must follow to notify the health plan of a PHI breach.',
    `business_associate_name` STRING COMMENT 'Legal name of the vendor, TPA, PBM, clearinghouse, or other entity that receives PHI under the agreement.',
    `business_associate_type` STRING COMMENT 'Category of the business associate indicating the nature of the relationship.. Valid values are `vendor|tpa|pbm|clearinghouse|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BAA record was first created in the data warehouse.',
    `data_disposal_method` STRING COMMENT 'Method the associate must use to dispose of retained PHI after the retention period.. Valid values are `destroy|deidentify|archive|return|other`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_retention_period_months` STRING COMMENT 'Number of months the associate must retain PHI before disposal.',
    `effective_end_date` DATE COMMENT 'Date on which the BAA expires or terminates; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date on which the BAA becomes legally binding.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `governing_law` STRING COMMENT 'Legal jurisdiction governing the agreement (e.g., state law, federal HIPAA).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction (state or territory) applicable to the BAA.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the BAA.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `permitted_phis` STRING COMMENT 'List or description of specific PHI categories the associate may handle (e.g., claims, enrollment, clinical data).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation(s) that the BAA satisfies (e.g., HIPAA, HITECH).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration that the health plan must provide notice to renew.',
    `renewal_option` STRING COMMENT 'Specifies whether the BAA renews automatically, requires manual action, or does not renew.. Valid values are `auto|manual|none`',
    `scope_of_phi_use` STRING COMMENT 'Narrative description of permitted uses and disclosures of Protected Health Information under the agreement.',
    `security_obligations` STRING COMMENT 'Detailed security controls and safeguards the associate must implement to protect PHI.',
    `subcontractor_allowed` BOOLEAN COMMENT 'Indicates whether the business associate may engage subcontractors to perform PHI‑related services.',
    `subcontractor_details` STRING COMMENT 'Description of any approved subcontractors, their roles, and required safeguards.',
    `termination_clause` STRING COMMENT 'Text describing conditions under which the BAA may be terminated by either party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BAA record.',
    CONSTRAINT pk_baa PRIMARY KEY(`baa_id`)
) COMMENT 'Master record for each Business Associate Agreement (BAA) executed with vendors, TPAs, PBMs, clearinghouses, and other entities that handle PHI on behalf of the health plan under HIPAA (45 CFR §164.308). Captures business associate name, agreement effective date, expiration date, PHI use permissions, security obligations, breach notification requirements, subcontractor provisions, termination clauses, and agreement status. Serves as the authoritative registry of all BAAs and supports HIPAA compliance audits and vendor risk management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` (
    `fwa_case_id` BIGINT COMMENT 'Unique system-generated identifier for the FWA case.',
    `employee_id` BIGINT COMMENT 'Identifier of the investigator assigned to the case.',
    `allegation_description` STRING COMMENT 'Detailed description of the alleged fraud, waste, or abuse.',
    `audit_log_url` STRING COMMENT 'Link to the immutable audit log for this case.',
    `case_disposition` STRING COMMENT 'Final outcome of the case after investigation.. Valid values are `substantiated|unsubstantiated|law_enforcement|civil_penalty|referred`',
    `case_number` STRING COMMENT 'Business identifier assigned to the case for external reference and reporting.',
    `case_open_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was officially opened.',
    `case_status` STRING COMMENT 'Current lifecycle status of the case.. Valid values are `open|in_progress|closed|referred|settled`',
    `case_type` STRING COMMENT 'Primary classification of the case as fraud, waste, or abuse.. Valid values are `fraud|waste|abuse`',
    `compliance_reference` STRING COMMENT 'Reference identifier used in external compliance filings (e.g., CMS FWA program ID).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disposition_date` DATE COMMENT 'Date the case disposition was recorded.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'Projected monetary loss associated with the alleged activity.',
    `evidence_reference` STRING COMMENT 'Link or identifier to supporting evidence stored in the evidence repository.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_high_risk` BOOLEAN COMMENT 'Flag indicating the case is considered high risk based on internal scoring.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes entered by investigators or reviewers.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered or expected to be recovered from the subject.',
    `referral_date` DATE COMMENT 'Date the referral was received and the case was created.',
    `referral_source` STRING COMMENT 'Origin of the case referral, such as claim edit, data mining, tip line, law enforcement, or employee report.. Valid values are `claim_edit|data_mining|tip_line|law_enforcement|employee_report`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the case has been reported to a regulatory body (e.g., CMS, state fraud bureau).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned during triage (0‑100 scale).',
    `subject_reference` BIGINT COMMENT 'Identifier of the subject (member, provider, or employer group) under investigation.',
    `subject_type` STRING COMMENT 'Entity type that is the subject of the investigation.. Valid values are `member|provider|employer_group`',
    `triage_outcome` STRING COMMENT 'Result of the initial triage review, indicating next steps.. Valid values are `escalated|closed|investigate|dismissed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the case record.',
    CONSTRAINT pk_fwa_case PRIMARY KEY(`fwa_case_id`)
) COMMENT 'Master record for each Fraud, Waste, and Abuse (FWA) investigation — from initial referral intake through case disposition. Captures referral source (claim edits, data mining, tip line, law enforcement, employee reports), referral date, allegation description, supporting evidence references, triage outcome, case type (fraud, waste, abuse), subject type (member, provider, employer group), case open date, investigation status, assigned investigator, estimated financial exposure, recovery amount, and case disposition (substantiated, unsubstantiated, referred to law enforcement, civil monetary penalty). Supports CMS FWA program requirements, state insurance fraud bureau reporting, and annual FWA reporting to CMS.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` (
    `fwa_referral_id` BIGINT COMMENT 'System-generated unique identifier for the FWA referral record.',
    `fwa_case_id` BIGINT COMMENT 'Identifier of the FWA case opened as a result of this referral, if any.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is the subject of the referral, when applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of the referral, when applicable.',
    `allegation_description` STRING COMMENT 'Free‑text description of the alleged fraud, waste, or abuse.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the estimated loss amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `due_date` DATE COMMENT 'Target date by which the referral should be resolved or escalated.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the referral has been escalated to higher‑level review.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of potential loss associated with the alleged activity.',
    `evidence_reference` STRING COMMENT 'Link (URL or document ID) to supporting evidence attached to the referral.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fwa_referral_status` STRING COMMENT 'Current lifecycle status of the referral within the investigation workflow.. Valid values are `new|in_review|assigned|closed|rejected`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations captured by the investigator.',
    `priority` STRING COMMENT 'Priority level assigned to the referral for handling urgency.. Valid values are `low|medium|high|critical`',
    `provider_npi` STRING COMMENT 'NPI of the provider who is the subject of the referral, when applicable.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_date` TIMESTAMP COMMENT 'Timestamp when the referral was received or logged in the SIU system.',
    `referral_number` STRING COMMENT 'Business identifier assigned to the referral for tracking and reporting.',
    `referral_source` STRING COMMENT 'Origin of the referral indicating how it was reported.. Valid values are `internal_detection|employee|member|provider|external_agency`',
    `referral_type` STRING COMMENT 'Category of the alleged wrongdoing.. Valid values are `fraud|waste|abuse|billing_error|other`',
    `subject_type` STRING COMMENT 'Classification of the entity that is the subject of the referral.. Valid values are `member|provider|employee|other`',
    `triage_outcome` STRING COMMENT 'Result of the initial triage assessment.. Valid values are `opened|closed|dismissed|escalated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the referral record.',
    CONSTRAINT pk_fwa_referral PRIMARY KEY(`fwa_referral_id`)
) COMMENT 'Transactional record for each FWA referral received by the Special Investigations Unit (SIU) from internal detection systems, employees, members, providers, or external agencies. Captures referral source, referral date, subject identifier, referral type, allegation description, supporting evidence references, triage outcome, and linkage to the resulting FWA case if opened. Tracks the intake and triage workflow for all FWA allegations and supports CMS annual FWA reporting requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` (
    `mlr_calculation_id` BIGINT COMMENT 'Primary key for mlr_calculation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: MLR calculations are performed by a specific analyst; needed for audit of financial compliance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MLR calculations are performed to demonstrate compliance with regulatory obligations; linking ties calculations to obligations.',
    `health_plan_id` BIGINT COMMENT 'Foreign key to the insurance product (e.g., specific benefit design) tied to the calculation.',
    `mlr_reporting_entity_health_plan_id` BIGINT COMMENT 'Foreign key to the health plan for which the MLR is being calculated.',
    `audit_finding_reference` STRING COMMENT 'Identifier linking to any audit findings or regulatory review notes related to this calculation.',
    `calculation_date` DATE COMMENT 'Date on which the MLR calculation was performed.',
    `calculation_number` STRING COMMENT 'Human‑readable identifier assigned to the MLR calculation for reporting and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR calculation record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `earned_premium_amount` DECIMAL(18,2) COMMENT 'Total earned premium dollars for the reporting period, forming the MLR denominator.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of claims incurred for the reporting period.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business line (e.g., HMO, PPO, Medicaid) associated with the MLR calculation.',
    `market_segment_code` STRING COMMENT 'Code representing the market segment (e.g., individual, group, Medicare) to which the calculation applies.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_calculation_status` STRING COMMENT 'Current processing status of the MLR calculation.. Valid values are `pending|calculated|approved|rejected`',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'Calculated MLR ratio expressed as a percentage (incurred claims ÷ earned premium).',
    `notes` STRING COMMENT 'Free‑form comments or explanations entered by analysts.',
    `quality_improvement_expenses_amount` DECIMAL(18,2) COMMENT 'Dollar amount spent on quality improvement activities that count toward the MLR denominator.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the rebate owed to members or the market segment.',
    `rebate_disbursement_date` DATE COMMENT 'Date on which the rebate payment was or will be disbursed.',
    `rebate_disbursement_status` STRING COMMENT 'Current status of the rebate payment process.. Valid values are `not_started|in_process|completed|failed`',
    `rebate_eligibility_flag` BOOLEAN COMMENT 'True if the calculated MLR exceeds the regulatory threshold and a rebate is required.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_year` STRING COMMENT 'Calendar year for which the MLR is being calculated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MLR calculation record.',
    `version_number` STRING COMMENT 'Incremental version of the calculation record for audit trail purposes.',
    CONSTRAINT pk_mlr_calculation PRIMARY KEY(`mlr_calculation_id`)
) COMMENT 'Medical Loss Ratio (MLR) calculation and rebate processing record per ACA Section 2718 requirements. Captures reporting year, market segment, LOB, incurred claims, quality improvement expenses, earned premium, MLR percentage, rebate determination, rebate amount, and disbursement tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Unique system-generated identifier for each accreditation program record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Accreditation programs are driven by specific regulatory obligations; linking clarifies compliance scope.',
    `employee_id` BIGINT COMMENT 'System identifier for the accountable business owner.',
    `accountable_owner` STRING COMMENT 'Full name of the person or team accountable for the accreditation.',
    `accreditation_program_status` STRING COMMENT 'Current state of the accreditation (e.g., accredited, provisional, denied).. Valid values are `accredited|provisional|denied|pending|revoked`',
    `accreditation_type` STRING COMMENT 'Classification of the accreditation program (e.g., health plan, provider, pharmacy).. Valid values are `health_plan|provider|pharmacy|network|member`',
    `accrediting_body` STRING COMMENT 'Name of the organization that issues the accreditation (e.g., NCQA, URAC, CMS).',
    `applicable_standards` STRING COMMENT 'List of standards, guidelines, or criteria the program must meet.',
    `audit_trail` STRING COMMENT 'Chronological notes capturing audit actions and decisions.',
    `benchmark_thresholds` STRING COMMENT 'Target values for performance measures used in the accreditation.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Progress of the accreditation process expressed as a percent.',
    `compliance_category` STRING COMMENT 'High‑level classification of the accreditations compliance focus.',
    `conditions` STRING COMMENT 'Any remedial actions, monitoring, or conditions required for continued accreditation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision` STRING COMMENT 'Final decision made by the accrediting body.. Valid values are `accredited|denied|conditional|revoked`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date on which the accreditation starts to be binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date on which the accreditation ends; null if open‑ended.',
    `escalated_flag` BOOLEAN COMMENT 'True when issues have been escalated to senior management.',
    `evidence_documentation_url` STRING COMMENT 'Link to uploaded evidence files used in the accreditation review.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CareTeam)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) resulting from the accreditation evaluation.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'True if the accreditation is essential to business operations.',
    `last_modified_by` STRING COMMENT 'Identifier of the person or system that performed the most recent update.',
    `last_review_date` DATE COMMENT 'Date when the accreditation was last reviewed for compliance.',
    `accreditation_program_level` STRING COMMENT 'Level or tier assigned by the accrediting body (e.g., Level 1, Level 2).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `measure_thresholds` STRING COMMENT 'Target thresholds for each evaluated measure.',
    `measures` STRING COMMENT 'Key performance or quality measures assessed during the accreditation.',
    `next_survey_due_date` DATE COMMENT 'Planned date for the next accreditation survey cycle.',
    `notes` STRING COMMENT 'Additional comments or observations about the accreditation.',
    `preliminary_findings` STRING COMMENT 'Initial observations and issues identified during the survey.',
    `program_code` STRING COMMENT 'Business identifier assigned by the accrediting organization.',
    `program_name` STRING COMMENT 'Descriptive name of the accreditation program (e.g., NCQA Health Plan Accreditation).',
    `rating` STRING COMMENT 'Star rating or equivalent tier based on the final score.. Valid values are `1_star|2_star|3_star|4_star|5_star`',
    `recommendations` STRING COMMENT 'Suggested improvements or corrective actions from the accrediting body.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, statute, or standard governing the accreditation.',
    `renewal_cycle_months` STRING COMMENT 'Number of months between required renewal surveys.',
    `risk_level` STRING COMMENT 'Risk rating reflecting potential impact of non‑compliance.. Valid values are `low|medium|high`',
    `scope` STRING COMMENT 'Description of the functional and geographic scope covered by the accreditation.',
    `survey_end_date` DATE COMMENT 'Last day of the accreditation survey window.',
    `survey_start_date` DATE COMMENT 'First day of the accreditation survey window.',
    `survey_type` STRING COMMENT 'Type of survey associated with the accreditation (initial, renewal, focused).. Valid values are `initial|renewal|focused`',
    `surveyor_contact` STRING COMMENT 'Email address of the primary surveyor or accrediting liaison.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `surveyor_team` STRING COMMENT 'Name(s) of the surveyor(s) or consulting firm performing the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the accreditation record.',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Master record for each accreditation program the health plan participates in — NCQA Health Plan Accreditation, URAC Health Plan Accreditation, NCQA HEDIS, CAHPS survey programs, and CMS Star Ratings. Captures accrediting body, program name, accreditation type, current status (accredited, provisional, denied), accreditation level, effective/expiration dates, accountable business owner, and applicable standards/measures with benchmark thresholds. Includes full survey/review cycle tracking: survey type (initial, renewal, focused), survey date range, surveyor team, scope, preliminary findings, final score/rating, accreditation decision, and conditions or recommendations. Serves as the authoritative registry of all accreditation relationships and their evaluation history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'System-generated unique identifier for the accreditation survey record.',
    `accreditation_program_id` BIGINT COMMENT 'Identifier of the accreditation program (e.g., NCQA, URAC, CMS) under which the survey is conducted.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Accreditation surveys are conducted by a designated employee; linking enables tracking of survey execution.',
    `accreditation_decision` STRING COMMENT 'Final determination of accreditation status.. Valid values are `accredited|conditionally_accredited|not_accredited|pending`',
    `accreditation_survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `scheduled|in_progress|completed|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation survey was concluded.',
    `evidence_documentation_url` STRING COMMENT 'Link to the repository containing supporting evidence and documents submitted for the survey.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the accrediting body after final evaluation (e.g., 0.00 – 100.00).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes captured by the surveyor team.',
    `preliminary_findings` STRING COMMENT 'Initial observations and findings recorded during the survey before final evaluation.',
    `rating` STRING COMMENT 'Overall rating tier derived from the final score (1‑5 stars).',
    `recommendation` STRING COMMENT 'Recommendations or conditions issued by the surveyor for future compliance.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_level` STRING COMMENT 'Risk classification associated with identified deficiencies.. Valid values are `low|moderate|high|critical`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the accreditation survey officially began.',
    `survey_location` STRING COMMENT 'Physical location or facility where the survey was performed.',
    `survey_method` STRING COMMENT 'Methodology used to conduct the survey (e.g., onsite visit, remote review).. Valid values are `onsite|remote|hybrid`',
    `survey_number` STRING COMMENT 'External reference number assigned by the accreditation body for this survey cycle.',
    `survey_region_code` STRING COMMENT 'Three‑letter ISO country code representing the region of the survey.. Valid values are `^[A-Z]{3}$`',
    `survey_scope` STRING COMMENT 'Description of the functional and geographic scope covered by the survey.',
    `survey_type` STRING COMMENT 'Classification of the survey purpose (e.g., initial accreditation, renewal, focused review).. Valid values are `initial|renewal|focused|ad_hoc`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the survey record.',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Transactional record for each accreditation survey or review cycle conducted by NCQA, URAC, or CMS. Captures survey type (initial, renewal, focused), survey date range, surveyor team, survey scope, preliminary findings, final score or rating, accreditation decision, and conditions or recommendations. Links to the parent accreditation program and drives corrective action planning for deficiencies identified during the survey. Tracks the full survey lifecycle from scheduling through final determination.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'System-generated unique identifier for the policy document record.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who granted final approval.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required: Contracts reference specific policy documents governing terms and compliance obligations.',
    `primary_policy_employee_id` BIGINT COMMENT 'Identifier of the internal party (e.g., compliance officer, department) responsible for the policy.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the person who conducted the review.',
    `approval_date` DATE COMMENT 'Date the policy was formally approved.',
    `approval_status` STRING COMMENT 'Result of the formal approval workflow.. Valid values are `pending|approved|rejected`',
    `archive_date` DATE COMMENT 'Date the policy was archived.',
    `policy_document_category` STRING COMMENT 'High‑level grouping such as HIPAA Privacy, FWA, ACA Compliance, Credentialing, Claims Adjudication, etc.',
    `compliance_area` STRING COMMENT 'Specific compliance domain the policy addresses (e.g., privacy, fraud waste abuse, risk adjustment).',
    `confidentiality_level` STRING COMMENT 'Sensitivity classification governing handling and distribution.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `distribution_scope` STRING COMMENT 'Audience for the policy (internal employees, external partners, regulators).',
    `document_format` STRING COMMENT 'File format of the stored policy document.. Valid values are `pdf|docx|html`',
    `document_size_bytes` BIGINT COMMENT 'File size of the electronic document in bytes.',
    `document_url` STRING COMMENT 'Link to the stored electronic version of the policy (e.g., S3, SharePoint).',
    `effective_date` DATE COMMENT 'Date on which the policy becomes operationally binding.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the policy ceases to be in effect; null for indefinite policies.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Indicates whether the policy is currently in effect.',
    `is_archived` BOOLEAN COMMENT 'True if the policy has been moved to archival storage.',
    `is_confidential` BOOLEAN COMMENT 'True if the policy is marked confidential; aligns with confidentiality_level.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_date` DATE COMMENT 'Planned date for the subsequent review.',
    `policy_code` STRING COMMENT 'Business code or alphanumeric identifier used to reference the policy across systems.',
    `policy_document_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `draft|active|suspended|retired`',
    `policy_name` STRING COMMENT 'Descriptive title of the compliance policy, procedure, or SOP.',
    `policy_owner_department` STRING COMMENT 'Business unit or department that owns the policy.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_citations` STRING COMMENT 'List of statutes, regulations, or standards referenced (e.g., HIPAA, ACA, CMS).',
    `review_date` DATE COMMENT 'Date the most recent review was performed.',
    `review_outcome` STRING COMMENT 'Result of the review process.. Valid values are `approved|revised|retired`',
    `review_type` STRING COMMENT 'Nature of the review (scheduled annual, triggered by event, or regulatory change).. Valid values are `annual|triggered|regulatory_change`',
    `revision_summary` STRING COMMENT 'Brief description of changes made in the latest version.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the policy record.',
    `version_number` STRING COMMENT 'Semantic version identifier (e.g., 1.0, 2.1) tracking revisions.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the record.',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Master record for each internal compliance policy, procedure, or SOP — including version history and review tracking. Covers HIPAA privacy/security policies, FWA program policies, ACA compliance procedures, credentialing policies, and claims adjudication standards. Captures policy name, category, owner, effective date, version number, approval status, regulatory citations, and distribution scope. Tracks periodic reviews with review date, reviewer, review type (annual, triggered, regulatory change), outcome (approved, revised, retired), revision summary, next review date, and approver sign-off. Serves as the authoritative policy registry supporting NCQA, URAC, and CMS audit readiness.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` (
    `policy_review_id` BIGINT COMMENT 'Unique system-generated identifier for each policy review transaction.',
    `employee_id` BIGINT COMMENT 'System identifier of the senior officer who approved the review outcome.',
    `policy_document_id` BIGINT COMMENT 'Identifier of the compliance policy document that is being reviewed.',
    `primary_policy_employee_id` BIGINT COMMENT 'System identifier of the employee who performed the review.',
    `approver_name` STRING COMMENT 'Full legal name of the approver.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the review record.',
    `compliance_category` STRING COMMENT 'High‑level category of the policy under review.. Valid values are `privacy|security|financial|clinical|operational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `evidence_documentation_url` STRING COMMENT 'Link to supporting evidence files stored in the enterprise DMS.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the review addresses a critical compliance risk.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_date` DATE COMMENT 'Scheduled date for the subsequent review of the policy.',
    `notes` STRING COMMENT 'Additional comments or observations captured by the reviewer.',
    `outcome` STRING COMMENT 'Result of the review after evaluation.. Valid values are `approved_as_is|revised|retired|deferred`',
    `outcome_date` DATE COMMENT 'Date the outcome was formally recorded.',
    `policy_version` STRING COMMENT 'Version label of the policy at the time of review (e.g., v3.2).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Code or identifier of the specific regulation prompting the review (e.g., 45CFR164.308).',
    `review_date` DATE COMMENT 'Calendar date on which the review was conducted.',
    `review_duration_days` STRING COMMENT 'Number of calendar days between review start and completion.',
    `review_number` STRING COMMENT 'Human‑readable sequential number assigned to the review (e.g., PR‑2023‑0001).',
    `review_score` DECIMAL(18,2) COMMENT 'Numeric rating (0‑100) assigned by the reviewer based on compliance completeness.',
    `review_status` STRING COMMENT 'Current lifecycle state of the review.. Valid values are `pending|in_progress|completed|cancelled`',
    `review_type` STRING COMMENT 'Classification of why the review was performed.. Valid values are `annual|triggered|regulatory_change|ad_hoc`',
    `reviewer_name` STRING COMMENT 'Full legal name of the reviewer.',
    `revision_summary` STRING COMMENT 'Narrative description of any changes made to the policy.',
    `risk_level` STRING COMMENT 'Assessed risk severity associated with the policy after review.. Valid values are `low|medium|high|critical`',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the approver signed off the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    CONSTRAINT pk_policy_review PRIMARY KEY(`policy_review_id`)
) COMMENT 'Transactional record for each scheduled or ad-hoc review of a compliance policy document. Captures review date, reviewer, review type (annual, triggered, regulatory change), review outcome (approved as-is, revised, retired), revision summary, next review date, and approver sign-off. Ensures compliance policies remain current with evolving regulatory requirements from CMS, OCR, NAIC, and state DOIs. Links to the parent policy document and maintains the version history required for NCQA and URAC accreditation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key for training_program',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Compliance training programs are mandated by specific regulatory obligations (e.g., HIPAA Privacy training mandated by 45 CFR 164.530(b), FWA training mandated by CMS). training_program has regulator',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the training program.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the external training vendor.',
    `accessibility_features` STRING COMMENT 'Description of accessibility accommodations (e.g., captions, screen‑reader support).',
    `assessment_type` STRING COMMENT 'Type of assessment used to evaluate participants.. Valid values are `quiz|exam|survey`',
    `attachment_count` STRING COMMENT 'Number of supporting documents or files attached to the program record.',
    `attempt_interval_days` STRING COMMENT 'Minimum number of days required between assessment attempts.',
    `certificate_identifier` STRING COMMENT 'Unique identifier of the certificate issued upon successful completion.',
    `certification_required` BOOLEAN COMMENT 'True if successful completion awards a certification or attestation.',
    `completion_deadline` DATE COMMENT 'Date by which participants must complete the training.',
    `compliance_category` STRING COMMENT 'Broad compliance domain the training addresses.. Valid values are `privacy|security|fraud|quality|regulatory`',
    `content_version` STRING COMMENT 'Version of the training content or materials associated with the program.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost to the organization for delivering the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training program record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_method` STRING COMMENT 'Primary method used to deliver the training (online, instructor‑led, blended, self‑paced).. Valid values are `online|instructor_led|blended|self_paced`',
    `training_program_description` STRING COMMENT 'Detailed narrative describing the content and objectives of the program.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the training program becomes effective and available for enrollment.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the training program is retired or no longer offered (nullable for open‑ended).',
    `external_provider_name` STRING COMMENT 'Name of the third‑party vendor providing the training.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CareTeam)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `format` STRING COMMENT 'Format of the training material (video, document, quiz, simulation, webinar).. Valid values are `video|document|quiz|simulation|webinar`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the program has been archived and is no longer active.',
    `is_external_provider` BOOLEAN COMMENT 'True if the training is delivered by an external vendor.',
    `language` STRING COMMENT 'Primary language of the training content.',
    `last_review_date` DATE COMMENT 'Date when the training content was last reviewed for relevance and compliance.',
    `last_updated_by` STRING COMMENT 'User identifier of the person who performed the most recent update.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training is mandatory for the target audience.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_attempts` STRING COMMENT 'Maximum number of times a participant may attempt the assessment.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the program.',
    `owner_role` STRING COMMENT 'Role of the owner within the organization.. Valid values are `compliance_officer|hr|training_manager`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the assessment, expressed as a percentage.',
    `passing_score_unit` STRING COMMENT 'Unit of measure for the passing score (percent).. Valid values are `percent`',
    `program_code` STRING COMMENT 'Business identifier or catalog code for the training program.',
    `program_name` STRING COMMENT 'Human‑readable name of the training program.',
    `program_type` STRING COMMENT 'Classification of the program by regulatory or business mandate.. Valid values are `hipaa|fwa|aca|code_of_conduct|cultural_competency|other`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_mandate` STRING COMMENT 'Regulatory requirement that drives the need for the training.. Valid values are `HIPAA|CMS_FWA|ACA|NCQA|URAC`',
    `review_frequency_months` STRING COMMENT 'Scheduled interval in months for periodic content review.',
    `risk_level` STRING COMMENT 'Risk rating associated with non‑completion of the training.. Valid values are `low|medium|high|critical`',
    `target_audience` STRING COMMENT 'Intended audience for the training program.. Valid values are `employee|delegate|provider|contractor|management`',
    `training_hours` DECIMAL(18,2) COMMENT 'Estimated total duration of the training program in hours.',
    `training_program_status` STRING COMMENT 'Current lifecycle status of the training program.. Valid values are `active|inactive|retired|draft|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training program record.',
    `version_number` STRING COMMENT 'Version identifier for the overall program (e.g., v1.0, v2.1).',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Master record for each compliance training program required of health plan employees and delegates — annual HIPAA training, FWA training (CMS-mandated for Medicare plans), ACA compliance training, cultural competency training, and code of conduct training. Captures training program name, training type, regulatory mandate, target audience, training format (online, instructor-led, attestation), completion deadline, passing score threshold, and training content version. Includes individual completion tracking: employee/delegate identifier, completion date, assessment score, pass/fail status, certificate identifier, delivery method, and attestation of understanding. Supports CMS FWA training compliance reporting, NCQA workforce training audits, and HIPAA workforce training documentation requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'System-generated unique identifier for the training completion record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or delegate who completed the training.',
    `training_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the record.',
    `training_program_id` BIGINT COMMENT 'Identifier of the training program or course.',
    `training_trainee_employee_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the training assessment, expressed as a percentage.',
    `attestation_text` STRING COMMENT 'Employees signed statement confirming understanding of the training material.',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date‑time when the attestation was recorded.',
    `certificate_number` STRING COMMENT 'Identifier of the issued training certificate, if any.',
    `certificate_url` STRING COMMENT 'Link to the electronic copy of the training certificate.',
    `completion_number` STRING COMMENT 'Human‑readable identifier assigned to the training completion event.',
    `completion_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee completed the training.',
    `compliance_requirements_met_flag` BOOLEAN COMMENT 'True when the training satisfies all applicable compliance requirements.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the training session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training completion record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_method` STRING COMMENT 'Method used to deliver the training (e.g., online, classroom).. Valid values are `online|classroom|virtual|self_paced`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the training certificate expires, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hours_completed` DECIMAL(18,2) COMMENT 'Number of training hours the employee completed.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_external_training` BOOLEAN COMMENT 'Indicates whether the training was delivered by an external vendor.',
    `location` STRING COMMENT 'Physical or virtual location where the training took place.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training completion.',
    `pass_fail_status` STRING COMMENT 'Result of the assessment indicating whether the employee passed or failed.. Valid values are `pass|fail`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or guidance (e.g., CMS‑FWA‑2023) that mandates the training.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the training must be renewed before the expiration date.',
    `scheduled_date` DATE COMMENT 'Planned date on which the training was scheduled to occur.',
    `total_hours_required` DECIMAL(18,2) COMMENT 'Total number of hours required for the training program.',
    `training_category` STRING COMMENT 'Regulatory or compliance category the training satisfies.. Valid values are `hipaa|fwa|ncqa|erisa|state|other`',
    `training_completion_status` STRING COMMENT 'Current lifecycle status of the training record.. Valid values are `pending|completed|failed|revoked`',
    `training_type` STRING COMMENT 'Classification of the training (e.g., mandatory, optional, refresher).. Valid values are `mandatory|optional|refresher`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training completion record.',
    `vendor_name` STRING COMMENT 'Name of the external vendor providing the training, if applicable.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record tracking individual employee or delegate completion of mandatory compliance training programs. Captures employee or delegate identifier, training program, completion date, assessment score, pass/fail status, certificate identifier, training delivery method, and attestation of understanding. Supports CMS FWA training compliance reporting, NCQA workforce training audits, and HIPAA workforce training documentation requirements. Enables compliance officers to identify and remediate training gaps.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` (
    `employee_screening_id` BIGINT COMMENT 'Unique surrogate key for each screening transaction.',
    `compliance_attestation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_attestation. Business justification: Employee screenings are often triggered by a compliance attestation; linking records the originating attestation.',
    `created_timestamp` TIMESTAMP COMMENT 'When the screening record was first inserted into the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_screening_status` STRING COMMENT 'Current state of the screening (e.g., pending, completed, reviewed, rejected).. Valid values are `pending|completed|reviewed|rejected`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'True if the screened subject is high‑risk (e.g., senior executive, high‑volume provider).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `match_detail` STRING COMMENT 'Narrative or code describing the nature of the match, including reference IDs from the source list.',
    `notes` STRING COMMENT 'Additional comments, observations, or rationale related to the screening.',
    `performed_by` STRING COMMENT 'Employee ID of the staff member who executed the screening.',
    `performed_by_name` STRING COMMENT 'Legal name of the staff member who performed the screening.',
    `re_screening_due_date` DATE COMMENT 'Scheduled date for the next mandatory screening of the same subject.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_action` STRING COMMENT 'Business decision taken after a match is identified (e.g., investigate further, escalate to compliance, clear the record, terminate employment).. Valid values are `none|investigate|escalate|clear|terminate`',
    `resolution_date` DATE COMMENT 'When the chosen resolution action was finalized.',
    `screening_reference` STRING COMMENT 'Business identifier used to track the screening transaction across systems.',
    `screening_result` STRING COMMENT 'Outcome of the screening: clear (no match), match (definite match), or potential_match (possible match requiring review).. Valid values are `clear|match|potential_match`',
    `screening_source` STRING COMMENT 'Origin of the exclusion/debarment list (e.g., OIG LEIE, SAM, state Medicaid exclusion list).. Valid values are `OIG_LEIE|SAM|STATE_MEDICAID|CMS|OTHER`',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time the screening activity occurred.',
    `source_reference` STRING COMMENT 'Unique identifier assigned by the external exclusion or debarment list for the matched record.',
    `subject_identifier` STRING COMMENT 'Unique identifier for the person or entity that was screened.',
    `subject_type` STRING COMMENT 'Indicates whether the screened party is an employee, provider, vendor, or delegate.. Valid values are `employee|provider|vendor|delegate`',
    `updated_timestamp` TIMESTAMP COMMENT 'When the screening record was most recently modified.',
    CONSTRAINT pk_employee_screening PRIMARY KEY(`employee_screening_id`)
) COMMENT 'Transactional record for each OIG (Office of Inspector General) exclusion list and SAM (System for Award Management) debarment screening performed on employees, providers, vendors, and delegates. Captures screening subject type, subject identifier, screening date, screening source (OIG LEIE, SAM, state Medicaid exclusion lists), screening result (clear, match, potential match), match details, resolution action, and re-screening due date. CMS requires monthly screening of all employees and providers participating in Medicare and Medicaid programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` (
    `erisa_filing_id` BIGINT COMMENT 'Unique surrogate key for the ERISA filing record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: ERISA filings are required for specific regulatory obligations; linking provides obligation context.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer responsible for the filing.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group (self-funded client) associated with the filing.',
    `acceptance_date` DATE COMMENT 'Date the regulator accepted the filing as compliant.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the filing.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the detailed audit trail for this filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fee_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the filing fee.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_date` DATE COMMENT 'Date the filing was actually submitted to the regulator.',
    `filing_description` STRING COMMENT 'Free‑text description of the filing purpose or special circumstances.',
    `filing_due_date` DATE COMMENT 'The statutory deadline by which the filing must be submitted.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulator for the filing.',
    `filing_method` STRING COMMENT 'Method used to submit the filing.. Valid values are `electronic|paper|fax`',
    `filing_period_end` DATE COMMENT 'End date of the period covered by the filing.',
    `filing_period_start` DATE COMMENT 'Start date of the period covered by the filing.',
    `filing_status` STRING COMMENT 'Current processing status of the filing with the regulator.. Valid values are `pending|submitted|accepted|rejected|withdrawn|closed`',
    `filing_type` STRING COMMENT 'Type of ERISA filing required by the Department of Labor.. Valid values are `Form_5500|Summary_Annual_Report|Summary_Plan_Description|COBRA_Notice|QMCSO_Response`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the filing is considered critical for compliance.',
    `is_fwa_monitoring` BOOLEAN COMMENT 'Indicates whether the filing is part of fraud, waste, and abuse monitoring.',
    `last_reminder_sent_date` DATE COMMENT 'Date the most recent reminder about the filing due date was sent.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional comments or notes related to the filing.',
    `plan_year` STRING COMMENT 'The plan year to which the filing pertains.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulator_acknowledged_date` DATE COMMENT 'Date the regulator confirmed receipt of the filing.',
    `regulator_acknowledged_flag` BOOLEAN COMMENT 'Indicates whether the regulator has acknowledged the filing.',
    `regulatory_body` STRING COMMENT 'Government agency responsible for the filing.. Valid values are `DOL|IRS|CMS|State_DOI`',
    `regulatory_reference` STRING COMMENT 'Citation to the specific ERISA regulation or statute governing the filing.',
    `rejection_reason_code` STRING COMMENT 'Code representing the reason for filing rejection, if applicable.',
    `reminder_schedule` STRING COMMENT 'Frequency at which reminder notifications are generated.. Valid values are `none|weekly|biweekly|monthly`',
    `risk_level` STRING COMMENT 'Risk rating associated with the filing based on compliance impact.. Valid values are `low|medium|high|critical`',
    `submission_number` STRING COMMENT 'Unique identifier assigned by the regulator to the filing submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    `version_number` STRING COMMENT 'Version of the filing record for audit purposes.',
    CONSTRAINT pk_erisa_filing PRIMARY KEY(`erisa_filing_id`)
) COMMENT 'Transactional record for each ERISA-related filing and reporting obligation for self-funded employer group health plans administered by the health plan as TPA or ASO. Captures filing type (Form 5500, Summary Annual Report, Summary Plan Description, COBRA notices, QMCSO responses), plan year, employer group identifier, filing due date, filing date, filing status, and regulatory confirmation. Supports ERISA compliance for ASO/TPA clients and tracks DOL reporting obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` (
    `state_fair_hearing_id` BIGINT COMMENT 'Primary key for state_fair_hearing',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: State fair hearings are filed in response to regulatory obligations; linking enables obligation‑level tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the hearing officer assigned to the case.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the Medicaid member filing the hearing request.',
    `adverse_action_type` STRING COMMENT 'Type of adverse benefit determination prompting the hearing request.. Valid values are `denial|reduction|termination|no_action`',
    `appeal_filed_date` DATE COMMENT 'Date the appeal was filed after the hearing.',
    `appeal_filed_flag` BOOLEAN COMMENT 'True if the member filed an appeal following the hearing outcome.',
    `attachment_url` STRING COMMENT 'Link to supporting documents attached to the hearing request.',
    `compliance_deadline_met` BOOLEAN COMMENT 'Indicates whether the implementation deadline was met.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hearing_date` DATE COMMENT 'Date on which the fair hearing took place.',
    `hearing_duration_minutes` STRING COMMENT 'Length of the hearing in minutes.',
    `hearing_location` STRING COMMENT 'Physical or virtual location where the hearing was conducted.',
    `hearing_officer_name` STRING COMMENT 'Full name of the hearing officer.',
    `hearing_outcome` STRING COMMENT 'Result of the hearing regarding the adverse action.. Valid values are `upheld|reversed|settlement|dismissed|withdrawn`',
    `hearing_request_number` STRING COMMENT 'External reference number assigned to the fair hearing request.',
    `hearing_type` STRING COMMENT 'Mode of the hearing delivery.. Valid values are `in_person|virtual|phone`',
    `implementation_deadline` DATE COMMENT 'Date by which the outcome must be implemented per regulatory timelines.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates if the hearing request is considered critical for compliance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_dob` DATE COMMENT 'Date of birth of the member filing the hearing.',
    `member_name` STRING COMMENT 'Full legal name of the member filing the hearing request.',
    `member_state` STRING COMMENT 'State of residence of the member.',
    `notes` STRING COMMENT 'Free-text notes related to the hearing request.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Citation to the regulatory rule governing the hearing (e.g., 42 CFR §438.400).',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the fair hearing request was received.',
    `state_agency_code` STRING COMMENT 'Code of the state agency handling the fair hearing.',
    `state_fair_hearing_status` STRING COMMENT 'Current processing status of the hearing request.. Valid values are `pending|scheduled|completed|closed|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_state_fair_hearing PRIMARY KEY(`state_fair_hearing_id`)
) COMMENT 'Master record for each state fair hearing request filed by a Medicaid member challenging an adverse benefit determination — denial of services, reduction of benefits, termination of coverage, or failure to act on a request. Captures member identifier, hearing request date, adverse action type, state agency, hearing officer, hearing date, hearing outcome, and implementation deadline. Tracks compliance with state Medicaid fair hearing regulations and CMS managed care final rule timelines (42 CFR §438.400). Distinct from the appeal domain which manages internal and external appeals.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory change record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: A regulatory change (new legislation, rule update) directly impacts specific regulatory obligations the health plan must fulfill. This FK links each change to its primary affected obligation, enabling',
    `employee_id` BIGINT COMMENT 'Identifier of the internal party responsible for implementing the change.',
    `prior_regulation_regulatory_change_id` BIGINT COMMENT 'Reference to the previous version of this regulation, if any.',
    `amendment_number` STRING COMMENT 'Sequential amendment identifier if the regulation has been amended.',
    `change_category` STRING COMMENT 'Broad category of the regulatory change (e.g., policy, rate, coverage, eligibility, process, technology, reporting). [ENUM-REF-CANDIDATE: policy|rate|coverage|eligibility|process|technology|reporting — promote to reference product]',
    `compliance_area` STRING COMMENT 'Primary compliance domain affected by the change.. Valid values are `privacy|security|financial|clinical|operational`',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline for achieving compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date the regulation becomes legally effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date the regulation expires or is superseded, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `governing_body` STRING COMMENT 'Regulatory authority that issued the change (e.g., CMS, HHS, NAIC, OCR, NCQA, URAC, Joint Commission, AMA, WHO).',
    `impact_assessment` STRING COMMENT 'Narrative assessment of operational and financial impact.',
    `impacted_business_areas` STRING COMMENT 'Comma‑separated list of business domains impacted (e.g., enrollment, claims, billing, provider network).',
    `implementation_status` STRING COMMENT 'Current progress of the implementation effort.. Valid values are `not_started|in_progress|completed|deferred|cancelled`',
    `implementation_target_date` DATE COMMENT 'Planned date by which implementation should be completed.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the change is deemed critical for business operations.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction affected (e.g., USA, CA, TX).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the change.',
    `publication_date` DATE COMMENT 'Date the regulation was officially published.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulation_code` STRING COMMENT 'Official code or identifier assigned by the governing body (e.g., CMS‑2023‑01).',
    `regulation_name` STRING COMMENT 'Human‑readable title of the regulation or rule change.',
    `regulation_type` STRING COMMENT 'Classification of the regulation by its scope.. Valid values are `federal|state|local|international|industry|internal`',
    `regulatory_change_status` STRING COMMENT 'Current lifecycle status of the regulation.. Valid values are `draft|proposed|final|active|repealed|expired`',
    `regulatory_reference_url` STRING COMMENT 'Link to the official regulatory document or notice.',
    `reporting_frequency_months` STRING COMMENT 'How often ongoing reporting is required for this regulation.',
    `required_response_actions` STRING COMMENT 'Summary of actions the organization must take to comply (e.g., system update, policy revision).',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating (0‑100) associated with non‑compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Sequential version of the regulatory change record.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Master record tracking regulatory changes, new legislation, and rule updates that impact the health plans compliance obligations — CMS final rules, ACA regulatory updates, state DOI bulletins, HIPAA amendments, NAIC model law adoptions, and IRS guidance on HSA/FSA/HRA. Captures regulatory body, regulation name, publication date, effective date, impacted business areas, required response actions, implementation owner, and implementation status. Enables proactive compliance management and regulatory impact assessment across the enterprise.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` (
    `breach_report_id` BIGINT COMMENT 'Primary key for breach_report',
    `audit_finding_id` BIGINT COMMENT 'Identifier for the audit finding related to the breach.',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier for the corrective action plan associated with the breach.',
    `parent_breach_report_id` BIGINT COMMENT 'Self-referencing FK on breach_report (parent_breach_report_id)',
    `affected_entity_description` STRING COMMENT 'Description of the affected entity.',
    `affected_entity_type` STRING COMMENT 'Type of entity affected by the breach.',
    `audit_finding_date` DATE COMMENT 'Date when the audit finding was recorded.',
    `audit_finding_description` STRING COMMENT 'Description of the audit finding.',
    `audit_finding_status` STRING COMMENT 'Current status of the audit finding.',
    `breach_amount` DECIMAL(18,2) COMMENT 'Monetary value of the breach impact.',
    `breach_category` STRING COMMENT 'Category of data affected by the breach.',
    `breach_cause` STRING COMMENT 'Root cause of the breach.',
    `breach_currency` STRING COMMENT 'Currency code for breach_amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CHF|CAD|AUD|NZD|CNY|HKD — promote to reference product]',
    `breach_date` DATE COMMENT 'Date when the breach event occurred.',
    `breach_description` STRING COMMENT 'Detailed description of the breach event.',
    `breach_initiated_by` STRING COMMENT 'Entity that initiated the breach event.',
    `breach_initiated_by_contact_email` STRING COMMENT 'Email address of the contact who reported or initiated the breach.',
    `breach_initiated_by_contact_name` STRING COMMENT 'Full name of the contact who reported or initiated the breach.',
    `breach_initiated_by_contact_phone` STRING COMMENT 'Phone number of the contact who reported or initiated the breach.',
    `breach_initiated_by_contact_type` STRING COMMENT 'Role of the contact who reported or initiated the breach.',
    `breach_location` STRING COMMENT 'Physical or logical location where the breach occurred.',
    `breach_report_status` STRING COMMENT '',
    `breach_severity` STRING COMMENT 'Severity level of the breach.',
    `breach_type` STRING COMMENT 'Nature of the breach event.',
    `cap_action_description` STRING COMMENT 'Description of actions taken in the corrective action plan.',
    `cap_completion_date` DATE COMMENT 'Date when the corrective action plan was completed.',
    `cap_status` STRING COMMENT 'Current status of the corrective action plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach report record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT '',
    `notification_date` DATE COMMENT 'Date when the breach notification was sent.',
    `notification_method` STRING COMMENT 'Method used to send the breach notification.',
    `notification_reference` STRING COMMENT 'Reference number or identifier for the notification.',
    `notification_status` STRING COMMENT 'Current status of the breach notification.',
    `number_of_affected_individuals` STRING COMMENT 'Count of individuals impacted by the breach.',
    `number_of_records_affected` STRING COMMENT '',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Regulatory body overseeing the breach reporting. [ENUM-REF-CANDIDATE: HIPAA|ACA|CMS|NCQA|URAC|SOC|FWA|ERISA — promote to reference product]',
    `regulatory_filing_date` DATE COMMENT 'Date when the breach was filed with the regulatory body.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing.',
    `regulatory_filing_status` STRING COMMENT 'Current status of the regulatory filing.',
    `regulatory_reference` STRING COMMENT '',
    `report_date` DATE COMMENT 'Date when the report was generated.',
    `report_name` STRING COMMENT 'Human-readable name of the breach report.',
    `report_number` STRING COMMENT 'Externally-known number or code for the breach report.',
    `report_status` STRING COMMENT 'Current lifecycle status of the report.',
    `report_type` STRING COMMENT 'Classification of the report type, e.g., incident, audit, investigation.',
    `reported_by` STRING COMMENT '',
    `reported_date` DATE COMMENT '',
    `resolution_date` DATE COMMENT '',
    `resolution_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach report record was last updated.',
    CONSTRAINT pk_breach_report PRIMARY KEY(`breach_report_id`)
) COMMENT 'Master reference table for breach_report. Referenced by breach_report_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Primary key for regulatory_obligation',
    `compliance_regulatory_obligation_id` BIGINT COMMENT 'SSOT primary key',
    `legal_entity_id` BIGINT COMMENT 'Regulator legal entity',
    `regulatory_change_id` BIGINT COMMENT 'add column regulatory_change_id (BIGINT) with FK to compliance.regulatory_change.regulatory_change_id - regulatory obligations originate from regulatory changes (currently isolated)',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `domain_scope` STRING COMMENT 'Domain scope of obligation',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Regulatory Obligation entity for compliance domain [P210 skipped: target-product-missing:compliance.compliance_regulatory_obligation renamed to compliance.regulatory_obligation per VREQ-004]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` (
    `compliance_attestation_id` BIGINT COMMENT 'SSOT primary key',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - attestations are signed by employees (currently isolated)',
    `policy_document_id` BIGINT COMMENT 'Related policy document',
    `regulatory_obligation_id` BIGINT COMMENT 'Related obligation',
    `credential_attestation_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_compliance_attestation PRIMARY KEY(`compliance_attestation_id`)
) COMMENT 'Attestation entity for compliance domain [P208 skipped: target-product-missing:compliance.compliance_attestation renamed to compliance.attestation per VREQ-005]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ADD CONSTRAINT `fk_compliance_cap_milestone_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_breach_report_id` FOREIGN KEY (`breach_report_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_report`(`breach_report_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_breach_incident_id` FOREIGN KEY (`breach_incident_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_incident`(`breach_incident_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_hipaa_privacy_request_id` FOREIGN KEY (`hipaa_privacy_request_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request`(`hipaa_privacy_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`fwa_case`(`fwa_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ADD CONSTRAINT `fk_compliance_accreditation_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ADD CONSTRAINT `fk_compliance_policy_review_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ADD CONSTRAINT `fk_compliance_employee_screening_compliance_attestation_id` FOREIGN KEY (`compliance_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`compliance_attestation`(`compliance_attestation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ADD CONSTRAINT `fk_compliance_erisa_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ADD CONSTRAINT `fk_compliance_state_fair_hearing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_prior_regulation_regulatory_change_id` FOREIGN KEY (`prior_regulation_regulatory_change_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_parent_breach_report_id` FOREIGN KEY (`parent_breach_report_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_report`(`breach_report_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_compliance_regulatory_obligation_id` FOREIGN KEY (`compliance_regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ADD CONSTRAINT `fk_compliance_compliance_attestation_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ADD CONSTRAINT `fk_compliance_compliance_attestation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `confirmation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_end` SET TAGS ('pii_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_start` SET TAGS ('pii_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Submission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('pii_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `net_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'CMS|STATE_DOI|NCQA|OCR|ERISA|DOL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_value_regex' = 'scheduled|draft|submitted|accepted|rejected|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reminder_schedule` SET TAGS ('pii_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('pii_business_glossary_term' = 'Submission Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'edi|portal|paper|email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'annual_notice|rate_filing|financial_statement|accreditation|breach_notification|mlr_report');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Follow-up Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('pii_business_glossary_term' = 'Auditing Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('pii_value_regex' = 'CMS|OCR|NCQA|URAC|State_DOI|Internal');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('pii_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('pii_value_regex' = 'financial|operational|clinical|IT|security');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_actual` SET TAGS ('pii_business_glossary_term' = 'Audit Cost Actual');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Audit Cost Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('pii_business_glossary_term' = 'Audit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_document_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_findings_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_followup_required` SET TAGS ('pii_business_glossary_term' = 'Audit Follow-up Required');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_location` SET TAGS ('pii_business_glossary_term' = 'Audit Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_methodology` SET TAGS ('pii_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_end` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_start` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('pii_business_glossary_term' = 'Audit Priority');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_report_release_date` SET TAGS ('pii_business_glossary_term' = 'Audit Report Release Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'regulatory|financial|operational|internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('pii_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State_DOI');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `critical_findings` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('pii_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('pii_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `minor_findings` SET TAGS ('pii_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('pii_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('pii_value_regex' = 'favorable|unfavorable|conditional|pending');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Plan Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('pii_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `significant_findings` SET TAGS ('pii_business_glossary_term' = 'Significant Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `total_findings` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Identifier (CLM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor Identifier (AUD_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('pii_business_glossary_term' = 'Affected Business Area (BUS_AREA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('pii_value_regex' = 'claims|billing|provider_network|member_services|care_management|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('pii_business_glossary_term' = 'Audit Category (CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('pii_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('pii_business_glossary_term' = 'Finding Status (STAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('pii_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Finding Closed Timestamp (CLS_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('pii_business_glossary_term' = 'Compliance Area (COMP_AREA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('pii_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completion Date (CA_CMPL_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status (CA_STAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (CRT_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description (DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date (DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Assessment (EFF_ASMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('pii_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_score` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Score (EFF_SCR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `evidence_document_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Document Reference (EVD_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount (FIN_IMP_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Currency (FIN_IMP_CUR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('pii_business_glossary_term' = 'Finding Number (FND)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type (FND_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'condition|cause|effect');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `identified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Finding Identified Timestamp (ID_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag (CRIT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('pii_business_glossary_term' = 'Repeat Finding Flag (REPEAT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp (LRV_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Finding Priority (PRIO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation (CIT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `related_policy_number` SET TAGS ('pii_business_glossary_term' = 'Related Policy Number (POL_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `related_policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `related_system` SET TAGS ('pii_business_glossary_term' = 'Related System (SYS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `remediation_action` SET TAGS ('pii_business_glossary_term' = 'Remediation Action (RM_ACT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date (RM_DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('pii_business_glossary_term' = 'Finding Resolution (RES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('pii_value_regex' = 'remediated|waived|deferred|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By Identifier (RVW_BY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (RSK_SCR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('pii_business_glossary_term' = 'Risk Score Source (RSK_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('pii_value_regex' = 'internal|external|model');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level (SEV)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|significant|minor');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Finding Source (SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'internal_audit|external_audit|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `tags` SET TAGS ('pii_business_glossary_term' = 'Finding Tags (TAG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (UPD_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Finding Version (VER)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'CAP Owner ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('pii_business_glossary_term' = 'Actual CAP Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_comments` SET TAGS ('pii_business_glossary_term' = 'Audit Comments');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'CAP Closed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'privacy|security|financial|clinical|operational');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_deadline` SET TAGS ('pii_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_value_regex' = 'draft|submitted|in_progress|completed|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'CAP Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('pii_business_glossary_term' = 'Estimated CAP Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `evidence_document_path` SET TAGS ('pii_business_glossary_term' = 'Evidence Document Path');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_external_audit` SET TAGS ('pii_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_fwa_monitoring` SET TAGS ('pii_business_glossary_term' = 'Fraud Waste Abuse Monitoring Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('pii_business_glossary_term' = 'Last Milestone Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `milestone_count` SET TAGS ('pii_business_glossary_term' = 'Number of Milestones');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'CAP General Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'CAP Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('pii_value_regex' = 'compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'audit|regulatory|operational|clinical|financial');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'CAP Priority');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `remediation_strategy` SET TAGS ('pii_business_glossary_term' = 'Remediation Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'CAP Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'CAP Severity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('pii_value_regex' = 'minor|moderate|major|severe');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'CAP Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_id` SET TAGS ('pii_business_glossary_term' = 'Cap Milestone ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Milestone Owner ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Milestone Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_status` SET TAGS ('pii_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `cap_milestone_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|blocked|deferred|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `escalated_flag` SET TAGS ('pii_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `evidence_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_code` SET TAGS ('pii_business_glossary_term' = 'Milestone Code (Unique Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_description` SET TAGS ('pii_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_name` SET TAGS ('pii_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_type` SET TAGS ('pii_business_glossary_term' = 'Milestone Type (e.g., Documentation, Training, Process Change, System Update, Audit, Review)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_type` SET TAGS ('pii_value_regex' = 'documentation|training|process_change|system_update|audit|review');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Milestone Priority');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_id` SET TAGS ('pii_business_glossary_term' = 'Breach Incident Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `baa_id` SET TAGS ('pii_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_report_id` SET TAGS ('pii_business_glossary_term' = 'External Breach Report ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Incident Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('pii_business_glossary_term' = 'Affected PHI Categories');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('pii_business_glossary_term' = 'Audit Findings');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('pii_business_glossary_term' = 'Breach Cause Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_discovery_date` SET TAGS ('pii_business_glossary_term' = 'Breach Discovery Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_number` SET TAGS ('pii_business_glossary_term' = 'Breach Incident Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_occurrence_date` SET TAGS ('pii_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_report_url` SET TAGS ('pii_business_glossary_term' = 'External Breach Report URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Breach Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('pii_business_glossary_term' = 'Breach Source');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('pii_value_regex' = 'internal|external|partner|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('pii_business_glossary_term' = 'Breach Status (Lifecycle)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('pii_value_regex' = 'open|investigating|closed|pending|resolved');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('pii_business_glossary_term' = 'Breach Type (Category)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('pii_value_regex' = 'unauthorized_access|theft|loss|improper_disposal|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `business_associate_involved` SET TAGS ('pii_business_glossary_term' = 'Business Associate Involved');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notification_date` SET TAGS ('pii_business_glossary_term' = 'HHS Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notified` SET TAGS ('pii_business_glossary_term' = 'HHS Notified');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_content_version` SET TAGS ('pii_business_glossary_term' = 'Notification Content Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_delivery_confirmation` SET TAGS ('pii_business_glossary_term' = 'Notification Delivery Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'mail|email|substitute_notice|phone|fax');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('pii_business_glossary_term' = 'Notification Obligation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('pii_value_regex' = 'individual|hhs|state|media|none');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_recipient_count` SET TAGS ('pii_business_glossary_term' = 'Notification Recipient Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('pii_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('pii_value_regex' = 'individual|hhs|state|media');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `number_of_individuals_affected` SET TAGS ('pii_business_glossary_term' = 'Number of Individuals Affected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `number_of_records_affected` SET TAGS ('pii_business_glossary_term' = 'Number of Records Affected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('pii_value_regex' = 'not_filed|filed|rejected|accepted');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('pii_value_regex' = 'qualitative|quantitative|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notification_date` SET TAGS ('pii_business_glossary_term' = 'State Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notified` SET TAGS ('pii_business_glossary_term' = 'State Notified');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_notification_id` SET TAGS ('pii_business_glossary_term' = 'Breach Notification ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_incident_id` SET TAGS ('pii_business_glossary_term' = 'Breach Incident ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Notification Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `affected_member_count` SET TAGS ('pii_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `affected_provider_count` SET TAGS ('pii_business_glossary_term' = 'Affected Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_category` SET TAGS ('pii_business_glossary_term' = 'Breach Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_category` SET TAGS ('pii_value_regex' = 'unauthorized_access|theft|loss|improper_disclosure|hacking|malware');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Breach Disclosure Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_discovery_date` SET TAGS ('pii_business_glossary_term' = 'Breach Discovery Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `breach_notification_status` SET TAGS ('pii_value_regex' = 'draft|sent|failed|cancelled|archived');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `content_version` SET TAGS ('pii_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `deadline_date` SET TAGS ('pii_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `deadline_met` SET TAGS ('pii_business_glossary_term' = 'Deadline Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `delivery_confirmation` SET TAGS ('pii_business_glossary_term' = 'Delivery Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `media_outlet_name` SET TAGS ('pii_business_glossary_term' = 'Media Outlet Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_content_hash` SET TAGS ('pii_business_glossary_term' = 'Notification Content Hash');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'mail|email|substitute_notice|fax|phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_business_glossary_term' = 'Notification Type (Individual, HHS, Media, State Regulator)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_value_regex' = 'individual|hhs|media|state_regulator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `number_of_recipients` SET TAGS ('pii_business_glossary_term' = 'Number of Recipients');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `regulatory_body_notified` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body Notified');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `regulatory_body_notified` SET TAGS ('pii_value_regex' = 'hhs|ocr|state|media');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `hipaa_privacy_request_id` SET TAGS ('pii_business_glossary_term' = 'HIPAA Privacy Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processing Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|reversed|denied|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('pii_business_glossary_term' = 'Disclosure Authorization Basis');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('pii_value_regex' = 'patient_authorization|legal_requirement|public_interest|court_order');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_logged` SET TAGS ('pii_business_glossary_term' = 'Disclosure Logged Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_phicategories` SET TAGS ('pii_business_glossary_term' = 'Disclosed PHI Categories');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_purpose` SET TAGS ('pii_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('pii_business_glossary_term' = 'Disclosure Recipient Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('pii_value_regex' = 'public_health|law_enforcement|research|legal|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Request Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_appealed` SET TAGS ('pii_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_confidential_communication` SET TAGS ('pii_business_glossary_term' = 'Confidential Communication Request');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('pii_business_glossary_term' = 'Request Channel');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('pii_value_regex' = 'digital|paper|phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_description` SET TAGS ('pii_business_glossary_term' = 'Request Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('pii_business_glossary_term' = 'Request Source');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('pii_value_regex' = 'portal|email|phone|fax|mail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('pii_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('pii_value_regex' = 'pending|in_review|completed|denied|partially_granted|closed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('pii_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('pii_value_regex' = 'access|amendment|accounting|restriction|confidential_communication');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `phi_disclosure_log_id` SET TAGS ('pii_business_glossary_term' = 'PHI Disclosure Log ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `hipaa_privacy_request_id` SET TAGS ('pii_business_glossary_term' = 'Disclosure Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `policy_document_id` SET TAGS ('pii_business_glossary_term' = 'Reference Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `authorization_basis` SET TAGS ('pii_business_glossary_term' = 'Authorization Basis');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `authorization_basis` SET TAGS ('pii_value_regex' = 'patient_consent|court_order|public_health_authority|law_enforcement_request|research_approval|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `disclosure_method` SET TAGS ('pii_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `disclosure_method` SET TAGS ('pii_value_regex' = 'electronic|fax|mail|oral|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('pii_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('pii_value_regex' = 'pending|completed|rejected|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `disclosure_timestamp` SET TAGS ('pii_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `is_authorized` SET TAGS ('pii_business_glossary_term' = 'Is Authorized Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `phi_category` SET TAGS ('pii_business_glossary_term' = 'PHI Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `phi_category` SET TAGS ('pii_value_regex' = 'demographics|diagnosis|treatment|payment|eligibility|utilization');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `purpose_of_disclosure` SET TAGS ('pii_business_glossary_term' = 'Purpose of Disclosure');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_type` SET TAGS ('pii_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_type` SET TAGS ('pii_value_regex' = 'public_health|law_enforcement|research|legal|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `baa_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement Identifier (BAA_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Number (AGREEMENT_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `agreement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status (AGREEMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `agreement_status` SET TAGS ('pii_value_regex' = 'active|terminated|pending|draft|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count (AMENDMENT_COUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `audit_rights` SET TAGS ('pii_business_glossary_term' = 'Audit Rights (AUDIT_RIGHTS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `audit_rights` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `breach_notification_requirements` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Requirements (BREACH_NOTIFICATION_REQUIREMENTS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `breach_notification_requirements` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `business_associate_name` SET TAGS ('pii_business_glossary_term' = 'Business Associate Name (BUSINESS_ASSOCIATE_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `business_associate_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `business_associate_type` SET TAGS ('pii_business_glossary_term' = 'Business Associate Type (BUSINESS_ASSOCIATE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `business_associate_type` SET TAGS ('pii_value_regex' = 'vendor|tpa|pbm|clearinghouse|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `data_disposal_method` SET TAGS ('pii_business_glossary_term' = 'Data Disposal Method (DATA_DISPOSAL_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `data_disposal_method` SET TAGS ('pii_value_regex' = 'destroy|deidentify|archive|return|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `data_retention_period_months` SET TAGS ('pii_business_glossary_term' = 'Data Retention Period (MONTHS) (DATA_RETENTION_PERIOD_MONTHS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `governing_law` SET TAGS ('pii_business_glossary_term' = 'Governing Law (GOVERNING_LAW)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date (LAST_AMENDMENT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `permitted_phis` SET TAGS ('pii_business_glossary_term' = 'Permitted PHI Types (PERMITTED_PHIS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `permitted_phis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference (REGULATORY_REFERENCE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Period (DAYS) (RENEWAL_NOTICE_PERIOD_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `renewal_option` SET TAGS ('pii_business_glossary_term' = 'Renewal Option (RENEWAL_OPTION)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `renewal_option` SET TAGS ('pii_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `scope_of_phi_use` SET TAGS ('pii_business_glossary_term' = 'Scope of PHI Use (SCOPE_OF_PHI_USE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `scope_of_phi_use` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `security_obligations` SET TAGS ('pii_business_glossary_term' = 'Security Obligations (SECURITY_OBLIGATIONS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `security_obligations` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `subcontractor_allowed` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Allowed Flag (SUBCONTRACTOR_ALLOWED)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `subcontractor_details` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Details (SUBCONTRACTOR_DETAILS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `subcontractor_details` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `termination_clause` SET TAGS ('pii_business_glossary_term' = 'Termination Clause (TERMINATION_CLAUSE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `termination_clause` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fwa_case_id` SET TAGS ('pii_business_glossary_term' = 'Fraud, Waste, and Abuse Case ID (FWA_CASE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Investigator Identifier (INVESTIGATOR_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `allegation_description` SET TAGS ('pii_business_glossary_term' = 'Allegation Description (ALLEG_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `audit_log_url` SET TAGS ('pii_business_glossary_term' = 'Audit Log URL (AUDIT_LOG_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('pii_business_glossary_term' = 'Case Disposition (CASE_DISP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('pii_value_regex' = 'substantiated|unsubstantiated|law_enforcement|civil_penalty|referred');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Case Number (CASE_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_open_timestamp` SET TAGS ('pii_business_glossary_term' = 'Case Open Timestamp (CASE_OPEN_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Case Status (CASE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('pii_value_regex' = 'open|in_progress|closed|referred|settled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('pii_business_glossary_term' = 'Case Type (CASE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('pii_value_regex' = 'fraud|waste|abuse');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `compliance_reference` SET TAGS ('pii_business_glossary_term' = 'Compliance Reference (COMP_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `disposition_date` SET TAGS ('pii_business_glossary_term' = 'Disposition Date (DISP_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Financial Exposure Amount (EST_EXP_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Reference (EVID_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `is_high_risk` SET TAGS ('pii_business_glossary_term' = 'High Risk Indicator (HIGH_RISK_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Case Notes (CASE_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Recovery Amount (RECOVERY_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'Referral Date (REF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('pii_business_glossary_term' = 'Referral Source (REF_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('pii_value_regex' = 'claim_edit|data_mining|tip_line|law_enforcement|employee_report');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('pii_business_glossary_term' = 'Subject Identifier (SUBJ_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('pii_business_glossary_term' = 'Subject Type (SUBJ_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('pii_value_regex' = 'member|provider|employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('pii_business_glossary_term' = 'Triage Outcome (TRIAGE_OUT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('pii_value_regex' = 'escalated|closed|investigate|dismissed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_id` SET TAGS ('pii_business_glossary_term' = 'Fraud Waste Abuse Referral ID (FWA_REFERRAL_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_case_id` SET TAGS ('pii_business_glossary_term' = 'Associated Case Identifier (CASE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier (EMPLOYEE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `allegation_description` SET TAGS ('pii_business_glossary_term' = 'Allegation Description (ALLEG_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURRENCY_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag (ESCALATION_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `estimated_loss_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Loss Amount (EST_LOSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Reference (EVID_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_status` SET TAGS ('pii_business_glossary_term' = 'Referral Status (REF_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `fwa_referral_status` SET TAGS ('pii_value_regex' = 'new|in_review|assigned|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority (PRIORITY)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'Provider National Provider Identifier (PROVIDER_NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'Referral Date (REF_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_number` SET TAGS ('pii_business_glossary_term' = 'Referral Number (REF_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_source` SET TAGS ('pii_business_glossary_term' = 'Referral Source (REF_SOURCE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_source` SET TAGS ('pii_value_regex' = 'internal_detection|employee|member|provider|external_agency');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_type` SET TAGS ('pii_business_glossary_term' = 'Referral Type (REF_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `referral_type` SET TAGS ('pii_value_regex' = 'fraud|waste|abuse|billing_error|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subject_type` SET TAGS ('pii_business_glossary_term' = 'Subject Type (SUBJ_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subject_type` SET TAGS ('pii_value_regex' = 'member|provider|employee|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `triage_outcome` SET TAGS ('pii_business_glossary_term' = 'Triage Outcome (TRIAGE_OUTCOME)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `triage_outcome` SET TAGS ('pii_value_regex' = 'opened|closed|dismissed|escalated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_id` SET TAGS ('pii_business_glossary_term' = 'Mlr Calculation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Calculated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_reporting_entity_health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_reporting_entity_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_reporting_entity_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `audit_finding_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_date` SET TAGS ('pii_business_glossary_term' = 'MLR Calculation Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_number` SET TAGS ('pii_business_glossary_term' = 'MLR Calculation Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `earned_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Earned Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `incurred_claims_amount` SET TAGS ('pii_business_glossary_term' = 'Incurred Claims Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `market_segment_code` SET TAGS ('pii_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `market_segment_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('pii_business_glossary_term' = 'MLR Calculation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('pii_value_regex' = 'pending|calculated|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_percentage` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'MLR Calculation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `quality_improvement_expenses_amount` SET TAGS ('pii_business_glossary_term' = 'Quality Improvement Expenses Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_amount` SET TAGS ('pii_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Disbursement Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('pii_business_glossary_term' = 'Rebate Disbursement Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('pii_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Rebate Eligibility Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `reporting_year` SET TAGS ('pii_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Record Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_subdomain' = 'accreditation_training');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Business Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accountable_owner` SET TAGS ('pii_business_glossary_term' = 'Accountable Business Owner');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('pii_value_regex' = 'accredited|provisional|denied|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('pii_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('pii_value_regex' = 'health_plan|provider|pharmacy|network|member');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `applicable_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `benchmark_thresholds` SET TAGS ('pii_business_glossary_term' = 'Benchmark Thresholds');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Accreditation Completion Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `conditions` SET TAGS ('pii_business_glossary_term' = 'Accreditation Conditions');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('pii_value_regex' = 'accredited|denied|conditional|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `escalated_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `evidence_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `final_score` SET TAGS ('pii_business_glossary_term' = 'Final Accreditation Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Accreditation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_level` SET TAGS ('pii_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `measure_thresholds` SET TAGS ('pii_business_glossary_term' = 'Measure Thresholds');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `measures` SET TAGS ('pii_business_glossary_term' = 'Accreditation Measures');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `next_survey_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `preliminary_findings` SET TAGS ('pii_business_glossary_term' = 'Preliminary Findings');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Accreditation Rating');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('pii_value_regex' = '1_star|2_star|3_star|4_star|5_star');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Accreditation Recommendations');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `renewal_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Renewal Cycle (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Accreditation Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_end_date` SET TAGS ('pii_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_start_date` SET TAGS ('pii_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'initial|renewal|focused');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('pii_business_glossary_term' = 'Surveyor Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('pii_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_subdomain' = 'accreditation_training');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Survey Conductor Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_value_regex' = 'accredited|conditionally_accredited|not_accredited|pending');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_status` SET TAGS ('pii_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `accreditation_survey_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Survey End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `evidence_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `final_score` SET TAGS ('pii_business_glossary_term' = 'Final Survey Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Survey Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `preliminary_findings` SET TAGS ('pii_business_glossary_term' = 'Preliminary Findings');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Accreditation Rating');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `recommendation` SET TAGS ('pii_business_glossary_term' = 'Accreditation Recommendation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Survey Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Survey Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_location` SET TAGS ('pii_business_glossary_term' = 'Survey Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_method` SET TAGS ('pii_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_method` SET TAGS ('pii_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_number` SET TAGS ('pii_business_glossary_term' = 'Survey Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_region_code` SET TAGS ('pii_business_glossary_term' = 'Survey Region Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_region_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_region_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_scope` SET TAGS ('pii_business_glossary_term' = 'Survey Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'initial|renewal|focused|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('pii_business_glossary_term' = 'Policy Document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Policy Approver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_business_glossary_term' = 'Policy Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Policy Reviewer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Policy Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `archive_date` SET TAGS ('pii_business_glossary_term' = 'Policy Archive Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_document_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `compliance_area` SET TAGS ('pii_business_glossary_term' = 'Compliance Area');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Policy Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('pii_business_glossary_term' = 'Policy Distribution Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `document_format` SET TAGS ('pii_business_glossary_term' = 'Policy Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `document_format` SET TAGS ('pii_value_regex' = 'pdf|docx|html');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `document_size_bytes` SET TAGS ('pii_business_glossary_term' = 'Policy Document Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Policy Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `is_archived` SET TAGS ('pii_business_glossary_term' = 'Is Archived Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Policy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_code` SET TAGS ('pii_business_glossary_term' = 'Policy Document Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Policy Document Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_owner_department` SET TAGS ('pii_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `regulatory_citations` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citations');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Policy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `review_outcome` SET TAGS ('pii_business_glossary_term' = 'Policy Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `review_outcome` SET TAGS ('pii_value_regex' = 'approved|revised|retired');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Policy Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'annual|triggered|regulatory_change');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `revision_summary` SET TAGS ('pii_business_glossary_term' = 'Policy Revision Summary');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `policy_review_id` SET TAGS ('pii_business_glossary_term' = 'Policy Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `policy_document_id` SET TAGS ('pii_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `approver_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'privacy|security|financial|clinical|operational');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `evidence_documentation_url` SET TAGS ('pii_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Review Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'approved_as_is|revised|retired|deferred');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `outcome_date` SET TAGS ('pii_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `policy_version` SET TAGS ('pii_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_duration_days` SET TAGS ('pii_business_glossary_term' = 'Review Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Policy Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_score` SET TAGS ('pii_business_glossary_term' = 'Review Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'annual|triggered|regulatory_change|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `reviewer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `revision_summary` SET TAGS ('pii_business_glossary_term' = 'Revision Summary');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `sign_off_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sign‑Off Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_subdomain' = 'accreditation_training');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('pii_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'External Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `accessibility_features` SET TAGS ('pii_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'quiz|exam|survey');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `attempt_interval_days` SET TAGS ('pii_business_glossary_term' = 'Attempt Interval (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `certificate_identifier` SET TAGS ('pii_business_glossary_term' = 'Certificate Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `certification_required` SET TAGS ('pii_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `completion_deadline` SET TAGS ('pii_business_glossary_term' = 'Completion Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'privacy|security|fraud|quality|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `content_version` SET TAGS ('pii_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `cost_usd` SET TAGS ('pii_business_glossary_term' = 'Program Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'online|instructor_led|blended|self_paced');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `training_program_description` SET TAGS ('pii_business_glossary_term' = 'Training Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `external_provider_name` SET TAGS ('pii_business_glossary_term' = 'External Provider Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Training Format');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `format` SET TAGS ('pii_value_regex' = 'video|document|quiz|simulation|webinar');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `is_archived` SET TAGS ('pii_business_glossary_term' = 'Archived Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `is_external_provider` SET TAGS ('pii_business_glossary_term' = 'External Provider Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `max_attempts` SET TAGS ('pii_business_glossary_term' = 'Maximum Attempts');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `owner_role` SET TAGS ('pii_value_regex' = 'compliance_officer|hr|training_manager');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `passing_score_threshold` SET TAGS ('pii_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `passing_score_unit` SET TAGS ('pii_business_glossary_term' = 'Passing Score Unit');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `passing_score_unit` SET TAGS ('pii_value_regex' = 'percent');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Training Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Training Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Training Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'hipaa|fwa|aca|code_of_conduct|cultural_competency|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `regulatory_mandate` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandate');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `regulatory_mandate` SET TAGS ('pii_value_regex' = 'HIPAA|CMS_FWA|ACA|NCQA|URAC');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `target_audience` SET TAGS ('pii_value_regex' = 'employee|delegate|provider|contractor|management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `training_hours` SET TAGS ('pii_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('pii_business_glossary_term' = 'Training Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Program Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_subdomain' = 'accreditation_training');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_program_id` SET TAGS ('pii_business_glossary_term' = 'Training Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_trainee_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_trainee_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_trainee_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score (Percent)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `attestation_text` SET TAGS ('pii_business_glossary_term' = 'Attestation Text');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `attestation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `certificate_url` SET TAGS ('pii_business_glossary_term' = 'Certificate URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('pii_business_glossary_term' = 'Training Completion Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `compliance_requirements_met_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `cost_usd` SET TAGS ('pii_business_glossary_term' = 'Training Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'online|classroom|virtual|self_paced');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `hours_completed` SET TAGS ('pii_business_glossary_term' = 'Hours Completed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `is_external_training` SET TAGS ('pii_business_glossary_term' = 'External Training Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_value_regex' = 'pass|fail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `total_hours_required` SET TAGS ('pii_business_glossary_term' = 'Total Hours Required');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('pii_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('pii_value_regex' = 'hipaa|fwa|ncqa|erisa|state|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('pii_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('pii_value_regex' = 'pending|completed|failed|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('pii_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('pii_value_regex' = 'mandatory|optional|refresher');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `employee_screening_id` SET TAGS ('pii_business_glossary_term' = 'Employee Screening ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `compliance_attestation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Attestation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `employee_screening_status` SET TAGS ('pii_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `employee_screening_status` SET TAGS ('pii_value_regex' = 'pending|completed|reviewed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Screening Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `match_detail` SET TAGS ('pii_business_glossary_term' = 'Match Detail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Screening Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by` SET TAGS ('pii_business_glossary_term' = 'Performed By Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by_name` SET TAGS ('pii_business_glossary_term' = 'Performed By Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `re_screening_due_date` SET TAGS ('pii_business_glossary_term' = 'Rescreening Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_value_regex' = 'none|investigate|escalate|clear|terminate');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_reference` SET TAGS ('pii_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_value_regex' = 'clear|match|potential_match');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_business_glossary_term' = 'Screening Source');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_value_regex' = 'OIG_LEIE|SAM|STATE_MEDICAID|CMS|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('pii_business_glossary_term' = 'Screening Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `source_reference` SET TAGS ('pii_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_business_glossary_term' = 'Screened Subject Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `subject_type` SET TAGS ('pii_business_glossary_term' = 'Screened Subject Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `subject_type` SET TAGS ('pii_value_regex' = 'employee|provider|vendor|delegate');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `erisa_filing_id` SET TAGS ('pii_business_glossary_term' = 'ERISA Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_business_glossary_term' = 'Fee Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_description` SET TAGS ('pii_business_glossary_term' = 'Filing Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_due_date` SET TAGS ('pii_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_method` SET TAGS ('pii_business_glossary_term' = 'Filing Method (Submission Method)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_method` SET TAGS ('pii_value_regex' = 'electronic|paper|fax');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_period_end` SET TAGS ('pii_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_period_start` SET TAGS ('pii_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status (ERISA Filing Status)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|withdrawn|closed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_type` SET TAGS ('pii_business_glossary_term' = 'Filing Type (ERISA Filing Type)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `filing_type` SET TAGS ('pii_value_regex' = 'Form_5500|Summary_Annual_Report|Summary_Plan_Description|COBRA_Notice|QMCSO_Response');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical (Critical Filing Indicator)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `is_fwa_monitoring` SET TAGS ('pii_business_glossary_term' = 'FWA Monitoring Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('pii_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (Free Text)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year (Calendar Year of the Benefit Plan)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulator_acknowledged_date` SET TAGS ('pii_business_glossary_term' = 'Regulator Acknowledged Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulator_acknowledged_flag` SET TAGS ('pii_business_glossary_term' = 'Regulator Acknowledged Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body (Governing Agency)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'DOL|IRS|CMS|State_DOI');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference (Statutory Citation)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `reminder_schedule` SET TAGS ('pii_business_glossary_term' = 'Reminder Schedule (Filing Reminder Frequency)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `reminder_schedule` SET TAGS ('pii_value_regex' = 'none|weekly|biweekly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level (Compliance Risk Rating)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number (Regulatory Submission Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `submission_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_fair_hearing_id` SET TAGS ('pii_business_glossary_term' = 'State Fair Hearing Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Hearing Officer ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `adverse_action_type` SET TAGS ('pii_business_glossary_term' = 'Adverse Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `adverse_action_type` SET TAGS ('pii_value_regex' = 'denial|reduction|termination|no_action');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `attachment_url` SET TAGS ('pii_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `compliance_deadline_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Deadline Met');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_date` SET TAGS ('pii_business_glossary_term' = 'Hearing Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Hearing Duration (Minutes)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_location` SET TAGS ('pii_business_glossary_term' = 'Hearing Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_officer_name` SET TAGS ('pii_business_glossary_term' = 'Hearing Officer Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_officer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_officer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_outcome` SET TAGS ('pii_business_glossary_term' = 'Hearing Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_outcome` SET TAGS ('pii_value_regex' = 'upheld|reversed|settlement|dismissed|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_request_number` SET TAGS ('pii_business_glossary_term' = 'Hearing Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_type` SET TAGS ('pii_business_glossary_term' = 'Hearing Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_type` SET TAGS ('pii_value_regex' = 'in_person|virtual|phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_dob` SET TAGS ('pii_business_glossary_term' = 'Member Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_dob` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_dob` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_name` SET TAGS ('pii_business_glossary_term' = 'Member Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_state` SET TAGS ('pii_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Hearing Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_agency_code` SET TAGS ('pii_business_glossary_term' = 'State Agency Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_agency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_fair_hearing_status` SET TAGS ('pii_business_glossary_term' = 'Hearing Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_fair_hearing_status` SET TAGS ('pii_value_regex' = 'pending|scheduled|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Implementation Owner ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `prior_regulation_regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Prior Regulation ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_category` SET TAGS ('pii_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_area` SET TAGS ('pii_business_glossary_term' = 'Compliance Area');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_area` SET TAGS ('pii_value_regex' = 'privacy|security|financial|clinical|operational');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_deadline` SET TAGS ('pii_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `governing_body` SET TAGS ('pii_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impacted_business_areas` SET TAGS ('pii_business_glossary_term' = 'Impacted Business Areas');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|deferred|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_target_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Target Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_code` SET TAGS ('pii_business_glossary_term' = 'Regulation Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_name` SET TAGS ('pii_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_type` SET TAGS ('pii_business_glossary_term' = 'Regulation Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_type` SET TAGS ('pii_value_regex' = 'federal|state|local|international|industry|internal');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('pii_business_glossary_term' = 'Regulation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('pii_value_regex' = 'draft|proposed|final|active|repealed|expired');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_reference_url` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `reporting_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `required_response_actions` SET TAGS ('pii_business_glossary_term' = 'Required Response Actions');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_report_id` SET TAGS ('pii_business_glossary_term' = 'Breach Report Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `parent_breach_report_id` SET TAGS ('pii_business_glossary_term' = 'Parent Breach Report Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `parent_breach_report_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `affected_entity_description` SET TAGS ('pii_business_glossary_term' = 'Affected Entity Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `affected_entity_type` SET TAGS ('pii_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `audit_finding_date` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `audit_finding_description` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `audit_finding_status` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_amount` SET TAGS ('pii_business_glossary_term' = 'Breach Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_category` SET TAGS ('pii_business_glossary_term' = 'Breach Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_cause` SET TAGS ('pii_business_glossary_term' = 'Breach Cause');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_currency` SET TAGS ('pii_business_glossary_term' = 'Breach Currency');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_date` SET TAGS ('pii_business_glossary_term' = 'Breach Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_description` SET TAGS ('pii_business_glossary_term' = 'Breach Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by` SET TAGS ('pii_business_glossary_term' = 'Breach Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_email` SET TAGS ('pii_business_glossary_term' = 'Breach Initiated By Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_name` SET TAGS ('pii_business_glossary_term' = 'Breach Initiated By Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Breach Initiated By Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_type` SET TAGS ('pii_business_glossary_term' = 'Breach Initiated By Contact Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_location` SET TAGS ('pii_business_glossary_term' = 'Breach Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_report_status` SET TAGS ('pii_business_glossary_term' = 'Breach Report Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_severity` SET TAGS ('pii_business_glossary_term' = 'Breach Severity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_type` SET TAGS ('pii_business_glossary_term' = 'Breach Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `cap_action_description` SET TAGS ('pii_business_glossary_term' = 'Cap Action Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `cap_completion_date` SET TAGS ('pii_business_glossary_term' = 'Cap Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `cap_status` SET TAGS ('pii_business_glossary_term' = 'Cap Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `notification_reference` SET TAGS ('pii_business_glossary_term' = 'Notification Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `number_of_affected_individuals` SET TAGS ('pii_business_glossary_term' = 'Number Of Affected Individuals');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `number_of_records_affected` SET TAGS ('pii_business_glossary_term' = 'Number Of Records Affected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `regulatory_filing_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `regulatory_filing_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_date` SET TAGS ('pii_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_name` SET TAGS ('pii_business_glossary_term' = 'Report Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_type` SET TAGS ('pii_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `reported_by` SET TAGS ('pii_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_ssot_source_domain' = 'compliance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_table_name' = 'regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_vreq_skip_P210' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_ssot_source_domain' = 'compliance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_table_name' = 'attestation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_vreq_skip_P208' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` SET TAGS ('pii_ssot_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
