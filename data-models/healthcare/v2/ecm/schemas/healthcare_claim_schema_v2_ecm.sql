-- Schema for Domain: claim | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`claim` COMMENT 'Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the insurance claim. Primary key for the claim entity.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Claims create accounts receivable balances tracked in AR subledger. Core AR management linking patient revenue cycle to financial accounting. Healthcare finance teams reconcile claim AR to GL AR contr',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Claims track billing organization for revenue allocation, payer contract reconciliation, and organizational performance reporting. Fundamental to healthcare revenue cycle operations. NPI denormalized.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Claims must track the facility where services were rendered for reimbursement validation, network status determination, cost reporting, and regulatory compliance. Essential for revenue cycle operation',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Claims are generated from clinical orders for billing and reimbursement. Revenue cycle operations require linking claims back to originating orders for charge reconciliation, denial management, and au',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this claim was submitted.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient claim payment requires DRG metadata for relative weight, geometric mean LOS, cost outlier thresholds, transfer flags, and national payment amounts. Every claim.drg_code must resolve to refer',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: Claims generate patient responsibility amounts (deductibles, copays, coinsurance) that must be billed to the guarantor. Essential for patient accounting, statement generation, payment posting, and col',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Claims adjudicate against specific plan benefits (deductibles, copays, out-of-pocket maximums, coverage rules), not just payer-level data. Essential for accurate benefit coordination, patient responsi',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to quality.hedis_measure. Business justification: HEDIS reporting requires direct claim-to-measure linkage for rate calculation and NCQA audit compliance. Claims provide numerator evidence for HEDIS measures; healthcare operations track which measure',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Claims must reference the specific insurance coverage under which services were billed. Essential for adjudication logic, coordination of benefits, payment posting, and reconciling allowed amounts aga',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Claims bill for supplies/devices/drugs (implants, DME, pharmaceuticals) identified by NDC/HCPCS codes. Link enables: claim adjudication matching billed items to formulary/contract pricing, denial appe',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - claims reference demographics but not mpi_record; since mpi_record is the SSOT for patient identity, this FK is essential for claim-to-patient resolutio',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization responsible for adjudicating this claim.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Claims are attributed to quality measures for VBP, MIPS, and HEDIS performance calculation. Healthcare operations require linking each claim to applicable quality measures for numerator/denominator de',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Referral orders generate professional claims when specialty services are rendered. Billing departments link claims to referral orders to validate authorization, track referral loop closure, and ensure',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Claims must track which clinician rendered service for payment attribution, quality reporting, and provider performance analysis. Core revenue cycle and credentialing process. NPI denormalized.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Claims are attributed to service delivery cost centers for departmental profitability analysis. Cost accounting requirement in healthcare. CFOs analyze claim revenue and costs by cost center for servi',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Claims are reported in fiscal periods for financial statement preparation and revenue recognition timing. Period accounting requirement. Healthcare finance must assign claim revenue to correct fiscal ',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit associated with this claim.',
    `invoice_id` BIGINT COMMENT 'add column billing_invoice_id (BIGINT) with FK to billing.invoice.invoice_id - claims are generated from invoices but claim has no FK back to billing.invoice; this is a critical revenue cycle link',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time the payer completed adjudication and determined payment or denial for this claim.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount of contractual adjustments, write-offs, and other reductions applied by the payer. Calculated as billed amount minus allowed amount.',
    `admission_date` DATE COMMENT 'Date the patient was admitted to the facility for inpatient or observation care. Required for institutional claims.',
    `appeal_filed_date` DATE COMMENT 'Date the appeal was formally submitted to the payer for reconsideration of the claim denial or underpayment.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed for this claim following a denial or partial payment. True if appeal is in process or completed.',
    `authorization_number` STRING COMMENT 'Authorization or referral number issued by the payer approving the services prior to delivery. Required for services subject to prior authorization.',
    `bill_type` STRING COMMENT 'Three-digit code on UB-04 institutional claims indicating the type of facility, care type, and billing sequence (e.g., 111 for hospital inpatient admit through discharge).',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Indicates whether this claim involves coordination of benefits with multiple payers. True when patient has primary and secondary insurance coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this claim record was first created in the revenue cycle management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this claim. Typically USD for US healthcare claims.. Valid values are `USD`',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason the claim or a portion of the claim was denied by the payer. Used for denial management and appeals.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of why the claim was denied, corresponding to the denial reason code.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the facility. Required for institutional claims to calculate length of stay.',
    `drg_grouper_version` STRING COMMENT 'Version identifier of the DRG grouper software used to assign the DRG code (e.g., MS-DRG v40.0). Critical for audit and reimbursement validation.',
    `number` STRING COMMENT 'Externally-known unique claim identifier assigned by the provider organization. Used for tracking and correspondence with payers.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time the payer issued payment to the provider for this claim. Corresponds to the remittance advice date.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Total amount the patient is responsible for paying, including deductibles, copayments, and coinsurance as determined by the payer.',
    `payer_claim_number` STRING COMMENT 'Unique claim identifier assigned by the payer organization upon receipt or adjudication. Also known as payer control number (PCN).',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the location where services were rendered (e.g., 11 for office, 21 for inpatient hospital, 23 for emergency department).',
    `primary_payer_flag` BOOLEAN COMMENT 'Indicates whether this claim was submitted to the primary insurance payer. True for primary claims, false for secondary or tertiary claims.',
    `principal_diagnosis_code` STRING COMMENT 'Primary ICD-10-CM diagnosis code representing the condition chiefly responsible for the services provided. Required for claim adjudication and DRG assignment.',
    `principal_procedure_code` STRING COMMENT 'Primary CPT or HCPCS procedure code representing the main service or procedure performed. Used for professional claim reimbursement.',
    `rac_audit_flag` BOOLEAN COMMENT 'Indicates whether this claim has been selected for or is under review by a Recovery Audit Contractor for potential overpayment recovery.',
    `referring_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who referred the patient for the services on this claim. Required for certain service types.',
    `service_from_date` DATE COMMENT 'Start date of the service period covered by this claim. For professional claims, this is the date services began.',
    `service_to_date` DATE COMMENT 'End date of the service period covered by this claim. For single-day services, this equals service_from_date.',
    `source_system_claim_code` STRING COMMENT 'Original unique identifier for this claim in the source operational system. Used for data lineage and reconciliation.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the claim in the revenue cycle management process. [ENUM-REF-CANDIDATE: draft|submitted|accepted|rejected|adjudicated|denied|appealed|paid|voided — 9 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Channel or method used to submit the claim to the payer. EDI 837P for professional claims, EDI 837I for institutional claims.. Valid values are `edi_837p|edi_837i|paper|portal`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time the claim was submitted to the payer for adjudication. Critical for tracking timely filing requirements.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Total amount the payer has determined is allowable for the services rendered, based on contracted rates or fee schedules. May be less than billed amount.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Total charges submitted to the payer for all services on this claim, before any adjustments or payments. Represents the providers full charge master pricing.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the payer to the provider for this claim, after applying deductibles, coinsurance, and other patient responsibility amounts.',
    `claim_type` STRING COMMENT 'Classification of the claim based on the type of service and billing form used. Professional claims use CMS-1500 form, institutional claims use UB-04 form.. Valid values are `professional|institutional|dental|vision|pharmacy`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this claim record was last modified in the revenue cycle management system.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Core master record for every insurance claim submitted to a payer. SSOT for claim identity, type (professional CMS-1500, facility UB-04, dental), status lifecycle (submitted, accepted, adjudicated, denied, appealed, paid), financial totals (billed, allowed, paid amounts), payer-assigned and internal claim numbers, place of service, bill type, admission/discharge details. Includes DRG assignment attributes (DRG code, weight, MDC, grouper version, base payment rate, outlier amounts) for inpatient facility claims. Includes diagnosis code associations (up to 25 ICD-10-CM codes per claim with sequence, POA indicator, and DRG grouper input flag per UB-04/CMS-1500 specifications). Captures principal diagnosis (ICD-10) and procedure (CPT/HCPCS), and submission channel (EDI 837P/837I, paper). Sourced from Epic Resolute PB/HB and Cerner Revenue Cycle.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` (
    `diagnosis_link_id` BIGINT COMMENT 'Primary key for diagnosis_link',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Diagnosis coding errors identified in compliance audits (RAC, MAC, OIG) link to specific claim diagnoses for remediation and coder education. Coding compliance teams track findings to diagnosis record',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim (UB-04 or CMS-1500) to which this diagnosis is attached. Required for all diagnosis links.',
    `employee_id` BIGINT COMMENT 'Reference to the Health Information Management (HIM) professional who assigned or validated this diagnosis code. Supports coding quality audits and productivity tracking.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Diagnosis coding requires ICD code metadata for validation, DRG grouping, HCC risk adjustment, denial prevention, and coding compliance audits. Every diagnosis_link.diagnosis_code must resolve to refe',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Claims coding validation requires direct linkage to encounter diagnosis for DRG grouper reconciliation, coding audit trails, and denial prevention. Coders verify claim diagnosis codes match encounter ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is currently active on the claim. False if the diagnosis was removed or replaced during coding review or appeals.',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a CDI query was issued to the provider to clarify or support this diagnosis. True if CDI intervention occurred.',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a chronic condition per CMS Chronic Condition Warehouse (CCW) definitions. Used for population health management and risk adjustment.',
    `coding_source` STRING COMMENT 'Origin of the diagnosis code assignment. Physician=provider-documented, Coder=HIM professional coding, CDI=Clinical Documentation Improvement query, CAC=Computer-Assisted Coding, Imported=external system.. Valid values are `physician|coder|cdi|cac|imported`',
    `coding_timestamp` TIMESTAMP COMMENT 'Date and time when this diagnosis code was assigned or last validated by a coder. Used for coding turnaround time (TAT) measurement and compliance audits.',
    `complication_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis qualifies as a complication or comorbidity (CC) or major complication or comorbidity (MCC) per MS-DRG grouper logic. Impacts DRG severity and reimbursement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this claim diagnosis link record was first created in the system. Audit trail for data lineage.',
    `denial_risk_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis has historically high denial rates or requires additional documentation to support medical necessity. Used for denial prevention and appeals management.',
    `diagnosis_category` STRING COMMENT 'High-level clinical category or chapter of the ICD-10-CM code (e.g., Endocrine, Circulatory, Injury). Derived from the first character of the ICD-10-CM code for analytics and quality reporting.',
    `diagnosis_code` STRING COMMENT 'The ICD-10-CM diagnosis code assigned to this claim. Alphanumeric code up to 7 characters (e.g., E11.9, S72.001A). Used for DRG grouping, quality reporting, and payer adjudication.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `diagnosis_date` DATE COMMENT 'Date when the diagnosis was clinically established or documented by the provider. May differ from claim service date.',
    `diagnosis_description` STRING COMMENT 'Human-readable description of the ICD-10-CM diagnosis code. Provides clinical context for reporting and audit purposes.',
    `diagnosis_pointer` STRING COMMENT 'Letter (A-L) linking this diagnosis to specific service lines on CMS-1500 professional claims. Maps diagnosis to procedures/services that treat the condition.. Valid values are `^[A-L]$`',
    `diagnosis_sequence` STRING COMMENT 'Ordinal position of this diagnosis on the claim. Sequence 1 is the principal diagnosis. Supports up to 25 diagnosis codes per UB-04 and CMS-1500 specifications.',
    `diagnosis_type` STRING COMMENT 'Classification of the diagnosis role on the claim. Principal diagnosis drives DRG assignment. Admitting diagnosis reflects condition at admission. External cause codes (V, W, X, Y) capture injury circumstances.. Valid values are `principal|secondary|admitting|external_cause|other`',
    `diagnosis_version` STRING COMMENT 'Version of the ICD code set used. ICD-10-CM is current standard (effective October 2015). ICD-9-CM retained for historical claims.. Valid values are `ICD-10-CM|ICD-9-CM`',
    `drg_grouper_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis was used as input to the DRG grouper algorithm for reimbursement calculation. True if the diagnosis influenced the assigned DRG.',
    `encounter_type` STRING COMMENT 'Type of encounter during which this diagnosis was documented. Determines applicable coding guidelines (e.g., inpatient principal diagnosis vs. outpatient first-listed diagnosis).. Valid values are `inpatient|outpatient|emergency|observation|ambulatory_surgery`',
    `hac_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is a CMS-designated Hospital-Acquired Condition (e.g., CLABSI, CAUTI, SSI, falls). HACs with POA=N may result in payment reduction under CMS HAC Reduction Program.',
    `laterality` STRING COMMENT 'Anatomical side affected by the diagnosis (e.g., left femur fracture, right eye cataract). Required for certain ICD-10-CM codes to achieve specificity.. Valid values are `left|right|bilateral|unspecified`',
    `poa_indicator` STRING COMMENT 'Indicates whether the diagnosis was present at the time of inpatient admission. Y=Yes, N=No, U=Unknown, W=Clinically Undetermined, 1=Exempt. Required for inpatient claims per CMS Hospital-Acquired Condition (HAC) reporting.. Valid values are `Y|N|U|W|1`',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is used in CMS quality measure calculations (e.g., HEDIS, Hospital VBP, MIPS). Supports quality reporting and value-based purchasing programs.',
    `rac_audit_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00-100.00) indicating likelihood of RAC audit scrutiny for this diagnosis. Higher scores indicate diagnoses frequently targeted in post-payment audits.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this claim diagnosis link record was last modified. Supports change tracking and audit compliance.',
    CONSTRAINT pk_diagnosis_link PRIMARY KEY(`diagnosis_link_id`)
) COMMENT 'Association entity linking ICD-10-CM diagnosis codes to a claim, capturing diagnosis sequence (principal, secondary, admitting, external cause, present-on-admission indicator), POA flag, diagnosis code, diagnosis description, and whether the diagnosis is used as a DRG grouper input. Supports up to 25 diagnosis codes per claim per UB-04 and CMS-1500 specifications. Critical for DRG assignment, quality reporting, and RAC audit defense.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`submission` (
    `submission_id` BIGINT COMMENT 'Primary key for submission',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Claim submissions must identify the originating facility for clearinghouse routing, payer validation, and reconciliation workflows. Supports submission tracking, error resolution, and facility-level s',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim being submitted. Links this submission event to the underlying claim record.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Certain claim submissions (Medicare cost reports, Medicaid encounters, 340B claims) are regulatory submissions requiring compliance tracking for timely filing and accuracy attestation. Compliance team',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Claim submissions route through specific interface channels (EDI connections) to clearinghouses/payers. IT operations and revenue cycle teams need to track which channel transmitted each submission fo',
    `original_submission_id` BIGINT COMMENT 'Reference to the original claim submission record if this is a resubmission or corrected claim. Null for original submissions. Enables tracking of submission history and resubmission chains.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer (health plan) to which this claim was submitted.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Submitting organization tracked for clearinghouse routing, EDI reconciliation, and submission error analysis. Essential for revenue cycle operations and payer relationship management. NPI denormalized',
    `trading_partner_id` BIGINT COMMENT 'Reference to the clearinghouse entity used as an intermediary for claim submission. Null if submitted directly to payer.',
    `acknowledgment_date` DATE COMMENT 'Date on which the payer or clearinghouse acknowledged receipt of the claim submission via 277CA transaction.',
    `acknowledgment_status` STRING COMMENT 'Status returned by the payer or clearinghouse in the 277CA (Claim Acknowledgment) transaction: accepted (passed initial validation), rejected (failed validation), error (technical issue), pending (awaiting validation).. Valid values are `accepted|rejected|error|pending`',
    `batch_number` STRING COMMENT 'Identifier for the batch or group of claims submitted together in a single transmission. Enables batch-level tracking and reconciliation.',
    `batch_sequence_number` STRING COMMENT 'Sequential position of this claim within the submission batch. Used for ordering and reconciliation within batch processing.',
    `claim_charge_amount` DECIMAL(18,2) COMMENT 'Total billed charge amount for the claim at the time of this submission. Captured here for submission audit trail and variance analysis if claim is resubmitted with different amounts.',
    `claim_filing_indicator_code` STRING COMMENT 'Code identifying the type of insurance plan or payer category (e.g., Medicare, Medicaid, commercial, HMO, PPO). Used for routing and adjudication logic.',
    `clearinghouse_transaction_number` STRING COMMENT 'Unique transaction identifier assigned by the clearinghouse for tracking this submission through their system. Used for reconciliation and support inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claim charge amount. Typically USD for U.S. healthcare claims.. Valid values are `USD`',
    `submission_date` DATE COMMENT 'The calendar date on which the claim was submitted to the payer or clearinghouse. Critical for timely filing compliance and submission audit trails.',
    `edi_transaction_set` STRING COMMENT 'The specific HIPAA EDI 837 transaction set used for electronic submission: 837P (professional claims), 837I (institutional claims), 837D (dental claims). Null for non-EDI submissions.. Valid values are `837P|837I|837D`',
    `error_code` STRING COMMENT 'Technical error code returned by the clearinghouse or payer system when a transmission or processing error occurs. Null if no technical errors.',
    `error_description` STRING COMMENT 'Detailed description of the technical error encountered during submission or processing. Used for troubleshooting and system issue resolution.',
    `is_timely_filed` BOOLEAN COMMENT 'Boolean flag indicating whether the claim was submitted within the payers timely filing window. True if submitted on or before the deadline, false otherwise.',
    `method` STRING COMMENT 'The technical channel or mechanism used to submit the claim: EDI 837 (electronic data interchange), clearinghouse (third-party intermediary), portal (payer web portal), paper (mailed form), fax, or direct API (application programming interface).. Valid values are `edi_837|clearinghouse|portal|paper|fax|direct_api`',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the submitter regarding this submission event. May include special handling instructions, context for resubmission, or internal tracking information.',
    `number` STRING COMMENT 'Business-assigned unique identifier for this submission event, used for tracking and reference in operational workflows.',
    `payer_acknowledgment_number` STRING COMMENT 'Unique acknowledgment or control number assigned by the payer upon receipt of the claim submission. Used for tracking and inquiries with the payer.',
    `prior_authorization_number` STRING COMMENT 'Authorization or pre-certification number obtained from the payer prior to service delivery, included in the claim submission for validation and payment approval.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for submission rejection. Maps to HIPAA claim adjustment reason codes (CARC) or remittance advice remark codes (RARC). Null if submission was accepted.',
    `rejection_reason_description` STRING COMMENT 'Human-readable explanation of the rejection reason, providing additional context beyond the rejection reason code. Used for denial management and corrective action.',
    `resubmission_count` STRING COMMENT 'The number of times this claim has been resubmitted to the payer. Zero for original submissions. Used for denial management analytics and workflow optimization.',
    `resubmission_reason_code` STRING COMMENT 'Standardized code indicating the reason for resubmission (e.g., denial, additional information requested, corrected claim). Null for original submissions.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the submission: pending (queued for transmission), transmitted (sent to payer/clearinghouse), acknowledged (receipt confirmed), accepted (passed validation), rejected (failed validation), error (technical failure), cancelled (withdrawn before processing). [ENUM-REF-CANDIDATE: pending|transmitted|acknowledged|accepted|rejected|error|cancelled — 7 candidates stripped; promote to reference product]',
    `submitter_contact_email` STRING COMMENT 'Email address of the submitter contact person for electronic correspondence regarding this submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `submitter_contact_name` STRING COMMENT 'Name of the individual contact person at the submitting organization responsible for this submission. Used for follow-up and inquiries.',
    `submitter_contact_phone` STRING COMMENT 'Phone number of the submitter contact person for inquiries and follow-up regarding this submission.',
    `submitter_organization_name` STRING COMMENT 'Name of the organization or billing service that submitted the claim. May differ from the rendering provider organization.',
    `timely_filing_deadline` DATE COMMENT 'The contractual deadline by which the claim must be submitted to the payer to comply with timely filing requirements. Used for submission prioritization and compliance monitoring.',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time when the submission was transmitted, including time zone. Used for audit trails, SLA tracking, and dispute resolution.',
    `transmission_control_number` STRING COMMENT 'Unique control number assigned to the transmission envelope (ISA/GS level in EDI 837). Used for transmission-level tracking and reconciliation.',
    `transmission_file_name` STRING COMMENT 'Name of the electronic file (e.g., EDI 837 file) that contained this claim submission. Used for technical audit trails and file-level reconciliation.',
    `submission_type` STRING COMMENT 'Categorizes the nature of the submission: original (first submission), resubmission (after denial or rejection), corrected (error correction), void (cancellation), or replacement (supersedes prior submission).. Valid values are `original|resubmission|corrected|void|replacement`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission record was last modified. Used for audit trails, change tracking, and data synchronization.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Tracks each discrete submission event for a claim to a payer, including original submission, resubmission after denial, and corrected claim submissions. Captures submission date, submission method (EDI 837, clearinghouse, paper, portal), clearinghouse transaction ID, payer-assigned acknowledgment number, submission batch ID, 277CA acknowledgment status (accepted, rejected, error), rejection reason codes, and submitter NPI. Enables end-to-end claim submission audit trail and resubmission workflow management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Primary key for status_history',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim for which this status transition was recorded. Links to the claim master record.',
    `employee_id` BIGINT COMMENT 'The identifier of the user who manually triggered this status transition. Null if the transition was automated or system-generated. Used for accountability and audit trail in Revenue Cycle Management (RCM).',
    `appeal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this status transition is associated with an appeal or reconsideration request. True if the status change is part of an appeal workflow; False otherwise. Supports denial management and appeals tracking.',
    `check_or_eft_number` STRING COMMENT 'The check number or Electronic Funds Transfer (EFT) trace number associated with the payment that triggered this status transition to a paid state. Null if no payment was issued. Used for payment reconciliation and cash application.',
    `clearinghouse_trace_number` STRING COMMENT 'The unique trace or reference number assigned by the clearinghouse for this status update transaction. Used for troubleshooting and reconciliation with clearinghouse reports.',
    `coordination_of_benefits_sequence` STRING COMMENT 'The payer sequence number in coordination of benefits (COB) scenarios (1 for primary, 2 for secondary, 3 for tertiary). Indicates which payer this status applies to when multiple payers are involved.',
    `corrected_claim_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this status transition is associated with a corrected or resubmitted claim (frequency type code 7 in ANSI X12 837). True if this is a corrected claim status; False for original claim submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this status history record was first created in the system. Represents the audit trail creation time, which may differ slightly from the effective_timestamp if there is processing lag.',
    `days_in_prior_status` STRING COMMENT 'The number of calendar days the claim remained in the prior status before this transition. Calculated metric used for aging analysis, bottleneck identification, and workflow optimization in Revenue Cycle Management (RCM).',
    `denial_category` STRING COMMENT 'High-level categorization of the denial reason when the status represents a denial. Categories include technical (coding errors), clinical (medical necessity), eligibility (coverage issues), authorization (prior auth missing), timely filing (submission deadline missed), and duplicate (claim already processed). Null if not a denial status. Supports denial management analytics and root cause analysis.. Valid values are `technical|clinical|eligibility|authorization|timely_filing|duplicate`',
    `effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when this status became effective for the claim. Represents the real-world business event time of the status transition, critical for Service Level Agreement (SLA) monitoring and timely filing compliance tracking.',
    `is_final_status` BOOLEAN COMMENT 'Boolean flag indicating whether this status represents a terminal state in the claim lifecycle (e.g., fully paid, denied and closed, written off). True if no further status transitions are expected; False if the claim remains in an active workflow state.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this status history record was last modified. Typically immutable for status history records, but may be updated if corrections or annotations are applied.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by revenue cycle staff or system processes to provide additional context for this status transition. May include follow-up actions, payer correspondence details, or resolution steps.',
    `payer_claim_control_number` STRING COMMENT 'The unique identifier assigned by the payer to this claim, as reported in the 277 or 835 transaction. Critical for payer correspondence, appeals, and coordination of benefits (COB) across Health Maintenance Organization (HMO), Preferred Provider Organization (PPO), Point of Service (POS), Medicare, and Medicaid payers.',
    `payer_response_code` STRING COMMENT 'The standardized response code provided by the payer in the Electronic Remittance Advice (ERA) or 277 transaction, indicating the reason for the status (e.g., claim adjustment reason codes, remark codes). Aligns with CARC and RARC code sets.',
    `payer_response_description` STRING COMMENT 'Human-readable explanation of the payer response code, providing additional context for denial management, appeals, and clinical documentation improvement (CDI) efforts.',
    `prior_status_code` STRING COMMENT 'The status code that was in effect immediately before this transition. Enables tracking of status progression and identification of status reversals or loops.',
    `remittance_date` DATE COMMENT 'The date the payer issued the Electronic Remittance Advice (ERA) or Explanation of Benefits (EOB) that triggered this status transition. Null if the status change was not payer-initiated. Critical for cash posting and accounts receivable (AR) aging.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this status transition occurred within the defined Service Level Agreement (SLA) timeframe for the claim type and payer contract. True if compliant; False if SLA was breached. Supports operational performance monitoring and payer contract compliance.',
    `status_category` STRING COMMENT 'Classification of the status origin: whether it is a payer-defined status received via Electronic Remittance Advice (ERA) or 277 response, an internal workflow state, a system-generated transition, or a manual override by revenue cycle staff.. Valid values are `payer_defined|internal_workflow|system_generated|manual_override`',
    `status_code` STRING COMMENT 'The standardized code representing the claim status at this point in time. Aligns with ANSI X12 277 Claim Status Category Codes and internal workflow states.',
    `status_description` STRING COMMENT 'Human-readable description of the claim status, providing context for the status code (e.g., Submitted to Payer, Pending Additional Information, Adjudicated - Paid, Denied - Medical Necessity).',
    `status_reason` STRING COMMENT 'Internal reason or note explaining why this status transition occurred, particularly for manual overrides, appeals, or corrected claims. Supports denial management and Recovery Audit Contractor (RAC) audit responses.',
    `transaction_set_identifier` STRING COMMENT 'The ANSI X12 transaction set control number or identifier associated with the Electronic Data Interchange (EDI) transaction that triggered this status change (e.g., 277 response, 835 ERA). Enables correlation with source EDI files for audit and reconciliation.',
    `triggered_by_process` STRING COMMENT 'The name of the automated process, batch job, or workflow engine that triggered this status transition (e.g., Nightly Clearinghouse Sync, ERA Import Job, Auto-Denial Workflow). Null if manually triggered.',
    `void_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this status transition represents a voided or cancelled claim submission (frequency type code 8 in ANSI X12 837). True if the claim was voided; False otherwise.',
    `work_queue_assignment` STRING COMMENT 'The name of the revenue cycle work queue or team to which this claim was assigned following this status transition (e.g., Denials Management, Prior Auth Follow-Up, Payment Posting, Appeals). Supports workflow routing and workload balancing.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Lifecycle status history for each claim, recording every status transition from creation through final adjudication or write-off. Captures status code, status description, status category (payer-defined vs. internal), effective timestamp, source system, user or automated process that triggered the transition, and associated payer response codes. Supports real-time claim tracking per ANSI X12 276/277 transaction sets and enables SLA monitoring for timely filing compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance` (
    `remittance_id` BIGINT COMMENT 'Primary key for remittance',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Remittance payments are AR cash receipt transactions reducing outstanding receivables. Standard AR posting workflow in healthcare. Finance teams must trace remittance payments to AR transactions for c',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: ERA/835 remittances trigger cash receipt and contractual adjustment journal entries. Standard cash posting workflow in healthcare revenue cycle. Finance teams must reconcile remittance payments to GL ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Remittance reconciliation discrepancies (unexplained adjustments, recoupments) trigger compliance audits for billing integrity and false claims act exposure. Revenue integrity teams link remittance va',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that posted this remittance advice to patient accounts. Used for audit trail and accountability.',
    `financial_entity_id` BIGINT COMMENT 'Federal Tax Identification Number (TIN) or Employer Identification Number (EIN) of the payee organization. Used for tax reporting and payment reconciliation.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Remittance advice (EDI 835) messages are logged in message_log. Revenue cycle teams link remittances to their inbound EDI messages for troubleshooting posting failures, reconciling payment batches, an',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer organization that issued this remittance advice. Links to the payer master entity.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Remittances are posted to fiscal periods for revenue recognition and cash receipt timing. Period close process requirement. Healthcare finance assigns remittance cash and adjustments to fiscal periods',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remittance revenue is allocated to cost centers for departmental revenue recognition. Revenue attribution process required for cost center P&L statements. Healthcare finance allocates payer payments t',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Remittance advice is received from specific trading partners (payers or clearinghouses). Revenue cycle teams track which trading partner sent each remittance for reconciling payment batches, troublesh',
    `bank_account_number` STRING COMMENT 'Bank account number to which the payment was deposited. Used for reconciliation of electronic payments against bank statements.',
    `check_eft_number` STRING COMMENT 'Check number or Electronic Funds Transfer (EFT) trace number associated with this payment. Used for payment reconciliation and bank deposit matching.',
    `coverage_period_end_date` DATE COMMENT 'End date of the coverage period for claims included in this remittance advice. Indicates the end of the service date range covered by this payment.',
    `coverage_period_start_date` DATE COMMENT 'Start date of the coverage period for claims included in this remittance advice. Indicates the beginning of the service date range covered by this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this remittance advice record was first created in the data product. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Typically USD for U.S. healthcare transactions.. Valid values are `USD`',
    `fiscal_period_date` DATE COMMENT 'Fiscal period or accounting period to which this remittance advice is assigned for financial reporting purposes.',
    `group_control_number` STRING COMMENT 'Unique control number assigned to the functional group within the EDI interchange. Used for organizing multiple transaction sets.',
    `interchange_control_number` STRING COMMENT 'Unique control number assigned to the EDI interchange envelope. Used for tracking the entire 835 transmission batch.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this remittance advice. Used for documenting exceptions, special handling instructions, or reconciliation issues.',
    `payee_name` STRING COMMENT 'Name of the healthcare provider or organization receiving the payment as listed in the remittance advice.',
    `payee_npi` STRING COMMENT 'National Provider Identifier (NPI) of the healthcare provider or organization receiving the payment. 10-digit unique identifier assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `payer_claim_control_number` STRING COMMENT 'Unique control number assigned by the payer to track the remittance advice. Used for payer-side reconciliation and inquiry.',
    `payer_contact_email` STRING COMMENT 'Email address of the payer contact for inquiries related to this remittance advice.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payer_contact_name` STRING COMMENT 'Name of the payer contact person or department for inquiries related to this remittance advice.',
    `payer_contact_phone` STRING COMMENT 'Phone number of the payer contact for inquiries related to this remittance advice.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total monetary amount paid by the payer in this remittance advice. Represents the net payment after all adjustments, denials, and contractual allowances.',
    `payment_date` DATE COMMENT 'Date on which the payment was issued or funds were transferred by the payer. This is the effective date of payment.',
    `payment_method_code` STRING COMMENT 'Code indicating the method of payment delivery. CHK=Check, ACH=Automated Clearing House, EFT=Electronic Funds Transfer, NON=Non-Payment (zero-dollar remittance).. Valid values are `CHK|ACH|EFT|NON`',
    `posting_date` DATE COMMENT 'Date on which the remittance advice was posted to patient accounts in the billing system. Used for revenue recognition and cash application tracking.',
    `production_date` DATE COMMENT 'Date on which the remittance advice was generated or produced by the payer system. May differ from payment date.',
    `provider_adjustment_amount` DECIMAL(18,2) COMMENT 'Provider-level adjustment amount applied across all claims in this remittance advice. Represents aggregate adjustments not tied to specific claims (e.g., prior period adjustments, recoupments).',
    `provider_adjustment_reason_code` STRING COMMENT 'Code indicating the reason for provider-level adjustments. Examples include prior overpayment recovery, interest payment, or administrative adjustments.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when the remittance advice was received by the provider system. Used for tracking ERA processing timeliness and SLA compliance.',
    `receiver_identification` STRING COMMENT 'Identification code of the receiver of the 835 transaction. Typically the clearinghouse or provider system receiving the ERA.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process between the remittance advice and bank deposit. Indicates whether the payment has been successfully matched to bank records.. Valid values are `pending|matched|unmatched|exception|resolved`',
    `routing_number` STRING COMMENT 'Nine-digit ABA routing number of the financial institution receiving the payment. Used for electronic funds transfer processing.. Valid values are `^[0-9]{9}$`',
    `sender_identification` STRING COMMENT 'Identification code of the sender of the 835 transaction. Typically the payer organization transmitting the ERA.',
    `source_file_name` STRING COMMENT 'Name of the source 835 EDI file from which this remittance advice was extracted. Used for data lineage and troubleshooting.',
    `remittance_status` STRING COMMENT 'Current processing status of the remittance advice within the revenue cycle system. Tracks the lifecycle from receipt through posting and reconciliation.. Valid values are `received|posted|reconciled|exception|voided`',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount of adjustments applied by the payer across all claims in this remittance advice. Includes contractual adjustments, denials, and other reductions.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Total amount allowed by the payer across all claims in this remittance advice. Represents the sum of all approved charges per payer contract terms.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed across all claims included in this remittance advice. Represents the sum of all submitted charges before payer adjustments.',
    `total_claim_count` STRING COMMENT 'Total number of claims included in this remittance advice. Represents the aggregate count of all claims adjudicated in this payment batch.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Total amount for which the patient is responsible across all claims in this remittance advice. Includes deductibles, copayments, and coinsurance.',
    `transaction_set_control_number` STRING COMMENT 'Unique control number assigned to the 835 transaction set by the payer. Used for tracking and reconciliation of the Electronic Remittance Advice (ERA) transmission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this remittance advice record was last updated. Used for audit trail and change tracking.',
    CONSTRAINT pk_remittance PRIMARY KEY(`remittance_id`)
) COMMENT 'Electronic Remittance Advice (ERA) received from payers following claim adjudication. Represents the 835 transaction set containing payer name, payer ID, check/EFT number, payment date, payment amount, payee NPI, and aggregate payment details. SSOT for all ERA transactions received from Medicare, Medicaid, HMO, PPO, and commercial payers. Enables automated payment posting, contractual adjustment calculation, and reconciliation against expected reimbursement per payer contracts.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` (
    `remittance_line_id` BIGINT COMMENT 'Primary key for remittance_line',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Individual remittance line adjustments (contractual, denials, sequestration) map to specific GL line entries for detailed variance analysis. Required for revenue integrity reporting and payer contract',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Remittance lines adjudicate individual charges. Payment posting, variance analysis, and charge reconciliation require linking remittance lines to the specific charges they adjudicate. Critical for ide',
    `claim_id` BIGINT COMMENT 'Reference to the original claim that this remittance line is paying or adjusting. Links remittance payment to the submitted claim.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Payment reconciliation requires CPT metadata to validate allowed amounts against contracted rates, identify payment variances, and analyze reimbursement trends by procedure. Every remittance_line.proc',
    `employee_id` BIGINT COMMENT 'Reference to the user who posted or approved the remittance line transaction. Provides audit trail for manual adjustments and ERA posting activities.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule. Business justification: Remittance line payment amounts are calculated per contracted fee schedule terms. Essential for payment variance analysis, contract compliance verification, underpayment identification, and reconcilia',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Payment reconciliation for HCPCS services requires HCPCS metadata to validate DME and drug reimbursement against contracted rates and identify underpayment. Every remittance_line.procedure_code (when ',
    `claim_line_id` BIGINT COMMENT 'Reference to the specific service line within the claim that this remittance line is addressing. Enables line-level payment reconciliation.',
    `payer_contract_id` BIGINT COMMENT 'Reference to the specific payer contract that governs reimbursement for this service line. Used for contract variance analysis and rate validation.',
    `remittance_id` BIGINT COMMENT 'Reference to the parent ERA 835 transaction that contains this remittance line. Links to the ERA header transaction.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of the specific adjustment identified by the CARC and adjustment group code. May represent contractual write-offs, denials, or other payment variances.',
    `adjustment_date` DATE COMMENT 'The date on which the adjustment was applied to the claim line. Used for financial period reconciliation and audit trail purposes.',
    `adjustment_group_code` STRING COMMENT 'High-level categorization of the adjustment reason. CO=Contractual Obligation, PR=Patient Responsibility, OA=Other Adjustment, PI=Payer Initiated, CR=Correction and Reversal.. Valid values are `CO|PR|OA|PI|CR`',
    `adjustment_quantity` DECIMAL(18,2) COMMENT 'The number of units affected by the adjustment. Used when the payer adjusts the quantity of service units from what was billed.',
    `adjustment_source` STRING COMMENT 'The origin or system that generated the adjustment. Identifies whether the adjustment came from automated ERA posting, manual intervention, audit recoupment, or other sources.. Valid values are `era_posting|manual_adjustment|rac_recoupment|cob_processing|payer_correction|appeal_result`',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment applied to the remittance line. Identifies the nature and source of the payment variance for financial reporting and variance analysis. [ENUM-REF-CANDIDATE: contractual|write_off|recoupment|manual|era_posting|rac_recoupment|cob_transfer — 7 candidates stripped; promote to reference product]',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The maximum amount the payer will reimburse for the service based on the contract or fee schedule. Also known as the approved amount or eligible amount.',
    `balance_transfer_amount` DECIMAL(18,2) COMMENT 'Amount transferred to another payer or entity as part of coordination of benefits (COB). Indicates the portion of the claim forwarded to a secondary or tertiary payer.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The original amount charged by the provider for the service as submitted on the claim. Represents the gross charge before payer adjudication.',
    `claim_adjustment_reason_code` STRING COMMENT 'Standardized code explaining why the claim or service line was adjusted. Provides detailed reason for payment variance from billed amount. Examples include 1=Deductible, 2=Coinsurance, 45=Charge exceeds fee schedule.',
    `coinsurance_amount` DECIMAL(18,2) COMMENT 'The percentage-based patient responsibility amount after the deductible has been met. Typically expressed as a percentage of the allowed amount.',
    `contractual_adjustment_amount` DECIMAL(18,2) COMMENT 'The difference between the billed amount and the allowed amount per the payer contract. Represents the write-off amount that the provider has agreed to accept per contractual terms.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount the patient is required to pay for the service as defined by their insurance plan. Collected at the time of service or billed to the patient.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this remittance line record was first created in the system. Provides audit trail for data lineage and compliance reporting.',
    `credit_balance_amount` DECIMAL(18,2) COMMENT 'Amount representing an overpayment or credit on the patient or claim account. May require refund processing or application to future services.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The portion of the allowed amount applied to the patients annual deductible. Represents patient responsibility before insurance coverage begins.',
    `denial_reason_code` STRING COMMENT 'Specific code indicating why a claim line was denied payment. Used for denial management, appeals processing, and root cause analysis of claim rejections.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this remittance line amount is posted. Enables integration with financial accounting systems and revenue recognition.',
    `line_payment_status` STRING COMMENT 'Current adjudication status of this remittance line. Indicates whether the service line was paid in full, partially paid, denied, or requires additional action.. Valid values are `paid|denied|adjusted|pending|reversed`',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of remittance lines within the parent ERA transaction. Used to maintain the order of service line payments as received from the payer.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The final net revenue recognized for this service line after all adjustments, write-offs, and patient responsibility amounts. Represents the actual revenue booked to the general ledger.',
    `note` STRING COMMENT 'Free-text notes or comments related to the remittance line. May include additional payer remarks, internal processing notes, or appeal documentation.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by the payer to the provider for this service line. Represents the net payment after all adjustments, deductibles, coinsurance, and copayments.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The total amount the patient is responsible for paying, including deductibles, coinsurance, and copayments. Used for patient billing and accounts receivable management.',
    `payer_claim_control_number` STRING COMMENT 'The payer-assigned unique identifier for the claim as reported in the ERA. Used for cross-referencing with payer systems and correspondence.',
    `posting_date` DATE COMMENT 'The date on which the remittance line was posted to the patient account or billing system. Used for cash application tracking and accounts receivable aging.',
    `procedure_code` STRING COMMENT 'The Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) code for the service rendered. Identifies the specific medical procedure or service being paid.',
    `procedure_modifier_1` STRING COMMENT 'First modifier code appended to the procedure code to provide additional information about the service performed. Affects reimbursement and adjudication logic.',
    `procedure_modifier_2` STRING COMMENT 'Second modifier code appended to the procedure code. Provides additional context for the service performed.',
    `procedure_modifier_3` STRING COMMENT 'Third modifier code appended to the procedure code. Provides additional context for the service performed.',
    `procedure_modifier_4` STRING COMMENT 'Fourth modifier code appended to the procedure code. Provides additional context for the service performed.',
    `recoupment_amount` DECIMAL(18,2) COMMENT 'Amount being recovered or taken back by the payer from previous overpayments. May result from Recovery Audit Contractor (RAC) audits, payer audits, or claim corrections.',
    `remittance_advice_remark_code` STRING COMMENT 'Supplemental code providing additional information or instructions related to the claim adjudication. Used in conjunction with CARC to provide complete explanation of payment decisions.',
    `revenue_code` STRING COMMENT 'Four-digit code used on institutional claims (UB-04) to identify the specific accommodation, ancillary service, or billing calculation related to the service. Used primarily for hospital billing.',
    `service_date` DATE COMMENT 'The date on which the healthcare service was provided to the patient. Used for matching remittance lines to original claim service dates.',
    `service_line_number` STRING COMMENT 'The line item number within the claim as assigned by the payer in the ERA. Corresponds to the specific procedure or service being adjudicated.',
    `units_of_service` DECIMAL(18,2) COMMENT 'The quantity of services or procedures performed. May represent time units, number of procedures, or other countable service measures depending on the procedure code.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this remittance line record was last modified. Tracks changes for audit purposes and data quality monitoring.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between expected payment (based on contract terms) and actual payment received. Used for contract compliance monitoring and underpayment identification.',
    CONSTRAINT pk_remittance_line PRIMARY KEY(`remittance_line_id`)
) COMMENT 'Claim-level and service-line-level detail within an ERA (835) transaction, linking each remittance payment to specific claims and claim lines. Captures claim adjustment reason codes (CARC), remittance advice remark codes (RARC), paid amount, allowed amount, contractual adjustment amount, CO/PR/OA adjustment group codes, and line-level payment details. Includes all post-adjudication adjustments: contractual adjustments, write-offs, recoupments, balance transfers, credit balances, manual adjustments, and RAC recoupment entries with adjustment type, reason code, amount, date, source (ERA posting, manual, RAC recoupment, COB), GL account code, and approving user. Enables granular payment reconciliation, underpayment identification, net revenue calculation, and contractual variance analysis per payer contract terms.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Primary key for prior_authorization',
    `billing_coverage_id` BIGINT COMMENT 'Reference to the insurance coverage under which this prior authorization is submitted.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Prior authorizations must specify the facility where service will be performed for payer network validation, facility-specific contract terms, and authorization approval workflows. Has facility_npi bu',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Prior authorization review requires CPT metadata for medical necessity determination, utilization management, peer review criteria, and authorization decision support. Every prior_authorization.reques',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Authorization tied to facility for site-of-service rules, facility-specific authorization requirements, and network participation validation. Required for inpatient and outpatient authorization workfl',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: Prior authorization requests via FHIR ServiceRequest/CoverageEligibilityRequest are logged in fhir_resource_log. Utilization management staff track FHIR-based prior auth transactions for troubleshooti',
    `hie_query_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_query. Business justification: Prior authorization requests may trigger HIE queries to retrieve clinical documentation from other facilities. Utilization management staff track which HIE queries supported each prior auth for docume',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prior authorization medical necessity validation requires ICD code metadata for diagnosis appropriateness, coverage policy matching, and clinical indication verification. Every prior_authorization.cli',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Prior authorizations for high-cost implants, specialty drugs, and DME require linking to supply master for: clinical review of device specifications, cost estimation for payer approval, formulary stat',
    `order_authorization_id` BIGINT COMMENT 'Foreign key linking to order.order_authorization. Business justification: Prior authorizations obtained during order placement must be referenced in claim submission to justify medical necessity and secure payment. Revenue cycle teams validate authorization numbers against ',
    `patient_account_id` BIGINT COMMENT 'Reference to the patient account for which this prior authorization is requested.',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - prior authorizations are patient-specific but lack a direct patient FK; patient is only reachable through visit or insurance_coverage indirection',
    `payer_id` BIGINT COMMENT 'The unique identifier for the insurance payer or health plan to which the prior authorization was submitted (e.g., payer EDI ID or internal payer identifier).',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Authorization decisions are governed by specific payer rules. Linking authorization records to the applied rule enables compliance auditing, rule effectiveness measurement, turnaround time tracking by',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Authorization requests tied to requesting clinician for utilization management workflow, approval rate tracking, and provider education on authorization requirements. Core managed care operation. NPI ',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Prior authorizations for investigational procedures must link to research protocols for authorization tracking, protocol compliance verification, and research billing determination. Payers require pro',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this prior authorization request.',
    `appeal_decision_date` DATE COMMENT 'The date the payer made a decision on the appeal (upheld denial, overturned to approval, or partially approved).',
    `appeal_filed_date` DATE COMMENT 'The date an appeal was filed with the payer for a denied or partially approved prior authorization.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed for a denied or partially approved prior authorization. True if an appeal has been submitted, False otherwise.',
    `appeal_outcome` STRING COMMENT 'The outcome of the appeal process. Indicates whether the appeal resulted in approval, continued denial, or partial approval.. Valid values are `approved|denied|partially_approved|pending`',
    `approved_end_date` DATE COMMENT 'The end date of the approved authorization period. Services must be rendered on or before this date to be covered under this authorization.',
    `approved_start_date` DATE COMMENT 'The start date of the approved authorization period. Services may only be rendered on or after this date.',
    `approved_units` DECIMAL(18,2) COMMENT 'The number of units or quantity of the service approved by the payer. May differ from requested units if partially approved.',
    `authorization_notes` STRING COMMENT 'Free-text notes or comments related to the prior authorization request, decision, or appeal. May include clinical justification, payer feedback, or internal tracking notes.',
    `authorization_number` STRING COMMENT 'The unique authorization number or reference number assigned by the payer upon approval or submission. This is the externally-known identifier for the PA.',
    `authorization_source` STRING COMMENT 'The method or channel through which the prior authorization request was submitted to the payer (e.g., phone, payer portal, fax, EDI 278 transaction).. Valid values are `phone|portal|fax|edi_278|mail|other`',
    `authorization_status` STRING COMMENT 'Current lifecycle status of the prior authorization request. Indicates whether the payer has approved, denied, or is still reviewing the request.. Valid values are `approved|denied|pending|cancelled|expired|partially_approved`',
    `clinical_indication_icd10_code` STRING COMMENT 'The primary ICD-10 diagnosis code representing the clinical indication or medical necessity justifying the prior authorization request.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this prior authorization record was first created in the system.',
    `decision_date` DATE COMMENT 'The date the payer made a decision on the prior authorization request (approved, denied, or partially approved).',
    `denial_reason_code` STRING COMMENT 'The code provided by the payer indicating the reason for denial or partial approval of the prior authorization request.',
    `denial_reason_description` STRING COMMENT 'A textual description of the reason the prior authorization was denied or partially approved, as provided by the payer.',
    `payer_type` STRING COMMENT 'The category or type of payer (e.g., Medicare, Medicaid, commercial insurance, HMO, PPO, POS). [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|hmo|ppo|pos|self_pay|other — 8 candidates stripped; promote to reference product]',
    `peer_review_completed_date` DATE COMMENT 'The date a peer-to-peer review was completed between the requesting provider and the payers medical director or reviewer.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates whether the payer requires a peer-to-peer review (physician-to-physician discussion) as part of the prior authorization process. True if required, False otherwise.',
    `rendering_provider_npi` STRING COMMENT 'The 10-digit NPI of the provider who will render or perform the authorized service. May differ from the requesting provider.. Valid values are `^[0-9]{10}$`',
    `requested_service_cpt_code` STRING COMMENT 'The CPT or HCPCS code representing the primary service or procedure for which prior authorization is requested.',
    `requested_units` DECIMAL(18,2) COMMENT 'The number of units or quantity of the service requested in the prior authorization (e.g., number of visits, procedures, or items).',
    `service_setting` STRING COMMENT 'The care setting or place of service where the authorized service will be delivered (e.g., inpatient, outpatient, home health). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|home_health|skilled_nursing|ambulatory_surgery|other — 7 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'The date the prior authorization request was submitted to the payer.',
    `units_consumed` DECIMAL(18,2) COMMENT 'The cumulative number of units consumed or utilized to date against the approved authorization. Used for utilization tracking and to prevent over-utilization.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this prior authorization record was last updated or modified.',
    `urgency_level` STRING COMMENT 'The urgency classification of the prior authorization request. Indicates how quickly a decision is needed (routine, urgent, emergent).. Valid values are `routine|urgent|emergent`',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Prior authorization (PA) requests submitted to payers for services requiring pre-approval before delivery. Captures authorization number, requesting provider NPI, payer ID, requested service CPT/HCPCS code, requested units, clinical indication ICD-10 codes, submission date, decision date, authorization status (approved, denied, pending, cancelled, expired), approved units, approved date range, urgency level (routine, urgent, emergent), and authorization source (phone, portal, fax, EDI 278). Includes authorized service line detail: individual CPT/HCPCS codes authorized, authorized units per service, authorized date ranges, service setting (inpatient, outpatient, home health), rendering and facility provider NPIs, and units consumed to date for utilization tracking against approved limits. SSOT for PA tracking across all payer types and supports claim-to-authorization matching during adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`eligibility` (
    `eligibility_id` BIGINT COMMENT 'Primary key for eligibility',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider or facility for which eligibility is being verified.',
    `mpi_record_id` BIGINT COMMENT 'Insurance member identifier for the patient, which may differ from subscriber ID if the patient is a dependent. Used for payer eligibility lookups.',
    `eligibility_patient_mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom eligibility is being verified. Links to the patient master data product.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or staff member who initiated the eligibility verification request.',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: Eligibility checks via FHIR Coverage/Patient resources are logged in fhir_resource_log. IT operations and registration staff track FHIR-based eligibility verifications for troubleshooting API failures',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Real-time eligibility verification validates member benefits (copays, deductibles, coverage limits) at health plan level, not just payer. Essential for accurate patient responsibility estimation and a',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Eligibility checks verify benefits for a specific coverage on file. Linking enables reconciliation of real-time eligibility responses with stored coverage records, identifying discrepancies in member ',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Eligibility verifications (270/271 transactions) are transmitted via specific interface channels to payers/clearinghouses. Registration staff and IT operations track which channel was used for trouble',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization to which the eligibility verification request was submitted.',
    `subscriber_id` BIGINT COMMENT 'Insurance subscriber identifier assigned by the payer, representing the primary policyholder. This is the member ID on the insurance card.',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Eligibility verifications are sent to specific trading partners (clearinghouses or direct payer connections). Registration staff and IT operations track which trading partner processed each verificati',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter for which eligibility is being verified, if the verification is tied to a specific visit.',
    `clearinghouse_name` STRING COMMENT 'Name of the clearinghouse intermediary used to submit the eligibility verification request to the payer, if applicable.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered service costs that the patient is responsible for paying after the deductible is met, expressed as a decimal (e.g., 20.00 for 20% coinsurance).',
    `coordination_of_benefits_order` STRING COMMENT 'Order in which this insurance plan pays when the patient has multiple insurance coverages. Primary pays first, secondary pays after primary, tertiary pays after secondary.. Valid values are `primary|secondary|tertiary`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the patient is required to pay at the time of service as a copayment under their insurance plan.',
    `coverage_effective_date` DATE COMMENT 'Date on which the insurance coverage became or will become effective and active for the patient.',
    `coverage_level` STRING COMMENT 'Level of coverage indicating whether the plan covers an individual only, family, employee and spouse, employee and children, or employee and family.. Valid values are `individual|family|employee_spouse|employee_children|employee_family`',
    `coverage_status` STRING COMMENT 'Current status of the insurance coverage indicating whether it is active, inactive, terminated, suspended, or pending activation.. Valid values are `active|inactive|terminated|suspended|pending`',
    `coverage_termination_date` DATE COMMENT 'Date on which the insurance coverage terminated or will terminate. Null if coverage is ongoing without a known end date.',
    `coverage_type` STRING COMMENT 'Type of healthcare coverage being verified: medical, dental, vision, pharmacy, behavioral health, or durable medical equipment (DME).. Valid values are `medical|dental|vision|pharmacy|behavioral_health|durable_medical_equipment`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility verification record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Total annual deductible amount the patient must pay out-of-pocket before insurance coverage begins paying for covered services.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Amount of the annual deductible that has already been met by the patient as of the verification date.',
    `deductible_remaining_amount` DECIMAL(18,2) COMMENT 'Amount of the annual deductible that remains to be met by the patient before insurance coverage begins.',
    `group_number` STRING COMMENT 'Insurance group number identifying the employer or organization plan under which the patient is covered.',
    `network_status` STRING COMMENT 'Indicates whether the provider or facility for which eligibility is being verified is in-network, out-of-network, or unknown under the patients insurance plan.. Valid values are `in_network|out_of_network|unknown`',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the patient is required to pay out-of-pocket for covered services in a plan year, after which the insurance pays 100% of covered expenses.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Amount of the out-of-pocket maximum that has already been met by the patient as of the verification date.',
    `pcp_name` STRING COMMENT 'Name of the Primary Care Physician assigned to the patient under this insurance plan, if applicable.',
    `pcp_npi` STRING COMMENT 'National Provider Identifier (NPI) of the Primary Care Physician assigned to the patient, a unique 10-digit identifier.. Valid values are `^[0-9]{10}$`',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before services can be rendered and covered under this plan.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether a referral from a Primary Care Physician (PCP) is required for specialist visits or certain services under this plan.',
    `rejection_reason` STRING COMMENT 'Reason provided by the payer or clearinghouse if the eligibility verification request was rejected or could not be processed.',
    `response_code` STRING COMMENT 'Standardized code returned by the payer indicating the result of the eligibility verification request (e.g., eligible, not eligible, invalid subscriber).',
    `response_description` STRING COMMENT 'Human-readable description of the eligibility verification response, providing additional context or explanation for the response code.',
    `service_date` DATE COMMENT 'Date of service for which eligibility is being verified. Used to check coverage status as of a specific date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility verification record was last modified in the system.',
    `verification_date` DATE COMMENT 'Business date on which the eligibility verification was performed, used for reporting and analytics purposes.',
    `verification_method` STRING COMMENT 'Method by which the eligibility verification was performed: real-time electronic transaction, batch file submission, manual entry, payer web portal, or phone call.. Valid values are `real_time|batch|manual|portal|phone`',
    `verification_request_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility verification request was submitted to the payer or clearinghouse. This is the principal business event timestamp for the transaction.',
    `verification_response_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility verification response was received from the payer or clearinghouse.',
    `verification_status` STRING COMMENT 'Current lifecycle status of the eligibility verification request indicating whether the transaction has been submitted, is pending payer response, completed successfully, failed, timed out, or was rejected.. Valid values are `submitted|pending|completed|failed|timeout|rejected`',
    `verification_transaction_number` STRING COMMENT 'Business identifier for the eligibility verification transaction, typically the X12 270 transaction control number or system-generated verification request number used for tracking and reconciliation.',
    CONSTRAINT pk_eligibility PRIMARY KEY(`eligibility_id`)
) COMMENT 'Real-time and batch eligibility verification transactions submitted to payers to confirm patient insurance coverage prior to service delivery or claim submission. Captures verification date, payer ID, subscriber ID, member ID, group number, plan name, coverage type (medical, dental, vision, pharmacy), coverage effective date, coverage termination date, copay amount, deductible amount, deductible met amount, out-of-pocket maximum, coinsurance percentage, coordination of benefits order, and verification response status. Sourced from ANSI X12 270/271 transactions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Primary key for cob',
    `claim_id` BIGINT COMMENT 'Reference to the claim that requires coordination of benefits due to multiple insurance coverages.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer with secondary responsibility for claim payment after primary payer adjudication. May be null if only one payer exists.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who has multiple insurance coverages requiring coordination.',
    `primary_payer_id` BIGINT COMMENT 'Reference to the insurance payer with primary responsibility for claim payment. First in the COB sequence.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: COB coordination requires knowing specific secondary and tertiary plan benefit structures for birthday rule application, benefit stacking calculations, and payment sequencing. Plan-level details (not ',
    `tertiary_payer_id` BIGINT COMMENT 'Reference to the insurance payer with tertiary responsibility for claim payment after secondary payer adjudication. May be null if fewer than three payers exist.',
    `birthday_rule_applied` BOOLEAN COMMENT 'Flag indicating whether the birthday rule was applied to determine primary coverage for dependent children with coverage under both parents plans. The parent whose birthday occurs earlier in the calendar year provides primary coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination of benefits record was first created in the system.',
    `crossover_claim_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a Medicare/Medicaid crossover claim where Medicare automatically forwards claim information to Medicaid for secondary payment.',
    `determination_date` DATE COMMENT 'Date when the coordination of benefits order and payer responsibility sequence was determined and documented.',
    `determination_method` STRING COMMENT 'Specific method or rule used to determine the order of benefit responsibility among multiple payers.. Valid values are `birthday_rule|gender_rule|court_order|plan_provision|active_inactive|continuation_coverage`',
    `duplicate_payment_prevention_flag` BOOLEAN COMMENT 'Flag indicating that duplicate payment prevention controls are active for this COB record to ensure no payer pays more than their responsibility.',
    `gender_rule_applied` BOOLEAN COMMENT 'Flag indicating whether the gender rule was applied when birthday rule cannot determine primary coverage (same birthday). Male parent typically provides primary coverage under this rule.',
    `method` STRING COMMENT 'Method used to coordinate benefits between multiple payers: standard (traditional COB), carve_out (specific services excluded), non_duplication (no duplicate payment), maintenance_of_benefits (MOB - ensures patient receives full benefit).. Valid values are `standard|carve_out|non_duplication|maintenance_of_benefits`',
    `msp_indicator` BOOLEAN COMMENT 'Flag indicating whether Medicare is the secondary payer due to other primary coverage such as employer group health plan, workers compensation, or liability insurance.',
    `msp_type_code` STRING COMMENT 'Code identifying the type of Medicare Secondary Payer situation: EGHP (Employer Group Health Plan), WC (Workers Compensation), AUTO (Automobile Insurance), LIABILITY (Liability Insurance), VA (Veterans Affairs), ESRD (End-Stage Renal Disease), DISABILITY (Disability), NONE (Medicare is primary). [ENUM-REF-CANDIDATE: EGHP|WC|AUTO|LIABILITY|VA|ESRD|DISABILITY|NONE — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, exceptions, or additional details about the coordination of benefits determination.',
    `order_sequence` STRING COMMENT 'Sequential order in which payers are responsible for payment (1=primary, 2=secondary, 3=tertiary). Determines the cascade of payer responsibility.',
    `other_insurance_on_file_date` DATE COMMENT 'Date when the existence of other insurance coverage was documented and recorded in the system.',
    `primary_adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount adjusted (written off or reduced) by the primary payer due to contractual agreements or policy limitations.',
    `primary_adjustment_reason_code` STRING COMMENT 'Standardized code explaining why the primary payer adjusted the billed amount. Follows CARC (Claim Adjustment Reason Code) standards.',
    `primary_allowed_amount` DECIMAL(18,2) COMMENT 'Amount approved by the primary payer as eligible for payment based on contract terms and fee schedules.',
    `primary_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the primary payer before any adjustments or payments.',
    `primary_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the primary payer after applying deductibles, coinsurance, and copayments.',
    `primary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Amount the patient is responsible for after primary payer adjudication, including deductibles, coinsurance, and copayments.',
    `secondary_adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount adjusted by the secondary payer due to contractual agreements or coordination of benefits rules.',
    `secondary_adjustment_reason_code` STRING COMMENT 'Standardized code explaining why the secondary payer adjusted the billed amount. Follows CARC standards.',
    `secondary_allowed_amount` DECIMAL(18,2) COMMENT 'Amount approved by the secondary payer as eligible for payment based on contract terms and coordination rules.',
    `secondary_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the secondary payer, typically the patient responsibility amount from the primary payer.',
    `secondary_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the secondary payer after considering primary payer payment and secondary plan benefits.',
    `secondary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Remaining amount the patient is responsible for after both primary and secondary payer adjudications.',
    `cob_status` STRING COMMENT 'Current lifecycle status of the coordination of benefits process for this claim.. Valid values are `pending|determined|in_process|completed|disputed|reversed`',
    `tertiary_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the tertiary payer, typically the remaining patient responsibility after secondary payer adjudication.',
    `tertiary_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the tertiary payer after considering primary and secondary payer payments.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Final amount the patient owes after all payer adjudications in the coordination of benefits sequence are complete.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination of benefits record was last modified or updated.',
    `verification_date` DATE COMMENT 'Date when the coordination of benefits information was last verified with the patient or payers.',
    `verification_method` STRING COMMENT 'Method used to verify the coordination of benefits information and payer order.. Valid values are `patient_interview|payer_inquiry|eligibility_check|eob_review|automated_system`',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Coordination of Benefits (COB) records managing claims where a patient has multiple insurance coverages. Captures primary payer ID, secondary payer ID, tertiary payer ID, COB order, primary paid amount, primary allowed amount, primary adjustment reason, secondary billed amount, secondary paid amount, COB determination date, and Medicare Secondary Payer (MSP) indicator. Ensures correct sequencing of payer responsibility and prevents duplicate payment. Critical for Medicare/Medicaid crossover claims.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` (
    `authorization_service_id` BIGINT COMMENT 'Unique identifier for the authorization service line record. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Authorization service tracking requires CPT metadata for utilization monitoring, unit consumption validation, and service-level authorization management. Every authorization_service.procedure_code mus',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Service-level facility tracking enables site-specific authorization compliance monitoring, facility utilization analysis, and network adequacy reporting. Required for multi-site authorization manageme',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Authorization service medical necessity requires ICD code metadata for diagnosis validation and clinical appropriateness verification at the service line level. Every authorization_service.diagnosis_c',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan that issued this authorization. Used for payer-specific authorization rules and reporting.',
    `prior_authorization_id` BIGINT COMMENT 'Reference to the parent prior authorization under which this service line is authorized. Links to the authorization header record.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Service-level provider tracking enables utilization analysis by clinician, authorization consumption monitoring, and provider-specific authorization patterns. Essential for utilization management repo',
    `authorized_amount` DECIMAL(18,2) COMMENT 'The maximum reimbursement amount authorized per unit or per service line by the payer. Used for financial tracking and claim adjudication limits.',
    `authorized_units` DECIMAL(18,2) COMMENT 'The total number of units authorized for this service line under the prior authorization. Represents the approved limit against which utilization is tracked.',
    `clinical_review_required` BOOLEAN COMMENT 'Indicates whether clinical review or additional documentation is required before services under this authorization can be rendered or reimbursed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this authorization service line record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the authorized amount (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `diagnosis_code` STRING COMMENT 'The primary ICD-10 diagnosis code that justifies the medical necessity for this authorized service. Used for clinical validation and claim adjudication.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `extension_count` STRING COMMENT 'The number of times this authorization service line has been extended beyond its original service_to_date. Used for tracking authorization modifications and payer communication.',
    `last_claim_date` DATE COMMENT 'The date of the most recent claim submitted against this authorization service line. Used for utilization tracking and authorization expiration monitoring.',
    `line_number` STRING COMMENT 'Sequential line number within the parent authorization, used for ordering and referencing individual service lines.',
    `modifier_1` STRING COMMENT 'The first CPT or HCPCS modifier authorized for this service line, providing additional information about the service performed (e.g., bilateral procedure, multiple procedures).. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'The second CPT or HCPCS modifier authorized for this service line, if applicable.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_3` STRING COMMENT 'The third CPT or HCPCS modifier authorized for this service line, if applicable.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_4` STRING COMMENT 'The fourth CPT or HCPCS modifier authorized for this service line, if applicable.. Valid values are `^[A-Z0-9]{2}$`',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this authorization service line, such as payer requirements, clinical conditions, or utilization management guidance.',
    `payer_authorization_number` STRING COMMENT 'The unique authorization or reference number assigned by the payer for this service line. Used for claim submission and payer correspondence.',
    `peer_review_completed` BOOLEAN COMMENT 'Indicates whether peer-to-peer clinical review has been completed for this authorization service line, typically required for high-cost or complex procedures.',
    `procedure_code` STRING COMMENT 'The specific CPT or HCPCS procedure code authorized for this service line. Used for claim-to-authorization matching during adjudication.. Valid values are `^[0-9A-Z]{5}$`',
    `service_from_date` DATE COMMENT 'The start date of the authorized service period for this service line. Services rendered before this date are not covered under this authorization.',
    `service_setting` STRING COMMENT 'The care setting or place of service where the authorized procedure or service may be performed, such as inpatient, outpatient, home health, or skilled nursing facility. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|home_health|skilled_nursing|ambulatory_surgery|telehealth — 7 candidates stripped; promote to reference product]',
    `service_status` STRING COMMENT 'Current status of this authorization service line in its lifecycle. Active indicates available for use; partially_used indicates some units consumed; fully_used indicates all units consumed; expired indicates service period ended; cancelled indicates authorization revoked; suspended indicates temporarily on hold.. Valid values are `active|partially_used|fully_used|expired|cancelled|suspended`',
    `service_to_date` DATE COMMENT 'The end date of the authorized service period for this service line. Services rendered after this date are not covered under this authorization unless extended.',
    `unit_of_measure` STRING COMMENT 'The unit type for the authorized quantity, such as visits, days, hours, sessions, or procedures. Defines how authorized_units should be interpreted. [ENUM-REF-CANDIDATE: visits|days|hours|sessions|units|procedures|treatments — 7 candidates stripped; promote to reference product]',
    `units_consumed` DECIMAL(18,2) COMMENT 'The cumulative number of units consumed or utilized against this authorization service line to date. Updated as claims are adjudicated and matched to the authorization.',
    `units_remaining` DECIMAL(18,2) COMMENT 'The number of authorized units still available for use, calculated as authorized_units minus units_consumed. Used to prevent over-utilization and authorization-related denials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this authorization service line record was last modified. Used for audit trail and change tracking.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of authorized units that have been consumed, calculated as (units_consumed / authorized_units) * 100. Used for utilization tracking and alerts.',
    CONSTRAINT pk_authorization_service PRIMARY KEY(`authorization_service_id`)
) COMMENT 'Individual service lines authorized under a prior authorization, capturing the specific CPT/HCPCS code authorized, authorized units, authorized date range, service setting (inpatient, outpatient, home health), rendering provider NPI, facility NPI, and units consumed to date. Enables tracking of authorization utilization against approved limits and supports claim-to-authorization matching during adjudication to prevent authorization-related denials.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` (
    `study_attribution_id` BIGINT COMMENT 'Unique identifier for this claim-study attribution record. Primary key.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to the insurance claim being attributed to research activity',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study receiving attribution for claim services',
    `attribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the claim attributed to this research study, calculated by applying service_attribution_percentage to claim totals. Used for sponsor invoicing and research cost accounting.',
    `attribution_rationale` STRING COMMENT 'Free-text explanation of why this claim was attributed to this study, referencing protocol procedures, coverage analysis, or regulatory guidance. Required for audit trail and sponsor transparency.',
    `attribution_status` STRING COMMENT 'Lifecycle status of the attribution determination. PENDING_REVIEW = awaiting coverage analysis; DETERMINED = billing responsibility established; DISPUTED = sponsor or payer contest; RESOLVED = dispute settled; INVOICED = billed to responsible party; PAID = payment received.',
    `billing_responsibility` STRING COMMENT 'Entity responsible for payment of the attributed services. PAYER = insurance covers as standard-of-care; SPONSOR = research budget covers; PATIENT = patient responsibility; SPLIT = shared responsibility requiring coordination.',
    `coverage_determination_date` DATE COMMENT 'Date on which the coverage determination was made for this claim-study attribution, establishing billing responsibility between payer, patient, and sponsor.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this attribution record was created in the system.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this attribution record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this attribution record was last updated.',
    `research_only_flag` BOOLEAN COMMENT 'Indicates whether the services on this claim are solely for research purposes with no clinical benefit to the patient. True = not billable to insurance, sponsor responsible; False = has clinical component.',
    `service_attribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of claim services attributable to this research study. Supports scenarios where a single claim spans multiple concurrent trials. Sum across all studies for a claim may equal 100% or less.',
    `sponsor_invoice_number` STRING COMMENT 'Invoice number issued to the study sponsor for research-attributable services on this claim. Null if billing responsibility is not sponsor.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates whether the services on this claim represent standard-of-care treatment that would be provided regardless of research participation. True = billable to insurance; False = research-only service.',
    `created_by` STRING COMMENT 'User or system identifier that created this attribution record.',
    CONSTRAINT pk_study_attribution PRIMARY KEY(`study_attribution_id`)
) COMMENT 'This association product represents the billing attribution relationship between insurance claims and research studies. It captures the operational linkage required for clinical trial billing compliance, determining which portions of a claim are attributable to research protocols versus standard-of-care, and establishing billing responsibility between the institution and study sponsor. Each record links one claim to one research study with attributes that govern coverage determination and sponsor invoicing.. Existence Justification: In healthcare research operations, a single insurance claim can legitimately span multiple concurrent research studies when a patient is enrolled in multiple trials simultaneously (e.g., a cancer treatment trial plus a supportive care trial). Conversely, each research study generates thousands of claims across its enrolled patient population. The business actively manages claim-study attribution records to ensure clinical trial billing compliance, determine coverage responsibility (standard-of-care vs research-only services), and generate accurate sponsor invoices.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` (
    `audit_sample_id` BIGINT COMMENT 'Primary key for the claim_audit_sample association',
    `audit_id` BIGINT COMMENT 'Foreign key linking to the compliance audit',
    `claim_id` BIGINT COMMENT 'Foreign key linking to the claim being audited',
    `audit_scope_reason` STRING COMMENT 'The specific rationale or criteria that caused this claim to be included in the audit scope (e.g., high-dollar claim, specific DRG, outlier payment, prior denial history)',
    `claim_review_status` STRING COMMENT 'The current status of the audit review for this specific claim within the audit lifecycle',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required as a result of findings identified in this claim review',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The monetary impact (overpayment, underpayment, or adjustment) identified during the audit review of this claim',
    `finding_description` STRING COMMENT 'Detailed description of any compliance finding, deficiency, or issue identified during the audit review of this claim',
    `finding_severity` STRING COMMENT 'The severity level of any compliance finding or deficiency identified during the audit review of this claim',
    `review_completion_date` DATE COMMENT 'The date when the audit review of this specific claim was completed',
    `review_start_date` DATE COMMENT 'The date when the audit review of this specific claim began',
    `reviewer_name` STRING COMMENT 'The name of the auditor or reviewer assigned to review this specific claim',
    `sample_selection_method` STRING COMMENT 'The methodology used to select this claim for inclusion in the audit sample (e.g., random sampling, risk-based selection, targeted review)',
    `sample_sequence_number` STRING COMMENT 'The sequential order or identifier of this claim within the audit sample set',
    `selected_date` DATE COMMENT 'The date when this claim was selected for inclusion in the audit sample',
    CONSTRAINT pk_audit_sample PRIMARY KEY(`audit_sample_id`)
) COMMENT 'This association product represents the inclusion of a specific claim in a compliance audit sample. It captures the selection rationale, review status, and findings for each claim-audit pair. Each record links one claim to one audit with attributes that exist only in the context of this audit review relationship.. Existence Justification: In healthcare compliance operations, audits routinely sample multiple claims for review (RAC audits typically review 30-50 claims per provider, Joint Commission surveys sample across multiple encounters). Individual claims can be included in multiple audits over time—an initial HIPAA audit, a follow-up verification audit, a separate OIG work plan audit, or a CMS validation survey. The business actively manages claim audit samples as operational records, tracking selection rationale, review status, findings, and corrective actions for each claim-audit pair.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim_line` (
    `claim_line_id` BIGINT COMMENT 'Unique identifier for the claim line item. Primary key for the claim line product.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Line-level facility tracking required for multi-site encounters where different services occur at different facilities. Critical for accurate revenue allocation, cost center reporting, and line-item a',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Claim lines represent billed charges submitted to payers. Reconciliation between charges captured in billing and claim lines submitted requires direct linkage. Denial analysis, charge capture audits, ',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim header under which this line item is submitted. Links the line to the overall claim submission.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure code billing requires CPT metadata for RVU calculation, NCCI edit validation, global period determination, modifier requirements, and payment calculation. Every claim_line.procedure_code (wh',
    `fulfillment_id` BIGINT COMMENT 'Foreign key linking to order.order_fulfillment. Business justification: Claim line items are generated from order fulfillment events for charge capture. Billing systems link line items to fulfillment records to validate quantities, CPT codes, and service dates. Critical f',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: HCPCS procedure billing requires HCPCS metadata for DME coverage determination, drug billing validation, quantity limits, prior authorization requirements, and ASC/OPPS payment indicators. Every claim',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each claim line represents a billable supply, device, or drug with procedure/revenue codes. Link required for: line-level revenue cycle reconciliation matching charges to supply costs, formulary compl',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Line-level provider attribution enables procedure-specific payment distribution, RVU calculation, and productivity reporting. Required for split billing and multi-provider encounters. NPI denormalized',
    `adjudication_date` DATE COMMENT 'The date the payer completed adjudication and made a payment decision for this specific line item.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The total amount of contractual adjustments, write-offs, or other reductions applied to this line item by the payer.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The maximum amount the payer will reimburse for this line item based on contracted rates, fee schedules, or payer policies. Also known as the approved or eligible amount.',
    `authorization_number` STRING COMMENT 'The authorization or referral number assigned by the payer approving this specific service. Required when prior authorization was obtained.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The total amount billed to the payer for this line item, representing the providers charge before any adjustments or contractual allowances.',
    `coordination_of_benefits_indicator` STRING COMMENT 'Indicates whether this line item is being billed to the primary, secondary, or tertiary payer in coordination of benefits scenarios.. Valid values are `primary|secondary|tertiary`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this claim line record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'The standardized code indicating why the line item was denied, adjusted, or not paid in full. Used for denial management and appeals.. Valid values are `^[A-Z0-9]{1,5}$`',
    `diagnosis_pointer_1` STRING COMMENT 'Letter (A-L) linking this line item to one of the diagnosis codes on the claim header, indicating which diagnosis justifies this service. First diagnosis pointer.. Valid values are `^[A-L]$`',
    `diagnosis_pointer_2` STRING COMMENT 'Letter (A-L) linking this line item to a second diagnosis code on the claim header. Second diagnosis pointer.. Valid values are `^[A-L]$`',
    `diagnosis_pointer_3` STRING COMMENT 'Letter (A-L) linking this line item to a third diagnosis code on the claim header. Third diagnosis pointer.. Valid values are `^[A-L]$`',
    `diagnosis_pointer_4` STRING COMMENT 'Letter (A-L) linking this line item to a fourth diagnosis code on the claim header. Fourth diagnosis pointer.. Valid values are `^[A-L]$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'The relative weight assigned to the DRG for this line item, used in calculating facility reimbursement under prospective payment systems.',
    `drug_quantity` DECIMAL(18,2) COMMENT 'The quantity of drug dispensed for pharmacy line items, measured in the appropriate unit (e.g., tablets, milliliters, grams).',
    `drug_unit_of_measure` STRING COMMENT 'Two-character code indicating the unit of measure for the drug quantity (e.g., EA for each, ML for milliliter, GM for gram).. Valid values are `^[A-Z]{2}$`',
    `line_number` STRING COMMENT 'Sequential line number within the claim, used to order and identify individual service lines on professional (CMS-1500) and facility (UB-04) claims.',
    `line_status` STRING COMMENT 'Current adjudication status of this claim line item in the payer processing workflow.. Valid values are `submitted|pending|adjudicated|paid|denied|appealed`',
    `modifier_1` STRING COMMENT 'First two-character CPT or HCPCS modifier code providing additional information about the service performed (e.g., bilateral procedure, assistant surgeon, distinct procedural service).. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'Second two-character CPT or HCPCS modifier code providing additional information about the service performed.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_3` STRING COMMENT 'Third two-character CPT or HCPCS modifier code providing additional information about the service performed.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_4` STRING COMMENT 'Fourth two-character CPT or HCPCS modifier code providing additional information about the service performed.. Valid values are `^[A-Z0-9]{2}$`',
    `ndc_code` STRING COMMENT 'Eleven-digit National Drug Code identifying the specific drug product dispensed. Required for pharmacy line items and certain medical claims involving drugs.. Valid values are `^[0-9]{11}$`',
    `ordering_provider_npi` STRING COMMENT 'Ten-digit National Provider Identifier of the provider who ordered the service (e.g., physician ordering lab tests or imaging studies).. Valid values are `^[0-9]{10}$`',
    `outlier_payment_amount` DECIMAL(18,2) COMMENT 'Additional payment amount for cases that exceed typical cost thresholds, applicable to high-cost inpatient stays under Medicare IPPS.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by the payer for this line item after applying deductibles, coinsurance, copayments, and other adjustments.',
    `paid_date` DATE COMMENT 'The date payment was issued by the payer for this line item, typically matching the remittance advice date.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The portion of the line item charge that is the patients financial responsibility, including deductibles, coinsurance, and copayments.',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the physical location where the service was rendered (e.g., 11 for office, 21 for inpatient hospital, 23 for emergency department).. Valid values are `^[0-9]{2}$`',
    `procedure_code` STRING COMMENT 'The CPT or HCPCS code representing the specific billable service or procedure performed. Five-character alphanumeric code used for billing and reimbursement.. Valid values are `^[0-9A-Z]{5}$`',
    `remark_code` STRING COMMENT 'Supplemental code providing additional explanation or context for the line item adjudication decision, often used alongside denial reason codes.. Valid values are `^[A-Z0-9]{1,5}$`',
    `revenue_code` STRING COMMENT 'Four-digit code used on facility claims (UB-04) to classify the type of service or accommodation provided (e.g., room and board, pharmacy, laboratory). Required for institutional billing.. Valid values are `^[0-9]{4}$`',
    `service_description` STRING COMMENT 'Free-text description of the service or procedure performed on this line item, providing additional clinical context beyond the procedure code.',
    `service_from_date` DATE COMMENT 'The start date of the service period for this line item. Represents the first date the service was rendered.',
    `service_to_date` DATE COMMENT 'The end date of the service period for this line item. For single-day services, this matches the service from date.',
    `units_of_service` DECIMAL(18,2) COMMENT 'The quantity of services rendered for this line item. May represent days, visits, procedures, or other unit measures depending on the service type.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this claim line record was last modified or updated.',
    CONSTRAINT pk_claim_line PRIMARY KEY(`claim_line_id`)
) COMMENT 'Individual service line items within a claim, each representing a distinct billable service rendered. Captures line number, CPT/HCPCS procedure code, revenue code, service date range, units of service, billed/allowed/paid amounts, line-level denial reason code, modifier codes (up to 4), place of service, rendering and ordering provider NPIs, diagnosis pointer linkage (up to 4 pointers per line), and NDC for pharmacy lines. Supports professional (CMS-1500) and facility (UB-04) claim line adjudication per CMS and HIPAA X12 837 specifications.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` (
    `claim_attachment_id` BIGINT COMMENT 'Unique identifier for the claim attachment record. Primary key.',
    `behavioral_health_consent_id` BIGINT COMMENT 'Foreign key linking to consent.behavioral_health_consent. Business justification: Behavioral health claims require submission of state-specific mental health consent forms as claim attachments for payer disclosure compliance. Billing teams must attach proper behavioral health conse',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Claim attachments must link to facility for medical records retrieval, document routing, and compliance workflows. Has facility_npi but needs FK to care_site for operational integration with facility ',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Claim attachments often reference CDA clinical documents (C-CDA Continuity of Care Documents) sent to payers for medical review. Revenue cycle teams link attachments to source CDA documents for tracki',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim to which this attachment is associated.',
    `claim_original_attachment_id` BIGINT COMMENT 'Reference to the original attachment record if this is a resubmission or corrected version.',
    `claim_superseded_attachment_id` BIGINT COMMENT 'Self-referencing FK on attachment (superseded_attachment_id)',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Claim attachment routing requires CPT metadata to determine documentation requirements, medical record guidelines, and clinical review criteria. Every claim_attachment.procedure_code must resolve to r',
    `demographics_id` BIGINT COMMENT 'Reference to the patient whose clinical information is contained in this attachment.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that submitted the attachment.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Attachments linked to facility for document routing to correct medical records department, facility-specific documentation requirements, and audit response coordination. Required for multi-facility or',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Claim attachment routing and clinical review requires ICD code metadata to determine medical record requirements, peer review criteria, and documentation guidelines. Every claim_attachment.diagnosis_c',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Claim attachments are transmitted through specific interface channels to payers. Revenue cycle teams track which channel transmitted each attachment for troubleshooting delivery failures and correlati',
    `payer_id` BIGINT COMMENT 'Reference to the payer organization to whom the attachment was submitted.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Attachments linked to provider for medical record request routing, documentation compliance tracking, and provider-specific attachment patterns. Essential for claims appeal and audit response workflow',
    `substance_use_consent_id` BIGINT COMMENT 'Foreign key linking to consent.substance_use_consent. Business justification: Substance use disorder claims must include 42 CFR Part 2 compliant consent forms as attachments for disclosure to payers. SUD billing compliance mandates that specific patient consent for disclosure a',
    `trading_partner_id` BIGINT COMMENT 'Identifier of the clearinghouse used to transmit the attachment electronically.',
    `visit_id` BIGINT COMMENT 'Reference to the specific patient encounter or visit associated with this attachment.',
    `attachment_number` STRING COMMENT 'Business-assigned unique number or identifier for this attachment within the claim context.',
    `attachment_status` STRING COMMENT 'Current lifecycle status of the attachment in the claims adjudication workflow.. Valid values are `pending|submitted|received|accepted|rejected|under_review`',
    `attachment_type` STRING COMMENT 'Classification of the attachment document type submitted with or in response to payer requests. [ENUM-REF-CANDIDATE: medical_record|operative_note|discharge_summary|lab_result|radiology_report|prior_authorization_letter|clinical_documentation|explanation_letter — 8 candidates stripped; promote to reference product]',
    `authorization_number` STRING COMMENT 'Prior authorization number referenced in the attachment documentation.',
    `clearinghouse_transaction_number` STRING COMMENT 'Transaction identifier assigned by the clearinghouse for tracking the attachment submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the attachment record was first created in the system.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code documented in the attachment, typically in ICD-10 format.',
    `document_description` STRING COMMENT 'Detailed description of the attachment content and purpose.',
    `document_format` STRING COMMENT 'File format or standard in which the attachment document is stored or transmitted. [ENUM-REF-CANDIDATE: pdf|tiff|jpeg|png|xml|hl7|fhir — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Descriptive title or name of the attachment document.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set identifier used for electronic attachment submission, typically 275 for attachments.',
    `encryption_status` STRING COMMENT 'Indicates whether the attachment file is encrypted at rest or in transit.. Valid values are `encrypted|unencrypted|in_transit_encrypted`',
    `file_size_bytes` BIGINT COMMENT 'Size of the attachment file measured in bytes.',
    `medical_record_number` STRING COMMENT 'Unique medical record number identifying the patient within the healthcare organization.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the attachment submission or content.',
    `page_count` STRING COMMENT 'Number of pages in the attachment document.',
    `payer_attachment_control_number` STRING COMMENT 'Unique control number assigned by the payer to track this attachment.',
    `phi_indicator` BOOLEAN COMMENT 'Flag indicating whether the attachment contains Protected Health Information subject to HIPAA privacy rules.',
    `procedure_code` STRING COMMENT 'Primary procedure code documented in the attachment, typically in CPT or HCPCS format.',
    `received_date` DATE COMMENT 'Date on which the payer acknowledged receipt of the attachment.',
    `redaction_required` BOOLEAN COMMENT 'Indicates whether the attachment requires redaction of sensitive information before external sharing.',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason the attachment was rejected by the payer.',
    `rejection_reason_description` STRING COMMENT 'Detailed description of why the attachment was rejected by the payer.',
    `request_date` DATE COMMENT 'Date on which the payer requested this attachment for claim adjudication.',
    `response_deadline_date` DATE COMMENT 'Date by which the attachment must be submitted to avoid claim denial or delay.',
    `resubmission_count` STRING COMMENT 'Number of times this attachment has been resubmitted to the payer.',
    `service_from_date` DATE COMMENT 'Start date of the service period covered by the clinical documentation in this attachment.',
    `service_to_date` DATE COMMENT 'End date of the service period covered by the clinical documentation in this attachment.',
    `storage_location` STRING COMMENT 'File path or storage system location where the attachment document is stored.',
    `submission_date` DATE COMMENT 'Date on which the attachment was submitted to the payer.',
    `submission_method` STRING COMMENT 'Method by which the attachment was submitted to the payer.. Valid values are `electronic|fax|mail|portal|edi`',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the attachment was submitted to the payer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the attachment record was last modified in the system.',
    CONSTRAINT pk_claim_attachment PRIMARY KEY(`claim_attachment_id`)
) COMMENT 'Supporting clinical documentation and attachments submitted with or in response to payer requests for claims, including medical records, operative notes, and prior authorization letters.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` (
    `claim_denial_id` BIGINT COMMENT 'Primary key for denial',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Denials generate AR adjustment transactions (write-offs, bad debt). AR adjustment workflow required for accurate receivables reporting. Healthcare finance tracks denial AR impact for allowance for dou',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Claim denials with systemic patterns trigger compliance audit findings requiring root cause analysis and corrective action per billing integrity programs. Healthcare compliance teams routinely link de',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the denied service was provided.',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim that was denied. Links this denial to the originating claim submission.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Denials are tracked by cost center for departmental performance monitoring and denial prevention initiatives. Denial management reporting requirement. Healthcare operations leaders analyze denial rate',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Denial root cause analysis and appeal preparation require linking to the specific coverage policy that was applied. Enables tracking policy-driven denial patterns, supporting policy review and appeal ',
    `deficiency_id` BIGINT COMMENT 'Foreign key linking to consent.consent_deficiency. Business justification: When claims are denied due to missing or invalid consent documentation, the denial record must reference the specific consent deficiency that caused the denial. Denial management teams track consent-r',
    `employee_id` BIGINT COMMENT 'Reference to the revenue cycle staff member or denial management specialist assigned to work this denial.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Denials require coverage verification to determine if denial was due to coverage limitations, benefit exhaustion, or policy exclusions. Critical for appeal preparation, benefit interpretation, and det',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Denials impact specific invoices and patient accounts. Denial management workflows require invoice context to determine patient responsibility, trigger rebilling, or initiate appeals. Revenue cycle re',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer who issued the denial (e.g., Medicare, Medicaid, commercial insurer).',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Denial tracking by provider enables root cause analysis, credentialing impact assessment, and provider-specific education. Critical for quality improvement and reappointment decisions. NPI denormalize',
    `quality_peer_review_id` BIGINT COMMENT 'Foreign key linking to quality.peer_review. Business justification: Denials for medical necessity trigger peer review for clinical appropriateness determination. Healthcare denial management workflows route cases to peer review committees; linking denial to review sup',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Denial management teams perform root cause analysis requiring direct visit context: LOS, discharge disposition, readmission flags, provider performance. Preventability assessment and provider feedback',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Denial write-offs and subsequent recoveries require GL entries to bad debt expense or recovery accounts. Standard healthcare bad debt accounting process. CFOs track denial financial impact through GL ',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Amount the payer allowed or approved for payment before applying the denial, in US dollars. May be zero if entire claim was denied.',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal must be filed according to payer contract terms or regulatory requirements (typically 30-180 days from denial date).',
    `appeal_filed_date` DATE COMMENT 'Date when a formal appeal was submitted to the payer to contest the denial. Null if no appeal has been filed.',
    `appeal_level` STRING COMMENT 'Current level of appeal in the multi-tier appeal process: first level (initial reconsideration), second level (qualified independent contractor), third level (administrative law judge), external review, or final administrative review.. Valid values are `first_level|second_level|third_level|external_review|administrative_law_judge`',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process: pending (under review), approved (denial overturned), partially approved (partial payment granted), denied (denial upheld), or withdrawn (appeal retracted).. Valid values are `pending|approved|partially_approved|denied|withdrawn`',
    `appeal_outcome_date` DATE COMMENT 'Date when the payer issued a decision on the appeal. Null if appeal is still pending.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount originally billed to the payer for the claim or claim line that was denied, in US dollars.',
    `carc_code` STRING COMMENT 'Primary denial reason code from the standard CARC code set maintained by the Washington Publishing Company, used on Electronic Remittance Advice (ERA) and Explanation of Benefits (EOB).',
    `carc_description` STRING COMMENT 'Human-readable description of the CARC code explaining the primary reason for the denial.',
    `claim_line_number` STRING COMMENT 'Line item number within the claim if the denial applies to a specific service line. Null if denial applies to entire claim header.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this denial record was first created in the system.',
    `denial_category` STRING COMMENT 'Business classification of the denial for root cause analysis: preventable, non-preventable, payer error, provider error, patient responsibility, or policy limitation.. Valid values are `preventable|non-preventable|payer_error|provider_error|patient_responsibility|policy_limitation`',
    `denial_date` DATE COMMENT 'Date when the payer issued the denial decision. This is the principal business event timestamp for the denial.',
    `denial_number` STRING COMMENT 'Business identifier for the denial, often assigned by the payer or internal denial management system for tracking and reference.',
    `denial_source` STRING COMMENT 'Origin of the denial: payer (insurance company), clearinghouse (intermediary), internal edit (pre-submission validation), or scrubber (automated claim review system).. Valid values are `payer|clearinghouse|internal_edit|scrubber`',
    `denial_type` STRING COMMENT 'High-level classification of the denial reason: clinical (medical necessity), administrative (documentation), technical (coding error), duplicate (already paid), eligibility (coverage issue), or authorization (prior auth missing).. Valid values are `clinical|administrative|technical|duplicate|eligibility|authorization`',
    `denied_amount` DECIMAL(18,2) COMMENT 'Amount denied by the payer, which may be the full billed amount or a partial denial, in US dollars.',
    `is_preventable` BOOLEAN COMMENT 'Boolean flag indicating whether the denial could have been prevented through better processes, documentation, or coding (True) or was unavoidable due to policy or patient factors (False).',
    `is_rac_audit` BOOLEAN COMMENT 'Boolean flag indicating whether this denial originated from a Recovery Audit Contractor (RAC) audit or post-payment review (True) versus a standard claim adjudication denial (False).',
    `medical_record_number` STRING COMMENT 'Medical Record Number (MRN) of the patient whose claim was denied, used for clinical documentation review during appeal preparation.',
    `notes` STRING COMMENT 'Free-text notes and comments from denial management staff documenting research, actions taken, and resolution strategy.',
    `patient_account_number` STRING COMMENT 'Patient account number associated with the denied claim, used for financial reconciliation and patient communication.',
    `priority_level` STRING COMMENT 'Priority assigned to the denial for workflow management based on dollar amount, appeal deadline, or strategic importance: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `rarc_code` STRING COMMENT 'Secondary remark code providing additional detail or context about the denial, used in conjunction with CARC on Electronic Remittance Advice (ERA).',
    `rarc_description` STRING COMMENT 'Human-readable description of the RARC code providing supplementary information about the denial.',
    `reason_text` STRING COMMENT 'Free-text explanation of the denial provided by the payer, often included in the Electronic Remittance Advice (ERA) or Explanation of Benefits (EOB).',
    `received_date` DATE COMMENT 'Date when the denial notification was received by the healthcare organization, which may differ from the payer denial date.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount successfully recovered through appeal or resubmission, in US dollars. Zero if denial was upheld or written off.',
    `resolution_status` STRING COMMENT 'Current status of the denial in the resolution workflow: open (newly received), under review (being analyzed), appealed (formal appeal submitted), overturned (appeal successful), upheld (appeal denied), written off (uncollectible), resubmitted (corrected and resubmitted), or closed (final resolution). [ENUM-REF-CANDIDATE: open|under_review|appealed|overturned|upheld|written_off|resubmitted|closed — 8 candidates stripped; promote to reference product]',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for addressing the denial (e.g., Patient Access, Health Information Management (HIM), Clinical Documentation Improvement (CDI), Coding, Billing).',
    `root_cause_code` STRING COMMENT 'Internal classification code identifying the underlying root cause of the denial for process improvement and prevention analytics.',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause analysis findings explaining why the denial occurred and how it could have been prevented.',
    `service_date` DATE COMMENT 'Date of service for the denied claim or claim line. Used for aging analysis and timely filing calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this denial record was last modified, reflecting the most recent status change or data update.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible after exhausting appeal options or determining appeal is not cost-effective, in US dollars.',
    `write_off_date` DATE COMMENT 'Date when the denied amount was written off in the financial system. Null if not yet written off.',
    CONSTRAINT pk_claim_denial PRIMARY KEY(`claim_denial_id`)
) COMMENT 'Master record for every claim or claim-line denial received from a payer. Captures denial date, denial type (clinical, administrative, technical, duplicate), primary denial reason code (CARC), secondary remark code (RARC), denial category, denial source (payer, clearinghouse, internal edit), billed amount denied, denial resolution status (open, appealed, overturned, upheld, written-off), root cause classification, and responsible department. SSOT for denial management workflow and denial prevention analytics.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` (
    `claim_appeal_id` BIGINT COMMENT 'Primary key for appeal',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who created this appeal record. Used for audit trail and accountability.',
    `claim_appeal_employee_id` BIGINT COMMENT 'Reference to the revenue cycle staff member or appeal specialist assigned to manage this appeal. Responsible for preparing documentation, tracking status, and coordinating with clinical staff.',
    `claim_appeal_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user identifier of the person who most recently modified this appeal record. Used for audit trail and accountability.',
    `claim_id` BIGINT COMMENT 'Reference to the original claim that was denied or underpaid and is being appealed.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Successful appeals revealing process failures require corrective action plans to prevent recurrence per compliance protocols. CMS and commercial payers mandate CAPs for systemic appeal overturn patter',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Appeals often challenge specific coverage policy application or interpretation. Linking appeal to contested policy supports appeal preparation, clinical documentation requirements identification, poli',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Appeals reference the specific coverage under which the original claim was denied. Essential for citing policy language, benefit limits, and coverage terms in appeal letters. Appeals staff must access',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Appeals contest denied claims tied to specific invoices. Revenue recovery workflows require invoice linkage to track appeal outcomes, post overturned amounts, and update patient balances. Financial re',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that denied the claim and is adjudicating the appeal. May be HMO (Health Maintenance Organization), PPO (Preferred Provider Organization), POS (Point of Service), Medicare, Medicaid, or commercial insurer.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Successful appeals generate revenue recovery journal entries reversing prior write-offs or recognizing new revenue. Appeals accounting process required for accurate revenue reporting and measuring app',
    `appeal_level` STRING COMMENT 'The hierarchical level of the appeal in the multi-stage appeal process. First-level is initial reconsideration, second-level is escalated internal review, external review involves independent third-party, and arbitration is binding dispute resolution.. Valid values are `first_level|second_level|external_review|arbitration`',
    `appeal_number` STRING COMMENT 'Business identifier for the appeal, typically assigned by the payer or internal system. Used for tracking and correspondence with payers.',
    `appeal_status` STRING COMMENT 'Current state of the appeal in its lifecycle. Draft indicates preparation stage, submitted means filed with payer, under_review indicates active payer evaluation, pending_documentation awaits additional information, overturned means appeal succeeded, upheld means denial stands, partial indicates partial approval, withdrawn means provider cancelled, expired means deadline passed. [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_documentation|overturned|upheld|partial|withdrawn|expired — 9 candidates stripped; promote to reference product]',
    `appeal_type` STRING COMMENT 'Classification of the appeal based on the nature of the dispute. Clinical appeals challenge medical necessity or appropriateness of care decisions. Administrative appeals address procedural or billing errors. Expedited appeals are fast-tracked for urgent situations. Standard appeals follow normal timelines.. Valid values are `clinical|administrative|expedited|standard`',
    `clinical_rationale` STRING COMMENT 'Detailed clinical justification for the appeal, explaining why the denied service was medically necessary and appropriate. Typically authored by clinical staff or medical director for clinical appeals.',
    `coordination_of_benefits_issue_flag` BOOLEAN COMMENT 'Indicates whether the denial and appeal involve coordination of benefits disputes between multiple payers. True when primary/secondary payer responsibility is contested.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this appeal record was first created in the system. Represents the start of internal appeal tracking, which may precede formal submission to payer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this appeal. Typically USD for US healthcare operations.. Valid values are `USD`',
    `deadline_date` DATE COMMENT 'The final date by which the appeal must be submitted to the payer to be considered timely. Calculated based on payer contract terms and regulatory requirements. Missing this deadline typically results in automatic denial.',
    `denial_reason_code` STRING COMMENT 'The standardized code provided by the payer indicating why the claim was denied or underpaid. This is the basis for the appeal and drives the appeal strategy.',
    `denial_reason_description` STRING COMMENT 'Human-readable explanation of why the claim was denied or underpaid, corresponding to the denial reason code. Provides context for appeal preparation.',
    `denied_amount` DECIMAL(18,2) COMMENT 'The portion of the claim amount that was denied by the payer and is subject to appeal. May be partial or full claim amount.',
    `external_review_requested_flag` BOOLEAN COMMENT 'Indicates whether the provider has requested or intends to request an independent external review by a third-party organization. True when escalating beyond internal payer appeals.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this appeal record was most recently updated. Tracks all changes to appeal status, documentation, or outcome throughout the appeal lifecycle.',
    `notes` STRING COMMENT 'Free-text field for appeal specialists to document internal notes, strategy decisions, communication log with payer, and other contextual information not captured in structured fields.',
    `original_claim_amount` DECIMAL(18,2) COMMENT 'The total amount originally billed on the claim before denial or underpayment. Represents the full requested reimbursement.',
    `outcome_code` STRING COMMENT 'Standardized code provided by the payer indicating the final decision on the appeal. Maps to outcome categories such as overturned, upheld, or partial approval.',
    `outcome_description` STRING COMMENT 'Human-readable explanation of the payers final decision on the appeal. Provides rationale for overturning, upholding, or partially approving the appeal.',
    `overturn_amount` DECIMAL(18,2) COMMENT 'The dollar amount successfully recovered through the appeal process. Populated when appeal status is overturned or partial. Zero if appeal is upheld.',
    `payer_appeal_reference_number` STRING COMMENT 'The unique tracking number assigned by the payer to this appeal. Used in all correspondence and inquiries with the payer regarding appeal status.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates whether the appeal requires clinical peer review by a physician or clinical expert. True for complex clinical appeals challenging medical necessity determinations.',
    `prior_authorization_issue_flag` BOOLEAN COMMENT 'Indicates whether the denial was due to lack of prior authorization and the appeal is contesting the authorization requirement or demonstrating retroactive authorization. True for authorization-related denials.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this appeal requires expedited handling due to high dollar value, patient impact, or regulatory deadline. True for high-priority appeals requiring immediate attention.',
    `rac_audit_related_flag` BOOLEAN COMMENT 'Indicates whether this appeal is in response to a RAC (Recovery Audit Contractor) audit finding. True for appeals of post-payment audits and recoupment actions by Medicare RAC auditors.',
    `requested_amount` DECIMAL(18,2) COMMENT 'The specific dollar amount the provider is requesting to be overturned through the appeal process. May differ from denied amount if provider accepts partial denial.',
    `resolution_date` DATE COMMENT 'The date the payer made a final determination on the appeal. Populated when appeal reaches terminal status (overturned, upheld, partial).',
    `service_from_date` DATE COMMENT 'The start date of the service period for the denied claim being appealed. Used to identify the specific services in dispute.',
    `service_to_date` DATE COMMENT 'The end date of the service period for the denied claim being appealed. For single-day services, matches service_from_date.',
    `service_type_code` STRING COMMENT 'Standardized code indicating the category of healthcare service that was denied. Examples include inpatient, outpatient, emergency, surgical, diagnostic, pharmacy. Used for appeal success rate analytics by service type.',
    `submission_date` DATE COMMENT 'The date the appeal was formally submitted to the payer. Critical for tracking timelines and compliance with appeal deadlines.',
    `submission_method` STRING COMMENT 'The channel through which the appeal was submitted to the payer. Electronic includes EDI transactions, portal refers to payer web portals, mail is postal service, fax is facsimile transmission.. Valid values are `electronic|mail|fax|portal`',
    `supporting_documentation_references` STRING COMMENT 'Comma-separated list of document identifiers or file paths for clinical notes, medical records, peer-reviewed literature, and other evidence submitted to support the appeal. Critical for clinical appeals challenging medical necessity.',
    CONSTRAINT pk_claim_appeal PRIMARY KEY(`claim_appeal_id`)
) COMMENT 'Tracks formal appeals filed against payer claim denials or underpayments. Captures appeal level (first-level, second-level, external review, arbitration), appeal type (clinical, administrative, expedited), appeal submission date, appeal deadline date, supporting documentation references, appeal outcome (overturned, upheld, partial, pending), overturn amount, appeal resolution date, and assigned appeal specialist. Supports multi-level appeal workflow management and tracks appeal success rates by payer, denial reason, and service type.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_original_submission_id` FOREIGN KEY (`original_submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_line_id` FOREIGN KEY (`claim_line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim_line`(`claim_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_claim_original_attachment_id` FOREIGN KEY (`claim_original_attachment_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim_attachment`(`claim_attachment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_claim_superseded_attachment_id` FOREIGN KEY (`claim_superseded_attachment_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim_attachment`(`claim_attachment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Service Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `bill_type` SET TAGS ('dbx_business_glossary_term' = 'Bill Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `primary_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Code (ICD-10-CM)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `rac_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi_837p|edi_837i|paper|portal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental|vision|pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Link Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coder Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('dbx_business_glossary_term' = 'Coding Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('dbx_value_regex' = 'physician|coder|cdi|cac|imported');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coding Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `complication_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity (CC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `denial_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision Clinical Modification (ICD-10-CM) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_value_regex' = '^[A-L]$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'principal|secondary|admitting|external_cause|other');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_value_regex' = 'ICD-10-CM|ICD-9-CM');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Grouper Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|ambulatory_surgery');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital-Acquired Condition (HAC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Laterality');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `rac_audit_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status (277CA)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|error|pending');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Batch Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_value_regex' = '837P|837I|837D');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `is_timely_filed` SET TAGS ('dbx_business_glossary_term' = 'Is Timely Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'edi_837|clearinghouse|portal|paper|fax|direct_api');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Deadline');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'original|resubmission|corrected|void|replacement');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Status History Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `check_or_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check or Electronic Funds Transfer (EFT) Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `coordination_of_benefits_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `corrected_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Corrected Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `days_in_prior_status` SET TAGS ('dbx_business_glossary_term' = 'Days in Prior Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `denial_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `denial_category` SET TAGS ('dbx_value_regex' = 'technical|clinical|eligibility|authorization|timely_filing|duplicate');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `is_final_status` SET TAGS ('dbx_business_glossary_term' = 'Is Final Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_description` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `prior_status_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_category` SET TAGS ('dbx_business_glossary_term' = 'Status Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_category` SET TAGS ('dbx_value_regex' = 'payer_defined|internal_workflow|system_generated|manual_override');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_description` SET TAGS ('dbx_business_glossary_term' = 'Status Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `triggered_by_process` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Process');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `void_indicator` SET TAGS ('dbx_business_glossary_term' = 'Void Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `work_queue_assignment` SET TAGS ('dbx_business_glossary_term' = 'Work Queue Assignment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Receipt Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `financial_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `financial_entity_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Posting Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `check_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check or Electronic Funds Transfer (EFT) Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Remittance Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('dbx_business_glossary_term' = 'Payee National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_value_regex' = 'CHK|ACH|EFT|NON');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Provider Level Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Level Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `receiver_identification` SET TAGS ('dbx_business_glossary_term' = 'Receiver Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|exception|resolved');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `sender_identification` SET TAGS ('dbx_business_glossary_term' = 'Sender Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'received|posted|reconciled|exception|voided');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Journal Entry Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('dbx_value_regex' = 'CO|PR|OA|PI|CR');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('dbx_value_regex' = 'era_posting|manual_adjustment|rac_recoupment|cob_processing|payer_correction|appeal_result');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `balance_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment (Copay) Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `credit_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Line Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('dbx_value_regex' = 'paid|denied|adjusted|pending|reversed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Note');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `hie_query_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Query Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `order_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Order Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partially_approved|pending');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('dbx_business_glossary_term' = 'Authorization Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('dbx_value_regex' = 'phone|portal|fax|edi_278|mail|other');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|cancelled|expired|partially_approved');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_units` SET TAGS ('dbx_business_glossary_term' = 'Requested Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `units_consumed` SET TAGS ('dbx_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting User ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'individual|family|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral_health|durable_medical_equipment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|unknown');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_description` SET TAGS ('dbx_business_glossary_term' = 'Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'real_time|batch|manual|portal|phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|completed|failed|timeout|rejected');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Birthday Rule Applied Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('dbx_value_regex' = 'birthday_rule|gender_rule|court_order|plan_provision|active_inactive|continuation_coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `duplicate_payment_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Payment Prevention Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Gender Rule Applied Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'standard|carve_out|non_duplication|maintenance_of_benefits');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Secondary Payer (MSP) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_type_code` SET TAGS ('dbx_business_glossary_term' = 'Medicare Secondary Payer (MSP) Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `order_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Order Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_on_file_date` SET TAGS ('dbx_business_glossary_term' = 'Other Insurance On File Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'pending|determined|in_process|completed|disputed|reversed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'patient_interview|payer_inquiry|eligibility_check|eob_review|automated_system');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('dbx_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorization_service_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Service Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_units` SET TAGS ('dbx_business_glossary_term' = 'Authorized Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('dbx_business_glossary_term' = 'Clinical Review Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Service Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `peer_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service Authorization Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('dbx_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|partially_used|fully_used|expired|cancelled|suspended');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service Authorization End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_consumed` SET TAGS ('dbx_business_glossary_term' = 'Units Consumed to Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_remaining` SET TAGS ('dbx_business_glossary_term' = 'Units Remaining');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('dbx_subdomain' = 'compliance_attribution');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('dbx_association_edges' = 'claim.claim,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `study_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Study Attribution Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Study Attribution - Claim Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Study Attribution - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Attribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_rationale` SET TAGS ('dbx_business_glossary_term' = 'Attribution Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `billing_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Billing Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `coverage_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `coverage_determination_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Only Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `service_attribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Attribution Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `service_attribution_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `sponsor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `standard_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('dbx_subdomain' = 'compliance_attribution');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('dbx_association_edges' = 'claim.claim,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Audit Sample - Claim Audit Sample Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Audit Sample - Audit Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Audit Sample - Claim Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_scope_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_review_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Claim Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_selection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Selection Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `selected_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Selection Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `claim_line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Line Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_value_regex' = '^[A-L]$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_value_regex' = '^[A-L]$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_value_regex' = '^[A-L]$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_value_regex' = '^[A-L]$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Weight');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `drug_quantity` SET TAGS ('dbx_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|adjudicated|paid|denied|appealed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `outlier_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Line Paid Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `remark_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Attachment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_original_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Attachment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_original_attachment_id` SET TAGS ('dbx_self_reference' = 'claim_original_attachment_id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_superseded_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Attachment Id');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `claim_superseded_attachment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `attachment_number` SET TAGS ('dbx_business_glossary_term' = 'Attachment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `attachment_status` SET TAGS ('dbx_business_glossary_term' = 'Attachment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `attachment_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|received|accepted|rejected|under_review');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `attachment_type` SET TAGS ('dbx_business_glossary_term' = 'Attachment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `encryption_status` SET TAGS ('dbx_value_regex' = 'encrypted|unencrypted|in_transit_encrypted');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attachment Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `page_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `payer_attachment_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Attachment Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `phi_indicator` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `redaction_required` SET TAGS ('dbx_business_glossary_term' = 'Redaction Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|fax|mail|portal|edi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_attachment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `claim_denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Adjustment Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Deficiency Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `quality_peer_review_id` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Write Off Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_level` SET TAGS ('dbx_value_regex' = 'first_level|second_level|third_level|external_review|administrative_law_judge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'pending|approved|partially_approved|denied|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `appeal_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `carc_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `carc_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC) Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `claim_line_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_category` SET TAGS ('dbx_value_regex' = 'preventable|non-preventable|payer_error|provider_error|patient_responsibility|policy_limitation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_number` SET TAGS ('dbx_business_glossary_term' = 'Denial Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_source` SET TAGS ('dbx_business_glossary_term' = 'Denial Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_source` SET TAGS ('dbx_value_regex' = 'payer|clearinghouse|internal_edit|scrubber');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|technical|duplicate|eligibility|authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `is_preventable` SET TAGS ('dbx_business_glossary_term' = 'Is Preventable Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `is_rac_audit` SET TAGS ('dbx_business_glossary_term' = 'Is Recovery Audit Contractor (RAC) Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Denial Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `rarc_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `rarc_description` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC) Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `reason_text` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Denial Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_denial` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Specialist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_appeal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_level` SET TAGS ('dbx_value_regex' = 'first_level|second_level|external_review|arbitration');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|expedited|standard');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `coordination_of_benefits_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `external_review_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'External Review Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `original_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `overturn_amount` SET TAGS ('dbx_business_glossary_term' = 'Overturn Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `payer_appeal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Appeal Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `prior_authorization_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `rac_audit_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Appeal Requested Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|portal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim_appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation References');
