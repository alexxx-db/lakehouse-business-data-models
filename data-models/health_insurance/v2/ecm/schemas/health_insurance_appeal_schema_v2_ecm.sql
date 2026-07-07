-- Schema for Domain: appeal | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`appeal` COMMENT 'Manages member and provider appeals and grievances including claim denials, coverage disputes, utilization management appeals, external review requests, and state fair hearing processes. Tracks appeal status, resolution timelines, overturn rates, and compliance with state and federal appeal rights (ACA, ERISA). Distinct from compliance (which owns regulatory audit and reporting) and utilization (which owns initial authorization decisions).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for the appeal case.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee assigned to the case.',
    `header_id` BIGINT COMMENT 'FK to the related claim header.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to the compliance regulatory obligation.',
    `provider_contract_id` BIGINT COMMENT 'FK to the contract provider contract.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `party_id` BIGINT COMMENT 'FK to the contract party.',
    `plan_election_id` BIGINT COMMENT 'FK to the enrollment plan election.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
    `appeal_assigned_to` STRING COMMENT 'Name or ID of the person assigned to the appeal.',
    `appeal_escalation_flag` BOOLEAN COMMENT 'Indicates if the appeal has been escalated.',
    `appeal_number` STRING COMMENT 'Unique appeal case number.',
    `appeal_priority` STRING COMMENT 'Priority level of the appeal case.',
    `appeal_review_cycle_days` STRING COMMENT 'Number of days in the review cycle.',
    `appeal_status` STRING COMMENT 'Current status of the appeal case.',
    `appeal_type` STRING COMMENT 'Type of appeal (e.g., pre-service, post-service).',
    `clinical_criteria_applied` STRING COMMENT 'Clinical criteria applied in the appeal review.',
    `completeness_determination` STRING COMMENT 'Determination of case completeness.',
    `complexity_score` DECIMAL(18,2) COMMENT '',
    `decision_author_npi` STRING COMMENT 'NPI of the decision author.',
    `decision_rationale` STRING COMMENT 'Rationale for the appeal decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp of the appeal decision.',
    `decision_type` STRING COMMENT 'Type of decision rendered.',
    `effective_benefit_change_date` DATE COMMENT 'Date when benefit changes take effect.',
    `expedited_clinical_urgency_basis` STRING COMMENT 'Clinical basis for expedited processing.',
    `expedited_trigger` BOOLEAN COMMENT 'Whether the case triggered expedited processing.',
    `filing_channel` STRING COMMENT 'Channel through which the appeal was filed.',
    `filing_method` STRING COMMENT 'Method used to file the appeal.',
    `filing_party_type` STRING COMMENT 'Type of party filing the appeal.',
    `filing_timestamp` TIMESTAMP COMMENT 'Timestamp when the appeal was filed.',
    `line_of_business` STRING COMMENT 'Line of business for the appeal.',
    `member_notification_date` DATE COMMENT 'Date the member was notified.',
    `original_claim_number` STRING COMMENT 'Original claim number related to the appeal.',
    `overturn_reason` STRING COMMENT 'Reason for overturning the original decision.',
    `priority_level_code` STRING COMMENT '',
    `provider_notification_date` DATE COMMENT 'Date the provider was notified.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `regulatory_tier` STRING COMMENT 'Regulatory tier classification.',
    `related_diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `related_drug_ndc` STRING COMMENT 'Related drug NDC code.',
    `related_service_code` STRING COMMENT 'Related service/procedure code.',
    `sla_breach_flag` BOOLEAN COMMENT '',
    `supporting_documentation_checklist` STRING COMMENT 'Checklist of supporting documentation received.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Represents an appeal case encompassing all related reviews, documents, communications, and decisions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` (
    `adverse_determination_id` BIGINT COMMENT 'Primary key for the adverse determination.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `pa_request_id` BIGINT COMMENT 'FK to the utilization PA request.',
    `prior_authorization_id` BIGINT COMMENT 'FK to the pharmacy prior authorization.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `appeal_deadline_date` DATE COMMENT 'Deadline for filing an appeal.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Whether the determination is eligible for appeal.',
    `appeal_filed_date` DATE COMMENT 'Date an appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal if filed.',
    `appeal_resolution_date` DATE COMMENT 'Date the appeal was resolved.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `basis_of_denial` STRING COMMENT 'Basis for the denial decision.',
    `clinical_criteria_version` STRING COMMENT 'Version of clinical criteria used.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code for monetary amounts.',
    `denial_reason_code` STRING COMMENT 'Code for the denial reason.',
    `denial_reason_description` STRING COMMENT 'Description of the denial reason.',
    `determination_date` TIMESTAMP COMMENT 'Date/time the determination was made.',
    `determination_number` STRING COMMENT 'Unique determination tracking number.',
    `determination_status` STRING COMMENT 'Current status of the determination.',
    `determination_type` STRING COMMENT 'Type of adverse determination.',
    `diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `effective_date` DATE COMMENT 'Effective date of the determination.',
    `monetary_amount_adjusted` DECIMAL(18,2) COMMENT 'Amount adjusted as a result of the determination.',
    `monetary_amount_denied` DECIMAL(18,2) COMMENT 'Amount denied.',
    `network_status` STRING COMMENT 'Network status at time of determination.',
    `notes` STRING COMMENT 'Additional notes.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Whether prior authorization was required.',
    `reviewer_name` STRING COMMENT 'Name of the reviewer.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `service_code` STRING COMMENT 'Service/procedure code.',
    `service_date` DATE COMMENT 'Date of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_adverse_determination PRIMARY KEY(`adverse_determination_id`)
) COMMENT 'Records adverse benefit determinations that may be subject to appeal, including denials and reductions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`review` (
    `review_id` BIGINT COMMENT 'Primary key for the review.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `record_id` BIGINT COMMENT 'FK to the credential record of the reviewer.',
    `employee_id` BIGINT COMMENT 'add column reviewer_employee_id (BIGINT) with FK to workforce.employee.employee_id - reviews are conducted by an employee',
    `appeal_case_number` STRING COMMENT 'Appeal case number reference.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_status_at_review` STRING COMMENT 'Status of the appeal at time of review.',
    `appeal_submission_date` DATE COMMENT 'Date the appeal was submitted.',
    `clinical_rationale` STRING COMMENT 'Clinical rationale for the review decision.',
    `compliance_flag` STRING COMMENT 'Compliance status flag.',
    `cpt_codes_reviewed` STRING COMMENT 'CPT codes reviewed during the appeal.',
    `criteria_version` STRING COMMENT 'Version of criteria applied.',
    `drg_code` STRING COMMENT 'DRG code if applicable.',
    `duration_minutes` STRING COMMENT 'Duration of the review in minutes.',
    `icd_codes_reviewed` STRING COMMENT 'ICD codes reviewed.',
    `is_independent_reviewer` BOOLEAN COMMENT 'Whether the reviewer is independent.',
    `location` STRING COMMENT 'Location where review was conducted.',
    `notes` STRING COMMENT 'Review notes.',
    `outcome` STRING COMMENT 'Outcome of the review.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `review_number` STRING COMMENT 'Unique review tracking number.',
    `review_status` STRING COMMENT 'Current status of the review.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp of the review.',
    `review_type` STRING COMMENT 'Type of review conducted.',
    `reviewer_npi` STRING COMMENT 'NPI of the reviewer.',
    `reviewer_specialty` STRING COMMENT 'Specialty of the reviewer.',
    `reviewer_type` STRING COMMENT 'Type of reviewer.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Records internal reviews conducted as part of the appeal process by clinical or administrative reviewers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` (
    `external_review_id` BIGINT COMMENT 'Primary key for the external review.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `iro_organization_id` BIGINT COMMENT 'FK to the IRO organization.',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Financial adjustment amount.',
    `appeal_reason_code` STRING COMMENT 'Reason code for the appeal.',
    `appeal_reason_description` STRING COMMENT 'Description of the appeal reason.',
    `binding_determination_flag` BOOLEAN COMMENT 'Whether the determination is binding.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Original claim amount.',
    `compliance_action_taken` STRING COMMENT 'Compliance action taken.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `deadline_date` DATE COMMENT 'Deadline for the external review.',
    `decision` STRING COMMENT 'Decision of the external review.',
    `decision_date` DATE COMMENT 'Date of the decision.',
    `decision_rationale` STRING COMMENT 'Rationale for the decision.',
    `diagnosis_code` STRING COMMENT 'Related diagnosis code.',
    `external_review_status` STRING COMMENT 'Current status of the external review.',
    `external_review_type` STRING COMMENT 'Type of external review.',
    `iro_accreditation_status` STRING COMMENT 'Accreditation status of the IRO.',
    `is_urgent` BOOLEAN COMMENT 'Whether the review is urgent.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of last status change.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net financial amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `overdue_flag` BOOLEAN COMMENT 'Whether the review is overdue.',
    `patient_relationship` STRING COMMENT 'Patient relationship to subscriber.',
    `procedure_code` STRING COMMENT 'Related procedure code.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether regulatory reporting is required.',
    `reporting_status` STRING COMMENT 'Status of regulatory reporting.',
    `reporting_submission_date` DATE COMMENT 'Date of regulatory submission.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the review request.',
    `review_category` STRING COMMENT 'Category of the review.',
    `review_number` STRING COMMENT 'Unique review tracking number.',
    `review_priority` STRING COMMENT 'Priority of the review.',
    `service_date` DATE COMMENT 'Date of service.',
    `source` STRING COMMENT 'Source of the external review.',
    `state` STRING COMMENT 'State jurisdiction.',
    `transmission_date` DATE COMMENT 'Date of transmission to IRO.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_external_review PRIMARY KEY(`external_review_id`)
) COMMENT 'Records external independent reviews conducted by IROs when internal appeals are exhausted or expedited.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` (
    `timeline_id` BIGINT COMMENT 'Primary key for the timeline record.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `org_unit_id` BIGINT COMMENT 'FK to the workforce org unit.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key to compliance.compliance_regulatory_obligation.regulatory_obligation_id',
    `acknowledgment_due_date` DATE COMMENT 'Due date for acknowledgment.',
    `actual_acknowledgment_date` DATE COMMENT 'Actual date of acknowledgment.',
    `actual_decision_date` DATE COMMENT 'Actual date of decision.',
    `actual_expedited_date` DATE COMMENT 'Actual expedited processing date.',
    `actual_extension_date` DATE COMMENT 'Actual extension date.',
    `appeal_category` STRING COMMENT 'Category of the appeal.',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Timestamp when appeal was filed.',
    `appeal_origin` STRING COMMENT 'Origin of the appeal.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `breach_flag` BOOLEAN COMMENT 'Whether an SLA breach occurred.',
    `breach_reason` STRING COMMENT 'Reason for the breach.',
    `clock_start_event` STRING COMMENT 'Event that started the compliance clock.',
    `clock_type` STRING COMMENT 'Type of compliance clock.',
    `compliance_status` STRING COMMENT 'Current compliance status.',
    `corrective_action` STRING COMMENT 'Corrective action taken.',
    `days_overdue` STRING COMMENT 'Number of days overdue.',
    `decision_due_date` DATE COMMENT 'Due date for decision.',
    `expedited_due_date` DATE COMMENT 'Due date for expedited processing.',
    `extension_notification_date` DATE COMMENT 'Date extension notification was sent.',
    `extension_reason` STRING COMMENT 'Reason for the extension.',
    `jurisdiction_state` STRING COMMENT 'State jurisdiction.',
    `last_action_timestamp` TIMESTAMP COMMENT 'Timestamp of last action.',
    `notes` STRING COMMENT 'Additional notes.',
    `priority` STRING COMMENT 'Priority level.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `record_version` STRING COMMENT 'Version number of the record.',
    `regulatory_body` STRING COMMENT 'Regulatory body governing the timeline.',
    `root_cause_category` STRING COMMENT 'Root cause category for breaches.',
    `self_report_flag` BOOLEAN COMMENT 'Whether self-reported.',
    `sla_actual_days` STRING COMMENT 'Actual days taken.',
    `sla_breach` BOOLEAN COMMENT 'Whether SLA was breached.',
    `sla_target_days` STRING COMMENT 'Target SLA days.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    CONSTRAINT pk_timeline PRIMARY KEY(`timeline_id`)
) COMMENT 'Tracks regulatory timelines and SLA compliance for appeal cases including deadlines and breach events.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` (
    `coverage_dispute_id` BIGINT COMMENT 'Primary key for the coverage dispute.',
    `adverse_determination_id` BIGINT COMMENT 'add column adverse_determination_id (BIGINT) with FK to appeal.adverse_determination.adverse_determination_id - coverage disputes follow adverse determinations',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to the compliance regulatory obligation.',
    `party_id` BIGINT COMMENT 'FK to the disputing party.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'FK to the enrollment eligibility span.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `prior_authorization_id` BIGINT COMMENT 'FK to the pharmacy prior authorization.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `appeal_deadline` DATE COMMENT 'Deadline for filing an appeal.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_status` STRING COMMENT 'Current appeal status.',
    `cob_order` STRING COMMENT 'Coordination of benefits order.',
    `cob_rule_applied` STRING COMMENT 'COB rule applied.',
    `coordination_amount` DECIMAL(18,2) COMMENT 'Coordination amount.',
    `coverage_dispute_status` STRING COMMENT 'Current status of the coverage dispute.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `dispute_description` STRING COMMENT 'Description of the dispute.',
    `dispute_number` STRING COMMENT 'Unique dispute number.',
    `dispute_type` STRING COMMENT 'Type of dispute.',
    `disputed_benefit_code` STRING COMMENT 'Benefit code being disputed.',
    `disputing_party_type` STRING COMMENT 'Type of disputing party.',
    `effective_from` DATE COMMENT 'Effective start date.',
    `effective_until` DATE COMMENT 'Effective end date.',
    `formulary_exception_flag` BOOLEAN COMMENT 'Whether a formulary exception is involved.',
    `is_critical` BOOLEAN COMMENT 'Whether the dispute is critical.',
    `network_status` STRING COMMENT 'Network status.',
    `notes` STRING COMMENT 'Additional notes.',
    `other_carrier_code` BIGINT COMMENT 'Other carrier code.',
    `other_carrier_name` STRING COMMENT 'Other carrier name.',
    `priority_level` STRING COMMENT 'Priority level.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `resolution_date` DATE COMMENT 'Date of resolution.',
    `resolution_outcome` STRING COMMENT 'Outcome of resolution.',
    `subrogation_amount` DECIMAL(18,2) COMMENT 'Subrogation amount.',
    `subrogation_flag` BOOLEAN COMMENT 'Whether subrogation applies.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_coverage_dispute PRIMARY KEY(`coverage_dispute_id`)
) COMMENT 'Records disputes related to coverage determinations including COB, network status, and benefit eligibility.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` (
    `iro_organization_id` BIGINT COMMENT 'Primary key for the IRO organization.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key to compliance.compliance_regulatory_obligation.regulatory_obligation_id',
    `vendor_id` BIGINT COMMENT 'FK to the vendor master.',
    `accreditation_body` STRING COMMENT 'Accreditation body.',
    `accreditation_expiration_date` DATE COMMENT 'Expiration date of accreditation.',
    `accreditation_review_notes` STRING COMMENT 'Notes from accreditation review.',
    `accreditation_status` STRING COMMENT 'Current accreditation status.',
    `accreditation_status_code` STRING COMMENT '',
    `address_line1` STRING COMMENT 'Address line 1.',
    `address_line2` STRING COMMENT 'Address line 2.',
    `approved_states` STRING COMMENT 'States where the IRO is approved.',
    `assignment_rotation_methodology` STRING COMMENT 'Methodology for assignment rotation.',
    `city` STRING COMMENT 'City.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements.',
    `conflict_of_interest_attestation_date` DATE COMMENT 'Date of conflict of interest attestation.',
    `contract_effective_end_date` DATE COMMENT 'Contract end date.',
    `contract_effective_start_date` DATE COMMENT 'Contract start date.',
    `contracted_specialty_codes` STRING COMMENT '',
    `country` STRING COMMENT 'Country.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `email` STRING COMMENT 'Email address.',
    `external_review_scope` STRING COMMENT 'Scope of external reviews.',
    `iro_organization_status` STRING COMMENT 'Current status of the IRO.',
    `is_conflict_of_interest` BOOLEAN COMMENT 'Whether a conflict of interest exists.',
    `is_state_approved` BOOLEAN COMMENT 'Whether state approved.',
    `last_accreditation_review_date` DATE COMMENT 'Date of last accreditation review.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp.',
    `iro_organization_name` STRING COMMENT 'Name of the IRO organization.',
    `ncqa_certified_flag` BOOLEAN COMMENT '',
    `organization_type` STRING COMMENT 'Type of organization.',
    `phone` STRING COMMENT 'Phone number.',
    `postal_code` STRING COMMENT 'Postal code.',
    `rotation_cycle_months` STRING COMMENT 'Rotation cycle in months.',
    `specialty_capabilities` STRING COMMENT 'Specialty capabilities.',
    `state` STRING COMMENT 'State.',
    `state_approval_status` STRING COMMENT 'State approval status.',
    `stub_populated_flag` BOOLEAN COMMENT 'Indicates that this stub product has been populated with required attributes',
    `urac_certified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_iro_organization PRIMARY KEY(`iro_organization_id`)
) COMMENT 'Stores information about Independent Review Organizations (IROs) that conduct external reviews.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` (
    `expedited_review_id` BIGINT COMMENT 'Primary key for the expedited review.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `subscriber_id` BIGINT COMMENT 'FK to the member subscriber.',
    `original_expedited_review_id` BIGINT COMMENT 'Self-referencing FK to parent expedited review.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `actual_decision_date` DATE COMMENT 'Actual date of decision.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Claim amount.',
    `clinical_urgency_classification` STRING COMMENT 'Classification of clinical urgency.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `decision_due_date` DATE COMMENT 'Due date for decision.',
    `decision_outcome` STRING COMMENT 'Outcome of the decision.',
    `decision_rationale` STRING COMMENT 'Rationale for the decision.',
    `expedited_notification_required` BOOLEAN COMMENT 'Whether expedited notification is required.',
    `expedited_reason` STRING COMMENT 'Reason for expedited processing.',
    `expedited_review_status` STRING COMMENT 'Current status of the expedited review.',
    `is_confidential` BOOLEAN COMMENT 'Whether confidential.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `notification_method` STRING COMMENT 'Method of notification.',
    `notified_timestamp` TIMESTAMP COMMENT 'Timestamp of notification.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the request.',
    `review_request_number` STRING COMMENT 'Unique review request number.',
    `state_code` STRING COMMENT 'State code.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_expedited_review PRIMARY KEY(`expedited_review_id`)
) COMMENT 'Records expedited appeal reviews triggered by clinical urgency requiring accelerated timelines.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` (
    `outcome_id` BIGINT COMMENT 'Primary key for the outcome.',
    `adjustment_id` BIGINT COMMENT 'add column adjustment_id (BIGINT) with FK to claim.adjustment.adjustment_id - overturn outcomes generate claim adjustments',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `prior_outcome_id` BIGINT COMMENT 'Self-referencing FK to parent outcome.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `downstream_action` STRING COMMENT 'Downstream action required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact amount.',
    `jurisdiction_state` STRING COMMENT 'State jurisdiction.',
    `member_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of member notification.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome_number` STRING COMMENT 'Unique outcome number.',
    `outcome_status` STRING COMMENT 'Current outcome status.',
    `outcome_timestamp` TIMESTAMP COMMENT 'Timestamp of the outcome.',
    `outcome_type` STRING COMMENT 'Type of outcome.',
    `provider_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of provider notification.',
    `reason_code` STRING COMMENT 'Reason code.',
    `reason_description` STRING COMMENT 'Reason description.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_outcome PRIMARY KEY(`outcome_id`)
) COMMENT 'Records the final outcomes of appeal cases including decisions, financial impacts, and downstream actions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` (
    `penalty_id` BIGINT COMMENT 'Primary key for the penalty.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to the compliance regulatory obligation.',
    `escalated_from_penalty_id` BIGINT COMMENT 'Self-referencing FK to parent penalty.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `journal_entry_id` BIGINT COMMENT 'add column journal_entry_id (BIGINT) with FK to finance.journal_entry.journal_entry_id - penalties post to GL',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `amount` DECIMAL(18,2) COMMENT 'Penalty amount.',
    `appeal_deadline` DATE COMMENT 'Deadline to appeal the penalty.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Whether an appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of the penalty appeal.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Timestamp of penalty assessment.',
    `audit_trail` STRING COMMENT 'Audit trail.',
    `penalty_category` STRING COMMENT 'Category of penalty.',
    `compliance_flag` STRING COMMENT 'Compliance flag.',
    `currency_code` STRING COMMENT 'Currency code.',
    `due_date` DATE COMMENT 'Payment due date.',
    `effective_from` DATE COMMENT 'Effective start date.',
    `effective_until` DATE COMMENT 'Effective end date.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `payment_date` DATE COMMENT 'Date of payment.',
    `payment_status` STRING COMMENT 'Payment status.',
    `penalty_number` STRING COMMENT 'Unique penalty number.',
    `penalty_status` STRING COMMENT 'Current penalty status.',
    `penalty_type` STRING COMMENT 'Type of penalty.',
    `reason_code` STRING COMMENT 'Reason code.',
    `reason_description` STRING COMMENT 'Reason description.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `severity` STRING COMMENT 'Severity level.',
    `source_record_reference` STRING COMMENT 'Source record reference.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total penalty amount including interest.',
    CONSTRAINT pk_penalty PRIMARY KEY(`penalty_id`)
) COMMENT 'Records penalties assessed as a result of appeal outcomes or regulatory non-compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Primary key for the evidence record.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `pa_request_id` BIGINT COMMENT 'FK to the utilization PA request.',
    `header_id` BIGINT COMMENT 'FK to the claim header.',
    `supporting_evidence_id` BIGINT COMMENT 'Self-referencing FK to parent evidence.',
    `author_name` STRING COMMENT 'Name of the evidence author.',
    `author_npi` STRING COMMENT 'NPI of the evidence author.',
    `checksum` STRING COMMENT 'File checksum for integrity.',
    `clinical_code_icd10` STRING COMMENT 'ICD-10 clinical code.',
    `confidentiality_flag` BOOLEAN COMMENT 'Whether the evidence is confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `evidence_description` STRING COMMENT 'Description of the evidence.',
    `drg_code` STRING COMMENT 'DRG code.',
    `effective_date` DATE COMMENT 'Effective date of the evidence.',
    `evidence_number` STRING COMMENT 'Unique evidence number.',
    `evidence_status` STRING COMMENT 'Current status of the evidence.',
    `evidence_type` STRING COMMENT 'Type of evidence.',
    `expiration_date` DATE COMMENT 'Expiration date of the evidence.',
    `file_format` STRING COMMENT 'File format.',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes.',
    `guideline_version` STRING COMMENT 'Version of clinical guideline.',
    `ndc_code` STRING COMMENT 'NDC code if drug-related.',
    `notes` STRING COMMENT 'Additional notes.',
    `phi_flag` BOOLEAN COMMENT 'Whether the evidence contains PHI.',
    `procedure_code_cpt` STRING COMMENT 'CPT procedure code.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when evidence was received.',
    `related_encounter_number` BIGINT COMMENT 'Related encounter number.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Relevance score of the evidence.',
    `source_entity_type` STRING COMMENT 'Type of source entity.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    `storage_path` STRING COMMENT 'Storage path.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of submission.',
    `title` STRING COMMENT 'Title of the evidence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Records evidence submitted in support of or against appeal cases including clinical records and documentation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` (
    `appeal_grievance2_id` BIGINT COMMENT 'Primary key for the appeal grievance record.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee handling the grievance.',
    `party_id` BIGINT COMMENT 'FK to the contract party filing the grievance.',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `premium_invoice_id` BIGINT COMMENT 'FK to the billing premium invoice.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `header_id` BIGINT COMMENT 'FK to the related claim header.',
    `member_grievance_id` BIGINT COMMENT '',
    `acknowledgment_date` DATE COMMENT 'Date the grievance was acknowledged.',
    `appeal_grievance_status` STRING COMMENT 'Current status of the appeal grievance.',
    `appeal_reference_number` STRING COMMENT 'Unique reference number for the appeal.',
    `case_notes` STRING COMMENT 'Free-text notes on the grievance case.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the grievance has compliance implications.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `escalation_level` STRING COMMENT 'Current escalation level of the grievance.',
    `external_review_outcome` STRING COMMENT 'Outcome of external review if requested.',
    `external_review_requested` BOOLEAN COMMENT 'Whether external review has been requested.',
    `filing_channel` STRING COMMENT 'Channel through which the grievance was filed.',
    `filing_date` DATE COMMENT 'Date the grievance was filed.',
    `filing_party_type` STRING COMMENT 'Type of party filing the grievance.',
    `grievance_number` STRING COMMENT 'Unique grievance tracking number.',
    `grievance_type` STRING COMMENT 'Classification of the grievance type.',
    `investigation_end_date` DATE COMMENT 'Date the investigation ended.',
    `investigation_start_date` DATE COMMENT 'Date the investigation started.',
    `is_appeal` BOOLEAN COMMENT 'Indicates if this is an appeal rather than a grievance.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the grievance is confidential.',
    `priority` STRING COMMENT 'Priority level of the grievance.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the grievance.',
    `related_encounter_number` BIGINT COMMENT 'Related encounter number if applicable.',
    `resolution_date` DATE COMMENT 'Date the grievance was resolved.',
    `resolution_detail` STRING COMMENT 'Details of the resolution.',
    `resolution_type` STRING COMMENT 'Type of resolution applied.',
    `state_code` STRING COMMENT 'State jurisdiction code.',
    `title` STRING COMMENT 'Title or subject of the grievance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `zip_code` STRING COMMENT 'Zip code of the filing party.',
    CONSTRAINT pk_appeal_grievance2 PRIMARY KEY(`appeal_grievance2_id`)
) COMMENT 'Grievance as appeal-case precursor. Distinct from member.member_grievance which is the general member complaint record. [P201 skipped: target-product-missing:appeal.appeal_grievance renamed to appeal.grievance per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` (
    `appeal_document2_id` BIGINT COMMENT 'Primary key for the appeal document.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `provider_id` BIGINT COMMENT 'FK to the provider.',
    `appeal_document_description` STRING COMMENT 'Description of the document.',
    `appeal_document_status` STRING COMMENT 'Current status of the document.',
    `audit_trail` STRING COMMENT 'Audit trail for the document.',
    `considered_in_decision` BOOLEAN COMMENT 'Whether the document was considered in the decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `document_number` STRING COMMENT 'Unique document number.',
    `document_type` STRING COMMENT 'Type of document.',
    `document_type_code` STRING COMMENT 'Type of appeal document; differentiates scope from credential/vendor document',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes.',
    `format` STRING COMMENT 'File format.',
    `is_confidential` BOOLEAN COMMENT 'Whether the document is confidential.',
    `is_redacted` BOOLEAN COMMENT 'Whether the document has been redacted.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of last access.',
    `phi_classification` STRING COMMENT 'PHI classification level.',
    `receipt_date` DATE COMMENT 'Date the document was received.',
    `redaction_status` STRING COMMENT 'Status of redaction.',
    `required_for_appeal_only` BOOLEAN COMMENT 'Flag indicating document is required only for appeal cases',
    `retention_period_years` STRING COMMENT 'Retention period in years.',
    `source` STRING COMMENT 'Source of the document.',
    `storage_path` STRING COMMENT 'Storage path for the document.',
    `title` STRING COMMENT 'Title of the document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `version_number` STRING COMMENT 'Document version number.',
    CONSTRAINT pk_appeal_document2 PRIMARY KEY(`appeal_document2_id`)
) COMMENT 'Stores documents associated with appeal cases including clinical records, correspondence, and evidence. [P202 skipped: target-product-missing:appeal.appeal_document renamed to appeal.document per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` (
    `appeal_communication2_id` BIGINT COMMENT 'Primary key for the appeal communication.',
    `case_id` BIGINT COMMENT 'FK to the appeal case.',
    `member_communication_id` BIGINT COMMENT 'SSOT link to member.communication owner',
    `identity_id` BIGINT COMMENT 'Appellant member identity',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee.',
    `accessibility_accommodation` STRING COMMENT 'Accessibility accommodation required.',
    `appeal_communication_status` STRING COMMENT 'Current status of the communication.',
    `attachment_count` STRING COMMENT 'Number of attachments.',
    `attachment_indicator` BOOLEAN COMMENT 'Whether attachments are present.',
    `body_text` STRING COMMENT 'Body text of the communication.',
    `channel` STRING COMMENT 'Communication channel.',
    `communication_category` STRING COMMENT 'Category of communication.',
    `communication_number` STRING COMMENT 'Unique communication number.',
    `communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the communication.',
    `communication_type` STRING COMMENT 'Type of communication.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance flag.',
    `compliance_notes` STRING COMMENT 'Compliance-related notes.',
    `created_by_user_role` STRING COMMENT 'Role of the user who created the record.',
    `delivery_confirmation_date` DATE COMMENT 'Date delivery was confirmed.',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'Whether delivery was confirmed.',
    `direction` STRING COMMENT 'Direction of communication (inbound/outbound).',
    `escalation_date` DATE COMMENT 'Date of escalation.',
    `escalation_flag` BOOLEAN COMMENT 'Whether escalated.',
    `is_confidential` BOOLEAN COMMENT 'Whether confidential.',
    `is_physical_mail` BOOLEAN COMMENT 'Whether sent as physical mail.',
    `language` STRING COMMENT 'Language of the communication.',
    `last_modified_by_user_role` STRING COMMENT 'Role of last modifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `party_type` STRING COMMENT 'Type of party communicated with.',
    `priority_flag` BOOLEAN COMMENT 'Priority flag.',
    `priority_level` STRING COMMENT 'Priority level.',
    `received_date` DATE COMMENT 'Date received.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `regulatory_basis` STRING COMMENT 'Regulatory basis for the communication.',
    `regulatory_notice_flag` BOOLEAN COMMENT 'Whether this is a regulatory notice.',
    `response_due_date` DATE COMMENT 'Due date for response.',
    `response_received_date` DATE COMMENT 'Date response was received.',
    `response_received_flag` BOOLEAN COMMENT 'Whether response was received.',
    `returned_mail_date` DATE COMMENT 'Date mail was returned.',
    `returned_mail_flag` BOOLEAN COMMENT 'Whether mail was returned.',
    `sent_date` DATE COMMENT 'Date sent.',
    `subject` STRING COMMENT 'Subject of the communication.',
    CONSTRAINT pk_appeal_communication2 PRIMARY KEY(`appeal_communication2_id`)
) COMMENT 'Records all communications related to appeal cases including notices, letters, and member/provider correspondence. [P203 skipped: target-product-missing:appeal.appeal_communication renamed to appeal.communication per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Primary key for the regulatory filing.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to the compliance regulatory obligation.',
    `finance_regulatory_filing_id` BIGINT COMMENT 'SSOT link to finance.regulatory_filing owner',
    `group_id` BIGINT COMMENT 'FK to the employer group.',
    `identity_id` BIGINT COMMENT 'FK to the member identity.',
    `regulatory_submission_id` BIGINT COMMENT '',
    `acknowledgment_date` TIMESTAMP COMMENT 'Date/time of acknowledgment.',
    `acknowledgment_received` BOOLEAN COMMENT 'Whether acknowledgment was received.',
    `corrective_action_plan` STRING COMMENT 'Corrective action plan details.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `deficiency_description` STRING COMMENT 'Description of deficiency.',
    `deficiency_notice` BOOLEAN COMMENT 'Whether a deficiency notice was issued.',
    `filing_amount` DECIMAL(18,2) COMMENT 'Amount associated with the filing.',
    `filing_date` TIMESTAMP COMMENT 'Date of the filing.',
    `filing_method` STRING COMMENT 'Method of filing.',
    `filing_number` STRING COMMENT 'Unique filing number.',
    `filing_status` STRING COMMENT 'Current filing status.',
    `filing_type` STRING COMMENT 'Type of filing.',
    `filing_version` STRING COMMENT 'Version of the filing.',
    `notes` STRING COMMENT 'Additional notes.',
    `regulatory_body` STRING COMMENT 'Regulatory body.',
    `reporting_period` STRING COMMENT 'Reporting period.',
    `resubmission_date` TIMESTAMP COMMENT 'Date of resubmission.',
    `resubmission_required` BOOLEAN COMMENT 'Whether resubmission is required.',
    `submission_method` STRING COMMENT 'Method of submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Records regulatory filings related to appeals including state and federal submissions and compliance reports. [P211 skipped: target-product-missing:appeal.appeal_regulatory_filing renamed to appeal.regulatory_filing per VREQ-006]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` (
    `appeal_communication_id` BIGINT COMMENT 'Primary key',
    `member_communication_id` BIGINT COMMENT 'Foreign key to member.member_communication.member_communication_id',
    `identity_id` BIGINT COMMENT 'Foreign key to member.identity.identity_id',
    CONSTRAINT pk_appeal_communication PRIMARY KEY(`appeal_communication_id`)
) COMMENT 'Records communication events and correspondence related to appeals, including notifications, letters, and member interactions throughout the appeal lifecycle.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` (
    `appeal_document_id` BIGINT COMMENT 'Primary key for appeal_document',
    `credential_document_id` BIGINT COMMENT 'Foreign key reference',
    `document_type_code` STRING COMMENT 'Code indicating the type of document attached to the appeal',
    `required_for_appeal_only_flag` BOOLEAN COMMENT 'Flag indicating whether this document is required specifically for appeal purposes only',
    `required_for_appeal_only` BOOLEAN COMMENT '',
    CONSTRAINT pk_appeal_document PRIMARY KEY(`appeal_document_id`)
) COMMENT 'Records documents submitted or generated during the appeal process, including supporting evidence, medical records, and decision letters.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` (
    `appeal_grievance_id` BIGINT COMMENT 'Primary key for appeal_grievance',
    `member_grievance_id` BIGINT COMMENT '',
    CONSTRAINT pk_appeal_grievance PRIMARY KEY(`appeal_grievance_id`)
) COMMENT 'Grievance-as-appeal-case precursor';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_iro_organization_id` FOREIGN KEY (`iro_organization_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`iro_organization`(`iro_organization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_original_expedited_review_id` FOREIGN KEY (`original_expedited_review_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`expedited_review`(`expedited_review_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_prior_outcome_id` FOREIGN KEY (`prior_outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_escalated_from_penalty_id` FOREIGN KEY (`escalated_from_penalty_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`penalty`(`penalty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_supporting_evidence_id` FOREIGN KEY (`supporting_evidence_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`evidence`(`evidence_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ADD CONSTRAINT `fk_appeal_appeal_document2_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ADD CONSTRAINT `fk_appeal_appeal_communication2_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `plan_election_id` SET TAGS ('pii_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_assigned_to` SET TAGS ('pii_business_glossary_term' = 'Appeal Assigned To');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_priority` SET TAGS ('pii_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_review_cycle_days` SET TAGS ('pii_business_glossary_term' = 'Appeal Review Cycle Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_type` SET TAGS ('pii_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `completeness_determination` SET TAGS ('pii_business_glossary_term' = 'Completeness Determination');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('pii_business_glossary_term' = 'Decision Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_type` SET TAGS ('pii_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `effective_benefit_change_date` SET TAGS ('pii_business_glossary_term' = 'Effective Benefit Change Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_clinical_urgency_basis` SET TAGS ('pii_business_glossary_term' = 'Expedited Clinical Urgency Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_trigger` SET TAGS ('pii_business_glossary_term' = 'Expedited Trigger');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_channel` SET TAGS ('pii_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_method` SET TAGS ('pii_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_party_type` SET TAGS ('pii_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_timestamp` SET TAGS ('pii_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `member_notification_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `original_claim_number` SET TAGS ('pii_business_glossary_term' = 'Original Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `overturn_reason` SET TAGS ('pii_business_glossary_term' = 'Overturn Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_notification_date` SET TAGS ('pii_business_glossary_term' = 'Provider Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_tier` SET TAGS ('pii_business_glossary_term' = 'Regulatory Tier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Related Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Related Drug NDC');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_service_code` SET TAGS ('pii_business_glossary_term' = 'Related Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `supporting_documentation_checklist` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Checklist');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_fhir_resource' = 'ClaimResponse');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `adverse_determination_id` SET TAGS ('pii_business_glossary_term' = 'Adverse Determination ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'PA Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `basis_of_denial` SET TAGS ('pii_business_glossary_term' = 'Basis of Denial');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_date` SET TAGS ('pii_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_number` SET TAGS ('pii_business_glossary_term' = 'Determination Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_status` SET TAGS ('pii_business_glossary_term' = 'Determination Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_type` SET TAGS ('pii_business_glossary_term' = 'Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_adjusted` SET TAGS ('pii_business_glossary_term' = 'Monetary Amount Adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_denied` SET TAGS ('pii_business_glossary_term' = 'Monetary Amount Denied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_id` SET TAGS ('pii_business_glossary_term' = 'Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_case_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_reason_code` SET TAGS ('pii_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_status_at_review` SET TAGS ('pii_business_glossary_term' = 'Appeal Status at Review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_submission_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `cpt_codes_reviewed` SET TAGS ('pii_business_glossary_term' = 'CPT Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `criteria_version` SET TAGS ('pii_business_glossary_term' = 'Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('pii_business_glossary_term' = 'ICD Codes Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `is_independent_reviewer` SET TAGS ('pii_business_glossary_term' = 'Is Independent Reviewer');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_specialty` SET TAGS ('pii_business_glossary_term' = 'Reviewer Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_type` SET TAGS ('pii_business_glossary_term' = 'Reviewer Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_id` SET TAGS ('pii_business_glossary_term' = 'External Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_organization_id` SET TAGS ('pii_business_glossary_term' = 'IRO Organization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_code` SET TAGS ('pii_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_description` SET TAGS ('pii_business_glossary_term' = 'Appeal Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `binding_determination_flag` SET TAGS ('pii_business_glossary_term' = 'Binding Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `compliance_action_taken` SET TAGS ('pii_business_glossary_term' = 'Compliance Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `deadline_date` SET TAGS ('pii_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision` SET TAGS ('pii_business_glossary_term' = 'Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_status` SET TAGS ('pii_business_glossary_term' = 'External Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_type` SET TAGS ('pii_business_glossary_term' = 'External Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'IRO Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `is_urgent` SET TAGS ('pii_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `overdue_flag` SET TAGS ('pii_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `patient_relationship` SET TAGS ('pii_business_glossary_term' = 'Patient Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('pii_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_submission_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_category` SET TAGS ('pii_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_priority` SET TAGS ('pii_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'External Review Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `transmission_date` SET TAGS ('pii_business_glossary_term' = 'Transmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `timeline_id` SET TAGS ('pii_business_glossary_term' = 'Timeline ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `acknowledgment_due_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Actual Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_decision_date` SET TAGS ('pii_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_expedited_date` SET TAGS ('pii_business_glossary_term' = 'Actual Expedited Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_extension_date` SET TAGS ('pii_business_glossary_term' = 'Actual Extension Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_category` SET TAGS ('pii_business_glossary_term' = 'Appeal Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_origin` SET TAGS ('pii_business_glossary_term' = 'Appeal Origin');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_flag` SET TAGS ('pii_business_glossary_term' = 'Breach Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_reason` SET TAGS ('pii_business_glossary_term' = 'Breach Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_start_event` SET TAGS ('pii_business_glossary_term' = 'Clock Start Event');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_type` SET TAGS ('pii_business_glossary_term' = 'Clock Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `days_overdue` SET TAGS ('pii_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `decision_due_date` SET TAGS ('pii_business_glossary_term' = 'Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `expedited_due_date` SET TAGS ('pii_business_glossary_term' = 'Expedited Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_notification_date` SET TAGS ('pii_business_glossary_term' = 'Extension Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_reason` SET TAGS ('pii_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `last_action_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Action Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `self_report_flag` SET TAGS ('pii_business_glossary_term' = 'Self Report Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_actual_days` SET TAGS ('pii_business_glossary_term' = 'SLA Actual Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_breach` SET TAGS ('pii_business_glossary_term' = 'SLA Breach');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_target_days` SET TAGS ('pii_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_fhir_resource' = 'ClaimResponse');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Dispute ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Disputing Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Eligibility Span ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_order` SET TAGS ('pii_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_rule_applied` SET TAGS ('pii_business_glossary_term' = 'COB Rule Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coordination_amount` SET TAGS ('pii_business_glossary_term' = 'Coordination Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_description` SET TAGS ('pii_business_glossary_term' = 'Dispute Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_type` SET TAGS ('pii_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputed_benefit_code` SET TAGS ('pii_business_glossary_term' = 'Disputed Benefit Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputing_party_type` SET TAGS ('pii_business_glossary_term' = 'Disputing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `formulary_exception_flag` SET TAGS ('pii_business_glossary_term' = 'Formulary Exception Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_code` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_amount` SET TAGS ('pii_business_glossary_term' = 'Subrogation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_flag` SET TAGS ('pii_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `supporting_document_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_id` SET TAGS ('pii_business_glossary_term' = 'IRO Organization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_review_notes` SET TAGS ('pii_business_glossary_term' = 'Accreditation Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('pii_business_glossary_term' = 'Approved States');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `assignment_rotation_methodology` SET TAGS ('pii_business_glossary_term' = 'Assignment Rotation Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `conflict_of_interest_attestation_date` SET TAGS ('pii_business_glossary_term' = 'Conflict of Interest Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `external_review_scope` SET TAGS ('pii_business_glossary_term' = 'External Review Scope');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_status` SET TAGS ('pii_business_glossary_term' = 'IRO Organization Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_conflict_of_interest` SET TAGS ('pii_business_glossary_term' = 'Is Conflict of Interest');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('pii_business_glossary_term' = 'Is State Approved');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_accreditation_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Accreditation Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('pii_business_glossary_term' = 'IRO Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `organization_type` SET TAGS ('pii_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `rotation_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Rotation Cycle Months');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `specialty_capabilities` SET TAGS ('pii_business_glossary_term' = 'Specialty Capabilities');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('pii_business_glossary_term' = 'State Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_id` SET TAGS ('pii_business_glossary_term' = 'Expedited Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `original_expedited_review_id` SET TAGS ('pii_business_glossary_term' = 'Parent Expedited Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `actual_decision_date` SET TAGS ('pii_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `claim_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `clinical_urgency_classification` SET TAGS ('pii_business_glossary_term' = 'Clinical Urgency Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_due_date` SET TAGS ('pii_business_glossary_term' = 'Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_outcome` SET TAGS ('pii_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_notification_required` SET TAGS ('pii_business_glossary_term' = 'Expedited Notification Required');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_reason` SET TAGS ('pii_business_glossary_term' = 'Expedited Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_status` SET TAGS ('pii_business_glossary_term' = 'Expedited Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Notified Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `review_request_number` SET TAGS ('pii_business_glossary_term' = 'Review Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `supporting_document_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_fhir_resource' = 'ClaimResponse');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_id` SET TAGS ('pii_business_glossary_term' = 'Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `prior_outcome_id` SET TAGS ('pii_business_glossary_term' = 'Parent Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `downstream_action` SET TAGS ('pii_business_glossary_term' = 'Downstream Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `member_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Member Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_number` SET TAGS ('pii_business_glossary_term' = 'Outcome Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('pii_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_timestamp` SET TAGS ('pii_business_glossary_term' = 'Outcome Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('pii_business_glossary_term' = 'Outcome Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Provider Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_fhir_resource' = 'PaymentNotice');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_id` SET TAGS ('pii_business_glossary_term' = 'Penalty ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `escalated_from_penalty_id` SET TAGS ('pii_business_glossary_term' = 'Parent Penalty ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `assessment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_category` SET TAGS ('pii_business_glossary_term' = 'Penalty Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `interest_amount` SET TAGS ('pii_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_number` SET TAGS ('pii_business_glossary_term' = 'Penalty Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_status` SET TAGS ('pii_business_glossary_term' = 'Penalty Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_type` SET TAGS ('pii_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('pii_business_glossary_term' = 'Evidence ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Related Appeal Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Related Authorization PA Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `supporting_evidence_id` SET TAGS ('pii_business_glossary_term' = 'Parent Evidence ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('pii_business_glossary_term' = 'Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `checksum` SET TAGS ('pii_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('pii_business_glossary_term' = 'Clinical Code ICD10');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('pii_phi_diagnosis' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `confidentiality_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('pii_business_glossary_term' = 'Evidence Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_number` SET TAGS ('pii_business_glossary_term' = 'Evidence Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('pii_business_glossary_term' = 'Evidence Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('pii_business_glossary_term' = 'Evidence Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `guideline_version` SET TAGS ('pii_business_glossary_term' = 'Guideline Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `phi_flag` SET TAGS ('pii_business_glossary_term' = 'PHI Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `procedure_code_cpt` SET TAGS ('pii_business_glossary_term' = 'Procedure Code CPT');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `related_encounter_number` SET TAGS ('pii_business_glossary_term' = 'Related Encounter Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `relevance_score` SET TAGS ('pii_business_glossary_term' = 'Relevance Score');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `source_entity_type` SET TAGS ('pii_business_glossary_term' = 'Source Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `storage_path` SET TAGS ('pii_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_ssot_ref' = 'member.member_grievance');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_ssot_concept' = 'member_grievance');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_rename_redirect_applied' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` SET TAGS ('pii_vreq_skip_P201' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `appeal_grievance2_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Grievance ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `appeal_grievance2_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Filing Party ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Header ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `appeal_grievance_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Grievance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `appeal_reference_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `case_notes` SET TAGS ('pii_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `escalation_level` SET TAGS ('pii_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `external_review_outcome` SET TAGS ('pii_business_glossary_term' = 'External Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `external_review_requested` SET TAGS ('pii_business_glossary_term' = 'External Review Requested');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `filing_channel` SET TAGS ('pii_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `filing_party_type` SET TAGS ('pii_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `grievance_type` SET TAGS ('pii_business_glossary_term' = 'Grievance Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `investigation_end_date` SET TAGS ('pii_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `investigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `is_appeal` SET TAGS ('pii_business_glossary_term' = 'Is Appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `related_encounter_number` SET TAGS ('pii_business_glossary_term' = 'Related Encounter Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `resolution_detail` SET TAGS ('pii_business_glossary_term' = 'Resolution Detail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `resolution_type` SET TAGS ('pii_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ALTER COLUMN `zip_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_ssot_ref' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_ssot_concept' = 'credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` SET TAGS ('pii_vreq_skip_P202' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `appeal_document2_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `appeal_document_description` SET TAGS ('pii_business_glossary_term' = 'Appeal Document Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `appeal_document_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `considered_in_decision` SET TAGS ('pii_business_glossary_term' = 'Considered in Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Format');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `is_redacted` SET TAGS ('pii_business_glossary_term' = 'Is Redacted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `phi_classification` SET TAGS ('pii_business_glossary_term' = 'PHI Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `redaction_status` SET TAGS ('pii_business_glossary_term' = 'Redaction Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `storage_path` SET TAGS ('pii_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_ssot_ref' = 'member.member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_ssot_concept' = 'member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` SET TAGS ('pii_vreq_skip_P203' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `appeal_communication2_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Communication ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Primary Appeal Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `accessibility_accommodation` SET TAGS ('pii_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `appeal_communication_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Communication Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `attachment_indicator` SET TAGS ('pii_business_glossary_term' = 'Attachment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `body_text` SET TAGS ('pii_business_glossary_term' = 'Body Text');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `communication_category` SET TAGS ('pii_business_glossary_term' = 'Communication Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `communication_number` SET TAGS ('pii_business_glossary_term' = 'Communication Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `communication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Communication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `communication_type` SET TAGS ('pii_business_glossary_term' = 'Communication Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `created_by_user_role` SET TAGS ('pii_business_glossary_term' = 'Created By User Role');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `delivery_confirmation_flag` SET TAGS ('pii_business_glossary_term' = 'Delivery Confirmation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `direction` SET TAGS ('pii_business_glossary_term' = 'Direction');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `is_physical_mail` SET TAGS ('pii_business_glossary_term' = 'Is Physical Mail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `language` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `language` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `last_modified_by_user_role` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Role');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `party_type` SET TAGS ('pii_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `priority_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `regulatory_notice_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notice Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `response_received_date` SET TAGS ('pii_business_glossary_term' = 'Response Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `response_received_flag` SET TAGS ('pii_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `returned_mail_date` SET TAGS ('pii_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `returned_mail_flag` SET TAGS ('pii_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `sent_date` SET TAGS ('pii_business_glossary_term' = 'Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Subject');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_ssot_ref' = 'finance.finance_regulatory_filing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_ssot_concept' = 'finance_regulatory_filing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_vreq_skip_P211' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('pii_rename_applied' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Regulatory Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `acknowledgment_received` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Received');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `corrective_action_plan` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `deficiency_description` SET TAGS ('pii_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `deficiency_notice` SET TAGS ('pii_business_glossary_term' = 'Deficiency Notice');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_amount` SET TAGS ('pii_business_glossary_term' = 'Filing Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('pii_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('pii_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_version` SET TAGS ('pii_business_glossary_term' = 'Filing Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `reporting_period` SET TAGS ('pii_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `resubmission_date` SET TAGS ('pii_business_glossary_term' = 'Resubmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `resubmission_required` SET TAGS ('pii_business_glossary_term' = 'Resubmission Required');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_id` SET TAGS ('pii_business_glossary_term' = 'appeal_document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` SET TAGS ('pii_subdomain' = 'supporting_documentation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_id` SET TAGS ('pii_business_glossary_term' = 'appeal_grievance Identifier');
