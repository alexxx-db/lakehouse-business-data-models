-- Schema for Domain: enrollment | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`enrollment` COMMENT 'Manages the end-to-end enrollment and eligibility lifecycle — open enrollment, special enrollment periods, qualifying life events, 834 EDI transactions, effective dates, terminations, reinstatements, and retroactive adjustments. Owns eligibility spans, coverage periods, and enrollment event history. Interfaces with CMS EDPS/RAPS for government program enrollment and supports 270/271 real-time eligibility verification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Enrollment transactions must reference the benefit package to drive claims adjudication, cost-sharing application, and benefit utilization tracking. Payers require benefit-package-level transaction re',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Each enrollment transaction occurs within a defined open enrollment period; linking transaction to period enables period‑based reporting and ensures the period is not a silo.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with this enrollment transaction.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Each enrollment transaction can generate a Care Plan; linking enables cost, outcome, and compliance reporting per transaction.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Enrollment transactions directly create, modify, or terminate member policies. CMS audit trails and claims reprocessing require tracing each transaction to the specific policy it affects. Health insur',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network enrollment reporting for quarterly compliance requires linking each transaction to the provider network.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: An enrollment transaction can be triggered by a qualifying life event (QLE) that opens a special enrollment period (SEP). Linking transaction.qualifying_life_event_id -> qualifying_life_event provides',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.plan_rate. Business justification: Required for premium audit reports that must trace each enrollment transaction to the exact rate applied for regulatory compliance.',
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
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Transactional record capturing every enrollment action for a member — initial enrollment, re-enrollment, plan change, disenrollment (voluntary/involuntary termination), reinstatement, and retroactive adjustment. Tracks enrollment source, enrollment period type (open enrollment, SEP, auto-enrollment), effective date, submitted date, processing status, and transaction-type-specific attributes: termination reason/last day of coverage/grace period status for disenrollments; original termination reference/reinstatement effective date/approving authority for reinstatements; adjusted dates/financial impact flag/claims reprocessing trigger for retro adjustments. One enrollment_transaction may produce one or more eligibility_spans. Sourced from Facets/QNXT and 834 EDI transactions via Availity/Change Healthcare.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`event` (
    `event_id` BIGINT COMMENT 'System-generated unique identifier for each enrollment event record.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member associated with the enrollment event.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Enrollment lifecycle events are scoped to an open enrollment period — e.g., OEP opened, OEP closed, enrollment deadline approaching, volume target met events. Linking event.open_enrollment_period_id -',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Enrollment lifecycle events (submitted, pended, approved, terminated) can be directly associated with a specific plan election — e.g., a plan election approval event, a termination event for a specifi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Enrollment lifecycle events (effective date changes, terminations, reinstatements) affect a specific policy. Operational audit trails and regulatory reporting require knowing which policy an enrollmen',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network change audit log records which network triggered an enrollment event for regulatory audit.',
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
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who reported the qualifying life event.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A QLE triggers a Special Enrollment Period resulting in a specific policy change. CMS SEP compliance tracking, appeals processing, and regulatory documentation require linking the qualifying event to ',
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
    `service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Open enrollment periods are geographically scoped to plan service areas. Market-level OEP planning, enrollment capacity management (enrollment_capacity on plan_service_area), and CMS exchange reportin',
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
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: 834 EDI enrollment files are submitted per health plan. CMS and state exchanges require plan-level EDI reconciliation and audit trails. Without this FK, edi_transaction cannot be directly associated w',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: EDI 834 transaction files are submitted by employer groups and exchanges during specific open enrollment periods. Linking edi_transaction.open_enrollment_period_id -> open_enrollment_period associates',
    `transaction_id` BIGINT COMMENT 'External identifier supplied by the sender to uniquely identify the transaction (e.g., control number from the senders system).',
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
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: HIPAA 270/271 eligibility transactions are benefit-specific — providers query eligibility for a specific service/benefit category. Linking eligibility_verification to plan.benefit enables precise bene',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: HIPAA 270/271 eligibility verification responses must return benefit-package-level cost-sharing details (deductibles, copays, OOP maximums) to providers. Without this FK, the eligibility_verification ',
    `edi_transaction_id` BIGINT COMMENT 'add column transaction_270_id (BIGINT) with FK to enrollment.edi_transaction.edi_transaction_id - 270/271 verification is delivered via EDI',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled.',
    `identity_id` BIGINT COMMENT 'Unique member identifier used in the eligibility request (e.g., member number, SSN, MRN).',
    `participation_status_id` BIGINT COMMENT 'Foreign key linking to provider.participation_status. Business justification: Real-time eligibility verification (270/271 EDI) must confirm the providers active participation status in the members plan/network at the time of service. This link directly supports in-network vs.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: A 270/271 eligibility verification request checks a members active coverage under a specific plan election. Linking eligibility_verification.plan_election_id -> plan_election connects the real-time e',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: EDI 270/271 eligibility verification is performed against a specific member policy to confirm active coverage, deductible remaining, and OOP max. Providers require policy-level verification responses.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Eligibility verifications reference the specific practice location where service will be rendered, since a provider may be in-network at one location but not another. Location-specific network partici',
    `primary_eligibility_edi_transaction_id` BIGINT COMMENT '',
    `provider_directory_id` BIGINT COMMENT 'Foreign key linking to network.provider_directory. Business justification: Real-time eligibility verification (270/271 EDI transactions) confirms a providers in-network status by consulting a specific directory listing. Linking eligibility_verification to the provider_direc',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` (
    `plan_election_id` BIGINT COMMENT 'Unique surrogate identifier for the plan election record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A plan election is billed under a specific billing account that governs payment terms, billing cycle, and auto-pay setup. Premium collection operations and billing account establishment at enrollment ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: When a member elects a plan, they enroll into a specific benefit package governing cost-sharing, formulary tier, and network designation. This link is essential for premium billing, EOB generation, an',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: A members plan election determines which formulary governs their drug benefits. Benefit administrators, member services, and claims adjudication require this link to display covered drugs, enforce ti',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan that was elected.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: CMS risk-adjusted premium reconciliation requires linking each plan election to the members risk score for that payment year. Risk adjustment payment validation (RAPS/EDGE) depends on confirming that',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber who made the election.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: A plan election is made within the context of a specific open enrollment period (annual OEP, ACA marketplace OEP, or Medicare OEP). Linking plan_election.open_enrollment_period_id -> open_enrollment_p',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: A plan elections pharmacy benefits are administered under a specific PBM contract. Claims routing, pharmacy benefit adjudication, PBM performance reporting, and rebate reconciliation all require know',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: HMO and gatekeeper plans require PCP selection at enrollment. The elected PCP is a specific provider_assignment record (provider credentialed and paneled in the network). This drives care coordination',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: HMO/POS plan elections require PCP designation at enrollment. This FK tracks the members assigned Primary Care Provider per plan election, supporting care coordination, referral authorization, PCP pa',
    `plan_association_id` BIGINT COMMENT 'Foreign key linking to network.plan_association. Business justification: Plan elections must reference the specific plan-network association active at election time. This governs network access rules, PCP selection requirements, directory lookups, and adequacy compliance r',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A plan election produces or updates a member policy. Premium reconciliation, benefit administration, and coverage verification all require tracing which plan election generated which policy. Health in',
    `prior_plan_election_id` BIGINT COMMENT 'Reference to the previous election record when this election is a change or reinstatement.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: A plan election can be triggered by a qualifying life event (QLE) that opens a special enrollment period (SEP) — e.g., marriage, birth, loss of coverage. The plan_election.enrollment_event_type attrib',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: A plan election is the direct outcome of an enrollment transaction — the subscribers specific plan selection is created as a result of processing an enrollment transaction. Linking plan_election.tran',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Primary key for reconciliation',
    `edi_transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.edi_transaction. Business justification: Enrollment reconciliation is typically initiated by or associated with an EDI 834 transaction file received from an employer group, exchange, or CMS. Linking reconciliation.edi_transaction_id -> edi_t',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - reconciliation is per plan',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: CMS TRR/MARx enrollment reconciliation identifies discrepancies at the policy level — adds, changes, terminations. Linking reconciliation to a specific policy enables financial impact tracking and res',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: Enrollment reconciliation compares membership records against billing invoices to identify financial discrepancies (adds, terms, demographic mismatches). Financial impact reporting and discrepancy res',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: A reconciliation record captures discrepancies between the health plans enrollment records and external sources. Linking reconciliation.transaction_id -> transaction associates the reconciliation out',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_edi_transaction_id` FOREIGN KEY (`edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_primary_eligibility_edi_transaction_id` FOREIGN KEY (`primary_eligibility_edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_prior_plan_election_id` FOREIGN KEY (`prior_plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_edi_transaction_id` FOREIGN KEY (`edi_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`edi_transaction`(`edi_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`enrollment` SET TAGS ('dbx_domain' = 'enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'premium_change|plan_change|error_correction|regulatory|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_value_regex' = 'admin|operator|system');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `claims_reprocess_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Reprocess Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `coverage_period_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|gap');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_comment` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Comment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Origin (ENROLL_ORIGIN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_origin` SET TAGS ('dbx_value_regex' = 'online|call_center|mail|agent|broker');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Number (ETN)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_transaction_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENROLL_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open|sep|auto|special|manual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `health_plan_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `is_grace_period` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `original_termination_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Termination Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status (PROC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source (TXN_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'edi_834|web_portal|batch|api');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|nonpayment|eligibility|other');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction Status (ENROLL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|cancelled|completed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'member|employer|system|cms|provider');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Status Change');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|terminated|reinstated|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|reinstated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'core_admin|provider_system|member_portal|edi_gateway|batch_process');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `appeal_reference` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `cms_sep_outcome` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'birth_certificate|marriage_license|loss_of_coverage_letter|relocation_proof|divorce_decree|adoption_order');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'marriage|birth|loss_of_coverage|relocation|divorce|adoption');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `qualifying_life_event_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_business_glossary_term' = 'CMS SEP Category Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_category_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_end` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_start` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_business_glossary_term' = 'SEP Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `sep_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|denied|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Segment');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `eligibility_segment` SET TAGS ('dbx_value_regex' = 'Group|Individual|Medicare|Medicaid|Marketplace');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cutoff Time (HH:MM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type (Annual, Special, Continuous)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'Annual|Special|Continuous');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type (SHOP, Individual, Off-Exchange, Medicare, Medicaid)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'SHOP|Individual|Off-Exchange|Medicare|Medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurrence Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `is_retrospective_allowed` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Enrollment Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_status` SET TAGS ('dbx_value_regex' = 'upcoming|open|closed|cancelled|postponed');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Code (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Name (OEP)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_actual` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Actual');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Volume Target');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ALTER COLUMN `volume_target_met` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Target Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `average_record_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Average Record Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Action Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_value_regex' = 'A|D|M|C');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `enrollment_action_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number (GS08)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `group_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number (ISA13)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `last_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Processing Attempt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'new|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_attempts` SET TAGS ('dbx_business_glossary_term' = 'Processing Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'received|queued|processing|completed|error|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver EDI Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `receiver_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number (ST02)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'add|change|terminate|correction');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `participation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Status Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `provider_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_limit` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_remaining` SET TAGS ('dbx_business_glossary_term' = 'Benefit Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `benefit_used` SET TAGS ('dbx_business_glossary_term' = 'Benefit Used Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `deductible_remaining` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|error|pending');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `member_identifier_type` SET TAGS ('dbx_value_regex' = 'ssn|mrn|member_id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `oop_remaining` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket (OOP) Remaining Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Seconds)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `service_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` SET TAGS ('dbx_subdomain' = 'eligibility_management');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_association_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `prior_plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan Election ID');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `cobra_eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `dental_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Number (PLAN_ELECTION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'new|change|termination|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|qualifying_life_event');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|broker|mail');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `fsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'FSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hra_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HRA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `hsa_election_flag` SET TAGS ('dbx_business_glossary_term' = 'HSA Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Election Notes');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_business_glossary_term' = 'Election Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `plan_election_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employee` SET TAGS ('dbx_business_glossary_term' = 'Employee Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_contribution_employer` SET TAGS ('dbx_business_glossary_term' = 'Employer Premium Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `total_premium` SET TAGS ('dbx_business_glossary_term' = 'Total Premium');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ALTER COLUMN `vision_rider_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Rider Election Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` SET TAGS ('dbx_subdomain' = 'enrollment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `edi_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `auto_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Comments');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_add_count` SET TAGS ('dbx_business_glossary_term' = 'Additions Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_change_count` SET TAGS ('dbx_business_glossary_term' = 'Changes Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_demographic_mismatch_count` SET TAGS ('dbx_business_glossary_term' = 'Demographic Mismatch Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_detail_file_path` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Detail File Path');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_termination_count` SET TAGS ('dbx_business_glossary_term' = 'Terminations Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `discrepancy_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Discrepancy Count');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_gross` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `financial_impact_net` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `manual_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|error|manual_review|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Number');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
