-- Schema for Domain: enrollment | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`enrollment` COMMENT 'Manages the end-to-end enrollment and eligibility lifecycle — open enrollment, special enrollment periods, qualifying life events, 834 EDI transactions, effective dates, terminations, reinstatements, and retroactive adjustments. Owns eligibility spans, coverage periods, and enrollment event history. Interfaces with CMS EDPS/RAPS for government program enrollment and supports 270/271 real-time eligibility verification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Enrollment transactions (add/change/term) are executed against a specific benefit package. This FK enables claims reprocessing (claims_reprocess_flag) to reference the correct benefit design and suppo',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Each enrollment transaction occurs within a defined open enrollment period; linking transaction to period enables period‑based reporting and ensures the period is not a silo.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Financial reconciliation requires associating each enrollment transaction with the employers renewal cycle.',
    `provider_id` BIGINT COMMENT 'Identifier of the eligibility span generated from this transaction.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: An enrollment transaction is frequently triggered by a qualifying life event (QLE) that opens a special enrollment period (SEP). Linking transaction to qualifying_life_event captures the causal event ',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.plan_rate. Business justification: Required for premium audit reports that must trace each enrollment transaction to the exact rate applied for regulatory compliance.',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to enrollment.reconciliation. Business justification: Enrollment reconciliation runs identify discrepancies (adds, changes, terminations) that must be resolved via corrective enrollment transactions. Linking transaction to reconciliation captures which r',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment (e.g., discount, surcharge) applied to the gross premium.',
    `adjustment_reason_code` STRING COMMENT 'Standard code describing why a financial or coverage adjustment was made.. Valid values are `premium_change|plan_change|error_correction|regulatory|other`',
    `approving_authority` STRING COMMENT 'Name or role of the individual or system that approved the enrollment change.',
    `audit_user_role` STRING COMMENT 'Role of the audit user (e.g., admin, operator, system).. Valid values are `admin|operator|system`',
    `claims_reprocess_flag` BOOLEAN COMMENT 'True if the enrollment change requires downstream claims to be re‑processed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the transaction with applicable regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `coverage_period_type` STRING COMMENT 'Indicates whether the coverage is continuous, intermittent, or contains a gap.. Valid values are `continuous|intermittent|gap`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment transaction record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in this transaction.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `effective_date` DATE COMMENT 'Date on which the members coverage under the new enrollment becomes effective.',
    `effective_end_date` DATE COMMENT 'Scheduled end date of the coverage period associated with this enrollment (may differ from termination_date).',
    `enrollment_comment` STRING COMMENT 'Free‑form text field for notes or comments entered by the processor.',
    `enrollment_origin` STRING COMMENT 'Channel through which the enrollment was initiated.. Valid values are `online|call_center|mail|agent|broker`',
    `enrollment_transaction_number` STRING COMMENT 'External business identifier assigned to the enrollment transaction, used for tracking and reference.',
    `enrollment_type` STRING COMMENT 'Category of enrollment event: open enrollment, special enrollment period, automatic enrollment, special manual enrollment, or other.. Valid values are `open|sep|auto|special|manual`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment event occurred in the source system.',
    `financial_impact_flag` BOOLEAN COMMENT 'True when the enrollment change has a direct impact on premium billing or financial reporting.',
    `grace_period_end_date` DATE COMMENT 'Date when the applicable grace period expires.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total premium amount before any adjustments for the enrollment period.',
    `health_plan_type` STRING COMMENT 'Classification of the health plan (e.g., HMO, PPO, EPO, POS, HDHP).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `is_grace_period` BOOLEAN COMMENT 'True if the enrollment is being processed within a grace period after termination.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final premium amount after adjustments, representing the amount to be billed.',
    `original_termination_reference` BIGINT COMMENT 'Reference to the prior termination transaction that is being reinstated.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the enrollment change triggers a prior authorization requirement.',
    `processing_status` STRING COMMENT 'Current processing stage of the transaction within the enrollment workflow.. Valid values are `draft|submitted|under_review|approved|rejected`',
    `reactivation_date` DATE COMMENT 'Effective date of coverage reactivation for reinstatement events.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this transaction must be reported to a regulatory body (e.g., CMS, NAIC).',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Flag indicating whether the transaction represents a retroactive adjustment to prior coverage dates.',
    `source` STRING COMMENT 'Source of the enrollment transaction record, e.g., EDI 834 feed, web portal, batch load, or API.. Valid values are `edi_834|web_portal|batch|api`',
    `termination_date` DATE COMMENT 'Date on which coverage ends for a disenrollment or termination event (nullable if not applicable).',
    `termination_reason` STRING COMMENT 'Standardized reason why the enrollment was terminated.. Valid values are `voluntary|involuntary|nonpayment|eligibility|other`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the enrollment transaction.. Valid values are `pending|processed|failed|cancelled|completed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment transaction record.',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Transactional record capturing every enrollment action for a member — initial enrollment, re-enrollment, plan change, disenrollment (voluntary/involuntary termination), reinstatement, and retroactive adjustment. Tracks enrollment source, enrollment period type (open enrollment, SEP, auto-enrollment), effective date, submitted date, processing status, and transaction-type-specific attributes: termination reason/last day of coverage/grace period status for disenrollments; original termination reference/reinstatement effective date/approving authority for reinstatements; adjusted dates/financial impact flag/claims reprocessing trigger for retro adjustments. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT and 834 EDI transactions via Availity/Change Healthcare.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` (
    `qualifying_life_event_id` BIGINT COMMENT 'System-generated unique identifier for the qualifying life event record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SEP verification requires tracking which regulatory obligation (42 CFR 435.916, state insurance codes) governs each QLE determination for CMS compliance audits and appeal documentation.',
    `appeal_reference` STRING COMMENT 'Reference number of any appeal filed against a denial.',
    `cms_sep_outcome` STRING COMMENT 'Result of the CMS SEP eligibility determination.. Valid values are `eligible|ineligible|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualifying life event record was first created in the system.',
    `denial_reason` STRING COMMENT 'Explanation why the SEP request was denied, if applicable.',
    `documentation_type` STRING COMMENT 'Type of supporting document submitted for the event.. Valid values are `birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order`',
    `event_date` DATE COMMENT 'Calendar date on which the qualifying life event occurred.',
    `event_type` STRING COMMENT 'Category of the life event that triggers a special enrollment period.. Valid values are `marriage|birth|loss_of_coverage|relocation|divorce|adoption`',
    `qualifying_life_event_status` STRING COMMENT 'Overall lifecycle status of the qualifying life event record.. Valid values are `active|inactive|archived`',
    `sep_category_code` STRING COMMENT 'CMS‑defined code that classifies the SEP category for the qualifying life event.',
    `sep_window_end` DATE COMMENT 'Last date the special enrollment period (SEP) is open for this event.',
    `sep_window_start` DATE COMMENT 'First date the special enrollment period (SEP) is open for this event.',
    `sep_window_status` STRING COMMENT 'Current state of the SEP window based on dates and actions.. Valid values are `open|closed|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualifying life event record.',
    `verification_date` DATE COMMENT 'Date the verification decision was recorded.',
    `verification_status` STRING COMMENT 'Current status of the CMS SEP verification process.. Valid values are `pending|verified|denied|appealed`',
    CONSTRAINT pk_qualifying_life_event PRIMARY KEY(`qualifying_life_event_id`)
) COMMENT 'Master record of a qualifying life event (QLE) that triggers a special enrollment period (SEP), including the full SEP verification lifecycle. Captures event type (marriage, birth, loss of coverage, relocation, divorce, adoption), event date, SEP window open/close dates, CMS SEP category codes, submitted documentation type and artifacts (birth certificate, marriage license, loss of coverage letter), verification status, verifier ID, verification date, CMS SEP verification outcome, pend/denial reason, and appeal reference. This is the authoritative SSOT for both QLE registration and SEP verification — no separate verification record exists. Required for ACA compliance, CMS SEP eligibility determinations, and SEP integrity program compliance. Sourced from Facets/QNXT pend workflow and member portal document uploads.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Open enrollment periods are defined within a plan year — start_date, end_date, and enrollment_deadline_date are all plan-year-bounded. This FK enables OEP-to-plan-year alignment for ACA regulatory fil',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: OEP windows are mandated by specific regulations (ACA §1311, state codes). Business tracks which regulatory obligation drives each enrollment period for compliance reporting and regulatory filing vali',
    `compliance_status` STRING COMMENT 'Current compliance verification outcome for the enrollment period.. Valid values are `compliant|non-compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment period record was first created in the system.',
    `eligibility_segment` STRING COMMENT 'Population segment eligible for this enrollment period (e.g., group, individual, Medicare).. Valid values are `Group|Individual|Medicare|Medicaid|Marketplace`',
    `end_date` DATE COMMENT 'Last calendar day for submitting enrollment applications; after this date the window closes.',
    `enrollment_cutoff_time` TIMESTAMP COMMENT 'Daily cut‑off time (in local time) after which submissions on the deadline date are rejected.',
    `enrollment_deadline_date` DATE COMMENT 'Final calendar date by which all enrollment submissions must be received.',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment window based on its recurrence and purpose.. Valid values are `Annual|Special|Continuous`',
    `exchange_type` STRING COMMENT 'Marketplace or exchange through which the enrollment is offered.. Valid values are `SHOP|Individual|Off-Exchange|Medicare|Medicaid`',
    `is_annual` BOOLEAN COMMENT 'True if the enrollment period recurs each year on the same schedule.',
    `is_retrospective_allowed` BOOLEAN COMMENT 'True if members may submit enrollment changes that become effective prior to the submission date.',
    `lob` STRING COMMENT 'Business line to which the enrollment period applies.. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or operational comments.',
    `open_enrollment_period_status` STRING COMMENT 'Current lifecycle status of the enrollment window.. Valid values are `upcoming|open|closed|cancelled|postponed`',
    `period_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the enrollment window across systems.',
    `period_name` STRING COMMENT 'Descriptive name of the enrollment window, e.g., "2025 Individual Marketplace OE".',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this enrollment period triggers mandatory regulatory reporting (e.g., CMS filings).',
    `start_date` DATE COMMENT 'First calendar day on which members may submit enrollment applications.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the enrollment period record.',
    `volume_actual` STRING COMMENT 'Actual count of enrollments captured within the window.',
    `volume_target` STRING COMMENT 'Planned number of enrollments the organization aims to achieve during the window.',
    `volume_target_met` BOOLEAN COMMENT 'Indicates whether the actual enrollment volume met or exceeded the target.',
    CONSTRAINT pk_open_enrollment_period PRIMARY KEY(`open_enrollment_period_id`)
) COMMENT 'Master record defining each open enrollment window — annual employer group OE, ACA marketplace OE, Medicare Annual Enrollment Period (AEP), and Medicaid continuous enrollment periods. Captures period start/end dates, eligible population segment, LOB, exchange type (SHOP, individual marketplace, off-exchange), and enrollment volume targets. Used to govern when enrollment_records are accepted without a QLE. Sourced from CMS plan year calendars and employer group contracts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` (
    `edi_transaction_id` BIGINT COMMENT 'Primary key for edi_transaction',
    `transaction_id` BIGINT COMMENT 'External identifier supplied by the sender to uniquely identify the transaction (e.g., control number from the senders system).',
    `average_record_size_bytes` DECIMAL(18,2) COMMENT 'Average size of each member record within the file, calculated as file_size_bytes divided by member_count.',
    `effective_date` DATE COMMENT 'Date on which the enrollment coverage becomes effective for the member(s).',
    `enrollment_action_code` STRING COMMENT 'Standard X12 834 code indicating Add (A), Delete (D), Modify (M), or Correct (C) action.. Valid values are `A|D|M|C`',
    `error_code` STRING COMMENT 'Standardized error code returned when processing fails (e.g., X12 validation error).',
    `error_description` STRING COMMENT 'Human‑readable description of the processing error.',
    `file_name` STRING COMMENT 'Original filename of the inbound 834 transaction as received from the EDI gateway.',
    `file_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the 834 file was first ingested into the lakehouse.',
    `file_size_bytes` BIGINT COMMENT 'Total size of the inbound 834 file in bytes.',
    `group_control_number` STRING COMMENT 'Control number identifying the GS functional group for the transaction.',
    `interchange_control_number` STRING COMMENT 'Control number identifying the ISA interchange envelope for the transaction.',
    `last_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent processing attempt.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the transaction from ingestion to final disposition.. Valid values are `new|in_progress|completed|failed|cancelled`',
    `member_count` STRING COMMENT 'Number of individual member enrollment records contained in the 834 file.',
    `processing_attempts` STRING COMMENT 'Number of times the transaction has been attempted for processing.',
    `processing_status` STRING COMMENT 'Current workflow status of the transaction within the ingestion pipeline.. Valid values are `received|queued|processing|completed|error|rejected`',
    `receiver_code` STRING COMMENT 'Identifier of the trading partner that receives the 834 file (typically the health insurer).',
    `reconciliation_status` STRING COMMENT 'Result of matching the transaction to internal enrollment records.. Valid values are `unmatched|matched|partial|pending`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `termination_date` DATE COMMENT 'Date on which the enrollment coverage ends, if applicable.',
    `transaction_set_control_number` STRING COMMENT 'Control number that uniquely identifies the 834 transaction set within the interchange.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp representing the business event time encoded in the 834 transaction (e.g., effective date of the enrollment action).',
    `transaction_type` STRING COMMENT 'Indicates whether the 834 file adds new enrollments, changes existing ones, terminates coverage, or corrects prior data.. Valid values are `add|change|terminate|correction`',
    CONSTRAINT pk_edi_transaction PRIMARY KEY(`edi_transaction_id`)
) COMMENT 'Raw and processed 834 EDI transaction records received from employer groups, exchanges, and CMS — the primary electronic mechanism for enrollment adds, changes, and terminations. Captures ISA/GS envelope metadata, transaction set control number, sender/receiver IDs, transaction type (full file vs. change only), processing status, error codes, and reconciliation status. Sourced from Availity/Change Healthcare EDI gateway. Distinct from enrollment_record (the business outcome) — this is the inbound EDI artifact.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` (
    `eligibility_verification_id` BIGINT COMMENT 'Primary key for eligibility_verification',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: 270/271 eligibility transactions are scoped to a specific benefit package — the response includes benefit limits, cost-sharing, and coverage details defined at benefit_package level. Providers need pa',
    `identity_id` BIGINT COMMENT 'Unique member identifier used in the eligibility request (e.g., member number, SSN, MRN).',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: A 270/271 eligibility verification inquiry is performed in the context of a specific plan election — verifying that a members coverage under a particular plan election is active and valid. Linking el',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: HIPAA 270/271 eligibility verification transactions are location-specific — the service delivery site determines benefit applicability and network status. Linking eligibility_verification to practice_',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for automated provider credential checks during eligibility verification; the process matches providers to member eligibility inquiries.',
    `transaction_id` BIGINT COMMENT 'Identifier assigned by the source system for the eligibility transaction.',
    `authorization_number` STRING COMMENT 'Authorization number returned when prior authorization is required.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for the service.',
    `benefit_category` STRING COMMENT 'High‑level category of benefits being queried (e.g., medical, dental).. Valid values are `medical|dental|vision|rx|wellness`',
    `benefit_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount allowed for the queried benefit.',
    `benefit_remaining` DECIMAL(18,2) COMMENT 'Remaining dollar amount of the benefit available.',
    `benefit_used` DECIMAL(18,2) COMMENT 'Dollar amount of the benefit already utilized in the current period.',
    `coverage_type` STRING COMMENT 'Level of coverage returned (full, partial, or none).. Valid values are `full|partial|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility record was first persisted in the data lake.',
    `deductible_remaining` DECIMAL(18,2) COMMENT 'Members remaining deductible balance for the benefit period.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code associated with the request, if applicable.',
    `eligibility_status` STRING COMMENT 'Overall result of the eligibility check (eligible, ineligible, error, or pending).. Valid values are `eligible|ineligible|error|pending`',
    `error_code` STRING COMMENT 'Technical or business error code returned in a failed eligibility response.',
    `error_description` STRING COMMENT 'Human‑readable description of the error condition.',
    `inquiry_reference_number` STRING COMMENT 'External reference number assigned by the source system (e.g., Availity) for the eligibility request.',
    `inquiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility request was sent to the payer.',
    `member_identifier_type` STRING COMMENT 'Type of identifier supplied for the member (SSN, MRN, or internal member ID).. Valid values are `ssn|mrn|member_id`',
    `oop_remaining` DECIMAL(18,2) COMMENT 'Remaining out‑of‑pocket amount before maximum OOP is reached.',
    `response_message` STRING COMMENT 'Free‑form message returned by the payer providing additional context.',
    `response_time_seconds` DECIMAL(18,2) COMMENT 'Elapsed time between request and response, measured in seconds.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility response was received.',
    `service_code` STRING COMMENT 'CPT code of the service/procedure for which eligibility is being checked.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility record.',
    CONSTRAINT pk_eligibility_verification PRIMARY KEY(`eligibility_verification_id`)
) COMMENT 'Transactional record of real-time 270/271 eligibility verification requests and responses. Captures requesting provider NPI, member identifier used, inquiry date/time, response status, coverage details returned, deductible/OOP balances returned, and response time SLA. Supports provider-facing eligibility verification at point of care. Sourced from Availity/Change Healthcare 270/271 gateway and Facets real-time eligibility API.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` (
    `plan_election_id` BIGINT COMMENT 'Unique surrogate identifier for the plan election record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Members elect a specific benefit package (metal tier, cost-sharing design) during enrollment. This FK enables benefit-package-level enrollment reporting, premium calculation validation, and ACA actuar',
    `edi_transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.edi_transaction. Business justification: Plan elections received from employer groups via 834 EDI files must be traceable back to the originating EDI transaction record. This FK enables end-to-end traceability from the raw EDI file through t',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: A plan election is made within the context of a specific open enrollment period (annual OEP, ACA marketplace OEP, Medicare OEP). Linking plan_election to open_enrollment_period enables volume tracking',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: PCP designation at plan election is a core health insurance enrollment workflow. Members select a Primary Care Provider when electing a plan; this FK supports PCP assignment tracking, continuity-of-ca',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Plan elections are always scoped to a plan year for ACA compliance, open enrollment period alignment, and annual enrollment reporting. Role-prefix plan_year_id used to distinguish from generic date ',
    `prior_plan_election_id` BIGINT COMMENT 'Reference to the previous election record when this election is a change or reinstatement.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: A plan election made during a special enrollment period must reference the qualifying life event that opened that SEP window. This FK is critical for SEP eligibility validation, CMS SEP outcome tracki',
    `cobra_eligibility_end_date` DATE COMMENT 'Date when COBRA eligibility expires.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected (e.g., employee only, employee + spouse, employee + children, family).. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `dental_rider_flag` BOOLEAN COMMENT 'Indicates if a dental coverage rider was elected.',
    `effective_date` DATE COMMENT 'Date the elected coverage becomes effective.',
    `election_number` STRING COMMENT 'External reference number assigned to the election by the enrollment system.',
    `election_type` STRING COMMENT 'Nature of the election event (new enrollment, change, termination, reinstatement).. Valid values are `new|change|termination|reinstatement`',
    `enrollment_event_type` STRING COMMENT 'Type of enrollment event that triggered the election.. Valid values are `open_enrollment|special_enrollment|qualifying_life_event`',
    `enrollment_source` STRING COMMENT 'Channel through which the election was submitted.. Valid values are `online|call_center|broker|mail`',
    `fsa_election_flag` BOOLEAN COMMENT 'Indicates if a Flexible Spending Account was elected.',
    `hra_election_flag` BOOLEAN COMMENT 'Indicates if a Health Reimbursement Arrangement was elected.',
    `hsa_election_flag` BOOLEAN COMMENT 'Indicates if a Health Savings Account was elected.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates if the election is eligible for COBRA continuation coverage.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions related to the election.',
    `plan_election_status` STRING COMMENT 'Current processing status of the election record.. Valid values are `active|pending|terminated|cancelled`',
    `premium_contribution_employee` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee.',
    `premium_contribution_employer` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (e.g., monthly).. Valid values are `monthly|quarterly|annually`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the election record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the election record.',
    `termination_date` DATE COMMENT 'Date the elected coverage ends, if applicable.',
    `total_premium` DECIMAL(18,2) COMMENT 'Total premium amount for the elected coverage (employer + employee).',
    `vision_rider_flag` BOOLEAN COMMENT 'Indicates if a vision coverage rider was elected.',
    CONSTRAINT pk_plan_election PRIMARY KEY(`plan_election_id`)
) COMMENT 'Master record of a subscribers specific plan selection, coverage tier, and covered member roster during an enrollment or plan change event. Captures elected plan ID, coverage tier (employee-only, employee+spouse, employee+children, family), effective date, prior plan reference, premium contribution split (employer vs. employee), HSA/HRA/FSA election flag, dental/vision rider elections, and the roster of covered individuals with their relationship codes, age-out dates, and COBRA continuation eligibility. References member domain for person identity — this product owns the enrollment-specific election and roster, not the person demographics. Represents the members choice artifact — distinct from eligibility_span (the resulting coverage). Sourced from Facets/QNXT benefits election module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Primary key for reconciliation',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Enrollment reconciliation runs (CMS 820/834 reconciliation) are always executed within a specific plan year. This FK enables plan-year-level discrepancy reporting, financial impact aggregation, and CM',
    `auto_resolution_flag` BOOLEAN COMMENT 'Indicates whether the system automatically resolved the discrepancy.',
    `comments` STRING COMMENT 'Free‑form notes captured by the analyst about the reconciliation outcome.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for financial impact values.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_add_count` STRING COMMENT 'Count of enrollment records present in the source but missing in the internal system.',
    `discrepancy_change_count` STRING COMMENT 'Count of enrollment attribute changes (e.g., plan, coverage) that differ between systems.',
    `discrepancy_demographic_mismatch_count` STRING COMMENT 'Number of records where member demographic data (name, DOB, SSN) does not match.',
    `discrepancy_detail_file_path` STRING COMMENT 'File system or object storage path to the detailed discrepancy report generated by the run.',
    `discrepancy_termination_count` STRING COMMENT 'Count of enrollment records terminated in the source but still active internally.',
    `discrepancy_total_count` STRING COMMENT 'Aggregate number of mismatches identified in the reconciliation run.',
    `financial_impact_adjustment` DECIMAL(18,2) COMMENT 'Sum of adjustments (credits, penalties) applied to the gross impact.',
    `financial_impact_gross` DECIMAL(18,2) COMMENT 'Total gross monetary impact of all unresolved discrepancies before adjustments.',
    `financial_impact_net` DECIMAL(18,2) COMMENT 'Net monetary impact after adjustments; the amount that may affect premium billing.',
    `manual_resolution_flag` BOOLEAN COMMENT 'Indicates whether human intervention is required to resolve the discrepancy.',
    `period_end` DATE COMMENT 'End date of the enrollment coverage period being reconciled.',
    `period_start` DATE COMMENT 'Start date of the enrollment coverage period being reconciled.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation process.. Valid values are `pending|in_progress|completed|error|manual_review|cancelled`',
    `resolution_deadline` DATE COMMENT 'Date by which outstanding discrepancies must be resolved to avoid financial impact.',
    `run_number` BIGINT COMMENT 'Sequential number assigned to each reconciliation execution for tracking and audit purposes.',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation run was initiated.',
    `run_type` STRING COMMENT 'Indicates whether the run was a full reconciliation or an incremental update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Transactional record capturing periodic reconciliation between the health plans enrollment records and external authoritative sources — employer group rosters, CMS enrollment files (TRR/MARx), state Medicaid agency 834 files, and ACA exchange enrollment data. Captures reconciliation run date, source system, discrepancy count by type (adds, terms, changes, demographic mismatches), auto-resolution vs. manual resolution status, resolution deadline, and financial impact of unresolved discrepancies on premium billing and risk adjustment. Critical for CMS compliance (monthly TRR reconciliation), premium billing accuracy, and employer group roster integrity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` (
    `cms_submission_id` BIGINT COMMENT 'Primary key for cms_submission',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: CMS EDGE/EDE submissions are audited for data accuracy and timeliness. Audit findings reference specific submission batches for remediation, resubmission tracking, and penalty avoidance.',
    `benefit_package_id` BIGINT COMMENT 'Identifier for the specific benefit package within the plan.',
    `breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.breach_incident. Business justification: CMS submission files contain PHI and may be involved in breach incidents (unauthorized access, transmission errors). Business tracks which submissions were affected for HIPAA notification and remediat',
    `transaction_id` BIGINT COMMENT 'Unique transaction identifier assigned by CMS for the submission.',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: CMS Part D submissions report formulary compliance, drug coverage status, and benefit design. Each submission must reference the specific formulary version in effect to validate regulatory compliance ',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the enrollment.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: CMS submissions report risk-adjusted payments; linking to member risk scores enables RAF validation, payment reconciliation, and audit trail for risk adjustment factors used in premium calculations. R',
    `subscriber_id` BIGINT COMMENT 'Internal identifier of the member whose enrollment is being submitted.',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: CMS Part D submissions must report PBM contract terms including rebate arrangements, dispensing fees, and network configurations. Each submission references the governing PBM contract to validate pric',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: CMS submissions for Medicare Advantage, Part D, and Medicaid report on specific plan elections — the subscribers coverage selection is the core data element being submitted to CMS. Linking cms_submis',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: CMS enrollment submissions (RAPS, EDGE, 834) are always tied to a plan year for risk adjustment, MLR reporting, and regulatory filing deadlines. Direct FK to plan.year enables plan-year submission aud',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any premium adjustments (e.g., discounts, fees) applied to the submission.',
    `audit_user` STRING COMMENT 'User ID of the person who created or last updated the record.',
    `audit_user_role` STRING COMMENT 'Role or job function of the audit user (e.g., Data Steward, Operations Analyst).',
    `compliance_check_date` DATE COMMENT 'Date when the compliance validation was performed.',
    `compliance_error_code` STRING COMMENT 'Code representing a specific compliance validation failure.',
    `compliance_error_description` STRING COMMENT 'Human‑readable description of the compliance error.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the submission passed all regulatory compliance validations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `USD|CAD|GBP|EUR|JPY|CHF`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting the overall quality of the submission data.',
    `effective_date` DATE COMMENT 'Date when the members coverage becomes effective.',
    `enrollment_cms_submission_status` STRING COMMENT 'Current lifecycle status of the submission within the processing pipeline.. Valid values are `pending|accepted|rejected|processed|error`',
    `error_code` STRING COMMENT 'Technical error code returned by the CMS response file.',
    `error_message` STRING COMMENT 'Detailed error message associated with the error code.',
    `is_legacy_submission` BOOLEAN COMMENT 'Flag indicating whether the submission originates from a legacy system.',
    `is_test_submission` BOOLEAN COMMENT 'Flag indicating whether the submission is a test (non‑production) record.',
    `member_number` STRING COMMENT 'External member identifier used in member communications and EDI files.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final premium amount after adjustments, to be billed.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Timestamp when internal processing of the submission completed.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Timestamp when internal processing of the submission began.',
    `processing_status` STRING COMMENT 'Current status of internal processing of the submission file.. Valid values are `not_started|in_progress|completed|failed`',
    `rejection_reason_code` STRING COMMENT 'CMS‑provided code indicating why a submission was rejected.',
    `rejection_reason_description` STRING COMMENT 'Human‑readable description of the rejection reason.',
    `risk_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the submission impacts the RAF (Risk Adjustment Factor) score.',
    `submission_file_name` STRING COMMENT 'Name of the EDI file transmitted to CMS.',
    `submission_file_timestamp` TIMESTAMP COMMENT 'Timestamp when the EDI file was created or received by the gateway.',
    `submission_source_system` STRING COMMENT 'Originating core administration system that generated the submission.. Valid values are `Facets|QNXT|Custom`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment batch was transmitted to CMS.',
    `submission_type` STRING COMMENT 'Indicates whether the submission is an initial enrollment, a correction, a deletion, or a termination request.. Valid values are `initial|correction|delete|termination`',
    `submission_version` STRING COMMENT 'Version identifier for the submission schema or format.',
    `termination_date` DATE COMMENT 'Date when the members coverage ends, if applicable.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Gross premium amount for the enrollment before adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    CONSTRAINT pk_cms_submission PRIMARY KEY(`cms_submission_id`)
) COMMENT 'Transactional record of enrollment data submissions to CMS for Medicare Advantage, Part D, and Medicaid managed care programs via RAPS and EDPS. Captures submission batch ID, submission type (initial, correction, delete), CMS transaction ID, acceptance/rejection status, error detail codes, risk adjustment impact flag, and reconciliation status. Critical for government program compliance and RAF score accuracy. Sourced from CMS EDPS/RAPS response files.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_edi_transaction_id` FOREIGN KEY (`edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_prior_plan_election_id` FOREIGN KEY (`prior_plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_domain' = 'enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_subdomain' = 'member_actions');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'premium_change|plan_change|error_correction|regulatory|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_value_regex' = 'admin|operator|system');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `claims_reprocess_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Reprocess Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|gap');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_comment` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Comment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Origin (ENROLL_ORIGIN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_value_regex' = 'online|call_center|mail|agent|broker');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Number (ETN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLL_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open|sep|auto|special|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `original_termination_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Termination Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source (TXN_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'edi_834|web_portal|batch|api');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|nonpayment|eligibility|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Status (ENROLL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|cancelled|completed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_subdomain' = 'period_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `appeal_reference` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'marriage|birth|loss_of_coverage|relocation|divorce|adoption');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Category Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_end` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_start` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_business_glossary_term' = 'SEP Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|denied|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'period_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Segment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_value_regex' = 'Group|Individual|Medicare|Medicaid|Marketplace');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cutoff Time (HH:MM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type (Annual, Special, Continuous)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'Annual|Special|Continuous');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type (SHOP, Individual, Off-Exchange, Medicare, Medicaid)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'SHOP|Individual|Off-Exchange|Medicare|Medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurrence Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_retrospective_allowed` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Enrollment Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_value_regex' = 'upcoming|open|closed|cancelled|postponed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Code (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Name (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_actual` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Actual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Target');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target_met` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Target Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_subdomain' = 'external_exchange');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `average_record_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Average Record Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Action Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_value_regex' = 'A|D|M|C');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number (GS08)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number (ISA13)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `last_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Processing Attempt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'new|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_attempts` SET TAGS ('dbx_business_glossary_term' = 'Processing Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'received|queued|processing|completed|error|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver EDI Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number (ST02)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'add|change|terminate|correction');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_subdomain' = 'member_actions');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_limit` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_remaining` SET TAGS ('dbx_business_glossary_term' = 'Benefit Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_used` SET TAGS ('dbx_business_glossary_term' = 'Benefit Used Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `deductible_remaining` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|error|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_value_regex' = 'ssn|mrn|member_id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `oop_remaining` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket (OOP) Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_subdomain' = 'member_actions');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `prior_plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `cobra_eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `dental_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Number (PLAN_ELECTION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'new|change|termination|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|qualifying_life_event');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|broker|mail');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'FSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hra_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HRA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Election Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_business_glossary_term' = 'Election Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employee` SET TAGS ('dbx_business_glossary_term' = 'Employee Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employer` SET TAGS ('dbx_business_glossary_term' = 'Employer Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `total_premium` SET TAGS ('dbx_business_glossary_term' = 'Total Premium');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `vision_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('dbx_subdomain' = 'external_exchange');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `auto_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Comments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_add_count` SET TAGS ('dbx_business_glossary_term' = 'Additions Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_change_count` SET TAGS ('dbx_business_glossary_term' = 'Changes Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_demographic_mismatch_count` SET TAGS ('dbx_business_glossary_term' = 'Demographic Mismatch Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_detail_file_path` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Detail File Path');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_termination_count` SET TAGS ('dbx_business_glossary_term' = 'Terminations Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_gross` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_net` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `manual_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|error|manual_review|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('dbx_subdomain' = 'external_exchange');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'CMS Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_error_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_error_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `enrollment_cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `enrollment_cms_submission_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|processed|error');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `is_legacy_submission` SET TAGS ('dbx_business_glossary_term' = 'Legacy Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `is_test_submission` SET TAGS ('dbx_business_glossary_term' = 'Test Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('dbx_business_glossary_term' = 'Member Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_file_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission File Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_business_glossary_term' = 'Submission Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|Custom');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|correction|delete|termination');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
