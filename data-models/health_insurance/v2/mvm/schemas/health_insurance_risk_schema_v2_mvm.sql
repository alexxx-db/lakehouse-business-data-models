-- Schema for Domain: risk | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'System-generated unique identifier for the member risk score record.',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: CMS requires risk scores to correspond to validated enrollment/eligibility periods for payment accuracy. Compliance and actuarial teams must verify each risk score aligns with an active eligibility sp',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CMS risk adjustment payment calculation requires member risk scores to be associated with the specific health_plan for RAF computation, MLR reporting, and CMS submissions. Risk actuaries and complianc',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the risk score applies.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: CMS risk adjustment payments are tied to specific policy/coverage periods. Actuaries and compliance teams must link each risk score to the exact policy it was calculated for — supporting premium recon',
    `score_run_id` BIGINT COMMENT '',
    `audit_user` STRING COMMENT 'User ID of the person who performed the most recent audit action.',
    `cms_published_score` DECIMAL(18,2) COMMENT 'RAF score value as published by CMS after reconciliation.',
    `cms_submission_status` STRING COMMENT 'Current status of the scores submission to CMS.. Valid values are `submitted|accepted|rejected|pending`',
    `corrective_action` STRING COMMENT 'Description of actions taken to resolve score variance (e.g., code addendum, data correction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk score record was first created in the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `demographic_factor_score` DECIMAL(18,2) COMMENT 'Score component derived from member demographics (age, gender, Medicaid status).',
    `diagnosis_count` STRING COMMENT 'Number of distinct diagnoses captured for the member in the scoring period.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the risk score became effective.',
    `expiration_date` DATE COMMENT 'Date after which the risk score is no longer valid for payment.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: RiskAssessment)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_codes` STRING COMMENT 'Pipe‑separated list of HCC codes contributing to the score.',
    `hcc_count` BIGINT COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the score was manually overridden.',
    `manual_override_reason` STRING COMMENT 'Reason provided for a manual override of the risk score.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `model_name` STRING COMMENT 'Name of the risk adjustment model (e.g., "CMS‑HCC", "RxHCC", "HHS‑HCC").',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model used to generate the score (e.g., "CMS‑HCC v2023").',
    `payment_year` BIGINT COMMENT 'Calendar year for which the risk score is used in CMS payment calculations.',
    `plan_calculated_score` DECIMAL(18,2) COMMENT 'RAF score calculated internally by the health plan prior to CMS submission.',
    `raf_score` DECIMAL(18,2) COMMENT 'add column raf_score, hcc_count, score_methodology_code (CMS-HCC v24, etc.), payment_year, score_run_id (BIGINT) FK to risk.score_run.score_run_id',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Lifecycle status of the risk score record.. Valid values are `active|inactive|archived`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resubmission_reference` STRING COMMENT 'Reference identifier for any resubmitted score file to CMS.',
    `risk_adjustment_factor_category` STRING COMMENT 'Category of the risk adjustment factor (e.g., "RAF", "HCC", "RxHCC").',
    `risk_score_code` STRING COMMENT 'Business identifier code for the risk score record, often composed of member ID, year, and model version.',
    `risk_score_confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) assigned by the model to the score.',
    `risk_score_label` STRING COMMENT 'Human‑readable label describing the risk score record (e.g., "2023 Medicare Advantage RAF").',
    `risk_score_notes` STRING COMMENT 'Free‑text field for any additional commentary or observations.',
    `risk_score_source` STRING COMMENT 'Data source used to generate the score.. Valid values are `encounter|claims|pharmacy|utilization`',
    `risk_score_status` STRING COMMENT 'Current processing status of the risk score.. Valid values are `pending_review|finalized`',
    `risk_score_type` STRING COMMENT 'Indicates whether the score is projected (prospective), derived from current data (concurrent), or the final CMS‑published value.. Valid values are `prospective|concurrent|final`',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric RAF score calculated for the member (e.g., 1.2345).',
    `score_components` STRING COMMENT 'Delimited list or JSON string of component scores (e.g., HCC contributions, demographic adjustments).',
    `score_effective_date` DATE COMMENT 'Date on which the risk score becomes effective for payment calculations.',
    `score_methodology_code` STRING COMMENT '',
    `score_variance` DECIMAL(18,2) COMMENT 'Numeric difference between the plan‑calculated score and the CMS‑published score.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk score record.',
    `variance_category` STRING COMMENT 'Root‑cause classification for any variance between plan and CMS scores.. Valid values are `missing_diagnoses|hierarchy_diff|demographic|other`',
    CONSTRAINT pk_member_risk_score PRIMARY KEY(`member_risk_score_id`)
) COMMENT 'Authoritative member-level risk score record and reconciliation tracker. Captures RAF (Risk Adjustment Factor) scores, HCC (Hierarchical Condition Category) mappings, CMS reconciliation outcomes, and plan-vs-CMS variance analysis. Stores prospective and concurrent RAF scores derived from actuarial models and encounter data, including score effective dates, payment year, model version (CMS-HCC, RxHCC, HHS-HCC, PACE), score components, CMS submission status, plan-calculated vs. CMS-published RAF variance, root cause category (missing diagnoses, HCC hierarchy differences, demographic factors), corrective actions, and resubmission references. Core SSOT for member-level risk in Medicare Advantage, ACA, and Medicaid risk adjustment programs. Subsumes RAF reconciliation tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` (
    `hcc_mapping_id` BIGINT COMMENT 'Primary key for hcc_mapping',
    `member_risk_score_id` BIGINT COMMENT 'add column member_risk_score_id (BIGINT) with FK to risk.member_risk_score.member_risk_score_id - HCC mappings feed RAF scores',
    `age_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member age.',
    `coefficient` DECIMAL(18,2) COMMENT 'Weighting coefficient used in RAF score calculations for the HCC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mapping record was first loaded into the lakehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `demographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor adjusting the HCC weight for demographic characteristics (age, gender, etc.).',
    `disease_interaction_group` STRING COMMENT 'Identifier for a group of diagnoses that have interaction effects.',
    `effective_date` DATE COMMENT 'Date when this mapping becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when this mapping expires or is superseded; null if still active.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member gender.',
    `hcc_code` STRING COMMENT 'CMS-assigned HCC identifier linked to the diagnosis.',
    `hcc_description` STRING COMMENT 'Human‑readable description of the HCC.',
    `hcc_mapping_status` STRING COMMENT 'Current lifecycle status of the mapping record.. Valid values are `active|inactive|retired`',
    `hierarchy_level` STRING COMMENT 'Depth of the HCC within the hierarchical structure (0 = top level).',
    `icd10_code` STRING COMMENT 'Standard ICD-10 diagnosis code associated with the mapping.. Valid values are `^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$`',
    `icd10_description` STRING COMMENT 'Full textual description of the ICD-10 diagnosis.',
    `interaction_flag` STRING COMMENT 'Indicates whether the diagnosis interacts with other HCCs (yes) or not (no).. Valid values are `yes|no`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_excluded` BOOLEAN COMMENT 'Indicates whether the diagnosis is excluded from the current model year.',
    `is_mapped` BOOLEAN COMMENT 'True if the ICD‑10 code has a valid HCC mapping in this version.',
    `last_review_date` DATE COMMENT 'Date when the mapping was last reviewed for accuracy.',
    `last_updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the mapping record.',
    `mapping_source` STRING COMMENT 'Origin of the mapping data.. Valid values are `CMS|Milliman|Custom`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `model_year` STRING COMMENT 'Calendar year of the CMS HCC model version to which the mapping applies.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes regarding the mapping.',
    `parent_hcc_code` STRING COMMENT 'Code of the immediate parent HCC in the hierarchy, if applicable.',
    `plan_type_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor for the HCC based on the members health plan type (e.g., HMO, PPO).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `region_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor reflecting geographic cost variations.',
    `review_status` STRING COMMENT 'Current status of the most recent review process.. Valid values are `pending|approved|rejected`',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight applied to the HCC when aggregating RAF scores.',
    `source_version` STRING COMMENT 'Version identifier of the source CMS model (e.g., V24, V28).',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_hcc_mapping PRIMARY KEY(`hcc_mapping_id`)
) COMMENT 'Maps ICD-10 diagnosis codes to Hierarchical Condition Categories (HCCs) per CMS model version. Stores the ICD-to-HCC crosswalk, HCC hierarchy relationships (parent/child HCC hierarchies), coefficient values by model year, disease interaction flags, and demographic adjustment factors. Supports RAF score calculation, RAPS/EDPS submission validation, and RADV audit defense. Reference entity managed per CMS annual model updates (V24, V28 transition). Source: CMS annual HCC model release files.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` (
    `raps_submission_id` BIGINT COMMENT 'System-generated unique identifier for each RAPS submission batch record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan (contract) associated with the RAPS submission.',
    `score_run_id` BIGINT COMMENT 'Foreign key linking to risk.score_run. Business justification: RAPS submissions to CMS are generated from a specific score run — the risk scores and RAF values in the submission are produced by a particular score_run execution (model version, run date, population',
    `accepted_record_count` STRING COMMENT 'Number of records that CMS accepted without error in this submission.',
    `batch_number` STRING COMMENT 'External batch identifier assigned by the source system for the RAPS submission.',
    `cms_acknowledgment_status` STRING COMMENT 'Acknowledgment status returned by CMS for the submitted batch.. Valid values are `received|processed|accepted|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `error_disposition` STRING COMMENT 'Textual description of any errors or rejections returned by CMS for this batch.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_year` STRING COMMENT 'Calendar year for which the risk adjustment payment is being calculated.',
    `plan_contract_number` STRING COMMENT 'Contract number of the plan submitted to CMS for risk adjustment.',
    `plan_type` STRING COMMENT 'Type of health plan associated with the submission (e.g., HMO, PPO).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `raps_submission_status` STRING COMMENT 'Current processing status of the RAPS submission within the CMS workflow.. Valid values are `pending|submitted|acknowledged|rejected|error`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rejected_record_count` STRING COMMENT 'Number of records that CMS rejected or flagged with errors in this submission.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Aggregated HCC-derived factor used to compute the plans risk adjustment payment.',
    `risk_adjustment_year` STRING COMMENT 'Year for which the risk adjustment factors are being reported.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk Adjustment Factor (RAF) score calculated for the plan in this submission.',
    `submission_file_checksum` STRING COMMENT 'SHA-256 checksum of the transmitted file to ensure data integrity.',
    `submission_file_name` STRING COMMENT 'Name of the flat file or payload transmitted to CMS for this batch.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the RAPS batch was transmitted to the CMS gateway.',
    `submission_user_name` STRING COMMENT 'Display name of the user who submitted the batch.',
    `total_record_count` STRING COMMENT 'Total number of individual member risk adjustment records included in the batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    CONSTRAINT pk_raps_submission PRIMARY KEY(`raps_submission_id`)
) COMMENT 'Tracks Risk Adjustment Processing System (RAPS) submissions to CMS for Medicare Advantage risk adjustment. Captures submission batch ID, submission date, plan contract number, payment year, record counts, accepted/rejected record counts, CMS acknowledgment status, and error disposition. Each record represents a RAPS batch transaction submitted via the CMS RAPS gateway. Source: Milliman MG-ALFA and EDI gateway.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`score_run` (
    `score_run_id` BIGINT COMMENT 'Primary key for score_run',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Score runs are executed against a specific plan population for CMS model year alignment and actuarial sign-off. Risk analytics teams must filter score runs by health_plan to produce plan-level RAF sum',
    `actuarial_signoff_date` DATE COMMENT 'Date the actuarial sign‑off was recorded.',
    `average_raf_score` DECIMAL(18,2) COMMENT 'Mean RAF score across the member population for the run.',
    `cms_model_year` STRING COMMENT 'Calendar year of the CMS model specification applied in the run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the run record was first created in the data lake.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall data quality for the run.. Valid values are `good|questionable|bad`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_snapshot_date` DATE COMMENT 'Date of the data extract snapshot used for scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `input_data_period_end` DATE COMMENT 'Last day of the data period used as input for the model.',
    `input_data_period_start` DATE COMMENT 'First day of the data period used as input for the model.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_population_count` BIGINT COMMENT 'Number of members included in the scoring run.',
    `model_name` STRING COMMENT 'Descriptive name of the actuarial risk model (e.g., CMS-HCC Model).',
    `model_status` STRING COMMENT 'Current lifecycle status of the risk model used in the run.. Valid values are `active|inactive|retired`',
    `model_version` STRING COMMENT 'Version string of the risk model used for the run.',
    `normalization_factor` DECIMAL(18,2) COMMENT 'Factor applied to adjust raw scores to a common scale.',
    `population_segment` STRING COMMENT 'Member segment targeted by the run.. Valid values are `Medicare|Medicaid|Commercial|DualEligible`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_model_type` STRING COMMENT 'Category of the risk model applied.. Valid values are `CMS-HCC|RxHCC|HHS-HCC|CDPS`',
    `run_code` STRING COMMENT 'Business identifier code for the run, often used in reporting and audit logs.',
    `run_date` DATE COMMENT 'Date on which the run was initiated.',
    `run_description` STRING COMMENT 'Free‑form description or notes about the run.',
    `run_status` STRING COMMENT 'Current lifecycle status of the run.. Valid values are `pending|running|completed|failed|cancelled`',
    `run_type` STRING COMMENT 'Indicates whether the run is a production, test, or reconciliation execution.. Valid values are `production|test|reconciliation`',
    `score_distribution_summary` STRING COMMENT 'JSON-formatted summary of score buckets and frequencies.',
    `total_raf_score` DECIMAL(18,2) COMMENT 'Sum of all Risk Adjustment Factor (RAF) scores calculated in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the run record.',
    CONSTRAINT pk_score_run PRIMARY KEY(`score_run_id`)
) COMMENT 'Represents a risk score model configuration and its production/test execution runs against the member population. Captures model name, model version, CMS model year, risk model type (CMS-HCC, RxHCC, HHS-HCC, CDPS), population segment (Medicare, Medicaid, Commercial), normalization factor, model status, run type (production/test/reconciliation), run date, input data period, data snapshot date, member population count, total and average RAF scores, score distribution summary, run status, and actuarial sign-off. Manages the actuarial model catalog and provides the complete audit trail from model configuration through execution for each risk score production cycle. Source: Milliman MG-ALFA.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` (
    `radv_audit_id` BIGINT COMMENT 'Unique surrogate key for each RADV audit record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.case. Business justification: CMS RADV audits with adverse findings trigger formal appeal cases under the RADV Appeals Process. Risk adjustment teams must link each RADV audit to its associated appeal case to track dispute status,',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: RADV audits validate HCC coding accuracy by reviewing specific sampled claims. Auditors must pull the exact claim record to verify diagnosis documentation supports the HCC. This link is operationally ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: RADV audits are conducted by CMS at the plan/contract level. Linking radv_audit to health_plan enables plan-level audit tracking, financial settlement reconciliation, and regulatory compliance reporti',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: RADV audits are performed to validate the accuracy of member-level risk scores submitted to CMS for Medicare Advantage. Each audit record directly validates a specific member_risk_score record — the a',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose records were sampled for the audit.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: RADV audits require medical record retrieval from the facility where the audited encounter occurred. The medical_record_request_status field confirms record retrieval workflows exist. Linking to the r',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: CMS RADV audits require medical record retrieval from the rendering provider who submitted the HCC-supporting diagnosis. RADV audit teams must identify and contact the specific provider for record req',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed against CMS audit findings.. Valid values are `none|filed|under_review|resolved|rejected`',
    `audit_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit reached final settlement.',
    `audit_error_description` STRING COMMENT 'Text description of the error condition when audit_error_flag is true.',
    `audit_error_flag` BOOLEAN COMMENT 'Indicates whether any processing error was detected for this audit record.',
    `audit_notes` STRING COMMENT 'Free‑form notes captured by auditors during the audit process.',
    `audit_source` STRING COMMENT 'Origin of the audit request – either CMS‑initiated or internally initiated.. Valid values are `CMS|internal`',
    `audit_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit process was initiated.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the RADV audit.. Valid values are `open|in_progress|closed|appealed|settled`',
    `audit_type` STRING COMMENT 'Indicates whether this is an initial RADV audit or a follow‑up audit.. Valid values are `initial|follow_up`',
    `audit_updated_by` STRING COMMENT 'User identifier of the analyst who last updated the audit record.',
    `audit_year` STRING COMMENT 'Calendar year in which the RADV audit was performed.',
    `cms_findings` STRING COMMENT 'Summary of findings and observations reported by CMS for this audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `extrapolated_payment_error` DECIMAL(18,2) COMMENT 'Estimated monetary error in payments derived from audit findings, before final settlement.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount finally paid or recovered after audit resolution.',
    `hcc_mapping_version` STRING COMMENT 'Version of the HCC mapping algorithm used for validation.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_record_receipt_date` DATE COMMENT 'Date on which the requested medical records were received.',
    `medical_record_request_status` STRING COMMENT 'Current status of the request for medical records from providers.. Valid values are `pending|requested|received|rejected`',
    `record_created` TIMESTAMP COMMENT 'Timestamp when this audit record was first captured in the data warehouse.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this audit record.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'RAF score applied to the member cohort for this audit.',
    `sampled_member_count` STRING COMMENT 'Number of members selected for review in this audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `validated_hcc_count` STRING COMMENT 'Number of Hierarchical Condition Categories confirmed as accurate after audit.',
    CONSTRAINT pk_radv_audit PRIMARY KEY(`radv_audit_id`)
) COMMENT 'Manages CMS Risk Adjustment Data Validation (RADV) audit records for Medicare Advantage contracts. Captures audit year, contract number, sampled member list, medical record request status, medical record receipt date, CMS audit findings, validated HCC count, extrapolated payment error, appeal status, and final settlement amount. Tracks the full RADV audit lifecycle from CMS notification through final payment reconciliation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_score_run_id` FOREIGN KEY (`score_run_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`score_run`(`score_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ADD CONSTRAINT `fk_risk_hcc_mapping_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_score_run_id` FOREIGN KEY (`score_run_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`score_run`(`score_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('dbx_business_glossary_term' = 'CMS Published RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Score Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `hcc_codes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Codes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('dbx_business_glossary_term' = 'Plan Calculated RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Confidence Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_label` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Label');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'encounter|claims|pharmacy|utilization');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_value_regex' = 'pending_review|finalized');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type (Prospective/Concurrent/Final)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_value_regex' = 'prospective|concurrent|final');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score Value');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_components` SET TAGS ('dbx_business_glossary_term' = 'Score Components Detail');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_variance` SET TAGS ('dbx_business_glossary_term' = 'Score Variance (Plan vs CMS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'missing_diagnoses|hierarchy_diff|demographic|other');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Adjustment Factor (AGE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('dbx_business_glossary_term' = 'HCC Coefficient (COEF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Demographic Adjustment Factor (DEMOG_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Group (DI_GROUP)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Adjustment Factor (GENDER_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Code (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Description (HCC_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HIER_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Code (ICD10)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Description (ICD10_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Flag (INTERACT_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded Flag (EXCLUDED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('dbx_business_glossary_term' = 'Is Mapped Flag (MAPPED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (UPDATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source (MAP_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_value_regex' = 'CMS|Milliman|Custom');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MODEL_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Parent HCC Code (PARENT_HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Adjustment Factor (PLAN_TYPE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Region Adjustment Factor (REGION_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (REVIEW_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight (RS_WEIGHT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version (SRC_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_subdomain' = 'adjustment_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `score_run_id` SET TAGS ('dbx_business_glossary_term' = 'Score Run Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'received|processed|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|acknowledged|rejected|error');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_year` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission File Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_business_glossary_term' = 'Submission User Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `total_record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_run_id` SET TAGS ('dbx_business_glossary_term' = 'Score Run Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Sign‑off Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `average_raf_score` SET TAGS ('dbx_business_glossary_term' = 'Average RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `cms_model_year` SET TAGS ('dbx_business_glossary_term' = 'CMS Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Data Snapshot Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_end` SET TAGS ('dbx_business_glossary_term' = 'Input Data Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_start` SET TAGS ('dbx_business_glossary_term' = 'Input Data Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `member_population_count` SET TAGS ('dbx_business_glossary_term' = 'Member Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `normalization_factor` SET TAGS ('dbx_business_glossary_term' = 'Normalization Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `population_segment` SET TAGS ('dbx_value_regex' = 'Medicare|Medicaid|Commercial|DualEligible');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Type (CMS-HCC, RxHCC, HHS-HCC, CDPS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_value_regex' = 'CMS-HCC|RxHCC|HHS-HCC|CDPS');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_description` SET TAGS ('dbx_business_glossary_term' = 'Run Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'production|test|reconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_distribution_summary` SET TAGS ('dbx_business_glossary_term' = 'Score Distribution Summary');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `total_raf_score` SET TAGS ('dbx_business_glossary_term' = 'Total RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_subdomain' = 'adjustment_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `radv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'RADV Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'none|filed|under_review|resolved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('dbx_value_regex' = 'CMS|internal');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|appealed|settled');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|follow_up');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Year (YR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `cms_findings` SET TAGS ('dbx_business_glossary_term' = 'CMS Findings');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `extrapolated_payment_error` SET TAGS ('dbx_business_glossary_term' = 'Extrapolated Payment Error (EPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount (FSA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `hcc_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_value_regex' = 'pending|requested|received|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `sampled_member_count` SET TAGS ('dbx_business_glossary_term' = 'Sampled Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `validated_hcc_count` SET TAGS ('dbx_business_glossary_term' = 'Validated HCC Count');
