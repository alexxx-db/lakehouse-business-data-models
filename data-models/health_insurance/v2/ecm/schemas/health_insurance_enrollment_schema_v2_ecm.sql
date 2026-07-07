-- Schema for Domain: enrollment | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`enrollment` COMMENT 'Manages the end-to-end enrollment and eligibility lifecycle — open enrollment, special enrollment periods, qualifying life events, 834 EDI transactions, effective dates, terminations, reinstatements, and retroactive adjustments. Owns eligibility spans, coverage periods, and enrollment event history. Interfaces with CMS EDPS/RAPS for government program enrollment and supports 270/271 real-time eligibility verification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Each enrollment transaction can generate a Care Plan; linking enables cost, outcome, and compliance reporting per transaction.',
    `employee_id` BIGINT COMMENT 'System identifier of the user or process that performed the last audit action.',
    `batch_id` BIGINT COMMENT 'Identifier of the batch job that processed this enrollment transaction.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Each enrollment transaction occurs within a defined open enrollment period; linking transaction to period enables period‑based reporting and ensures the period is not a silo.',
    `group_contact_id` BIGINT COMMENT 'Foreign key linking to employer.group_contact. Business justification: Required for audit of enrollment approvals: employers designated contact must be recorded per ACA compliance reporting.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Financial reconciliation requires associating each enrollment transaction with the employers renewal cycle.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group or line of business to which the member belongs.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with this enrollment transaction.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network enrollment reporting for quarterly compliance requires linking each transaction to the provider network.',
    `raps_submission_id` BIGINT COMMENT 'Foreign key linking to risk.raps_submission. Business justification: During enrollment processing, a RAPS risk‑adjustment submission may be generated; linking provides audit trail for regulatory reporting.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.plan_rate. Business justification: Required for premium audit reports that must trace each enrollment transaction to the exact rate applied for regulatory compliance.',
    `edi_transaction_id` BIGINT COMMENT 'add column edi_transaction_id (BIGINT) with FK to enrollment.edi_transaction.edi_transaction_id - many transactions originate as 834 EDIs',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment (e.g., discount, surcharge) applied to the gross premium.',
    `adjustment_reason_code` STRING COMMENT 'Standard code describing why a financial or coverage adjustment was made.. Valid values are `premium_change|plan_change|error_correction|regulatory|other`',
    `approving_authority` STRING COMMENT 'Name or role of the individual or system that approved the enrollment change.',
    `audit_user_role` STRING COMMENT 'Role of the audit user (e.g., admin, operator, system).. Valid values are `admin|operator|system`',
    `claims_reprocess_flag` BOOLEAN COMMENT 'True if the enrollment change requires downstream claims to be re‑processed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the transaction with applicable regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `coverage_period_type` STRING COMMENT 'Indicates whether the coverage is continuous, intermittent, or contains a gap.. Valid values are `continuous|intermittent|gap`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment transaction record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in this transaction.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the members coverage under the new enrollment becomes effective.',
    `effective_end_date` DATE COMMENT 'Scheduled end date of the coverage period associated with this enrollment (may differ from termination_date).',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_comment` STRING COMMENT 'Free‑form text field for notes or comments entered by the processor.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Identifier of the eligibility span generated from this transaction.',
    `enrollment_origin` STRING COMMENT 'Channel through which the enrollment was initiated.. Valid values are `online|call_center|mail|agent|broker`',
    `enrollment_transaction_number` STRING COMMENT 'External business identifier assigned to the enrollment transaction, used for tracking and reference.',
    `enrollment_type` STRING COMMENT 'Category of enrollment event: open enrollment, special enrollment period, automatic enrollment, special manual enrollment, or other.. Valid values are `open|sep|auto|special|manual`',
    `error_code` STRING COMMENT 'Error code associated with the transaction',
    `error_description` STRING COMMENT 'Description of any error that occurred during the transaction processing',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment event occurred in the source system.',
    `exchange_code` STRING COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `file_name` STRING COMMENT '',
    `financial_impact_flag` BOOLEAN COMMENT 'True when the enrollment change has a direct impact on premium billing or financial reporting.',
    `grace_period_end_date` DATE COMMENT 'Date when the applicable grace period expires.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total premium amount before any adjustments for the enrollment period.',
    `health_plan_type` STRING COMMENT 'Classification of the health plan (e.g., HMO, PPO, EPO, POS, HDHP).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `hios_code` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_grace_period` BOOLEAN COMMENT 'True if the enrollment is being processed within a grace period after termination.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final premium amount after adjustments, representing the amount to be billed.',
    `original_termination_reference` BIGINT COMMENT 'Reference to the prior termination transaction that is being reinstated.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the enrollment change triggers a prior authorization requirement.',
    `processing_status` STRING COMMENT 'Current processing stage of the transaction within the enrollment workflow.. Valid values are `draft|submitted|under_review|approved|rejected`',
    `reactivation_date` DATE COMMENT 'Effective date of coverage reactivation for reinstatement events.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this transaction must be reported to a regulatory body (e.g., CMS, NAIC).',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Flag indicating whether the transaction represents a retroactive adjustment to prior coverage dates.',
    `source` STRING COMMENT 'Source of the enrollment transaction record, e.g., EDI 834 feed, web portal, batch load, or API.. Valid values are `edi_834|web_portal|batch|api`',
    `termination_date` DATE COMMENT 'Date on which coverage ends for a disenrollment or termination event (nullable if not applicable).',
    `termination_reason` STRING COMMENT 'Standardized reason why the enrollment was terminated.. Valid values are `voluntary|involuntary|nonpayment|eligibility|other`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the enrollment transaction.. Valid values are `pending|processed|failed|cancelled|completed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment transaction record.',
    `hios_id` STRING COMMENT '',
    `exchange_id` STRING COMMENT '',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Transactional record capturing every enrollment action for a member — initial enrollment, re-enrollment, plan change, disenrollment (voluntary/involuntary termination), reinstatement, and retroactive adjustment. Tracks enrollment source, enrollment period type (open enrollment, SEP, auto-enrollment), effective date, submitted date, processing status, and transaction-type-specific attributes: termination reason/last day of coverage/grace period status for disenrollments; original termination reference/reinstatement effective date/approving authority for reinstatements; adjusted dates/financial impact flag/claims reprocessing trigger for retro adjustments. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT and 834 EDI transactions via Availity/Change Healthcare.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`event` (
    `event_id` BIGINT COMMENT 'System-generated unique identifier for each enrollment event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the actor (e.g., member_id, employer_id) that caused the event.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group linked to the enrollment, if applicable.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: Event tracking reports must reference the exact plan offering the change relates to for employer‑level reporting.',
    `member_lifecycle_event_id` BIGINT COMMENT 'Generated member lifecycle event',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with the enrollment event.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network change audit log records which network triggered an enrollment event for regulatory audit.',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Event‑driven underwriting decisions are recorded; linking supports the Underwriting Decision Audit report.',
    `transaction_id` BIGINT COMMENT 'Identifier of the enrollment to which this event belongs.',
    `actor_type` STRING COMMENT 'Classifies the party that triggered the event.. Valid values are `member|employer|system|cms|provider`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `event_description` STRING COMMENT 'Free‑text narrative providing additional context for the event.',
    `effective_date` DATE COMMENT 'Date on which the new enrollment status becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment event occurred in the source system.',
    `event_type` STRING COMMENT 'Categorizes the nature of the state transition (e.g., submitted, approved).. Valid values are `submitted|approved|rejected|terminated|reinstated|adjusted`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the event was entered manually (True) or generated automatically (False).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_status` STRING COMMENT 'Enrollment status after the event was applied.. Valid values are `pending|active|terminated|reinstated|cancelled`',
    `previous_status` STRING COMMENT 'Enrollment status before the event was applied.. Valid values are `pending|active|terminated|reinstated|cancelled`',
    `reason_code` STRING COMMENT 'Standardized code explaining why the event was generated (e.g., QLE‑DIVORCE, SYSTEM‑ERROR).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first persisted in the data lake.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the event record.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source` STRING COMMENT 'System or interface that generated the event record.. Valid values are `core_admin|provider_system|member_portal|edi_gateway|batch_process`',
    `termination_date` DATE COMMENT 'Date the enrollment was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Granular audit log of every state transition in the enrollment lifecycle — submitted, pended, approved, rejected, effectuated, terminated, reinstated, retroactively adjusted. Each event captures the triggering action, actor (member, employer, CMS, system), timestamp, reason code, and before/after state. Supports regulatory audit trails required by CMS, state DOI, and HIPAA administrative simplification. Distinct from enrollment_transaction (which is the business action) — this is the immutable event history of that actions processing lifecycle.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` (
    `qualifying_life_event_id` BIGINT COMMENT 'System-generated unique identifier for the qualifying life event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or system that performed the verification.',
    `event_id` BIGINT COMMENT 'add column event_id (BIGINT) with FK to enrollment.event.event_id - QLEs trigger enrollment events',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who reported the qualifying life event.',
    `appeal_reference` STRING COMMENT 'Reference number of any appeal filed against a denial.',
    `cms_sep_outcome` STRING COMMENT 'Result of the CMS SEP eligibility determination.. Valid values are `eligible|ineligible|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualifying life event record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason` STRING COMMENT 'Explanation why the SEP request was denied, if applicable.',
    `documentation_received_flag` BOOLEAN COMMENT 'Flag indicating whether required documentation has been received for the qualifying life event',
    `documentation_type` STRING COMMENT 'Type of supporting document submitted for the event.. Valid values are `birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_date` DATE COMMENT 'Calendar date on which the qualifying life event occurred.',
    `event_type` STRING COMMENT 'Category of the life event that triggers a special enrollment period.. Valid values are `marriage|birth|loss_of_coverage|relocation|divorce|adoption`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `qle_type_code` STRING COMMENT '',
    `qualifying_life_event_status` STRING COMMENT 'Overall lifecycle status of the qualifying life event record.. Valid values are `active|inactive|archived`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `sep_category_code` STRING COMMENT 'CMS‑defined code that classifies the SEP category for the qualifying life event.',
    `sep_window_end` DATE COMMENT 'Last date the special enrollment period (SEP) is open for this event.',
    `sep_window_end_date` DATE COMMENT '',
    `sep_window_start` DATE COMMENT 'First date the special enrollment period (SEP) is open for this event.',
    `sep_window_status` STRING COMMENT 'Current state of the SEP window based on dates and actions.. Valid values are `open|closed|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualifying life event record.',
    `verification_date` DATE COMMENT 'Date the verification decision was recorded.',
    `verification_status` STRING COMMENT 'Current status of the CMS SEP verification process.. Valid values are `pending|verified|denied|appealed`',
    `verified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_qualifying_life_event PRIMARY KEY(`qualifying_life_event_id`)
) COMMENT 'Master record of a qualifying life event (QLE) that triggers a special enrollment period (SEP), including the full SEP verification lifecycle. Captures event type (marriage, birth, loss of coverage, relocation, divorce, adoption), event date, SEP window open/close dates, CMS SEP category codes, submitted documentation type and artifacts (birth certificate, marriage license, loss of coverage letter), verification status, verifier ID, verification date, CMS SEP verification outcome, pend/denial reason, and appeal reference. This is the authoritative SSOT for both QLE registration and SEP verification — no separate verification record exists. Required for ACA compliance, CMS SEP eligibility determinations, and SEP integrity program compliance. Sourced from Facets/QNXT pend workflow and member portal document uploads.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `open_health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - open enrollment periods are scoped to specific plans',
    `open_plan_health_plan_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `health_plan_id` BIGINT COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance verification outcome for the enrollment period.. Valid values are `compliant|non-compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment period record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_segment` STRING COMMENT 'Population segment eligible for this enrollment period (e.g., group, individual, Medicare).. Valid values are `Group|Individual|Medicare|Medicaid|Marketplace`',
    `end_date` DATE COMMENT 'Last calendar day for submitting enrollment applications; after this date the window closes.',
    `enrollment_cutoff_time` TIMESTAMP COMMENT 'Daily cut‑off time (in local time) after which submissions on the deadline date are rejected.',
    `enrollment_deadline_date` DATE COMMENT 'Final calendar date by which all enrollment submissions must be received.',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment window based on its recurrence and purpose.. Valid values are `Annual|Special|Continuous`',
    `exchange_type` STRING COMMENT 'Marketplace or exchange through which the enrollment is offered.. Valid values are `SHOP|Individual|Off-Exchange|Medicare|Medicaid`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_annual` BOOLEAN COMMENT 'True if the enrollment period recurs each year on the same schedule.',
    `is_retrospective_allowed` BOOLEAN COMMENT 'True if members may submit enrollment changes that become effective prior to the submission date.',
    `lob` STRING COMMENT 'Business line to which the enrollment period applies.. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or operational comments.',
    `open_enrollment_period_status` STRING COMMENT 'Current lifecycle status of the enrollment window.. Valid values are `upcoming|open|closed|cancelled|postponed`',
    `period_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the enrollment window across systems.',
    `period_name` STRING COMMENT 'Descriptive name of the enrollment window, e.g., "2025 Individual Marketplace OE".',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `group_id` BIGINT COMMENT 'Identifier of the employer group associated with the enrollment transaction.',
    `transaction_id` BIGINT COMMENT 'External identifier supplied by the sender to uniquely identify the transaction (e.g., control number from the senders system).',
    `vendor_id` BIGINT COMMENT 'Identifier of the trading partner that sent the 834 file (e.g., employer or broker ID).',
    `average_record_size_bytes` DECIMAL(18,2) COMMENT 'Average size of each member record within the file, calculated as file_size_bytes divided by member_count.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the enrollment coverage becomes effective for the member(s).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_action_code` STRING COMMENT 'Standard X12 834 code indicating Add (A), Delete (D), Modify (M), or Correct (C) action.. Valid values are `A|D|M|C`',
    `error_code` STRING COMMENT 'Standardized error code returned when processing fails (e.g., X12 validation error).',
    `error_description` STRING COMMENT 'Human‑readable description of the processing error.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `file_name` STRING COMMENT 'Original filename of the inbound 834 transaction as received from the EDI gateway.',
    `file_received_timestamp` TIMESTAMP COMMENT 'Date‑time when the 834 file was first ingested into the lakehouse.',
    `file_size_bytes` BIGINT COMMENT 'Total size of the inbound 834 file in bytes.',
    `group_control_number` STRING COMMENT 'Control number identifying the GS functional group for the transaction.',
    `interchange_control_number` STRING COMMENT 'Control number identifying the ISA interchange envelope for the transaction.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent processing attempt.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the transaction from ingestion to final disposition.. Valid values are `new|in_progress|completed|failed|cancelled`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_count` STRING COMMENT 'Number of individual member enrollment records contained in the 834 file.',
    `processing_attempts` STRING COMMENT 'Number of times the transaction has been attempted for processing.',
    `processing_status` STRING COMMENT 'Current workflow status of the transaction within the ingestion pipeline.. Valid values are `received|queued|processing|completed|error|rejected`',
    `receiver_code` STRING COMMENT 'Identifier of the trading partner that receives the 834 file (typically the health insurer).',
    `reconciliation_status` STRING COMMENT 'Result of matching the transaction to internal enrollment records.. Valid values are `unmatched|matched|partial|pending`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date on which the enrollment coverage ends, if applicable.',
    `transaction_set_control_number` STRING COMMENT 'Control number that uniquely identifies the 834 transaction set within the interchange.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp representing the business event time encoded in the 834 transaction (e.g., effective date of the enrollment action).',
    `transaction_type` STRING COMMENT 'Indicates whether the 834 file adds new enrollments, changes existing ones, terminates coverage, or corrects prior data.. Valid values are `add|change|terminate|correction`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_edi_transaction PRIMARY KEY(`edi_transaction_id`)
) COMMENT 'Raw and processed 834 EDI transaction records received from employer groups, exchanges, and CMS — the primary electronic mechanism for enrollment adds, changes, and terminations. Captures ISA/GS envelope metadata, transaction set control number, sender/receiver IDs, transaction type (full file vs. change only), processing status, error codes, and reconciliation status. Sourced from Availity/Change Healthcare EDI gateway. Distinct from enrollment_record (the business outcome) — this is the inbound EDI artifact.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` (
    `eligibility_verification_id` BIGINT COMMENT 'Primary key for eligibility_verification',
    `edi_transaction_id` BIGINT COMMENT 'add column transaction_270_id (BIGINT) with FK to enrollment.edi_transaction.edi_transaction_id - 270/271 verification is delivered via EDI',
    `eligibility_edi_transaction_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `identity_id` BIGINT COMMENT 'Unique member identifier used in the eligibility request (e.g., member number, SSN, MRN).',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_remaining` DECIMAL(18,2) COMMENT 'Members remaining deductible balance for the benefit period.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code associated with the request, if applicable.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_status` STRING COMMENT 'Overall result of the eligibility check (eligible, ineligible, error, or pending).. Valid values are `eligible|ineligible|error|pending`',
    `error_code` STRING COMMENT 'Technical or business error code returned in a failed eligibility response.',
    `error_description` STRING COMMENT 'Human‑readable description of the error condition.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage.CoverageEligibilityResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `inquiry_reference_number` STRING COMMENT 'External reference number assigned by the source system (e.g., Availity) for the eligibility request.',
    `inquiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility request was sent to the payer.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_identifier_type` STRING COMMENT 'Type of identifier supplied for the member (SSN, MRN, or internal member ID).. Valid values are `ssn|mrn|member_id`',
    `oop_remaining` DECIMAL(18,2) COMMENT 'Remaining out‑of‑pocket amount before maximum OOP is reached.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `response_message` STRING COMMENT 'Free‑form message returned by the payer providing additional context.',
    `response_time_seconds` DECIMAL(18,2) COMMENT 'Elapsed time between request and response, measured in seconds.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the eligibility response was received.',
    `service_code` STRING COMMENT 'CPT code of the service/procedure for which eligibility is being checked.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility record.',
    CONSTRAINT pk_eligibility_verification PRIMARY KEY(`eligibility_verification_id`)
) COMMENT 'Transactional record of real-time 270/271 eligibility verification requests and responses. Captures requesting provider NPI, member identifier used, inquiry date/time, response status, coverage details returned, deductible/OOP balances returned, and response time SLA. Supports provider-facing eligibility verification at point of care. Sourced from Availity/Change Healthcare 270/271 gateway and Facets real-time eligibility API.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` (
    `cobra_election_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA election record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group from which the member lost group coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health benefit plan associated with the COBRA election.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is electing COBRA continuation coverage.',
    `qualifying_life_event_id` BIGINT COMMENT 'add column qualifying_life_event_id (BIGINT) with FK to enrollment.qualifying_life_event.qualifying_life_event_id - COBRA elections are triggered by QLEs',
    `business_identifier` STRING COMMENT 'External reference number or code used by the business to identify the election.',
    `classification_or_type` STRING COMMENT 'Category of the agreement; identifies it as a COBRA continuation election.. Valid values are `cobra_election|cobra_continuation`',
    `cobra_premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount for COBRA coverage (typically 102% of the full premium).',
    `coverage_end_date` DATE COMMENT 'Date when COBRA coverage terminates.',
    `coverage_start_date` DATE COMMENT 'Effective date when COBRA coverage begins.',
    `coverage_type` STRING COMMENT 'Classification of COBRA coverage (individual, family, or dependent only).. Valid values are `individual|family|dependent`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dependent_count` STRING COMMENT 'Count of dependents included in the COBRA election.',
    `early_termination_flag` BOOLEAN COMMENT 'Indicates if the COBRA coverage was terminated before the scheduled end date.',
    `early_termination_notice_sent_flag` BOOLEAN COMMENT 'True when an early termination notice has been sent to the member.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `election_decision` STRING COMMENT 'Members decision regarding COBRA continuation coverage.. Valid values are `elected|declined|pending`',
    `election_notice_sent_flag` BOOLEAN COMMENT 'True when the election notice has been dispatched to the member.',
    `election_status` STRING COMMENT 'Current status of the COBRA election process.. Valid values are `pending|elected|declined|terminated|expired`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_payment_date` DATE COMMENT 'Date of the most recent premium payment received for the COBRA coverage.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the COBRA election record.. Valid values are `active|inactive|terminated|cancelled|pending`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or special instructions.',
    `notice_date_election` DATE COMMENT 'Date the election-specific notice (reminder) was sent to the member.',
    `notice_date_initial` DATE COMMENT 'Date the initial COBRA continuation coverage notice was sent to the member.',
    `notice_deadline` DATE COMMENT 'Last date by which the member must elect COBRA coverage.',
    `payment_method` STRING COMMENT 'Method used by the member to pay the COBRA premium.. Valid values are `payroll|credit_card|bank_transfer|check`',
    `payment_status` STRING COMMENT 'Current status of premium payment for the COBRA election.. Valid values are `paid|unpaid|partial|failed`',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the COBRA premium.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `premium_frequency` STRING COMMENT 'Frequency at which the COBRA premium is billed.. Valid values are `monthly|quarterly|annual`',
    `qualifying_event_date` DATE COMMENT 'Date on which the qualifying event occurred.',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying event that triggered COBRA eligibility.. Valid values are `termination|reduction_of_hours|divorce|death|aging_off`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the COBRA election record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COBRA election record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the subsidy applied to the premium.',
    `subsidy_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member qualifies for an ARP COBRA subsidy.',
    `subsidy_type` STRING COMMENT 'Type of subsidy applied to the COBRA premium.. Valid values are `arp|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_cobra_election PRIMARY KEY(`cobra_election_id`)
) COMMENT 'Master record tracking COBRA continuation coverage elections for members who have lost group health coverage due to a qualifying event (termination, reduction in hours, divorce, death, aging off dependent). Captures qualifying event type, election notice date, election deadline, election status, COBRA premium amount (102% of full premium), coverage start/end dates, subsidy eligibility (ARP COBRA subsidy), and COBRA-specific notice tracking (initial notice, election notice, early termination notice). Governed by ERISA Section 601-608 and DOL COBRA regulations. Sourced from Facets/QNXT COBRA module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` (
    `plan_election_id` BIGINT COMMENT 'Unique surrogate identifier for the plan election record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan that was elected.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber who made the election.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the election record.',
    `prior_plan_election_id` BIGINT COMMENT 'Reference to the previous election record when this election is a change or reinstatement.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Plan election pricing is derived from the assigned risk pool; the Plan Election Pricing report needs this association.',
    `cobra_eligibility_end_date` DATE COMMENT 'Date when COBRA eligibility expires.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected (e.g., employee only, employee + spouse, employee + children, family).. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dental_rider_flag` BOOLEAN COMMENT 'Indicates if a dental coverage rider was elected.',
    `effective_date` DATE COMMENT 'Date the elected coverage becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `election_number` STRING COMMENT 'External reference number assigned to the election by the enrollment system.',
    `election_type` STRING COMMENT 'Nature of the election event (new enrollment, change, termination, reinstatement).. Valid values are `new|change|termination|reinstatement`',
    `enrollment_event_type` STRING COMMENT 'Type of enrollment event that triggered the election.. Valid values are `open_enrollment|special_enrollment|qualifying_life_event`',
    `enrollment_source` STRING COMMENT 'Channel through which the election was submitted.. Valid values are `online|call_center|broker|mail`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fsa_election_flag` BOOLEAN COMMENT 'Indicates if a Flexible Spending Account was elected.',
    `hra_election_flag` BOOLEAN COMMENT 'Indicates if a Health Reimbursement Arrangement was elected.',
    `hsa_election_flag` BOOLEAN COMMENT 'Indicates if a Health Savings Account was elected.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates if the election is eligible for COBRA continuation coverage.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions related to the election.',
    `plan_election_status` STRING COMMENT 'Current processing status of the election record.. Valid values are `active|pending|terminated|cancelled`',
    `premium_contribution_employee` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee.',
    `premium_contribution_employer` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (e.g., monthly).. Valid values are `monthly|quarterly|annually`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the election record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the election record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date the elected coverage ends, if applicable.',
    `total_premium` DECIMAL(18,2) COMMENT 'Total premium amount for the elected coverage (employer + employee).',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vision_rider_flag` BOOLEAN COMMENT 'Indicates if a vision coverage rider was elected.',
    CONSTRAINT pk_plan_election PRIMARY KEY(`plan_election_id`)
) COMMENT 'Master record of a subscribers specific plan selection, coverage tier, and covered member roster during an enrollment or plan change event. Captures elected plan ID, coverage tier (employee-only, employee+spouse, employee+children, family), effective date, prior plan reference, premium contribution split (employer vs. employee), HSA/HRA/FSA election flag, dental/vision rider elections, and the roster of covered individuals with their relationship codes, age-out dates, and COBRA continuation eligibility. References member domain for person identity — this product owns the enrollment-specific election and roster, not the person demographics. Represents the members choice artifact — distinct from eligibility_span (the resulting coverage). Sourced from Facets/QNXT benefits election module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` (
    `pend_queue_id` BIGINT COMMENT 'Primary key for pend_queue',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for resolving the pend.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group associated with the enrollment, if applicable.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose enrollment is pending.',
    `transaction_id` BIGINT COMMENT 'add column transaction_id (BIGINT) with FK to enrollment.transaction.transaction_id - pended items are EDI/enrollment transactions',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the pend raises a compliance concern under HIPAA, ACA, or other regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pend record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the enrollment would become effective if the pend is resolved successfully.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the pend has been escalated to a higher tier.',
    `escalation_level` STRING COMMENT 'Severity level of the escalation.. Valid values are `low|medium|high`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_aptc_csr_conflict_flag` BOOLEAN COMMENT 'True when there is a conflict between Advanced Premium Tax Credit (APTC) eligibility and Cost Sharing Reduction (CSR) calculations.',
    `is_auto_resolved` BOOLEAN COMMENT 'True when the system automatically resolves the pend without human intervention.',
    `is_cms_match_failure_flag` BOOLEAN COMMENT 'True when the enrollment data fails validation against CMS EDPS/RAPS rules.',
    `is_documentation_missing_flag` BOOLEAN COMMENT 'True when required enrollment documentation has not been received.',
    `is_duplicate_flag` BOOLEAN COMMENT 'True when the pending enrollment is identified as a potential duplicate of an existing member record.',
    `is_eligibility_discrepancy_flag` BOOLEAN COMMENT 'True when there is a mismatch between submitted eligibility data and system records.',
    `is_employer_verification_hold_flag` BOOLEAN COMMENT 'True when the employer group verification is pending, causing the enrollment to be held.',
    `is_manual_review_required` BOOLEAN COMMENT 'True when the pend must be reviewed manually rather than automatically.',
    `last_escalation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent escalation event for the pend.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes entered by staff documenting additional context or actions.',
    `pend_reason_code` STRING COMMENT 'Standardized code indicating why the enrollment was placed in a pending state.',
    `pend_reason_description` STRING COMMENT 'Free‑text description providing detail about the pend reason.',
    `pend_reference_number` STRING COMMENT 'Human‑readable reference number assigned to the pend record for tracking and communication.',
    `pend_status` STRING COMMENT 'Current lifecycle status of the pending enrollment.. Valid values are `pending|resolved|escalated|closed`',
    `pend_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment transaction entered the pending queue.',
    `priority_level` STRING COMMENT 'Business priority assigned to the pend for handling order.. Valid values are `high|medium|low`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_rule_code` STRING COMMENT 'Code of the specific regulatory rule (e.g., CMS_14DAY) that governs the pends timeliness.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the pend (e.g., document upload, eligibility verification, manual override).',
    `resolution_date` TIMESTAMP COMMENT 'Timestamp when the pend was resolved.',
    `resolution_deadline` DATE COMMENT 'Date by which the pending issue must be resolved to meet SLA or regulatory timeliness.',
    `resolver_team` STRING COMMENT 'Name of the team or workgroup handling the pend.',
    `sla_actual_days` STRING COMMENT 'Actual number of days taken to resolve the pend.',
    `sla_compliance_status` STRING COMMENT 'Indicates whether the pend is meeting the Service Level Agreement targets.. Valid values are `compliant|non_compliant|at_risk`',
    `sla_target_days` STRING COMMENT 'Number of calendar days defined by SLA for resolving the pend.',
    `termination_date` DATE COMMENT 'Date on which the enrollment is terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pend record.',
    CONSTRAINT pk_pend_queue PRIMARY KEY(`pend_queue_id`)
) COMMENT 'Transactional record for enrollment transactions placed in a pending/suspended state awaiting resolution — missing documentation, eligibility discrepancy, duplicate member detection, CMS data match failure, employer group verification hold, or APTC/CSR eligibility conflict. Captures pend reason code, pend date, resolution deadline, assigned resolver (individual or team queue), resolution action taken, resolution date, escalation history, and SLA compliance status. Tracks enrollment processing turnaround SLA compliance per CMS timeliness standards (e.g., 14-day effectuation requirement) and state regulatory requirements. High-volume operational product — typically 5-15% of all enrollment transactions pend.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` (
    `medicaid_eligibility_id` BIGINT COMMENT 'System-generated unique identifier for the Medicaid eligibility record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Medicaid eligibility determinations are tied to a specific Medicaid health plan for state reporting and compliance.',
    `member_eligibility_span_id` BIGINT COMMENT 'FK to member.member_eligibility_span.member_eligibility_span_id',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility applies.',
    `prior_eligibility_medicaid_eligibility_id` BIGINT COMMENT 'Reference to the previous eligibility record for continuity tracking.',
    `assets_amount` DECIMAL(18,2) COMMENT 'Total countable assets reported for eligibility assessment.',
    `coverage_end_date` DATE COMMENT 'Date when Medicaid coverage under this eligibility ends, if known.',
    `coverage_start_date` DATE COMMENT 'Date when Medicaid coverage under this eligibility begins.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dual_eligible_flag` BOOLEAN COMMENT 'Indicates whether the member is also eligible for Medicare.',
    `effective_date` DATE COMMENT 'Date on which the Medicaid coverage becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_category` STRING COMMENT 'Classification of Medicaid eligibility based on income and other criteria.. Valid values are `MAGI|SSI|CHIP|Dual-Eligible`',
    `eligibility_determination_timestamp` TIMESTAMP COMMENT 'Exact date and time when the eligibility determination was made.',
    `eligibility_notes` STRING COMMENT 'Free-text notes captured by eligibility staff during determination.',
    `eligibility_number` STRING COMMENT 'Business reference number for the eligibility determination, used in reporting and external communications.',
    `eligibility_reason_code` STRING COMMENT 'Standard code indicating the reason for eligibility determination (e.g., income, disability).',
    `eligibility_status` STRING COMMENT 'Current lifecycle status of the eligibility record.. Valid values are `active|inactive|pending|terminated`',
    `eligibility_verification_date` DATE COMMENT 'Date on which eligibility information was verified.',
    `eligibility_verification_method` STRING COMMENT 'Method used to verify eligibility information.. Valid values are `electronic|paper|phone`',
    `enrollment_source` STRING COMMENT 'Origin of the eligibility record (e.g., EDI 834 file, Facets system, manual entry).. Valid values are `834_file|facets|manual`',
    `federal_program_indicator` BOOLEAN COMMENT 'True if the eligibility is linked to a federal program such as Medicare.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage.CoverageEligibilityResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Members income expressed as a percentage of the Federal Poverty Level.',
    `household_size` STRING COMMENT 'Number of individuals in the members household used for eligibility calculations.',
    `income_amount` DECIMAL(18,2) COMMENT 'Reported annual income used for eligibility calculation.',
    `income_verification_status` STRING COMMENT 'Result of the income verification process for eligibility.. Valid values are `verified|unverified|pending`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the eligibility record.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_program_type` STRING COMMENT 'Type of Medicaid program the member is enrolled in.. Valid values are `fee_for_service|managed_care|other`',
    `medical_need_flag` BOOLEAN COMMENT 'Indicates whether the member qualifies based on medical need criteria.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `redetermination_due_date` DATE COMMENT 'Date by which the member must be re-evaluated for continued eligibility.',
    `special_program_indicator` STRING COMMENT 'Identifies enrollment in special Medicaid programs (e.g., pregnant, disability).. Valid values are `pregnant|disability|elderly|none`',
    `state_agency` STRING COMMENT 'Two-letter code of the state Medicaid agency governing the eligibility.. Valid values are `^[A-Z]{2}$`',
    `state_medicaid_number` STRING COMMENT 'State-assigned Medicaid identification number for the member.',
    `termination_date` DATE COMMENT 'Date on which the Medicaid coverage ends or is scheduled to end.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_medicaid_eligibility PRIMARY KEY(`medicaid_eligibility_id`)
) COMMENT 'Master record tracking Medicaid and CHIP eligibility determinations for members enrolled in managed Medicaid plans. Captures Medicaid eligibility category (MAGI, SSI, CHIP, dual-eligible), state Medicaid ID, eligibility determination date, redetermination due date, income verification status, household size, FPL percentage, and dual-eligible Medicare coordination flag. Interfaces with state Medicaid agency eligibility systems and CMS EDPS. Sourced from state 834 files and Facets Medicaid module.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` (
    `medicare_entitlement_id` BIGINT COMMENT 'Unique surrogate key for the Medicare entitlement record.',
    `lob_assignment_id` BIGINT COMMENT 'add column lob_assignment_id (BIGINT) with FK to member.lob_assignment.lob_assignment_id - Medicare entitlement drives LOB assignment',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member to whom this entitlement belongs.',
    `cms_contract_number` STRING COMMENT 'Identifier of the CMS contract under which the members Medicare coverage is administered.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the entitlement record was first created in the lakehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dual_eligible_flag` BOOLEAN COMMENT '',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_span_end` DATE COMMENT 'End date of the members overall Medicare eligibility period (null if ongoing).',
    `eligibility_span_start` DATE COMMENT 'Start date of the members overall Medicare eligibility period.',
    `entitlement_number` STRING COMMENT 'External reference number used by business partners to identify this entitlement.',
    `entitlement_status` STRING COMMENT 'Overall lifecycle status of the Medicare entitlement record.. Valid values are `active|inactive|terminated|suspended`',
    `entitlement_type` STRING COMMENT 'Category of Medicare coverage (e.g., Medicare Advantage, Part D, Dual Eligible).. Valid values are `MA|PartD|Dual|Other`',
    `esrd_indicator` BOOLEAN COMMENT '',
    `extra_help_effective_date` DATE COMMENT 'Date the Extra Help status became effective.',
    `extra_help_status` STRING COMMENT 'Eligibility status for the Extra Help program (assists with Part D costs).. Valid values are `eligible|ineligible|pending`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hicn_or_mbi` STRING COMMENT '',
    `irmaa_effective_date` DATE COMMENT 'Date the IRMAA status became effective.',
    `irmaa_income_bracket` STRING COMMENT 'Income bracket used to calculate the members IRMAA surcharge.',
    `irmaa_status` STRING COMMENT 'Current IRMAA status indicating whether the member pays an income‑based surcharge.. Valid values are `eligible|ineligible|pending`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_dual_eligible` BOOLEAN COMMENT 'Indicates whether the member is eligible for both Medicare and Medicaid.',
    `is_retired` BOOLEAN COMMENT 'True if the entitlement has been retired (e.g., member deceased or moved to non‑Medicare coverage).',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date‑time when the entitlement information was last verified against CMS.',
    `lis_effective_date` DATE COMMENT 'Date on which the LIS status became effective.',
    `lis_status` STRING COMMENT 'Current status of the members Low Income Subsidy eligibility.. Valid values are `eligible|ineligible|pending`',
    `ma_enrollment_effective_date` DATE COMMENT 'Date the members Medicare Advantage (MA) plan enrollment became effective.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mbi` STRING COMMENT 'Unique 11‑character identifier assigned to each Medicare beneficiary.',
    `notes` STRING COMMENT 'Free‑form text for any additional remarks or audit comments.',
    `part_a_effective_date` DATE COMMENT '',
    `part_a_entitlement_date` DATE COMMENT 'Effective date on which the member became entitled to Medicare Part A benefits.',
    `part_a_termination_date` DATE COMMENT 'Date on which Part A entitlement ended, if applicable.',
    `part_b_effective_date` DATE COMMENT '',
    `part_b_entitlement_date` DATE COMMENT 'Effective date on which the member became entitled to Medicare Part B benefits.',
    `part_b_termination_date` DATE COMMENT 'Date on which Part B entitlement ended, if applicable.',
    `part_d_effective_date` DATE COMMENT '',
    `part_d_enrollment_effective_date` DATE COMMENT 'Date the members Medicare Part D prescription drug coverage became effective.',
    `pbp_assignment` STRING COMMENT 'Code representing the primary business partner (e.g., health plan) assigned to the member.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_record_reference` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `stub_populated_flag` BOOLEAN COMMENT 'Indicates that this stub product has been populated with required attributes',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the entitlement record.',
    `verification_status` STRING COMMENT 'Current verification state of the entitlement data.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_medicare_entitlement PRIMARY KEY(`medicare_entitlement_id`)
) COMMENT 'Master record capturing Medicare entitlement and enrollment details for members in Medicare Advantage (MA) and Part D plans. Captures Medicare Beneficiary Identifier (MBI), Part A/B entitlement dates, MA enrollment effective date, Part D enrollment effective date, Low Income Subsidy (LIS) status, Extra Help level, IRMAA status, and CMS contract/PBP assignment. Sourced from CMS MARx system data and EDPS enrollment confirmations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Primary key for reconciliation',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or service account that executed the reconciliation.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group whose roster is being reconciled.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - reconciliation is per plan',
    `auto_resolution_flag` BOOLEAN COMMENT 'Indicates whether the system automatically resolved the discrepancy.',
    `comments` STRING COMMENT 'Free‑form notes captured by the analyst about the reconciliation outcome.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for financial impact values.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `discrepancy_add_count` STRING COMMENT 'Count of enrollment records present in the source but missing in the internal system.',
    `discrepancy_change_count` STRING COMMENT 'Count of enrollment attribute changes (e.g., plan, coverage) that differ between systems.',
    `discrepancy_demographic_mismatch_count` STRING COMMENT 'Number of records where member demographic data (name, DOB, SSN) does not match.',
    `discrepancy_detail_file_path` STRING COMMENT 'File system or object storage path to the detailed discrepancy report generated by the run.',
    `discrepancy_termination_count` STRING COMMENT 'Count of enrollment records terminated in the source but still active internally.',
    `discrepancy_total_count` STRING COMMENT 'Aggregate number of mismatches identified in the reconciliation run.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_impact_adjustment` DECIMAL(18,2) COMMENT 'Sum of adjustments (credits, penalties) applied to the gross impact.',
    `financial_impact_gross` DECIMAL(18,2) COMMENT 'Total gross monetary impact of all unresolved discrepancies before adjustments.',
    `financial_impact_net` DECIMAL(18,2) COMMENT 'Net monetary impact after adjustments; the amount that may affect premium billing.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `manual_resolution_flag` BOOLEAN COMMENT 'Indicates whether human intervention is required to resolve the discrepancy.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `period_end` DATE COMMENT 'End date of the enrollment coverage period being reconciled.',
    `period_start` DATE COMMENT 'Start date of the enrollment coverage period being reconciled.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation process.. Valid values are `pending|in_progress|completed|error|manual_review|cancelled`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_deadline` DATE COMMENT 'Date by which outstanding discrepancies must be resolved to avoid financial impact.',
    `run_number` BIGINT COMMENT 'Sequential number assigned to each reconciliation execution for tracking and audit purposes.',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation run was initiated.',
    `run_type` STRING COMMENT 'Indicates whether the run was a full reconciliation or an incremental update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Transactional record capturing periodic reconciliation between the health plans enrollment records and external authoritative sources — employer group rosters, CMS enrollment files (TRR/MARx), state Medicaid agency 834 files, and ACA exchange enrollment data. Captures reconciliation run date, source system, discrepancy count by type (adds, terms, changes, demographic mismatches), auto-resolution vs. manual resolution status, resolution deadline, and financial impact of unresolved discrepancies on premium billing and risk adjustment. Critical for CMS compliance (monthly TRR reconciliation), premium billing accuracy, and employer group roster integrity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` (
    `exchange_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the exchange enrollment record.',
    `eligibility_verification_id` BIGINT COMMENT 'add column eligibility_verification_id (BIGINT) with FK to enrollment.eligibility_verification.eligibility_verification_id - exchange enrollment requires eligibility verification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Exchange enrollment updates are performed by staff; FK supports regulatory audit of who last modified enrollment data.',
    `enrollment_original_exchange_enrollment_id` BIGINT COMMENT 'Identifier of the original enrollment record that this renewal references.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original transaction received from the ACA exchange gateway.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group (if group coverage) linked to the enrollment.',
    `health_plan_id` BIGINT COMMENT 'Health Insurance Oversight System (HIOS) plan identifier as provided by the marketplace.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with this enrollment.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: ACA marketplace reporting requires associating each exchange enrollment with the provider network for network‑level statistics.',
    `qualifying_life_event_id` BIGINT COMMENT 'Reference to the qualifying life event that triggered a special enrollment, if any.',
    `aptc_subsidy_id` BIGINT COMMENT '',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the advance premium tax credit applied to the members premium.',
    `coverage_type` STRING COMMENT 'Indicates whether the enrollment is for an individual, family, or group coverage.. Valid values are `individual|family|group`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange enrollment record was first created in the lakehouse.',
    `csr_variant` STRING COMMENT 'Indicates the level of cost‑sharing reduction applied (none, full, or partial).. Valid values are `none|full|partial`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the enrollment coverage becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effectuation_deadline` DATE COMMENT 'Latest date by which the enrollment must be effectuated to avoid loss of coverage.',
    `effectuation_status` STRING COMMENT 'Status of the enrollment effectuation process with the marketplace.. Valid values are `pending|effectuated|failed`',
    `enrollment_effectuation_timestamp` TIMESTAMP COMMENT 'Exact time when the enrollment was effectuated with the marketplace.',
    `enrollment_renewal_indicator` BOOLEAN COMMENT 'True if this enrollment record represents a renewal of a prior enrollment.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `pending|active|terminated|cancelled|reinstated`',
    `enrollment_termination_initiator` STRING COMMENT 'Entity that initiated the termination of the enrollment.. Valid values are `member|employer|system|regulator`',
    `enrollment_termination_reason_code` STRING COMMENT 'Standardized code representing the reason for enrollment termination.',
    `enrollment_termination_type` STRING COMMENT 'Classifies the termination as voluntary or involuntary.. Valid values are `voluntary|involuntary`',
    `enrollment_type` STRING COMMENT 'Nature of the enrollment event (e.g., new enrollment, renewal, reinstatement, termination).. Valid values are `new|renewal|reinstatement|termination`',
    `exchange_eligibility_determination_reference` STRING COMMENT 'Reference number linking to the eligibility determination used for this enrollment.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `marketplace_source` STRING COMMENT 'Origin of the enrollment: Federally Facilitated Marketplace (FFM), State-Based Marketplace (SBM), or Small Business Health Options Program (SHOP).. Valid values are `FFM|SBM|SHOP`',
    `marketplace_state` STRING COMMENT 'Two‑letter state code where the marketplace enrollment originated (if applicable).. Valid values are `^[A-Z]{2}$`',
    `marketplace_year` STRING COMMENT 'Calendar year of the marketplace enrollment period.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_due_date` DATE COMMENT 'Date by which the premium payment must be received.',
    `payment_method` STRING COMMENT 'Method used to collect the premium payment.. Valid values are `credit_card|bank_transfer|check|auto_debit`',
    `payment_status` STRING COMMENT 'Current status of premium payment for the enrollment.. Valid values are `paid|unpaid|partial|failed`',
    `plan_year` STRING COMMENT 'The plan year to which this enrollment belongs (e.g., 2024).',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly (or applicable frequency) premium amount for the enrollment.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (e.g., monthly, quarterly, annually).. Valid values are `monthly|quarterly|annually`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_1095a_flag` BOOLEAN COMMENT 'Indicates whether this enrollment must be reported on Form 1095‑A.',
    `reporting_1095a_generated_date` DATE COMMENT 'Date on which the 1095‑A form was generated for this enrollment.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy amount (APTC + CSR) applied to the premium.',
    `subsidy_type` STRING COMMENT 'Type of subsidy applied (APTC, Cost Sharing Reduction, or none).. Valid values are `aptc|csc|none`',
    `tax_credit_reconciliation_status` STRING COMMENT 'Status of the reconciliation of tax credits (APTC/CSR) with the IRS.. Valid values are `reconciled|pending|error`',
    `termination_date` DATE COMMENT 'Date on which the enrollment coverage ends, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exchange enrollment record.',
    CONSTRAINT pk_exchange_enrollment PRIMARY KEY(`exchange_enrollment_id`)
) COMMENT 'Master record for enrollments originating from ACA health insurance exchanges — Federally Facilitated Marketplace (FFM), State-Based Marketplaces (SBM), and SHOP exchange. Captures exchange transaction ID, marketplace plan ID (HIOS ID), APTC amount and reconciliation status, CSR variant, eligibility determination reference, effectuation status, 1095-A reporting flag, and premium payment effectuation deadline. Interfaces with CMS FFM enrollment data feeds. Critical for ACA compliance, APTC reconciliation with IRS, and annual 1095-A generation. Sourced from Availity/Change Healthcare exchange gateway and CMS 834 files.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` (
    `submission_batch_id` BIGINT COMMENT 'Primary key for submission_batch',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - CMS submission batches are scoped to a plan/contract',
    `parent_submission_batch_id` BIGINT COMMENT 'Self-referencing FK on submission_batch (parent_submission_batch_id)',
    `batch_approval_by` STRING COMMENT 'Email address of the user who approved the batch.',
    `batch_approval_date` TIMESTAMP COMMENT 'Timestamp when the batch was approved.',
    `batch_archival_date` TIMESTAMP COMMENT 'Timestamp when the batch was archived.',
    `batch_deletion_date` TIMESTAMP COMMENT 'Timestamp when the batch was deleted.',
    `batch_description` STRING COMMENT 'Human-readable description of the batch purpose.',
    `batch_error_count` STRING COMMENT 'Number of errors encountered during batch processing.',
    `batch_error_details` STRING COMMENT 'Detailed error messages for failed submissions.',
    `batch_failure_count` STRING COMMENT 'Number of failed submissions in the batch.',
    `batch_failure_details` STRING COMMENT 'Details of failed submissions.',
    `batch_finalization_date` TIMESTAMP COMMENT 'Timestamp when the batch was finalized.',
    `batch_is_approved` BOOLEAN COMMENT 'Flag indicating if the batch has been approved for processing.',
    `batch_is_archived` BOOLEAN COMMENT 'Flag indicating if the batch has been archived.',
    `batch_is_automatic` BOOLEAN COMMENT 'Flag indicating if the batch was generated automatically.',
    `batch_is_deleted` BOOLEAN COMMENT 'Flag indicating if the batch has been deleted.',
    `batch_is_finalized` BOOLEAN COMMENT 'Flag indicating if the batch has been finalized.',
    `batch_is_manual` BOOLEAN COMMENT 'Flag indicating if the batch was created manually.',
    `batch_is_retroactive` BOOLEAN COMMENT 'Flag indicating if the batch contains retroactive submissions.',
    `batch_notes` STRING COMMENT 'Additional notes or comments about the batch.',
    `batch_number` BIGINT COMMENT 'Sequential number assigned to the batch for internal tracking.',
    `batch_processing_end` TIMESTAMP COMMENT 'Timestamp when processing of the batch completed.',
    `batch_processing_start` TIMESTAMP COMMENT 'Timestamp when processing of the batch began.',
    `batch_reference_number` STRING COMMENT 'External reference number for the batch, e.g., CMS reference.',
    `batch_status` STRING COMMENT 'Current lifecycle state of the batch.',
    `batch_submission_date` DATE COMMENT 'Date when the batch was submitted to the system.',
    `batch_submission_time` TIMESTAMP COMMENT 'Timestamp of batch submission.',
    `batch_success_count` STRING COMMENT 'Number of successful submissions in the batch.',
    `batch_success_details` STRING COMMENT 'Details of successful submissions.',
    `batch_type` STRING COMMENT 'Category of the batch indicating the enrollment context.',
    `batch_warning_count` STRING COMMENT 'Number of warnings encountered during batch processing.',
    `batch_warning_details` STRING COMMENT 'Detailed warning messages for submissions.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the batch record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from_date` DATE COMMENT 'Date when the batch becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until_date` DATE COMMENT 'Date when the batch expires or is no longer effective.',
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
    `source_system_version` STRING COMMENT 'Version or release of the source system.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all submissions in the batch.',
    `total_submissions` STRING COMMENT 'Number of individual submissions included in the batch.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the batch record was last updated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_submission_batch PRIMARY KEY(`submission_batch_id`)
) COMMENT 'Master reference table for submission_batch. Referenced by submission_batch_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` (
    `enrollment_eligibility_span_id` BIGINT COMMENT 'System-generated unique identifier for the enrollment eligibility span record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Needed for eligibility reporting to show which benefit package a members coverage span belongs to, essential for benefit design analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Eligibility spans are processed by a case‑manager employee; linking enables case‑manager workload and audit reports.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each eligibility span must satisfy particular regulatory obligations (e.g., ACA reporting); linking enables obligation‑by‑span compliance tracking.',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Large employers apply division‑specific eligibility rules; linking enables division‑level eligibility analytics.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group for group enrollments.',
    `group_location_id` BIGINT COMMENT 'Foreign key linking to employer.group_location. Business justification: Eligibility calculations depend on employers primary location to apply network rules and state‑specific regulations.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan associated with this eligibility span.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Eligibility reconciliation report requires linking each enrollment eligibility span to the members eligibility span to compare periods and resolve discrepancies.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility span applies.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Needed to assign a primary care provider to each member’s coverage span for network compliance and care coordination reports.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network associated with the plan.',
    `transaction_id` BIGINT COMMENT 'Identifier of the enrollment transaction that generated this span.',
    `benefit_designation` STRING COMMENT 'Design of the benefit plan (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `benefit_period_end` DATE COMMENT 'End date of the benefit period (often same as termination_date).',
    `benefit_period_start` DATE COMMENT 'Start date of the benefit period (often same as effective_date).',
    `benefit_year` STRING COMMENT 'Calendar year for which the benefit amounts apply.',
    `coverage_category` STRING COMMENT 'Classification of the covered individual (e.g., employee, spouse).. Valid values are `Employee|Spouse|Dependent|Retiree|Other`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable amount for a specific benefit within the span.',
    `coverage_limit_units` STRING COMMENT 'Unit of measure for the coverage limit (e.g., visits, days).. Valid values are `visits|days|sessions|units|claims`',
    `coverage_type` STRING COMMENT 'Type of coverage provided in this span (e.g., medical, dental).. Valid values are `Medical|Dental|Vision|Pharmacy|Wellness`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility span record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount applicable for this span.',
    `deductible_reset_date` DATE COMMENT 'Date when the deductible accumulator resets (usually start of benefit year).',
    `effective_date` DATE COMMENT 'Date when the eligibility span becomes active.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_status` STRING COMMENT 'Eligibility determination for the member during this span.. Valid values are `eligible|ineligible|pending`',
    `enrollment_eligibility_span_status` STRING COMMENT 'Current lifecycle status of the eligibility span.. Valid values are `active|inactive|terminated|pending`',
    `enrollment_event_type` STRING COMMENT 'Category of enrollment event that created or modified this span.. Valid values are `OpenEnrollment|SpecialEnrollment|QualifyingLifeEvent|Retroactive|ManualAdjustment`',
    `enrollment_source` STRING COMMENT 'System or channel through which the enrollment was received.. Valid values are `EDI_834|WebPortal|CallCenter|BatchUpload`',
    `fhir_coverage_resource_identifier` STRING COMMENT 'FHIR Coverage resource identifier for interoperability. No FK, VARCHAR.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage.CoverageEligibilityResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary_coverage` BOOLEAN COMMENT 'True if this span represents the members primary coverage.',
    `is_waiver_applied` BOOLEAN COMMENT 'Indicates if a cost‑sharing waiver (e.g., HSA) is applied to this span.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last changed.',
    `line_of_business` STRING COMMENT 'Business line under which the enrollment is processed.. Valid values are `Commercial|Medicare|Medicaid|Exchange|Group`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `moop_reset_date` DATE COMMENT 'Date when the MOOP threshold resets.',
    `moop_threshold` DECIMAL(18,2) COMMENT 'Combined deductible and OOP limit for this span.',
    `oop_maximum` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense the member can incur.',
    `oop_reset_date` DATE COMMENT 'Date when the OOP accumulator resets.',
    `plan_code` STRING COMMENT 'External plan identifier used in contracts and communications.',
    `prior_coverage_end_date` DATE COMMENT 'Termination date of the preceding coverage period, if any.',
    `prior_coverage_indicator` BOOLEAN COMMENT 'True if the member had coverage immediately before this span.',
    `qualifying_life_event_code` STRING COMMENT 'Code representing the life event that triggered a special enrollment.. Valid values are `MARRIAGE|DIVORCE|BIRTH|ADOPTION|DEATH|EMPLOYER_CHANGE`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the span was created or modified retroactively.',
    `retroactive_adjustment_reason` STRING COMMENT 'Explanation for a retroactive change to the eligibility span.',
    `subscriber_relationship` STRING COMMENT 'Relationship of the covered individual to the subscriber.. Valid values are `Self|Spouse|Child|OtherDependent`',
    `termination_date` DATE COMMENT 'Date when the eligibility span ends; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `utilization_reset_date` DATE COMMENT 'Date when utilization counters (e.g., visit counts) reset.',
    `waiver_type` STRING COMMENT 'Type of waiver applied, if any.. Valid values are `HSA|FSA|HRA|None`',
    `fhir_coverage_resource_id` STRING COMMENT '',
    CONSTRAINT pk_enrollment_eligibility_span PRIMARY KEY(`enrollment_eligibility_span_id`)
) COMMENT 'Core master record representing a members continuous coverage period under a specific health plan, including benefit year boundaries, deductible/OOP accumulator reset dates, and MOOP thresholds. Captures effective date, termination date, coverage type, line of business (commercial, Medicare, Medicaid), plan code, subscriber relationship, eligibility status, and benefit period attributes. This is the authoritative SSOT for is this member covered? and what benefit period applies? at any point in time. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT enrollment module and CMS EDPS for government programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` (
    `cms_submission_id` BIGINT COMMENT 'Primary key for cms_submission',
    `benefit_package_id` BIGINT COMMENT 'Identifier for the specific benefit package within the plan.',
    `transaction_id` BIGINT COMMENT 'Unique transaction identifier assigned by CMS for the submission.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the enrollment.',
    `subscriber_id` BIGINT COMMENT 'Internal identifier of the member whose enrollment is being submitted.',
    `submission_batch_id` BIGINT COMMENT 'Alphanumeric identifier for the batch of enrollment records submitted together.',
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
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_cms_submission_status` STRING COMMENT 'Current lifecycle status of the submission within the processing pipeline.. Valid values are `pending|accepted|rejected|processed|error`',
    `error_code` STRING COMMENT 'Technical error code returned by the CMS response file.',
    `error_message` STRING COMMENT 'Detailed error message associated with the error code.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_legacy_submission` BOOLEAN COMMENT 'Flag indicating whether the submission originates from a legacy system.',
    `is_test_submission` BOOLEAN COMMENT 'Flag indicating whether the submission is a test (non‑production) record.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_number` STRING COMMENT 'External member identifier used in member communications and EDI files.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final premium amount after adjustments, to be billed.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Timestamp when internal processing of the submission completed.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Timestamp when internal processing of the submission began.',
    `processing_status` STRING COMMENT 'Current status of internal processing of the submission file.. Valid values are `not_started|in_progress|completed|failed`',
    `raf_score_impact` DECIMAL(18,2) COMMENT 'Numeric impact on the members RAF score resulting from the enrollment.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` (
    `batch_id` BIGINT COMMENT 'Primary key for enrollment_batch',
    `parent_enrollment_batch_id` BIGINT COMMENT 'Self-referencing FK on enrollment_batch (parent_enrollment_batch_id)',
    `approval_by` STRING COMMENT 'Identifier of the user who approved or rejected the batch.',
    `approval_comments` STRING COMMENT 'Comments provided during the approval or rejection of the batch.',
    `approval_status` STRING COMMENT 'Current approval status of the batch in the workflow.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was approved or rejected.',
    `batch_number` STRING COMMENT 'Human-readable identifier for the enrollment batch, often used in reporting and communication.',
    `batch_type` STRING COMMENT 'Classification of the batch indicating the enrollment process type.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `batch_description` STRING COMMENT 'Free-text description providing context about the batch.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the batch becomes effective for enrollment processing.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the batch ceases to be effective. Nullable for open-ended batches.',
    `enrollment_batch_status` STRING COMMENT 'Current lifecycle status of the batch.',
    `error_count` STRING COMMENT 'Number of errors encountered during batch processing.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the batch has been archived for long-term retention.',
    `is_auto` BOOLEAN COMMENT 'Indicates whether the batch was generated automatically by the system.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the batch has been logically deleted.',
    `is_live` BOOLEAN COMMENT 'Indicates whether the batch is a live production batch.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the batch was created manually by an operator.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether the batch contains retroactive adjustments.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the batch is a test batch used for validation purposes.',
    `load_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was loaded into the lakehouse.',
    `load_user` STRING COMMENT 'Identifier of the user or system that performed the load.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional notes or comments related to the batch.',
    `priority` STRING COMMENT 'Priority level assigned to the batch for processing order.',
    `priority_level` STRING COMMENT 'Numeric representation of the batch priority for sorting.',
    `processing_duration_seconds` STRING COMMENT 'Total duration of batch processing in seconds.',
    `processing_end` TIMESTAMP COMMENT 'Timestamp when batch processing completed.',
    `processing_start` TIMESTAMP COMMENT 'Timestamp when batch processing began.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reference_number` STRING COMMENT 'External reference number associated with the batch, used for cross-system traceability.',
    `reference_type` STRING COMMENT 'Type of reference used for the batch (e.g., CMS_EDPS, internal).',
    `source` STRING COMMENT 'Source of the batch data, such as CMS EDPS or internal system.',
    `source_system_batch_reference` STRING COMMENT 'Identifier of the batch in the originating system.',
    `success_count` STRING COMMENT 'Number of successful records processed in the batch.',
    `total_adjustments` STRING COMMENT 'Number of retroactive adjustment events processed in this batch.',
    `total_enrollments` STRING COMMENT 'Number of enrollment events processed in this batch.',
    `total_reinstatements` STRING COMMENT 'Number of reinstatement events processed in this batch.',
    `total_terminations` STRING COMMENT 'Number of termination events processed in this batch.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `version` STRING COMMENT 'Version number of the batch record for change tracking.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the batch record.',
    CONSTRAINT pk_batch PRIMARY KEY(`batch_id`)
) COMMENT 'Master reference table for enrollment_batch. Referenced by enrollment_batch_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`batch`(`batch_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_edi_transaction_id` FOREIGN KEY (`edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`event`(`event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_edi_transaction_id` FOREIGN KEY (`edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_eligibility_edi_transaction_id` FOREIGN KEY (`eligibility_edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_prior_plan_election_id` FOREIGN KEY (`prior_plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ADD CONSTRAINT `fk_enrollment_pend_queue_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_prior_eligibility_medicaid_eligibility_id` FOREIGN KEY (`prior_eligibility_medicaid_eligibility_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_eligibility_verification_id` FOREIGN KEY (`eligibility_verification_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`(`eligibility_verification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_enrollment_original_exchange_enrollment_id` FOREIGN KEY (`enrollment_original_exchange_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment`(`exchange_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ADD CONSTRAINT `fk_enrollment_submission_batch_parent_submission_batch_id` FOREIGN KEY (`parent_submission_batch_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`submission_batch`(`submission_batch_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_submission_batch_id` FOREIGN KEY (`submission_batch_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`submission_batch`(`submission_batch_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ADD CONSTRAINT `fk_enrollment_batch_parent_enrollment_batch_id` FOREIGN KEY (`parent_enrollment_batch_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`batch`(`batch_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('pii_domain' = 'enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Audit User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `batch_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `group_contact_id` SET TAGS ('pii_business_glossary_term' = 'Group Contact Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `group_renewal_id` SET TAGS ('pii_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Member Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `raps_submission_id` SET TAGS ('pii_business_glossary_term' = 'Raps Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `rate_id` SET TAGS ('pii_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_value_regex' = 'premium_change|plan_change|error_correction|regulatory|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('pii_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('pii_value_regex' = 'admin|operator|system');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `claims_reprocess_flag` SET TAGS ('pii_business_glossary_term' = 'Claims Reprocess Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('pii_value_regex' = 'continuous|intermittent|gap');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_comment` SET TAGS ('pii_business_glossary_term' = 'Enrollment Comment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Span Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('pii_business_glossary_term' = 'Enrollment Origin (ENROLL_ORIGIN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('pii_value_regex' = 'online|call_center|mail|agent|broker');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Enrollment Transaction Number (ETN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Type (ENROLL_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('pii_value_regex' = 'open|sep|auto|special|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Enrollment Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `financial_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Premium Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('pii_business_glossary_term' = 'Health Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('pii_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('pii_business_glossary_term' = 'Grace Period Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `original_termination_reference` SET TAGS ('pii_business_glossary_term' = 'Original Termination Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('pii_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `reactivation_date` SET TAGS ('pii_business_glossary_term' = 'Reactivation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Transaction Source (TXN_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'edi_834|web_portal|batch|api');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('pii_value_regex' = 'voluntary|involuntary|nonpayment|eligibility|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Transaction Status (ENROLL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_value_regex' = 'pending|processed|failed|cancelled|completed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Actor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier (Employer Group ID)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `group_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `group_plan_offering_id` SET TAGS ('pii_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('pii_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('pii_business_glossary_term' = 'Actor Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('pii_value_regex' = 'member|employer|system|cms|provider');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_description` SET TAGS ('pii_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date of Status Change');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'submitted|approved|rejected|terminated|reinstated|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `is_manual` SET TAGS ('pii_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('pii_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('pii_business_glossary_term' = 'Previous Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('pii_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Event Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'core_admin|provider_system|member_portal|edi_gateway|batch_process');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('pii_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verifier ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `appeal_reference` SET TAGS ('pii_business_glossary_term' = 'Appeal Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('pii_business_glossary_term' = 'CMS SEP Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('pii_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('pii_value_regex' = 'birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_date` SET TAGS ('pii_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'marriage|birth|loss_of_coverage|relocation|divorce|adoption');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('pii_business_glossary_term' = 'CMS SEP Category Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_end` SET TAGS ('pii_business_glossary_term' = 'Special Enrollment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_start` SET TAGS ('pii_business_glossary_term' = 'Special Enrollment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('pii_business_glossary_term' = 'SEP Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('pii_value_regex' = 'open|closed|expired');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'pending|verified|denied|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_plan_health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_plan_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_plan_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('pii_business_glossary_term' = 'Eligibility Segment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('pii_value_regex' = 'Group|Individual|Medicare|Medicaid|Marketplace');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_cutoff_time` SET TAGS ('pii_business_glossary_term' = 'Enrollment Cutoff Time (HH:MM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Window Type (Annual, Special, Continuous)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('pii_value_regex' = 'Annual|Special|Continuous');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('pii_business_glossary_term' = 'Exchange Type (SHOP, Individual, Off-Exchange, Medicare, Medicaid)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('pii_value_regex' = 'SHOP|Individual|Off-Exchange|Medicare|Medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_annual` SET TAGS ('pii_business_glossary_term' = 'Annual Recurrence Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_retrospective_allowed` SET TAGS ('pii_business_glossary_term' = 'Retroactive Enrollment Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('pii_value_regex' = 'upcoming|open|closed|cancelled|postponed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Period Code (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Period Name (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_filing_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_actual` SET TAGS ('pii_business_glossary_term' = 'Enrollment Volume Actual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target` SET TAGS ('pii_business_glossary_term' = 'Enrollment Volume Target');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target_met` SET TAGS ('pii_business_glossary_term' = 'Enrollment Target Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `edi_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Edi Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Business Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Sender EDI Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `average_record_size_bytes` SET TAGS ('pii_business_glossary_term' = 'Average Record Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('pii_business_glossary_term' = 'Enrollment Action Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('pii_value_regex' = 'A|D|M|C');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Processing Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Processing Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('pii_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'File Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('pii_business_glossary_term' = 'Group Control Number (GS08)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('pii_business_glossary_term' = 'Interchange Control Number (ISA13)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `last_attempt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Processing Attempt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'new|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Member Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_attempts` SET TAGS ('pii_business_glossary_term' = 'Processing Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('pii_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('pii_value_regex' = 'received|queued|processing|completed|error|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('pii_business_glossary_term' = 'Receiver EDI Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'unmatched|matched|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Control Number (ST02)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_value_regex' = 'add|change|terminate|correction');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_fhir_resource' = 'Coverage.CoverageEligibilityResponse');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_verification_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_required` SET TAGS ('pii_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('pii_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('pii_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_limit` SET TAGS ('pii_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_remaining` SET TAGS ('pii_business_glossary_term' = 'Benefit Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_used` SET TAGS ('pii_business_glossary_term' = 'Benefit Used Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `deductible_remaining` SET TAGS ('pii_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|error|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('pii_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_timestamp` SET TAGS ('pii_business_glossary_term' = 'Inquiry Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('pii_business_glossary_term' = 'Member Identifier Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('pii_value_regex' = 'ssn|mrn|member_id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `oop_remaining` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket (OOP) Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_message` SET TAGS ('pii_business_glossary_term' = 'Response Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_time_seconds` SET TAGS ('pii_business_glossary_term' = 'Response Time (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_subdomain' = 'plan_selection');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_election_id` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `business_identifier` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Business Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `classification_or_type` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Classification');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `classification_or_type` SET TAGS ('pii_value_regex' = 'cobra_election|cobra_continuation');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('pii_business_glossary_term' = 'COBRA Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `cobra_premium_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'individual|family|dependent');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `dependent_count` SET TAGS ('pii_business_glossary_term' = 'Number of Dependents Covered');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `early_termination_flag` SET TAGS ('pii_business_glossary_term' = 'Early Termination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `early_termination_notice_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Early Termination Notice Sent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `election_decision` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Decision');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `election_decision` SET TAGS ('pii_value_regex' = 'elected|declined|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `election_notice_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Election Notice Sent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `election_status` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `election_status` SET TAGS ('pii_value_regex' = 'pending|elected|declined|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|cancelled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `notice_date_election` SET TAGS ('pii_business_glossary_term' = 'Election Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `notice_date_initial` SET TAGS ('pii_business_glossary_term' = 'Initial COBRA Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `notice_deadline` SET TAGS ('pii_business_glossary_term' = 'Election Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'payroll|credit_card|bank_transfer|check');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'paid|unpaid|partial|failed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `premium_currency` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `premium_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `premium_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_date` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_type` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Type (COBRA)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `qualifying_event_type` SET TAGS ('pii_value_regex' = 'termination|reduction_of_hours|divorce|death|aging_off');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Subsidy Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_type` SET TAGS ('pii_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `subsidy_type` SET TAGS ('pii_value_regex' = 'arp|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_subdomain' = 'plan_selection');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_id` SET TAGS ('pii_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `prior_plan_election_id` SET TAGS ('pii_business_glossary_term' = 'Prior Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `cobra_eligibility_end_date` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('pii_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `dental_rider_flag` SET TAGS ('pii_business_glossary_term' = 'Dental Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('pii_business_glossary_term' = 'Plan Election Number (PLAN_ELECTION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('pii_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('pii_value_regex' = 'new|change|termination|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('pii_value_regex' = 'open_enrollment|special_enrollment|qualifying_life_event');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('pii_value_regex' = 'online|call_center|broker|mail');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fsa_election_flag` SET TAGS ('pii_business_glossary_term' = 'FSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hra_election_flag` SET TAGS ('pii_business_glossary_term' = 'HRA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hsa_election_flag` SET TAGS ('pii_business_glossary_term' = 'HSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_cobra_eligible` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Election Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('pii_business_glossary_term' = 'Election Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('pii_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employee` SET TAGS ('pii_business_glossary_term' = 'Employee Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employer` SET TAGS ('pii_business_glossary_term' = 'Employer Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `total_premium` SET TAGS ('pii_business_glossary_term' = 'Total Premium');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `vision_rider_flag` SET TAGS ('pii_business_glossary_term' = 'Vision Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_queue_id` SET TAGS ('pii_business_glossary_term' = 'Pend Queue Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Resolver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `escalation_level` SET TAGS ('pii_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `escalation_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_aptc_csr_conflict_flag` SET TAGS ('pii_business_glossary_term' = 'APTC/CSR Conflict Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_auto_resolved` SET TAGS ('pii_business_glossary_term' = 'Auto‑Resolved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_cms_match_failure_flag` SET TAGS ('pii_business_glossary_term' = 'CMS Match Failure Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_documentation_missing_flag` SET TAGS ('pii_business_glossary_term' = 'Documentation Missing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_duplicate_flag` SET TAGS ('pii_business_glossary_term' = 'Duplicate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_eligibility_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Eligibility Discrepancy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_employer_verification_hold_flag` SET TAGS ('pii_business_glossary_term' = 'Employer Verification Hold Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `is_manual_review_required` SET TAGS ('pii_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `last_escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Escalation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Pend Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_reason_code` SET TAGS ('pii_business_glossary_term' = 'Pend Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_reason_description` SET TAGS ('pii_business_glossary_term' = 'Pend Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_reference_number` SET TAGS ('pii_business_glossary_term' = 'Pend Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_status` SET TAGS ('pii_business_glossary_term' = 'Pend Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_status` SET TAGS ('pii_value_regex' = 'pending|resolved|escalated|closed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `pend_timestamp` SET TAGS ('pii_business_glossary_term' = 'Pend Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `regulatory_rule_code` SET TAGS ('pii_business_glossary_term' = 'Regulatory Rule Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `regulatory_rule_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `resolution_deadline` SET TAGS ('pii_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `resolver_team` SET TAGS ('pii_business_glossary_term' = 'Resolver Team');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `sla_actual_days` SET TAGS ('pii_business_glossary_term' = 'SLA Actual Days');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `sla_compliance_status` SET TAGS ('pii_business_glossary_term' = 'SLA Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `sla_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|at_risk');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `sla_target_days` SET TAGS ('pii_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_fhir_resource' = 'Coverage.CoverageEligibilityResponse');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `prior_eligibility_medicaid_eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Prior Eligibility ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `assets_amount` SET TAGS ('pii_business_glossary_term' = 'Assets Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `dual_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('pii_business_glossary_term' = 'Eligibility Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_category` SET TAGS ('pii_value_regex' = 'MAGI|SSI|CHIP|Dual-Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_determination_timestamp` SET TAGS ('pii_business_glossary_term' = 'Eligibility Determination Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_notes` SET TAGS ('pii_business_glossary_term' = 'Eligibility Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('pii_business_glossary_term' = 'Eligibility Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('pii_business_glossary_term' = 'Eligibility Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_date` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `eligibility_verification_method` SET TAGS ('pii_value_regex' = 'electronic|paper|phone');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `enrollment_source` SET TAGS ('pii_value_regex' = '834_file|facets|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `federal_program_indicator` SET TAGS ('pii_business_glossary_term' = 'Federal Program Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `household_size` SET TAGS ('pii_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Income Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('pii_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `income_verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `last_update_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('pii_business_glossary_term' = 'Medicaid Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medicaid_program_type` SET TAGS ('pii_value_regex' = 'fee_for_service|managed_care|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Need Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `medical_need_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `redetermination_due_date` SET TAGS ('pii_business_glossary_term' = 'Redetermination Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('pii_business_glossary_term' = 'Special Program Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `special_program_indicator` SET TAGS ('pii_value_regex' = 'pregnant|disability|elderly|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('pii_business_glossary_term' = 'State Agency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_agency` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('pii_business_glossary_term' = 'State Medicaid ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `state_medicaid_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `medicare_entitlement_id` SET TAGS ('pii_business_glossary_term' = 'Medicare Entitlement ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_end` SET TAGS ('pii_business_glossary_term' = 'Eligibility Span End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `eligibility_span_start` SET TAGS ('pii_business_glossary_term' = 'Eligibility Span Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('pii_business_glossary_term' = 'Entitlement Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('pii_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('pii_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('pii_value_regex' = 'MA|PartD|Dual|Other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_effective_date` SET TAGS ('pii_business_glossary_term' = 'Extra Help Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('pii_business_glossary_term' = 'Extra Help Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `extra_help_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_effective_date` SET TAGS ('pii_business_glossary_term' = 'IRMAA Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_income_bracket` SET TAGS ('pii_business_glossary_term' = 'IRMAA Income Bracket');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('pii_business_glossary_term' = 'Income‑Related Monthly Adjustment Amount (IRMAA) Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `irmaa_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_dual_eligible` SET TAGS ('pii_business_glossary_term' = 'Dual Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `is_retired` SET TAGS ('pii_business_glossary_term' = 'Retired Entitlement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `last_verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_effective_date` SET TAGS ('pii_business_glossary_term' = 'LIS Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('pii_business_glossary_term' = 'Low Income Subsidy (LIS) Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `lis_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `ma_enrollment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Medicare Advantage Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('pii_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `mbi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_entitlement_date` SET TAGS ('pii_business_glossary_term' = 'Part A Entitlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_a_termination_date` SET TAGS ('pii_business_glossary_term' = 'Part A Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_entitlement_date` SET TAGS ('pii_business_glossary_term' = 'Part B Entitlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_b_termination_date` SET TAGS ('pii_business_glossary_term' = 'Part B Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `part_d_enrollment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Part D Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `pbp_assignment` SET TAGS ('pii_business_glossary_term' = 'Primary Business Partner (PBP) Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processed By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `auto_resolution_flag` SET TAGS ('pii_business_glossary_term' = 'Automatic Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Comments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_add_count` SET TAGS ('pii_business_glossary_term' = 'Additions Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_change_count` SET TAGS ('pii_business_glossary_term' = 'Changes Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_demographic_mismatch_count` SET TAGS ('pii_business_glossary_term' = 'Demographic Mismatch Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_detail_file_path` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Detail File Path');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_termination_count` SET TAGS ('pii_business_glossary_term' = 'Terminations Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_total_count` SET TAGS ('pii_business_glossary_term' = 'Total Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_adjustment` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_gross` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_net` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `manual_resolution_flag` SET TAGS ('pii_business_glossary_term' = 'Manual Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_end` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_start` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|error|manual_review|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `resolution_deadline` SET TAGS ('pii_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Run Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_subdomain' = 'plan_selection');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Last Updated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_original_exchange_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Original Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Marketplace Plan ID (HIOS ID)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('pii_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('pii_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `aptc_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'individual|family|group');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `csr_variant` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Reduction (CSR) Variant');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `csr_variant` SET TAGS ('pii_value_regex' = 'none|full|partial');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_deadline` SET TAGS ('pii_business_glossary_term' = 'Effectuation Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_status` SET TAGS ('pii_business_glossary_term' = 'Effectuation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `effectuation_status` SET TAGS ('pii_value_regex' = 'pending|effectuated|failed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_effectuation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Enrollment Effectuation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_renewal_indicator` SET TAGS ('pii_business_glossary_term' = 'Enrollment Renewal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_value_regex' = 'pending|active|terminated|cancelled|reinstated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_initiator` SET TAGS ('pii_business_glossary_term' = 'Enrollment Termination Initiator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_initiator` SET TAGS ('pii_value_regex' = 'member|employer|system|regulator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Enrollment Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_termination_type` SET TAGS ('pii_value_regex' = 'voluntary|involuntary');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('pii_value_regex' = 'new|renewal|reinstatement|termination');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `exchange_eligibility_determination_reference` SET TAGS ('pii_business_glossary_term' = 'Eligibility Determination Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_source` SET TAGS ('pii_business_glossary_term' = 'Marketplace Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_source` SET TAGS ('pii_value_regex' = 'FFM|SBM|SHOP');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_state` SET TAGS ('pii_business_glossary_term' = 'Marketplace State');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `marketplace_year` SET TAGS ('pii_business_glossary_term' = 'Marketplace Year');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|bank_transfer|check|auto_debit');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'paid|unpaid|partial|failed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `premium_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `reporting_1095a_flag` SET TAGS ('pii_business_glossary_term' = '1095‑A Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `reporting_1095a_generated_date` SET TAGS ('pii_business_glossary_term' = '1095‑A Generation Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('pii_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('pii_value_regex' = 'aptc|csc|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `tax_credit_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Tax Credit Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `tax_credit_reconciliation_status` SET TAGS ('pii_value_regex' = 'reconciled|pending|error');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `submission_batch_id` SET TAGS ('pii_business_glossary_term' = 'Submission Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `parent_submission_batch_id` SET TAGS ('pii_business_glossary_term' = 'Parent Submission Batch Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `parent_submission_batch_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_approval_by` SET TAGS ('pii_business_glossary_term' = 'Batch Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_approval_date` SET TAGS ('pii_business_glossary_term' = 'Batch Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_archival_date` SET TAGS ('pii_business_glossary_term' = 'Batch Archival Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_deletion_date` SET TAGS ('pii_business_glossary_term' = 'Batch Deletion Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_description` SET TAGS ('pii_business_glossary_term' = 'Batch Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_error_count` SET TAGS ('pii_business_glossary_term' = 'Batch Error Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_error_details` SET TAGS ('pii_business_glossary_term' = 'Batch Error Details');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_failure_count` SET TAGS ('pii_business_glossary_term' = 'Batch Failure Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_failure_details` SET TAGS ('pii_business_glossary_term' = 'Batch Failure Details');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_finalization_date` SET TAGS ('pii_business_glossary_term' = 'Batch Finalization Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_approved` SET TAGS ('pii_business_glossary_term' = 'Batch Is Approved');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_archived` SET TAGS ('pii_business_glossary_term' = 'Batch Is Archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_automatic` SET TAGS ('pii_business_glossary_term' = 'Batch Is Automatic');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_deleted` SET TAGS ('pii_business_glossary_term' = 'Batch Is Deleted');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_finalized` SET TAGS ('pii_business_glossary_term' = 'Batch Is Finalized');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_manual` SET TAGS ('pii_business_glossary_term' = 'Batch Is Manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_is_retroactive` SET TAGS ('pii_business_glossary_term' = 'Batch Is Retroactive');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_notes` SET TAGS ('pii_business_glossary_term' = 'Batch Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_processing_end` SET TAGS ('pii_business_glossary_term' = 'Batch Processing End');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_processing_start` SET TAGS ('pii_business_glossary_term' = 'Batch Processing Start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_reference_number` SET TAGS ('pii_business_glossary_term' = 'Batch Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_status` SET TAGS ('pii_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_submission_date` SET TAGS ('pii_business_glossary_term' = 'Batch Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_submission_time` SET TAGS ('pii_business_glossary_term' = 'Batch Submission Time');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_success_count` SET TAGS ('pii_business_glossary_term' = 'Batch Success Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_success_details` SET TAGS ('pii_business_glossary_term' = 'Batch Success Details');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_type` SET TAGS ('pii_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_warning_count` SET TAGS ('pii_business_glossary_term' = 'Batch Warning Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `batch_warning_details` SET TAGS ('pii_business_glossary_term' = 'Batch Warning Details');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `effective_until_date` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `source_system_version` SET TAGS ('pii_business_glossary_term' = 'Source System Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `total_submissions` SET TAGS ('pii_business_glossary_term' = 'Total Submissions');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_fhir_resource' = 'Coverage.CoverageEligibilityResponse');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Eligibility Span ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Case Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_division_id` SET TAGS ('pii_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `group_location_id` SET TAGS ('pii_business_glossary_term' = 'Group Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('pii_business_glossary_term' = 'Benefit Designation (TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_designation` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_period_end` SET TAGS ('pii_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_period_start` SET TAGS ('pii_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `benefit_year` SET TAGS ('pii_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('pii_business_glossary_term' = 'Coverage Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_category` SET TAGS ('pii_value_regex' = 'Employee|Spouse|Dependent|Retiree|Other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_limit_units` SET TAGS ('pii_value_regex' = 'visits|days|sessions|units|claims');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type (TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `deductible_reset_date` SET TAGS ('pii_business_glossary_term' = 'Deductible Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Span Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_eligibility_span_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_event_type` SET TAGS ('pii_value_regex' = 'OpenEnrollment|SpecialEnrollment|QualifyingLifeEvent|Retroactive|ManualAdjustment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('pii_value_regex' = 'EDI_834|WebPortal|CallCenter|BatchUpload');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `is_primary_coverage` SET TAGS ('pii_business_glossary_term' = 'Primary Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `is_waiver_applied` SET TAGS ('pii_business_glossary_term' = 'Waiver Applied Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|Group');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `moop_reset_date` SET TAGS ('pii_business_glossary_term' = 'MOOP Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `moop_threshold` SET TAGS ('pii_business_glossary_term' = 'Maximum‑Of‑Pay Threshold (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `oop_maximum` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `oop_reset_date` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `prior_coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Prior Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `prior_coverage_indicator` SET TAGS ('pii_business_glossary_term' = 'Prior Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `qualifying_life_event_code` SET TAGS ('pii_business_glossary_term' = 'Qualifying Life Event Code (QLE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `qualifying_life_event_code` SET TAGS ('pii_value_regex' = 'MARRIAGE|DIVORCE|BIRTH|ADOPTION|DEATH|EMPLOYER_CHANGE');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `qualifying_life_event_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `retroactive_adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_value_regex' = 'Self|Spouse|Child|OtherDependent');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `utilization_reset_date` SET TAGS ('pii_business_glossary_term' = 'Utilization Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('pii_business_glossary_term' = 'Waiver Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `waiver_type` SET TAGS ('pii_value_regex' = 'HSA|FSA|HRA|None');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ALTER COLUMN `fhir_coverage_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `cms_submission_id` SET TAGS ('pii_business_glossary_term' = 'Cms Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Package ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'CMS Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_batch_id` SET TAGS ('pii_business_glossary_term' = 'Submission Batch ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('pii_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `audit_user_role` SET TAGS ('pii_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_check_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_error_code` SET TAGS ('pii_business_glossary_term' = 'Compliance Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_error_description` SET TAGS ('pii_business_glossary_term' = 'Compliance Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|GBP|EUR|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `enrollment_cms_submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `enrollment_cms_submission_status` SET TAGS ('pii_value_regex' = 'pending|accepted|rejected|processed|error');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `is_legacy_submission` SET TAGS ('pii_business_glossary_term' = 'Legacy Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `is_test_submission` SET TAGS ('pii_business_glossary_term' = 'Test Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('pii_business_glossary_term' = 'Member Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `member_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_status` SET TAGS ('pii_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `processing_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `raf_score_impact` SET TAGS ('pii_business_glossary_term' = 'RAF Score Impact');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('pii_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_file_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission File Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('pii_business_glossary_term' = 'Submission Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('pii_value_regex' = 'Facets|QNXT|Custom');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'initial|correction|delete|termination');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `submission_version` SET TAGS ('pii_business_glossary_term' = 'Submission Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `total_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `batch_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `parent_enrollment_batch_id` SET TAGS ('pii_business_glossary_term' = 'Parent Enrollment Batch Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `parent_enrollment_batch_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `approval_by` SET TAGS ('pii_business_glossary_term' = 'Batch Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `approval_comments` SET TAGS ('pii_business_glossary_term' = 'Batch Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Batch Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Batch Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `batch_type` SET TAGS ('pii_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `batch_description` SET TAGS ('pii_business_glossary_term' = 'Batch Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `enrollment_batch_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `error_count` SET TAGS ('pii_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_archived` SET TAGS ('pii_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_auto` SET TAGS ('pii_business_glossary_term' = 'Is Auto');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_deleted` SET TAGS ('pii_business_glossary_term' = 'Is Deleted');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_live` SET TAGS ('pii_business_glossary_term' = 'Is Live');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_manual` SET TAGS ('pii_business_glossary_term' = 'Is Manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_retroactive` SET TAGS ('pii_business_glossary_term' = 'Is Retroactive');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `is_test` SET TAGS ('pii_business_glossary_term' = 'Is Test');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `load_timestamp` SET TAGS ('pii_business_glossary_term' = 'Batch Load Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `load_user` SET TAGS ('pii_business_glossary_term' = 'Batch Load User');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Batch Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Batch Priority');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Batch Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `processing_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Processing Duration Seconds');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `processing_end` SET TAGS ('pii_business_glossary_term' = 'Processing End');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `processing_start` SET TAGS ('pii_business_glossary_term' = 'Processing Start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Batch Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `reference_type` SET TAGS ('pii_business_glossary_term' = 'Batch Reference Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Batch Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `source_system_batch_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Batch Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `success_count` SET TAGS ('pii_business_glossary_term' = 'Success Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_adjustments` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_enrollments` SET TAGS ('pii_business_glossary_term' = 'Total Enrollments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_reinstatements` SET TAGS ('pii_business_glossary_term' = 'Total Reinstatements');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_reinstatements` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_reinstatements` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `total_terminations` SET TAGS ('pii_business_glossary_term' = 'Total Terminations');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Batch Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`batch` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
