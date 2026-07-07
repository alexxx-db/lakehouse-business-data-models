-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`compliance` COMMENT 'Regulatory compliance, risk management, health and safety, data privacy (GDPR/CCPA), ADA accessibility, fire safety, liquor licensing, food safety certifications, and audit management across all properties and jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key for the compliance obligation entity.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Internal compliance policies create specific obligations that employees and properties must fulfill (training requirements, acknowledgment deadlines, operational procedures). One policy generates mult',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this compliance obligation record.',
    `property_id` BIGINT COMMENT 'Identifier of the property or organizational unit to which this compliance obligation applies.',
    `regulatory_requirement_id` BIGINT COMMENT 'Identifier of the specific regulatory requirement that creates this obligation.',
    `superseded_obligation_id` BIGINT COMMENT 'Self-referencing FK on obligation (superseded_obligation_id)',
    `tertiary_obligation_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this compliance obligation record.',
    `applicable_department` STRING COMMENT 'Name or code of the department within the property that is primarily responsible for this compliance obligation (e.g., Food and Beverage, Housekeeping, Front Desk, Engineering, Security).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit logs, inspection reports, or compliance documentation stored in external systems.',
    `certification_expiry_date` DATE COMMENT 'Date on which the certification or license expires and must be renewed to maintain compliance.',
    `certification_issue_date` DATE COMMENT 'Date on which the certification or license was issued by the regulatory authority.',
    `certification_number` STRING COMMENT 'Official certification, license, or permit number issued by the regulatory authority to satisfy this obligation.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether this obligation requires formal certification, licensing, or documented proof of compliance. True indicates certification is required; False indicates no formal certification needed.',
    `obligation_code` STRING COMMENT 'Business-assigned unique code for this compliance obligation, used for reporting and tracking purposes.. Valid values are `^[A-Z0-9]{3,20}$`',
    `compliance_status` STRING COMMENT 'Current assessment of whether the property is meeting this obligation. Compliant indicates full compliance; non_compliant indicates violation or gap; partial indicates some requirements met; under_review indicates assessment in progress; not_assessed indicates no evaluation has been performed.. Valid values are `compliant|non_compliant|partial|under_review|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation, including specific requirements, scope, and applicability conditions.',
    `due_date` DATE COMMENT 'Target date by which compliance actions or certifications must be completed to satisfy this obligation.',
    `effective_date` DATE COMMENT 'Date on which this compliance obligation becomes effective and binding for the property.',
    `expiration_date` DATE COMMENT 'Date on which this compliance obligation expires or is no longer applicable. Null indicates an ongoing obligation with no defined end date.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, government agency, or certification authority that issued the certification or enforces this obligation.',
    `jurisdiction_code` STRING COMMENT 'ISO country code or extended jurisdiction code (country-state-locality) identifying the regulatory jurisdiction under which this obligation falls (e.g., USA-CA-SF for San Francisco, California, USA).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$`',
    `jurisdiction_notes` STRING COMMENT 'Free-text notes capturing jurisdiction-specific nuances, local interpretations, or special conditions applicable to this obligation in this jurisdiction.',
    `last_compliance_assessment_date` DATE COMMENT 'Date on which the compliance status was last formally assessed or updated.',
    `last_review_date` DATE COMMENT 'Date on which this compliance obligation was last reviewed or audited for compliance status.',
    `obligation_name` STRING COMMENT 'Short descriptive name of the compliance obligation for business user identification.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or audit of this obligation.',
    `non_compliance_notes` STRING COMMENT 'Free-text notes documenting any non-compliance issues, corrective actions taken, or remediation plans in progress.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation. Active indicates the obligation is in force; pending indicates awaiting activation; waived indicates exemption granted; expired indicates obligation period has ended; suspended indicates temporarily inactive; terminated indicates permanently closed.. Valid values are `active|pending|waived|expired|suspended|terminated`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed or potentially assessable for non-compliance with this obligation, in the propertys local currency.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled compliance reviews for this obligation. Used to calculate next review date automatically.',
    `risk_level` STRING COMMENT 'Business-assessed risk severity level associated with non-compliance of this obligation. Critical indicates severe legal or operational impact; high indicates significant impact; medium indicates moderate impact; low indicates minor impact.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last modified.',
    `waiver_expiry_date` DATE COMMENT 'Date on which the granted waiver expires and the obligation becomes enforceable again. Null indicates permanent waiver.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a formal waiver or exemption has been granted for this obligation. True indicates waiver granted; False indicates no waiver.',
    `waiver_reason` STRING COMMENT 'Business justification or regulatory basis for the granted waiver or exemption.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Property-level compliance obligation record linking a specific regulatory requirement to a specific property or organizational unit. Captures obligation status (active, pending, waived, expired), assigned compliance owner, due date, last review date, next review date, risk level (critical, high, medium, low), applicable department, and any jurisdiction-specific notes. This is the operational SSOT for tracking which properties are bound by which regulatory requirements and their current compliance posture.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique identifier for the permit record. Primary key for the permit entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Permit fees (permit_fee_amount, renewal_fee_amount) are paid via AP invoices. Hotels reconcile permit payments to invoices for audit trails, cost center allocation, and regulatory documentation. Stand',
    `property_id` BIGINT COMMENT 'Reference to the property that holds this permit. Links to the property master record.',
    `renewed_permit_id` BIGINT COMMENT 'Self-referencing FK on permit (renewed_permit_id)',
    `application_date` DATE COMMENT 'Date on which the permit application was submitted to the issuing authority. Used to track processing timelines and compliance with application deadlines.',
    `approval_date` DATE COMMENT 'Date on which the permit application was approved by the issuing authority. May precede the issue date if there are administrative processing steps.',
    `compliance_officer_email` STRING COMMENT 'Email address of the compliance officer responsible for this permit. Used for renewal notifications and compliance alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `compliance_officer_name` STRING COMMENT 'Name of the internal compliance officer or manager responsible for maintaining this permit and ensuring ongoing compliance with permit conditions.',
    `compliance_officer_phone` STRING COMMENT 'Phone number of the compliance officer responsible for this permit. Primary contact for regulatory inquiries and inspection coordination.',
    `conditions` STRING COMMENT 'Text description of any special conditions, restrictions, or requirements attached to the permit by the issuing authority. May include operational limitations, reporting requirements, or compliance obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this permit record. Typically USD for US properties but may vary for international locations.. Valid values are `^[A-Z]{3}$`',
    `document_reference_number` STRING COMMENT 'Reference number or identifier for the physical or digital permit document stored in the document management system. Used to retrieve the official permit certificate.',
    `effective_date` DATE COMMENT 'Date from which the permit becomes legally effective and authorizes the permitted activity. May differ from issue date if there is a waiting period or conditional approval.',
    `expiration_date` DATE COMMENT 'Date on which the permit expires and must be renewed to continue authorized operations. Critical for compliance tracking and renewal planning.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee charged by the issuing authority for the permit issuance or renewal. Includes base permit fee and any applicable surcharges.',
    `holder_name` STRING COMMENT 'Legal name of the entity or individual to whom the permit is issued. Must match the legal business name registered with the issuing authority.',
    `holder_type` STRING COMMENT 'Legal classification of the permit holder entity. Determines liability structure and regulatory reporting requirements.. Valid values are `corporation|llc|partnership|individual|government_entity`',
    `inspection_frequency` STRING COMMENT 'Required frequency of regulatory inspections as mandated by the issuing authority. Determines inspection scheduling and compliance monitoring cadence.. Valid values are `annual|semi_annual|quarterly|monthly|as_needed`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires periodic inspections by the issuing authority to maintain active status. True for permits with ongoing compliance verification requirements.',
    `issue_date` DATE COMMENT 'Date on which the permit was officially issued by the regulatory authority. Marks the beginning of the permits validity period.',
    `issuing_authority` STRING COMMENT 'Name of the government agency, regulatory body, or jurisdiction that issued the permit. Examples include state liquor control boards, county health departments, city fire marshals, or federal agencies.',
    `jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction under which the permit is governed. May be city, county, state, or federal level depending on the permit type.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection conducted by the regulatory authority for this permit. Used to track inspection frequency and compliance history.',
    `last_renewal_date` DATE COMMENT 'Date on which the permit was most recently renewed. Used to track renewal history and compliance with periodic renewal requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was most recently modified. Used for audit trail and change tracking.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next regulatory inspection. Critical for operational planning and ensuring inspection readiness.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the permit. May include renewal reminders, special handling instructions, or historical context.',
    `permit_number` STRING COMMENT 'The official permit or license number issued by the regulatory authority. This is the externally-known identifier used in all regulatory correspondence and inspections.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Active permits authorize operations; expired or suspended permits require immediate remediation to avoid operational shutdowns or fines.. Valid values are `active|expired|suspended|pending_renewal|revoked|pending_approval`',
    `permit_type` STRING COMMENT 'Classification of the permit based on the regulatory domain it covers. Determines which regulatory body governs this permit and what operational activities it authorizes. [ENUM-REF-CANDIDATE: liquor_license|food_service_permit|fire_safety_certificate|building_occupancy_permit|health_department_permit|pool_spa_license|gaming_license|business_operating_license — 8 candidates stripped; promote to reference product]',
    `reinstatement_date` DATE COMMENT 'Date on which a suspended permit was reinstated and operations were authorized to resume. Indicates successful remediation of suspension causes.',
    `renewal_date` DATE COMMENT 'Date by which the permit renewal application must be submitted to the issuing authority to avoid lapse in authorization. Typically precedes expiration date by 30-90 days.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount required for permit renewal. May differ from initial permit fee based on regulatory fee schedules.',
    `revocation_date` DATE COMMENT 'Date on which the permit was permanently revoked by the issuing authority. Revocation typically requires a new application process to regain authorization.',
    `revocation_reason` STRING COMMENT 'Explanation of why the permit was revoked. Includes serious violations, repeated non-compliance, or failure to meet statutory requirements.',
    `suspension_date` DATE COMMENT 'Date on which the permit was suspended by the issuing authority. Marks the beginning of the suspension period during which authorized operations must cease.',
    `suspension_reason` STRING COMMENT 'Explanation of why the permit was suspended, if applicable. Includes regulatory violations, non-payment of fees, or failure to meet permit conditions.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this permit record. Used for audit trail and accountability.',
    `violation_count` STRING COMMENT 'Total number of violations or citations issued against this permit since its last issuance or renewal. Used to track compliance history and risk exposure.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Master record for all operating permits, licenses, and regulatory authorizations held by Travel Hospitality properties. Covers liquor licenses, food service permits, fire safety certificates, building occupancy permits, health department permits, pool/spa operating licenses, gaming licenses, and business operating licenses. Captures permit number, permit type, issuing authority, jurisdiction, property reference, issue date, expiration date, renewal date, permit status (active, expired, suspended, pending renewal), permit holder name, and associated fee amounts. Single source of truth for all property-level permits and licenses.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` (
    `permit_renewal_id` BIGINT COMMENT 'Unique identifier for the permit renewal transaction record. Primary key for the permit renewal entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Renewal fees (renewal_fee_amount) are paid via AP invoices. Finance teams track which invoice paid which renewal for reconciliation, accrual management, and audit compliance. Essential for permit life',
    `permit_id` BIGINT COMMENT 'Reference to the underlying permit or license being renewed. Links this renewal transaction to the master permit record.',
    `prior_permit_renewal_id` BIGINT COMMENT 'Self-referencing FK on permit_renewal (prior_permit_renewal_id)',
    `property_id` BIGINT COMMENT 'Reference to the property or facility for which the permit renewal applies. Links renewal to specific hotel, resort, or operational location.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and coordinating this permit renewal process. Typically a compliance officer, property manager, or legal staff member.',
    `appeal_filed_date` DATE COMMENT 'Date when an appeal was formally filed with the appropriate authority. Null if no appeal has been filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed in response to a renewal rejection or adverse conditions. True if appeal is active, False otherwise.',
    `auto_renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this permit is eligible for automatic renewal without full re-application. True if auto-renewal is available, False if full application is required.',
    `compliance_notes` STRING COMMENT 'Free-text field for internal compliance team notes, observations, and action items related to this renewal. May include lessons learned, process improvements, or coordination details.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit renewal record was first created in the system. Audit field for data lineage and compliance tracking.',
    `inspection_completed_date` DATE COMMENT 'Date when the required inspection was completed by the issuing authority. Null if no inspection is required or if inspection has not yet occurred.',
    `inspection_outcome` STRING COMMENT 'Result of the regulatory inspection conducted as part of the renewal process. Determines whether renewal can proceed or if corrective actions are required.. Valid values are `passed|failed|conditional|pending|not_applicable`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a physical inspection by the issuing authority is required as part of the renewal process. True if inspection is mandatory, False otherwise.',
    `issuing_authority_name` STRING COMMENT 'Name of the governmental or regulatory body responsible for issuing and renewing the permit. Examples include local health departments, fire marshals, liquor control boards, or building departments.',
    `issuing_authority_reference_number` STRING COMMENT 'External reference number or case identifier assigned by the issuing authority to track this renewal application in their systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit renewal record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `priority_level` STRING COMMENT 'Business priority assigned to this renewal based on operational impact, regulatory risk, and permit criticality. Critical permits may include health licenses or occupancy certificates required for operations.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Explanation provided by the issuing authority for rejecting the renewal application. Null if renewal was not rejected.',
    `renewal_approval_date` DATE COMMENT 'Date when the renewal was officially approved by the issuing authority. Null if renewal is not yet approved or was rejected.',
    `renewal_conditions` STRING COMMENT 'Any special conditions, restrictions, or requirements attached to the renewed permit by the issuing authority. May include operational limitations, reporting obligations, or corrective action deadlines.',
    `renewal_cycle_months` STRING COMMENT 'Duration in months of the renewed permit period. Enables calculation of next renewal due date and proactive renewal planning.',
    `renewal_effective_date` DATE COMMENT 'Start date of the renewed permit period. Represents when the renewed permit becomes legally binding and operational.',
    `renewal_expiration_date` DATE COMMENT 'End date of the renewed permit period. Represents when the renewed permit will expire and require subsequent renewal.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Total fee charged by the issuing authority for processing and approving the permit renewal. Expressed in the propertys local operating currency.',
    `renewal_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the renewal fee amount. Enables multi-currency tracking across global property portfolio.. Valid values are `^[A-Z]{3}$`',
    `renewal_fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the renewal fee has been paid to the issuing authority. True if paid, False if outstanding.',
    `renewal_fee_payment_date` DATE COMMENT 'Date when the renewal fee was paid to the issuing authority. Null if fee has not yet been paid.',
    `renewal_number` STRING COMMENT 'Externally-visible business identifier for this renewal transaction. May be used in correspondence with regulatory authorities and internal tracking systems.',
    `renewal_request_date` DATE COMMENT 'Date when the renewal process was initiated internally. Represents the business event timestamp when the organization began preparing the renewal application.',
    `renewal_status` STRING COMMENT 'Current lifecycle status of the permit renewal transaction. Tracks progression from initiation through final disposition. [ENUM-REF-CANDIDATE: initiated|submitted|under_review|approved|rejected|lapsed|withdrawn|pending_payment — 8 candidates stripped; promote to reference product]',
    `renewal_submission_date` DATE COMMENT 'Date when the renewal application was formally submitted to the issuing authority or regulatory body.',
    `supporting_documents_checklist_status` STRING COMMENT 'Status of the supporting documentation required for the renewal application. Tracks whether all required certificates, inspections, and supporting materials have been gathered and verified.. Valid values are `not_started|in_progress|complete|incomplete|verified`',
    CONSTRAINT pk_permit_renewal PRIMARY KEY(`permit_renewal_id`)
) COMMENT 'Transactional record tracking the lifecycle of permit and license renewal events for Travel Hospitality properties. Captures renewal request date, renewal submission date, renewal status (initiated, submitted, under review, approved, rejected, lapsed), renewal fee paid, renewal period start and end dates, issuing authority reference number, assigned renewal coordinator, supporting documents checklist status, and any conditions attached to the renewed permit. Enables proactive renewal management and prevents permit lapses.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key.',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (follow_up_audit_id)',
    `property_id` BIGINT COMMENT 'Identifier of the property where the audit was conducted.',
    `actual_end_date` DATE COMMENT 'The date on which the audit fieldwork was completed and exit conference conducted.',
    `actual_start_date` DATE COMMENT 'The date on which the audit fieldwork actually commenced. May differ from scheduled date due to operational constraints or rescheduling.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Scheduled indicates the audit is planned but not yet started, in-progress indicates fieldwork is underway, completed indicates the audit has finished and report is finalized, cancelled indicates the audit was terminated before completion, failed indicates the property did not meet minimum compliance standards, and passed with conditions indicates the property met standards but has minor findings requiring corrective action.. Valid values are `scheduled|in_progress|completed|cancelled|failed|passed_with_conditions`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its purpose and conducting authority. Internal audits are conducted by company staff, brand standard audits verify adherence to brand requirements, regulatory audits are mandated by government agencies (health department, fire marshal, liquor control board), third-party audits are conducted by external certification bodies (Forbes Travel Guide, AAA), ADA accessibility audits verify compliance with Americans with Disabilities Act, and fire safety audits assess fire code compliance.. Valid values are `internal|brand_standard|regulatory|third_party|ada_accessibility|fire_safety`',
    `auditor_certification_number` STRING COMMENT 'Professional certification or license number of the auditor, if applicable. Required for certain regulatory audits (e.g., health inspector license, fire marshal certification).',
    `auditor_contact_email` STRING COMMENT 'Email address of the lead auditor for follow-up questions and corrective action verification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `auditor_contact_phone` STRING COMMENT 'Phone number of the lead auditor for urgent communications regarding audit findings or corrective actions.',
    `auditor_name` STRING COMMENT 'Full name of the lead auditor or inspector who conducted the audit.',
    `auditor_organization` STRING COMMENT 'Name of the organization or agency that the auditor represents. May be internal department name, regulatory agency (e.g., County Health Department, State Fire Marshal), or third-party certification body (e.g., Forbes Travel Guide, AAA, ISO certification body).',
    `certification_awarded` BOOLEAN COMMENT 'Indicates whether a formal certification, accreditation, or rating was awarded as a result of this audit. True for third-party certification audits (Forbes Travel Guide star rating, AAA Diamond rating, ISO certification) where the audit resulted in certification issuance or renewal.',
    `certification_expiry_date` DATE COMMENT 'Date on which the awarded certification expires and requires renewal. Used for tracking certification lifecycle and scheduling re-audits.',
    `certification_level` STRING COMMENT 'The level or grade of certification awarded, if applicable. Examples include Forbes Travel Guide star ratings (4-star, 5-star), AAA Diamond ratings (3-Diamond, 4-Diamond, 5-Diamond), or ISO certification levels. Null if no certification was awarded or audit type does not involve certification.',
    `compliance_period_end` DATE COMMENT 'End date of the compliance period being audited. Used for periodic compliance audits that assess adherence over a defined time window.',
    `compliance_period_start` DATE COMMENT 'Start date of the compliance period being audited. Used for periodic compliance audits that assess adherence over a defined time window.',
    `corrective_action_deadline` DATE COMMENT 'Date by which all corrective actions must be completed and verified. Set by auditor or regulatory body based on finding severity. Null if no corrective action is required.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the audit identified findings that require formal corrective action plans. True when property must submit remediation plans and evidence of correction.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the audit, including auditor fees, travel expenses, and administrative costs. Used for budgeting and cost analysis of compliance programs. Null for internal audits where costs are not separately tracked.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Used for audit trail and data lineage.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-compliance findings identified during the audit. Critical findings represent immediate health, safety, or legal risks requiring urgent remediation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount. Required when audit_cost is populated.. Valid values are `^[A-Z]{3}$`',
    `executive_summary` STRING COMMENT 'High-level summary of audit findings, conclusions, and recommendations for executive reporting. Provides context for overall result and key takeaways.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled date for the follow-up audit or re-inspection. Null if no follow-up is required.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit or re-inspection is required to verify corrective actions have been implemented. True for audits with critical findings or regulatory enforcement actions.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction under which the audit was conducted. Identifies the country, state, province, county, or municipality whose regulations apply. Critical for multi-jurisdictional compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated. Used for tracking changes and data currency.',
    `major_findings_count` STRING COMMENT 'Number of major non-compliance findings identified during the audit. Major findings represent significant deviations from standards that require corrective action but do not pose immediate risk.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-compliance findings or observations identified during the audit. Minor findings represent opportunities for improvement that do not constitute non-compliance.',
    `notes` STRING COMMENT 'Additional notes, observations, or context regarding the audit that do not fit into structured fields. May include special circumstances, property responses, or auditor commentary.',
    `overall_audit_result` STRING COMMENT 'Final outcome determination of the audit. Pass indicates full compliance with all standards, fail indicates critical non-compliance requiring immediate remediation, conditional pass indicates compliance achieved with minor corrective actions required, pending review indicates the audit report is under final review before result determination, and not applicable is used when the audit was cancelled or scope changed.. Valid values are `pass|fail|conditional_pass|pending_review|not_applicable`',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to the audit, typically on a scale of 0-100 or as defined by the auditing body. Used for brand standard audits and third-party certifications. Null for pass/fail regulatory audits that do not use scoring.',
    `property_contact_email` STRING COMMENT 'Email address of the property contact for audit-related communications and corrective action tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `property_contact_name` STRING COMMENT 'Name of the property representative who served as primary contact during the audit. Typically the General Manager, Director of Operations, or Compliance Manager.',
    `reference_number` STRING COMMENT 'External reference number assigned to the audit for tracking and reporting purposes. Unique business identifier.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework, standard, or code against which the audit was conducted. Examples include USALI financial reporting standards, PCI DSS payment security standards, GDPR or CCPA data privacy regulations, ISO 22000 food safety standards, OSHA workplace safety regulations, ADA accessibility standards, or local fire and building codes.',
    `report_reference` STRING COMMENT 'Reference identifier or document management system location of the formal audit report. May be a document ID, file path, or URL to the report repository.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned based on audit findings. Critical indicates immediate threat to guest safety, legal compliance, or brand reputation requiring executive escalation. High indicates significant risk requiring urgent management attention. Medium indicates moderate risk requiring corrective action within normal timeframes. Low indicates minimal risk with opportunities for improvement.. Valid values are `low|medium|high|critical`',
    `scheduled_date` DATE COMMENT 'The date on which the audit was originally scheduled to be conducted. Used for planning and resource allocation.',
    `scope` STRING COMMENT 'Detailed description of the areas, departments, processes, or compliance domains covered by the audit. May include specific operational areas such as front desk operations, housekeeping standards, food and beverage safety, fire safety systems, accessibility features, or financial controls.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for formal compliance audits and inspections conducted at Travel Hospitality properties. Covers internal audits, brand standard audits, regulatory inspections (health department, fire marshal, liquor control board), third-party audits (Forbes Travel Guide, AAA), and ADA accessibility audits. Captures audit reference number, audit type, audit scope, property audited, auditor name and organization, scheduled date, actual date, audit status (scheduled, in-progress, completed, failed, passed with conditions), overall audit result, and audit report reference. Central registry for all compliance audit activity.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key for the audit finding entity.',
    `audit_id` BIGINT COMMENT 'Reference to the parent compliance audit or regulatory inspection during which this finding was identified.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Audit findings often relate to specific compliance obligations that were not met (e.g., failure to complete required training, missed permit renewal deadline, incomplete regulatory filing). One findin',
    `org_unit_id` BIGINT COMMENT 'Reference to the department responsible for addressing this finding (e.g., Housekeeping, Food and Beverage, Front Desk, Engineering).',
    `parent_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on audit_finding (related_audit_finding_id)',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Audit findings often relate to specific permit violations (e.g., liquor license violations, health permit deficiencies, fire safety certificate non-compliance). One finding relates to one permit. This',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Audit findings often cite specific policy violations (e.g., failure to follow Code of Conduct, non-compliance with Data Privacy Policy, violation of Safety Procedures). One finding relates to one poli',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where this finding was identified.',
    `certification_impact` STRING COMMENT 'Assessment of the findings impact on property certifications, accreditations, or licenses (e.g., ISO 22000, LEED, AAA Diamond Rating, liquor license). Indicates whether the finding jeopardizes certification status.. Valid values are `none|warning|suspension_risk|revocation_risk`',
    `closure_date` DATE COMMENT 'Date on which the finding was formally closed in the audit management system after successful verification of corrective action.',
    `compliance_domain` STRING COMMENT 'High-level compliance domain or regulatory area to which this finding pertains, enabling categorization and trend analysis across compliance frameworks. [ENUM-REF-CANDIDATE: health_safety|data_privacy|accessibility|fire_safety|food_safety|liquor_licensing|financial_controls|environmental|labor_employment|other — 10 candidates stripped; promote to reference product]',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan, remediation steps, and controls implemented to address the finding and prevent recurrence.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective action must be completed and verified. Typically set based on finding severity: critical (immediate to 7 days), major (30 days), minor (60-90 days).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether formal corrective action is mandated for this finding. True for critical, major, and most minor findings; False for observations that are advisory only.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was first created in the audit management system, supporting audit trail and data lineage requirements.',
    `escalation_date` DATE COMMENT 'Date on which the finding was escalated to higher management levels, if applicable.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding has been escalated to senior management, corporate compliance, or executive leadership due to severity, repeat occurrence, or remediation delays.',
    `evidence_location` STRING COMMENT 'File path, document reference, or storage location of supporting evidence, photographs, documentation, or records related to the finding and its remediation.',
    `external_auditor_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding was identified by an external third-party auditor, regulatory inspector, or certification body (as opposed to internal audit).',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of the finding in USD, including potential fines, penalties, remediation costs, or revenue at risk if not addressed.',
    `finding_category` STRING COMMENT 'Severity classification of the finding based on risk impact and regulatory significance. Critical findings require immediate action; major findings pose significant risk; minor findings are low-impact deficiencies; observations are improvement opportunities.. Valid values are `critical|major|minor|observation`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the deficiency, non-compliance, or gap identified during the audit, including specific observations and evidence.',
    `finding_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this finding for tracking and reporting purposes. Typically follows format: AUDIT_TYPE-YEAR-SEQUENCE.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}-[0-9]{2,4}$`',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open: newly identified; In Remediation: corrective action underway; Closed: remediation completed and verified; Disputed: finding contested by property; Deferred: remediation postponed with approval.. Valid values are `open|in_remediation|closed|disputed|deferred`',
    `finding_title` STRING COMMENT 'Brief descriptive title summarizing the nature of the finding for quick identification and reporting.',
    `guest_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding has direct impact on guest safety, experience, or satisfaction, requiring elevated priority and communication protocols.',
    `identified_date` DATE COMMENT 'Date on which the finding was first identified during the audit or inspection, representing the business event timestamp for the finding discovery.',
    `inspector_name` STRING COMMENT 'Name of the auditor, inspector, or compliance officer who identified and documented this finding.',
    `inspector_notes` STRING COMMENT 'Additional observations, context, recommendations, or clarifications provided by the inspector regarding the finding, remediation approach, or risk implications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this finding record, supporting change tracking and audit trail requirements.',
    `previous_finding_reference` STRING COMMENT 'Reference number of the prior finding if this is a repeat occurrence, enabling linkage and trend analysis of recurring issues.',
    `regulatory_report_date` DATE COMMENT 'Date on which the finding was formally reported to the relevant regulatory authority or governing body, if applicable.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding must be formally reported to external regulatory authorities, governing bodies, or certification agencies.',
    `regulatory_standard_violated` STRING COMMENT 'Specific regulatory standard, code section, policy requirement, or compliance framework provision that was violated or not met (e.g., OSHA 1910.22, ADA Title III, GDPR Article 32, Local Fire Code Section 5.3).',
    `repeat_finding_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding is a recurrence of a previously identified and supposedly remediated deficiency, signaling potential systemic control weakness.',
    `responsible_person_email` STRING COMMENT 'Email address of the individual assigned accountability for corrective action, used for notifications and follow-up communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the individual (typically department head or property manager) assigned accountability for ensuring corrective action completion.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the finding based on likelihood and impact assessment, typically on a scale of 0-100, used for prioritization and resource allocation.',
    `root_cause_classification` STRING COMMENT 'Categorization of the underlying root cause that led to the finding, enabling systemic analysis and preventive action planning. [ENUM-REF-CANDIDATE: process_gap|training_deficiency|system_failure|resource_constraint|policy_violation|external_factor|design_flaw|other — 8 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'Date on which the corrective action was verified as complete and effective by the auditor or compliance officer, enabling closure of the finding.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or deficiency record identified during a compliance audit or regulatory inspection. Captures finding reference number, finding category (critical, major, minor, observation), finding description, regulatory standard violated, department responsible, corrective action required flag, corrective action due date, finding status (open, in-remediation, closed, disputed), root cause classification, repeat finding flag, and inspector notes. Enables systematic tracking of compliance gaps from identification through remediation closure.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Corrective actions often require vendor payments (repairs, equipment, consulting). Linking actual_cost to AP invoice enables cost tracking, budget variance analysis, and audit trail for compliance-dri',
    `audit_finding_id` BIGINT COMMENT 'Reference to the compliance audit finding or regulatory violation that triggered this corrective action.',
    `follow_up_corrective_action_id` BIGINT COMMENT 'Self-referencing FK on corrective_action (follow_up_corrective_action_id)',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to loyalty.fraud_alert. Business justification: When loyalty fraud alerts trigger corrective actions (account freezes, points reversals, investigation escalations), the CAPA record must reference the originating fraud alert for audit trail and effe',
    `health_safety_incident_id` BIGINT COMMENT 'Reference to the risk incident or safety event that triggered this corrective action, if applicable.',
    `note_id` BIGINT COMMENT 'Foreign key linking to guest.guest_note. Business justification: CAPAs for service failures may require updating guest profiles with service recovery notes, VIP alerts, or handling instructions. Links corrective action to resulting guest profile updates for audit t',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for implementing and completing the corrective action.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Privacy incidents require corrective actions (CAPA) to remediate data breaches and prevent recurrence. One privacy incident can generate multiple corrective actions addressing different aspects of the',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort where the corrective action is being implemented.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Corrective actions stem from reservation-related incidents like overbooking compensation, rate discrepancy corrections, booking policy breaches, and commission disputes. Operations teams need to link ',
    `whistleblower_report_id` BIGINT COMMENT 'Foreign key linking to compliance.whistleblower_report. Business justification: Whistleblower reports alleging ethics violations or compliance breaches require corrective actions to address the identified issues. One report can generate multiple corrective actions (disciplinary, ',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and ready for verification.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action.',
    `assigned_department` STRING COMMENT 'Department or functional area responsible for implementing the corrective action (e.g., Housekeeping, Food and Beverage, Front Desk, Engineering).',
    `capa_reference_number` STRING COMMENT 'Externally-known unique reference number for this CAPA record, used in regulatory correspondence and audit documentation. Format: CAPA-YYYY-NNNNNN.. Valid values are `^CAPA-[0-9]{4}-[0-9]{6}$`',
    `capa_type` STRING COMMENT 'Classification of the action as corrective (addresses existing issue), preventive (prevents future occurrence), or both.. Valid values are `corrective|preventive|both`',
    `compliance_category` STRING COMMENT 'High-level category of compliance domain that this corrective action addresses. [ENUM-REF-CANDIDATE: data-privacy|health-safety|accessibility|fire-safety|food-safety|financial|environmental — 7 candidates stripped; promote to reference product]',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action. Open indicates newly created, in-progress indicates work underway, pending-verification indicates awaiting validation, closed indicates completed and verified, overdue indicates past target date, cancelled indicates action no longer required.. Valid values are `open|in-progress|pending-verification|closed|overdue|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this corrective action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action taken to address the immediate compliance issue or violation.',
    `effectiveness_rating` STRING COMMENT 'Assessment of how effective the corrective action was in resolving the issue and preventing recurrence.. Valid values are `highly-effective|effective|partially-effective|ineffective|not-yet-assessed`',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess long-term effectiveness of the corrective action.',
    `escalation_date` DATE COMMENT 'Date when the corrective action was escalated to higher authority due to severity or non-completion.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this corrective action requires escalation to senior management or regulatory authorities.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action, including labor, materials, and external services.',
    `evidence_of_completion` STRING COMMENT 'Description or reference to documentation, photos, certificates, or other evidence demonstrating completion of the corrective action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this corrective action record was last updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the corrective action implementation and progress.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the preventive measures implemented to prevent recurrence of the issue.',
    `priority` STRING COMMENT 'Business priority level for completing this corrective action based on risk severity and regulatory impact.. Valid values are `critical|high|medium|low`',
    `recurrence_detected` BOOLEAN COMMENT 'Indicates whether the same or similar issue recurred after the corrective action was implemented, suggesting ineffective remediation.',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework or compliance standard that this corrective action addresses (e.g., GDPR, CCPA, ADA, OSHA, PCI DSS, local fire code). [ENUM-REF-CANDIDATE: GDPR|CCPA|ADA|OSHA|PCI-DSS|ISO-22000|local-fire-code|local-health-code|liquor-licensing|SOX — promote to reference product]',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory authorities were notified of the corrective action completion.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether regulatory authorities must be notified of this corrective action and its completion.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause that led to the compliance finding or incident, used to inform preventive actions.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action must be completed to meet regulatory or audit requirements.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effectively implemented and resolved the issue.. Valid values are `document-review|on-site-inspection|testing|audit|observation|interview`',
    `verification_notes` STRING COMMENT 'Notes and observations from the verification process documenting the effectiveness of the corrective action.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record tracking remediation activities required to address compliance audit findings, regulatory violations, or risk incidents. Captures CAPA reference number, linked finding or incident, corrective action description, preventive action description, assigned owner, target completion date, actual completion date, CAPA status (open, in-progress, pending verification, closed, overdue), verification method, verifier name, and evidence of completion. Supports regulatory follow-up and demonstrates compliance remediation to auditors.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` (
    `health_safety_incident_id` BIGINT COMMENT 'Unique identifier for the health and safety incident record. Primary key.',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Health/safety incidents during group events (weddings, conferences, MICE) require group block context for liability assessment, insurance claims, contract review, and group leader notification. Critic',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Guest incidents involving loyalty members require member linkage for benefit entitlements (compensation points, tier protection during medical absences, service recovery). Already has profile_id FK; t',
    `parent_health_safety_incident_id` BIGINT COMMENT 'Self-referencing FK on health_safety_incident (related_health_safety_incident_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the employee involved in the incident, if applicable. Nullable for non-employee incidents.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest involved in the incident, if applicable. Nullable for non-guest incidents.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the incident occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Health and safety incidents involving guests should link to their reservation for complete incident context, service recovery coordination, and liability tracking. This FK enables cross-referencing be',
    `tertiary_health_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last updated this incident record.',
    `corrective_actions_taken` STRING COMMENT 'Description of corrective and preventive actions implemented to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the employee was away from work as a result of the incident. Applicable for employee incidents only.',
    `immediate_actions_taken` STRING COMMENT 'Description of the immediate response and actions taken following the incident (e.g., first aid administered, emergency services called, area secured).',
    `incident_date` DATE COMMENT 'The calendar date on which the health and safety incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the health and safety incident, including circumstances, contributing factors, and sequence of events.',
    `incident_report_number` STRING COMMENT 'Externally-known unique report number assigned to the incident for tracking and reference purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident investigation and resolution process.. Valid values are `reported|under_investigation|closed|pending_review`',
    `incident_time` TIMESTAMP COMMENT 'The precise date and time when the health and safety incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the health and safety incident. [ENUM-REF-CANDIDATE: slip_and_fall|food_illness|pool_accident|fire|chemical_exposure|assault|medical_emergency|equipment_injury|electrical_shock|burn|laceration|other — promote to reference product]. Valid values are `slip_and_fall|food_illness|pool_accident|fire|chemical_exposure|assault`',
    `injury_severity` STRING COMMENT 'Classification of the severity of injury or harm resulting from the incident.. Valid values are `none|minor|serious|critical|fatality`',
    `insurance_claim_number` STRING COMMENT 'Reference number for the insurance claim filed in connection with this incident, if applicable.',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the person or team assigned to investigate the incident.',
    `investigation_completed_date` DATE COMMENT 'Date on which the incident investigation was completed.',
    `involved_party_name` STRING COMMENT 'Full name of the person involved in the incident. Used when the party is not a registered guest or employee (e.g., contractor, visitor).',
    `liability_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a liability claim or lawsuit was filed by the injured party against the property or company.',
    `location_within_property` STRING COMMENT 'Specific location or area within the property where the incident occurred (e.g., lobby, pool deck, guest room 305, kitchen, parking lot).',
    `medical_facility_name` STRING COMMENT 'Name of the medical facility or hospital where treatment was provided, if applicable.',
    `medical_treatment_provided_flag` BOOLEAN COMMENT 'Indicates whether medical treatment was provided to the injured party beyond first aid.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordable work-related injuries and illnesses.',
    `person_type_involved` STRING COMMENT 'Classification of the type of person(s) involved in the incident.. Valid values are `guest|employee|contractor|vendor|visitor|other`',
    `regulatory_authority_notified` STRING COMMENT 'Name of the regulatory authority or agency that was notified (e.g., OSHA, local health department, fire department).',
    `regulatory_notification_date` DATE COMMENT 'Date on which regulatory authorities were notified of the incident, if applicable.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident requires notification to regulatory authorities (OSHA, local health department, fire marshal, etc.).',
    `reported_by_name` STRING COMMENT 'Name of the person who initially reported the incident.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first reported to management or the safety team.',
    `restricted_work_days` STRING COMMENT 'Number of calendar days the employee was on restricted work duty as a result of the incident. Applicable for employee incidents only.',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis findings identifying underlying factors that contributed to the incident.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was last modified.',
    `witness_information` STRING COMMENT 'Information about witnesses to the incident, including names and contact details. May contain multiple witnesses in structured or semi-structured format.',
    `workers_compensation_claim_flag` BOOLEAN COMMENT 'Indicates whether a workers compensation claim was filed as a result of this incident.',
    CONSTRAINT pk_health_safety_incident PRIMARY KEY(`health_safety_incident_id`)
) COMMENT 'Operational record of health and safety incidents occurring at Travel Hospitality properties involving guests, employees, or third parties. Captures incident report number, incident type (slip and fall, food illness, pool accident, fire, chemical exposure, assault, medical emergency), incident date and time, location within property, persons involved (guest, employee, contractor), injury severity (none, minor, serious, fatality), OSHA recordable flag, workers compensation claim flag, incident description, immediate actions taken, witness information, and regulatory notification requirement. Distinct from workforce.workforce_safety_incident which covers employee-only OSHA records; this entity covers all parties including guests.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique identifier for the incident investigation record. Primary key.',
    `corrective_action_id` BIGINT COMMENT 'Reference to the formal corrective action plan created in response to the investigation findings. Links to the action plan tracking system.',
    `escalated_incident_investigation_id` BIGINT COMMENT 'Self-referencing FK on incident_investigation (escalated_incident_investigation_id)',
    `health_safety_incident_id` BIGINT COMMENT 'Reference to the underlying incident that triggered this investigation. Links to the incident record being investigated.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or external party serving as the primary investigator responsible for conducting the investigation and compiling findings.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Privacy incidents (data breaches, GDPR/CCPA violations) require formal investigation to determine root cause, scope of impact, and required remediation. One privacy incident has one formal investigati',
    `property_id` BIGINT COMMENT 'Reference to the property where the incident occurred and investigation is being conducted.',
    `tertiary_incident_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this investigation record in the system.',
    `whistleblower_report_id` BIGINT COMMENT 'Foreign key linking to compliance.whistleblower_report. Business justification: Whistleblower reports alleging misconduct, fraud, or compliance violations require formal investigation to validate allegations and determine appropriate action. One report has one investigation recor',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access to and disclosure of investigation findings. Restricted for investigations involving legal proceedings or sensitive personnel matters.. Valid values are `public|internal|confidential|restricted`',
    `contributing_factors` STRING COMMENT 'Narrative description of secondary or contributing factors that played a role in the incident but were not the primary root cause. May include environmental, procedural, or human factors.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was first created in the system.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the incident including direct costs (medical, property damage, legal) and indirect costs (lost productivity, reputation damage). Expressed in the propertys local currency.',
    `evidence_collected` STRING COMMENT 'Summary of physical, documentary, or testimonial evidence collected during the investigation (e.g., photographs, equipment samples, witness statements, video footage, maintenance records).',
    `external_investigator_firm` STRING COMMENT 'Name of the external consulting firm or independent investigator engaged to conduct or support the investigation, if applicable.',
    `insurance_carrier_name` STRING COMMENT 'Name of the insurance carrier handling the claim associated with this incident (e.g., workers compensation, general liability, property insurance).',
    `insurance_claim_reference` STRING COMMENT 'Reference number for any insurance claim filed in connection with this incident. Links the investigation to the insurance claim process.',
    `investigation_close_date` DATE COMMENT 'The date when the investigation was formally closed and all findings were finalized. Null if investigation is still open or in progress.',
    `investigation_methodology` STRING COMMENT 'The primary investigative methodology or framework used to conduct the investigation (e.g., root cause analysis, five whys, fishbone diagram, fault tree analysis, timeline reconstruction, witness interviews). [ENUM-REF-CANDIDATE: root_cause_analysis|five_whys|fishbone|fault_tree|timeline|witness_interview|other — 7 candidates stripped; promote to reference product]',
    `investigation_notes` STRING COMMENT 'Additional notes, observations, or context relevant to the investigation that do not fit into other structured fields.',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation determining resource allocation and timeline urgency.. Valid values are `routine|elevated|urgent|critical`',
    `investigation_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this investigation for tracking and regulatory reporting purposes.. Valid values are `^INV-[A-Z0-9]{8,12}$`',
    `investigation_report_document_reference` STRING COMMENT 'Reference to the formal investigation report document stored in the document management system. Contains the full investigation findings, evidence, and recommendations.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation was initiated and investigative activities began.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation: open (initiated but not started), in_progress (actively investigating), pending_review (awaiting management or regulatory review), closed (completed and finalized), suspended (temporarily halted).. Valid values are `open|in_progress|pending_review|closed|suspended`',
    `investigation_team_members` STRING COMMENT 'Comma-separated list of employee names or identifiers who are part of the investigation team supporting the lead investigator.',
    `investigation_type` STRING COMMENT 'Classification of the investigation based on the driving authority or purpose: internal (company-led), regulatory (mandated by OSHA or other agency), insurance (claim-related), legal (litigation-related), third_party (external consultant), or joint (multi-party).. Valid values are `internal|regulatory|insurance|legal|third_party|joint`',
    `legal_case_reference` STRING COMMENT 'Reference number for any legal case or litigation filed in connection with this incident. Links the investigation to legal proceedings.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether a legal hold has been placed on all evidence and documentation related to this investigation due to pending or anticipated litigation.',
    `notification_date` DATE COMMENT 'The date when the regulatory body was formally notified of the incident and investigation. Null if no notification was required or made.',
    `recommended_preventive_measures` STRING COMMENT 'Detailed recommendations for corrective and preventive actions to eliminate the root cause and prevent recurrence of similar incidents. May include policy changes, training, equipment upgrades, or procedural modifications.',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory agency or body that was notified (e.g., OSHA, state health department, fire marshal, ADA compliance office).',
    `regulatory_body_notified_flag` BOOLEAN COMMENT 'Indicates whether a regulatory body (e.g., OSHA, local health department, fire marshal) was notified of the incident and investigation.',
    `regulatory_case_number` STRING COMMENT 'The case or reference number assigned by the regulatory body for tracking their review or enforcement action related to this incident.',
    `regulatory_inspection_conducted_flag` BOOLEAN COMMENT 'Indicates whether the regulatory body conducted an on-site inspection as part of their review of the incident.',
    `regulatory_inspection_date` DATE COMMENT 'The date when the regulatory body conducted their on-site inspection. Null if no inspection occurred.',
    `root_cause_determination` STRING COMMENT 'Detailed narrative describing the identified root cause(s) of the incident based on investigation findings. This is the primary causal factor that, if eliminated, would have prevented the incident.',
    `severity_rating` STRING COMMENT 'Overall severity rating assigned to the investigation based on the incidents actual and potential impact on health, safety, compliance, and business operations.. Valid values are `low|moderate|high|critical`',
    `target_completion_date` DATE COMMENT 'The planned or mandated date by which the investigation must be completed, often driven by regulatory timelines or insurance claim deadlines.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was last modified in the system.',
    `witness_count` STRING COMMENT 'The number of witnesses interviewed as part of the investigation.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Formal investigation record for health, safety, and compliance incidents requiring root cause analysis and regulatory reporting. Captures investigation reference number, investigation type (internal, regulatory, insurance, legal), lead investigator, investigation start date, investigation close date, investigation status (open, in-progress, pending review, closed), root cause determination, contributing factors, regulatory body notified flag, notification date, regulatory case number, insurance claim reference, and recommended preventive measures. Supports OSHA reporting, insurance claims, and legal proceedings.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` (
    `privacy_incident_id` BIGINT COMMENT 'Unique identifier for the privacy incident record. Primary key.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: GDPR/CCPA breaches affecting loyalty member PII (account access logs, points transaction history, tier status) require direct member reference for breach notification obligations, remediation tracking',
    `communication_consent_id` BIGINT COMMENT 'Foreign key linking to guest.communication_consent. Business justification: Privacy incidents may stem from consent violations (unauthorized marketing, improper data sharing). Linking incident to specific consent record supports root cause analysis, regulatory investigation r',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to compliance.dpia. Business justification: Privacy incidents (data breaches) may trigger the requirement for a Data Protection Impact Assessment (DPIA) to evaluate the privacy risks of the affected processing activity and determine required sa',
    `identity_document_id` BIGINT COMMENT 'Foreign key linking to guest.identity_document. Business justification: Data breaches exposing identity documents (passports, IDs) require tracking which specific documents were compromised for breach notification, fraud monitoring, and regulatory reporting. Essential for',
    `parent_privacy_incident_id` BIGINT COMMENT 'Self-referencing FK on privacy_incident (related_privacy_incident_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or Data Protection Officer (DPO) responsible for managing and coordinating the incident response.',
    `privacy_request_id` BIGINT COMMENT 'Foreign key linking to guest.privacy_request. Business justification: Privacy incidents often trigger data subject access requests (DSARs) or erasure requests. Linking incident to originating request supports incident investigation, regulatory response coordination, and',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Privacy incidents (data breaches, unauthorized access) in hospitality must track affected guest profiles for GDPR/CCPA breach notification, regulatory reporting, and guest communication. Essential for',
    `property_id` BIGINT COMMENT 'Identifier of the property where the privacy incident occurred or was discovered.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Privacy breaches often involve specific guest reservations (unauthorized booking access, PII exposure, payment data leaks). GDPR/CCPA breach notification requires identifying affected bookings, notify',
    `tertiary_privacy_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last updated the privacy incident record.',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory breach notification to supervisory authorities is required under applicable data protection laws.',
    `confirmed_subjects_affected` STRING COMMENT 'Confirmed count of individual data subjects whose personal data was definitively affected by the incident after investigation.',
    `containment_actions_taken` STRING COMMENT 'Description of immediate containment and mitigation actions taken to stop the breach, secure systems, and prevent further unauthorized access or data loss.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy incident record was first created in the system.',
    `data_categories_affected` STRING COMMENT 'Comma-separated list of data categories involved in the incident such as PII (Personally Identifiable Information), payment card data, health data, biometric data, guest preferences, loyalty account information.',
    `discovery_date` DATE COMMENT 'Date when the privacy incident was first discovered or detected by the organization.',
    `discovery_method` STRING COMMENT 'Method or channel through which the privacy incident was discovered or brought to the organizations attention.. Valid values are `internal_audit|system_alert|employee_report|guest_complaint|third_party_notification|regulatory_inquiry`',
    `dpo_notification_date` TIMESTAMP COMMENT 'Timestamp when the Data Protection Officer was notified about the privacy incident.',
    `dpo_notified_flag` BOOLEAN COMMENT 'Indicates whether the organizations Data Protection Officer was notified about the incident.',
    `estimated_subjects_affected` STRING COMMENT 'Estimated number of individual data subjects (guests, employees, or other persons) whose personal data was affected by the incident.',
    `incident_date` DATE COMMENT 'Actual or estimated date when the privacy incident occurred or the breach event took place.',
    `incident_notes` STRING COMMENT 'Additional free-text notes, observations, or context about the privacy incident not captured in other structured fields.',
    `incident_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the privacy incident for tracking and regulatory reporting purposes. Format: PI-YYYY-NNNNNN.. Valid values are `^PI-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the privacy incident in the investigation and remediation workflow.. Valid values are `reported|under_investigation|contained|remediated|closed`',
    `incident_type` STRING COMMENT 'Classification of the privacy incident type indicating the nature of the data protection violation or breach event.. Valid values are `data_breach|unauthorized_access|data_loss|improper_disclosure|subject_rights_violation|system_compromise`',
    `investigation_completion_date` DATE COMMENT 'Date when the internal investigation into the privacy incident was completed.',
    `investigation_status` STRING COMMENT 'Current status of the internal investigation into the privacy incident.. Valid values are `not_started|in_progress|completed|on_hold`',
    `jurisdictions_impacted` STRING COMMENT 'Comma-separated list of jurisdictions or regulatory regions where affected data subjects reside, determining applicable data protection laws (e.g., USA, GBR, DEU, FRA, CAN).',
    `legal_counsel_engaged_flag` BOOLEAN COMMENT 'Indicates whether internal or external legal counsel was engaged to advise on the incident response and regulatory obligations.',
    `litigation_filed_flag` BOOLEAN COMMENT 'Indicates whether civil litigation or class action lawsuits were filed by affected data subjects as a result of the incident.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of regulatory penalty or fine imposed by the supervisory authority.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `regulatory_authority_notified` STRING COMMENT 'Name of the supervisory authority or data protection authority that was notified about the breach (e.g., ICO, CNIL, California Attorney General).',
    `regulatory_notification_deadline` TIMESTAMP COMMENT 'Deadline timestamp by which the organization must notify the relevant supervisory authority about the breach (typically 72 hours from discovery under GDPR).',
    `regulatory_notification_sent_date` TIMESTAMP COMMENT 'Actual timestamp when notification was sent to the regulatory supervisory authority.',
    `regulatory_penalty_imposed_flag` BOOLEAN COMMENT 'Indicates whether a regulatory penalty or fine was imposed by a supervisory authority as a result of the incident.',
    `remediation_actions_taken` STRING COMMENT 'Description of remediation measures implemented to address the root cause, restore security, and prevent recurrence of similar incidents.',
    `risk_assessment` STRING COMMENT 'Detailed risk assessment narrative describing the potential consequences and risks to the rights and freedoms of affected data subjects.',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause of the privacy incident including technical, procedural, or human factors that contributed to the breach.',
    `severity_level` STRING COMMENT 'Assessed severity level of the privacy incident based on the nature of data affected, number of subjects, and potential harm.. Valid values are `critical|high|medium|low`',
    `subject_notification_required_flag` BOOLEAN COMMENT 'Indicates whether direct notification to affected data subjects is required under applicable data protection laws.',
    `subject_notification_sent_date` TIMESTAMP COMMENT 'Actual timestamp when notification was sent to affected data subjects.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy incident record was last modified or updated.',
    CONSTRAINT pk_privacy_incident PRIMARY KEY(`privacy_incident_id`)
) COMMENT 'Data privacy breach and incident record tracking GDPR, CCPA, and other data protection regulation events at Travel Hospitality. Captures incident reference number, incident type (data breach, unauthorized access, data loss, improper disclosure, subject rights violation), discovery date, incident date, data categories affected (PII, payment card, health data, biometric), estimated number of data subjects affected, jurisdictions impacted, breach notification required flag, regulatory notification deadline, notification sent date, regulatory authority notified, and containment actions taken. Distinct from guest.privacy_request which tracks individual data subject rights requests.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` (
    `dpia_id` BIGINT COMMENT 'Unique identifier for the Data Protection Impact Assessment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this DPIA record, supporting audit trail and accountability requirements.',
    `property_id` BIGINT COMMENT 'Identifier of the property or business unit to which this DPIA applies. Links to the property master data.',
    `superseded_dpia_id` BIGINT COMMENT 'Self-referencing FK on dpia (superseded_dpia_id)',
    `approval_date` DATE COMMENT 'Date on which the DPIA was formally approved.',
    `approval_status` STRING COMMENT 'Current approval status of the DPIA within the organizations governance workflow.. Valid values are `draft|pending_review|approved|rejected|requires_revision`',
    `approved_by_name` STRING COMMENT 'Full name of the individual who approved the DPIA (typically a senior privacy officer, legal counsel, or executive).',
    `assessment_date` DATE COMMENT 'Date on which the DPIA was conducted or completed.',
    `assessor_name` STRING COMMENT 'Full name of the individual or team responsible for conducting the DPIA.',
    `assessor_role` STRING COMMENT 'Job title or role of the assessor (e.g., Data Protection Officer, Privacy Manager, Compliance Analyst).',
    `automated_decision_logic` STRING COMMENT 'Description of the logic involved in automated decision-making processes, if applicable.',
    `automated_decision_making_flag` BOOLEAN COMMENT 'Indicates whether the processing involves automated decision-making, including profiling, that produces legal or similarly significant effects.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DPIA record was first created in the system.',
    `cross_border_transfer_flag` BOOLEAN COMMENT 'Indicates whether the processing involves transfer of personal data to third countries or international organizations.',
    `data_subject_consultation_flag` BOOLEAN COMMENT 'Indicates whether data subjects or their representatives were consulted during the DPIA process, as recommended under GDPR Article 35(9).',
    `data_subject_consultation_summary` STRING COMMENT 'Summary of feedback or views obtained from data subjects or their representatives during the DPIA process.',
    `dpo_consultation_date` DATE COMMENT 'Date on which the Data Protection Officer was consulted regarding the DPIA.',
    `dpo_consultation_flag` BOOLEAN COMMENT 'Indicates whether the Data Protection Officer was consulted during the DPIA process as required under GDPR Article 35(2).',
    `dpo_recommendation` STRING COMMENT 'Formal recommendation or advice provided by the Data Protection Officer regarding the processing activity and identified risks.',
    `identified_privacy_risks` STRING COMMENT 'Comprehensive description of privacy risks identified during the assessment, including risks to data subject rights and freedoms.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or update of this DPIA.',
    `legal_basis` STRING COMMENT 'Legal basis under GDPR Article 6 that justifies the processing activity being assessed.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `mitigation_measures` STRING COMMENT 'Detailed description of technical and organizational measures implemented or planned to mitigate identified privacy risks.',
    `necessity_assessment` STRING COMMENT 'Assessment of whether the data processing is necessary to achieve the stated purpose, documenting the business justification and legal basis.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this DPIA to reassess risks and mitigation measures.',
    `notes` STRING COMMENT 'Additional notes, observations, or context relevant to the DPIA that do not fit into other structured fields.',
    `processing_activity_description` STRING COMMENT 'Detailed description of the data processing activity, including purpose, scope, data subjects involved, and data categories processed.',
    `processing_activity_name` STRING COMMENT 'Name of the personal data processing activity being assessed (e.g., Guest Loyalty Program Enrollment, Employee Background Screening, CCTV Surveillance in Public Areas).',
    `proportionality_assessment` STRING COMMENT 'Assessment of whether the data processing is proportionate to the purpose, evaluating whether less intrusive alternatives exist.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the DPIA, typically formatted as DPIA-YYYY-NNNN for tracking and audit purposes.. Valid values are `^DPIA-[0-9]{4}-[0-9]{4}$`',
    `residual_risk_level` STRING COMMENT 'Risk level remaining after mitigation measures have been applied, determining whether additional action or supervisory authority consultation is required.. Valid values are `high|medium|low|acceptable`',
    `retention_period` STRING COMMENT 'Documented retention period for personal data processed under this activity, aligned with data minimization principles.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which the DPIA should be reviewed and updated to ensure continued accuracy and compliance.',
    `risk_likelihood` STRING COMMENT 'Likelihood rating of the identified privacy risks materializing before mitigation measures are applied.. Valid values are `high|medium|low`',
    `risk_severity` STRING COMMENT 'Overall severity rating of the identified privacy risks before mitigation measures are applied.. Valid values are `high|medium|low`',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the processing involves special categories of personal data as defined in GDPR Article 9 (e.g., health data, biometric data, racial or ethnic origin).',
    `special_category_justification` STRING COMMENT 'Justification and legal basis for processing special category data, if applicable, under GDPR Article 9(2).',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date on which the supervisory authority was consulted regarding the high-risk processing activity.',
    `supervisory_authority_consultation_required_flag` BOOLEAN COMMENT 'Indicates whether consultation with the supervisory authority is required due to high residual risk that cannot be adequately mitigated, as per GDPR Article 36.',
    `supervisory_authority_response` STRING COMMENT 'Summary of the response or guidance received from the supervisory authority following consultation.',
    `transfer_safeguards` STRING COMMENT 'Description of safeguards in place for cross-border data transfers (e.g., Standard Contractual Clauses, Binding Corporate Rules, adequacy decision).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this DPIA record was last modified.',
    CONSTRAINT pk_dpia PRIMARY KEY(`dpia_id`)
) COMMENT 'Data Protection Impact Assessment (DPIA) record documenting formal privacy risk assessments conducted for high-risk personal data processing activities as required under GDPR Article 35. Captures DPIA reference number, processing activity assessed, assessment date, assessor name, necessity and proportionality assessment, identified privacy risks, risk severity (high, medium, low), risk mitigation measures, residual risk level, DPO consultation flag, DPO recommendation, supervisory authority consultation required flag, and DPIA approval status. Supports GDPR accountability obligations and privacy-by-design governance.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` (
    `food_safety_cert_id` BIGINT COMMENT 'Unique identifier for the food safety certification record. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the specific F&B outlet, kitchen, or catering operation covered by this certification.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Food safety certifications are regulatory permits/licenses. The food_safety_cert table has certification_number, certifying_body, status, and lifecycle dates that duplicate permit master data. Adding ',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for maintaining this certification and ensuring ongoing compliance.',
    `property_id` BIGINT COMMENT 'Reference to the property where this food safety certification applies.',
    `renewed_food_safety_cert_id` BIGINT COMMENT 'Self-referencing FK on food_safety_cert (renewed_food_safety_cert_id)',
    `tertiary_food_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last updated this certification record in the system.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this certification record to detailed audit logs, inspection reports, or compliance documentation.',
    `certification_name` STRING COMMENT 'The full name or title of the certification as issued by the certifying body.',
    `certification_scope` STRING COMMENT 'Description of the scope of operations covered by this certification (e.g., full-service restaurant, banquet kitchen, bar service, catering operations).',
    `certification_type` STRING COMMENT 'The type or category of food safety certification (e.g., HACCP, ServSafe, local health department grade, ISO 22000, food handler card, manager certification). [ENUM-REF-CANDIDATE: HACCP|ServSafe|Local Health Department|ISO 22000|Food Handler|Manager Certification|Other — 7 candidates stripped; promote to reference product]',
    `corrective_actions_completed_flag` BOOLEAN COMMENT 'Indicates whether all required corrective actions have been completed (True) or are still pending (False).',
    `corrective_actions_completion_date` DATE COMMENT 'The date on which all required corrective actions were completed and verified.',
    `corrective_actions_required` STRING COMMENT 'Description of corrective actions required to address violations or deficiencies identified during the last inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system.',
    `critical_violations_count` STRING COMMENT 'The number of critical food safety violations identified during the last inspection. Critical violations pose immediate health risks.',
    `health_inspection_grade` STRING COMMENT 'The letter grade or pass/fail result assigned by the health inspector during the last inspection. [ENUM-REF-CANDIDATE: A|B|C|Pass|Fail|Satisfactory|Unsatisfactory — 7 candidates stripped; promote to reference product]',
    `health_inspection_score` DECIMAL(18,2) COMMENT 'The numeric score assigned during the last health inspection (typically 0-100 scale, where higher is better).',
    `inspection_frequency_days` STRING COMMENT 'The number of days between required inspections as mandated by the certifying body or regulatory authority.',
    `jurisdiction_code` STRING COMMENT 'The code or identifier for the regulatory jurisdiction (city, county, state, country) under which this certification is issued and enforced.',
    `jurisdiction_name` STRING COMMENT 'The full name of the regulatory jurisdiction (e.g., Los Angeles County Health Department, New York State Department of Health).',
    `last_inspection_date` DATE COMMENT 'The date of the most recent health inspection conducted at the outlet or facility covered by this certification.',
    `last_training_date` DATE COMMENT 'The date on which the most recent food safety training was completed for staff covered by this certification.',
    `next_inspection_date` DATE COMMENT 'The scheduled date for the next health inspection or audit of the outlet or facility.',
    `next_training_due_date` DATE COMMENT 'The date by which the next food safety training session must be completed to maintain certification compliance.',
    `non_critical_violations_count` STRING COMMENT 'The number of non-critical food safety violations identified during the last inspection. Non-critical violations do not pose immediate health risks but require correction.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this food safety certification.',
    `risk_level` STRING COMMENT 'The assessed risk level of the outlet or facility based on food safety compliance history, violation severity, and operational complexity.. Valid values are `Low|Medium|High|Critical`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing food safety training is required to maintain this certification (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last updated in the system.',
    CONSTRAINT pk_food_safety_cert PRIMARY KEY(`food_safety_cert_id`)
) COMMENT 'Food safety certification and inspection record for F&B outlets, kitchens, and catering operations at Travel Hospitality properties. Captures certification type (HACCP, ServSafe, local health department grade, ISO 22000), certifying body, property and outlet reference, certification number, issue date, expiration date, certification status (active, expired, suspended, pending), last health inspection date, health inspection grade or score, critical violations count, non-critical violations count, and corrective actions required. Complements fnb.food_safety_inspection (which captures individual inspection events) by serving as the authoritative certification master.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` (
    `fire_safety_record_id` BIGINT COMMENT 'Unique identifier for the fire safety compliance record. Primary key for the fire safety record entity.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Fire suppression systems, alarms, and extinguishers are capitalized assets. Linking safety records to asset register enables maintenance cost tracking, depreciation schedules, insurance documentation,',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Fire safety certificates are a type of permit/license. The fire_safety_record table has certificate_number, issuing_authority, certificate dates, and status that duplicate permit master data. Adding p',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this fire safety record.',
    `prior_fire_safety_record_id` BIGINT COMMENT 'Self-referencing FK on fire_safety_record (prior_fire_safety_record_id)',
    `property_id` BIGINT COMMENT 'Reference to the property for which this fire safety record applies. Links to the property master data.',
    `alarm_system_last_test_date` DATE COMMENT 'Date when the fire alarm system was last tested for functionality and compliance.',
    `alarm_system_next_test_date` DATE COMMENT 'Scheduled date for the next required test of the fire alarm system.',
    `compliance_status` STRING COMMENT 'Overall fire safety compliance status of the property based on all inspections, certifications, and violations.. Valid values are `compliant|non_compliant|conditional|pending_inspection|under_remediation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fire safety record was first created in the system.',
    `emergency_lighting_compliant_flag` BOOLEAN COMMENT 'Indicates whether emergency lighting systems meet fire safety code requirements.',
    `evacuation_plan_last_review_date` DATE COMMENT 'Date when the emergency evacuation plan was last reviewed and updated.',
    `evacuation_plan_next_review_date` DATE COMMENT 'Scheduled date for the next required review of the emergency evacuation plan.',
    `exit_signage_compliant_flag` BOOLEAN COMMENT 'Indicates whether exit signage meets fire safety code requirements for visibility and placement.',
    `extinguisher_last_inspection_date` DATE COMMENT 'Date when fire extinguishers were last inspected for compliance and operational readiness.',
    `extinguisher_next_inspection_date` DATE COMMENT 'Scheduled date for the next required inspection of fire extinguishers.',
    `fire_alarm_system_type` STRING COMMENT 'Type of fire alarm system installed at the property (e.g., conventional, addressable, wireless).. Valid values are `conventional|addressable|wireless|hybrid|none`',
    `fire_door_count` STRING COMMENT 'Total number of fire-rated doors installed at the property.',
    `fire_door_last_inspection_date` DATE COMMENT 'Date when fire-rated doors were last inspected for proper operation and compliance.',
    `fire_drill_frequency_days` STRING COMMENT 'Number of days between required fire drills as mandated by local regulations.',
    `fire_drill_last_conducted_date` DATE COMMENT 'Date when the most recent fire drill was conducted at the property.',
    `fire_drill_next_scheduled_date` DATE COMMENT 'Scheduled date for the next required fire drill at the property.',
    `fire_extinguisher_count` STRING COMMENT 'Total number of fire extinguishers installed and maintained at the property.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed at the property (e.g., sprinkler, foam, gas-based). [ENUM-REF-CANDIDATE: sprinkler|foam|gas|water_mist|dry_chemical|wet_chemical|hybrid|none — 8 candidates stripped; promote to reference product]',
    `inspection_frequency_days` STRING COMMENT 'Number of days between required fire safety inspections as mandated by local regulations.',
    `insurance_notification_required_flag` BOOLEAN COMMENT 'Indicates whether property insurance carrier must be notified of fire safety status changes.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent fire safety inspection conducted by the fire authority or certified inspector.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required fire safety inspection.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the propertys fire safety compliance status.',
    `outstanding_violations_count` STRING COMMENT 'Number of unresolved fire code violations currently recorded for the property.',
    `remediation_due_date` DATE COMMENT 'Deadline by which outstanding fire code violations must be remediated to maintain compliance.',
    `responsible_person_contact` STRING COMMENT 'Contact phone number for the individual responsible for fire safety compliance.',
    `responsible_person_name` STRING COMMENT 'Name of the individual responsible for fire safety compliance at the property.',
    `sprinkler_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the propertys total area covered by automatic sprinkler systems.',
    `suppression_system_last_test_date` DATE COMMENT 'Date when the fire suppression system was last tested for operational readiness.',
    `suppression_system_next_test_date` DATE COMMENT 'Scheduled date for the next required test of the fire suppression system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fire safety record was last updated in the system.',
    `violation_details` STRING COMMENT 'Detailed description of any outstanding fire code violations identified during inspections.',
    `violation_severity_level` STRING COMMENT 'Severity classification of the most critical outstanding fire code violation.. Valid values are `critical|high|medium|low|none`',
    CONSTRAINT pk_fire_safety_record PRIMARY KEY(`fire_safety_record_id`)
) COMMENT 'Fire safety compliance master record for each property capturing the status of all fire safety systems, inspections, and certifications. Captures fire safety certificate number, issuing fire authority, property reference, certificate issue date, expiration date, certificate status, last fire inspection date, fire suppression system type and last test date, fire alarm system last test date, emergency evacuation plan last review date, fire drill last conducted date, sprinkler coverage percentage, fire extinguisher count and last inspection date, and any outstanding fire code violations. Single source of truth for property-level fire safety compliance posture.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` (
    `ada_assessment_id` BIGINT COMMENT 'Unique identifier for the ADA accessibility compliance assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this ADA assessment record.',
    `prior_ada_assessment_id` BIGINT COMMENT 'Self-referencing FK on ada_assessment (prior_ada_assessment_id)',
    `property_id` BIGINT COMMENT 'Identifier of the hotel, resort, or vacation property being assessed for ADA compliance.',
    `assessment_date` DATE COMMENT 'The date on which the ADA accessibility assessment was conducted at the property.',
    `assessment_frequency_months` STRING COMMENT 'Standard frequency in months between scheduled ADA assessments for this property (e.g., 12, 24, 36 months).',
    `assessment_notes` STRING COMMENT 'Additional free-text notes, observations, or recommendations from the assessor regarding ADA compliance, best practices, or areas of concern.',
    `assessment_reference_number` STRING COMMENT 'External business reference number for the ADA assessment, used for tracking and reporting purposes.. Valid values are `^ADA-[A-Z0-9]{8,12}$`',
    `assessment_report_url` STRING COMMENT 'URL or file path to the detailed ADA assessment report document containing findings, photographs, and recommendations.',
    `assessment_scope_notes` STRING COMMENT 'Free-text notes describing the specific scope, limitations, or special considerations of the ADA assessment (e.g., areas excluded, phased approach, weather constraints).',
    `assessment_type` STRING COMMENT 'Classification of the ADA assessment based on the trigger or purpose: initial baseline assessment, periodic scheduled review, complaint-triggered investigation, renovation-triggered evaluation, acquisition due diligence, or post-remediation verification.. Valid values are `initial|periodic|complaint_triggered|renovation_triggered|acquisition_due_diligence|post_remediation`',
    `assessor_credentials` STRING COMMENT 'Professional credentials, certifications, or qualifications of the assessor (e.g., Certified Access Specialist, ADA Coordinator, licensed architect).',
    `assessor_name` STRING COMMENT 'Full name of the individual or firm who conducted the ADA accessibility assessment.',
    `assessor_organization` STRING COMMENT 'Name of the organization or consulting firm that the assessor represents.',
    `barriers_pending_remediation_count` STRING COMMENT 'Count of accessibility barriers that remain outstanding and require remediation to achieve full ADA compliance.',
    `barriers_remediated_count` STRING COMMENT 'Count of accessibility barriers that have been successfully remediated and brought into ADA compliance as of the current date.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the ADA compliance certification, after which a new assessment is required to maintain certified status.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal ADA compliance certification or letter of compliance was issued by the assessor following the assessment.',
    `complaint_reference_number` STRING COMMENT 'Reference number of the guest complaint, legal claim, or regulatory inquiry that triggered this ADA assessment, if applicable.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of ADA compliance based on the ratio of compliant elements to total elements assessed, expressed as a percentage (0.00 to 100.00).',
    `compliance_status` STRING COMMENT 'Overall ADA compliance status of the property based on the assessment findings: compliant (no barriers), substantially compliant (minor barriers only), partially compliant (moderate barriers present), non-compliant (significant barriers present), or under remediation (active remediation plan in progress).. Valid values are `compliant|substantially_compliant|partially_compliant|non_compliant|under_remediation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ADA assessment record was first created in the system.',
    `entrances_evaluated_flag` BOOLEAN COMMENT 'Indicates whether building entrances, accessible routes, and entry points were included in the ADA assessment.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in the propertys operating currency to remediate all identified ADA accessibility barriers and achieve full compliance.',
    `fitness_facilities_evaluated_flag` BOOLEAN COMMENT 'Indicates whether fitness centers, gyms, and exercise facilities were included in the ADA assessment.',
    `guest_rooms_evaluated_flag` BOOLEAN COMMENT 'Indicates whether guest rooms and sleeping accommodations were included in the scope of the ADA assessment.',
    `high_priority_barriers_count` STRING COMMENT 'Count of accessibility barriers classified as high priority due to significant impact on guest safety, access, or legal risk.',
    `legal_case_reference` STRING COMMENT 'Reference number or docket number of any legal case, lawsuit, or Department of Justice (DOJ) investigation related to this ADA assessment.',
    `meeting_spaces_evaluated_flag` BOOLEAN COMMENT 'Indicates whether meeting rooms, conference spaces, ballrooms, and event facilities were included in the ADA assessment for accessibility compliance.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic ADA accessibility assessment to ensure ongoing compliance and identify any new barriers.',
    `parking_evaluated_flag` BOOLEAN COMMENT 'Indicates whether parking facilities and accessible parking spaces were included in the ADA assessment.',
    `pools_evaluated_flag` BOOLEAN COMMENT 'Indicates whether swimming pools, spas, and aquatic facilities were included in the ADA assessment for accessibility features such as lifts and sloped entries.',
    `public_areas_evaluated_flag` BOOLEAN COMMENT 'Indicates whether public areas such as lobbies, corridors, elevators, and common spaces were included in the ADA assessment.',
    `remediation_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated remediation cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `remediation_plan_reference` STRING COMMENT 'Reference number or identifier of the formal remediation plan document that outlines corrective actions, timelines, and responsibilities for addressing identified ADA barriers.',
    `responsible_party_email` STRING COMMENT 'Email address of the individual responsible for ADA compliance and remediation at the property.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or department responsible for overseeing ADA compliance and remediation efforts at the property (e.g., General Manager, Facilities Director, Compliance Officer).',
    `restaurants_evaluated_flag` BOOLEAN COMMENT 'Indicates whether Food and Beverage (F&B) outlets, restaurants, bars, and dining areas were included in the ADA assessment.',
    `restrooms_evaluated_flag` BOOLEAN COMMENT 'Indicates whether public restrooms and toilet facilities were included in the ADA assessment for accessibility features.',
    `signage_evaluated_flag` BOOLEAN COMMENT 'Indicates whether directional, informational, and accessible signage (including Braille and tactile signs) were included in the ADA assessment.',
    `total_barriers_identified` STRING COMMENT 'Total count of accessibility barriers, deficiencies, or non-compliant elements identified during the ADA assessment across all evaluated areas.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ADA assessment record was last modified or updated in the system.',
    CONSTRAINT pk_ada_assessment PRIMARY KEY(`ada_assessment_id`)
) COMMENT 'ADA (Americans with Disabilities Act) and accessibility compliance assessment record for Travel Hospitality properties. Captures assessment reference number, property assessed, assessment type (initial, periodic, triggered by complaint), assessment date, assessor name and credentials, accessibility areas evaluated (guest rooms, public areas, parking, pools, restaurants, meeting spaces), total barriers identified, barriers remediated count, barriers pending remediation count, ADA compliance status (compliant, partially compliant, non-compliant), remediation plan reference, and next assessment due date. Supports ADA Title III compliance and accessibility improvement planning.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` (
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key for this entity.',
    `learning_course_id` BIGINT COMMENT 'Reference to the compliance training requirement that this completion record satisfies. Links to the training requirement master.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Compliance policies often require mandatory training (e.g., Code of Conduct training, Anti-Harassment training, Data Privacy training). One policy can require one training course. This FK allows track',
    `employee_id` BIGINT COMMENT 'Reference to the employee who completed the training. Links to the workforce employee master record.',
    `property_id` BIGINT COMMENT 'Reference to the property where the employee is assigned at the time of training completion. Enables property-level compliance tracking.',
    `retake_compliance_training_completion_id` BIGINT COMMENT 'Self-referencing FK on compliance_training_completion (retake_compliance_training_completion_id)',
    `tertiary_compliance_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or process that last modified this training completion record. Used for audit trail and change management.',
    `workforce_training_completion_id` BIGINT COMMENT '',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this represents for the employee to complete this training requirement. First attempt is 1. Used to track retakes and learning effectiveness.',
    `audit_trail_reference` STRING COMMENT 'Reference number or identifier linking this training completion to external audit documentation, regulatory filings, or compliance case files. Used for regulatory audit response.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was officially issued. May differ from completion date for certifications requiring external validation. Null if no certificate issued.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion. Used for verification with regulatory bodies and external auditors. Null if no certificate issued.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the training course. Used to calculate compliance currency and expiration dates.',
    `completion_record_number` STRING COMMENT 'Business-facing unique identifier for the training completion record. Used for audit trails and external reporting to regulatory bodies.',
    `compliance_status` STRING COMMENT 'Current compliance status of the training for this employee. Current indicates valid certification; expiring_soon indicates approaching expiration within threshold; expired indicates past due; not_started indicates requirement not yet initiated; in_progress indicates training underway; waived indicates exemption granted.. Valid values are `current|expiring_soon|expired|not_started|in_progress|waived`',
    `course_code` STRING COMMENT 'Standardized code or identifier for the training course. Used for system integration and reporting consistency across properties.',
    `course_name` STRING COMMENT 'Full name of the compliance training course completed by the employee. Examples include Food Safety Certification, ADA Accessibility Training, Fire Safety Procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount. Examples: USD, EUR, GBP. Enables multi-currency cost tracking across global properties.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered to the employee. Online indicates e-learning; in_person indicates classroom; blended indicates combination; virtual_instructor_led indicates live remote; self_paced indicates asynchronous; on_the_job indicates practical training.. Valid values are `online|in_person|blended|virtual_instructor_led|self_paced|on_the_job`',
    `department_code` STRING COMMENT 'Code identifying the department to which the employee belonged at the time of training completion. Used for department-level compliance reporting and cost allocation.',
    `expiration_date` DATE COMMENT 'Date on which the training certification expires and requires renewal. Null for training that does not expire. Critical for proactive compliance monitoring.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the training. Null for self-paced or automated training. Used for quality tracking and instructor effectiveness analysis.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, certification authority, or organization that issued the certificate. Examples include ServSafe, OSHA, state liquor boards. Null if internally certified.',
    `job_code` STRING COMMENT 'Code identifying the employees job role at the time of training completion. Used to track role-specific training compliance and identify training gaps by position.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the legal jurisdiction (country, state, province, municipality) whose regulations this training satisfies. Critical for multi-jurisdictional compliance tracking.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for the employees role and location. True for required compliance training; false for optional professional development.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or compliance officer comments related to this training completion. Used for audit documentation and exception tracking.',
    `pass_fail_result` STRING COMMENT 'Outcome of the training assessment. Pass indicates successful completion; fail indicates unsuccessful attempt; incomplete indicates training started but not finished; waived indicates exemption from assessment.. Valid values are `pass|fail|incomplete|waived`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment. Used to determine pass/fail result. Null if training does not have a scored assessment.',
    `regulatory_category` STRING COMMENT 'High-level category of regulatory compliance that this training addresses. Used for compliance dashboard reporting and regulatory audit preparation by compliance domain. [ENUM-REF-CANDIDATE: health_safety|food_safety|data_privacy|accessibility|fire_safety|liquor_licensing|financial_compliance|hr_compliance|environmental|other — 10 candidates stripped; promote to reference product]',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for this training. Null if renewal is not required. Common values include 12, 24, 36 months depending on regulatory requirements.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this training requires periodic renewal. True for certifications that expire; false for one-time training. Used to trigger renewal workflows.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved by the employee on the training assessment. Null if training does not include scored assessment. Range typically 0-100.',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training completion, including course fees, materials, instructor costs, and employee time. Used for training ROI analysis and budget tracking.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee spent completing the training. Used for workforce planning, cost analysis, and regulatory reporting where contact hours are required.',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that provided the training. May be internal (company name) or external third-party provider. Important for audit and vendor management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified. Used for audit trail and change tracking. Updated whenever any field in the record changes.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the compliance officer or manager who approved the training waiver. Null if no waiver granted. Required for audit trail.',
    `waiver_expiry_date` DATE COMMENT 'Date on which the training waiver expires and standard requirement resumes. Null if waiver is permanent or no waiver granted. Used to trigger compliance re-assessment.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exemption from this training requirement was granted to the employee. True if waived; false if standard requirement applies. Requires documented justification.',
    `waiver_reason` STRING COMMENT 'Business justification for granting a training waiver. Examples include prior certification from another employer, role exemption, or temporary assignment. Null if no waiver granted.',
    CONSTRAINT pk_compliance_training_completion PRIMARY KEY(`compliance_training_completion_id`)
) COMMENT 'Transactional record of individual employee completion of mandatory compliance training requirements. Captures completion record number, employee reference, training requirement reference, training course name, completion date, expiration date, pass/fail result, score achieved, training delivery method, training provider, certificate number issued, and compliance status (current, expiring soon, expired, not started). Enables compliance officers to track training currency across the workforce and demonstrate regulatory compliance to auditors. Complements workforce.learning_course by focusing on compliance-mandated training completion status. [SSOT_OWNER] [SSOT MASTER for group compliance.compliance_training_completion] [SSOT:training_completion] Canonical single-source-of-truth for the training_completion concept; other domain variants are domain-specific specializations referencing this owner.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk register entry. Primary key for the risk register product.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings (especially critical and major findings) represent identified compliance risks that must be tracked and mitigated. One finding can be tracked as one risk entry. This FK allows linking r',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance obligations represent operational and regulatory risks that must be tracked in the enterprise risk register. Failure to meet an obligation can result in fines, license suspension, or operat',
    `parent_risk_register_id` BIGINT COMMENT 'Self-referencing FK on risk_register (parent_risk_register_id)',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit expiration, suspension, or non-renewal represents significant operational risk (e.g., liquor license expiration shuts down bar operations, health permit suspension closes F&B outlets). One perm',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this risk applies. Links to the property master data for property-specific risks.',
    `risk_employee_id` BIGINT COMMENT 'Identifier of the user who created this risk register entry. Links to user or employee master data for audit trail purposes.',
    `risk_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last updated this risk register entry. Links to user or employee master data for audit trail purposes.',
    `actual_closure_date` DATE COMMENT 'Actual date when the risk was closed or mitigated to an acceptable level.',
    `control_effectiveness` STRING COMMENT 'Assessment of how well the current control measures are functioning to mitigate the risk. Effective means controls are working as designed; partially effective means controls reduce but do not eliminate risk; ineffective means controls are not adequately addressing the risk.. Valid values are `effective|partially_effective|ineffective|not_assessed`',
    `control_measures` STRING COMMENT 'Description of existing controls, policies, procedures, and mitigation actions currently in place to manage and reduce the risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date when the risk was escalated to senior management or board level for review and decision.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this risk currently requires escalation to senior management based on residual risk score exceeding the escalation threshold.',
    `escalation_threshold_score` STRING COMMENT 'Residual risk score threshold above which the risk must be escalated to senior management or board level. Typically set at 15 or 20 on the 1-25 scale.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact in monetary terms if the risk materializes, including potential revenue loss, penalty costs, remediation costs, or legal settlement amounts.',
    `financial_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `identification_date` DATE COMMENT 'Date when the risk was first identified and entered into the risk register.',
    `impact_rating` STRING COMMENT 'Severity assessment of the risk impact if it occurs on a scale of 1 to 5, where 1 is negligible impact and 5 is catastrophic impact affecting multiple properties or enterprise reputation.',
    `inherent_risk_score` STRING COMMENT 'Calculated risk score before considering control measures, computed as likelihood rating multiplied by impact rating. Range is 1 to 25.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the legal jurisdiction or geographic region where this risk applies (e.g., US, CA, EU, UK).. Valid values are `^[A-Z]{2,3}$`',
    `last_incident_date` DATE COMMENT 'Date of the most recent incident or event related to this risk.',
    `last_review_date` DATE COMMENT 'Date when the risk was most recently reviewed and assessed by the risk owner or compliance team.',
    `likelihood_rating` STRING COMMENT 'Probability assessment of the risk occurring on a scale of 1 to 5, where 1 is rare (less than 10% probability) and 5 is almost certain (greater than 90% probability).',
    `mitigation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost in monetary terms to implement the mitigation plan and controls to reduce the risk.',
    `mitigation_plan` STRING COMMENT 'Detailed action plan outlining specific steps, resources, and timeline for reducing the risk to an acceptable level.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review and reassessment of this risk.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context about the risk for internal reference and knowledge sharing.',
    `regulatory_reference` STRING COMMENT 'Citation of specific regulation, law, standard, or compliance requirement associated with this risk (e.g., GDPR Article 32, OSHA 1910.38, PCI DSS 3.2.1).',
    `related_incident_count` STRING COMMENT 'Number of actual incidents or near-miss events that have occurred related to this risk, providing evidence of risk materialization.',
    `residual_impact_rating` STRING COMMENT 'Revised severity assessment after considering the effect of control measures, on a scale of 1 to 5.',
    `residual_likelihood_rating` STRING COMMENT 'Revised probability assessment after considering the effect of control measures, on a scale of 1 to 5.',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after considering control measures, computed as residual likelihood rating multiplied by residual impact rating. Range is 1 to 25.',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of this risk. High-priority risks typically have shorter review cycles (e.g., 30, 60, 90 days).',
    `risk_appetite_alignment` STRING COMMENT 'Assessment of whether the residual risk level aligns with the organizations stated risk appetite. Within appetite means acceptable; exceeds appetite means requires additional mitigation; below appetite means over-controlled.. Valid values are `within_appetite|exceeds_appetite|below_appetite`',
    `risk_category` STRING COMMENT 'Primary classification of the risk type. Regulatory includes compliance with laws and regulations; health and safety covers guest and employee safety; data privacy includes GDPR and CCPA compliance; reputational covers brand and guest satisfaction; financial covers revenue and cost risks; operational covers business process and service delivery risks.. Valid values are `regulatory|health_and_safety|data_privacy|reputational|financial|operational`',
    `risk_code` STRING COMMENT 'Unique business identifier for the risk following the format AAA-9999 where AAA represents risk category prefix and 9999 is sequential number.. Valid values are `^[A-Z]{3}-[0-9]{4}$`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk including potential causes, scenarios, and business context.',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk. Open means newly identified; in progress means mitigation actions underway; mitigated means controls have reduced risk to acceptable level; accepted means risk acknowledged and no further action planned; closed means risk no longer applicable; escalated means risk requires senior management attention.. Valid values are `open|in_progress|mitigated|accepted|closed|escalated`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the primary risk category (e.g., fire safety, food safety, PCI DSS, ADA compliance).',
    `risk_title` STRING COMMENT 'Short descriptive title of the identified risk for quick reference and reporting.',
    `scope_level` STRING COMMENT 'Organizational level at which the risk applies. Property for single-property risks; brand for brand-specific risks; region for geographic area risks; portfolio for multi-property segment risks; enterprise for company-wide risks.. Valid values are `property|brand|region|portfolio|enterprise`',
    `target_closure_date` DATE COMMENT 'Planned date by which the risk is expected to be mitigated to an acceptable level or closed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was last modified or updated.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Enterprise compliance and operational risk register for Travel Hospitality capturing identified risks across all properties and business functions. Captures risk ID, risk title, risk category (regulatory, health and safety, data privacy, reputational, financial, operational), risk description, property or portfolio scope, likelihood rating (1-5), impact rating (1-5), inherent risk score, control measures in place, residual risk score, risk owner, risk status (open, mitigated, accepted, closed), risk review date, and escalation threshold. Serves as the authoritative risk inventory for compliance governance and executive risk reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `amended_regulatory_filing_id` BIGINT COMMENT 'Self-referencing FK on regulatory_filing (amended_regulatory_filing_id)',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Regulatory filings often incur fees or penalties that must be paid via AP invoices. This FK links the compliance filing to the payment document for audit trail and financial reconciliation. Critical f',
    `environmental_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_compliance. Business justification: Environmental compliance permits require periodic regulatory filings (energy usage reports, water consumption reports, waste diversion reports, carbon emissions disclosures). One environmental complia',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance obligations often require regulatory filings to demonstrate compliance (e.g., ADA compliance reports, environmental disclosures, safety certifications). One obligation can require multiple ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permits require periodic regulatory filings (renewal applications, annual reports, compliance certifications). One permit generates multiple filings over its lifecycle. This FK allows tracking which f',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this regulatory filing record.',
    `property_id` BIGINT COMMENT 'Identifier of the property or entity to which this regulatory filing applies. Links to the property master data.',
    `acceptance_date` DATE COMMENT 'Date on which the regulatory body formally accepted or approved the filing as complete and compliant.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory body acknowledged receipt of the filing.',
    `confirmation_number` STRING COMMENT 'Confirmation or receipt number provided by the regulatory body upon successful submission of the filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was first created in the system.',
    `document_reference_code` STRING COMMENT 'Reference identifier or file path to the supporting documentation, forms, or attachments associated with this filing.',
    `due_date` DATE COMMENT 'Regulatory deadline by which this filing must be submitted to avoid penalties or non-compliance.',
    `filing_agent_email` STRING COMMENT 'Email address of the filing agent or compliance officer responsible for this submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `filing_agent_name` STRING COMMENT 'Name of the individual, department, or external consultant responsible for preparing and submitting this filing.',
    `filing_agent_phone` STRING COMMENT 'Contact phone number of the filing agent or compliance officer responsible for this submission.',
    `filing_description` STRING COMMENT 'Detailed description of the purpose, scope, and content of this regulatory filing.',
    `filing_method` STRING COMMENT 'Method or channel used to submit the filing to the regulatory body (e.g., online portal, email, postal mail, fax, in-person delivery, API integration).. Valid values are `online_portal|email|postal_mail|fax|in_person|api_integration`',
    `filing_period_end_date` DATE COMMENT 'End date of the reporting or compliance period covered by this filing.',
    `filing_period_start_date` DATE COMMENT 'Start date of the reporting or compliance period covered by this filing.',
    `filing_reference_number` STRING COMMENT 'External reference number or tracking identifier assigned by the regulatory body or internal compliance system for this filing.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing. Tracks progression from draft through submission, review, and final disposition. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|accepted|rejected|under_review|pending_correction|withdrawn — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Category of regulatory filing. Indicates the nature of the submission such as occupancy tax filings, liquor license renewals, health department reports, OSHA 300 log submissions, GDPR supervisory authority notifications, CCPA annual reports, fire marshal reports, environmental compliance filings, ADA compliance reports, building permits, or food safety certifications. [ENUM-REF-CANDIDATE: occupancy_tax|liquor_license_renewal|health_department_report|osha_300_log|gdpr_notification|ccpa_annual_report|fire_marshal_report|environmental_compliance|ada_compliance|building_permit|food_safety_certification — 11 candidates stripped; promote to reference product]',
    `jurisdiction_code` STRING COMMENT 'Code representing the geographic or legal jurisdiction under which this filing is required (e.g., state code, country code, municipality code).',
    `jurisdiction_name` STRING COMMENT 'Full name of the jurisdiction (country, state, province, municipality) governing this regulatory filing requirement.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this filing, including internal observations or follow-up actions required.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any penalty or fine assessed by the regulatory body for late filing, non-compliance, or errors in this submission.',
    `penalty_assessed_flag` BOOLEAN COMMENT 'Indicates whether a penalty, fine, or sanction was assessed by the regulatory body in relation to this filing.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `penalty_paid_flag` BOOLEAN COMMENT 'Indicates whether any assessed penalty or fine has been paid in full.',
    `penalty_payment_date` DATE COMMENT 'Date on which the assessed penalty or fine was paid to the regulatory body.',
    `regulatory_body` STRING COMMENT 'Name of the government agency, regulatory authority, or supervisory body to which this filing is submitted (e.g., IRS, state tax authority, health department, OSHA, fire marshal, data protection authority).',
    `regulatory_response_date` DATE COMMENT 'Date on which the regulatory body provided a formal response, feedback, or decision regarding this filing.',
    `regulatory_response_received_flag` BOOLEAN COMMENT 'Indicates whether a formal response or feedback has been received from the regulatory body regarding this filing.',
    `regulatory_response_summary` STRING COMMENT 'Summary of the regulatory bodys response, including any comments, requests for correction, or approval notes.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory body rejected the filing due to errors, omissions, or non-compliance.',
    `submission_date` DATE COMMENT 'Date on which the filing was submitted to the regulatory body.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the filing was submitted to the regulatory authority, including timezone information.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was last updated or modified.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Transactional record of regulatory filings, submissions, and reports submitted by Travel Hospitality to government agencies and regulatory bodies. Covers occupancy tax filings, liquor license renewals, health department reports, OSHA 300 log submissions, GDPR supervisory authority notifications, CCPA annual reports, fire marshal reports, and environmental compliance filings. Captures filing reference number, filing type, regulatory body, jurisdiction, property or entity scope, filing period, submission date, filing status (draft, submitted, acknowledged, accepted, rejected, under review), filing agent, and any regulatory response received.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this policy record in the system.',
    `superseded_policy_id` BIGINT COMMENT 'Identifier of the previous policy version that this policy replaces. Null if this is the first version.',
    `tertiary_policy_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this policy record.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether employees must formally acknowledge receipt and understanding of this policy. True if acknowledgment is mandatory.',
    `applicable_scope` STRING COMMENT 'Organizational reach of the policy. applies to all entities; brand-specific applies to a hotel brand; property-specific applies to individual properties; regional applies to geographic regions; departmental applies to specific functions.. Valid values are `enterprise_wide|brand_specific|property_specific|regional|departmental`',
    `approval_authority` STRING COMMENT 'Name and title of the executive, board, or committee that formally approved this policy for implementation.',
    `approval_date` DATE COMMENT 'Date when the policy was formally approved by the designated authority.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this policy to audit logs, compliance assessments, and enforcement actions for traceability.',
    `policy_category` STRING COMMENT 'Primary classification of the policy domain. Categories include data privacy (GDPR/CCPA compliance), health and safety (OSHA, fire safety), anti-bribery (anti-corruption), code of conduct (ethics), liquor service (licensing), food safety (ISO 22000), ADA (accessibility), environmental (sustainability), and information security (PCI DSS).. Valid values are `data_privacy|health_and_safety|anti_bribery|code_of_conduct|liquor_service|food_safety`',
    `contact_email` STRING COMMENT 'Email address of the policy owner or compliance officer for questions, clarifications, and policy-related inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the policy owner or compliance officer for urgent policy-related matters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was first created in the system.',
    `policy_description` STRING COMMENT 'Comprehensive summary of the policy purpose, scope, and key requirements. Provides context for policy application and interpretation.',
    `document_reference_url` STRING COMMENT 'URL or file path to the full policy document stored in the enterprise document management system.',
    `effective_date` DATE COMMENT 'Date when the policy becomes enforceable and binding across the applicable scope.',
    `enforcement_level` STRING COMMENT 'Degree of compliance obligation. Mandatory policies require strict adherence with consequences for non-compliance; recommended policies are best practices; advisory policies provide guidance.. Valid values are `mandatory|recommended|advisory`',
    `expiration_date` DATE COMMENT 'Date when the policy ceases to be in force. Null for policies without a defined end date.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the primary legal jurisdiction governing this policy (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the policy was most recently reviewed for accuracy, relevance, and regulatory alignment.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review to ensure continued compliance and relevance.',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation guidance, exceptions, or special considerations related to this policy.',
    `policy_number` STRING COMMENT 'Business-facing unique policy identifier used for reference and communication across the organization.. Valid values are `^POL-[A-Z]{2,4}-[0-9]{4,6}$`',
    `policy_status` STRING COMMENT 'Current lifecycle state of the policy. Draft indicates policy is being developed; active indicates policy is in force; under review indicates policy is being revised; retired indicates policy is no longer applicable; suspended indicates temporary hold.. Valid values are `draft|active|under_review|retired|suspended`',
    `regulatory_basis` STRING COMMENT 'Primary regulatory framework, statute, or industry standard that mandates or informs this policy (e.g., GDPR Article 32, OSHA 1910.38, PCI DSS 3.2.1, ISO 22000:2018).',
    `related_policy_ids` STRING COMMENT 'Comma-separated list of policy IDs that are related or cross-referenced by this policy for comprehensive compliance understanding.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between mandatory policy reviews as defined by governance requirements.',
    `risk_level` STRING COMMENT 'Assessment of the business and regulatory risk associated with non-compliance with this policy. Critical indicates severe legal or operational consequences.. Valid values are `critical|high|medium|low`',
    `scope_entity_reference` BIGINT COMMENT 'Identifier of the specific brand, property, region, or department to which this policy applies when scope is not. Null for policies.',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the policy category (e.g., guest data protection, employee safety, vendor conduct).',
    `title` STRING COMMENT 'Full official title of the compliance policy as approved by governance authority.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether employees within the applicable scope must complete formal training on this policy. True if training is mandatory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was last modified.',
    `version_number` STRING COMMENT 'Semantic version identifier for the policy document (e.g., 1.0, 2.3) to track revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Internal compliance policy and procedure master record for Travel Hospitality. Captures policy number, policy title, policy category (data privacy, health and safety, anti-bribery, code of conduct, liquor service, food safety, ADA, environmental, information security), policy owner, effective date, review date, next review date, policy status (draft, active, under review, retired), applicable scope (enterprise-wide, brand-specific, property-specific), regulatory basis, version number, and approval authority. Single source of truth for all internal compliance policies and their lifecycle management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` (
    `policy_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the policy acknowledgment record. Primary key for the policy acknowledgment transaction.',
    `compliance_training_completion_id` BIGINT COMMENT 'Reference to the e-learning or training completion record if acknowledgment was captured through training system attestation. Null for non-training acknowledgments.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty program terms & conditions acknowledgments by members (required for tier benefits eligibility, points redemption authorization, data sharing consent) are policy acknowledgments. Essential for ',
    `policy_id` BIGINT COMMENT 'Reference to the compliance policy that was acknowledged. Links to the compliance policy master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who acknowledged the policy. Links to the workforce employee master record.',
    `prior_policy_acknowledgment_id` BIGINT COMMENT 'Self-referencing FK on policy_acknowledgment (prior_policy_acknowledgment_id)',
    `property_id` BIGINT COMMENT 'Reference to the property where the employee was assigned at the time of acknowledgment. Supports property-level compliance reporting and jurisdiction-specific policy tracking.',
    `tertiary_policy_escalated_to_user_employee_id` BIGINT COMMENT 'Reference to the manager or compliance officer to whom the overdue acknowledgment was escalated. Null if no escalation has occurred.',
    `tertiary_quinary_policy_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system process that last modified this acknowledgment record. Supports audit trail and change tracking.',
    `acknowledgment_channel` STRING COMMENT 'The digital or physical channel through which the acknowledgment was captured. Distinguishes between self-service, facilitated, and system-driven acknowledgments.. Valid values are `web_portal|mobile_app|email_link|in_person|training_system|hr_system`',
    `acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged the policy. Represents the business event timestamp when the acknowledgment was completed.',
    `acknowledgment_due_date` DATE COMMENT 'The deadline by which the employee was required to acknowledge the policy. Used to identify overdue acknowledgments and trigger escalations.',
    `acknowledgment_method` STRING COMMENT 'The mechanism through which the employee acknowledged the policy. Indicates whether acknowledgment was captured electronically, physically, or through training completion.. Valid values are `electronic_signature|wet_signature|e_learning_attestation|verbal_confirmation|system_auto_accept`',
    `acknowledgment_record_number` STRING COMMENT 'Business identifier for the acknowledgment transaction. Externally visible unique reference number used in audit trails and compliance reporting.. Valid values are `^ACK-[0-9]{8}-[A-Z0-9]{6}$`',
    `acknowledgment_status` STRING COMMENT 'Current lifecycle status of the policy acknowledgment. Tracks whether the employee has completed, is pending, or has missed the acknowledgment requirement.. Valid values are `pending|completed|overdue|waived|expired`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee completed the policy acknowledgment. Used for audit trail and legal defensibility.',
    `audit_trail_reference` STRING COMMENT 'Reference to external audit trail or document management system records related to this acknowledgment. Supports regulatory audit requirements.',
    `compliance_officer_notes` STRING COMMENT 'Free-text notes added by compliance officers regarding this acknowledgment. Used to document special circumstances, follow-up actions, or audit findings.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this acknowledgment record was first created in the system. Represents the initial capture of the acknowledgment requirement.',
    `department_code` STRING COMMENT 'The department or division to which the employee belonged at the time of acknowledgment. Enables department-level compliance tracking and reporting.. Valid values are `^[A-Z]{2,6}$`',
    `device_type` STRING COMMENT 'The type of device used to submit the acknowledgment. Supports user experience analysis and fraud detection.. Valid values are `desktop|laptop|tablet|mobile|kiosk|unknown`',
    `escalation_level` STRING COMMENT 'The current escalation level for overdue acknowledgments. 0 indicates no escalation, higher numbers indicate progressive escalation to management.',
    `expiration_date` DATE COMMENT 'The date when this acknowledgment expires and requires renewal. Supports periodic re-acknowledgment requirements for ongoing compliance.',
    `ip_address` STRING COMMENT 'The Internet Protocol address from which the acknowledgment was submitted. Captured for audit trail and fraud prevention purposes.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `job_role_code` STRING COMMENT 'The job role or position code of the employee at the time of acknowledgment. Supports role-based policy assignment and compliance analysis.. Valid values are `^[A-Z0-9]{4,8}$`',
    `last_reminder_sent_date` DATE COMMENT 'The date when the most recent reminder notification was sent to the employee. Null if no reminders were sent.',
    `policy_version_acknowledged` STRING COMMENT 'The specific version of the policy that the employee acknowledged. Critical for demonstrating that employees acknowledged the current policy version in effect at the time.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `re_acknowledgment_frequency_days` STRING COMMENT 'The number of days between required re-acknowledgments. Null if re-acknowledgment is not required. Common values include 365 (annual) or 730 (biennial).',
    `re_acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether this policy requires periodic re-acknowledgment. True if the employee must re-acknowledge at regular intervals.',
    `reminder_sent_count` STRING COMMENT 'The number of reminder notifications sent to the employee before acknowledgment was completed. Used to track engagement and escalation effectiveness.',
    `signature_image_reference` STRING COMMENT 'Reference to the stored digital or scanned signature image file. Null for non-signature acknowledgment methods. Points to secure document storage system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acknowledgment record was last modified. Tracks changes to status, notes, or other attributes.',
    `waiver_approval_date` DATE COMMENT 'The date when the waiver was approved. Null if no waiver was granted.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver was granted exempting the employee from acknowledging this policy. True if waiver was approved by compliance officer.',
    `waiver_reason` STRING COMMENT 'Business justification for granting a waiver. Null if no waiver was granted. Required for audit trail when waiver_granted_flag is true.',
    CONSTRAINT pk_policy_acknowledgment PRIMARY KEY(`policy_acknowledgment_id`)
) COMMENT 'Transactional record of employee acknowledgment of compliance policies and codes of conduct. Captures acknowledgment record number, employee reference, policy reference, acknowledgment date, acknowledgment method (electronic signature, wet signature, e-learning attestation), acknowledgment status (pending, completed, overdue, waived), policy version acknowledged, and expiration date for re-acknowledgment. Enables compliance officers to demonstrate that employees have read and accepted key compliance policies, supporting regulatory audits and legal defensibility.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` (
    `third_party_due_diligence_id` BIGINT COMMENT 'Unique identifier for the third-party due diligence assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this due diligence assessment record.',
    `prior_third_party_due_diligence_id` BIGINT COMMENT 'Self-referencing FK on third_party_due_diligence (prior_third_party_due_diligence_id)',
    `property_id` BIGINT COMMENT 'Identifier of the property or corporate entity conducting the due diligence assessment.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hotels perform third-party due diligence on vendors before contracting, screening for sanctions, financial stability, data processing agreements, and cybersecurity. This is a mandatory pre-contracting',
    `adverse_media_flag` BOOLEAN COMMENT 'Boolean flag indicating whether adverse media (negative news, legal issues, corruption allegations) was identified during the assessment.',
    `adverse_media_summary` STRING COMMENT 'Summary of adverse media findings, including sources and nature of concerns identified during screening.',
    `approval_date` DATE COMMENT 'Date when the third-party relationship was formally approved following due diligence assessment.',
    `approval_expiry_date` DATE COMMENT 'Date when the current approval expires and re-assessment is required.',
    `approval_status` STRING COMMENT 'Current approval status of the third-party relationship based on due diligence findings (approved, rejected, conditional approval, pending approval, under review).. Valid values are `approved|rejected|conditional_approval|pending_approval|under_review`',
    `approved_by_name` STRING COMMENT 'Name of the individual or authority who granted final approval for the third-party relationship.',
    `assessment_date` DATE COMMENT 'Date when the due diligence assessment was conducted or completed.',
    `assessment_notes` STRING COMMENT 'Detailed notes and observations from the due diligence assessment, including specific findings, concerns, and recommendations.',
    `assessment_type` STRING COMMENT 'Type of due diligence assessment conducted (anti-bribery/FCPA, sanctions screening, data processor assessment under GDPR Article 28, modern slavery, environmental, financial stability, cybersecurity). [ENUM-REF-CANDIDATE: anti_bribery_fcpa|sanctions_screening|data_processor_assessment|modern_slavery|environmental|financial_stability|cybersecurity — 7 candidates stripped; promote to reference product]',
    `assessor_department` STRING COMMENT 'Department or business unit of the assessor (e.g., Legal, Compliance, Procurement, Risk Management).',
    `assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the due diligence assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this due diligence assessment record was first created in the system.',
    `cybersecurity_assessment_result` STRING COMMENT 'Result of cybersecurity and data security assessment for third-parties with access to Travel Hospitality systems or guest data.. Valid values are `compliant|non_compliant|partially_compliant|not_assessed`',
    `data_processing_agreement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a compliant Data Processing Agreement (DPA) is in place as required by GDPR Article 28.',
    `data_processor_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the third-party acts as a data processor under GDPR Article 28, requiring specific contractual safeguards and assessments.',
    `document_repository_reference` STRING COMMENT 'Reference identifier or path to supporting documentation stored in the document management system (contracts, certificates, screening reports).',
    `dpa_execution_date` DATE COMMENT 'Date when the Data Processing Agreement was executed with the third-party data processor.',
    `due_diligence_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this due diligence assessment for tracking and audit purposes.. Valid values are `^DD-[0-9]{8}-[A-Z0-9]{6}$`',
    `financial_stability_rating` STRING COMMENT 'Assessment of the third-partys financial stability and viability (excellent, good, fair, poor, not assessed).. Valid values are `excellent|good|fair|poor|not_assessed`',
    `insurance_verification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether required insurance coverage (liability, professional indemnity, cyber insurance) has been verified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic due diligence review or re-assessment of the third-party relationship.',
    `pep_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the third-party or its principals are identified as Politically Exposed Persons (PEP), requiring enhanced due diligence.',
    `remediation_actions` STRING COMMENT 'Description of specific remediation actions or corrective measures required to address identified risks or deficiencies.',
    `remediation_completion_date` DATE COMMENT 'Actual date when all required remediation actions were completed and verified.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed.',
    `remediation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether remediation actions or corrective measures are required before the third-party relationship can proceed or continue.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which periodic due diligence reviews must be conducted based on risk rating (e.g., 12 months for low risk, 6 months for high risk).',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the third-party based on the due diligence assessment (high, medium, low, critical).. Valid values are `high|medium|low|critical`',
    `sanctions_list_check_result` STRING COMMENT 'Result of screening against international sanctions lists (OFAC, UN, EU) indicating whether the third-party or its principals appear on any sanctions list.. Valid values are `clear|match_found|potential_match|not_screened`',
    `screening_result` STRING COMMENT 'Overall result of the due diligence screening (pass, fail, conditional approval, pending review).. Valid values are `pass|fail|conditional|pending_review`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this due diligence assessment record was last modified.',
    CONSTRAINT pk_third_party_due_diligence PRIMARY KEY(`third_party_due_diligence_id`)
) COMMENT 'Compliance due diligence assessment record for third-party vendors, contractors, and business partners engaged by Travel Hospitality. Captures due diligence reference number, third-party name and type (vendor, contractor, franchise partner, joint venture), assessment type (anti-bribery/FCPA, sanctions screening, data processor assessment, modern slavery, environmental), assessment date, assessor, risk rating (high, medium, low), screening result (pass, fail, conditional), sanctions list check result, PEP (Politically Exposed Person) flag, adverse media flag, remediation required flag, and approval status. Supports FCPA, UK Bribery Act, and GDPR Article 28 processor obligations.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` (
    `environmental_compliance_id` BIGINT COMMENT 'Unique identifier for the environmental compliance record. Primary key for this entity.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Environmental compliance records track specific permits/licenses. The environmental_compliance table has permit_number, permit_type, permit_status, issuing_authority, jurisdiction, and date fields tha',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this environmental compliance record.',
    `property_id` BIGINT COMMENT 'Reference to the property subject to this environmental compliance obligation.',
    `superseded_environmental_compliance_id` BIGINT COMMENT 'Self-referencing FK on environmental_compliance (superseded_environmental_compliance_id)',
    `carbon_emissions_framework` STRING COMMENT 'The carbon emissions or greenhouse gas reporting framework that this compliance obligation aligns with.. Valid values are `ghg_protocol|cdp|eu_taxonomy|tcfd|sbti|none`',
    `compliance_officer_email` STRING COMMENT 'Email address of the environmental compliance officer responsible for this obligation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `compliance_officer_name` STRING COMMENT 'Name of the property or corporate environmental compliance officer responsible for managing this compliance obligation.',
    `compliance_officer_phone` STRING COMMENT 'Phone number of the environmental compliance officer responsible for this obligation.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions must be completed to address environmental violations or deficiencies.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required to address environmental violations or deficiencies.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions required to address environmental violations or deficiencies.. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental compliance record was first created in the system.',
    `document_reference_number` STRING COMMENT 'Reference number or identifier for supporting documentation, permits, or regulatory correspondence related to this compliance record.',
    `energy_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this permit or compliance obligation requires periodic energy consumption reporting to regulatory authorities.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this environmental compliance record is included in corporate ESG sustainability reporting.',
    `inspection_result` STRING COMMENT 'Outcome of the most recent environmental compliance inspection.. Valid values are `compliant|non_compliant|conditional|pending_review|not_inspected`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent environmental compliance inspection conducted by regulatory authorities.',
    `last_report_submission_date` DATE COMMENT 'Date when the most recent environmental compliance report was submitted to regulatory authorities.',
    `monitoring_frequency` STRING COMMENT 'Required frequency for environmental monitoring, testing, or reporting activities under this compliance obligation.. Valid values are `daily|weekly|monthly|quarterly|annually|as_needed`',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next environmental compliance inspection by regulatory authorities.',
    `next_report_due_date` DATE COMMENT 'Scheduled date for the next environmental compliance report submission to regulatory authorities.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this environmental compliance obligation, inspection, or violation.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed for environmental violations or non-compliance.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the environmental penalty amount.. Valid values are `^[A-Z]{3}$`',
    `permit_conditions` STRING COMMENT 'Specific conditions, restrictions, or operational requirements stipulated in the environmental permit.',
    `sustainability_certification` STRING COMMENT 'Name of any sustainability or environmental certification program this compliance record supports (LEED, Green Key, EarthCheck, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental compliance record was last modified in the system.',
    `violation_date` DATE COMMENT 'Date when the most recent environmental violation or notice of violation was issued.',
    `violation_description` STRING COMMENT 'Detailed description of the environmental violation, including the nature of non-compliance and regulatory citation.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether any environmental violations or notices of violation have been issued against this permit or compliance obligation.',
    `violation_severity` STRING COMMENT 'Classification of the severity level of the environmental violation based on regulatory impact and risk.. Valid values are `minor|moderate|major|critical`',
    `waste_diversion_reporting_flag` BOOLEAN COMMENT 'Indicates whether this permit or compliance obligation requires periodic waste diversion and recycling rate reporting.',
    `water_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this permit or compliance obligation requires periodic water usage reporting to regulatory authorities.',
    CONSTRAINT pk_environmental_compliance PRIMARY KEY(`environmental_compliance_id`)
) COMMENT 'Environmental compliance and sustainability regulatory record for Travel Hospitality properties. Captures environmental permit type (wastewater discharge, air emissions, hazardous waste, stormwater), permit number, issuing environmental authority, jurisdiction, property reference, permit issue date, expiration date, permit status, last environmental inspection date, inspection result, energy consumption reporting obligation flag, water usage reporting obligation flag, waste diversion rate reporting flag, carbon emissions reporting framework (GHG Protocol, CDP, EU Taxonomy), and any environmental violations or notices of violation. Supports ESG regulatory reporting and environmental permit management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` (
    `whistleblower_report_id` BIGINT COMMENT 'Unique identifier for the whistleblower report record. Primary key for the whistleblower report entity.',
    `parent_whistleblower_report_id` BIGINT COMMENT 'Self-referencing FK on whistleblower_report (related_whistleblower_report_id)',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Whistleblower reports often allege violations of specific policies (e.g., Code of Conduct violations, Anti-Harassment Policy violations, Conflict of Interest Policy violations). One report can cite on',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer or investigator assigned to review and investigate the report.',
    `property_id` BIGINT COMMENT 'Identifier of the property or business unit implicated in the report. Links to the property where the alleged incident occurred or is relevant.',
    `tertiary_whistleblower_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or process that last modified the whistleblower report record.',
    `allegation_category` STRING COMMENT 'Primary category of the allegation reported. [ENUM-REF-CANDIDATE: fraud|bribery|harassment|safety_violation|data_misuse|discrimination|retaliation|code_of_conduct_breach|theft|conflict_of_interest|environmental_violation|accounting_irregularity — promote to reference product]. Valid values are `fraud|bribery|harassment|safety_violation|data_misuse|discrimination`',
    `allegation_description` STRING COMMENT 'Detailed narrative description of the allegation as reported by the whistleblower. Contains sensitive information about the reported incident.',
    `allegation_subcategory` STRING COMMENT 'Detailed subcategory or specific type of allegation within the primary category for granular classification and trend analysis.',
    `assigned_investigator_name` STRING COMMENT 'Name of the compliance officer or investigator assigned to the case for tracking and accountability.',
    `audit_committee_notification_date` DATE COMMENT 'Date when the Audit Committee was formally notified about the whistleblower report.',
    `audit_committee_notified_flag` BOOLEAN COMMENT 'Indicates whether the Board Audit Committee was notified about this report, typically for high-severity or financial misconduct cases (True/False).',
    `case_status` STRING COMMENT 'Current status of the whistleblower case in the investigation lifecycle (received, under review, investigation opened, closed substantiated, closed unsubstantiated, closed no action required).. Valid values are `received|under_review|investigation_opened|closed_substantiated|closed_unsubstantiated|closed_no_action`',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the report based on sensitivity and access restrictions (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions, disciplinary measures, or remediation steps taken as a result of the investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the whistleblower report record was first created in the system. Audit trail for record creation.',
    `document_reference_location` STRING COMMENT 'File path or document management system reference where supporting evidence and investigation documentation are stored.',
    `incident_date` DATE COMMENT 'Date when the alleged incident or violation occurred, as reported by the whistleblower. May be approximate or a date range start.',
    `incident_location` STRING COMMENT 'Specific location within the property or business unit where the alleged incident occurred (department, floor, area).',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was completed and findings were documented.',
    `investigation_outcome` STRING COMMENT 'Final outcome of the investigation (substantiated, unsubstantiated, partially substantiated, inconclusive, withdrawn by reporter).. Valid values are `substantiated|unsubstantiated|partially_substantiated|inconclusive|withdrawn`',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation was initiated following initial review and case assignment.',
    `investigation_summary` STRING COMMENT 'Executive summary of the investigation findings, actions taken, and conclusions reached. Contains sensitive investigation details.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the whistleblower report record was last updated. Audit trail for record modifications.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the case is subject to legal hold requirements for litigation or regulatory proceedings (True/False).',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the whistleblower report and investigation process.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the report based on severity, risk, and potential impact (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `regulatory_authority_notified` STRING COMMENT 'Name of the external regulatory authority or law enforcement agency notified about the case, if escalation was required.',
    `regulatory_escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the case requires escalation or reporting to external regulatory authorities (True) or can be handled internally (False).',
    `regulatory_notification_date` DATE COMMENT 'Date when external regulatory authorities were formally notified about the case.',
    `report_channel` STRING COMMENT 'Channel through which the whistleblower report was submitted (hotline, web portal, email, in-person, mail, mobile app).. Valid values are `hotline|web_portal|email|in_person|mail|mobile_app`',
    `report_date` DATE COMMENT 'Date when the whistleblower report was received by the ethics hotline or compliance team. Principal business event timestamp for the report lifecycle.',
    `report_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the whistleblower report for tracking and case management purposes. Format: WB-YYYYMMDD-XXXXXX.. Valid values are `^WB-[0-9]{8}-[A-Z0-9]{6}$`',
    `report_time` TIMESTAMP COMMENT 'Precise timestamp when the whistleblower report was submitted, including time zone information.',
    `reporter_anonymity_flag` BOOLEAN COMMENT 'Indicates whether the whistleblower chose to remain anonymous (True) or provided identifying information (False).',
    `reporter_contact_method` STRING COMMENT 'Contact information provided by the reporter (email, phone, or callback code) for follow-up communication. Null if anonymous.',
    `reporter_name` STRING COMMENT 'Name of the individual who submitted the report, if not anonymous. Null if reporter chose anonymity.',
    `reporter_relationship` STRING COMMENT 'Relationship of the reporter to the organization (employee, contractor, vendor, guest, former employee, other).. Valid values are `employee|contractor|vendor|guest|former_employee|other`',
    `retaliation_concern_flag` BOOLEAN COMMENT 'Indicates whether the reporter expressed concerns about potential retaliation (True/False). Triggers additional monitoring and protection measures.',
    `retention_expiry_date` DATE COMMENT 'Date when the whistleblower report record is eligible for archival or deletion per records retention policy, typically 7 years from case closure.',
    CONSTRAINT pk_whistleblower_report PRIMARY KEY(`whistleblower_report_id`)
) COMMENT 'Confidential whistleblower and ethics hotline report record for Travel Hospitality. Captures report reference number, report channel (hotline, web portal, in-person, email), report date, allegation category (fraud, bribery, harassment, safety violation, data misuse, discrimination, retaliation, code of conduct breach), property or business unit implicated, reporter anonymity flag, case status (received, under review, investigation opened, closed substantiated, closed unsubstantiated), assigned investigator, investigation outcome, and regulatory escalation required flag. Supports Sarbanes-Oxley Section 301 whistleblower obligations and internal ethics governance.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` (
    `sanction_screening_id` BIGINT COMMENT 'Unique identifier for the sanction screening record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Identifier of the corporate account if the screened entity is a corporate account. Null for non-corporate entities.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee if the screened entity is an employee. Null for non-employee entities.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest if the screened entity is a guest. Null for non-guest entities.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the screening was initiated or where the screened entity has a relationship.',
    `rescreened_sanction_screening_id` BIGINT COMMENT 'Self-referencing FK on sanction_screening (rescreened_sanction_screening_id)',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: AML/sanctions screening must be performed on bookings from high-risk jurisdictions, sanctioned entities, or flagged guests. Hotels need to link screening results to specific bookings for compliance do',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer or employee who manually reviewed the screening result. Null if no manual review was performed.',
    `sanction_employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that created this screening record.',
    `sanction_updated_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that last updated this screening record.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: AML/sanctions screening of high-value loyalty members (large points transfers, suspicious redemption patterns, partner program transfers) requires member reference for risk assessment and regulatory r',
    `third_party_due_diligence_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_due_diligence. Business justification: Sanctions screening is a component of third-party due diligence for vendors, contractors, and business partners. One due diligence assessment includes one or more sanctions screenings. This FK allows ',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor if the screened entity is a vendor or supplier. Null for non-vendor entities.',
    `business_relationship_status` STRING COMMENT 'Current status of the business relationship with the screened entity following the screening result: active (approved to continue), suspended (temporarily halted), terminated (permanently ended), or pending approval.. Valid values are `active|suspended|terminated|pending_approval`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanction screening record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or module from which the entity data was extracted for screening (e.g., OPERA PMS Guest Profiles, Salesforce CRM, SAP S/4HANA Vendor Master).',
    `escalation_date` DATE COMMENT 'Date when the screening result was escalated to senior compliance management or legal counsel. Null if no escalation occurred.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this screening result requires escalation to senior compliance management or legal counsel due to high risk or complexity.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code or jurisdiction identifier where the screening was performed or where the entity operates, relevant for jurisdiction-specific sanctions compliance.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0.00 to 100.00) indicating the likelihood that the screened entity matches a watchlist entry, generated by the screening system algorithm.',
    `match_disposition` STRING COMMENT 'Final disposition status of the screening result after review: cleared (approved to proceed), escalated (sent to compliance officer), blocked (transaction/relationship prohibited), under review, or false positive.. Valid values are `cleared|escalated|blocked|under_review|false_positive`',
    `match_result` STRING COMMENT 'Outcome of the screening indicating whether the entity matched any watchlist entries: no match, potential match requiring review, or confirmed match.. Valid values are `no_match|potential_match|confirmed_match`',
    `matched_entry_reference` STRING COMMENT 'Reference number or identifier of the specific watchlist entry that matched or potentially matched the screened entity. Null if no match.',
    `matched_list_name` STRING COMMENT 'Name of the specific sanctions or watchlist where a match or potential match was identified. Null if no match.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic re-screening of this entity against updated sanctions and watchlists, as required by AML compliance policy.',
    `regulatory_report_date` DATE COMMENT 'Date when the screening result was reported to regulatory authorities. Null if no reporting was required or not yet reported.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report filed (e.g., SAR filing number). Null if no report was filed.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this screening result requires reporting to regulatory authorities (e.g., FinCEN SAR filing for confirmed matches).',
    `review_date` DATE COMMENT 'Date when the manual review of the screening result was completed. Null if no manual review was performed.',
    `review_notes` STRING COMMENT 'Detailed notes and rationale documented by the reviewer explaining the disposition decision, including any supporting evidence or justification for clearing or blocking the entity.',
    `reviewer_name` STRING COMMENT 'Full name of the compliance officer or employee who reviewed the screening result. Null if no manual review was performed.',
    `risk_level` STRING COMMENT 'Overall risk level assigned to this screening result based on match confidence, entity type, and business context: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `screened_by_system` STRING COMMENT 'Name or identifier of the automated screening system or platform that performed the sanction check (e.g., Salesforce CRM screening module, third-party AML platform).',
    `screened_entity_name` STRING COMMENT 'Full name of the individual, corporate account, vendor, or business partner being screened against sanctions and watchlists.',
    `screened_entity_type` STRING COMMENT 'Classification of the entity being screened: guest, corporate account, vendor, employee, business partner, or third-party.. Valid values are `guest|corporate_account|vendor|employee|business_partner|third_party`',
    `screening_date` DATE COMMENT 'Date when the sanction screening was performed against regulatory watchlists.',
    `screening_lists_checked` STRING COMMENT 'Comma-separated list of regulatory watchlists checked during this screening event (e.g., OFAC SDN, EU Consolidated Sanctions List, UN Security Council Sanctions, INTERPOL, national lists).',
    `screening_method` STRING COMMENT 'Method used to perform the screening: automated system, manual review, or hybrid approach combining both.. Valid values are `automated|manual|hybrid`',
    `screening_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this sanction screening event for audit trail and regulatory reporting purposes.',
    `screening_status` STRING COMMENT 'Current lifecycle status of the screening record: completed (final disposition reached), in progress (screening underway), pending review (awaiting manual review), or expired (requires re-screening).. Valid values are `completed|in_progress|pending_review|expired`',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the sanction screening was executed, including time zone information.',
    `screening_trigger` STRING COMMENT 'Event or condition that triggered this sanction screening: new entity onboarding, periodic review, transaction threshold exceeded, regulatory watchlist update, or manual compliance request.. Valid values are `new_entity|periodic_review|transaction_threshold|regulatory_update|manual_request`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sanction screening record was last modified or updated.',
    CONSTRAINT pk_sanction_screening PRIMARY KEY(`sanction_screening_id`)
) COMMENT 'Sanctions and watchlist screening record for guests, corporate accounts, vendors, and business partners screened against OFAC SDN, EU Consolidated Sanctions List, UN Security Council Sanctions, and other regulatory watchlists. Captures screening reference number, screened entity name and type (guest, corporate account, vendor, employee), screening date, screening list(s) checked, match result (no match, potential match, confirmed match), match confidence score, match disposition (cleared, escalated, blocked), screened by (automated system, manual review), reviewer name, and regulatory reporting required flag. Supports AML, OFAC compliance, and anti-terrorism financing obligations in hospitality.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` (
    `compliance_calendar_id` BIGINT COMMENT 'Unique identifier for the compliance calendar entry. Primary key for the compliance calendar product.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Scheduled compliance audits (internal audits, regulatory inspections, certification audits) appear on the compliance calendar as obligations with due dates. One audit has one calendar entry. This FK a',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this compliance calendar entry. Provides audit trail for data governance.',
    `compliance_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this compliance calendar entry. Provides audit trail for data governance.',
    `obligation_id` BIGINT COMMENT 'Reference to the parent compliance obligation record in the compliance obligation product. Establishes traceability between calendar entries and master obligation records.',
    `permit_id` BIGINT COMMENT 'Reference to the associated permit record if this calendar entry relates to permit renewal or permit-related compliance activity.',
    `primary_compliance_responsible_owner_employee_id` BIGINT COMMENT 'Reference to the employee who is accountable for ensuring timely completion of this compliance obligation. Links to workforce master data.',
    `property_id` BIGINT COMMENT 'Reference to the property or corporate entity to which this compliance obligation applies. Links to the property master data.',
    `recurring_source_compliance_calendar_id` BIGINT COMMENT 'Self-referencing FK on compliance_calendar (recurring_source_compliance_calendar_id)',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Regulatory filing deadlines appear on the compliance calendar as obligations with due dates. One filing has one calendar entry. This FK allows tracking which calendar obligations represent filing dead',
    `marketing_calendar_id` BIGINT COMMENT '',
    `completion_date` DATE COMMENT 'Actual date when the compliance obligation was fulfilled or completed. Null for upcoming or in-progress obligations.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the compliance calendar entry. Tracks progress from upcoming through completion or waiver.. Valid values are `upcoming|in_progress|overdue|completed|waived|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance calendar entry was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amount.. Valid values are `^[A-Z]{3}$`',
    `document_repository_reference` STRING COMMENT 'Reference identifier or path to the location where supporting documents for this compliance obligation are stored in the document management system.',
    `due_date` DATE COMMENT 'The date by which the compliance obligation must be completed to avoid regulatory lapse or penalty. Critical for proactive compliance management.',
    `escalation_date` DATE COMMENT 'Date when this compliance obligation was escalated to higher authority. Tracks escalation timeline for governance reporting.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this compliance obligation requires escalation to senior management or executive leadership for awareness or approval.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated financial cost to complete this compliance obligation including fees, external services, and internal resource costs.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this compliance obligation. Used for resource planning and workload management.',
    `jurisdiction_code` STRING COMMENT 'Geographic or regulatory jurisdiction code under which this compliance obligation falls. May be country, state, province, or local authority code.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance calendar entry was last updated. Tracks most recent change for audit and synchronization purposes.',
    `last_notification_date` DATE COMMENT 'Date when the most recent notification or reminder was sent to responsible parties regarding this compliance obligation.',
    `lead_time_alert_days` STRING COMMENT 'Number of days before the due date when alerts and notifications should be triggered to responsible parties. Enables proactive compliance management.',
    `notes` STRING COMMENT 'Free-form notes and comments regarding this compliance calendar entry. May include special instructions, historical context, or coordination details.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether alert notifications have been sent to responsible parties for this compliance calendar entry.',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation including specific requirements, deliverables, and any special instructions or conditions.',
    `obligation_reference_number` STRING COMMENT 'Business identifier for the compliance calendar entry. May reference external permit numbers, regulatory filing codes, or internal tracking identifiers.',
    `obligation_title` STRING COMMENT 'Short descriptive title of the compliance obligation for display and reporting purposes.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation. Defines the nature of the calendar entry and determines workflow and escalation rules. [ENUM-REF-CANDIDATE: permit_renewal|regulatory_filing|audit|training_deadline|policy_review|inspection|reporting_deadline — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to this compliance obligation based on risk, regulatory impact, and business criticality.. Valid values are `critical|high|medium|low`',
    `recurrence_pattern` STRING COMMENT 'Frequency with which this compliance obligation recurs. Determines whether the calendar entry is a one-time event or repeating obligation. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|semi_annual|annual|biennial — 8 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body, government agency, or authority that mandates this compliance obligation.',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for managing and completing this compliance obligation.',
    `risk_level` STRING COMMENT 'Assessment of the risk exposure if this compliance obligation is not met on time. Considers regulatory penalties, operational impact, and reputational risk.. Valid values are `critical|high|medium|low`',
    `scope_level` STRING COMMENT 'Organizational scope of the compliance obligation. Indicates whether the obligation applies to a single property, corporate entity, regional group, brand, or entire portfolio.. Valid values are `property|corporate|regional|brand|portfolio`',
    `supporting_documents_required` STRING COMMENT 'List or description of supporting documentation required to complete this compliance obligation such as certificates, reports, or attestations.',
    `waiver_expiry_date` DATE COMMENT 'Date when the granted waiver expires and the compliance obligation becomes active again. Null for permanent waivers.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exemption was granted for this compliance obligation by the regulatory authority or internal governance.',
    `waiver_reason` STRING COMMENT 'Explanation or justification for why a waiver was granted for this compliance obligation. Required when waiver flag is true.',
    CONSTRAINT pk_compliance_calendar PRIMARY KEY(`compliance_calendar_id`)
) COMMENT 'Master compliance calendar and obligation schedule for Travel Hospitality properties and corporate entities. Captures calendar entry reference, obligation type (permit renewal, regulatory filing, audit, training deadline, policy review, inspection, reporting deadline), property or entity scope, due date, lead time alert days, responsible owner, recurrence pattern (one-time, monthly, quarterly, annual), linked obligation or permit reference, completion status (upcoming, overdue, completed, waived), and completion date. Enables proactive compliance management by surfacing upcoming deadlines and preventing regulatory lapses across the portfolio. SSOT: defers to marketing.marketing_calendar (MVM). [SSOT_OWNER] [SSOT MASTER for group compliance.compliance_calendar] [SSOT:calendar] Canonical single-source-of-truth for the calendar concept; other domain variants are domain-specific specializations referencing this owner.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Primary key for regulatory_requirement',
    `parent_regulatory_requirement_id` BIGINT COMMENT 'Self-referencing FK on regulatory_requirement (parent_regulatory_requirement_id)',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - regulatory requirements vary by jurisdiction/property.',
    `regulatory_superseded_by_requirement_id` BIGINT COMMENT 'Identifier of the regulatory requirement that supersedes or replaces this requirement. Null if not superseded.',
    `applicability_scope` STRING COMMENT 'Description of which properties, business units, or operations are subject to this requirement (e.g., all properties, luxury segment only, properties with food service).',
    `certification_required` BOOLEAN COMMENT 'Indicates whether a formal certification or license is required to demonstrate compliance (True/False).',
    `certification_type` STRING COMMENT 'Type of certification or license required (e.g., ServSafe, liquor license, fire marshal certificate, ADA compliance certificate).',
    `compliance_obligation` STRING COMMENT 'Specific actions or conditions that must be met to satisfy the regulatory requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory requirement record was first created in the system.',
    `regulatory_requirement_description` STRING COMMENT 'Detailed description of the regulatory requirement, including what is mandated and the scope of applicability.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether formal documentation or records must be maintained to demonstrate compliance (True/False).',
    `effective_date` DATE COMMENT 'Date when the regulatory requirement becomes enforceable and binding.',
    `expiration_date` DATE COMMENT 'Date when the regulatory requirement ceases to be enforceable. Null for requirements with no defined end date.',
    `inspection_frequency` STRING COMMENT 'Required frequency of inspections or audits to verify compliance (annual, semi-annual, quarterly, monthly, on-demand, event-driven).',
    `issuing_authority` STRING COMMENT 'Name of the governmental or regulatory body that issued the requirement (e.g., European Commission, OSHA, ADA, FDA, state liquor board).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where the requirement applies (e.g., USA, California, European Union, United Kingdom).',
    `jurisdiction_level` STRING COMMENT 'Level of government or regulatory authority (international, federal, national, state, provincial, local, municipal).',
    `last_review_date` DATE COMMENT 'Date when the regulatory requirement was last reviewed or assessed for applicability and accuracy.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty or fine amount that can be imposed for non-compliance, in the currency specified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reassessment of the regulatory requirement.',
    `notes` STRING COMMENT 'Additional notes, comments, or internal guidance related to the regulatory requirement.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, or sanctions that may be imposed for non-compliance.',
    `property_segment` STRING COMMENT 'Hotel or property segment to which the requirement applies (all, luxury, premium, select-service, resort, extended-stay).',
    `record_retention_years` STRING COMMENT 'Number of years that compliance records must be retained as mandated by the requirement.',
    `reference_url` STRING COMMENT 'Web link to the official text or authoritative source of the regulatory requirement.',
    `regulation_section` STRING COMMENT 'Specific section, article, or clause within the source regulation that defines this requirement.',
    `regulatory_requirement_status` STRING COMMENT 'Current lifecycle status of the regulatory requirement (active, inactive, pending, superseded, repealed, draft).',
    `renewal_period_months` STRING COMMENT 'Number of months between required renewals of certification or compliance verification. Null if no renewal is required.',
    `requirement_code` STRING COMMENT 'Externally-known unique code or reference number for the regulatory requirement (e.g., GDPR-ART-6, OSHA-1910.38, ADA-Title-III).',
    `requirement_name` STRING COMMENT 'Human-readable name or title of the regulatory requirement.',
    `requirement_type` STRING COMMENT 'Categorical classification of the regulatory requirement domain (e.g., data privacy, health and safety, accessibility, fire safety, food safety, liquor licensing, environmental, labor, financial, building code).',
    `responsible_department` STRING COMMENT 'Internal department or function responsible for ensuring compliance with this requirement (e.g., Legal, Risk Management, Operations, Human Resources).',
    `risk_category` STRING COMMENT 'Category of risk associated with non-compliance (operational, financial, reputational, legal, safety, environmental).',
    `severity_level` STRING COMMENT 'Risk severity level associated with non-compliance (critical, high, medium, low).',
    `source_regulation` STRING COMMENT 'Name or citation of the parent regulation, statute, or legal framework from which this requirement derives (e.g., GDPR, OSHA 1910, ADA Title III, CCPA).',
    `training_frequency` STRING COMMENT 'Required frequency of employee training to maintain compliance (annual, biennial, one-time, as-needed).',
    `training_required` BOOLEAN COMMENT 'Indicates whether employee training is mandated by the requirement (True/False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory requirement record was last modified.',
    `version_number` STRING COMMENT 'Version or revision number of the regulatory requirement, used to track changes over time.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master reference table for regulatory_requirement. Referenced by regulatory_requirement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_superseded_obligation_id` FOREIGN KEY (`superseded_obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_renewed_permit_id` FOREIGN KEY (`renewed_permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ADD CONSTRAINT `fk_compliance_permit_renewal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ADD CONSTRAINT `fk_compliance_permit_renewal_prior_permit_renewal_id` FOREIGN KEY (`prior_permit_renewal_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal`(`permit_renewal_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_parent_audit_finding_id` FOREIGN KEY (`parent_audit_finding_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_follow_up_corrective_action_id` FOREIGN KEY (`follow_up_corrective_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_whistleblower_report_id` FOREIGN KEY (`whistleblower_report_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report`(`whistleblower_report_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_parent_health_safety_incident_id` FOREIGN KEY (`parent_health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_escalated_incident_investigation_id` FOREIGN KEY (`escalated_incident_investigation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_whistleblower_report_id` FOREIGN KEY (`whistleblower_report_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report`(`whistleblower_report_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_parent_privacy_incident_id` FOREIGN KEY (`parent_privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_superseded_dpia_id` FOREIGN KEY (`superseded_dpia_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_renewed_food_safety_cert_id` FOREIGN KEY (`renewed_food_safety_cert_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`(`food_safety_cert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ADD CONSTRAINT `fk_compliance_fire_safety_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ADD CONSTRAINT `fk_compliance_fire_safety_record_prior_fire_safety_record_id` FOREIGN KEY (`prior_fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_prior_ada_assessment_id` FOREIGN KEY (`prior_ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_retake_compliance_training_completion_id` FOREIGN KEY (`retake_compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_parent_risk_register_id` FOREIGN KEY (`parent_risk_register_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_amended_regulatory_filing_id` FOREIGN KEY (`amended_regulatory_filing_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_environmental_compliance_id` FOREIGN KEY (`environmental_compliance_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`(`environmental_compliance_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_prior_policy_acknowledgment_id` FOREIGN KEY (`prior_policy_acknowledgment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment`(`policy_acknowledgment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_prior_third_party_due_diligence_id` FOREIGN KEY (`prior_third_party_due_diligence_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_superseded_environmental_compliance_id` FOREIGN KEY (`superseded_environmental_compliance_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`(`environmental_compliance_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ADD CONSTRAINT `fk_compliance_whistleblower_report_parent_whistleblower_report_id` FOREIGN KEY (`parent_whistleblower_report_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report`(`whistleblower_report_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ADD CONSTRAINT `fk_compliance_whistleblower_report_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_rescreened_sanction_screening_id` FOREIGN KEY (`rescreened_sanction_screening_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`(`sanction_screening_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_recurring_source_compliance_calendar_id` FOREIGN KEY (`recurring_source_compliance_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar`(`compliance_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_parent_regulatory_requirement_id` FOREIGN KEY (`parent_regulatory_requirement_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_superseded_by_requirement_id` FOREIGN KEY (`regulatory_superseded_by_requirement_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `superseded_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Obligation Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `superseded_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `tertiary_obligation_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `tertiary_obligation_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `tertiary_obligation_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `applicable_department` SET TAGS ('dbx_business_glossary_term' = 'Applicable Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|under_review|not_assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction_notes` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|pending|waived|expired|suspended|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `renewed_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Permit Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `renewed_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `holder_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `holder_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|individual|government_entity');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|as_needed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|pending_approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `permit_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `prior_permit_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Permit Renewal Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `prior_permit_renewal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Coordinator Employee Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `auto_renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|pending|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `issuing_authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_conditions` SET TAGS ('dbx_business_glossary_term' = 'Renewal Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Duration in Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_request_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Request Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `renewal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Submission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `supporting_documents_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Checklist Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ALTER COLUMN `supporting_documents_checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|incomplete|verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Audit Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed|passed_with_conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|brand_standard|regulatory|third_party|ada_accessibility|fire_safety');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Auditor Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `compliance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `compliance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Executive Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Audit Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Property Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Property Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `property_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `parent_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `parent_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `certification_impact` SET TAGS ('dbx_business_glossary_term' = 'Certification Impact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `certification_impact` SET TAGS ('dbx_value_regex' = 'none|warning|suspension_risk|revocation_risk');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `compliance_domain` SET TAGS ('dbx_business_glossary_term' = 'Compliance Domain');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `external_auditor_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}-[0-9]{2,4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|closed|disputed|deferred');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `guest_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_standard_violated` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Violated');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `follow_up_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Corrective Action Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `follow_up_corrective_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Note Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `whistleblower_report_id` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Report Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in-progress|pending-verification|closed|overdue|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly-effective|effective|partially-effective|ineffective|not-yet-assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `evidence_of_completion` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `recurrence_detected` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Detected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document-review|on-site-inspection|testing|audit|observation|interview');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Incident ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Group Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `parent_health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Health Safety Incident Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `parent_health_safety_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `parent_health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `parent_health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `tertiary_health_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `tertiary_health_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `tertiary_health_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `corrective_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `immediate_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Actions Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_report_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|closed|pending_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'slip_and_fall|food_illness|pool_accident|fire|chemical_exposure|assault');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'none|minor|serious|critical|fatality');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `involved_party_name` SET TAGS ('dbx_business_glossary_term' = 'Involved Party Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `involved_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `involved_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `liability_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Liability Claim Filed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `location_within_property` SET TAGS ('dbx_business_glossary_term' = 'Location Within Property');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Facility Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_treatment_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Provided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_treatment_provided_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `medical_treatment_provided_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `person_type_involved` SET TAGS ('dbx_business_glossary_term' = 'Person Type Involved');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `person_type_involved` SET TAGS ('dbx_value_regex' = 'guest|employee|contractor|vendor|visitor|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `restricted_work_days` SET TAGS ('dbx_business_glossary_term' = 'Restricted Work Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `witness_information` SET TAGS ('dbx_business_glossary_term' = 'Witness Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `witness_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `workers_compensation_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `workers_compensation_claim_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ALTER COLUMN `workers_compensation_claim_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `escalated_incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated Incident Investigation Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `escalated_incident_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `tertiary_incident_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `tertiary_incident_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `tertiary_incident_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `whistleblower_report_id` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Report Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Investigation Confidentiality Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `external_investigator_firm` SET TAGS ('dbx_business_glossary_term' = 'External Investigator Firm Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `insurance_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'routine|elevated|urgent|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_reference_number` SET TAGS ('dbx_value_regex' = '^INV-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Document Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|closed|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'internal|regulatory|insurance|legal|third_party|joint');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `recommended_preventive_measures` SET TAGS ('dbx_business_glossary_term' = 'Recommended Preventive Measures');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `regulatory_body_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `regulatory_inspection_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Conducted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `regulatory_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `root_cause_determination` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Determination');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Investigation Severity Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Consent Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `parent_privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Privacy Incident Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `parent_privacy_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Owner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `tertiary_privacy_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `tertiary_privacy_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `tertiary_privacy_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `confirmed_subjects_affected` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Data Subjects Affected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `containment_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_categories_affected` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Affected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'internal_audit|system_alert|employee_report|guest_complaint|third_party_notification|regulatory_inquiry');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `dpo_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `dpo_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `estimated_subjects_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Data Subjects Affected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_value_regex' = '^PI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|contained|remediated|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'data_breach|unauthorized_access|data_loss|improper_disclosure|subject_rights_violation|system_compromise');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `jurisdictions_impacted` SET TAGS ('dbx_business_glossary_term' = 'Jurisdictions Impacted');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `legal_counsel_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Engaged Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `litigation_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Filed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Sent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_penalty_imposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Imposed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `remediation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `subject_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Subject Notification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `subject_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Subject Notification Sent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `superseded_dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Dpia Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `superseded_dpia_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'DPIA Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|requires_revision');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `automated_decision_logic` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Logic');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `automated_decision_making_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision-Making Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `cross_border_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `data_subject_consultation_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Consultation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `data_subject_consultation_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `data_subject_consultation_summary` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Consultation Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `data_subject_consultation_summary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'DPO Consultation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_consultation_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `dpo_recommendation` SET TAGS ('dbx_business_glossary_term' = 'DPO Recommendation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `identified_privacy_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Privacy Risks');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Measures');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Necessity Assessment');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DPIA Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `processing_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `processing_activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'DPIA Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^DPIA-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|acceptable');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `special_category_justification` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_consultation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `supervisory_authority_response` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `transfer_safeguards` SET TAGS ('dbx_business_glossary_term' = 'Transfer Safeguards');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `food_safety_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `renewed_food_safety_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Food Safety Cert Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `renewed_food_safety_cert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `tertiary_food_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `tertiary_food_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `tertiary_food_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `corrective_actions_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `corrective_actions_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_grade` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_grade` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Health Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Violations Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression System Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `prior_fire_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Fire Safety Record Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `prior_fire_safety_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `alarm_system_last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Alarm System Last Test Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `alarm_system_next_test_date` SET TAGS ('dbx_business_glossary_term' = 'Alarm System Next Test Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_inspection|under_remediation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `emergency_lighting_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Lighting Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `evacuation_plan_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Evacuation Plan Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `evacuation_plan_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Evacuation Plan Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `exit_signage_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Exit Signage Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `extinguisher_last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Extinguisher Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `extinguisher_next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Extinguisher Next Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_alarm_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Alarm System Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_alarm_system_type` SET TAGS ('dbx_value_regex' = 'conventional|addressable|wireless|hybrid|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_door_count` SET TAGS ('dbx_business_glossary_term' = 'Fire Door Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_door_last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Door Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_drill_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Fire Drill Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_drill_last_conducted_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Drill Last Conducted Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_drill_next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Drill Next Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_extinguisher_count` SET TAGS ('dbx_business_glossary_term' = 'Fire Extinguisher Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `insurance_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Notification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fire Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Record Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `outstanding_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Fire Code Violations Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Remediation Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Responsible Person Contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Responsible Person Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `sprinkler_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sprinkler Coverage Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `suppression_system_last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Suppression System Last Test Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `suppression_system_next_test_date` SET TAGS ('dbx_business_glossary_term' = 'Suppression System Next Test Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `violation_details` SET TAGS ('dbx_business_glossary_term' = 'Fire Code Violation Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `violation_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ALTER COLUMN `violation_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` SET TAGS ('dbx_subdomain' = 'safety_privacy');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Assessment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `prior_ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Ada Assessment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `prior_ada_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_value_regex' = '^ADA-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_scope_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|complaint_triggered|renovation_triggered|acquisition_due_diligence|post_remediation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_credentials` SET TAGS ('dbx_business_glossary_term' = 'Assessor Credentials');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `barriers_pending_remediation_count` SET TAGS ('dbx_business_glossary_term' = 'Barriers Pending Remediation Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `barriers_remediated_count` SET TAGS ('dbx_business_glossary_term' = 'Barriers Remediated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `complaint_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|substantially_compliant|partially_compliant|non_compliant|under_remediation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `entrances_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Entrances Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `fitness_facilities_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Fitness Facilities Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `guest_rooms_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Rooms Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `high_priority_barriers_count` SET TAGS ('dbx_business_glossary_term' = 'High Priority Barriers Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `meeting_spaces_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Meeting Spaces Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `parking_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Parking Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `pools_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Pools Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `public_areas_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Areas Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Remediation Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `restaurants_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Restaurants Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `restrooms_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Restrooms Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `signage_evaluated_flag` SET TAGS ('dbx_business_glossary_term' = 'Signage Evaluated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `total_barriers_identified` SET TAGS ('dbx_business_glossary_term' = 'Total Barriers Identified');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_subdomain' = 'policy_training');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_concept' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_group' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_canonical' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `retake_compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Retake Compliance Training Completion Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `retake_compliance_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `tertiary_compliance_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `tertiary_compliance_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `tertiary_compliance_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_ssot_owner' = 'workforce.workforce_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_ssot_entity' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `completion_record_number` SET TAGS ('dbx_business_glossary_term' = 'Completion Record Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|not_started|in_progress|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|blended|virtual_instructor_led|self_paced|on_the_job');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Training Score Achieved');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `parent_risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Risk Register Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `parent_risk_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Risk Owner Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `escalation_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `mitigation_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Cost Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `related_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `residual_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Alignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_value_regex' = 'within_appetite|exceeds_appetite|below_appetite');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'regulatory|health_and_safety|data_privacy|reputational|financial|operational');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|mitigated|accepted|closed|escalated');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'property|brand|region|portfolio|enterprise');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `amended_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Regulatory Filing Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `amended_regulatory_filing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_business_glossary_term' = 'Filing Agent Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Agent Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_phone` SET TAGS ('dbx_business_glossary_term' = 'Filing Agent Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_agent_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|fax|in_person|api_integration');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_assessed_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `penalty_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_response_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Received Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'policy_training');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `tertiary_policy_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `tertiary_policy_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `tertiary_policy_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `applicable_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `applicable_scope` SET TAGS ('dbx_value_regex' = 'enterprise_wide|brand_specific|property_specific|regional|departmental');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_value_regex' = 'data_privacy|health_and_safety|anti_bribery|code_of_conduct|liquor_service|food_safety');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|advisory');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^POL-[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|retired|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `related_policy_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Identifiers (IDs)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `scope_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Scope Entity Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Policy Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_subdomain' = 'policy_training');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `prior_policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Policy Acknowledgment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `prior_policy_acknowledgment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_escalated_to_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_escalated_to_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_escalated_to_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_quinary_policy_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_quinary_policy_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `tertiary_quinary_policy_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_channel` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|email_link|in_person|training_system|hr_system');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|wet_signature|e_learning_attestation|verbal_confirmation|system_auto_accept');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_record_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Record Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_record_number` SET TAGS ('dbx_value_regex' = '^ACK-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue|waived|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `compliance_officer_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|kiosk|unknown');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `job_role_code` SET TAGS ('dbx_business_glossary_term' = 'Job Role Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `job_role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_version_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Acknowledged');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `policy_version_acknowledged` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `re_acknowledgment_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Re-Acknowledgment Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `re_acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Acknowledgment Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `reminder_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Due Diligence ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `prior_third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Third Party Due Diligence Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `prior_third_party_due_diligence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `adverse_media_summary` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `adverse_media_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|pending_approval|under_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessor_department` SET TAGS ('dbx_business_glossary_term' = 'Assessor Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `cybersecurity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Assessment Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `cybersecurity_assessment_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|not_assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `data_processing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `data_processor_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Processor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `dpa_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Execution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `due_diligence_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `due_diligence_reference_number` SET TAGS ('dbx_value_regex' = '^DD-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `financial_stability_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `financial_stability_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `insurance_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `remediation_actions` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_list_check_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Check Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `sanctions_list_check_result` SET TAGS ('dbx_value_regex' = 'clear|match_found|potential_match|not_screened');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `superseded_environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Environmental Compliance Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `superseded_environmental_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `carbon_emissions_framework` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions Reporting Framework');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `carbon_emissions_framework` SET TAGS ('dbx_value_regex' = 'ghg_protocol|cdp|eu_taxonomy|tcfd|sbti|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Officer Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Officer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Officer Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Document Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `energy_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Reporting Obligation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Environmental Inspection Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_review|not_inspected');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Environmental Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Environmental Report Submission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|as_needed');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Environmental Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Environmental Report Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Violation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Violation Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Violation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Violation Severity');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `waste_diversion_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Diversion Rate Reporting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ALTER COLUMN `water_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Reporting Obligation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` SET TAGS ('dbx_subdomain' = 'policy_training');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `whistleblower_report_id` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Report ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `parent_whistleblower_report_id` SET TAGS ('dbx_business_glossary_term' = 'Related Whistleblower Report Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `parent_whistleblower_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `tertiary_whistleblower_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `tertiary_whistleblower_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `tertiary_whistleblower_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `allegation_category` SET TAGS ('dbx_business_glossary_term' = 'Allegation Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `allegation_category` SET TAGS ('dbx_value_regex' = 'fraud|bribery|harassment|safety_violation|data_misuse|discrimination');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `allegation_description` SET TAGS ('dbx_business_glossary_term' = 'Allegation Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `allegation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `allegation_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Allegation Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `assigned_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `audit_committee_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `audit_committee_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'received|under_review|investigation_opened|closed_substantiated|closed_unsubstantiated|closed_no_action');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `document_reference_location` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|partially_substantiated|inconclusive|withdrawn');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `regulatory_escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_channel` SET TAGS ('dbx_business_glossary_term' = 'Report Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_channel` SET TAGS ('dbx_value_regex' = 'hotline|web_portal|email|in_person|mail|mobile_app');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_value_regex' = '^WB-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `report_time` SET TAGS ('dbx_business_glossary_term' = 'Report Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_anonymity_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporter Anonymity Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_contact_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_contact_method` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_relationship` SET TAGS ('dbx_business_glossary_term' = 'Reporter Relationship');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `reporter_relationship` SET TAGS ('dbx_value_regex' = 'employee|contractor|vendor|guest|former_employee|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `retaliation_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Retaliation Concern Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` SET TAGS ('dbx_subdomain' = 'policy_training');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Screening ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `rescreened_sanction_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Rescreened Sanction Screening Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `rescreened_sanction_screening_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `sanction_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Due Diligence Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `business_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Business Relationship Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `business_relationship_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `match_disposition` SET TAGS ('dbx_business_glossary_term' = 'Match Disposition');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `match_disposition` SET TAGS ('dbx_value_regex' = 'cleared|escalated|blocked|under_review|false_positive');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_value_regex' = 'no_match|potential_match|confirmed_match');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `matched_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Matched Entry Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `matched_list_name` SET TAGS ('dbx_business_glossary_term' = 'Matched List Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_by_system` SET TAGS ('dbx_business_glossary_term' = 'Screened By System');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_value_regex' = 'guest|corporate_account|vendor|employee|business_partner|third_party');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_lists_checked` SET TAGS ('dbx_business_glossary_term' = 'Screening Lists Checked');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|pending_review|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_trigger` SET TAGS ('dbx_business_glossary_term' = 'Screening Trigger');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `screening_trigger` SET TAGS ('dbx_value_regex' = 'new_entity|periodic_review|transaction_threshold|regulatory_update|manual_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_subdomain' = 'audit_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_reference' = 'marketing.marketing_calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_concept' = 'calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_group' = 'calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_canonical' = 'compliance.compliance_calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Obligation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Permit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `primary_compliance_responsible_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `primary_compliance_responsible_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `primary_compliance_responsible_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `recurring_source_compliance_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Source Compliance Calendar Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `recurring_source_compliance_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `marketing_calendar_id` SET TAGS ('dbx_ssot_owner' = 'marketing.marketing_calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `marketing_calendar_id` SET TAGS ('dbx_ssot_entity' = 'calendar');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|overdue|completed|waived|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `last_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `lead_time_alert_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Alert Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `obligation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'property|corporate|regional|brand|portfolio');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `supporting_documents_required` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parent_regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Regulatory Requirement Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parent_regulatory_requirement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_superseded_by_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Requirement Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `property_segment` SET TAGS ('dbx_business_glossary_term' = 'Property Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reference_url` SET TAGS ('dbx_business_glossary_term' = 'Reference Url');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Regulation Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `renewal_period_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Period Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `source_regulation` SET TAGS ('dbx_business_glossary_term' = 'Source Regulation');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
