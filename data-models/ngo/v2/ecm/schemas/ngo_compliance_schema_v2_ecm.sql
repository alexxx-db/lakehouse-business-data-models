-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`compliance` COMMENT 'Systems of record: SAP GRC (governance risk compliance), TeamMate (audit management), IATI Registry (transparency reporting), national regulatory portals. Covers regulatory filings, audits, NICRA, sanctions screening, and governance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key for the regulatory filing entity.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Regulatory filings are submitted through specific platforms (IRS e-file, state charity portals, IATI registry). Nonprofits must track which system was used for each filing for audit trail, troubleshoo',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Each regulatory filing satisfies a specific compliance obligation from the master obligation catalog. One filing is for one obligation; one obligation generates many filings over time (recurring oblig',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original regulatory filing record that this amendment corrects or supersedes. Null if this is an original filing.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Regulatory filings are often associated with specific statutory registrations (e.g., annual charity returns for a registration, IRS 990 for a 501(c)(3) registration). One filing is for one registratio',
    `acceptance_date` DATE COMMENT 'Date on which the regulatory authority formally accepted the filing as complete and compliant. Marks successful completion of the filing obligation.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory authority acknowledged receipt of the filing. Confirms that the submission was received and entered into the processing queue.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this filing is an amendment or correction of a previously submitted filing. True if this is an amended return, false if original filing.',
    `authorized_signatory_name` STRING COMMENT 'Full name of the individual authorized to sign and submit the regulatory filing on behalf of the organization. Typically an officer or director with legal authority.',
    `authorized_signatory_title` STRING COMMENT 'Official title or position of the authorized signatory. Examples include Executive Director, Board Chair, President, or Chief Executive Officer (CEO).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory filing record was first created in the system. Marks the beginning of the filing lifecycle for audit trail purposes.',
    `document_url` STRING COMMENT 'Web address or file path where the submitted filing document is stored for retrieval and audit purposes. May point to internal document management system or external regulatory portal.',
    `due_date` DATE COMMENT 'Statutory or regulatory deadline by which the filing must be submitted to avoid penalties or loss of status. Calculated based on fiscal year end and jurisdiction-specific rules.',
    `extended_due_date` DATE COMMENT 'New filing deadline after an approved extension. Replaces the original due date for compliance tracking purposes.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether the requested filing deadline extension was granted by the regulatory authority. True if extension was approved, false if denied or not applicable.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicates whether an extension of the filing deadline was requested from the regulatory authority. True if extension was requested, false otherwise.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulatory authority for processing the filing. Amount in the organizations functional currency.',
    `filing_fee_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the filing fee amount. Examples include USD, GBP, EUR.',
    `filing_fee_payment_date` DATE COMMENT 'Date on which the filing fee was paid to the regulatory authority. Used to confirm payment and avoid processing delays.',
    `filing_notes` STRING COMMENT 'Free-text field for internal notes, comments, or special circumstances related to the filing. Used to document unusual situations, preparer communications, or follow-up actions required.',
    `filing_number` STRING COMMENT 'Externally-known unique identifier or confirmation number assigned by the regulatory authority or filing system upon submission. Examples include IRS e-file confirmation number, Charity Commission submission reference, or state registration number.',
    `filing_period_end_date` DATE COMMENT 'End date of the fiscal or reporting period covered by this regulatory filing. Defines the conclusion of the time span for which financial and operational data are reported.',
    `filing_period_start_date` DATE COMMENT 'Start date of the fiscal or reporting period covered by this regulatory filing. Defines the beginning of the time span for which financial and operational data are reported.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing. Tracks progression from initial draft through submission, acknowledgment, and final acceptance or rejection by the regulatory authority. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|accepted|rejected|resubmitted|withdrawn|pending_review — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory filing record was most recently updated. Tracks all changes throughout the filing lifecycle from draft to final acceptance.',
    `preparer_name` STRING COMMENT 'Full name of the individual or firm responsible for preparing the regulatory filing. May be internal staff or external consultant/accountant.',
    `preparer_organization` STRING COMMENT 'Name of the organization or firm employing the preparer, if applicable. Identifies external accounting firms, consultancies, or legal advisors engaged to prepare the filing.',
    `preparer_ptin` STRING COMMENT 'IRS-issued Preparer Tax Identification Number for the individual who prepared the filing. Required for paid tax return preparers in the United States.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this filing is subject to public disclosure requirements. True for filings that must be made available for public inspection (e.g., IRS Form 990), false for confidential regulatory reports.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory authority rejected the filing due to errors, omissions, or non-compliance. Triggers resubmission workflow.',
    `rejection_reason_code` STRING COMMENT 'Standardized code assigned by the regulatory authority indicating the specific reason for filing rejection. Used to identify and correct errors for resubmission. [ENUM-REF-CANDIDATE: IRS Reject Code 0001|0002|0003|0004|0005|0006|... — promote to reference product]',
    `rejection_reason_description` STRING COMMENT 'Detailed narrative explanation of why the filing was rejected by the regulatory authority. Provides context and guidance for corrective action.',
    `resubmission_count` STRING COMMENT 'Number of times this filing has been resubmitted after rejection. Tracks the iteration history for audit and quality improvement purposes.',
    `review_date` DATE COMMENT 'Date on which the internal review and approval of the filing was completed. Marks the point at which the filing was deemed ready for submission.',
    `reviewer_name` STRING COMMENT 'Full name of the individual responsible for reviewing and approving the regulatory filing before submission. Typically a senior finance officer, legal counsel, or executive director.',
    `reviewer_title` STRING COMMENT 'Job title or role of the individual who reviewed and approved the filing. Examples include Chief Financial Officer (CFO), Executive Director, or Board Treasurer.',
    `submission_channel` STRING COMMENT 'Method or channel through which the filing was submitted to the regulatory authority. Distinguishes between electronic filing systems, paper mail, online portals, and third-party filing services.. Valid values are `electronic|paper|online_portal|third_party_service|mail|in_person`',
    `submission_date` DATE COMMENT 'Actual date on which the filing was submitted to the regulatory authority. Used to determine timeliness and compliance with due date requirements.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the filing was transmitted to the regulatory authority or filing portal. Provides audit trail for electronic submissions.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Regulatory filing or statutory submission. Source systems: SAP GRC, national regulatory portals, IATI Registry. Covers US Form 990, Charity Commission (UK), IPSAS-mandated disclosures. Systems-of-record: SAP GRC, internal compliance systems. Framework: 2 CFR 200 / Form 990 (US) / Charity Commission (UK) / IPSAS disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Primary key for obligation',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Compliance obligations often mandate specific technology platforms (IATI publication requires IATI registry, 990 filing requires e-file system, grant reporting requires donor portals). Nonprofits must',
    `chs_self_assessment_required` BOOLEAN COMMENT 'Indicates whether this obligation requires a self-assessment against the Core Humanitarian Standard (CHS) commitments.',
    `obligation_code` STRING COMMENT 'Internal or external reference code for the obligation (e.g., IRS-990, CC-AR, IATI-PUB, CHS-SA).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was first created in the system.',
    `documentation_required` STRING COMMENT 'Description of the documents, reports, or evidence that must be prepared or submitted to fulfill this obligation (e.g., Audited financial statements, Program impact report, Beneficiary data summary, Board meeting minutes).',
    `donor_funder_name` STRING COMMENT 'The name of the donor, funder, or granting organization that requires this obligation, if applicable (e.g., USAID, DFID, Bill & Melinda Gates Foundation).',
    `effective_date` DATE COMMENT 'The date when this obligation first became applicable or enforceable for the organization.',
    `escalation_threshold_days` STRING COMMENT 'The number of days before the due date when an alert or escalation should be triggered to ensure timely completion.',
    `expiration_date` DATE COMMENT 'The date when this obligation ceases to be applicable or enforceable, if applicable. Null for ongoing obligations.',
    `fiscal_year_applicable` STRING COMMENT 'The fiscal year or reporting period to which this obligation applies (e.g., FY2024, 2024, Q1-2024).',
    `frequency` STRING COMMENT 'How often the obligation must be fulfilled: annual, quarterly, monthly, semi-annual, biennial, one-time (single occurrence), ad-hoc (irregular), event-driven (triggered by specific events). [ENUM-REF-CANDIDATE: annual|quarterly|monthly|semi-annual|biennial|one-time|ad-hoc|event-driven — 8 candidates stripped; promote to reference product]',
    `governing_body` STRING COMMENT 'The regulatory authority, oversight body, or standard-setting organization that mandates or oversees this obligation (e.g., Internal Revenue Service, Charity Commission, OCHA, CHS Alliance, USAID).',
    `grant_agreement_reference` STRING COMMENT 'Reference number or identifier of the grant agreement, contract, or Memorandum of Understanding (MoU) that establishes this obligation, if applicable.',
    `iati_publication_required` BOOLEAN COMMENT 'Indicates whether this obligation requires publication of data to the IATI Registry for transparency and accountability.',
    `jurisdiction` STRING COMMENT 'The geographic or organizational scope where this obligation applies (e.g., United States, United Kingdom, European Union, Global, State of California, Country Office Kenya).',
    `last_completed_date` DATE COMMENT 'The date when this obligation was most recently fulfilled or submitted successfully.',
    `lead_time_days` STRING COMMENT 'The number of days in advance that preparation or submission must begin to meet the obligation deadline.',
    `legal_basis` STRING COMMENT 'The specific law, regulation, standard, or contractual clause that establishes this obligation (e.g., IRC Section 501(c)(3), 2 CFR 200.501, CHS Commitment 1, Grant Agreement Clause 12.3).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was last updated or modified.',
    `obligation_name` STRING COMMENT 'The official name or title of the compliance obligation (e.g., IRS Form 990 Annual Return, Charity Commission Annual Return, IATI Publication).',
    `next_due_date` DATE COMMENT 'The next scheduled date by which this obligation must be fulfilled or submitted.',
    `notes` STRING COMMENT 'Additional notes, instructions, or context related to this obligation, including special handling requirements or historical context.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation: active (in force and must be fulfilled), pending (upcoming or not yet effective), completed (fulfilled for current period), overdue (past due date and not fulfilled), waived (exempted or not applicable), suspended (temporarily not enforced).. Valid values are `active|pending|completed|overdue|waived|suspended`',
    `obligation_type` STRING COMMENT 'Classification of the obligation by its source or nature: regulatory (government-mandated), donor (funder-specific requirement), voluntary (self-imposed accountability framework), contractual (grant or partnership agreement condition), statutory (legal requirement).. Valid values are `regulatory|donor|voluntary|contractual|statutory`',
    `penalty_description` STRING COMMENT 'Description of the consequences, penalties, or sanctions that may result from non-compliance (e.g., Loss of tax-exempt status, Fines up to $50,000, Grant suspension, Reputational damage).',
    `responsible_person` STRING COMMENT 'The name or identifier of the individual accountable for ensuring this obligation is fulfilled (e.g., Chief Financial Officer, Compliance Manager, MEL Director).',
    `responsible_unit` STRING COMMENT 'The department, team, or organizational unit responsible for fulfilling this obligation (e.g., Finance Department, Compliance Office, MEL Team, Legal Affairs, Country Office).',
    `risk_rating` STRING COMMENT 'The severity of risk to the organization if this obligation is not fulfilled: critical (severe legal or reputational consequences), high (significant impact), medium (moderate impact), low (minimal impact).. Valid values are `critical|high|medium|low`',
    `single_audit_required` BOOLEAN COMMENT 'Indicates whether this obligation requires a Single Audit under 2 CFR 200 Subpart F for US federal awards exceeding the threshold.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the obligation must be fulfilled or submitted (e.g., online portal, email, postal mail, in-person delivery, API, FTP).. Valid values are `online_portal|email|postal_mail|in_person|api|ftp`',
    `submission_url` STRING COMMENT 'The web address or portal URL where the obligation must be submitted, if applicable.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Master catalog of all recurring and one-time compliance obligations the organization must fulfill across regulatory, donor, and voluntary accountability frameworks. Includes IRS 990 filings, Charity Commission returns, IATI publications, CHS self-assessments, Single Audit requirements (2 CFR 200), state registrations, OCHA reporting, and donor-specific conditions. Captures obligation name, governing body, legal basis, frequency, jurisdiction, responsible unit, lead time, and risk rating. Overdue obligations escalate to incident records via obligation_schedule monitoring.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` (
    `obligation_schedule_id` BIGINT COMMENT 'Unique identifier for the compliance obligation schedule entry. Primary key for the obligation schedule product.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Scheduled compliance tasks are executed through specific platforms (e.g., filing system, reporting portal). Nonprofits need this link for workflow automation, access provisioning before due dates, and',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period (month, quarter, year) to which this obligation schedule applies. Enables period-based compliance tracking.',
    `obligation_id` BIGINT COMMENT 'Reference to the parent compliance obligation that this schedule entry is tracking. Links to the master obligation registry.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (compliance officer, finance manager, or program director) assigned primary responsibility for completing this obligation.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Obligation schedules track when compliance filings are due. When the obligation is completed, the schedule should reference the actual regulatory filing that satisfied it. One schedule entry results i',
    `tertiary_obligation_assigned_officer_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `user_account_id` BIGINT COMMENT 'Reference to the system user who last modified this obligation schedule entry. Supports accountability and change tracking.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of staff hours spent completing this obligation. Used for capacity planning and process improvement. Null if not yet completed.',
    `completion_status` STRING COMMENT 'Overall completion status of the scheduled obligation. Indicates whether the obligation is pending, actively being worked, completed on time, overdue, waived by authority, or deferred to a future period.. Valid values are `pending|in_progress|completed|overdue|waived|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation schedule entry was first created in the system. Supports audit trail and compliance history tracking.',
    `effective_due_date` DATE COMMENT 'The actual due date in effect for this obligation, taking into account any approved extensions. Equals extended_due_date if extension granted, otherwise equals planned_due_date.',
    `escalation_date` DATE COMMENT 'Date when the obligation was escalated to senior management or executive leadership due to risk of non-compliance. Null if no escalation has occurred.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the effective due date when the obligation should be escalated to senior management if not yet completed. Enables proactive deadline monitoring.',
    `escalation_triggered_flag` BOOLEAN COMMENT 'Boolean indicator of whether this obligation has triggered an escalation alert due to approaching deadline or overdue status. True if escalation has been triggered, False otherwise.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of staff hours required to complete this obligation, including data collection, preparation, review, and submission activities.',
    `extended_due_date` DATE COMMENT 'Revised due date if an extension has been granted by the regulatory authority or approved internally. Null if no extension applies.',
    `extension_granted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requested extension was approved by the regulatory authority. True if extension granted, False if denied or not applicable.',
    `extension_reason` STRING COMMENT 'Business justification or reason provided when requesting an extension (e.g., Awaiting final audit report, Staff transition, System migration delay).',
    `extension_requested_flag` BOOLEAN COMMENT 'Boolean indicator of whether an extension has been formally requested from the regulatory authority. True if extension requested, False otherwise.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or regulatory authority under which this obligation falls (e.g., United States - IRS, United Kingdom - Charity Commission, International - IATI).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation schedule entry was last updated. Tracks changes to due dates, assignments, status, or other schedule attributes.',
    `non_compliance_risk` STRING COMMENT 'Assessment of the organizational risk if this obligation is not met on time. Severe risk includes loss of tax-exempt status, funding restrictions, or legal penalties.. Valid values are `severe|high|moderate|low|minimal`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine amount assessed for late or non-compliant submission. Null if no penalty applies or obligation completed on time.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `planned_due_date` DATE COMMENT 'Original scheduled due date for the compliance obligation as defined by the regulatory authority or internal policy.',
    `priority_level` STRING COMMENT 'Business priority assigned to this obligation based on regulatory impact, financial risk, and organizational importance. Critical obligations have severe non-compliance penalties.. Valid values are `critical|high|medium|low`',
    `recurrence_pattern` STRING COMMENT 'Frequency pattern for this obligation. Indicates whether it is a one-time requirement, recurring annually, quarterly, monthly, biennially, or triggered by specific events.. Valid values are `one_time|annual|quarterly|monthly|biennial|event_driven`',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework or standard governing this obligation (e.g., IRS 501(c)(3), OMB Uniform Guidance 2 CFR 200, IATI Standard, CHS, Sphere Standards).',
    `reviewer_notes` STRING COMMENT 'Internal notes and comments from compliance reviewers, auditors, or executive leadership regarding this obligation schedule entry. Used for quality assurance and process improvement.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents, attachments, or exhibits required or submitted with this obligation (e.g., financial statements, audit reports, program narratives).',
    `waiver_reason` STRING COMMENT 'Explanation for why this obligation was waived or exempted by the regulatory authority or internal policy (e.g., Below revenue threshold, Disaster relief exemption).',
    `workflow_stage` STRING COMMENT 'Current stage in the compliance workflow process. Tracks progression from initial data collection through final submission and acknowledgment. [ENUM-REF-CANDIDATE: not_started|data_collection|draft_preparation|internal_review|executive_review|final_approval|submission_ready|submitted|acknowledged — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_obligation_schedule PRIMARY KEY(`obligation_schedule_id`)
) COMMENT 'Operational schedule linking compliance obligations to specific fiscal periods, deadlines, and responsible staff. Tracks planned due date, extended due date (if extension granted), assigned compliance officer, review workflow stage, escalation thresholds, and completion status. Enables proactive compliance calendar management and deadline monitoring across all jurisdictions and reporting frameworks.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`single_audit` (
    `single_audit_id` BIGINT COMMENT 'Unique identifier for the Single Audit engagement record. Primary key for this entity.',
    `cognizant_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.cognizant_agency. Business justification: Single Audits conducted under OMB Uniform Guidance 2 CFR 200 are overseen by the organizations designated cognizant agency (typically the federal agency providing the most funding). This is a require',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Single Audits (OMB Uniform Guidance 2 CFR 200) satisfy federal audit obligations for organizations expending $750K+ in federal awards. The obligation table tracks single_audit_required flag. One audit',
    `partner_org_id` BIGINT COMMENT 'Reference to the nonprofit organization undergoing the Single Audit.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Single Audit results must be filed with the Federal Audit Clearinghouse (FAC) as a regulatory filing. One Single Audit generates one regulatory filing submission. The filing details (submission date, ',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Single audit data is extracted from financial and grants management systems (ERP, grants platforms). Nonprofits must document which system provided audit data for SEFA preparation, auditor data reques',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost paid or payable to the auditor firm for conducting the Single Audit engagement.',
    `audit_finding_count` STRING COMMENT 'Total number of audit findings reported in the Schedule of Findings and Questioned Costs.',
    `audit_period_end_date` DATE COMMENT 'The ending date of the fiscal year or audit period covered by this Single Audit engagement.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the fiscal year or audit period covered by this Single Audit engagement.',
    `audit_report_date` DATE COMMENT 'Date when the auditor issued the final Single Audit report package.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the Single Audit engagement: planned, in_progress, fieldwork_complete, report_draft, report_final, submitted_to_fac, or closed. [ENUM-REF-CANDIDATE: planned|in_progress|fieldwork_complete|report_draft|report_final|submitted_to_fac|closed — 7 candidates stripped; promote to reference product]',
    `audit_year` STRING COMMENT 'The fiscal year for which the Single Audit is being conducted, typically a four-digit year (e.g., 2023).',
    `auditor_contact_email` STRING COMMENT 'Email address of the primary auditor contact for this Single Audit engagement.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `auditor_contact_name` STRING COMMENT 'Name of the primary contact person at the auditor firm responsible for this engagement.',
    `auditor_contact_phone` STRING COMMENT 'Phone number of the primary auditor contact for this Single Audit engagement.',
    `auditor_ein` STRING COMMENT 'Federal Employer Identification Number of the auditor firm conducting the Single Audit.. Valid values are `^d{2}-d{7}$`',
    `auditor_firm_name` STRING COMMENT 'Name of the independent certified public accounting firm or auditor conducting the Single Audit.',
    `compliance_opinion_type` STRING COMMENT 'Type of audit opinion issued on compliance with federal award requirements: unmodified (clean), qualified, adverse, or disclaimer of opinion.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `corrective_action_plan_date` DATE COMMENT 'Date when the organization submitted its corrective action plan to address audit findings.',
    `corrective_action_plan_submitted_flag` BOOLEAN COMMENT 'Indicates whether the organization submitted a corrective action plan addressing audit findings as required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Single Audit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the federal expenditure amount (typically USD for US federal awards).. Valid values are `^[A-Z]{3}$`',
    `engagement_letter_date` DATE COMMENT 'Date when the audit engagement letter was signed between the organization and the auditor firm.',
    `federal_expenditure_amount` DECIMAL(18,2) COMMENT 'Total amount of federal awards expended by the organization during the audit period, triggering Single Audit requirement if $750,000 or more.',
    `fieldwork_end_date` DATE COMMENT 'Date when the auditor completed fieldwork for the Single Audit.',
    `fieldwork_start_date` DATE COMMENT 'Date when the auditor began on-site or remote fieldwork for the Single Audit.',
    `financial_statement_opinion_type` STRING COMMENT 'Type of audit opinion issued on the organizations financial statements: unmodified (clean), qualified, adverse, or disclaimer of opinion.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `going_concern_issue_flag` BOOLEAN COMMENT 'Indicates whether the auditor raised substantial doubt about the organizations ability to continue as a going concern.',
    `internal_control_opinion_type` STRING COMMENT 'Type of audit opinion issued on internal control over financial reporting and compliance: unmodified, qualified, adverse, or disclaimer.. Valid values are `unmodified|qualified|adverse|disclaimer`',
    `low_risk_auditee_flag` BOOLEAN COMMENT 'Indicates whether the organization qualifies as a low-risk auditee under OMB Uniform Guidance criteria, which may reduce the number of major programs tested.',
    `major_program_count` STRING COMMENT 'Number of federal programs identified as major programs requiring detailed compliance testing under the risk-based approach.',
    `material_weakness_identified_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified any material weaknesses in internal control over financial reporting or compliance.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the Single Audit engagement, including special circumstances, follow-up actions, or internal observations.',
    `questioned_cost_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of questioned costs identified by the auditor across all federal programs.',
    `sefa_reference_number` STRING COMMENT 'Reference number or identifier for the Schedule of Expenditures of Federal Awards (SEFA) prepared as part of the Single Audit package.',
    `significant_deficiency_identified_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified any significant deficiencies in internal control over financial reporting or compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this Single Audit record was last updated in the system.',
    CONSTRAINT pk_single_audit PRIMARY KEY(`single_audit_id`)
) COMMENT 'Single Audit (2 CFR 200) or equivalent statutory audit. Source systems: TeamMate (audit management), SAP GRC. Applicable to US federal fund recipients; UN agencies undergo Board of Auditors review. Systems-of-record: SAP GRC, cognizant agency portals. Framework: 2 CFR 200 Subpart F (Single Audit) / IPSAS external audit standards (ISA).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Primary key for audit_finding',
    `award_id` BIGINT COMMENT 'Reference to the specific grant or award under which this finding was identified, if applicable.',
    `corrective_action_plan_id` BIGINT COMMENT 'Reference to the corrective action plan developed to address this finding. Links to the detailed remediation plan with responsible parties, timelines, and action steps.',
    `intervention_id` BIGINT COMMENT 'Reference to the federal program under which this finding was identified, if applicable to a specific program.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Audit findings document safeguarding incidents discovered during compliance audits (single audit, donor audits). Real business process: audit documentation, questioned costs, and corrective action tra',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Audit findings discovered during Single Audit engagements (OMB Uniform Guidance 2 CFR 200) should reference the specific Single Audit. The existing audit_id points to compliance.audit (cross-domain)',
    `vulnerability_id` BIGINT COMMENT 'Foreign key linking to technology.vulnerability. Business justification: Compliance audit findings may identify technical vulnerabilities (weak access controls, unpatched systems, data exposure). Nonprofits must link findings to vulnerabilities for integrated risk manageme',
    `actual_resolution_date` DATE COMMENT 'The actual date on which the finding was fully resolved and remediated, as verified by management or subsequent audit. Null if the finding is still open or in remediation.',
    `audit_period_end_date` DATE COMMENT 'The end date of the audit period during which this finding was identified. Typically the end of the organizations fiscal year under audit.',
    `audit_period_start_date` DATE COMMENT 'The start date of the audit period during which this finding was identified. Typically the beginning of the organizations fiscal year under audit.',
    `auditor_name` STRING COMMENT 'Name of the external audit firm or auditor who identified this finding during the audit engagement.',
    `cause_description` STRING COMMENT 'Explanation of the underlying reason or root cause that led to the condition. This identifies why the deficiency occurred (e.g., lack of training, inadequate controls, resource constraints).',
    `cfda_number` STRING COMMENT 'The five-digit CFDA number (now known as Assistance Listings number) identifying the federal program under which the finding was identified. Format is XX.XXX where the first two digits represent the federal agency and the last three represent the specific program.. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `compliance_requirement_type` STRING COMMENT 'The specific type of compliance requirement that was violated or not met, as defined in the OMB Compliance Supplement (e.g., Activities Allowed or Unallowed, Allowable Costs/Cost Principles, Cash Management, Eligibility, Equipment and Real Property Management, Matching, Period of Performance, Procurement, Program Income, Reporting, Subrecipient Monitoring, Special Tests and Provisions).',
    `condition_description` STRING COMMENT 'Detailed description of the actual condition or deficiency found during the audit. This describes what the auditor observed or identified as problematic.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was first created in the system.',
    `criteria_description` STRING COMMENT 'Description of the required standard, regulation, policy, or grant provision that was not met. This establishes the benchmark against which the condition is measured.',
    `effect_description` STRING COMMENT 'Description of the actual or potential impact or consequence of the finding. This explains what harm or risk resulted from the condition (e.g., misstated financial statements, unallowable costs charged to grant, noncompliance with donor restrictions).',
    `expected_resolution_date` DATE COMMENT 'The target date by which the organization expects to fully resolve and remediate this finding based on the corrective action plan.',
    `fac_submission_date` DATE COMMENT 'The date on which the audit report containing this finding was submitted to the Federal Audit Clearinghouse. Null if not yet submitted.',
    `federal_agency_name` STRING COMMENT 'Name of the federal agency that provided the funding for the program under which this finding was identified (e.g., USAID, BHA, Department of State, HHS).',
    `federal_award_identification_number` STRING COMMENT 'The unique Federal Award Identification Number assigned by the federal agency to the specific award under which this finding was identified.',
    `finding_identified_date` DATE COMMENT 'The date on which the auditor formally identified and documented this finding during the audit fieldwork or reporting process.',
    `finding_reference_number` STRING COMMENT 'The externally-known unique reference number assigned to this audit finding by the auditor, typically following the format YYYY-NNN or similar audit-specific numbering convention.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the audit finding. Open indicates newly identified and not yet addressed. In remediation indicates corrective action plan is being implemented. Resolved indicates corrective actions completed and pending verification. Closed indicates finding fully remediated and verified. Repeat finding indicates this issue was identified in a prior audit period.. Valid values are `open|in_remediation|resolved|closed|repeat_finding`',
    `finding_title` STRING COMMENT 'Brief descriptive title or summary of the audit finding, providing a high-level overview of the issue identified.',
    `finding_type` STRING COMMENT 'Classification of the audit finding based on severity and nature. Material weakness indicates a deficiency or combination of deficiencies in internal control such that there is a reasonable possibility that a material misstatement will not be prevented or detected. Significant deficiency is less severe than a material weakness but important enough to merit attention. Questioned cost represents costs that do not comply with grant terms. Noncompliance indicates violation of laws, regulations, or grant provisions.. Valid values are `material_weakness|significant_deficiency|questioned_cost|noncompliance|other_matter`',
    `is_fraud_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this finding includes indicators of potential fraud, waste, or abuse. True if fraud indicators are present and require further investigation.',
    `is_material_weakness` BOOLEAN COMMENT 'Boolean flag indicating whether this finding represents a material weakness in internal control over financial reporting or compliance. True if the finding is classified as a material weakness.',
    `is_repeat_finding` BOOLEAN COMMENT 'Boolean flag indicating whether this finding was previously identified in a prior audit period and has not been fully resolved. True if this is a repeat finding.',
    `is_significant_deficiency` BOOLEAN COMMENT 'Boolean flag indicating whether this finding represents a significant deficiency in internal control. True if the finding is classified as a significant deficiency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was last updated or modified in the system.',
    `management_response` STRING COMMENT 'The organizations management response to the audit finding, including agreement or disagreement with the finding and planned corrective actions.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this audit finding, including follow-up actions, communications with auditors, or internal discussions.',
    `prior_finding_reference_number` STRING COMMENT 'Reference number of the prior audit finding if this is a repeat finding. Links to the original finding from a previous audit period.',
    `questioned_cost_amount` DECIMAL(18,2) COMMENT 'The monetary amount of costs questioned by the auditor due to noncompliance with grant terms, unallowable costs, or lack of supporting documentation. Null if the finding does not involve questioned costs.',
    `questioned_cost_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the questioned cost amount (e.g., USD, EUR, GBP).',
    `recommendation_description` STRING COMMENT 'Auditors recommendation for corrective action to address the finding. This provides guidance on steps the organization should take to remediate the deficiency.',
    `reported_to_federal_audit_clearinghouse` BOOLEAN COMMENT 'Boolean flag indicating whether this finding has been reported to the Federal Audit Clearinghouse as part of the Single Audit submission. True if reported to FAC.',
    `responsible_department` STRING COMMENT 'The internal department or functional area responsible for addressing and remediating this finding (e.g., Finance, Program Operations, Grants Management, Human Resources).',
    `responsible_person_name` STRING COMMENT 'Name of the individual assigned primary responsibility for implementing the corrective action plan and resolving this finding.',
    `risk_category` STRING COMMENT 'Classification of the type of risk this finding represents (e.g., Financial Risk, Compliance Risk, Operational Risk, Reputational Risk, Fraud Risk).',
    `severity_level` STRING COMMENT 'Internal classification of the findings severity based on organizational risk assessment. Critical findings pose immediate risk to funding or compliance. High findings require urgent attention. Medium findings should be addressed in the normal course. Low findings are minor issues.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record of each finding, material weakness, significant deficiency, or questioned cost identified during a Single Audit or internal compliance audit. Captures finding reference number, finding type (material weakness, significant deficiency, questioned cost, noncompliance), federal program CFDA number, finding description, condition, criteria, cause, effect, and recommendation. Links to corrective action plans.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award associated with the finding, if the corrective action relates to donor compliance or federal award requirements.',
    `chs_self_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.chs_self_assessment. Business justification: CHS self-assessments identify improvement actions for each of the 9 commitments (commitment_X_improvement_actions fields). These improvement actions are formalized as corrective action plans. One CAP ',
    `staff_member_id` BIGINT COMMENT 'Identifier of the user who last modified the corrective action plan record.',
    `corrective_staff_member_id` BIGINT COMMENT 'Identifier of the user who created the corrective action plan record.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Corrective actions for compliance findings often require system changes (access controls, workflow modifications, reporting enhancements). Nonprofits must link CAPs to change requests for implementati',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Internal compliance reviews generate findings that require corrective action plans. One CAP addresses one internal review finding; one review may generate multiple CAPs (one per finding). This paralle',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project associated with the finding, if the corrective action relates to program operations or service delivery.',
    `primary_corrective_staff_member_id` BIGINT COMMENT 'Identifier of the manager or staff member accountable for implementing the corrective action plan.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: CAPs remediate safeguarding incidents (SEA, abuse, exploitation). Real business process: incident response workflow requires documented corrective actions for donor reporting and organizational learni',
    `tertiary_corrective_responsible_manager_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `audit_finding_id` BIGINT COMMENT 'Reference to the audit finding, CHS non-conformity, or compliance issue that triggered this corrective action plan.',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action plan was fully implemented and verified as complete. Null if still in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action plan. Null if not yet completed or cost not tracked.',
    `audit_report_reference` STRING COMMENT 'Reference to the audit report document that contains the original finding, including report number and page reference.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, typically formatted as CAP-YYYY-NNN or similar organizational convention.',
    `cap_status` STRING COMMENT 'Current lifecycle status of the corrective action plan, tracking progress from initiation through closure. [ENUM-REF-CANDIDATE: draft|open|in_progress|pending_verification|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `corrective_action_description` STRING COMMENT 'Detailed narrative describing the specific corrective actions to be taken to address the finding, including process changes, policy updates, training, or system enhancements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual costs.. Valid values are `^[A-Z]{3}$`',
    `donor_notification_date` DATE COMMENT 'Date when the donor or funding agency was notified of the finding and corrective action plan. Null if notification not required or not yet sent.',
    `donor_notification_required` BOOLEAN COMMENT 'Indicates whether the donor or funding agency must be notified of the finding and corrective action plan per grant agreement terms.',
    `escalation_date` DATE COMMENT 'Date when the corrective action plan was escalated to higher authority. Null if no escalation occurred.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the corrective action plan requires escalation to senior management, board of directors, or external parties due to severity or complexity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action plan, including staff time, system changes, training, and other resources.',
    `finding_reference_number` STRING COMMENT 'External reference number from the audit report, CHS verification report, or donor compliance review that documented the original finding.',
    `finding_severity` STRING COMMENT 'Severity level of the finding as assessed by auditors or compliance reviewers, indicating urgency and risk exposure.. Valid values are `critical|high|medium|low`',
    `finding_type` STRING COMMENT 'Classification of the underlying issue that necessitated the corrective action plan.. Valid values are `audit_finding|chs_non_conformity|donor_compliance_issue|internal_control_deficiency|regulatory_violation|fraud_allegation`',
    `management_response` STRING COMMENT 'Official management response to the finding, documenting agreement or disagreement with the finding and planned corrective actions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the corrective action plan, including progress updates, challenges encountered, or lessons learned.',
    `preventive_measures` STRING COMMENT 'Description of preventive measures implemented to reduce the risk of recurrence, such as policy changes, training programs, or system controls.',
    `recurrence_risk` STRING COMMENT 'Assessment of the risk that the finding could recur if corrective actions are not sustained or are inadequately implemented.. Valid values are `high|medium|low`',
    `regulatory_reporting_date` DATE COMMENT 'Date when the finding and corrective action plan were reported to regulatory authorities. Null if reporting not required or not yet submitted.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the finding and corrective action plan must be reported to regulatory authorities such as IRS, Charity Commission, or OCHA.',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for executing the corrective action plan.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) that led to the finding, supporting effective remediation and prevention of recurrence.',
    `sphere_standard_reference` STRING COMMENT 'Reference to the specific Sphere Humanitarian Charter or Minimum Standard that was not met, if the finding relates to humanitarian quality standards.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action plan is expected to be fully implemented and closed.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective by auditors, compliance officers, or management.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action has been effectively implemented and the finding has been remediated. [ENUM-REF-CANDIDATE: document_review|site_visit|testing|management_attestation|external_audit|internal_audit|chs_verification — 7 candidates stripped; promote to reference product]',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process, documenting evidence reviewed and conclusions reached regarding corrective action effectiveness.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Master record of corrective action plans (CAPs) developed in response to audit findings, CHS non-conformities, donor compliance issues, or internal control deficiencies. Captures finding reference, corrective action description, responsible manager, target completion date, actual completion date, verification method, and status (open, in progress, closed, overdue). Supports management response documentation required by 2 CFR 200 and CHS Alliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` (
    `chs_self_assessment_id` BIGINT COMMENT 'Unique identifier for the CHS self-assessment cycle record.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: CHS self-assessments use specific platforms for data collection, evidence management, and verification (quality management systems, survey tools). Nonprofits must track which platform houses assessmen',
    `country_office_id` BIGINT COMMENT 'Foreign key reference to the country office that is the subject of this assessment, if the scope is country_office.',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program that is the subject of this assessment, if the scope is program.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: CHS (Core Humanitarian Standard) self-assessments satisfy CHS compliance obligations. The obligation table tracks chs_self_assessment_required flag. One assessment satisfies one obligation instance; o',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: CHS Commitment 5 requires PSEA policy implementation and assessment. Real business process: humanitarian standards compliance verification where CHS self-assessments evaluate organizational PSEA polic',
    `assessment_code` STRING COMMENT 'Business identifier for the self-assessment cycle, typically formatted as CHS-[Country]-[Year]-[Sequence].. Valid values are `^CHS-[A-Z]{3}-[0-9]{4}-[0-9]{2}$`',
    `assessment_methodology` STRING COMMENT 'The methodology used to conduct the CHS self-assessment: internal self-assessment (staff-led), peer review (peer organization review), independent verification (third-party auditor), hybrid (combination of methods).. Valid values are `internal_self_assessment|peer_review|independent_verification|hybrid`',
    `assessment_notes` STRING COMMENT 'General notes, observations, and contextual information about the self-assessment process and findings.',
    `assessment_period_end_date` DATE COMMENT 'The end date of the period being assessed for CHS conformity.',
    `assessment_period_start_date` DATE COMMENT 'The start date of the period being assessed for CHS conformity.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the self-assessment: planned (scheduled but not started), in_progress (data collection underway), under_review (internal review), completed (finalized), verified (third-party verified), archived (historical record).. Valid values are `planned|in_progress|under_review|completed|verified|archived`',
    `assessment_team_members` STRING COMMENT 'Comma-separated list of names of team members who participated in the self-assessment process.',
    `certification_target_flag` BOOLEAN COMMENT 'Indicates whether this self-assessment is being conducted as part of a formal CHS certification process (True) or for internal improvement purposes only (False).',
    `commitment_1_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 1.',
    `commitment_1_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 1, including documentation references and examples.',
    `commitment_1_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 1.',
    `commitment_1_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 1 (Humanitarian assistance is appropriate and relevant): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_2_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 2.',
    `commitment_2_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 2, including documentation references and examples.',
    `commitment_2_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 2.',
    `commitment_2_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 2 (Humanitarian response is effective and timely): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_3_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 3.',
    `commitment_3_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 3, including documentation references and examples.',
    `commitment_3_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 3.',
    `commitment_3_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 3 (Communities and people affected by crisis are not negatively affected and are more prepared, resilient and less at-risk): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_4_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 4.',
    `commitment_4_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 4, including documentation references and examples.',
    `commitment_4_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 4.',
    `commitment_4_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 4 (Communication with communities and people affected by crisis is frequent, accessible and two-way): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_5_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 5.',
    `commitment_5_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 5, including documentation references and examples.',
    `commitment_5_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 5.',
    `commitment_5_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 5 (Complaints are welcomed and addressed): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_6_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 6.',
    `commitment_6_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 6, including documentation references and examples.',
    `commitment_6_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 6.',
    `commitment_6_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 6 (Humanitarian response is coordinated and complementary): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_7_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 7.',
    `commitment_7_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 7, including documentation references and examples.',
    `commitment_7_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 7.',
    `commitment_7_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 7 (Humanitarian actors continuously learn and improve): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_8_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 8.',
    `commitment_8_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 8, including documentation references and examples.',
    `commitment_8_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 8.',
    `commitment_8_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 8 (Staff are supported to do their job effectively and are treated fairly and equitably): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `commitment_9_assessor_notes` STRING COMMENT 'Assessor observations, findings, and rationale for the conformity rating assigned to CHS Commitment 9.',
    `commitment_9_evidence` STRING COMMENT 'Summary of evidence provided to support the conformity rating for CHS Commitment 9, including documentation references and examples.',
    `commitment_9_improvement_actions` STRING COMMENT 'Recommended improvement actions and corrective measures to enhance conformity with CHS Commitment 9.',
    `commitment_9_rating` DECIMAL(18,2) COMMENT 'Conformity rating for CHS Commitment 9 (Resources are managed and used responsibly for their intended purpose): numeric score from 1.00 (non-conforming) to 5.00 (fully conforming).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CHS self-assessment record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CHS self-assessment record was last updated.',
    `lead_assessor_email` STRING COMMENT 'Email address of the lead assessor for assessment coordination and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `lead_assessor_name` STRING COMMENT 'Full name of the lead assessor responsible for coordinating the CHS self-assessment process.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next CHS self-assessment cycle, typically 12-24 months after the current assessment.',
    `overall_conformity_rating` STRING COMMENT 'Aggregate conformity rating across all nine CHS commitments: non-conforming (significant gaps), partially conforming (some evidence), largely conforming (most requirements met), fully conforming (all requirements met), not assessed (assessment incomplete).. Valid values are `non_conforming|partially_conforming|largely_conforming|fully_conforming|not_assessed`',
    `overall_conformity_score` DECIMAL(18,2) COMMENT 'Numeric overall conformity score calculated as the average of all commitment ratings, typically on a scale of 1.00 to 5.00.',
    `submission_date` DATE COMMENT 'Date when the completed self-assessment was formally submitted to the CHS Alliance or verification body.',
    `verification_body` STRING COMMENT 'Name of the CHS Alliance-approved verification body or independent auditor that conducted third-party verification, if applicable.',
    `verification_date` DATE COMMENT 'Date when third-party verification of the self-assessment was completed, if applicable.',
    CONSTRAINT pk_chs_self_assessment PRIMARY KEY(`chs_self_assessment_id`)
) COMMENT 'Master record of Core Humanitarian Standard (CHS) self-assessment cycles including per-commitment conformity ratings. Captures assessment period, methodology (internal, peer review, third-party verification), CHS Alliance verification body, overall conformity rating, scope (organizational, country office, program), lead assessor, and submission date. Includes granular ratings for each of the nine CHS commitments: commitment number, performance indicator, evidence provided, rating score (1-5), assessor notes, and improvement actions. Enables tracking of humanitarian accountability standards compliance and progress toward CHS certification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` (
    `iati_publication_id` BIGINT COMMENT 'Unique identifier for the IATI publication record. Primary key for tracking individual publication events to the IATI Registry.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: IATI publications satisfy transparency and accountability obligations (IATI reporting requirements). The obligation table tracks that iati_publication_required flag. One publication satisfies one obli',
    `partner_org_id` BIGINT COMMENT 'Reference to the organization entity that owns this IATI publication. Links to the master organization record.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: IATI publications are generated from and published through specific platforms (grants management system, IATI publisher tool). Nonprofits track which system produced each publication for data quality ',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: IATI publications to the IATI Registry are a specialized type of regulatory filing. One IATI publication is one filing; one filing is one publication. Publication metadata (date, timestamp, URL, file ',
    `superseded_by_publication_iati_publication_id` BIGINT COMMENT 'Reference to the newer IATI publication that replaces this record. Null if this is the current active publication.',
    `activity_count` STRING COMMENT 'Total number of IATI activity records included in this publication. Used for completeness validation and registry statistics.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of recommended IATI fields populated across all activities in this publication. Measures adherence to IATI best practices for comprehensive reporting.',
    `created_by_user` STRING COMMENT 'Username or identifier of the staff member who initiated this IATI publication. Used for accountability and change management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IATI publication record was first created in the system. Used for audit trail and publication history analysis.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) assessing completeness and accuracy of IATI data elements based on IATI Dashboard methodology. Higher scores indicate better data quality.',
    `donor_requirement_compliance` STRING COMMENT 'Assessment of whether this publication meets specific IATI transparency requirements mandated by major donors (USAID, FCDO, DAC members). Used for grant compliance reporting.. Valid values are `compliant|partial|non_compliant|not_applicable`',
    `file_size_bytes` BIGINT COMMENT 'Size of the published IATI XML file in bytes. Used for technical monitoring and registry performance optimization.',
    `iati_organization_identifier` STRING COMMENT 'The globally unique IATI organization identifier assigned by the IATI Registry. Format follows IATI standard: country code, registration agency, and registration number (e.g., US-EIN-123456789).. Valid values are `^[A-Z]{2}-[A-Z]+-[0-9]+$`',
    `iati_version` STRING COMMENT 'The version of the IATI Standard used for this publication (e.g., 2.03, 2.02, 1.05). Determines schema validation rules and available fields.. Valid values are `^[0-9]+.[0-9]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this IATI publication record. Tracks changes to metadata or file content after initial publication.',
    `notes` STRING COMMENT 'Free-text field for internal notes about this publication, including special circumstances, data quality issues, or donor-specific requirements addressed.',
    `publication_status` STRING COMMENT 'Current lifecycle status of this IATI publication. Published indicates active availability on the registry; superseded indicates replacement by a newer version.. Valid values are `published|draft|withdrawn|superseded`',
    `publication_type` STRING COMMENT 'Type of IATI file published: organization-level file containing organizational metadata, or activity-level file containing individual project/program records.. Valid values are `organization|activity`',
    `publisher_contact_email` STRING COMMENT 'Email address of the organizational contact responsible for this IATI publication. Used for data quality inquiries and registry communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_country_count` STRING COMMENT 'Number of distinct recipient countries covered by activities in this publication. Indicates geographic scope of transparency reporting.',
    `registry_dataset_code` STRING COMMENT 'Unique dataset identifier assigned by the IATI Registry system. Used for programmatic access via IATI Registry API.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code used for financial values in this publication (e.g., USD, EUR, GBP). All monetary amounts are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this IATI publication. Used to assess data currency and timeliness compliance.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this IATI publication. Defines the temporal scope of activities and financial data included.',
    `sector_count` STRING COMMENT 'Number of distinct Development Assistance Committee (DAC) sector codes represented in this publication. Indicates thematic diversity of reported activities.',
    `timeliness_category` STRING COMMENT 'Qualitative assessment of publication timeliness based on the timeliness score. Used for donor reporting and transparency benchmarking.. Valid values are `excellent|good|fair|poor`',
    `timeliness_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) measuring how current the published data is relative to the reporting period end date. Higher scores indicate more timely transparency reporting.',
    `total_budget_value` DECIMAL(18,2) COMMENT 'Aggregate budget value across all activities included in this publication, in the organizations reporting currency. Provides summary financial transparency metric.',
    `total_disbursement_value` DECIMAL(18,2) COMMENT 'Aggregate actual disbursement value across all activities in this publication, in the organizations reporting currency. Represents total funds deployed during the reporting period.',
    `validation_error_count` STRING COMMENT 'Number of schema validation errors detected in the published IATI file. Zero indicates full technical compliance with the IATI Standard.',
    `validation_warning_count` STRING COMMENT 'Number of non-critical warnings identified during IATI validation. Warnings indicate recommended improvements but do not prevent publication.',
    CONSTRAINT pk_iati_publication PRIMARY KEY(`iati_publication_id`)
) COMMENT 'Master record of IATI (International Aid Transparency Initiative) publications to the IATI Registry, covering both organization-level files and individual activity records. Tracks IATI organization identifier, publication date, registry URL, file type, IATI version, timeliness score, and per-activity detail including IATI activity identifier, title, status, dates, recipient countries, DAC sector codes, budgets, and disbursements. Supports compliance with IATI Standard and donor transparency requirements from USAID, FCDO, and DAC members. Systems-of-record: IATI Registry, d-portal, eTools IATI export. Framework: IATI Standard v2.03 / Grand Bargain transparency commitments.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` (
    `governance_policy_id` BIGINT COMMENT 'Unique identifier for the governance policy record. Primary key.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Governance policies are managed in document management or governance platforms for version control, approval workflow, and access management. Nonprofits track which system houses each policy for board',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Board governance policies reference and approve organizational PSEA policies. Real business process: board oversight and policy approval where governance resolutions formally adopt PSEA policies and t',
    `superseded_by_policy_governance_policy_id` BIGINT COMMENT 'Reference to the governance policy that supersedes this document. Used to track policy version lineage when a new version replaces an older one. Null if this is the current active version.',
    `annual_certification_status` STRING COMMENT 'For conflict-of-interest (COI) disclosures: the status of the annual COI certification requirement for the disclosing party. Indicates whether the annual disclosure has been completed, is pending, is overdue, or is not required for this document type.. Valid values are `certified|pending|overdue|not_required`',
    `approval_date` DATE COMMENT 'The date on which the approving authority formally approved the governance policy or resolution.',
    `approving_authority` STRING COMMENT 'The governing body or individual who formally approved the policy. Typically the Board of Directors, Executive Director, or designated committee.',
    `governance_policy_category` STRING COMMENT 'The functional category or domain of the governance policy. Includes financial management, human resources (HR), safeguarding, anti-fraud, data protection, and conflict-of-interest (COI) policies.. Valid values are `financial|hr|safeguarding|anti_fraud|data_protection|coi`',
    `certification_date` DATE COMMENT 'For conflict-of-interest (COI) disclosures: the date on which the disclosing party signed the annual COI certification. Null for non-COI documents or uncertified disclosures.',
    `compliance_framework` STRING COMMENT 'The external regulatory or industry standard framework that the governance policy is designed to satisfy (e.g., IRS 501(c)(3), Charity Commission, Core Humanitarian Standard, GDPR, OMB Uniform Guidance 2 CFR 200).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this governance policy record was first created in the system.',
    `governance_policy_description` STRING COMMENT 'A detailed narrative description of the governance policys purpose, scope, and key provisions.',
    `disclosing_party` STRING COMMENT 'For conflict-of-interest (COI) disclosures: the name of the board member, officer, or key employee making the disclosure. Null for non-COI documents.',
    `document_owner` STRING COMMENT 'The department, role, or individual responsible for maintaining, updating, and ensuring compliance with the governance policy.',
    `document_type` STRING COMMENT 'Classification of the governance document type. Distinguishes between organizational policies, board resolutions, bylaws, charters, conflict-of-interest (COI) disclosures, and internal control frameworks.. Valid values are `policy|resolution|bylaw|charter|coi_disclosure|framework`',
    `document_url` STRING COMMENT 'The file path or URL where the full governance policy document is stored in the organizations document management system or cloud storage.',
    `effective_date` DATE COMMENT 'The date on which the governance policy becomes binding and enforceable within the organization.',
    `expiry_date` DATE COMMENT 'The date on which the governance policy ceases to be effective or is scheduled for mandatory review. Nullable for policies without a defined expiration.',
    `governance_policy_status` STRING COMMENT 'Current lifecycle status of the governance policy. Indicates whether the document is in draft, active and enforceable, under review for revision, superseded by a newer version, or archived.. Valid values are `draft|active|under_review|superseded|archived`',
    `irs_990_disclosure_required` BOOLEAN COMMENT 'Boolean flag indicating whether this governance policy or resolution must be disclosed on the organizations IRS Form 990 (Schedule O or Part VI).',
    `last_review_date` DATE COMMENT 'The date on which the governance policy was most recently reviewed by the responsible authority.',
    `meeting_date` DATE COMMENT 'For board resolutions: the date of the board or committee meeting at which the resolution was passed. Null for non-resolution documents.',
    `meeting_type` STRING COMMENT 'For board resolutions: the type of meeting at which the resolution was passed (regular, special, annual, or emergency). Null for non-resolution documents.. Valid values are `regular|special|annual|emergency`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this governance policy record was last modified or updated in the system.',
    `nature_of_conflict` STRING COMMENT 'For conflict-of-interest (COI) disclosures: a description of the nature and circumstances of the potential or actual conflict of interest. Null for non-COI documents.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next mandatory review of the governance policy.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the governance policy, resolution, or disclosure. Used for internal documentation and audit trail purposes.',
    `policy_name` STRING COMMENT 'The official name or title of the governance policy, resolution, bylaw, or charter document.',
    `policy_number` STRING COMMENT 'The unique business identifier or reference number assigned to the governance document for tracking and citation purposes.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this governance policy is publicly available or must be disclosed to donors, regulators, or the public under transparency requirements.',
    `recusal_decision` STRING COMMENT 'For conflict-of-interest (COI) disclosures: whether the disclosing party recused themselves from decision-making related to the conflict. Null for non-COI documents.. Valid values are `recused|not_recused|partial_recusal`',
    `related_party` STRING COMMENT 'For conflict-of-interest (COI) disclosures: the name of the related party (individual, organization, or entity) involved in the conflict. Null for non-COI documents.',
    `resolution_number` STRING COMMENT 'For board resolutions: the unique sequential identifier assigned to the resolution for tracking and reference. Null for non-resolution documents.',
    `resolution_text` STRING COMMENT 'For board resolutions: the full text of the resolution as recorded in the meeting minutes. Null for non-resolution documents.',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which the governance policy is scheduled for mandatory review and potential revision.',
    `review_outcome` STRING COMMENT 'For conflict-of-interest (COI) disclosures: the outcome of the board or committee review of the disclosed conflict (approved with safeguards, mitigated through controls, prohibited transaction, or still under review). Null for non-COI documents.. Valid values are `approved|mitigated|prohibited|under_review`',
    `scope` STRING COMMENT 'The organizational units, geographic regions, or functional areas to which the governance policy applies.',
    `version` STRING COMMENT 'The version number or identifier of the governance document, tracking revisions and updates over time.',
    `vote_outcome` STRING COMMENT 'For board resolutions: the outcome of the vote on the resolution (passed, failed, tabled for future consideration, or withdrawn). Null for non-resolution documents.. Valid values are `passed|failed|tabled|withdrawn`',
    `votes_abstained` STRING COMMENT 'For board resolutions: the number of board members who abstained from voting on the resolution. Null for non-resolution documents.',
    `votes_against` STRING COMMENT 'For board resolutions: the number of votes cast against the resolution. Null for non-resolution documents.',
    `votes_for` STRING COMMENT 'For board resolutions: the number of votes cast in favor of the resolution. Null for non-resolution documents.',
    CONSTRAINT pk_governance_policy PRIMARY KEY(`governance_policy_id`)
) COMMENT 'Master catalog of organizational governance documents including board-approved policies, bylaws, board resolutions, charters, conflict-of-interest disclosures, and internal control frameworks. Captures document type (policy, resolution, bylaw, charter, COI disclosure), name, category (financial, HR, safeguarding, anti-fraud, data protection, COI), version, effective/expiry dates, approving authority, document owner, review cycle. For resolutions: meeting date, meeting type, resolution text, vote outcome, and resolution number. For COI disclosures: disclosing party, nature of conflict, related party, recusal decision, review outcome, and annual certification status. Supports IRS 990 Schedule O and Part VI governance disclosures, Charity Commission annual returns, and donor due diligence.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` (
    `donor_requirement_id` BIGINT COMMENT 'Primary key for donor_requirement',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this compliance requirement applies.',
    `constituent_id` BIGINT COMMENT 'Reference to the institutional donor imposing this compliance requirement.',
    `staff_member_id` BIGINT COMMENT 'Reference to the user who last modified this compliance requirement record, used for audit trail and accountability.',
    `donor_staff_member_id` BIGINT COMMENT 'Reference to the staff member assigned primary responsibility for ensuring compliance with this requirement.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Donor reporting requirements are fulfilled through specific platforms (grants management systems, donor portals, reporting tools). Nonprofits must track which system fulfills each requirement for work',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Donor-specific compliance requirements are instances of broader compliance obligations. One donor requirement maps to one obligation in the master catalog; one obligation may be driven by multiple don',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'The actual number of staff hours expended in fulfilling this compliance requirement, used for future planning and cost analysis.',
    `approval_date` DATE COMMENT 'The date on which the donor formally approved or accepted the compliance submission.',
    `associated_cost_amount` DECIMAL(18,2) COMMENT 'The direct financial cost incurred to fulfill this compliance requirement, including consultant fees, audit costs, or system expenses.',
    `compliance_status` STRING COMMENT 'Current status of the organizations compliance with this requirement, tracking progress from initiation through approval or waiver. [ENUM-REF-CANDIDATE: not_started|in_progress|submitted|under_review|approved|overdue|waived — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the associated cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance requirement record was first created in the system.',
    `deliverable_format` STRING COMMENT 'The required format or medium for the compliance deliverable, such as PDF report, online portal submission, or physical document.',
    `donor_contact_email` STRING COMMENT 'The email address of the donor representative responsible for receiving and reviewing compliance submissions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'The name of the donor representative or point of contact for questions and submissions related to this compliance requirement.',
    `due_date` DATE COMMENT 'The date by which the compliance requirement must be fulfilled and submitted to the donor.',
    `effective_end_date` DATE COMMENT 'The date on which this compliance requirement expires or is no longer applicable, typically aligned with grant closure.',
    `effective_start_date` DATE COMMENT 'The date from which this compliance requirement becomes active and applicable to the grant.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'The estimated number of staff hours required to complete and submit this compliance requirement.',
    `internal_policy_reference` STRING COMMENT 'Reference to the organizations internal policy or procedure document that governs how this compliance requirement is fulfilled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance requirement record was last updated or modified.',
    `non_compliance_consequence` STRING COMMENT 'Description of the potential consequences or penalties for failing to meet this compliance requirement, such as grant suspension, fund recovery, or donor relationship damage.',
    `non_compliance_risk_level` STRING COMMENT 'The assessed risk level to the organization if this compliance requirement is not met, considering financial, reputational, and operational impacts.. Valid values are `low|medium|high|critical`',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to this compliance requirement, used for internal coordination and knowledge sharing.',
    `priority_level` STRING COMMENT 'The urgency and importance level assigned to this compliance requirement, used for resource allocation and risk management.. Valid values are `critical|high|medium|low`',
    `related_regulation_reference` STRING COMMENT 'Reference to the specific regulatory framework, law, or standard that underpins this donor requirement, such as OMB 2 CFR 200, IATI, or CHS.',
    `requirement_description` STRING COMMENT 'Detailed narrative description of the compliance requirement, including specific obligations, deliverables, and conditions imposed by the donor.',
    `requirement_reference_number` STRING COMMENT 'External reference number or code assigned by the donor to this compliance requirement, used for tracking and correspondence.',
    `requirement_title` STRING COMMENT 'Short descriptive title of the compliance requirement for quick identification and reporting.',
    `responsible_department` STRING COMMENT 'The organizational department or unit responsible for managing and fulfilling this compliance requirement.',
    `submission_date` DATE COMMENT 'The actual date on which the compliance deliverable was submitted to the donor.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the compliance deliverable must be submitted to the donor.. Valid values are `email|online_portal|postal_mail|in_person|ftp`',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation, templates, or guidance materials related to this compliance requirement.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the donor has approved a waiver or exemption for this compliance requirement.',
    `waiver_justification` STRING COMMENT 'The rationale or explanation provided for requesting a waiver from this compliance requirement.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether the organization has formally requested a waiver or exemption from this compliance requirement.',
    CONSTRAINT pk_donor_requirement PRIMARY KEY(`donor_requirement_id`)
) COMMENT 'Master record of specific compliance requirements imposed by individual institutional donors (USAID, DFID, EU, UN agencies) on grants awarded to the organization. Captures donor name, grant reference, requirement type (financial reporting, programmatic reporting, audit, visibility, procurement rules, anti-terrorism certification, NICRA application), requirement description, due date, and compliance status. Distinct from general regulatory obligations — these are donor-specific contractual compliance conditions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` (
    `compliance_incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or field location where the incident occurred.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding award affected by the incident. Critical for donor notification obligations.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program where the incident occurred or was detected. Links to program master data.',
    `it_incident_id` BIGINT COMMENT 'Foreign key linking to technology.it_incident. Business justification: Compliance incidents (fraud, data breach, misconduct) often trigger or relate to IT security incidents. Nonprofits must link these for coordinated investigation, root cause analysis, and integrated co',
    `allegation_category` STRING COMMENT 'Specific category of the allegation within the broader incident type. Supports detailed classification for MEL and donor reporting. [ENUM-REF-CANDIDATE: corruption|theft|misappropriation|conflict_of_interest|harassment|discrimination|safeguarding_violation|data_breach|regulatory_noncompliance — 9 candidates stripped; promote to reference product]',
    `corrective_action_taken` STRING COMMENT 'Summary of corrective actions, disciplinary measures, or process improvements implemented in response to the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the system.',
    `donor_notification_date` DATE COMMENT 'Date when the donor was formally notified of the incident per contractual obligations.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident meets donor notification thresholds per grant agreements. True if notification is required.',
    `estimated_financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial loss or exposure in US Dollars resulting from the incident. Used for materiality assessment and donor reporting thresholds.',
    `incident_date` DATE COMMENT 'Date when the alleged incident or violation occurred. May be approximate if exact date is unknown.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident, allegations, and circumstances. Confidential to protect investigation and individuals.',
    `incident_number` STRING COMMENT 'Externally-visible unique incident reference number used for tracking and donor reporting. Format: INC-YYYYMMDD.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident in the investigation and resolution workflow.. Valid values are `reported|under_review|investigation_open|investigation_closed|resolved|dismissed`',
    `incident_type` STRING COMMENT 'Primary classification of the compliance incident. Determines investigation protocol and reporting obligations.. Valid values are `fraud|financial_mismanagement|procurement_irregularity|data_protection_violation|ethical_breach|safeguarding`',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the investigator or investigation team assigned to the case. Confidential to protect investigation integrity.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was formally closed and findings documented.',
    `investigation_finding` STRING COMMENT 'Final determination of the investigation regarding the validity of the allegation. Confidential until disclosure obligations are met.. Valid values are `substantiated|partially_substantiated|unsubstantiated|inconclusive`',
    `investigation_notes` STRING COMMENT 'Internal notes and observations from the investigation process. Confidential working document.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation was initiated following triage and preliminary assessment.',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person who last modified this incident record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last updated.',
    `lessons_learned` STRING COMMENT 'Key lessons and insights captured from the incident for organizational learning and process improvement per MEL framework.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the incident and its resolution have been publicly disclosed per transparency commitments. True if disclosed.',
    `regulatory_report_date` DATE COMMENT 'Date when the incident was reported to the relevant regulatory authority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the incident must be reported to regulatory authorities (Charity Commission, IRS, OCHA). True if reporting is required.',
    `related_incident_ids` STRING COMMENT 'Comma-separated list of related or linked incident IDs if this incident is part of a pattern or connected to other cases.',
    `reported_date` DATE COMMENT 'Date when the incident was first reported to the organization through any channel.',
    `reporter_anonymity_flag` BOOLEAN COMMENT 'Indicates whether the reporter requested anonymity or submitted the report anonymously. True if anonymous.',
    `reporter_contact_info` STRING COMMENT 'Contact information for the reporter if they provided it and did not request anonymity. Used for follow-up and feedback.',
    `reporting_channel` STRING COMMENT 'Channel or mechanism through which the incident was reported to the organization. [ENUM-REF-CANDIDATE: internal_detection|anonymous_hotline|whistleblower_portal|donor_notification|beneficiary_complaint|partner_report|audit_finding — 7 candidates stripped; promote to reference product]',
    `resolution_date` DATE COMMENT 'Date when all corrective actions were completed and the incident was formally closed.',
    `severity_level` STRING COMMENT 'Assessed severity of the incident based on impact to beneficiaries, financial exposure, reputational risk, and regulatory implications.. Valid values are `critical|high|medium|low`',
    `triage_outcome` STRING COMMENT 'Initial triage decision determining the handling pathway for the reported incident.. Valid values are `escalate_to_investigation|refer_to_management|refer_to_hr|refer_to_legal|no_action_required|duplicate`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this incident record.',
    CONSTRAINT pk_compliance_incident PRIMARY KEY(`compliance_incident_id`)
) COMMENT 'SSOT for regulatory and policy compliance incidents (fraud, misuse of funds, regulatory breaches, audit findings). Distinct from safeguarding.safeguarding_incident which covers PSEA, sexual exploitation, abuse, and harassment incidents.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` (
    `nicra_agreement_id` BIGINT COMMENT 'Unique identifier for the NICRA agreement record. Primary key.',
    `cognizant_agency_id` BIGINT COMMENT 'Reference to the federal agency responsible for negotiating and approving this NICRA (typically USAID, DHHS, or other federal agency).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: NICRA agreements satisfy the compliance obligation to negotiate and maintain indirect cost rate agreements with cognizant federal agencies. One NICRA satisfies one obligation instance; one obligation ',
    `primary_predecessor_agreement_nicra_agreement_id` BIGINT COMMENT 'Reference to the previous NICRA agreement that this agreement supersedes or replaces. Enables tracking of NICRA history and rate evolution over time.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: NICRA (Negotiated Indirect Cost Rate Agreement) submissions to cognizant agencies are regulatory filings. One NICRA agreement has one filing submission; one filing is for one NICRA. Submission and app',
    `agreement_number` STRING COMMENT 'The official agreement number assigned by the cognizant agency to this NICRA. This is the externally-known identifier used in grant reporting and audit documentation.',
    `applicable_programs` STRING COMMENT 'Description of the federal programs, grants, or awards to which this NICRA applies. May specify all federal awards or list specific programs, agencies, or award types covered by this agreement.',
    `audit_findings_reference` STRING COMMENT 'Reference to any Single Audit or A-133 audit findings related to indirect cost rate compliance that informed this NICRA negotiation or require corrective action.',
    `cognizant_agency_contact_email` STRING COMMENT 'Email address of the cognizant agency contact for correspondence regarding this NICRA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cognizant_agency_contact_name` STRING COMMENT 'Name of the primary contact person at the cognizant agency responsible for this NICRA negotiation and oversight.',
    `cognizant_agency_contact_phone` STRING COMMENT 'Phone number of the cognizant agency contact for inquiries regarding this NICRA.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding compliance requirements, special conditions, or operational guidance for applying this NICRA to federal awards.',
    `cost_base_type` STRING COMMENT 'The cost base to which the indirect cost rate is applied: MTDC (Modified Total Direct Costs, excluding capital expenditures, equipment, subawards over $25K, and other exclusions per 2 CFR 200.68), TDC (Total Direct Costs), salaries_and_wages, or direct_salaries.. Valid values are `MTDC|TDC|salaries_and_wages|direct_salaries`',
    `cost_pool_definition` STRING COMMENT 'Detailed description of the Facilities and Administration (F&A) cost pools included in the indirect cost rate calculation, such as general administration, facilities operation and maintenance, depreciation, and other allowable indirect costs per 2 CFR 200 Appendix IV.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NICRA agreement record was first created in the system.',
    `de_minimis_rate_elected` BOOLEAN COMMENT 'Indicates whether the organization elected to use the de minimis indirect cost rate of 10% of MTDC as permitted under 2 CFR 200.414(f) for organizations that have never received a negotiated indirect cost rate. True if de minimis rate is elected, False otherwise.',
    `effective_end_date` DATE COMMENT 'The date on which this NICRA expires. Nullable for open-ended agreements pending final rate determination.',
    `effective_start_date` DATE COMMENT 'The date from which this NICRA becomes effective and the negotiated indirect cost rates may be applied to federal awards.',
    `exclusions_and_limitations` STRING COMMENT 'Any exclusions, limitations, or special conditions imposed by the cognizant agency on the use of this NICRA, such as caps on specific cost categories, excluded programs, or required cost allocation adjustments.',
    `fiscal_year_basis` STRING COMMENT 'The organizations fiscal year period on which the indirect cost rate calculation is based (e.g., July 1 - June 30, January 1 - December 31). Critical for aligning rate application with organizational accounting periods.',
    `fringe_benefit_rate_percentage` DECIMAL(18,2) COMMENT 'The negotiated fringe benefit rate percentage applied to salaries and wages to calculate employee benefits costs. May be included in the NICRA if fringe is treated as an indirect cost pool.',
    `indirect_cost_rate_percentage` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate expressed as a percentage (e.g., 15.50 for 15.50%). This is the primary rate applied to the cost base to calculate Facilities and Administration (F&A) costs recoverable from federal awards.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NICRA agreement record was last modified in the system.',
    `negotiation_date` DATE COMMENT 'The date on which the indirect cost rate negotiation with the cognizant agency was completed and the NICRA was formally executed.',
    `nicra_agreement_status` STRING COMMENT 'Current lifecycle status of the NICRA: draft (being prepared), pending_approval (submitted to cognizant agency), active (in effect), expired (past effective period), superseded (replaced by newer NICRA), or terminated (cancelled before expiry).. Valid values are `draft|pending_approval|active|expired|superseded|terminated`',
    `organizational_unit_applicability` STRING COMMENT 'Specifies which organizational units, divisions, or legal entities within the nonprofit organization this NICRA applies to. Important for multi-entity organizations with separate NICRAs for different subsidiaries or country offices.',
    `rate_adjustment_provision` STRING COMMENT 'Description of any provisions for rate adjustments, carry-forward of under/over-recoveries, or reconciliation requirements specified in the NICRA.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to the supporting documentation submitted with the indirect cost rate proposal, including cost allocation plans, financial statements, audit reports, and other materials required by the cognizant agency.',
    CONSTRAINT pk_nicra_agreement PRIMARY KEY(`nicra_agreement_id`)
) COMMENT 'Master record of Negotiated Indirect Cost Rate Agreements (NICRAs) between the organization and its US federal cognizant agency (typically USAID or DHHS). Captures NICRA effective date, expiry date, cognizant agency, indirect cost rate type (predetermined, fixed, provisional, final), rate percentage, base type (MTDC, TDC, salaries), applicable programs, and F&A (Facilities and Administration) cost pool definitions. Critical for US federal grant financial compliance under 2 CFR 200.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` (
    `statutory_registration_id` BIGINT COMMENT 'Unique identifier for the statutory registration record. Primary key for this entity.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Statutory registration data (legal entity information, tax status, operating authority) is maintained in legal entity management or ERP systems. Nonprofits track which system is the source of truth fo',
    `compliance_status` STRING COMMENT 'Current compliance status with the reporting and operational requirements of this registration. Compliant indicates all requirements met; Non-compliant indicates violations or missed filings; Under Review indicates regulatory audit or investigation in progress; Remediation Required indicates corrective action needed.. Valid values are `compliant|non_compliant|under_review|remediation_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this statutory registration record was first created in the system.',
    `deductibility_code` STRING COMMENT 'IRS deductibility code indicating the extent to which contributions are tax-deductible (e.g., PC for public charity, PF for private foundation). Applicable primarily to US 501(c)(3) registrations.',
    `determination_letter_date` DATE COMMENT 'Date of the official determination letter or registration certificate issued by the regulatory authority. Particularly relevant for US 501(c)(3) IRS determination letters.',
    `doing_business_as_name` STRING COMMENT 'Alternative operating name or trade name used by the organization, if different from the registered legal name.',
    `donor_eligibility_verified_flag` BOOLEAN COMMENT 'Indicates whether this registration has been verified for donor eligibility purposes (e.g., eligible to receive grants from institutional donors, government agencies, or foundations). True if verified; False if not verified or verification pending.',
    `effective_date` DATE COMMENT 'Date from which the statutory registration becomes legally effective and the organization can operate under this registration.',
    `expiry_date` DATE COMMENT 'Date when the statutory registration expires and requires renewal. Null for registrations with indefinite validity.',
    `foreign_operations_permitted_flag` BOOLEAN COMMENT 'Indicates whether this registration permits the organization to conduct operations or provide services outside the jurisdiction of registration. True if foreign operations are permitted; False if restricted to domestic operations only.',
    `foundation_status` STRING COMMENT 'Classification of the organization as a public charity or type of private foundation. Relevant for US 501(c)(3) organizations.. Valid values are `public_charity|private_operating_foundation|private_non_operating_foundation|not_applicable`',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the organization is registered (e.g., USA, GBR, KEN).. Valid values are `^[A-Z]{3}$`',
    `last_filing_date` DATE COMMENT 'Date of the most recent regulatory filing or report submitted under this registration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this statutory registration record was last updated or modified.',
    `next_filing_due_date` DATE COMMENT 'Date by which the next regulatory filing or report is due to maintain compliance with this registration.',
    `next_renewal_date` DATE COMMENT 'Date by which the next renewal application or filing must be submitted to maintain active registration status.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or contextual information about this statutory registration.',
    `operating_authority_granted_flag` BOOLEAN COMMENT 'Indicates whether this registration grants legal authority to operate programs and services in the jurisdiction. True if operating authority is granted; False if registration is for tax or reporting purposes only.',
    `public_charity_classification` STRING COMMENT 'IRS public charity classification under Section 509(a). 509(a)(1) for publicly supported organizations; 509(a)(2) for organizations receiving substantial support from program service revenue; 509(a)(3) for supporting organizations; Private Foundation if not qualifying as public charity; Not Applicable for non-US registrations.. Valid values are `509a1|509a2|509a3|private_foundation|not_applicable`',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address on file with the statutory authority.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address (suite, floor, building name, etc.).',
    `registered_city` STRING COMMENT 'City or municipality of the official registered address.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO country code of the official registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_legal_name` STRING COMMENT 'The official legal name of the organization as registered with the statutory authority. This is the name that appears on the determination letter or registration certificate.',
    `registered_postal_code` STRING COMMENT 'Postal code or ZIP code of the official registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region of the official registered address.',
    `registration_date` DATE COMMENT 'Date when the statutory registration was officially granted or approved by the regulatory authority.',
    `registration_document_url` STRING COMMENT 'URL or file path to the scanned copy of the official registration certificate, determination letter, or registration document.',
    `registration_number` STRING COMMENT 'Official registration number or identifier issued by the regulatory authority (e.g., EIN for US 501(c)(3), Charity Commission registration number).',
    `registration_status` STRING COMMENT 'Current lifecycle status of the statutory registration. Active indicates valid and in good standing; Pending indicates application submitted but not yet approved; Suspended indicates temporary hold; Revoked indicates permanently cancelled; Expired indicates past validity period; Lapsed indicates not renewed.. Valid values are `active|pending|suspended|revoked|expired|lapsed`',
    `registration_type` STRING COMMENT 'Type of statutory registration. Examples: 501(c)(3) for US tax-exempt status, Charity Commission for UK charities, NGO Registration for country-level registrations, Foreign Agent for FARA compliance, CSO (Civil Society Organization) Registration, INGO (International Non-Governmental Organization) Registration.. Valid values are `501c3|charity_commission|ngo_registration|foreign_agent|cso_registration|ingo_registration`',
    `regulatory_authority_name` STRING COMMENT 'Name of the government agency or regulatory body that issued and oversees this registration (e.g., Internal Revenue Service, Charity Commission for England and Wales, Ministry of Social Affairs).',
    `renewal_frequency` STRING COMMENT 'Frequency at which the statutory registration must be renewed. Not applicable for registrations that do not require renewal.. Valid values are `annual|biennial|triennial|quinquennial|not_applicable`',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this registration requires periodic renewal. True if renewal is required; False if registration is indefinite or does not require renewal.',
    `reporting_requirement_description` STRING COMMENT 'Description of the periodic reporting obligations associated with this registration (e.g., annual Form 990 filing, Charity Commission annual return, quarterly financial reports).',
    `tax_exempt_status` STRING COMMENT 'Tax exemption status granted under this registration. Exempt indicates full tax-exempt status; Non-exempt indicates no tax exemption; Conditional indicates exemption with specific conditions; Pending indicates exemption application under review.. Valid values are `exempt|non_exempt|conditional|pending`',
    CONSTRAINT pk_statutory_registration PRIMARY KEY(`statutory_registration_id`)
) COMMENT 'Master record of the organizations legal registrations and statutory status across all operating jurisdictions, including US 501(c)(3) IRS determination letter, UK Charity Commission registration, country-level NGO registrations, and foreign agent registrations. Captures jurisdiction, registration type, registration number, registration date, expiry date, registered name, registered address, and renewal requirements. Foundational for legal operating authority and donor eligibility verification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`internal_review` (
    `internal_review_id` BIGINT COMMENT 'Primary key for internal_review',
    `award_id` BIGINT COMMENT 'Identifier of the grant or award being reviewed for compliance. Nullable if the review is not grant-specific.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Compliance incidents often trigger internal reviews to investigate the incident, determine root cause, and assess impact. One internal review investigates one primary incident; one incident may trigge',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or field location that is the subject of this compliance review.',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program or project under review. Nullable if the review is office-wide rather than program-specific.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created this compliance review record. Audit trail for accountability.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Internal compliance reviews examine specific systems for regulatory compliance, data quality, and control effectiveness. Nonprofits must link reviews to systems for finding attribution, remediation tr',
    `security_assessment_id` BIGINT COMMENT 'Foreign key linking to technology.security_assessment. Business justification: Internal compliance reviews often trigger or reference security assessments for systems handling sensitive data (beneficiary PII, financial data). Nonprofits coordinate these for integrated assurance,',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or auditor who led the compliance review. Links to workforce or staff master data.',
    `compliance_framework_reference` STRING COMMENT 'Reference to the specific compliance framework, policy, or regulation against which the review was conducted (e.g., OMB 2 CFR 200, CHS, organizational policy number).',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which management must submit a corrective action plan addressing the review findings. Nullable if no corrective action is required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether corrective action is required as a result of the review findings. True if management must implement remediation actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance review record was first created in the system. Audit trail for record creation.',
    `critical_findings_count` STRING COMMENT 'Number of critical-severity findings identified during the review. Critical findings represent significant control failures or compliance violations requiring immediate action.',
    `donor_notification_date` DATE COMMENT 'Date when the donor or funding agency was formally notified of the review findings. Nullable if notification is not required.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor or funding agency must be notified of the review findings. True for material findings affecting grant compliance.',
    `external_auditor_coordination_flag` BOOLEAN COMMENT 'Boolean indicator of whether this internal review was coordinated with or informed by external auditor activities (e.g., Single Audit). True if coordination occurred.',
    `follow_up_review_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a follow-up review is required to verify implementation of corrective actions. True for reviews with significant findings requiring validation.',
    `follow_up_review_scheduled_date` DATE COMMENT 'Planned date for the follow-up review to verify corrective action implementation. Nullable if no follow-up is required.',
    `high_findings_count` STRING COMMENT 'Number of high-severity findings identified during the review. High findings represent material weaknesses requiring prompt remediation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance review record was last updated. Audit trail for record changes.',
    `low_findings_count` STRING COMMENT 'Number of low-severity findings identified during the review. Low findings represent minor control gaps or opportunities for improvement.',
    `management_response_received_date` DATE COMMENT 'Date when management formally responded to the review findings and submitted their corrective action plan.',
    `medium_findings_count` STRING COMMENT 'Number of medium-severity findings identified during the review. Medium findings represent control weaknesses that should be addressed in a reasonable timeframe.',
    `overall_compliance_rating` STRING COMMENT 'Summary assessment of the overall compliance posture based on the review findings. Provides an executive-level view of compliance health (satisfactory, needs improvement, unsatisfactory, high risk).. Valid values are `satisfactory|needs_improvement|unsatisfactory|high_risk`',
    `population_size` STRING COMMENT 'Total number of transactions, cases, or records in the population from which the sample was drawn. Provides context for sample representativeness.',
    `report_document_url` STRING COMMENT 'File path or URL to the stored compliance review report document. Provides access to the full detailed report.',
    `report_issued_date` DATE COMMENT 'Date when the final compliance review report was formally issued to management and stakeholders.',
    `review_end_date` DATE COMMENT 'Date when the compliance review fieldwork was completed and findings were finalized. Nullable for reviews still in progress.',
    `review_methodology` STRING COMMENT 'Primary audit methodology or approach used to conduct the compliance review (risk-based, transaction testing, control testing, analytical review, walkthrough, observation).. Valid values are `risk_based|transaction_testing|control_testing|analytical_review|walkthrough|observation`',
    `review_notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about the compliance review that do not fit structured fields. May include reviewer commentary or special circumstances.',
    `review_number` STRING COMMENT 'Externally-known business identifier for the compliance review, typically formatted as prefix-year-sequence (e.g., ICR-2024-00123).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$`',
    `review_period_end_date` DATE COMMENT 'End date of the operational period being reviewed. Defines the end of the time window under examination.',
    `review_period_start_date` DATE COMMENT 'Start date of the operational period being reviewed. Defines the beginning of the time window under examination (distinct from when the review itself started).',
    `review_scope_description` STRING COMMENT 'Detailed narrative describing the scope, objectives, and boundaries of the compliance review. Explains what was included and excluded from the review.',
    `review_start_date` DATE COMMENT 'Date when the compliance review fieldwork commenced. Represents the beginning of the review period for audit trail purposes.',
    `review_status` STRING COMMENT 'Current lifecycle state of the compliance review (planned, fieldwork in progress, draft report, management response pending, final report issued, closed with follow-up complete).. Valid values are `planned|fieldwork_in_progress|draft_report|management_response|final|closed`',
    `review_team_members` STRING COMMENT 'Comma-separated list of staff names or identifiers who participated in the review team. Captures the full review team composition.',
    `review_type` STRING COMMENT 'Classification of the internal compliance review activity. Defines the focus area and scope of the review (financial spot check, procurement review, programmatic compliance, data protection audit, conflict of interest certification review, grant compliance review).. Valid values are `financial_spot_check|procurement_review|programmatic_compliance|data_protection_audit|coi_certification_review|grant_compliance_review`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the reviewed entity based on findings severity and control environment. Typically on a scale of 0-100 where higher scores indicate greater risk.',
    `sample_size` STRING COMMENT 'Number of transactions, cases, or records sampled during the compliance review. Represents the statistical sample used for testing.',
    `total_findings_count` STRING COMMENT 'Total number of findings across all severity levels identified during the compliance review.',
    CONSTRAINT pk_internal_review PRIMARY KEY(`internal_review_id`)
) COMMENT 'Transactional record of internal compliance reviews, spot checks, and programmatic audits conducted by the compliance or internal audit function. Captures review type (financial spot check, procurement review, programmatic compliance, data protection audit, COI certification review), review scope, country office or program reviewed, review period, lead reviewer, findings count by severity, overall compliance rating, and follow-up actions required. Distinct from external Single Audits — these are internally initiated compliance assurance activities that verify ongoing adherence to policies, donor requirements, and corrective action plan closure.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` (
    `sanctions_screening_id` BIGINT COMMENT 'Unique identifier for the sanctions screening record. Primary key.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: When a sanctions screening identifies a non-false-positive match (match_result indicates hit, false_positive_flag = false), it triggers a compliance incident requiring investigation and resolution. Th',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Sanctions screening (OFAC, debarment lists) is often mandated by specific donor compliance requirements. The sanctions_screening table has donor_requirement_flag, donor_name, and grant_reference_numbe',
    `rescreening_sanctions_screening_id` BIGINT COMMENT 'Self-referencing FK on sanctions_screening (rescreening_sanctions_screening_id)',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Sanctions screening is performed through dedicated platforms (Dow Jones, World-Check, OFAC screening tools). Nonprofits must document which system performed each screening for audit trail, donor compl',
    `certification_statement` STRING COMMENT 'Text of the anti-terrorism certification or compliance statement that this screening supports.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening record was first created in the system.',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether a potential match was determined to be a false positive after investigation.',
    `legal_basis` STRING COMMENT 'Legal authority or executive order requiring the sanctions screening (e.g., US Executive Order 13224, UN Security Council Resolution 1267, EU Regulation 2580/2001).',
    `match_details` STRING COMMENT 'Detailed information about the match, including list entry details, matching criteria, and any aliases or alternate spellings that triggered the match.',
    `match_result` STRING COMMENT 'Outcome of the sanctions screening check indicating whether the subject was found on any sanctions list.. Valid values are `clear|potential_match|confirmed_match`',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0-100) indicating the likelihood of a true match when potential matches are identified. Higher scores indicate stronger matches.',
    `next_screening_due_date` DATE COMMENT 'Date when the next periodic rescreening is due for this subject.',
    `rescreening_frequency_days` STRING COMMENT 'Number of days between required rescreening checks for this subject (e.g., 90, 180, 365).',
    `rescreening_required_flag` BOOLEAN COMMENT 'Indicates whether periodic rescreening is required for this subject based on risk profile or donor requirements.',
    `resolution_action` STRING COMMENT 'Action taken to resolve a potential or confirmed match (e.g., cleared after review, engagement blocked, escalated to legal, OFAC license requested, alternative vendor sourced).',
    `resolution_date` DATE COMMENT 'Date when the screening result was resolved and a final determination was made.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation, evidence reviewed, and rationale for the resolution decision.',
    `reviewer_email` STRING COMMENT 'Email address of the reviewer who approved the resolution decision.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reviewer_name` STRING COMMENT 'Name of the senior compliance officer or legal counsel who reviewed and approved the resolution of a potential or confirmed match.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the subject based on screening results, geographic factors, and business context.. Valid values are `low|medium|high|critical`',
    `sanctions_list_checked` STRING COMMENT 'Name of the sanctions or debarment list(s) checked during this screening. Pipe-separated list for multiple lists (e.g., OFAC SDN|UN Security Council|EU Sanctions|World Bank Debarment).',
    `screener_email` STRING COMMENT 'Email address of the staff member who performed the screening, for audit trail and follow-up purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `screener_name` STRING COMMENT 'Name of the staff member or compliance officer who performed or initiated the screening.',
    `screening_date` DATE COMMENT 'Date when the sanctions screening check was performed.',
    `screening_method` STRING COMMENT 'Method used to perform the sanctions screening check.. Valid values are `automated|manual|hybrid`',
    `screening_status` STRING COMMENT 'Current status of the sanctions screening record in the compliance workflow.. Valid values are `pending|in_review|cleared|blocked|escalated`',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the sanctions screening check was initiated, including time zone information.',
    `screening_tool` STRING COMMENT 'Name of the software tool or service used to perform the screening (e.g., Dow Jones Risk & Compliance, LexisNexis Bridger, manual OFAC search).',
    `subject_address` STRING COMMENT 'Known address or location of the subject being screened, used for geographic risk assessment.',
    `subject_date_of_birth` DATE COMMENT 'Date of birth of the individual being screened, used for identity matching and disambiguation.',
    `subject_identifier` STRING COMMENT 'Unique identifier of the subject in the source system (e.g., vendor ID, staff ID, beneficiary registration number).',
    `subject_name` STRING COMMENT 'Full name of the individual or organization being screened. May include legal name, aliases, or transliterations.',
    `subject_nationality` STRING COMMENT 'Nationality or country of citizenship of the individual or country of registration for organizations. Pipe-separated list for multiple nationalities.',
    `subject_type` STRING COMMENT 'Type of entity being screened against sanctions lists.. Valid values are `vendor|partner|staff|beneficiary|donor|volunteer`',
    `supporting_documentation` STRING COMMENT 'References to supporting documents, evidence, or file paths for screening reports, investigation notes, and approval records.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanctions screening record was last modified.',
    CONSTRAINT pk_sanctions_screening PRIMARY KEY(`sanctions_screening_id`)
) COMMENT 'Master record of sanctions and debarment screening checks performed against OFAC (Office of Foreign Assets Control), UN Security Council, EU, and other sanctions lists for vendors, partners, staff, and beneficiaries. Captures screening date, subject name, list checked, match result (clear, potential match, confirmed match), resolution action, screener identity, and re-screening frequency. Critical for anti-terrorism certification compliance required by USAID, DFID, and EU donors, and for organizational due diligence under US Executive Orders and UN resolutions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` (
    `cognizant_agency_id` BIGINT COMMENT 'Primary key for cognizant_agency',
    `country_id` BIGINT COMMENT 'Connect field.cognizant_agency by adding column country_id (BIGINT) with FK to field.country.country_id because cognizant agencies operate in specific jurisdictions. P4: connect_table: field.cognizant_agency** - add column country',
    `parent_agency_id` BIGINT COMMENT 'Reference to the parent or umbrella agency if this cognizant agency is a sub-agency or division of a larger governmental body.',
    `parent_cognizant_agency_id` BIGINT COMMENT 'Self-referencing FK on cognizant_agency (parent_cognizant_agency_id)',
    `agency_address_line1` STRING COMMENT 'First line of the cognizant agencys official mailing address (street address, building number).',
    `agency_address_line2` STRING COMMENT 'Second line of the cognizant agencys official mailing address (suite, floor, department).',
    `agency_city` STRING COMMENT 'City where the cognizant agency is located.',
    `agency_code` STRING COMMENT 'Official alphanumeric code assigned to the cognizant agency by the federal government or oversight body. Used as the business identifier in grant documentation and audit reports.',
    `agency_country_code` STRING COMMENT 'Three-letter ISO country code for the cognizant agencys location.',
    `agency_name` STRING COMMENT 'Full legal name of the cognizant agency responsible for oversight and audit coordination.',
    `agency_postal_code` STRING COMMENT 'Postal or ZIP code for the cognizant agencys address.',
    `agency_short_name` STRING COMMENT 'Abbreviated or commonly used short name for the cognizant agency (e.g., USAID, HHS, DOD).',
    `agency_state_province` STRING COMMENT 'State, province, or administrative region where the cognizant agency is located.',
    `agency_type` STRING COMMENT 'Classification of the cognizant agency by governmental or organizational level.',
    `audit_frequency_months` STRING COMMENT 'Required frequency of audits coordinated by the cognizant agency, expressed in months (e.g., 12 for annual, 24 for biennial).',
    `compliance_framework` STRING COMMENT 'Primary regulatory or compliance framework that the cognizant agency enforces (e.g., OMB Uniform Guidance, FAR, DFARS).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cognizant agency record was first created in the system.',
    `designation_date` DATE COMMENT 'Date when the agency was officially designated as the cognizant agency for the organization.',
    `designation_end_date` DATE COMMENT 'Date when the cognizant agency designation ended or is scheduled to end. Null for ongoing designations.',
    `federal_award_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum dollar threshold of federal awards that triggers cognizant agency oversight responsibility, expressed in US dollars.',
    `indirect_cost_rate_approval_authority` BOOLEAN COMMENT 'Indicates whether the cognizant agency has authority to approve indirect cost rate proposals for organizations under its oversight.',
    `is_primary_cognizant_agency` BOOLEAN COMMENT 'Indicates whether this is the primary cognizant agency for the organization when multiple agencies have oversight roles.',
    `jurisdiction_scope` STRING COMMENT 'Description of the geographic or programmatic scope of the cognizant agencys oversight authority (e.g., nationwide, regional, sector-specific).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cognizant agency record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or contextual information about the cognizant agencys oversight requirements or relationship with the organization.',
    `oversight_status` STRING COMMENT 'Current operational status of the cognizant agencys oversight authority.',
    `primary_contact_email` STRING COMMENT 'Official email address of the primary contact at the cognizant agency for audit coordination and compliance inquiries.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the cognizant agency for audit and compliance matters.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the cognizant agency contact person.',
    `primary_contact_title` STRING COMMENT 'Job title or position of the primary contact person at the cognizant agency.',
    `reporting_portal_url` STRING COMMENT 'URL of the online portal where organizations submit compliance reports and audit documentation to the cognizant agency.',
    `single_audit_required` BOOLEAN COMMENT 'Indicates whether the cognizant agency requires Single Audit Act compliance for organizations under its oversight.',
    `website_url` STRING COMMENT 'Official website URL of the cognizant agency for accessing compliance guidance and resources.',
    CONSTRAINT pk_cognizant_agency PRIMARY KEY(`cognizant_agency_id`)
) COMMENT 'Master reference table for cognizant_agency. Referenced by cognizant_agency_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_cognizant_agency_id` FOREIGN KEY (`cognizant_agency_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`cognizant_agency`(`cognizant_agency_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ADD CONSTRAINT `fk_compliance_chs_self_assessment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ADD CONSTRAINT `fk_compliance_iati_publication_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ADD CONSTRAINT `fk_compliance_iati_publication_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ADD CONSTRAINT `fk_compliance_iati_publication_superseded_by_publication_iati_publication_id` FOREIGN KEY (`superseded_by_publication_iati_publication_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`iati_publication`(`iati_publication_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_superseded_by_policy_governance_policy_id` FOREIGN KEY (`superseded_by_policy_governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ADD CONSTRAINT `fk_compliance_nicra_agreement_cognizant_agency_id` FOREIGN KEY (`cognizant_agency_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`cognizant_agency`(`cognizant_agency_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ADD CONSTRAINT `fk_compliance_nicra_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ADD CONSTRAINT `fk_compliance_nicra_agreement_primary_predecessor_agreement_nicra_agreement_id` FOREIGN KEY (`primary_predecessor_agreement_nicra_agreement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`nicra_agreement`(`nicra_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ADD CONSTRAINT `fk_compliance_nicra_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_rescreening_sanctions_screening_id` FOREIGN KEY (`rescreening_sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ADD CONSTRAINT `fk_compliance_cognizant_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`cognizant_agency`(`cognizant_agency_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ADD CONSTRAINT `fk_compliance_cognizant_agency_parent_cognizant_agency_id` FOREIGN KEY (`parent_cognizant_agency_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`cognizant_agency`(`cognizant_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`compliance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`compliance` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` SET TAGS ('pii_column_comment_framework' = '2 CFR 200 + Form 990 + IPSAS');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Filing System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `statutory_registration_id` SET TAGS ('pii_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_flag` SET TAGS ('pii_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authorized_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extended_due_date` SET TAGS ('pii_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extension_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `extension_requested_flag` SET TAGS ('pii_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_payment_date` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Payment Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_notes` SET TAGS ('pii_business_glossary_term' = 'Filing Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_organization` SET TAGS ('pii_business_glossary_term' = 'Preparer Organization');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_ptin` SET TAGS ('pii_business_glossary_term' = 'Preparer Tax Identification Number (PTIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_ptin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `public_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `resubmission_count` SET TAGS ('pii_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_title` SET TAGS ('pii_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_channel` SET TAGS ('pii_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_channel` SET TAGS ('pii_value_regex' = 'electronic|paper|online_portal|third_party_service|mail|in_person');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Required System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `chs_self_assessment_required` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Self-Assessment Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('pii_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `documentation_required` SET TAGS ('pii_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_business_glossary_term' = 'Donor or Funder Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_person_type' = 'person_name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_masking_policy' = 'mask_non_prod');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `donor_funder_name` SET TAGS ('pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Escalation Threshold (Days)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `fiscal_year_applicable` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year Applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Obligation Frequency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `governing_body` SET TAGS ('pii_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `grant_agreement_reference` SET TAGS ('pii_business_glossary_term' = 'Grant Agreement Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `iati_publication_required` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Publication Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `last_completed_date` SET TAGS ('pii_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `legal_basis` SET TAGS ('pii_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `next_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_value_regex' = 'active|pending|completed|overdue|waived|suspended');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_value_regex' = 'regulatory|donor|voluntary|contractual|statutory');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `penalty_description` SET TAGS ('pii_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('pii_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_person` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_unit` SET TAGS ('pii_business_glossary_term' = 'Responsible Unit');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `single_audit_required` SET TAGS ('pii_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'online_portal|email|postal_mail|in_person|api|ftp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ALTER COLUMN `submission_url` SET TAGS ('pii_business_glossary_term' = 'Submission Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `obligation_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Schedule Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Execution System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Compliance Officer Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `tertiary_obligation_assigned_officer_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Obligation Assigned Officer Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `tertiary_obligation_assigned_officer_staff_member_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `tertiary_obligation_assigned_officer_staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `actual_effort_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `completion_status` SET TAGS ('pii_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `completion_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|overdue|waived|deferred');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `effective_due_date` SET TAGS ('pii_business_glossary_term' = 'Effective Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `escalation_triggered_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Triggered Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `estimated_effort_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extended_due_date` SET TAGS ('pii_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_reason` SET TAGS ('pii_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `extension_requested_flag` SET TAGS ('pii_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `non_compliance_risk` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Risk');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `non_compliance_risk` SET TAGS ('pii_value_regex' = 'severe|high|moderate|low|minimal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `penalty_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `planned_due_date` SET TAGS ('pii_business_glossary_term' = 'Planned Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_value_regex' = 'one_time|annual|quarterly|monthly|biennial|event_driven');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `reviewer_notes` SET TAGS ('pii_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `supporting_document_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `waiver_reason` SET TAGS ('pii_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ALTER COLUMN `workflow_stage` SET TAGS ('pii_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` SET TAGS ('pii_column_comment_framework' = '2 CFR 200 Subpart F + ISA + IPSAS');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `single_audit_id` SET TAGS ('pii_business_glossary_term' = 'Single Audit Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `cognizant_agency_id` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Source System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_finding_count` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_report_date` SET TAGS ('pii_business_glossary_term' = 'Audit Report Issuance Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Single Audit Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `audit_year` SET TAGS ('pii_business_glossary_term' = 'Audit Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_business_glossary_term' = 'Auditor Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Auditor Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('pii_business_glossary_term' = 'Auditor Employer Identification Number (EIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('pii_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_ein` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Firm Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `compliance_opinion_type` SET TAGS ('pii_business_glossary_term' = 'Federal Compliance Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `compliance_opinion_type` SET TAGS ('pii_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `corrective_action_plan_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `corrective_action_plan_submitted_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Submitted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `engagement_letter_date` SET TAGS ('pii_business_glossary_term' = 'Engagement Letter Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `federal_expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Total Federal Expenditure Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `fieldwork_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Fieldwork End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `fieldwork_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Fieldwork Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `financial_statement_opinion_type` SET TAGS ('pii_business_glossary_term' = 'Financial Statement Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `financial_statement_opinion_type` SET TAGS ('pii_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `going_concern_issue_flag` SET TAGS ('pii_business_glossary_term' = 'Going Concern Issue Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `internal_control_opinion_type` SET TAGS ('pii_business_glossary_term' = 'Internal Control Opinion Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `internal_control_opinion_type` SET TAGS ('pii_value_regex' = 'unmodified|qualified|adverse|disclaimer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `low_risk_auditee_flag` SET TAGS ('pii_business_glossary_term' = 'Low-Risk Auditee Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `major_program_count` SET TAGS ('pii_business_glossary_term' = 'Major Program Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `material_weakness_identified_flag` SET TAGS ('pii_business_glossary_term' = 'Material Weakness Identified Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `questioned_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Total Questioned Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `sefa_reference_number` SET TAGS ('pii_business_glossary_term' = 'Schedule of Expenditures of Federal Awards (SEFA) Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `significant_deficiency_identified_flag` SET TAGS ('pii_business_glossary_term' = 'Significant Deficiency Identified Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Federal Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `single_audit_id` SET TAGS ('pii_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `vulnerability_id` SET TAGS ('pii_business_glossary_term' = 'Related Vulnerability Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cause_description` SET TAGS ('pii_business_glossary_term' = 'Cause Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('pii_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `cfda_number` SET TAGS ('pii_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_requirement_type` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `condition_description` SET TAGS ('pii_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `criteria_description` SET TAGS ('pii_business_glossary_term' = 'Criteria Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `effect_description` SET TAGS ('pii_business_glossary_term' = 'Effect Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `expected_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `fac_submission_date` SET TAGS ('pii_business_glossary_term' = 'Federal Audit Clearinghouse (FAC) Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_business_glossary_term' = 'Federal Agency Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_agency_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `federal_award_identification_number` SET TAGS ('pii_business_glossary_term' = 'Federal Award Identification Number (FAIN)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_identified_date` SET TAGS ('pii_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('pii_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_value_regex' = 'open|in_remediation|resolved|closed|repeat_finding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('pii_business_glossary_term' = 'Finding Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'material_weakness|significant_deficiency|questioned_cost|noncompliance|other_matter');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_fraud_indicator` SET TAGS ('pii_business_glossary_term' = 'Is Fraud Indicator Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_material_weakness` SET TAGS ('pii_business_glossary_term' = 'Is Material Weakness Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('pii_business_glossary_term' = 'Is Repeat Finding Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `is_significant_deficiency` SET TAGS ('pii_business_glossary_term' = 'Is Significant Deficiency Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('pii_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Finding Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `prior_finding_reference_number` SET TAGS ('pii_business_glossary_term' = 'Prior Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Questioned Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `questioned_cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Questioned Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `recommendation_description` SET TAGS ('pii_business_glossary_term' = 'Recommendation Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_federal_audit_clearinghouse` SET TAGS ('pii_business_glossary_term' = 'Reported to Federal Audit Clearinghouse (FAC) Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Modified By ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `change_request_id` SET TAGS ('pii_business_glossary_term' = 'Implementing Change Request Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `internal_review_id` SET TAGS ('pii_business_glossary_term' = 'Internal Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `primary_corrective_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `primary_corrective_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `primary_corrective_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `tertiary_corrective_responsible_manager_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Corrective Responsible Manager Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `tertiary_corrective_responsible_manager_staff_member_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `tertiary_corrective_responsible_manager_staff_member_id` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Finding ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_report_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `donor_notification_required` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_required` SET TAGS ('pii_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `estimated_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_reference_number` SET TAGS ('pii_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_severity` SET TAGS ('pii_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'audit_finding|chs_non_conformity|donor_compliance_issue|internal_control_deficiency|regulatory_violation|fraud_allegation');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `management_response` SET TAGS ('pii_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `preventive_measures` SET TAGS ('pii_business_glossary_term' = 'Preventive Measures');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_risk` SET TAGS ('pii_business_glossary_term' = 'Recurrence Risk');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_risk` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_reporting_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `sphere_standard_reference` SET TAGS ('pii_business_glossary_term' = 'Sphere Standard Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Self-Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Assessment System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Reference Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_value_regex' = '^CHS-[A-Z]{3}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('pii_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('pii_value_regex' = 'internal_self_assessment|peer_review|independent_verification|hybrid');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('pii_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|under_review|completed|verified|archived');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('pii_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `certification_target_flag` SET TAGS ('pii_business_glossary_term' = 'Certification Target Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_1_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 1 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_1_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 1 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_1_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 1 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_1_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 1 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_2_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 2 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_2_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 2 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_2_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 2 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_2_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 2 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_3_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 3 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_3_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 3 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_3_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 3 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_3_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 3 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_4_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 4 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_4_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 4 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_4_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 4 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_4_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 4 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_5_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 5 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_5_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 5 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_5_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 5 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_5_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 5 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_6_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 6 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_6_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 6 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_6_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 6 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_6_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 6 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_7_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 7 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_7_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 7 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_7_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 7 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_7_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 7 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_8_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 8 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_8_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 8 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_8_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 8 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_8_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 8 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_9_assessor_notes` SET TAGS ('pii_business_glossary_term' = 'Commitment 9 Assessor Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_9_evidence` SET TAGS ('pii_business_glossary_term' = 'Commitment 9 Evidence Summary');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_9_improvement_actions` SET TAGS ('pii_business_glossary_term' = 'Commitment 9 Improvement Actions');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `commitment_9_rating` SET TAGS ('pii_business_glossary_term' = 'Commitment 9 Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_email` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor Email Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `overall_conformity_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Conformity Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `overall_conformity_rating` SET TAGS ('pii_value_regex' = 'non_conforming|partially_conforming|largely_conforming|fully_conforming|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `overall_conformity_score` SET TAGS ('pii_business_glossary_term' = 'Overall Conformity Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `verification_body` SET TAGS ('pii_business_glossary_term' = 'Verification Body Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` SET TAGS ('pii_column_comment_framework' = 'IATI v2.03 + Grand Bargain');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `iati_publication_id` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Publication Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Publishing System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `superseded_by_publication_iati_publication_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Publication Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `activity_count` SET TAGS ('pii_business_glossary_term' = 'Activity Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `completeness_percentage` SET TAGS ('pii_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `donor_requirement_compliance` SET TAGS ('pii_business_glossary_term' = 'Donor Requirement Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `donor_requirement_compliance` SET TAGS ('pii_value_regex' = 'compliant|partial|non_compliant|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `iati_organization_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `iati_organization_identifier` SET TAGS ('pii_value_regex' = '^[A-Z]{2}-[A-Z]+-[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `iati_version` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Standard Version');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `iati_version` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]{2}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Publication Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publication_status` SET TAGS ('pii_business_glossary_term' = 'Publication Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publication_status` SET TAGS ('pii_value_regex' = 'published|draft|withdrawn|superseded');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publication_type` SET TAGS ('pii_business_glossary_term' = 'Publication Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publication_type` SET TAGS ('pii_value_regex' = 'organization|activity');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publisher_contact_email` SET TAGS ('pii_business_glossary_term' = 'Publisher Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publisher_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publisher_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publisher_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `publisher_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `recipient_country_count` SET TAGS ('pii_business_glossary_term' = 'Recipient Country Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `registry_dataset_code` SET TAGS ('pii_business_glossary_term' = 'Registry Dataset Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `reporting_currency` SET TAGS ('pii_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `reporting_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `sector_count` SET TAGS ('pii_business_glossary_term' = 'Sector Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `timeliness_category` SET TAGS ('pii_business_glossary_term' = 'Timeliness Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `timeliness_category` SET TAGS ('pii_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `timeliness_score` SET TAGS ('pii_business_glossary_term' = 'Timeliness Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `total_budget_value` SET TAGS ('pii_business_glossary_term' = 'Total Budget Value');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `total_disbursement_value` SET TAGS ('pii_business_glossary_term' = 'Total Disbursement Value');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `validation_error_count` SET TAGS ('pii_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ALTER COLUMN `validation_warning_count` SET TAGS ('pii_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Governance Policy Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Document System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `psea_policy_id` SET TAGS ('pii_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `superseded_by_policy_governance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Policy Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `annual_certification_status` SET TAGS ('pii_business_glossary_term' = 'Annual Certification Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `annual_certification_status` SET TAGS ('pii_value_regex' = 'certified|pending|overdue|not_required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_category` SET TAGS ('pii_value_regex' = 'financial|hr|safeguarding|anti_fraud|data_protection|coi');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_description` SET TAGS ('pii_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `disclosing_party` SET TAGS ('pii_business_glossary_term' = 'Disclosing Party');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `disclosing_party` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `document_owner` SET TAGS ('pii_business_glossary_term' = 'Document Owner');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `document_type` SET TAGS ('pii_value_regex' = 'policy|resolution|bylaw|charter|coi_disclosure|framework');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `governance_policy_status` SET TAGS ('pii_value_regex' = 'draft|active|under_review|superseded|archived');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `irs_990_disclosure_required` SET TAGS ('pii_business_glossary_term' = 'Internal Revenue Service (IRS) Form 990 Disclosure Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `meeting_date` SET TAGS ('pii_business_glossary_term' = 'Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `meeting_type` SET TAGS ('pii_business_glossary_term' = 'Meeting Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `meeting_type` SET TAGS ('pii_value_regex' = 'regular|special|annual|emergency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `nature_of_conflict` SET TAGS ('pii_business_glossary_term' = 'Nature of Conflict');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `nature_of_conflict` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `public_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `recusal_decision` SET TAGS ('pii_business_glossary_term' = 'Recusal Decision');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `recusal_decision` SET TAGS ('pii_value_regex' = 'recused|not_recused|partial_recusal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `related_party` SET TAGS ('pii_business_glossary_term' = 'Related Party');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `related_party` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `resolution_number` SET TAGS ('pii_business_glossary_term' = 'Resolution Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `resolution_text` SET TAGS ('pii_business_glossary_term' = 'Resolution Text');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `review_outcome` SET TAGS ('pii_business_glossary_term' = 'Review Outcome');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `review_outcome` SET TAGS ('pii_value_regex' = 'approved|mitigated|prohibited|under_review');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Policy Scope');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `vote_outcome` SET TAGS ('pii_business_glossary_term' = 'Vote Outcome');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `vote_outcome` SET TAGS ('pii_value_regex' = 'passed|failed|tabled|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `votes_abstained` SET TAGS ('pii_business_glossary_term' = 'Votes Abstained');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `votes_against` SET TAGS ('pii_business_glossary_term' = 'Votes Against');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ALTER COLUMN `votes_for` SET TAGS ('pii_business_glossary_term' = 'Votes For');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Requirement Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `actual_effort_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `associated_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Associated Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `deliverable_format` SET TAGS ('pii_business_glossary_term' = 'Deliverable Format');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `estimated_effort_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('pii_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_consequence` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Risk Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `related_regulation_reference` SET TAGS ('pii_business_glossary_term' = 'Related Regulation Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_description` SET TAGS ('pii_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_reference_number` SET TAGS ('pii_business_glossary_term' = 'Requirement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `requirement_title` SET TAGS ('pii_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'email|online_portal|postal_mail|in_person|ftp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `supporting_document_url` SET TAGS ('pii_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ALTER COLUMN `waiver_requested_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Requested Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_subdomain' = 'incident_screening');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_ssot_scope' = 'compliance_regulatory_incident');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_ssot_owner' = 'compliance');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_ssot_boundary' = 'regulatory_incident');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` SET TAGS ('pii_disambiguated_from' = 'safeguarding.safeguarding_incident');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Affected Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Affected Grant ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Affected Program ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `it_incident_id` SET TAGS ('pii_business_glossary_term' = 'Related It Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `allegation_category` SET TAGS ('pii_business_glossary_term' = 'Allegation Category');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `donor_notification_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('pii_business_glossary_term' = 'Estimated Financial Impact (USD)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_status` SET TAGS ('pii_value_regex' = 'reported|under_review|investigation_open|investigation_closed|resolved|dismissed');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_value_regex' = 'fraud|financial_mismanagement|procurement_irregularity|data_protection_violation|ethical_breach|safeguarding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('pii_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_finding` SET TAGS ('pii_business_glossary_term' = 'Investigation Finding');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_finding` SET TAGS ('pii_value_regex' = 'substantiated|partially_substantiated|unsubstantiated|inconclusive');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_finding` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_notes` SET TAGS ('pii_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `public_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `regulatory_report_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `related_incident_ids` SET TAGS ('pii_business_glossary_term' = 'Related Incident IDs');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reporter_anonymity_flag` SET TAGS ('pii_business_glossary_term' = 'Reporter Anonymity Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('pii_business_glossary_term' = 'Reporter Contact Information');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reporter_contact_info` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `reporting_channel` SET TAGS ('pii_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `triage_outcome` SET TAGS ('pii_business_glossary_term' = 'Triage Outcome');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `triage_outcome` SET TAGS ('pii_value_regex' = 'escalate_to_investigation|refer_to_management|refer_to_hr|refer_to_legal|no_action_required|duplicate');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `nicra_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_id` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `primary_predecessor_agreement_nicra_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Predecessor NICRA Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'NICRA Agreement Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `applicable_programs` SET TAGS ('pii_business_glossary_term' = 'Applicable Programs');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `audit_findings_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_email` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency Contact Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cognizant_agency_contact_phone` SET TAGS ('pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'NICRA Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cost_base_type` SET TAGS ('pii_business_glossary_term' = 'Cost Base Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cost_base_type` SET TAGS ('pii_value_regex' = 'MTDC|TDC|salaries_and_wages|direct_salaries');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `cost_pool_definition` SET TAGS ('pii_business_glossary_term' = 'Facilities and Administration (F&A) Cost Pool Definition');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `de_minimis_rate_elected` SET TAGS ('pii_business_glossary_term' = 'De Minimis Rate Elected Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `exclusions_and_limitations` SET TAGS ('pii_business_glossary_term' = 'NICRA Exclusions and Limitations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `fiscal_year_basis` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year Basis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `fringe_benefit_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `indirect_cost_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `negotiation_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Negotiation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `nicra_agreement_status` SET TAGS ('pii_business_glossary_term' = 'NICRA Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `nicra_agreement_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|active|expired|superseded|terminated');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `organizational_unit_applicability` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Applicability');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `rate_adjustment_provision` SET TAGS ('pii_business_glossary_term' = 'Rate Adjustment Provision');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`nicra_agreement` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` SET TAGS ('pii_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `statutory_registration_id` SET TAGS ('pii_business_glossary_term' = 'Statutory Registration Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Registration System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review|remediation_required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `deductibility_code` SET TAGS ('pii_business_glossary_term' = 'Deductibility Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `determination_letter_date` SET TAGS ('pii_business_glossary_term' = 'Determination Letter Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `donor_eligibility_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Eligibility Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `foreign_operations_permitted_flag` SET TAGS ('pii_business_glossary_term' = 'Foreign Operations Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `foundation_status` SET TAGS ('pii_business_glossary_term' = 'Foundation Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `foundation_status` SET TAGS ('pii_value_regex' = 'public_charity|private_operating_foundation|private_non_operating_foundation|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `jurisdiction_code` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `jurisdiction_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `last_filing_date` SET TAGS ('pii_business_glossary_term' = 'Last Filing Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `next_filing_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Filing Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `next_renewal_date` SET TAGS ('pii_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `operating_authority_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Operating Authority Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `public_charity_classification` SET TAGS ('pii_business_glossary_term' = 'Public Charity Classification');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `public_charity_classification` SET TAGS ('pii_value_regex' = '509a1|509a2|509a3|private_foundation|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('pii_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('pii_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_address_line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_city` SET TAGS ('pii_business_glossary_term' = 'Registered City');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_country_code` SET TAGS ('pii_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_legal_name` SET TAGS ('pii_business_glossary_term' = 'Registered Legal Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_legal_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_legal_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_postal_code` SET TAGS ('pii_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_state_province` SET TAGS ('pii_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registered_state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_document_url` SET TAGS ('pii_business_glossary_term' = 'Registration Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_number` SET TAGS ('pii_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_status` SET TAGS ('pii_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|revoked|expired|lapsed');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_type` SET TAGS ('pii_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `registration_type` SET TAGS ('pii_value_regex' = '501c3|charity_commission|ngo_registration|foreign_agent|cso_registration|ingo_registration');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `regulatory_authority_name` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `regulatory_authority_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `regulatory_authority_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `renewal_frequency` SET TAGS ('pii_business_glossary_term' = 'Renewal Frequency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `renewal_frequency` SET TAGS ('pii_value_regex' = 'annual|biennial|triennial|quinquennial|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `reporting_requirement_description` SET TAGS ('pii_business_glossary_term' = 'Reporting Requirement Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `tax_exempt_status` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ALTER COLUMN `tax_exempt_status` SET TAGS ('pii_value_regex' = 'exempt|non_exempt|conditional|pending');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `internal_review_id` SET TAGS ('pii_business_glossary_term' = 'Internal Review Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Reviewed System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `security_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Related Security Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Reviewer ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `compliance_framework_reference` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework Reference');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `donor_notification_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `external_auditor_coordination_flag` SET TAGS ('pii_business_glossary_term' = 'External Auditor Coordination Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `follow_up_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Review Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `follow_up_review_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Review Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `high_findings_count` SET TAGS ('pii_business_glossary_term' = 'High Findings Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `low_findings_count` SET TAGS ('pii_business_glossary_term' = 'Low Findings Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `management_response_received_date` SET TAGS ('pii_business_glossary_term' = 'Management Response Received Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `medium_findings_count` SET TAGS ('pii_business_glossary_term' = 'Medium Findings Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `overall_compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `overall_compliance_rating` SET TAGS ('pii_value_regex' = 'satisfactory|needs_improvement|unsatisfactory|high_risk');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `population_size` SET TAGS ('pii_business_glossary_term' = 'Population Size');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `report_document_url` SET TAGS ('pii_business_glossary_term' = 'Report Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `report_document_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `report_issued_date` SET TAGS ('pii_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_end_date` SET TAGS ('pii_business_glossary_term' = 'Review End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_methodology` SET TAGS ('pii_business_glossary_term' = 'Review Methodology');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_methodology` SET TAGS ('pii_value_regex' = 'risk_based|transaction_testing|control_testing|analytical_review|walkthrough|observation');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Review Reference Number');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_number` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_scope_description` SET TAGS ('pii_business_glossary_term' = 'Review Scope Description');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'planned|fieldwork_in_progress|draft_report|management_response|final|closed');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_team_members` SET TAGS ('pii_business_glossary_term' = 'Review Team Members');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'financial_spot_check|procurement_review|programmatic_compliance|data_protection_audit|coi_certification_review|grant_compliance_review');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ALTER COLUMN `total_findings_count` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` SET TAGS ('pii_subdomain' = 'incident_screening');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening ID');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Rescreening Sanctions Screening Id');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_sanctions_screening_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Screening System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `certification_statement` SET TAGS ('pii_business_glossary_term' = 'Certification Statement');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `false_positive_flag` SET TAGS ('pii_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `legal_basis` SET TAGS ('pii_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_details` SET TAGS ('pii_business_glossary_term' = 'Match Details');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('pii_business_glossary_term' = 'Match Result');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('pii_value_regex' = 'clear|potential_match|confirmed_match');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `match_score` SET TAGS ('pii_business_glossary_term' = 'Match Score');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `next_screening_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Screening Due Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Rescreening Frequency Days');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `rescreening_required_flag` SET TAGS ('pii_business_glossary_term' = 'Rescreening Required Flag');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('pii_business_glossary_term' = 'Reviewer Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_list_checked` SET TAGS ('pii_business_glossary_term' = 'Sanctions List Checked');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('pii_business_glossary_term' = 'Screener Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('pii_business_glossary_term' = 'Screener Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screener_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_date` SET TAGS ('pii_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_business_glossary_term' = 'Screening Method');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_status` SET TAGS ('pii_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_status` SET TAGS ('pii_value_regex' = 'pending|in_review|cleared|blocked|escalated');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('pii_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_tool` SET TAGS ('pii_business_glossary_term' = 'Screening Tool');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('pii_business_glossary_term' = 'Subject Address');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Subject Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_business_glossary_term' = 'Subject Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('pii_business_glossary_term' = 'Subject Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('pii_business_glossary_term' = 'Subject Nationality');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_nationality` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_type` SET TAGS ('pii_business_glossary_term' = 'Subject Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `subject_type` SET TAGS ('pii_value_regex' = 'vendor|partner|staff|beneficiary|donor|volunteer');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `supporting_documentation` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` SET TAGS ('pii_subdomain' = 'audit_oversight');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `cognizant_agency_id` SET TAGS ('pii_business_glossary_term' = 'Cognizant Agency Identifier');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `parent_agency_id` SET TAGS ('pii_business_glossary_term' = 'Parent Agency Id');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `parent_cognizant_agency_id` SET TAGS ('pii_business_glossary_term' = 'Parent Cognizant Agency Id');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `parent_cognizant_agency_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line1` SET TAGS ('pii_business_glossary_term' = 'Agency Address Line1');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line2` SET TAGS ('pii_business_glossary_term' = 'Agency Address Line2');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_address_line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_city` SET TAGS ('pii_business_glossary_term' = 'Agency City');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_code` SET TAGS ('pii_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_country_code` SET TAGS ('pii_business_glossary_term' = 'Agency Country Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_name` SET TAGS ('pii_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_postal_code` SET TAGS ('pii_business_glossary_term' = 'Agency Postal Code');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_short_name` SET TAGS ('pii_business_glossary_term' = 'Agency Short Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_short_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_state_province` SET TAGS ('pii_business_glossary_term' = 'Agency State Province');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `agency_type` SET TAGS ('pii_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `audit_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `designation_date` SET TAGS ('pii_business_glossary_term' = 'Designation Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `designation_end_date` SET TAGS ('pii_business_glossary_term' = 'Designation End Date');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `federal_award_threshold_usd` SET TAGS ('pii_business_glossary_term' = 'Federal Award Threshold Usd');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `indirect_cost_rate_approval_authority` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `is_primary_cognizant_agency` SET TAGS ('pii_business_glossary_term' = 'Is Primary Cognizant Agency');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `jurisdiction_scope` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `oversight_status` SET TAGS ('pii_business_glossary_term' = 'Oversight Status');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `reporting_portal_url` SET TAGS ('pii_business_glossary_term' = 'Reporting Portal Url');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `single_audit_required` SET TAGS ('pii_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website Url');
