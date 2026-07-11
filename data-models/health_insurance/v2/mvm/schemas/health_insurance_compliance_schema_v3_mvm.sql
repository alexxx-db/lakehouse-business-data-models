-- Schema for Domain: compliance | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`compliance` COMMENT 'Manages regulatory compliance obligations — HIPAA privacy and security (OCR), ACA market conduct, CMS audit readiness, state DOI filings, NCQA/URAC accreditation, SOC reporting, fraud waste and abuse (FWA) monitoring, and PHI breach notification. Owns regulatory submission calendars, audit findings, corrective action plans (CAPs), compliance attestations, and MLR compliance tracking. Supports ERISA filings and state fair hearing coordination.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.breach_incident. Business justification: HIPAA breach notification requirements mandate regulatory submissions to HHS (OCR) and state regulators. A regulatory_submission record for a breach notification should reference the originating breac',
    `regulatory_obligation_id` BIGINT COMMENT 'Link to the specific regulatory requirement that this submission satisfies.',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: CMS and state service area expansion/contraction filings are directly tied to a specific plan_service_area record. Regulatory submissions for geographic coverage changes require traceability to the se',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: CMS annual rate filings, state benefit mandate submissions, and ACA compliance filings are tied to a specific plan year. Direct FK to plan.year enables year-based submission tracking and open enrollme',
    `acceptance_date` DATE COMMENT 'Date the regulator formally accepted the filing.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `confirmation_number` STRING COMMENT 'Identifier returned by the regulator confirming receipt of the filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `due_date` DATE COMMENT 'Deadline by which the regulatory filing must be completed.',
    `fee_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the filing fee is expressed.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Gross fee charged by the regulator for processing the submission.',
    `filing_period_end` DATE COMMENT 'End date of the reporting period covered by the submission.',
    `filing_period_start` DATE COMMENT 'Start date of the reporting period covered by the submission.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the filing is deemed critical for regulatory compliance (true) or routine (false).',
    `last_reminder_sent_date` DATE COMMENT 'Date the most recent reminder was sent to the responsible party.',
    `lead_time_days` STRING COMMENT 'Number of days between creation of the submission record and its due date.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Net fee after any adjustments, discounts, or credits.',
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
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_program. Business justification: Accreditation programs (NCQA, URAC, HEDIS) involve formal audit/survey engagements. An audit_engagement is a child activity conducted within the scope of an accreditation_program. The audit_engagement',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Targeted compliance audits (pharmacy benefit audits, behavioral health benefit package audits, MHPAEA parity audits) are scoped to specific benefit packages. Linking audit_engagement to benefit_packag',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audit engagements are performed to satisfy regulatory obligations; linking creates required hierarchy.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: CMS surveys, state inspections, and accreditation surveys are conducted at specific facilities. Audit engagements must reference the facility being audited to support survey scheduling, finding attrib',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practice audits (PCMH surveys, NCQA group credentialing audits, CMS group billing audits) are conducted at the group level. Audit engagements must reference the specific group practice to suppor',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Provider-level credentialing audits and quality audits are conducted against individual providers. Audit engagements must reference the specific provider being audited to support credentialing audit t',
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
    `engagement_end_date` DATE COMMENT 'Date when the audit engagement concluded or was terminated.',
    `engagement_start_date` DATE COMMENT 'Date when the audit engagement officially began.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit engagement was last reviewed for status or changes.',
    `minor_findings` STRING COMMENT 'Number of findings classified as minor severity.',
    `overall_outcome` STRING COMMENT 'Final result of the audit after all findings are addressed.. Valid values are `favorable|unfavorable|conditional|pending`',
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
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: ACA EHB compliance audits and cost-sharing accuracy audits target specific benefit packages. Auditors must trace findings to the exact benefit package under review for remediation tracking and regulat',
    `affected_business_area` STRING COMMENT 'Business function or area affected by the finding.. Valid values are `claims|billing|provider_network|member_services|care_management|pharmacy`',
    `audit_category` STRING COMMENT 'Regulatory or compliance domain to which the finding relates.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the audit finding.. Valid values are `open|in_progress|resolved|closed`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was formally closed after remediation.',
    `compliance_area` STRING COMMENT 'Specific compliance domain impacted by the finding.. Valid values are `HIPAA|ACA|CMS|NCQA|URAC|State`',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the remediation work.. Valid values are `not_started|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was created in the system.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative describing the nature of the finding.',
    `due_date` DATE COMMENT 'Date by which remediation actions must be completed.',
    `effectiveness_assessment` STRING COMMENT 'Qualitative assessment of remediation effectiveness.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_score` STRING COMMENT 'Score (0‑100) measuring how effective the remediation was.',
    `evidence_document_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting evidence documents.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact associated with the finding.',
    `financial_impact_currency` STRING COMMENT 'Currency code for the financial impact amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `finding_number` STRING COMMENT 'Business identifier assigned to the finding for tracking and reference.',
    `finding_type` STRING COMMENT 'Classification of the finding as a condition, cause, or effect.. Valid values are `condition|cause|effect`',
    `identified_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding was first identified during the audit.',
    `is_critical` BOOLEAN COMMENT 'True if the finding is deemed critical based on severity and impact.',
    `is_repeat_finding` BOOLEAN COMMENT 'Indicates whether this finding has been observed previously.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the finding.',
    `notes` STRING COMMENT 'Free‑form notes added by auditors or reviewers.',
    `priority` STRING COMMENT 'Priority level assigned to the finding for remediation scheduling.. Valid values are `high|medium|low`',
    `regulatory_citation` STRING COMMENT 'Specific regulation, statute, or standard cited for the finding.',
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
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Corrective action plans addressing mental health parity violations, preventive services non-compliance, or EHB deficiencies are remediated at the individual benefit level. Linking CAP to the specific ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: A Corrective Action Plan may be created in direct response to a regulatory obligation violation (e.g., a state DOI mandate, CMS directive) independent of a specific audit finding. The corrective_actio',
    `license_id` BIGINT COMMENT 'Foreign key linking to provider.license. Business justification: License deficiencies (expired licenses, disciplinary actions, scope violations) directly trigger corrective action plans. Compliance teams must link CAPs to the specific license record to track remedi',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Corrective action plans are issued directly to individual providers for credentialing deficiencies, quality failures, or regulatory violations. Compliance teams must link CAPs to the specific provider',
    `actual_completion_date` DATE COMMENT 'Date when the CAP was actually completed.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for the CAP.',
    `audit_comments` STRING COMMENT 'Free-text comments from auditors or reviewers regarding the CAP.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP was formally closed.',
    `compliance_category` STRING COMMENT 'High-level compliance domain of the issue.. Valid values are `privacy|security|financial|clinical|operational`',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline by which remediation must be completed.',
    `corrective_action_plan_status` STRING COMMENT 'Current lifecycle status of the CAP.. Valid values are `draft|submitted|in_progress|completed|closed|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAP record was created in the system.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the corrective actions.',
    `evidence_document_path` STRING COMMENT 'File system or URL location of supporting evidence artifacts.',
    `is_external_audit` BOOLEAN COMMENT 'Indicates whether the finding originated from an external audit.',
    `is_fwa_monitoring` BOOLEAN COMMENT 'Indicates if the CAP is related to FWA monitoring.',
    `last_milestone_status` STRING COMMENT 'Status of the most recent milestone.. Valid values are `not_started|in_progress|completed|blocked`',
    `milestone_count` STRING COMMENT 'Total number of milestones defined for the CAP.',
    `notes` STRING COMMENT 'Additional free-text notes about the CAP.',
    `owner_role` STRING COMMENT 'Role of the owner within the organization.. Valid values are `compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager`',
    `plan_name` STRING COMMENT 'Descriptive name of the corrective action plan.',
    `plan_number` STRING COMMENT 'External reference number assigned to the CAP.',
    `plan_type` STRING COMMENT 'Category of the CAP based on source of finding.. Valid values are `audit|regulatory|operational|clinical|financial`',
    `priority` STRING COMMENT 'Priority level assigned to the CAP.. Valid values are `low|medium|high|critical`',
    `regulatory_body` STRING COMMENT 'Regulatory authority associated with the finding. [ENUM-REF-CANDIDATE: CMS|OCR|NAIC|State_DOI|NCQA|URAC|Joint_Commission — 7 candidates stripped; promote to reference product]',
    `remediation_strategy` STRING COMMENT 'Planned approach to address the root cause.',
    `risk_score` STRING COMMENT 'Numeric risk score assigned to the CAP based on severity and impact.',
    `root_cause` STRING COMMENT 'Narrative of the root cause analysis for the finding.',
    `severity` STRING COMMENT 'Severity of the underlying finding.. Valid values are `minor|moderate|major|severe`',
    `target_completion_date` DATE COMMENT 'Planned date by which the CAP should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CAP record.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Master record for each Corrective Action Plan (CAP) developed in response to audit findings, regulatory violations, or accreditation deficiencies. Captures the triggering finding or violation, CAP type, remediation strategy, responsible owner, target completion date, and implementation status. Includes granular milestone tracking with individual action items, assigned owners, planned/actual completion dates, milestone status, evidence artifacts, and reviewer sign-off for each milestone. Tracks the full CAP lifecycle from submission to regulatory body through milestone completion, validation, and closure. Critical for CMS audit readiness and NCQA accreditation maintenance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` (
    `breach_incident_id` BIGINT COMMENT 'Primary key for breach_incident',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Data breaches often affect specific billing accounts (payment method theft, account takeover). Tracking enables HIPAA notification obligations, remediation scoping, affected member identification, and',
    `audit_finding_id` BIGINT COMMENT 'Identifier of the breach report filed with external regulator.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: A breach incident triggers a Corrective Action Plan to remediate the root cause and prevent recurrence. breach_incident currently has denormalized STRING fields corrective_action_plan and correctiv',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Breach incidents commonly originate at specific facilities (hospital data breaches, clinic PHI exposures). Linking breach_incident to facility supports HHS breach reporting, state notification require',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: HIPAA breach incidents frequently involve providers as business associates (e.g., provider EHR breach exposing member PHI). Breach investigations require linking to the specific provider involved for ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: When a PHI breach involves a business associate, the specific BAA governing that relationship is critical for determining breach notification requirements, liability, and remediation obligations. brea',
    `affected_phi_categories` STRING COMMENT 'Comma-separated list of PHI categories impacted (e.g., demographic, clinical, claims).',
    `audit_findings` STRING COMMENT 'Summary of audit findings related to the breach.',
    `breach_cause_description` STRING COMMENT 'Narrative description of the cause of the breach.',
    `breach_discovery_date` DATE COMMENT 'Date the breach was discovered by the organization.',
    `breach_occurrence_date` DATE COMMENT 'Date the breach actually occurred (if known).',
    `breach_report_url` STRING COMMENT 'Link to the external breach report document.',
    `breach_resolution_date` DATE COMMENT 'Date the breach was fully resolved and closed.',
    `breach_source` STRING COMMENT 'Origin of the breach (internal staff, external actor, partner, unknown).. Valid values are `internal|external|partner|unknown`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach investigation.. Valid values are `open|investigating|closed|pending|resolved`',
    `breach_type` STRING COMMENT 'Category of the breach event.. Valid values are `unauthorized_access|theft|loss|improper_disposal|other`',
    `business_associate_involved` BOOLEAN COMMENT 'Indicates whether a Business Associate was involved in the breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach incident record was created in the system.',
    `hhs_notification_date` DATE COMMENT 'Date HHS was notified of the breach.',
    `hhs_notified` BOOLEAN COMMENT 'Indicates if the U.S. Department of Health & Human Services was notified.',
    `notification_content_version` STRING COMMENT 'Version identifier of the notification content used.',
    `notification_date` DATE COMMENT 'Date the notification was sent.',
    `notification_delivery_confirmation` BOOLEAN COMMENT 'Indicates whether delivery confirmation was received.',
    `notification_method` STRING COMMENT 'Delivery channel used for the notification.. Valid values are `mail|email|substitute_notice|phone|fax`',
    `notification_obligation` STRING COMMENT 'Regulatory notification obligations triggered by the breach.. Valid values are `individual|hhs|state|media|none`',
    `notification_recipient_count` STRING COMMENT 'Number of recipients who received the notification.',
    `notification_type` STRING COMMENT 'Type of notification sent.. Valid values are `individual|hhs|state|media`',
    `number` STRING COMMENT 'External reference number assigned to the breach incident.',
    `number_of_individuals_affected` STRING COMMENT 'Count of distinct individuals whose PHI was compromised.',
    `number_of_records_affected` STRING COMMENT 'Total number of PHI records impacted.',
    `regulatory_filing_date` DATE COMMENT 'Date the breach was filed with the regulator.',
    `regulatory_filing_status` STRING COMMENT 'Status of required regulatory filings related to the breach.. Valid values are `not_filed|filed|rejected|accepted`',
    `risk_assessment_method` STRING COMMENT 'Methodology used for risk assessment.. Valid values are `qualitative|quantitative|hybrid`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score resulting from breach risk assessment.',
    `state_notification_date` DATE COMMENT 'Date the state authority was notified.',
    `state_notified` BOOLEAN COMMENT 'Indicates if the relevant state authority was notified.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach incident record.',
    CONSTRAINT pk_breach_incident PRIMARY KEY(`breach_incident_id`)
) COMMENT 'Master record for each PHI (Protected Health Information) breach incident identified under HIPAA Breach Notification Rule (45 CFR §164.400–414). Captures breach discovery date, breach type (unauthorized access, theft, loss, improper disposal), affected PHI categories, number of individuals affected, breach cause, business associate involvement, risk assessment outcome, and notification obligations triggered. Includes full notification tracking: notification type (individual, HHS/OCR, media, state AG), notification method (mail, email, substitute notice), notification date, recipient count, content version, and delivery confirmation. Drives the 60-day OCR notification workflow and annual breach report to HHS. Critical for HIPAA compliance and OCR audit readiness.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` (
    `hipaa_privacy_request_id` BIGINT COMMENT 'System-generated unique identifier for the HIPAA privacy request record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: HIPAA privacy requests are governed by specific regulatory obligations under the HIPAA Privacy Rule (45 CFR Part 164). Linking hipaa_privacy_request to regulatory_obligation is consistent with how all',
    `eob_id` BIGINT COMMENT 'Foreign key linking to claim.eob. Business justification: HIPAA privacy requests (right of access, amendment, restriction of disclosure) most commonly reference EOB documents containing PHI. Linking hipaa_privacy_request to the specific EOB enables privacy o',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Each HIPAA privacy request is processed by a compliance employee; required for audit trails.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: HIPAA privacy requests (access, amendment, accounting of disclosures) are made in the context of a specific health plan that holds the members PHI. Plan-level HIPAA compliance reporting and OCR audit',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who submitted the privacy request.',
    `appeal_deadline` DATE COMMENT 'Final date by which an appeal must be filed.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if applicable.. Valid values are `upheld|reversed|denied|withdrawn`',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy request record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the privacy request record.',
    `denial_reason` STRING COMMENT 'Explanation provided when a request is denied or partially granted.',
    `disclosure_authorization_basis` STRING COMMENT 'Legal basis authorizing the PHI disclosure.. Valid values are `patient_authorization|legal_requirement|public_interest|court_order`',
    `disclosure_date` TIMESTAMP COMMENT 'Timestamp of the PHI disclosure, if one occurred.',
    `disclosure_logged` BOOLEAN COMMENT 'Indicates whether a PHI disclosure related to this request has been logged.',
    `disclosure_phicategories` STRING COMMENT 'Comma‑separated list of PHI categories disclosed (e.g., diagnosis, treatment, payment).',
    `disclosure_purpose` STRING COMMENT 'Business or legal purpose for which the PHI was disclosed.',
    `disclosure_recipient_type` STRING COMMENT 'Category of the entity receiving the disclosed PHI.. Valid values are `public_health|law_enforcement|research|legal|other`',
    `disposition` STRING COMMENT 'Outcome of the request (e.g., granted, denied, partially granted).',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the member has appealed the request decision.',
    `is_confidential_communication` BOOLEAN COMMENT 'True when the member requests that communications be handled confidentially.',
    `request_channel` STRING COMMENT 'Medium of the request (digital, paper, or phone).. Valid values are `digital|paper|phone`',
    `request_description` STRING COMMENT 'Free‑text description provided by the member detailing the request.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the privacy request.',
    `request_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the privacy request was initially received.',
    `request_source` STRING COMMENT 'Channel through which the request was received (e.g., member portal, email, phone).. Valid values are `portal|email|phone|fax|mail`',
    `request_status` STRING COMMENT 'Current processing state of the privacy request.. Valid values are `pending|in_review|completed|denied|partially_granted|closed`',
    `request_type` STRING COMMENT 'Category of the privacy request as defined by HIPAA (e.g., access, amendment, accounting of disclosures, restriction, confidential communication).. Valid values are `access|amendment|accounting|restriction|confidential_communication`',
    `response_date` DATE COMMENT 'Date on which the organization completed its response to the request.',
    `response_due_date` DATE COMMENT 'Regulatory deadline by which a response must be provided (typically 30 days from receipt).',
    CONSTRAINT pk_hipaa_privacy_request PRIMARY KEY(`hipaa_privacy_request_id`)
) COMMENT 'Transactional record for HIPAA privacy operations — member privacy rights requests and PHI disclosure tracking. Covers access requests (right to access PHI), amendment requests, accounting of disclosures, restriction requests, and confidential communication requests under 45 CFR §164.500. Captures request type, member identifier, request receipt date, response due date, response date, request disposition (granted, denied, partially granted), denial reason, and appeal status. Includes PHI disclosure logging: disclosure date, recipient organization, recipient type (public health authority, law enforcement, research, legal), purpose of disclosure, PHI categories disclosed, and disclosure authorization basis. Excludes treatment, payment, and healthcare operations disclosures per HIPAA exemptions. Tracks compliance with HIPAA response timelines and supports OCR audit documentation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` (
    `fwa_case_id` BIGINT COMMENT 'Unique system-generated identifier for the FWA case.',
    `affiliation_id` BIGINT COMMENT 'Foreign key linking to provider.affiliation. Business justification: FWA cases frequently involve billing under a specific hospital affiliation (e.g., ghost admissions, upcoding tied to admitting privileges). SIU investigators must link FWA cases to the specific affili',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: FWA cases frequently involve fraudulent billing under specific benefits (DME, mental health, home health). Linking FWA cases to the specific benefit enables benefit-level fraud pattern analysis and ta',
    `header_id` BIGINT COMMENT 'add column claim_header_id (BIGINT) with FK to claim.header.header_id - FWA cases are triggered by suspicious claims',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: FWA investigations are governed by specific regulatory obligations (CMS FWA program requirements, state fraud statutes, False Claims Act). The fwa_case has a regulatory_reporting_flag boolean and comp',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: FWA cases frequently involve facility-level fraud (e.g., facility fee unbundling, ghost admissions, inflated facility charges). Linking fwa_case to facility supports facility-level FWA investigations,',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: FWA cases can involve group-level billing fraud (e.g., group NPI misuse, group-wide upcoding schemes). Linking fwa_case to group_practice enables group-level FWA pattern detection, CMS group billing f',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: FWA investigations frequently target specific premium invoices for billing fraud detection (phantom enrollments, premium manipulation). Enables case-to-evidence linking for investigations, recovery tr',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: Payment fraud cases must reference specific premium payments under investigation (check fraud, payment reversals, identity theft). Supports recovery amount tracking, evidence chain documentation, and ',
    `provider_id` BIGINT COMMENT '',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: FWA cases are frequently specialty-specific (e.g., upcoding in cardiology, unbundling in orthopedics). SIU investigators and analytics teams must link FWA cases to the providers specialty to detect s',
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
    `disposition_date` DATE COMMENT 'Date the case disposition was recorded.',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'Projected monetary loss associated with the alleged activity.',
    `evidence_reference` STRING COMMENT 'Link or identifier to supporting evidence stored in the evidence repository.',
    `is_high_risk` BOOLEAN COMMENT 'Flag indicating the case is considered high risk based on internal scoring.',
    `notes` STRING COMMENT 'Free‑form notes entered by investigators or reviewers.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` (
    `mlr_calculation_id` BIGINT COMMENT 'Primary key for mlr_calculation',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: The mlr_calculation table has an audit_finding_reference STRING column that is a denormalized text reference to an audit finding. This should be normalized to a proper FK (audit_finding_id → audit_fin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MLR calculations are performed to demonstrate compliance with regulatory obligations; linking ties calculations to obligations.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: MLR calculations are performed by a specific analyst; needed for audit of financial compliance.',
    `health_plan_id` BIGINT COMMENT 'Foreign key to the health plan for which the MLR is being calculated.',
    `primary_mlr_product_health_plan_id` BIGINT COMMENT 'Foreign key to the insurance product (e.g., specific benefit design) tied to the calculation.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: MLR calculations and CMS rebate submissions are plan-year-specific regulatory requirements. Linking mlr_calculation to plan.year enables joining to plan year metadata (open enrollment dates, grace per',
    `calculation_date` DATE COMMENT 'Date on which the MLR calculation was performed.',
    `calculation_number` STRING COMMENT 'Human‑readable identifier assigned to the MLR calculation for reporting and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR calculation record was first created in the system.',
    `earned_premium_amount` DECIMAL(18,2) COMMENT 'Total earned premium dollars for the reporting period, forming the MLR denominator.',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of claims incurred for the reporting period.',
    `line_of_business` STRING COMMENT 'Business line (e.g., HMO, PPO, Medicaid) associated with the MLR calculation.',
    `market_segment_code` STRING COMMENT 'Code representing the market segment (e.g., individual, group, Medicare) to which the calculation applies.',
    `mlr_calculation_status` STRING COMMENT 'Current processing status of the MLR calculation.. Valid values are `pending|calculated|approved|rejected`',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'Calculated MLR ratio expressed as a percentage (incurred claims ÷ earned premium).',
    `notes` STRING COMMENT 'Free‑form comments or explanations entered by analysts.',
    `quality_improvement_expenses_amount` DECIMAL(18,2) COMMENT 'Dollar amount spent on quality improvement activities that count toward the MLR denominator.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the rebate owed to members or the market segment.',
    `rebate_disbursement_date` DATE COMMENT 'Date on which the rebate payment was or will be disbursed.',
    `rebate_disbursement_status` STRING COMMENT 'Current status of the rebate payment process.. Valid values are `not_started|in_process|completed|failed`',
    `rebate_eligibility_flag` BOOLEAN COMMENT 'True if the calculated MLR exceeds the regulatory threshold and a rebate is required.',
    `reporting_year` STRING COMMENT 'Calendar year for which the MLR is being calculated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MLR calculation record.',
    `version_number` STRING COMMENT 'Incremental version of the calculation record for audit trail purposes.',
    CONSTRAINT pk_mlr_calculation PRIMARY KEY(`mlr_calculation_id`)
) COMMENT 'Medical Loss Ratio (MLR) calculation and rebate processing record per ACA Section 2718 requirements. Captures reporting year, market segment, LOB, incurred claims, quality improvement expenses, earned premium, MLR percentage, rebate determination, rebate amount, and disbursement tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Unique system-generated identifier for each accreditation program record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Accreditation programs are driven by specific regulatory obligations; linking clarifies compliance scope.',
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
    `decision` STRING COMMENT 'Final decision made by the accrediting body.. Valid values are `accredited|denied|conditional|revoked`',
    `effective_from` DATE COMMENT 'Date on which the accreditation starts to be binding.',
    `effective_until` DATE COMMENT 'Date on which the accreditation ends; null if open‑ended.',
    `escalated_flag` BOOLEAN COMMENT 'True when issues have been escalated to senior management.',
    `evidence_documentation_url` STRING COMMENT 'Link to uploaded evidence files used in the accreditation review.',
    `final_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) resulting from the accreditation evaluation.',
    `is_critical` BOOLEAN COMMENT 'True if the accreditation is essential to business operations.',
    `last_modified_by` STRING COMMENT 'Identifier of the person or system that performed the most recent update.',
    `last_review_date` DATE COMMENT 'Date when the accreditation was last reviewed for compliance.',
    `accreditation_program_level` STRING COMMENT 'Level or tier assigned by the accrediting body (e.g., Level 1, Level 2).',
    `measure_thresholds` STRING COMMENT 'Target thresholds for each evaluated measure.',
    `measures` STRING COMMENT 'Key performance or quality measures assessed during the accreditation.',
    `next_survey_due_date` DATE COMMENT 'Planned date for the next accreditation survey cycle.',
    `notes` STRING COMMENT 'Additional comments or observations about the accreditation.',
    `preliminary_findings` STRING COMMENT 'Initial observations and issues identified during the survey.',
    `program_code` STRING COMMENT 'Business identifier assigned by the accrediting organization.',
    `program_name` STRING COMMENT 'Descriptive name of the accreditation program (e.g., NCQA Health Plan Accreditation).',
    `rating` STRING COMMENT 'Star rating or equivalent tier based on the final score.. Valid values are `1_star|2_star|3_star|4_star|5_star`',
    `recommendations` STRING COMMENT 'Suggested improvements or corrective actions from the accrediting body.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory obligation record.',
    `audit_findings` STRING COMMENT 'Summary of audit observations related to the obligation.',
    `compliance_regulatory_obligation_description` STRING COMMENT 'Full textual description of the regulatory obligation.',
    `compliance_regulatory_obligation_status` STRING COMMENT 'Lifecycle status of the regulatory obligation record.. Valid values are `active|inactive|retired|draft`',
    `compliance_status` STRING COMMENT 'Current compliance state of the obligation.. Valid values are `compliant|non-compliant|pending|exempt`',
    `corrective_action_plan` STRING COMMENT 'Planned actions to remediate any compliance gaps.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `effective_date` DATE COMMENT 'Date the obligation becomes effective.',
    `exemption_allowed` BOOLEAN COMMENT 'Indicates whether an exemption from the obligation is possible.',
    `exemption_criteria` STRING COMMENT 'Conditions under which an exemption may be granted.',
    `expiration_date` DATE COMMENT 'Date the obligation expires or is superseded (nullable).',
    `filing_status` STRING COMMENT 'Current status of required filings.. Valid values are `filed|not_filed|pending|waived`',
    `frequency` STRING COMMENT 'How often the obligation must be satisfied.. Valid values are `annual|quarterly|monthly|one-time|as-needed`',
    `governing_body` STRING COMMENT 'Regulatory authority that issues the obligation (e.g., CMS, OCR, NAIC, State DOI).',
    `is_federal` BOOLEAN COMMENT 'True if the obligation applies at the federal level.',
    `is_state_specific` BOOLEAN COMMENT 'True if the obligation is limited to a particular state.',
    `jurisdiction` STRING COMMENT 'Geographic scope of the obligation (state, province, or federal).',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment.',
    `last_modified_by` STRING COMMENT 'User or process that performed the most recent update.',
    `next_due_date` DATE COMMENT 'Date the next compliance action is required.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations.',
    `obligation_code` STRING COMMENT 'Business identifier code assigned to the regulatory obligation.',
    `obligation_type` STRING COMMENT 'Category of the regulatory requirement.. Valid values are `privacy|security|financial|reporting|accreditation|operational`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty for non‑compliance.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP`',
    `reference_url` STRING COMMENT 'Link to the official regulation or guidance document.',
    `regulatory_framework` STRING COMMENT 'Framework or statute under which the obligation falls (e.g., HIPAA, ACA, Medicare, State Law).',
    `reporting_frequency_months` STRING COMMENT 'Number of months between required reports.',
    `risk_impact` STRING COMMENT 'Potential business impact if the obligation is not met.. Valid values are `low|medium|high|critical`',
    `risk_likelihood` STRING COMMENT 'Likelihood of non‑compliance occurring.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (likelihood × impact).',
    `submission_deadline` DATE COMMENT 'Final date for filing required reports or documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Version of the obligation definition for change tracking.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master record for each regulatory obligation the health plan must fulfill — HIPAA Privacy/Security Rules, ACA market conduct requirements, CMS Medicare/Medicaid mandates, state DOI filings, NCQA/URAC accreditation standards, ERISA requirements, SOC reporting obligations, and state Medicaid fair hearing compliance. Captures the governing body, regulatory framework, obligation type, effective date, jurisdiction, frequency, accountable business owner, compliance status, and obligation risk score (likelihood × impact of non-compliance). Includes tracking of state fair hearing obligations for Medicaid adverse benefit determinations under 42 CFR §438.400. Serves as the authoritative registry of all compliance requirements and the anchor entity linking to submissions, attestations, policies, and corrective actions that demonstrate adherence.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_breach_incident_id` FOREIGN KEY (`breach_incident_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_incident`(`breach_incident_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ADD CONSTRAINT `fk_compliance_accreditation_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Submission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|STATE_DOI|NCQA|OCR|ERISA|DOL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'scheduled|draft|submitted|accepted|rejected|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi|portal|paper|email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'annual_notice|rate_filing|financial_statement|accreditation|breach_notification|mlr_report');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_body` SET TAGS ('dbx_value_regex' = 'CMS|OCR|NCQA|URAC|State_DOI|Internal');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'financial|operational|clinical|IT|security');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Actual');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('dbx_business_glossary_term' = 'Audit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_engagement_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_findings_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_followup_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Follow-up Required');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_report_release_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Release Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'regulatory|financial|operational|internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State_DOI');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `minor_findings` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|conditional|pending');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `significant_findings` SET TAGS ('dbx_business_glossary_term' = 'Significant Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `total_findings` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Area (BUS_AREA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_business_area` SET TAGS ('dbx_value_regex' = 'claims|billing|provider_network|member_services|care_management|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category (CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status (STAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Closed Timestamp (CLS_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area (COMP_AREA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'HIPAA|ACA|CMS|NCQA|URAC|State');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date (CA_CMPL_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CA_STAT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CRT_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date (DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Assessment (EFF_ASMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_assessment` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score (EFF_SCR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference (EVD_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount (FIN_IMP_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency (FIN_IMP_CUR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number (FND)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (FND_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'condition|cause|effect');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Timestamp (ID_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Flag (CRIT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag (REPEAT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRV_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Finding Priority (PRIO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation (CIT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (RM_ACT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date (RM_DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Finding Resolution (RES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'remediated|waived|deferred|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Identifier (RVW_BY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RSK_SCR)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source (RSK_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'internal|external|model');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEV)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|significant|minor');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Finding Source (SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'internal_audit|external_audit|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Finding Tags (TAG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPD_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Finding Version (VER)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual CAP Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Comments');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Closed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'privacy|security|financial|clinical|operational');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_progress|completed|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated CAP Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Path');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_external_audit` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `is_fwa_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Fraud Waste Abuse Monitoring Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Milestones');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAP General Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'CAP Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `owner_role` SET TAGS ('dbx_value_regex' = 'compliance_officer|risk_manager|clinical_lead|finance_lead|operations_manager');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'audit|regulatory|operational|clinical|financial');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAP Priority');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `remediation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Remediation Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'CAP Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAP Severity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|severe');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAP Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'External Breach Report ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected PHI Categories');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `affected_phi_categories` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `audit_findings` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Cause Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_cause_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Discovery Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_report_url` SET TAGS ('dbx_business_glossary_term' = 'External Breach Report URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_business_glossary_term' = 'Breach Source');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_source` SET TAGS ('dbx_value_regex' = 'internal|external|partner|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status (Lifecycle)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|pending|resolved');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type (Category)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'unauthorized_access|theft|loss|improper_disposal|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `business_associate_involved` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Involved');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notification_date` SET TAGS ('dbx_business_glossary_term' = 'HHS Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `hhs_notified` SET TAGS ('dbx_business_glossary_term' = 'HHS Notified');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_content_version` SET TAGS ('dbx_business_glossary_term' = 'Notification Content Version');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_delivery_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Notification Delivery Confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'mail|email|substitute_notice|phone|fax');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('dbx_business_glossary_term' = 'Notification Obligation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_obligation` SET TAGS ('dbx_value_regex' = 'individual|hhs|state|media|none');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Count');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'individual|hhs|state|media');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `number_of_individuals_affected` SET TAGS ('dbx_business_glossary_term' = 'Number of Individuals Affected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `number_of_records_affected` SET TAGS ('dbx_business_glossary_term' = 'Number of Records Affected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|rejected|accepted');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notified` SET TAGS ('dbx_business_glossary_term' = 'State Notified');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `hipaa_privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Privacy Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `eob_id` SET TAGS ('dbx_business_glossary_term' = 'Eob Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `group_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|reversed|denied|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Authorization Basis');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_authorization_basis` SET TAGS ('dbx_value_regex' = 'patient_authorization|legal_requirement|public_interest|court_order');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_logged` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Logged Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_phicategories` SET TAGS ('dbx_business_glossary_term' = 'Disclosed PHI Categories');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Recipient Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disclosure_recipient_type` SET TAGS ('dbx_value_regex' = 'public_health|law_enforcement|research|legal|other');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Request Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_appealed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `is_confidential_communication` SET TAGS ('dbx_business_glossary_term' = 'Confidential Communication Request');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'digital|paper|phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'portal|email|phone|fax|mail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|denied|partially_granted|closed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|amendment|accounting|restriction|confidential_communication');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud, Waste, and Abuse Case ID (FWA_CASE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `allegation_description` SET TAGS ('dbx_business_glossary_term' = 'Allegation Description (ALLEG_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `audit_log_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Log URL (AUDIT_LOG_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition (CASE_DISP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_disposition` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|law_enforcement|civil_penalty|referred');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number (CASE_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Open Timestamp (CASE_OPEN_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status (CASE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|referred|settled');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type (CASE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'fraud|waste|abuse');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference (COMP_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date (DISP_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Exposure Amount (EST_EXP_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference (EVID_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator (HIGH_RISK_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes (CASE_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount (RECOVERY_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date (REF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (REF_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'claim_edit|data_mining|tip_line|law_enforcement|employee_report');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (SUBJ_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Type (SUBJ_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'member|provider|employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Triage Outcome (TRIAGE_OUT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `triage_outcome` SET TAGS ('dbx_value_regex' = 'escalated|closed|investigate|dismissed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Mlr Calculation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Calculated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `group_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `primary_mlr_product_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `primary_mlr_product_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `primary_mlr_product_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `calculation_number` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `earned_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `incurred_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Incurred Claims Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_calculation_status` SET TAGS ('dbx_value_regex' = 'pending|calculated|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Medical Loss Ratio Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'MLR Calculation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `quality_improvement_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Improvement Expenses Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Disbursement Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Disbursement Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_disbursement_status` SET TAGS ('dbx_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `rebate_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Eligibility Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `reporting_year` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accountable_owner` SET TAGS ('dbx_business_glossary_term' = 'Accountable Business Owner');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'health_plan|provider|pharmacy|network|member');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `benchmark_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Thresholds');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Completion Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Conditions');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'accredited|denied|conditional|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `evidence_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `final_score` SET TAGS ('dbx_business_glossary_term' = 'Final Accreditation Score');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Accreditation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `accreditation_program_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `measure_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Measure Thresholds');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `measures` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Measures');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `next_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `preliminary_findings` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Rating');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = '1_star|2_star|3_star|4_star|5_star');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `rating` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Recommendations');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|focused');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings (AUDIT_FINDINGS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (DESCRIPTION)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_regulatory_obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CORRECTIVE_ACTION_PLAN)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_allowed` SET TAGS ('dbx_business_glossary_term' = 'Exemption Allowed (EXEMPTION_ALLOWED)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exemption Criteria (EXEMPTION_CRITERIA)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FILING_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'filed|not_filed|pending|waived');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Obligation Frequency (FREQUENCY)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|one-time|as-needed');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body (GOVERNING_BODY)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_federal` SET TAGS ('dbx_business_glossary_term' = 'Is Federal (IS_FEDERAL)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_state_specific` SET TAGS ('dbx_business_glossary_term' = 'Is State Specific (IS_STATE_SPECIFIC)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAST_ASSESSMENT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MODIFIED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date (NEXT_DUE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OBLIGATION_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBLIGATION_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'privacy|security|financial|reporting|accreditation|operational');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PENALTY_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (PENALTY_CURRENCY)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `reference_url` SET TAGS ('dbx_business_glossary_term' = 'Reference URL (REFERENCE_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (REGULATORY_FRAMEWORK)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (MONTHS)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_frequency_months` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact (RISK_IMPACT)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_impact` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood (RISK_LIKELIHOOD)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline (SUBMISSION_DEADLINE)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
