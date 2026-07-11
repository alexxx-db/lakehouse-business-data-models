-- Schema for Domain: appeal | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 20:47:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`appeal` COMMENT 'Manages member and provider appeals and grievances including claim denials, coverage disputes, utilization management appeals, external review requests, and state fair hearing processes. Tracks appeal status, resolution timelines, overturn rates, and compliance with state and federal appeal rights (ACA, ERISA). Distinct from compliance (which owns regulatory audit and reporting) and utilization (which owns initial authorization decisions).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`case` (
    `case_id` BIGINT COMMENT 'System generated unique identifier for the appeal case record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Appeal case assignment process requires linking each case to the employee handling it for tracking case manager workload and regulatory reporting.',
    `header_id` BIGINT COMMENT 'Identifier of the claim that triggered the appeal.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each appeal case is subject to a regulatory obligation (e.g., timeliness); linking enables monitoring of compliance with that obligation.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Appeal adjudication must reference the governing provider contract to apply correct fee schedule, risk‑share and compliance rules per CMS regulations.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for employer‑level appeal reporting mandated by ACA regulations to track number of appeals per employer group.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for the Plan‑Level Appeal Performance Report which aggregates appeal outcomes by health plan for regulatory compliance; appeals are always filed under a specific members health plan.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who filed or is subject to the appeal.',
    `service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Service‑area‑specific appeals are evaluated against the service area regulations; the appeal must reference the relevant service_area.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: Identifying the contract party that filed the appeal enables party‑level appeal metrics and regulatory reporting required by state insurance oversight.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Many appeals contest plan election outcomes; linking to the specific plan election record supports the Plan Election Appeal audit.',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Required for the Invoice Appeal process; the appeal case must reference the specific premium invoice under dispute, enabling audit and resolution reporting.',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: Needed for Payment Appeal workflow; links the appeal case to the exact payment being contested, supporting regulatory reporting of disputed payments.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Provider Appeal Summary Report tracks which provider is the respondent for each appeal case.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network Adequacy Appeal Review report requires linking each appeal to the provider network under which the provider was contracted.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Required for the Credential Verification for Appeal report that checks provider credential status when a claim denial triggers an appeal.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key reference to risk member risk score',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for Enrollment Denial Appeal Report: ties each appeal case to the specific enrollment transaction that was denied, enabling audit of enrollment‑related appeals.',
    `appeal_assigned_to` STRING COMMENT 'Internal team or individual responsible for handling the appeal.',
    `appeal_escalation_flag` BOOLEAN COMMENT 'True if the appeal was escalated beyond the initial review level.',
    `appeal_number` STRING COMMENT 'External reference number assigned to the appeal by the plan.',
    `appeal_priority` STRING COMMENT 'Priority level assigned to the appeal for processing.. Valid values are `high|medium|low`',
    `appeal_review_cycle_days` STRING COMMENT 'Number of calendar days from filing to final decision.',
    `appeal_status` STRING COMMENT 'Current lifecycle status of the appeal.. Valid values are `open|in_review|closed|withdrawn|dismissed|remanded`',
    `appeal_type` STRING COMMENT 'Category of appeal based on level and review pathway.. Valid values are `first_level_internal|second_level_internal|expedited|external_review|state_fair_hearing`',
    `clinical_criteria_applied` STRING COMMENT 'Specific clinical guidelines or criteria used in the decision (e.g., InterQual code).',
    `completeness_determination` STRING COMMENT 'Indicates whether the appeal package was deemed complete at intake.. Valid values are `complete|incomplete`',
    `decision_author_npi` STRING COMMENT 'National Provider Identifier of the clinician or committee authorizing the decision.',
    `decision_rationale` STRING COMMENT 'Explanation of the clinical and policy reasoning behind the decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time the appeal decision was rendered.',
    `decision_type` STRING COMMENT 'Outcome of the appeal decision.. Valid values are `upheld|overturned|partially_overturned|withdrawn|dismissed|remanded`',
    `effective_benefit_change_date` DATE COMMENT 'Date when the benefit change resulting from the decision becomes effective.',
    `expedited_clinical_urgency_basis` STRING COMMENT 'Narrative justification for expedited status (e.g., life‑threatening condition).',
    `expedited_trigger` BOOLEAN COMMENT 'True if the appeal qualified for expedited processing based on clinical urgency.',
    `filing_channel` STRING COMMENT 'Method used to submit the appeal.. Valid values are `member_portal|provider_portal|phone|fax|email|mail`',
    `filing_method` STRING COMMENT 'Technical method of filing (e.g., electronic upload, paper mail).. Valid values are `electronic|paper|fax`',
    `filing_party_type` STRING COMMENT 'Entity that filed the appeal.. Valid values are `member|provider|authorized_rep`',
    `filing_timestamp` TIMESTAMP COMMENT 'Date and time the appeal was received by the plan.',
    `line_of_business` STRING COMMENT 'Business line to which the appeal belongs.. Valid values are `medical|dental|vision|pharmacy|wellness`',
    `member_notification_date` DATE COMMENT 'Date the member was notified of the appeal outcome.',
    `original_claim_number` STRING COMMENT 'External claim number associated with the appealed claim.',
    `overturn_reason` STRING COMMENT 'Reason why the original benefit determination was overturned, if applicable.',
    `provider_notification_date` DATE COMMENT 'Date the provider was notified of the appeal outcome.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the appeal case record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appeal case record.',
    `regulatory_tier` STRING COMMENT 'Regulatory framework governing the appeal rights.. Valid values are `ACA|ERISA|Medicare|Medicaid|CHIP`',
    `related_diagnosis_code` STRING COMMENT 'ICD diagnosis code linked to the appealed service.',
    `related_drug_ndc` STRING COMMENT 'National Drug Code of the medication involved, if a pharmacy appeal.',
    `related_service_code` STRING COMMENT 'CPT code of the service at issue in the appeal.',
    `supporting_documentation_checklist` STRING COMMENT 'List of required documents attached to the appeal (e.g., medical records, provider notes).',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Core master record for every formal appeal filed by a member, provider, or authorized representative contesting an adverse benefit determination (ABD). Captures appeal type (first-level internal, second-level internal, expedited, external independent review, state fair hearing), regulatory tier (ACA, ERISA, Medicare Part C/D, Medicaid/CHIP), line-of-business classification, and appeal level tracking for multi-level appeal processes. Includes filing details (channel, filing party type, receipt timestamp, filing method, completeness determination, expedited trigger, supporting documentation checklist), resolution details (decision type — upheld, overturned, partially overturned, withdrawn, dismissed, remanded — decision rationale, clinical criteria applied, decision author NPI or committee ID, decision date, effective date of benefit change, member/provider notification date), and overturn reason. Also tracks expedited appeal attributes (clinical urgency basis, 72-hour clock, treating provider attestation) when applicable. Primary SSOT for appeal identity, filing, resolution, and outcome in the appeal domain. Serves as the binding record of plan decision for regulatory reporting, HEDIS measurement, downstream claim reprocessing triggers, and benefit restoration workflows.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` (
    `adverse_determination_id` BIGINT COMMENT 'System‑generated unique identifier for the adverse benefit determination record.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Adverse determinations are audited for compliance; linking each determination to its audit finding supports audit trail and corrective actions.',
    `header_id` BIGINT COMMENT 'Identifier of the claim that triggered the adverse determination.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the adverse determination applies.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior authorization associated with the determination, if applicable.',
    `prior_authorization_id` BIGINT COMMENT 'Identifier of the prior authorization request linked to the determination.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Adverse Determination Provider Report needs a direct FK to provider for audit and risk analysis.',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal must be filed.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member is eligible to appeal the determination under applicable regulations.',
    `appeal_filed_date` DATE COMMENT 'Date on which the member filed an appeal.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal relative to the original adverse determination.. Valid values are `upheld|overturned|modified|withdrawn`',
    `appeal_resolution_date` DATE COMMENT 'Date the appeal decision was rendered.',
    `appeal_status` STRING COMMENT 'Current status of any appeal associated with the determination.. Valid values are `not_filed|filed|under_review|resolved|denied`',
    `basis_of_denial` STRING COMMENT 'High‑level category explaining the basis for the adverse determination.. Valid values are `medical_necessity|benefit_exclusion|out_of_network|experimental|policy_limit|other`',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical guideline (InterQual or MCG) applied in the decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the determination record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary fields.. Valid values are `USD|EUR|GBP`',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the primary reason for denial (e.g., CMS‑DRG, internal code).',
    `denial_reason_description` STRING COMMENT 'Narrative description of why the claim or service was denied.',
    `determination_date` TIMESTAMP COMMENT 'Timestamp when the adverse determination was issued.',
    `determination_number` STRING COMMENT 'Human‑readable business identifier assigned to the determination (e.g., ABD‑2023‑000123).',
    `determination_status` STRING COMMENT 'Current workflow status of the determination.. Valid values are `open|closed|overturned|pending`',
    `determination_type` STRING COMMENT 'Category of the adverse action issued by the health plan.. Valid values are `denial|reduction|termination|non_authorization`',
    `diagnosis_code` STRING COMMENT 'Diagnosis code associated with the service.',
    `effective_date` DATE COMMENT 'Date on which the adverse determination becomes effective for the member.',
    `monetary_amount_adjusted` DECIMAL(18,2) COMMENT 'Any monetary adjustment applied after the initial denial (e.g., partial payment).',
    `monetary_amount_denied` DECIMAL(18,2) COMMENT 'Dollar amount of benefit that was denied or reduced.',
    `network_status` STRING COMMENT 'Network relationship of the provider for the denied service.. Valid values are `in_network|out_of_network|preferred|non_preferred`',
    `notes` STRING COMMENT 'Free‑form notes entered by the reviewer or adjudicator.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates if a prior authorization was required for the service.',
    `reviewer_name` STRING COMMENT 'Full name of the reviewer who issued the determination.',
    `reviewer_npi` STRING COMMENT 'NPI of the clinician or reviewer who made the adverse determination.',
    `service_code` STRING COMMENT 'Procedure code for the service that was denied.',
    `service_date` DATE COMMENT 'Date on which the denied service was rendered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the determination record.',
    CONSTRAINT pk_adverse_determination PRIMARY KEY(`adverse_determination_id`)
) COMMENT 'Records every adverse benefit determination (ABD) issued by the health plan — the triggering event for member and provider appeal rights. Captures determination type (denial, reduction, termination, non-authorization), basis for denial (medical necessity, benefit exclusion, out-of-network, experimental), clinical criteria applied (InterQual/MCG guideline version), issuing reviewer NPI, determination date, effective date, and the specific claim, authorization, or enrollment action being denied. Links to the originating claim or prior authorization in the claim and utilization domains. Owned by the appeal domain as the formal adverse action record.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`review` (
    `review_id` BIGINT COMMENT 'System-generated unique identifier for each appeal review record.',
    `case_id` BIGINT COMMENT 'Foreign key to the parent appeal case that this review addresses.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Appeal reviewers must reference the providers credential record to assess if credentialing caused the denial, per the Appeal Review Credential Check process.',
    `appeal_case_number` STRING COMMENT 'Business identifier of the appeal case linked to this review.',
    `appeal_reason_code` STRING COMMENT 'Standardized code describing the reason for the original appeal.',
    `appeal_status_at_review` STRING COMMENT 'Status of the appeal case at the time the review was performed.',
    `appeal_submission_date` DATE COMMENT 'Date the appeal was originally submitted by the member or provider.',
    `clinical_rationale` STRING COMMENT 'Narrative explanation of the clinical reasoning behind the review decision.',
    `compliance_flag` BOOLEAN COMMENT 'Result of the NCQA/URAC compliance check for reviewer independence.',
    `cpt_codes_reviewed` STRING COMMENT 'Comma‑separated list of CPT procedure codes examined during the review.',
    `criteria_version` STRING COMMENT 'Version of the clinical criteria set (e.g., InterQual v2023) applied during the review.',
    `drg_code` STRING COMMENT 'DRG code associated with the claim under review.',
    `duration_minutes` STRING COMMENT 'Total time in minutes spent on the review from start to completion.',
    `icd_codes_reviewed` STRING COMMENT 'Comma‑separated list of ICD diagnosis codes evaluated in the review.',
    `is_independent_reviewer` BOOLEAN COMMENT 'Indicates whether the reviewer was independent of the original adverse determination (true/false).',
    `location` STRING COMMENT 'Physical or virtual location where the review was conducted.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the reviewer.',
    `number` STRING COMMENT 'Business-visible sequential number assigned to the review for tracking and reference.',
    `outcome` STRING COMMENT 'Result of the review after clinical evaluation.. Valid values are `approved|denied|partial|escalated|withdrawn`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `reviewer_npi` STRING COMMENT 'Unique NPI of the clinical reviewer who performed the review.',
    `reviewer_specialty` STRING COMMENT 'Clinical specialty of the reviewer (e.g., cardiology, orthopedics).',
    `reviewer_type` STRING COMMENT 'Classification of the reviewer role for the review.. Valid values are `clinical|peer|medical_director|committee`',
    `review_status` STRING COMMENT 'Current lifecycle state of the review.. Valid values are `pending|in_progress|completed|rejected|overturned|closed`',
    `timestamp` TIMESTAMP COMMENT 'Date and time when the review was performed.',
    `review_type` STRING COMMENT 'Level or tier of the review within the appeal process.. Valid values are `initial|second_level|medical_director|committee`',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Tracks each discrete review action performed on an appeal case — first-level clinical review, second-level peer review, medical director review, and committee review. Captures reviewer identity (NPI for clinical reviewers), reviewer specialty, review type, review date, review outcome, clinical rationale, criteria applied (ICD/CPT codes reviewed, DRG, InterQual/MCG criteria version), and whether the review was conducted by a reviewer not involved in the original adverse determination. Supports NCQA and URAC reviewer independence requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` (
    `external_review_id` BIGINT COMMENT 'System-generated unique identifier for the external review case.',
    `case_id` BIGINT COMMENT 'Identifier assigned by the IRO to this review case.',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim that triggered the external review.',
    `iro_organization_id` BIGINT COMMENT 'Unique identifier of the external independent review organization handling the case.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who initiated the external review.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider associated with the claim under review.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: External review organizations need the providers credential record to validate eligibility during independent appeal assessments.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any monetary adjustment (e.g., fee, discount) applied during the review.',
    `appeal_reason_code` STRING COMMENT 'Standardized code representing the member’s reason for requesting external review.',
    `appeal_reason_description` STRING COMMENT 'Full textual description of the appeal reason.',
    `binding_determination_flag` BOOLEAN COMMENT 'Indicates whether the IRO decision is binding on the plan (true) or advisory (false).',
    `claim_amount` DECIMAL(18,2) COMMENT 'Original claim dollar amount submitted for the service.',
    `compliance_action_taken` STRING COMMENT 'Plan‑level corrective or administrative action taken to comply with the IRO decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the external review record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values (e.g., USD).',
    `deadline_date` DATE COMMENT 'Latest date by which the IRO must render a decision per regulatory rules.',
    `decision` STRING COMMENT 'Outcome of the external review as determined by the IRO.. Valid values are `uphold|overturn|partial_uphold|partial_overturn|denied|approved`',
    `decision_date` DATE COMMENT 'Calendar date the IRO rendered its decision.',
    `decision_rationale` STRING COMMENT 'Narrative explanation provided by the IRO for its decision.',
    `diagnosis_code` STRING COMMENT 'ICD‑10 diagnosis code associated with the claim.. Valid values are `^[A-TV-Z][0-9][A-Z0-9]{0,3}$`',
    `iro_accreditation_status` STRING COMMENT 'Current accreditation status of the IRO per CMS/ACA requirements.. Valid values are `accredited|pending|revoked`',
    `is_urgent` BOOLEAN COMMENT 'True if the review was flagged as urgent due to clinical necessity.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition for the external review.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after adjustments, as determined by the IRO.',
    `notes` STRING COMMENT 'Free‑form comments captured by the plan staff.',
    `overdue_flag` BOOLEAN COMMENT 'True if the decision deadline has passed without a decision.',
    `patient_relationship` STRING COMMENT 'Relationship of the patient to the member requesting review.. Valid values are `self|spouse|dependent|other`',
    `procedure_code` STRING COMMENT 'Standard CPT code for the procedure under review.. Valid values are `^[0-9]{5}$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this case has been reported to CMS or state DOI.',
    `reporting_status` STRING COMMENT 'Current status of the regulatory report for this case.. Valid values are `not_submitted|submitted|accepted|rejected`',
    `reporting_submission_date` DATE COMMENT 'Date the external review case was submitted to the regulatory reporting system.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the external review request was transmitted to the IRO.',
    `review_category` STRING COMMENT 'High‑level classification of the review focus.. Valid values are `clinical|administrative|coverage`',
    `review_number` STRING COMMENT 'Business-assigned reference number for the external review request.',
    `review_priority` STRING COMMENT 'Priority level assigned to the external review case.. Valid values are `high|medium|low`',
    `service_date` DATE COMMENT 'Date on which the underlying health service was provided.',
    `source` STRING COMMENT 'Origin of the external review request.. Valid values are `member|provider|payer|state`',
    `state` STRING COMMENT 'Two‑letter state code where the member resides or the service was provided.',
    `external_review_status` STRING COMMENT 'Current lifecycle status of the external review case.. Valid values are `pending|received|under_review|decision_made|closed|withdrawn`',
    `transmission_date` DATE COMMENT 'Calendar date the external review request was sent to the IRO.',
    `external_review_type` STRING COMMENT 'Category of service under review.. Valid values are `medical|dental|vision|pharmacy|behavioral`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the external review record.',
    CONSTRAINT pk_external_review PRIMARY KEY(`external_review_id`)
) COMMENT 'Manages Independent Medical Review (IMR) and External Independent Review Organization (IRO) requests — the federally mandated external review process under ACA §2719 and state external review laws. Tracks IRO assignment, IRO accreditation status, case transmission date, IRO decision date, IRO decision (uphold/overturn), IRO clinical rationale, binding determination flag, and plan compliance action taken. Distinct from internal appeal reviews. Supports CMS external review reporting and state DOI compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` (
    `timeline_id` BIGINT COMMENT 'Unique identifier for each appeal timeline record.',
    `case_id` BIGINT COMMENT 'Identifier of the appeal case this timeline belongs to.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Timeline records need to identify which employers HR team is responsible; required for SLA tracking reports.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the appeal.',
    `org_unit_id` BIGINT COMMENT 'Internal team or workgroup responsible for the appeal.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider involved in the appeal.',
    `acknowledgment_due_date` DATE COMMENT 'Date by which the insurer must acknowledge receipt of the appeal.',
    `actual_acknowledgment_date` DATE COMMENT 'Date the insurer actually acknowledged the appeal.',
    `actual_decision_date` DATE COMMENT 'Date the final decision was rendered.',
    `actual_expedited_date` DATE COMMENT 'Date the expedited decision was actually completed.',
    `actual_extension_date` DATE COMMENT 'Date the granted extension became effective.',
    `appeal_category` STRING COMMENT 'High‑level classification of the appeal type.. Valid values are `claim_denial|coverage_dispute|utilization_management|external_review|state_fair_hearing`',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Date and time the appeal was officially submitted.',
    `appeal_origin` STRING COMMENT 'Entity that initiated the appeal.. Valid values are `member|provider|employer|third_party|internal`',
    `appeal_status` STRING COMMENT 'Operational state of the appeal.. Valid values are `open|closed|pending|withdrawn`',
    `breach_flag` BOOLEAN COMMENT 'True when the appeal missed a regulatory deadline.',
    `breach_reason` STRING COMMENT 'Free‑text explanation of why the SLA breach happened.',
    `clock_start_event` STRING COMMENT 'Narrative of the event that triggers the start of the regulatory clock (e.g., claim denial date).',
    `clock_type` STRING COMMENT 'The regulatory framework that defines the appeals timing requirements.. Valid values are `ACA|ERISA|Medicare Part C|Medicare Part D|Medicaid|State DOI`',
    `compliance_status` STRING COMMENT 'Indicates whether the appeal met its regulatory deadlines.. Valid values are `on_time|late|extended`',
    `corrective_action` STRING COMMENT 'Description of remediation steps performed after a breach.',
    `days_overdue` STRING COMMENT 'Count of calendar days the appeal missed its deadline.',
    `decision_due_date` DATE COMMENT 'Date by which a final decision on the appeal must be rendered.',
    `expedited_due_date` DATE COMMENT 'Accelerated deadline for decisions that qualify for expedited processing.',
    `extension_notification_date` DATE COMMENT 'Date the member/provider was notified of a deadline extension.',
    `extension_reason` STRING COMMENT 'Explanation provided for why a deadline extension was approved.',
    `jurisdiction_state` STRING COMMENT 'US state code governing the appeals regulatory requirements.. Valid values are `^[A-Z]{2}$`',
    `last_action_timestamp` TIMESTAMP COMMENT 'Date and time of the latest activity on the appeal.',
    `notes` STRING COMMENT 'Supplemental comments or observations about the appeal timeline.',
    `priority` STRING COMMENT 'Business priority for processing the appeal.. Valid values are `high|medium|low`',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time the timeline record was initially loaded.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date and time of the latest modification to the timeline record.',
    `record_version` STRING COMMENT 'Incremental version used to manage concurrent updates.',
    `regulatory_body` STRING COMMENT 'Agency or authority that defines the applicable appeal clock.. Valid values are `CMS|State DOI|HHS|NAIC`',
    `root_cause_category` STRING COMMENT 'Primary reason why a deadline was missed.. Valid values are `staffing|system_error|data_issue|policy_gap|external_delay`',
    `self_report_flag` BOOLEAN COMMENT 'True if the organization voluntarily reported the SLA breach.',
    `sla_actual_days` STRING COMMENT 'Number of days actually taken to complete the required action.',
    `sla_breach` BOOLEAN COMMENT 'True when actual days exceed target days.',
    `sla_target_days` STRING COMMENT 'Number of days defined by the regulatory clock for the required action.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the record in the originating source system.',
    CONSTRAINT pk_timeline PRIMARY KEY(`timeline_id`)
) COMMENT 'Tracks all regulatory and contractual deadline milestones for each appeal case — acknowledgment due date, decision due date, expedited decision due date, extension notification date, and actual completion dates. Captures regulatory clock type (ACA, ERISA, Medicare Part C/D, Medicaid, state DOI), clock start event, clock pause events, compliance status (on-time, late, extended), and SLA breach details (days overdue, root cause category, corrective action, self-report flag) when milestones are missed. Drives proactive SLA management, regulatory timeliness reporting to CMS and state DOIs, and breach tracking for quality improvement programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` (
    `coverage_dispute_id` BIGINT COMMENT 'Unique system-generated identifier for the coverage dispute record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Coverage disputes arise within the context of a specific appeal case; linking provides direct access to case details.',
    `header_id` BIGINT COMMENT 'Identifier of the claim that triggered the dispute.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Coverage disputes may trigger regulatory reporting obligations; linking captures the governing obligation for each dispute.',
    `party_id` BIGINT COMMENT 'System identifier of the party that initiated the dispute.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Eligibility disputes reference the exact eligibility span; needed for the Eligibility Dispute Analysis report required by CMS.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group (if dispute is on behalf of an employer).',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the dispute is being processed.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member involved in the dispute.',
    `prior_authorization_id` BIGINT COMMENT 'Identifier of the prior authorization associated with the disputed service.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider involved in the dispute.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Coverage disputes often arise from credentialing issues; linking to credential_record enables the Dispute Credential Impact analysis.',
    `appeal_deadline` DATE COMMENT 'Last date by which an appeal must be filed.',
    `appeal_filed_date` DATE COMMENT 'Date the appeal was submitted.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process.. Valid values are `pending|granted|denied|withdrawn`',
    `cob_order` STRING COMMENT 'Ordered list of payer responsibilities for the claim (e.g., primary|secondary|tertiary).',
    `cob_rule_applied` STRING COMMENT 'COB rule used to determine payer order for the dispute.. Valid values are `birthday|naic_model|state_specific|custom`',
    `coordination_amount` DECIMAL(18,2) COMMENT 'Monetary amount determined by the coordination of benefits calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Narrative description of the issue being disputed.',
    `dispute_number` STRING COMMENT 'External reference number assigned to the dispute for tracking and communication.',
    `dispute_type` STRING COMMENT 'Category of the coverage dispute indicating the underlying issue.. Valid values are `benefit_interpretation|cob|subrogation|network_status|formulary_exception`',
    `disputed_benefit_code` STRING COMMENT 'Code of the benefit, service, or procedure that is the subject of the dispute.. Valid values are `^[A-Z0-9]{5}$`',
    `disputing_party_type` STRING COMMENT 'Indicates whether the dispute was raised by a member, provider, employer group, or other entity.. Valid values are `member|provider|employer|other`',
    `effective_from` DATE COMMENT 'Date the dispute became effective (typically the date of filing).',
    `effective_until` DATE COMMENT 'Date the dispute was closed or otherwise terminated; null if still open.',
    `formulary_exception_flag` BOOLEAN COMMENT 'True if the dispute relates to a formulary exception request.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the dispute is flagged as high priority due to potential impact.',
    `network_status` STRING COMMENT 'Indicates the network classification of the service at issue.. Valid values are `in_network|out_of_network|preferred|non_preferred`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `other_carrier_code` BIGINT COMMENT 'System identifier of the secondary carrier.',
    `other_carrier_name` STRING COMMENT 'Name of the secondary carrier involved in a COB dispute.',
    `priority_level` STRING COMMENT 'Business‑defined priority for handling the dispute.. Valid values are `low|medium|high|urgent`',
    `regulatory_reference` STRING COMMENT 'Regulatory framework governing the dispute handling.. Valid values are `ACA|ERISA|NAIC|CMS`',
    `resolution_date` DATE COMMENT 'Date on which the dispute was resolved.',
    `resolution_outcome` STRING COMMENT 'Result of the dispute after final adjudication.. Valid values are `overturned|upheld|partial|settled|denied`',
    `coverage_dispute_status` STRING COMMENT 'Current lifecycle status of the dispute.. Valid values are `open|under_review|resolved|closed|reopened|withdrawn`',
    `subrogation_amount` DECIMAL(18,2) COMMENT 'Monetary amount involved in a subrogation claim.',
    `subrogation_flag` BOOLEAN COMMENT 'True if the dispute involves a subrogation scenario.',
    `supporting_document_count` STRING COMMENT 'Count of documents attached to the dispute for evidence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dispute record.',
    CONSTRAINT pk_coverage_dispute PRIMARY KEY(`coverage_dispute_id`)
) COMMENT 'Master record for coverage disputes — formal disagreements between members, providers, or employer groups and the health plan regarding benefit interpretation, plan exclusions, coordination of benefits (COB) determinations, or subrogation decisions. Captures dispute type (benefit interpretation, COB, subrogation, network status, formulary exception), disputing party, disputed benefit or service, plan position, and resolution outcome. For COB disputes, additionally captures other carrier information, COB rule applied (birthday rule, NAIC COB model), disputed payer order, coordination amount, and inter-plan communication records. Supports ERISA plan document interpretation, NAIC COB model law compliance, and state DOI market conduct requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` (
    `iro_organization_id` BIGINT COMMENT 'Unique system-generated identifier for the Independent Review Organization.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: REQUIRED: IROs are external vendors; linking enables compliance reports and performance metrics for each IRO contract.',
    `accreditation_body` STRING COMMENT 'Accrediting organization for the IRO.. Valid values are `URAC|NCQA|Other`',
    `accreditation_expiration_date` DATE COMMENT 'Date when the IROs accreditation expires.',
    `accreditation_review_notes` STRING COMMENT 'Notes from the latest accreditation review.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the IRO.. Valid values are `accredited|not_accredited|pending|revoked`',
    `address_line1` STRING COMMENT 'First line of the IROs mailing address.',
    `address_line2` STRING COMMENT 'Second line of the IROs mailing address, if applicable.',
    `approved_states` STRING COMMENT 'Comma-separated list of state codes where the IRO is approved.',
    `assignment_rotation_methodology` STRING COMMENT 'Methodology used to rotate case assignments among IROs (e.g., round-robin, random).',
    `city` STRING COMMENT 'City component of the IROs mailing address.',
    `compliance_requirements` STRING COMMENT 'Regulatory compliance requirements applicable to the IRO (e.g., ACA §2719).',
    `conflict_of_interest_attestation_date` DATE COMMENT 'Date when the IRO provided a conflict-of-interest attestation.',
    `contract_effective_end_date` DATE COMMENT 'End date of the contract with the IRO.',
    `contract_effective_start_date` DATE COMMENT 'Start date of the contract with the IRO.',
    `country` STRING COMMENT 'Country code (ISO 3166-1 alpha-3) of the IROs mailing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IRO record was first created in the system.',
    `email` STRING COMMENT 'Primary email address for contacting the IRO.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_review_scope` STRING COMMENT 'Scope of reviews performed by the IRO (e.g., medical, pharmacy, dental).',
    `is_conflict_of_interest` BOOLEAN COMMENT 'Indicates whether a conflict of interest was identified (True/False).',
    `is_state_approved` BOOLEAN COMMENT 'Indicates if the IRO is currently approved in all required states (True/False).',
    `last_accreditation_review_date` DATE COMMENT 'Date of the most recent accreditation review.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the IRO record.',
    `iro_organization_name` STRING COMMENT 'Legal name of the Independent Review Organization.',
    `organization_type` STRING COMMENT 'Category of the IRO based on its role and accreditation.. Valid values are `independent_review_organization|external_review_entity|other`',
    `phone` STRING COMMENT 'Primary telephone number for the IRO.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the IROs mailing address.',
    `rotation_cycle_months` STRING COMMENT 'Number of months in each rotation cycle.',
    `specialty_capabilities` STRING COMMENT 'List of medical specialties the IRO is qualified to review.',
    `state` STRING COMMENT 'State or province component of the IROs mailing address.',
    `state_approval_status` STRING COMMENT 'Overall state-level approval status for the IRO.. Valid values are `approved|pending|denied|revoked`',
    `iro_organization_status` STRING COMMENT 'Current operational status of the IRO.. Valid values are `active|inactive|suspended|pending|terminated`',
    CONSTRAINT pk_iro_organization PRIMARY KEY(`iro_organization_id`)
) COMMENT 'Master reference for Independent Review Organizations (IROs) and external review entities contracted or approved to conduct external independent reviews. Captures IRO name, URAC/NCQA accreditation status, accreditation expiration date, state approval status (by state), specialty capabilities, conflict-of-interest attestation date, contract effective dates, and assignment rotation methodology. Required for ACA §2719 external review compliance and state external review law adherence. Distinct from the provider and contract domains — IROs are specialized regulatory entities, not clinical providers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` (
    `expedited_review_id` BIGINT COMMENT 'System‑generated unique identifier for each expedited review request.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Expedited reviews are a specialized review type for an appeal case; the existing appeal_reference_number duplicates the case identifier and can be removed.',
    `header_id` BIGINT COMMENT 'Identifier of the health claim associated with the expedited review request.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member requesting the expedited review.',
    `parent_expedited_review_id` BIGINT COMMENT 'Self-referencing FK on expedited_review (parent_expedited_review_id)',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Expedited Review tracking requires linking the reviewed provider to the review record for SLA monitoring.',
    `actual_decision_date` DATE COMMENT 'Date the final decision for the expedited review was entered into the system.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustments (e.g., discounts, penalties) applied as a result of the expedited review.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Total dollar amount billed on the original claim.',
    `clinical_urgency_classification` STRING COMMENT 'Categorization of the clinical urgency that drives the expedited decision deadline.. Valid values are `high|medium|low`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the review triggered any compliance or regulatory follow‑up.',
    `created_timestamp` TIMESTAMP COMMENT 'When the expedited review record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter currency identifier (e.g., USD).',
    `decision_due_date` DATE COMMENT 'Regulatory or contractual deadline for completing the expedited review.',
    `decision_outcome` STRING COMMENT 'Result of the expedited review (e.g., claim upheld, denied, partially approved).. Valid values are `upheld|overturned|partial|withdrawn`',
    `decision_rationale` STRING COMMENT 'Clinical and policy rationale supporting the final decision.',
    `expedited_notification_required` BOOLEAN COMMENT 'True if the member must receive a notification within the expedited timeline.',
    `expedited_reason` STRING COMMENT 'Business‑defined reason that qualifies the request for an expedited timeline.. Valid values are `life_threatening|severe_illness|functional_impairment|other`',
    `is_confidential` BOOLEAN COMMENT 'True if the expedited review record includes protected health information.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after applying adjustments from the expedited review.',
    `notes` STRING COMMENT 'Additional comments or observations related to the expedited review.',
    `notification_method` STRING COMMENT 'Channel through which the member was notified of the decision.. Valid values are `email|mail|portal|phone`',
    `notified_timestamp` TIMESTAMP COMMENT 'Date‑time the notification was sent to the member.',
    `regulatory_body` STRING COMMENT 'Governing agency (e.g., CMS or state authority) that mandates the expedited review.. Valid values are `CMS|State`',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time the member or provider submitted the expedited review request.',
    `review_request_number` STRING COMMENT 'External reference number used in communications and reporting for the expedited review.',
    `state_code` STRING COMMENT 'US state code relevant to the expedited review jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `expedited_review_status` STRING COMMENT 'Indicates the processing stage of the expedited review request.. Valid values are `pending|under_review|approved|denied|closed`',
    `supporting_document_count` STRING COMMENT 'Number of documents (e.g., medical records) submitted with the expedited request.',
    `updated_timestamp` TIMESTAMP COMMENT 'When the expedited review record was most recently modified.',
    CONSTRAINT pk_expedited_review PRIMARY KEY(`expedited_review_id`)
) COMMENT 'Tracks expedited appeal review requests where standard timeframes could jeopardize the members life, health, or ability to regain maximum function. Captures expedited request reason, clinical urgency classification, shortened decision timeline, and expedited notification requirements per CMS and state regulations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` (
    `outcome_id` BIGINT COMMENT 'System-generated unique identifier for the appeal outcome record.',
    `case_id` BIGINT COMMENT 'Identifier of the original appeal case to which this outcome belongs.',
    `header_id` BIGINT COMMENT 'Identifier of the claim that was the subject of the appeal.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Outcome reporting per employer is required for financial impact analysis and employer‑specific compliance dashboards.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the appeal.',
    `parent_outcome_id` BIGINT COMMENT 'Self-referencing FK on outcome (parent_outcome_id)',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider associated with the appeal.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the appeal outcome complies with applicable regulations and internal policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the appeal outcome record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the financial impact amount. [ENUM-REF-CANDIDATE: USD|EUR|CAD|GBP|JPY|AUD — promote to reference product]',
    `downstream_action` STRING COMMENT 'Action triggered downstream as a result of the appeal outcome.. Valid values are `claim_reprocess|authorization_issue|none|other`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary amount restored to the member as a result of the appeal outcome.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state code where the appeal was adjudicated. [ENUM-REF-CANDIDATE: CA|NY|TX|FL|IL|PA — promote to reference product]',
    `member_notification_timestamp` TIMESTAMP COMMENT 'Date and time the member was notified of the appeal outcome.',
    `notes` STRING COMMENT 'Free‑form notes captured by the reviewer or system regarding the outcome.',
    `number` STRING COMMENT 'External reference number assigned to the appeal outcome for tracking and reporting.',
    `provider_notification_timestamp` TIMESTAMP COMMENT 'Date and time the provider was notified of the appeal outcome.',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for the appeal outcome.',
    `reason_description` STRING COMMENT 'Narrative description of the reason behind the appeal outcome.',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the appeal outcome (e.g., CMS, state insurance department).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the record in the source system.',
    `outcome_status` STRING COMMENT 'Current lifecycle status of the appeal outcome record.. Valid values are `pending|completed|archived|reversed`',
    `timestamp` TIMESTAMP COMMENT 'Date and time when the appeal outcome was rendered.',
    `outcome_type` STRING COMMENT 'Classification of the final disposition of the appeal.. Valid values are `overturn|uphold|partial_overturn|withdrawn|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appeal outcome record.',
    CONSTRAINT pk_outcome PRIMARY KEY(`outcome_id`)
) COMMENT 'Records the final disposition and outcome of an appeal case after all levels of review are exhausted — including overturn, uphold, partial overturn, and withdrawn outcomes. Captures outcome date, outcome type, financial impact (claim amount restored), member notification date, and downstream action triggers (claim reprocessing, authorization issuance).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` (
    `penalty_id` BIGINT COMMENT 'Unique system-generated identifier for each appeal penalty record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Penalty assessments arise from violations of specific regulatory obligations; linking ensures traceability for audit and reporting.',
    `health_plan_id` BIGINT COMMENT 'Reference to the plan entity that incurred the penalty.',
    `identity_id` BIGINT COMMENT 'Member whose claim or appeal triggered the penalty, when relevant.',
    `parent_penalty_id` BIGINT COMMENT 'Self-referencing FK on penalty (parent_penalty_id)',
    `provider_id` BIGINT COMMENT 'Provider linked to the penalty event, when relevant.',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary value assessed before any adjustments.',
    `appeal_deadline` DATE COMMENT 'Last date the plan or member may contest the penalty.',
    `appeal_filed_date` DATE COMMENT 'Date the appeal against the penalty was received.',
    `appeal_filed_flag` BOOLEAN COMMENT 'True if an appeal was submitted, otherwise false.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal after review.. Valid values are `upheld|reversed|modified|withdrawn`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Exact date and time the penalty became effective.',
    `audit_trail` STRING COMMENT 'Path or identifier for detailed audit records related to the penalty.',
    `penalty_category` STRING COMMENT 'High‑level grouping of the penalty purpose.. Valid values are `financial|operational|clinical|administrative`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the underlying process was in compliance when the penalty was issued.',
    `currency_code` STRING COMMENT 'Three‑letter code representing the currency of the penalty.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Deadline for payment to avoid additional sanctions.',
    `effective_from` DATE COMMENT 'Start date of the penaltys enforceability.',
    `effective_until` DATE COMMENT 'End date after which the penalty is no longer applicable.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Additional monetary charge accrued on the penalty.',
    `notes` STRING COMMENT 'Additional comments or contextual information.',
    `number` STRING COMMENT 'Business-assigned identifier used in regulatory filings and internal tracking.',
    `payment_date` DATE COMMENT 'Date on which the penalty amount was settled.',
    `payment_status` STRING COMMENT 'Indicates whether the penalty has been paid or remains outstanding.. Valid values are `unpaid|paid|partial|settled`',
    `reason_code` STRING COMMENT 'Compact code used by the organization to categorize penalty causes.. Valid values are `^[A-Z0-9]{3,10}$`',
    `reason_description` STRING COMMENT 'Narrative explanation of why the penalty was assessed.',
    `record_audit_created` TIMESTAMP COMMENT 'Date‑time the row was initially loaded.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date‑time of the latest modification.',
    `regulatory_body` STRING COMMENT 'Government or oversight entity that issued the penalty.. Valid values are `CMS|DOI|State|Federal|Other`',
    `regulatory_reference` STRING COMMENT 'Legal or regulatory provision that the penalty addresses.',
    `severity` STRING COMMENT 'Risk or impact rating assigned to the penalty.. Valid values are `low|medium|high|critical`',
    `source_record_reference` STRING COMMENT 'Primary key of the penalty record in the source system.',
    `penalty_status` STRING COMMENT 'Workflow state of the penalty record.. Valid values are `assessed|appealed|paid|waived|reversed|closed`',
    `total_amount` DECIMAL(18,2) COMMENT 'Net amount payable after interest and any reductions.',
    `penalty_type` STRING COMMENT 'Classification of the penalty based on its source or nature.. Valid values are `civil_money|state_fine|auto_approval|other`',
    CONSTRAINT pk_penalty PRIMARY KEY(`penalty_id`)
) COMMENT 'Tracks regulatory penalties, sanctions, and financial consequences imposed on the health plan for non-compliance with appeal processing requirements — including CMS Civil Money Penalties (CMPs), state DOI fines, and auto-approval penalties for missed turnaround times.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Unique identifier for the appeal evidence record.',
    `parent_evidence_id` BIGINT COMMENT 'Self-referencing FK on evidence (parent_evidence_id)',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Evidence Source Attribution Report links evidence submitted by a provider to the provider entity.',
    `case_id` BIGINT COMMENT 'Identifier of the appeal to which this evidence is attached.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior authorization related to the evidence.',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with the evidence, if applicable.',
    `author_name` STRING COMMENT 'Full name of the author of the evidence.',
    `author_npi` STRING COMMENT 'National Provider Identifier of the author of the evidence, if applicable.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA-256) for file integrity verification.',
    `clinical_code_icd10` STRING COMMENT 'Associated ICD-10 diagnosis code(s) referenced in the evidence.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates if the evidence contains confidential information requiring restricted handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence record was created in the system.',
    `evidence_description` STRING COMMENT 'Detailed description of the evidence content and purpose.',
    `drg_code` STRING COMMENT 'Diagnosis Related Group code associated with the evidence.',
    `effective_date` DATE COMMENT 'Date when the evidence becomes effective for the appeal review.',
    `expiration_date` DATE COMMENT 'Date after which the evidence is no longer considered valid.',
    `file_format` STRING COMMENT 'File format of the digital evidence document. [ENUM-REF-CANDIDATE: pdf|docx|txt|jpg|png|tiff|xml|json — 8 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Size of the evidence file in bytes.',
    `guideline_version` STRING COMMENT 'Version of the clinical guideline cited in the evidence.',
    `ndc_code` STRING COMMENT 'National Drug Code if the evidence pertains to a medication.',
    `notes` STRING COMMENT 'Free-text notes or comments about the evidence.',
    `number` STRING COMMENT 'Business identifier assigned to the evidence by the source system.',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether the evidence includes protected health information.',
    `procedure_code_cpt` STRING COMMENT 'Associated CPT procedure code(s) referenced in the evidence.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence was received by the processing system.',
    `related_encounter_number` BIGINT COMMENT 'Identifier of the clinical encounter linked to the evidence.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Numeric score indicating the relevance of the evidence to the appeal (0-100).',
    `source_entity_type` STRING COMMENT 'Type of entity that provided the evidence.. Valid values are `member|provider|external|internal`',
    `source_system_record_code` STRING COMMENT 'Identifier of the original record in the source system.',
    `evidence_status` STRING COMMENT 'Current processing status of the evidence.. Valid values are `pending|reviewed|accepted|rejected|withdrawn`',
    `storage_path` STRING COMMENT 'Logical storage location or URI where the evidence file is stored.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence was submitted to the appeal process.',
    `title` STRING COMMENT 'Brief title describing the evidence.',
    `evidence_type` STRING COMMENT 'Category of the evidence submitted for the appeal. [ENUM-REF-CANDIDATE: medical_record|clinical_guideline|peer_reviewed_literature|expert_opinion|lab_result|imaging|authorization|other — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the evidence record.',
    `version_number` STRING COMMENT 'Version of the evidence document, incremented on updates.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Master record for clinical and non-clinical evidence submitted or gathered during the appeal review process — medical records, clinical guidelines cited, peer-reviewed literature, and expert opinions. Distinct from appeal_document (which tracks document logistics) by focusing on the evidentiary substance and its weight in the review decision.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` (
    `appeal_communication_id` BIGINT COMMENT 'System-generated unique identifier for each appeal communication record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Communications are part of an appeal case workflow; linking them to the case enables chronological tracking.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Communications (e.g., status updates) are often sent to the employer; FK supports employer notification logs required for audit.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `accessibility_accommodation` STRING COMMENT 'Any accommodation provided for accessibility (e.g., large print, braille, interpreter).. Valid values are `large_print|braille|interpreter|none`',
    `appeal_communication_status` STRING COMMENT 'Current lifecycle status of the communication (e.g., pending, sent, delivered, failed, returned, closed).. Valid values are `pending|sent|delivered|failed|returned|closed`',
    `attachment_count` STRING COMMENT 'Number of attachments included with the communication.',
    `attachment_indicator` BOOLEAN COMMENT 'True if the communication includes one or more attachments.',
    `body_text` STRING COMMENT 'Full textual content of the communication.',
    `appeal_communication_category` STRING COMMENT 'High‑level classification of the communication purpose.. Valid values are `member_notice|provider_notice|grievance|legal|other`',
    `channel` STRING COMMENT 'Medium used to deliver the communication.. Valid values are `mail|phone|secure_portal|fax|email`',
    `compliance_flag` BOOLEAN COMMENT 'True if the communication meets all applicable compliance requirements.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding compliance considerations for the communication.',
    `created_by_user_role` STRING COMMENT 'Role of the user who created the record.. Valid values are `admin|agent|system|other`',
    `delivery_confirmation_date` DATE COMMENT 'Date on which delivery confirmation was received.',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'True if delivery of the communication was confirmed by the recipient.',
    `direction` STRING COMMENT 'Indicates whether the communication was sent to the party (outbound) or received from the party (inbound).. Valid values are `outbound|inbound`',
    `escalation_date` DATE COMMENT 'Date the communication was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the communication has been escalated for higher‑level review.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the communication contains confidential or PHI content.',
    `is_physical_mail` BOOLEAN COMMENT 'True if the communication was delivered via physical mail.',
    `language` STRING COMMENT 'Language code of the communication content.',
    `last_modified_by_user_role` STRING COMMENT 'Role of the user who last modified the record.. Valid values are `admin|agent|system|other`',
    `notes` STRING COMMENT 'Free‑form internal notes related to the communication.',
    `number` STRING COMMENT 'Human‑readable business identifier assigned to the communication for tracking and reference.',
    `party_type` STRING COMMENT 'Classification of the party involved: member, provider, or other.. Valid values are `member|provider|other`',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the communication is marked as high priority.',
    `priority_level` STRING COMMENT 'Priority classification of the communication.. Valid values are `high|medium|low`',
    `received_date` DATE COMMENT 'Date the communication was received (applicable for inbound messages).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the communication record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the communication record.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework that mandates the communication (e.g., ACA, ERISA, state DOI, CMS, HIPAA).. Valid values are `ACA|ERISA|state_DIO|CMS|HIPAA`',
    `regulatory_notice_flag` BOOLEAN COMMENT 'Indicates whether the communication satisfies a specific regulatory notice requirement.',
    `response_due_date` DATE COMMENT 'Date by which a response is required from the party.',
    `response_received_date` DATE COMMENT 'Date the response was received.',
    `response_received_flag` BOOLEAN COMMENT 'True if a response to the communication has been received.',
    `returned_mail_date` DATE COMMENT 'Date the mail was returned to sender.',
    `returned_mail_flag` BOOLEAN COMMENT 'True if the mailed communication was returned as undeliverable.',
    `sent_date` DATE COMMENT 'Date the communication was sent (applicable for outbound messages).',
    `subject` STRING COMMENT 'Subject or title of the communication.',
    `timestamp` TIMESTAMP COMMENT 'Exact date‑time when the communication event occurred (sent or received).',
    `appeal_communication_type` STRING COMMENT 'Category of the communication (e.g., acknowledgment, extension notice, decision letter, notice of rights, information request, response).. Valid values are `acknowledgment|extension_notice|decision_letter|notice_of_rights|information_request|response`',
    CONSTRAINT pk_appeal_communication PRIMARY KEY(`appeal_communication_id`)
) COMMENT 'Records all outbound and inbound communications related to appeal and grievance cases — acknowledgment letters, extension notices, decision letters (NOA/NOAD), Notice of Appeal Rights, member rights notices, requests for additional information, and member/provider responses. Tracks communication type, communication channel (mail, phone, secure portal, fax), sent/received date, recipient type, language, accessibility accommodation (large print, Braille, interpreter), regulatory notice compliance flag, regulatory basis, delivery confirmation, and returned mail tracking. Supports ACA §2719, ERISA §503, and state DOI member notice requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` (
    `appeal_document_id` BIGINT COMMENT 'Unique identifier for the appeal document.',
    `case_id` BIGINT COMMENT 'Identifier of the appeal case this document belongs to.',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the appeal.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider associated with the document.',
    `appeal_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `received|under_review|approved|rejected|closed`',
    `audit_trail` STRING COMMENT 'JSON string capturing audit events for the document (e.g., access, redaction).',
    `considered_in_decision` BOOLEAN COMMENT 'Flag indicating if the document was used in the final appeal decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was created.',
    `appeal_document_description` STRING COMMENT 'Additional free‑text description or notes about the document.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `format` STRING COMMENT 'File format of the stored document.. Valid values are `pdf|tiff|jpg|docx`',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the document is marked confidential beyond PHI.',
    `is_redacted` BOOLEAN COMMENT 'Indicates whether the document has been redacted to remove PHI.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to the document.',
    `number` STRING COMMENT 'Business identifier assigned to the document, often used in tracking.',
    `phi_classification` STRING COMMENT 'Extent to which the document contains protected health information.. Valid values are `none|partial|full`',
    `receipt_date` DATE COMMENT 'Date the document was received into the appeal system.',
    `redaction_status` STRING COMMENT 'Level of redaction applied to the document.. Valid values are `not_redacted|partial|full`',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory requirements.',
    `source` STRING COMMENT 'Origin of the document, e.g., member upload, provider submission, system generated.',
    `storage_path` STRING COMMENT 'Secure storage location reference (e.g., S3 URI).',
    `title` STRING COMMENT 'Human readable title or description of the document.',
    `appeal_document_type` STRING COMMENT 'Classification of the document content.. Valid values are `eob|denial_letter|medical_record|provider_note|transcript|peer_review`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Version of the document if multiple revisions exist.',
    CONSTRAINT pk_appeal_document PRIMARY KEY(`appeal_document_id`)
) COMMENT 'Manages all documents associated with an appeal or grievance case — member-submitted evidence, medical records, EOB copies, denial letters, acknowledgment letters, decision letters, IRO submissions, hearing transcripts, and peer-to-peer review notes. Tracks document type, document source, receipt date, document format, storage reference (BLOB/S3 path), PHI classification, redaction status, retention period (7-10 years per CMS and state DOI requirements), and whether the document was considered in the review decision. Supports HIPAA PHI handling requirements, regulatory record retention obligations, and litigation hold compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` (
    `appeal_grievance_id` BIGINT COMMENT 'Unique surrogate key for the grievance record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: A grievance that is an appeal should reference the related appeal case for traceability.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or case manager assigned to the grievance.',
    `event_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_event. Business justification: Grievance often stems from an enrollment termination or change event; linking provides the Enrollment Event Detail report for compliance.',
    `party_id` BIGINT COMMENT 'Unique identifier of the party who filed the grievance (member_id, provider_id, etc.).',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Employers may file grievances on behalf of employees; linking enables grievance tracking and compliance reporting per employer.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Needed for the Grievance Summary by Plan report used by plan administrators to monitor grievance volume and resolve plan‑specific issues per ACA requirements.',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Grievance filings often concern billing errors; linking grievance to the premium invoice provides the basis for investigation and compliance tracking.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Provider Grievance Management requires linking each grievance to the filing provider for reporting and compliance.',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with the grievance, if applicable.',
    `acknowledgment_date` DATE COMMENT 'Date the grievance was acknowledged by the health plan.',
    `appeal_grievance_status` STRING COMMENT 'Current lifecycle status of the grievance.. Valid values are `open|in_review|closed|withdrawn|escalated`',
    `appeal_reference_number` STRING COMMENT 'Reference number of the associated appeal, if the grievance is an appeal.',
    `case_notes` STRING COMMENT 'Free-text notes recorded by case handlers during the grievance lifecycle.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the grievance triggered a compliance review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was created in the system.',
    `escalation_level` STRING COMMENT 'Escalation tier if the grievance required higher-level review.. Valid values are `none|level_1|level_2|level_3`',
    `external_review_outcome` STRING COMMENT 'Result of any external review process.. Valid values are `favorable|unfavorable|pending|not_requested`',
    `external_review_requested` BOOLEAN COMMENT 'True if an external review (e.g., state fair hearing) was requested.',
    `filing_channel` STRING COMMENT 'Method through which the grievance was submitted.. Valid values are `portal|call_center|email|mail|in_person`',
    `filing_date` DATE COMMENT 'Date the grievance was received.',
    `filing_party_type` STRING COMMENT 'Indicates whether the grievance was filed by a member, provider, employer, or other party.. Valid values are `member|provider|employer|other`',
    `investigation_end_date` DATE COMMENT 'Date when the investigation concluded.',
    `investigation_start_date` DATE COMMENT 'Date when the investigation of the grievance began.',
    `is_appeal` BOOLEAN COMMENT 'Indicates whether the grievance is also an appeal of a specific adverse benefit determination.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the grievance contains confidential information requiring restricted handling.',
    `number` STRING COMMENT 'External reference number assigned to the grievance.',
    `priority` STRING COMMENT 'Priority level assigned to the grievance for handling.. Valid values are `high|medium|low`',
    `regulatory_classification` STRING COMMENT 'Regulatory category under which the grievance is reported.. Valid values are `medicare_ctm|state_doi|aca|other`',
    `related_encounter_number` BIGINT COMMENT 'Identifier of the clinical encounter linked to the grievance, if applicable.',
    `resolution_date` DATE COMMENT 'Date the grievance was resolved.',
    `resolution_detail` STRING COMMENT 'Narrative description of the resolution outcome.',
    `resolution_type` STRING COMMENT 'Outcome type of the grievance resolution.. Valid values are `overturned|upheld|settled|withdrawn|no_action`',
    `state_code` STRING COMMENT 'Two-letter US state code where the grievance originated.. Valid values are `^[A-Z]{2}$`',
    `title` STRING COMMENT 'Brief title summarizing the grievance.',
    `appeal_grievance_type` STRING COMMENT 'Category describing the nature of the grievance.. Valid values are `quality_of_care|access|billing|customer_service|provider_behavior|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grievance record.',
    `zip_code` STRING COMMENT 'Postal ZIP code of the member/provider address related to the grievance.. Valid values are `^d{5}(-d{4})?$`',
    CONSTRAINT pk_appeal_grievance PRIMARY KEY(`appeal_grievance_id`)
) COMMENT 'Master record for all member and provider grievances — formal expressions of dissatisfaction with health plan decisions, service quality, or administrative actions that do not contest a specific adverse benefit determination. Distinct from appeals (which contest specific ABDs) per CMS and state DOI classification rules. Tracks grievance type (quality of care, access, billing, customer service, provider behavior), filing party, filing channel, acknowledgment date, investigation findings, resolution date, resolution type, regulatory classification (CMS CTM categories for Medicare, state DOI categories for commercial), and case notes. SSOT for grievance identity and lifecycle in the appeal domain. Supports ACA, Medicare Part C/D CTM, and state DOI grievance reporting requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'System generated unique identifier for the appeal regulatory filing record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing of appeal data must reference the specific regulatory obligation it satisfies, required for compliance reporting.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Regulatory filings must include employer identifier to satisfy state/federal reporting of appeal outcomes.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who initiated the appeal.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider associated with the appeal (if applicable).',
    `acknowledgment_date` TIMESTAMP COMMENT 'Timestamp when the regulators acknowledgment was received.',
    `acknowledgment_received` BOOLEAN COMMENT 'Indicates whether an acknowledgment of receipt was received from the regulator.',
    `corrective_action_plan` STRING COMMENT 'Plan outlining steps to remediate deficiencies noted by the regulator.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the filing amount.',
    `deficiency_description` STRING COMMENT 'Text description of the issues identified by the regulator.',
    `deficiency_notice` BOOLEAN COMMENT 'Flag indicating whether the regulator issued a deficiency notice for the filing.',
    `filing_amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the filing (e.g., filing fee).',
    `filing_date` TIMESTAMP COMMENT 'Timestamp when the filing was initially submitted to the regulator.',
    `filing_method` STRING COMMENT 'Technical method used to submit the filing (e.g., EDI transaction, web portal upload).. Valid values are `EDI|WebPortal|ManualUpload|Fax`',
    `filing_number` STRING COMMENT 'External filing number assigned by the regulatory body for tracking the appeal submission.',
    `filing_status` STRING COMMENT 'Current processing status of the filing within the regulatory workflow.. Valid values are `pending|submitted|accepted|rejected|closed`',
    `filing_type` STRING COMMENT 'Category of the regulatory filing (e.g., appeal, grievance, external review, state hearing).. Valid values are `appeal|grievance|external_review|state_hearing`',
    `filing_version` STRING COMMENT 'Version identifier for the filing document (e.g., v1, v2).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the filing.',
    `regulatory_body` STRING COMMENT 'The governing agency or organization to which the filing is submitted.. Valid values are `CMS|State_DOI|NCQA|URAC|HHS`',
    `reporting_period` STRING COMMENT 'The calendar or fiscal period the filing covers (e.g., 2023Q1).',
    `resubmission_date` TIMESTAMP COMMENT 'Timestamp of the resubmitted filing, if applicable.',
    `resubmission_required` BOOLEAN COMMENT 'Indicates whether a resubmission of the filing is required.',
    `submission_method` STRING COMMENT 'Channel through which the filing was delivered to the regulator.. Valid values are `Electronic|Paper|Phone|Email`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Tracks mandatory regulatory filings and submissions related to appeals and grievances — CMS quarterly appeals data submissions (HPMS), CMS Medicare Part C/D organization determination and appeal reports, state DOI annual grievance and appeal reports, NCQA HEDIS appeals measures data extracts, URAC accreditation appeals documentation packages, and ACA external review annual reports to HHS. Captures filing type, regulatory body, reporting period, submission date, submission method (CMS HPMS, state portal, EDI, manual upload), filing status, acknowledgment or acceptance confirmation, deficiency notices, corrective action plans, and resubmission tracking. Distinct from the compliance domains general regulatory audit tracking — this is appeal-domain-specific regulatory reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_iro_organization_id` FOREIGN KEY (`iro_organization_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`iro_organization`(`iro_organization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_parent_expedited_review_id` FOREIGN KEY (`parent_expedited_review_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`expedited_review`(`expedited_review_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_parent_outcome_id` FOREIGN KEY (`parent_outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_parent_penalty_id` FOREIGN KEY (`parent_penalty_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`penalty`(`penalty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_parent_evidence_id` FOREIGN KEY (`parent_evidence_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`evidence`(`evidence_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ADD CONSTRAINT `fk_appeal_appeal_communication_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ADD CONSTRAINT `fk_appeal_appeal_document_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ADD CONSTRAINT `fk_appeal_appeal_grievance_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`appeal` SET TAGS ('dbx_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Original Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Appeal Assigned To');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_priority` SET TAGS ('dbx_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Cycle (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'open|in_review|closed|withdrawn|dismissed|remanded');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'first_level_internal|second_level_internal|expedited|external_review|state_fair_hearing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `completeness_determination` SET TAGS ('dbx_business_glossary_term' = 'Completeness Determination');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `completeness_determination` SET TAGS ('dbx_value_regex' = 'complete|incomplete');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_business_glossary_term' = 'Decision Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_author_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partially_overturned|withdrawn|dismissed|remanded');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `effective_benefit_change_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Benefit Change Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_clinical_urgency_basis` SET TAGS ('dbx_business_glossary_term' = 'Expedited Clinical Urgency Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `expedited_trigger` SET TAGS ('dbx_business_glossary_term' = 'Expedited Trigger');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_channel` SET TAGS ('dbx_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_channel` SET TAGS ('dbx_value_regex' = 'member_portal|provider_portal|phone|fax|email|mail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|fax');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_value_regex' = 'member|provider|authorized_rep');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `original_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `overturn_reason` SET TAGS ('dbx_business_glossary_term' = 'Overturn Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `provider_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_tier` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `regulatory_tier` SET TAGS ('dbx_value_regex' = 'ACA|ERISA|Medicare|Medicaid|CHIP');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Related Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'Related Drug NDC');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `related_service_code` SET TAGS ('dbx_business_glossary_term' = 'Related Service Code (CPT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `supporting_documentation_checklist` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Checklist');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ALTER COLUMN `supporting_documentation_checklist` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|under_review|resolved|denied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `basis_of_denial` SET TAGS ('dbx_business_glossary_term' = 'Basis of Denial');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `basis_of_denial` SET TAGS ('dbx_value_regex' = 'medical_necessity|benefit_exclusion|out_of_network|experimental|policy_limit|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_value_regex' = 'open|closed|overturned|pending');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_type` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `determination_type` SET TAGS ('dbx_value_regex' = 'denial|reduction|termination|non_authorization');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Determination');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Monetary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `monetary_amount_denied` SET TAGS ('dbx_business_glossary_term' = 'Denied Monetary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|non_preferred');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (APPEAL_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Number (APPEAL_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code (APPEAL_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_status_at_review` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status at Review (APPEAL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale (CLIN_RAT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `cpt_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'CPT Codes Reviewed (CPT_REVIEW)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version (CRIT_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group Code (DRG)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (MIN)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `icd_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'ICD Codes Reviewed (ICD_REVIEW)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `is_independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Review Location (REV_LOC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes (REV_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Review Number (REV_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome (REV_OUTCOME)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partial|escalated|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_specialty` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Specialty (REV_SPECIALTY)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Type (REV_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_value_regex' = 'clinical|peer|medical_director|committee');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (REV_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected|overturned|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type (REV_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'initial|second_level|medical_director|committee');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_id` SET TAGS ('dbx_business_glossary_term' = 'External Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'IRO Case Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Organization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `appeal_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `binding_determination_flag` SET TAGS ('dbx_business_glossary_term' = 'Binding Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount (Gross)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `compliance_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'External Review Decision');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'uphold|overturn|partial_uphold|partial_overturn|denied|approved');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'External Review Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD‑10) Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-TV-Z][0-9][A-Z0-9]{0,3}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'IRO Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `iro_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Urgent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'External Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `patient_relationship` SET TAGS ('dbx_business_glossary_term' = 'Patient Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `patient_relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|dependent|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `reporting_submission_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'External Review Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_category` SET TAGS ('dbx_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_category` SET TAGS ('dbx_value_regex' = 'clinical|administrative|coverage');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'External Review Number (ER#)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'External Review Source');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'member|provider|payer|state');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (Jurisdiction)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `state` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_status` SET TAGS ('dbx_business_glossary_term' = 'External Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_status` SET TAGS ('dbx_value_regex' = 'pending|received|under_review|decision_made|closed|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `transmission_date` SET TAGS ('dbx_business_glossary_term' = 'External Review Transmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_type` SET TAGS ('dbx_business_glossary_term' = 'External Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `external_review_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `timeline_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Timeline ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `acknowledgment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_expedited_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Expedited Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `actual_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Extension Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_category` SET TAGS ('dbx_business_glossary_term' = 'Appeal Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_category` SET TAGS ('dbx_value_regex' = 'claim_denial|coverage_dispute|utilization_management|external_review|state_fair_hearing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_origin` SET TAGS ('dbx_business_glossary_term' = 'Appeal Origin');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_origin` SET TAGS ('dbx_value_regex' = 'member|provider|employer|third_party|internal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Breach Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_start_event` SET TAGS ('dbx_business_glossary_term' = 'Clock Start Event Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clock Type (ACA, ERISA, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `clock_type` SET TAGS ('dbx_value_regex' = 'ACA|ERISA|Medicare Part C|Medicare Part D|Medicaid|State DOI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'on_time|late|extended');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `decision_due_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `expedited_due_date` SET TAGS ('dbx_business_glossary_term' = 'Expedited Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `last_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Action Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Timeline Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|State DOI|HHS|NAIC');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'staffing|system_error|data_issue|policy_gap|external_delay');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `self_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Self‑Report Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_actual_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_breach` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Dispute ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Disputing Party Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|granted|denied|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Payer Order');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Rule Applied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `cob_rule_applied` SET TAGS ('dbx_value_regex' = 'birthday|naic_model|state_specific|custom');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coordination_amount` SET TAGS ('dbx_business_glossary_term' = 'Coordination Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coordination_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coordination_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Dispute');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type (Benefit Interpretation, COB, Subrogation, Network Status, Formulary Exception)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'benefit_interpretation|cob|subrogation|network_status|formulary_exception');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputed_benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Disputed Benefit Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputed_benefit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Disputing Party Type (Member, Provider, Employer, Other)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputing_party_type` SET TAGS ('dbx_value_regex' = 'member|provider|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `disputing_party_type` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Dispute Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Dispute Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `formulary_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Dispute Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status of Service');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|non_preferred');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Other Carrier Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Other Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `other_carrier_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (ACA, ERISA, NAIC, CMS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_value_regex' = 'ACA|ERISA|NAIC|CMS');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'overturned|upheld|partial|settled|denied');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `coverage_dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|closed|reopened|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Supporting Documents');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Organization ID (IRO ID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body (Accreditation Body)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_value_regex' = 'URAC|NCQA|Other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date (Expiration Date)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Notes (Review Notes)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status (Accreditation Status)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|not_accredited|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'IRO Address Line 1 (Address Line 1)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'IRO Address Line 2 (Address Line 2)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `approved_states` SET TAGS ('dbx_business_glossary_term' = 'Approved States (States)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `assignment_rotation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rotation Methodology (Rotation Methodology)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'IRO City (City)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (Requirements)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `conflict_of_interest_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Attestation Date (COI Attestation)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date (Contract End)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `contract_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date (Contract Start)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'IRO Country (Country)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Organization Email Address (IRO Email)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `external_review_scope` SET TAGS ('dbx_business_glossary_term' = 'External Review Scope (Review Scope)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_conflict_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag (COI Flag)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('dbx_business_glossary_term' = 'State Approved Flag (State Approved)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `is_state_approved` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_accreditation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accreditation Review Date (Review Date)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Last Updated)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Organization Name (IRO Name)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'IRO Organization Type (IRO Type)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'independent_review_organization|external_review_entity|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Organization Phone Number (IRO Phone)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'IRO Postal Code (Postal Code)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `rotation_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle Length (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `specialty_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Specialty Capabilities (Specialties)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'IRO State (State)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_business_glossary_term' = 'State Approval Status (State Approval)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|denied|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `state_approval_status` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_status` SET TAGS ('dbx_business_glossary_term' = 'IRO Status (IRO Status)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ALTER COLUMN `iro_organization_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_id` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `parent_expedited_review_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Expedited Review Id');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `parent_expedited_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Expedited Decision Actual Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount (Gross)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `clinical_urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Urgency Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `clinical_urgency_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_due_date` SET TAGS ('dbx_business_glossary_term' = 'Expedited Decision Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partial|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Expedited Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_reason` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Reason');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_reason` SET TAGS ('dbx_value_regex' = 'life_threatening|severe_illness|functional_impairment|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Expedited Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|mail|portal|phone');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `review_request_number` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_status` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `expedited_review_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|denied|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `parent_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Outcome Id');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `parent_outcome_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `downstream_action` SET TAGS ('dbx_business_glossary_term' = 'Downstream Action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `downstream_action` SET TAGS ('dbx_value_regex' = 'claim_reprocess|authorization_issue|none|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `member_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `provider_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'pending|completed|archived|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_value_regex' = 'overturn|uphold|partial_overturn|withdrawn|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Penalty ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID (HPID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (MID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `parent_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Penalty Id');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `parent_penalty_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID (PID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PA)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline (AD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date (AFD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag (AFF)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome (AO)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|reversed|modified|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessment Timestamp (PAT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_category` SET TAGS ('dbx_business_glossary_term' = 'Penalty Category (PC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_category` SET TAGS ('dbx_value_regex' = 'financial|operational|clinical|administrative');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (CF)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Due Date (PDD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount (IA)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `interest_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Penalty Notes (PN)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reference Number (PRN)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date (PPD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PST)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|settled');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reason Code (PRC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reason Description (PRD)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (RAC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (RAU)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (RB)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|DOI|State|Federal|Other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Penalty Severity (PSV)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID (SRI)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Status (PS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_status` SET TAGS ('dbx_value_regex' = 'assessed|appealed|paid|waived|reversed|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Penalty Amount (TPA)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type (PT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'civil_money|state_fine|auto_approval|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` SET TAGS ('dbx_subdomain' = 'review_processing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Evidence ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `parent_evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Evidence Id');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `parent_evidence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Authorization ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('dbx_business_glossary_term' = 'Author NPI');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `author_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `clinical_code_icd10` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Guideline Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Evidence Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `phi_flag` SET TAGS ('dbx_business_glossary_term' = 'PHI Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `procedure_code_cpt` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `related_encounter_number` SET TAGS ('dbx_business_glossary_term' = 'Related Encounter ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_value_regex' = 'member|provider|external|internal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|accepted|rejected|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Evidence Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` SET TAGS ('dbx_subdomain' = 'member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Communication ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_value_regex' = 'large_print|braille|interpreter|none');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|failed|returned|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `attachment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Attachment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Communication Body Text');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_category` SET TAGS ('dbx_business_glossary_term' = 'Communication Category');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_category` SET TAGS ('dbx_value_regex' = 'member_notice|provider_notice|grievance|legal|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'mail|phone|secure_portal|fax|email');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `created_by_user_role` SET TAGS ('dbx_business_glossary_term' = 'Created By User Role');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `created_by_user_role` SET TAGS ('dbx_value_regex' = 'admin|agent|system|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `delivery_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Communication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `is_physical_mail` SET TAGS ('dbx_business_glossary_term' = 'Physical Mail Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `last_modified_by_user_role` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Role');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `last_modified_by_user_role` SET TAGS ('dbx_value_regex' = 'admin|agent|system|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Communication Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Communication Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'member|provider|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'ACA|ERISA|state_DIO|CMS|HIPAA');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `regulatory_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `returned_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `returned_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ALTER COLUMN `appeal_communication_type` SET TAGS ('dbx_value_regex' = 'acknowledgment|extension_notice|decision_letter|notice_of_rights|information_request|response');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` SET TAGS ('dbx_subdomain' = 'member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID (APPEAL_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID (PROV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_status` SET TAGS ('dbx_value_regex' = 'received|under_review|approved|rejected|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AUDIT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `considered_in_decision` SET TAGS ('dbx_business_glossary_term' = 'Considered In Decision (CONSIDERED)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description (DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (BYTES)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Document Format (FMT)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|tiff|jpg|docx');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CONFIDENTIAL)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `is_redacted` SET TAGS ('dbx_business_glossary_term' = 'Redaction Flag (REDACTED)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp (LAST_ACC_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `phi_classification` SET TAGS ('dbx_business_glossary_term' = 'PHI Classification (PHI_CLASS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `phi_classification` SET TAGS ('dbx_value_regex' = 'none|partial|full');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date (REC_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `redaction_status` SET TAGS ('dbx_business_glossary_term' = 'Redaction Status (REDACT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `redaction_status` SET TAGS ('dbx_value_regex' = 'not_redacted|partial|full');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (YEARS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Document Source (SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path (STORAGE_PATH)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DOC_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `appeal_document_type` SET TAGS ('dbx_value_regex' = 'eob|denial_letter|medical_record|provider_note|transcript|peer_review');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` SET TAGS ('dbx_subdomain' = 'member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Grievance ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_status` SET TAGS ('dbx_value_regex' = 'open|in_review|closed|withdrawn|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `external_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'External Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `external_review_outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|pending|not_requested');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `external_review_requested` SET TAGS ('dbx_business_glossary_term' = 'External Review Requested');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `filing_channel` SET TAGS ('dbx_business_glossary_term' = 'Filing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `filing_channel` SET TAGS ('dbx_value_regex' = 'portal|call_center|email|mail|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_value_regex' = 'member|provider|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `is_appeal` SET TAGS ('dbx_business_glossary_term' = 'Is Appeal');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Grievance Priority');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'medicare_ctm|state_doi|aca|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `related_encounter_number` SET TAGS ('dbx_business_glossary_term' = 'Related Encounter ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `resolution_detail` SET TAGS ('dbx_business_glossary_term' = 'Resolution Detail');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'overturned|upheld|settled|withdrawn|no_action');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Grievance Title');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `appeal_grievance_type` SET TAGS ('dbx_value_regex' = 'quality_of_care|access|billing|customer_service|provider_behavior|other');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Regulatory Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `deficiency_notice` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Notice');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Amount');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'EDI|WebPortal|ManualUpload|Fax');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected|closed');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'appeal|grievance|external_review|state_hearing');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `filing_version` SET TAGS ('dbx_business_glossary_term' = 'Filing Version');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|State_DOI|NCQA|URAC|HHS');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `reporting_period` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `resubmission_date` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Date');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `resubmission_required` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Electronic|Paper|Phone|Email');
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
